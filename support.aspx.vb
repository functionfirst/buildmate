﻿Imports System.Data
Imports System.Data.SqlClient

Partial Class manager_Default
    Inherits MyBaseClass

    Protected Sub rbTickets_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles rbTickets.SelectedIndexChanged
        setTicketFilter()
    End Sub

    Protected Sub setTicketFilter()
        Select Case rbTickets.SelectedIndex
            Case 0
                ticketsDataSource.FilterExpression = "isLocked <> 1"
            Case 1
                ticketsDataSource.FilterExpression = "isLocked = 1"
            Case 2
                ticketsDataSource.FilterExpression = ""
        End Select
    End Sub

    Protected Sub btnSend_Click(sender As Object, e As System.EventArgs) Handles btnSend.Click
        ' create and execute sql command
        Dim dbCon As New SqlConnection(ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString)

        Dim cmd As New SqlCommand("insertSupportTicket", dbCon)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@userId", Session("userId"))
        cmd.Parameters.AddWithValue("@subject", rtbSubject.Text)
        cmd.Parameters.AddWithValue("@content", rtbContent.Text)
        dbCon.Open()
        Dim newID = cmd.ExecuteScalar()
        dbCon.Close()

        ' send email notification to customer
        Try
            Dim obj As System.Net.Mail.SmtpClient = New System.Net.Mail.SmtpClient
            Dim Mailmsg As New System.Net.Mail.MailMessage
            Mailmsg.To.Clear()
            Mailmsg.To.Add(New System.Net.Mail.MailAddress(Session("email")))
            'Mailmsg.Bcc.Add(New System.Net.Mail.MailAddress("support@buildmateapp.com"))
            Mailmsg.From = New System.Net.Mail.MailAddress("support@buildmateapp.com")
            Mailmsg.Subject = String.Format("[Buildmate - Ticket ID: {0} - {1}]", newID, rtbSubject.Text)
            Mailmsg.IsBodyHtml = True
            Mailmsg.Body = String.Format("<h1>Your ticket has been created</h1><h3>{0}</h3><p>{1}</p><p><a href=""http://buildmateapp.com/view_ticket.aspx?id={2}"">http://buildmateapp.com/view_ticket.aspx?id={2}</a></p><p>Thank you for your email, our support team have received your request for assistance. You should receive a reply shortly.</p>", rtbSubject.Text, rtbContent.Text, newID)
            obj.Send(Mailmsg)

            Response.Redirect(String.Format("view_ticket.aspx?id={0}", newID))
        Catch ex As Exception
            Trace.Write(ex.ToString)
        End Try
    End Sub
End Class
