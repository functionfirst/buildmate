Imports Microsoft.VisualBasic

Namespace Buildmate
    Public Class MailRegister
        ' Send email notification to customer confirming their ticket was reopened
        Public Sub welcome(ByVal email As String)
            Dim mail As New Buildmate.Mailgun
            mail.toAdd = email
            mail.subject = "[Buildmate] Welcome to Buildmate"
            mail.template = "Welcome"
            mail.send()

            newAccount(email)
        End Sub

        ' Send email notification to customer confirming their ticket was reopened
        Public Sub newAccount(ByVal email As String)
            Dim mail As New Buildmate.Mailgun
            mail.toAdd = "Buildmate<support@buildmateapp.com>"
            mail.subject = "[Buildmate] New User Sign-up"
            mail.template = "NewAccount"
            mail.replacements.Add("{USERNAME}", email)
            mail.send()
        End Sub
    End Class
End Namespace
