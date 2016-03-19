
Partial Class login
    Inherits System.Web.UI.Page

    Protected Sub CreateUserWizard1_CreatingUser(sender As Object, e As LoginCancelEventArgs) Handles CreateUserWizard1.CreatingUser
        Dim cuw As CreateUserWizard = sender
        cuw.Email = cuw.UserName
    End Sub

    Protected Sub CreateUserWizard1_CreatedUser(sender As Object, e As EventArgs) Handles CreateUserWizard1.CreatedUser
        ' send confirmation email to new user with welcome instructions.
        sendWelcomeEmail()

        ' send email confirmation to admin informing them a new user was created
        sendNewAccountEmail()
    End Sub

    Protected Sub sendNewAccountEmail()
        Dim mail As New Buildmate.Mailgun
        mail.toAdd = "Buildmate <alan@functionfirst.co.uk>"
        mail.subject = "[Buildmate] New User Sign-up"
        mail.template = "NewAccount"
        mail.replacements.Add("{USERNAME}", CreateUserWizard1.UserName)
        mail.send()
    End Sub

    Protected Sub sendWelcomeEmail()
        Dim email As String = CreateUserWizard1.UserName

        Dim mail As New Buildmate.Mailgun
        mail.toAdd = email
        mail.subject = "[Buildmate] Welcome to Buildmate"
        mail.template = "Welcome"
        mail.send()
    End Sub

    Protected Sub CreateUserWizard1_SendMailError(sender As Object, e As SendMailErrorEventArgs) Handles CreateUserWizard1.SendMailError
        System.Diagnostics.Trace.WriteLine(e.Exception.Message)
        e.Handled = True
    End Sub
End Class