Partial Class register
    Inherits System.Web.UI.Page

    Dim mailRegister As New Buildmate.MailRegister

    Protected Sub CreateUserWizard1_CreatingUser(sender As Object, e As LoginCancelEventArgs) Handles CreateUserWizard1.CreatingUser
        Dim cuw As CreateUserWizard = sender
        cuw.Email = cuw.UserName
    End Sub

    Protected Sub CreateUserWizard1_CreatedUser(sender As Object, e As EventArgs) Handles CreateUserWizard1.CreatedUser
        ' send confirmation email to new user with welcome instructions
        Dim email As String = CreateUserWizard1.UserName
        mailRegister.welcome(email)
    End Sub

    Protected Sub CreateUserWizard1_SendMailError(sender As Object, e As SendMailErrorEventArgs) Handles CreateUserWizard1.SendMailError
        System.Diagnostics.Trace.WriteLine(e.Exception.Message)
        e.Handled = True
    End Sub
End Class