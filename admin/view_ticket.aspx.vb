Imports System.Data.SqlClient
Imports System.Data
Imports System.Net.Mail

Partial Class view_ticket
    Inherits System.Web.UI.Page

    Protected Sub btnClose_OnClick()
        ' close the support ticket
        updateSupportTicket(True)

        ' send an email notification to the user
        sendNotification("SupportClosed.html", "")
    End Sub

    Protected Sub btnOpen_OnClick()
        ' re-open the support ticket
        updateSupportTicket(False)

        ' send email notification to the user
        sendNotification("SupportOpened.html", "")
    End Sub

    Protected Sub updateSupportTicket(ByVal isLocked As Boolean)
        ' toggle opened/closed of this support ticket
        Dim dbCon As New SqlConnection(ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString)

        Dim cmd As New SqlCommand("updateSupportRequest", dbCon)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@id", Request.QueryString("id"))
        cmd.Parameters.AddWithValue("@isLocked", isLocked)
        dbCon.Open()
        cmd.ExecuteNonQuery()
        dbCon.Close()

        fvViewTicket.DataBind()
    End Sub

    Protected Sub btnAddReply_Click(sender As Object, e As System.EventArgs) Handles btnAddReply.Click
        ' add new reply to this ticket
        Dim dbCon As New SqlConnection(ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString)

        Dim cmd As New SqlCommand("insertSupportReply", dbCon)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@ticketId", Request.QueryString("id"))
        cmd.Parameters.AddWithValue("@userId", Session("UserId"))
        cmd.Parameters.AddWithValue("@repContent", rtbReplyContent.Text)
        dbCon.Open()
        cmd.ExecuteNonQuery()
        dbCon.Close()

        ' send email notification to the user
        sendNotification("SupportReply.html", rtbReplyContent.Text)

        ' reset/reload
        rtbReplyContent.Text = ""
        rReplies.DataBind()
    End Sub

    Protected Sub sendNotification(ByVal email_template As String, ByVal bodytext As String)
        Dim toEmail As Literal = fvViewTicket.FindControl("litEmail")
        Dim firstName As Literal = fvViewTicket.FindControl("litFirstName")
        Dim ticketId As String = Request.QueryString("id")

        Dim md As MailDefinition = New MailDefinition
        md.BodyFileName = "~/email_templates/" + email_template
        md.From = "support@buildmateapp.com"
        md.Subject = "[Buildmate] Support Ticket: " + Request.QueryString("id")
        md.Priority = MailPriority.Normal
        md.IsBodyHtml = True

        ' append additional information to the email template
        Dim replacements As ListDictionary = New ListDictionary
        replacements.Add("<% firstName %>", firstName.Text)
        replacements.Add("<% id %>", ticketId)
        If bodytext.Length > 0 Then replacements.Add("<% bodytext %>", bodytext)

        Dim fileMsg As System.Net.Mail.MailMessage
        fileMsg = md.CreateMailMessage(toEmail.Text, replacements, Me)
        Dim msg As System.Net.Mail.MailMessage = fileMsg

        Dim obj As System.Net.Mail.SmtpClient = New System.Net.Mail.SmtpClient
        obj.Send(msg)
    End Sub
End Class
