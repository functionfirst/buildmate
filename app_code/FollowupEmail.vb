Imports Microsoft.VisualBasic
Imports System.Net.Mail
Imports System.Data.SqlClient
Imports System.Data
Imports System.Diagnostics

Public Class FollowupEmail

    Public Sub Send()
        CheckNewUsers()
    End Sub

    Protected Sub CheckNewUsers()
        Dim sqlSelectCommand As String = "SELECT aspnet_Membership.userid, firstname, aspnet_Membership.email" & _
            " FROM aspnet_Membership" & _
            " LEFT JOIN UserProfile ON aspnet_Membership.UserId = UserProfile.userid" & _
            " WHERE aspnet_Membership.Email Is Not null" & _
            " AND notifyByEmail=1" & _
            " AND NOT EXISTS(" & _
            " 	SELECT * FROM EmailNotification WHERE userid = aspnet_Membership.UserId AND EmailType='FOLLOWUP'" & _
            " )"
        Try
            Dim adapter As New SqlDataAdapter(sqlSelectCommand, System.Configuration.ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString)
            Dim dataTable As New DataTable()
            adapter.Fill(dataTable)

            For Each dr In dataTable.Rows
                Dim Userid As String = dr("UserId").ToString()
                Dim firstName As String = dr("firstname").ToString()
                Dim email As String = dr("email").ToString()

                ' email the daily digest for this user
                SendMessage(email, firstName, Userid)
            Next
        Catch ex As Exception
            Trace.Write(ex.ToString)
        End Try
    End Sub

    Protected Sub SendMessage(ByVal toAddr As String, ByVal firstName As String, ByVal userid As String)
        If toAddr.Length > 1 Then
            Dim msg As System.Net.Mail.MailMessage = CreateMessage(toAddr, firstName)

            Try
                Dim sc As SmtpClient
                sc = New SmtpClient()
                sc.Send(msg)

                FollowupSent(userid)
            Catch ex As Exception
                ' do nothing
            End Try
        End If
    End Sub

    Protected Function CreateMessage(ByVal toAddr As String, ByVal firstName As String) As System.Net.Mail.MailMessage
        Dim md As MailDefinition = New MailDefinition
        md.BodyFileName = "~/email_templates/Followup.html"
        md.From = "support@buildmateapp.com"
        md.Subject = "[Buildmate] - Introduction"
        md.Priority = MailPriority.Normal
        md.IsBodyHtml = True

        Dim replacements As ListDictionary = New ListDictionary
        replacements.Add("<% Firstname %>", firstName)
        Dim fileMsg As System.Net.Mail.MailMessage
        fileMsg = md.CreateMailMessage(toAddr, replacements, New System.Web.UI.Control)
        Return fileMsg
    End Function

    Protected Sub FollowupSent(ByVal userid As String)
        Try
            Dim connString As String = System.Configuration.ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString
            Dim myConn As New SqlConnection(connString)
            Dim myCmd As New SqlCommand("INSERT INTO EmailNotification(UserId, EmailType) VALUES(@userId, 'FOLLOWUP');", myConn)
            myCmd.Parameters.AddWithValue("@UserId", userid)

            myConn.Open()
            myCmd.ExecuteScalar()
            myConn.Close()

            myCmd.Dispose()
            myConn.Dispose()
        Catch Ex As Exception
            'Response.End()
        End Try
    End Sub
End Class
