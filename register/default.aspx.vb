Imports System.Data.SqlClient
Imports System.Net.Mail

Partial Class login
    Inherits System.Web.UI.Page

    Protected Sub CreateUserWizard1_CreatedUser(sender As Object, e As EventArgs) Handles CreateUserWizard1.CreatedUser
        Dim msg As System.Net.Mail.MailMessage = CreateMessage()

        Try
            Dim sc As SmtpClient
            sc = New SmtpClient()
            sc.Send(msg)
        Catch ex As Exception
            Trace.Write(ex.ToString())
        End Try
    End Sub

    Function CreateMessage() As System.Net.Mail.MailMessage
        Dim md As MailDefinition = New MailDefinition
        md.BodyFileName = "~/email_templates/NewAccount.html"
        md.From = "Buildmate<support@buildmateapp.com>"
        md.IsBodyHtml = True
        md.Subject = "[Buildmate] New User Sign-up"
        md.Priority = Net.Mail.MailPriority.Normal

        Dim replacements As ListDictionary = New ListDictionary
        replacements.Add("<%Username%>", CreateUserWizard1.UserName)

        Dim fileMsg As System.Net.Mail.MailMessage
        fileMsg = md.CreateMailMessage(CreateUserWizard1.UserName, replacements, Me)
        fileMsg.To.Clear()
        fileMsg.To.Add(New MailAddress("alan@buildmateapp.com"))
        fileMsg.To.Add(New MailAddress("steve@buildmateapp.com"))
        Return fileMsg
    End Function

    Protected Sub CreateUserWizard1_CreatingUser(sender As Object, e As LoginCancelEventArgs) Handles CreateUserWizard1.CreatingUser
        Dim cuw As CreateUserWizard = sender
        cuw.Email = cuw.UserName
    End Sub

    Protected Sub CreateUserWizard1_SendingMail(sender As Object, e As MailMessageEventArgs) Handles CreateUserWizard1.SendingMail
        ' Set MailMessage fields.
        e.Message.IsBodyHtml = True
        e.Message.Subject = "[Buildmate] Welcome to Buildmate"

        ' Replace placeholder text in message body with information 
        ' provided by the user.
        e.Message.Body = e.Message.Body.Replace("<% UserName %>", CreateUserWizard1.UserName)
        e.Message.Body = e.Message.Body.Replace("<% Password %>", CreateUserWizard1.Password)

    End Sub

    Protected Sub CreateUserWizard1_SendMailError(sender As Object, e As SendMailErrorEventArgs) Handles CreateUserWizard1.SendMailError
        Trace.Write("Error in email")
        System.Diagnostics.Trace.WriteLine(e.Exception.Message)
        e.Handled = True
    End Sub
End Class