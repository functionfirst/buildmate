Imports System.Data
Imports System.Data.SqlClient

Partial Class manager_support
    Inherits MyBaseClass

    Dim mailSupport As New Buildmate.MailSupport

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

        ' Send email notification to customer
        mailSupport.confirmIssue(newID, rtbSubject.Text, rtbContent.Text, Session("email"))

        Response.Redirect(String.Format("view/?id={0}", newID))
    End Sub
End Class

