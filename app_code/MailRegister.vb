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

        ' Send email to User with token allowing them to reset their password
        Public Sub resetPassword(ByVal email As String, ByVal token As String, ByVal domain As String)
            Dim mail As New Buildmate.Mailgun
            mail.toAdd = email
            mail.subject = "[Buildmate] Password Reset Instructions"
            mail.template = "ResetPassword"
            mail.replacements.Add("{EMAIL}", email)
            mail.replacements.Add("{TOKEN}", token)
            mail.replacements.Add("{DOMAIN}", domain)
            mail.send()
        End Sub

        ' Send email to User confirming their password was reset
        Public Sub resetConfirmation(ByVal email As String)
            Dim mail As New Buildmate.Mailgun
            mail.toAdd = email
            mail.subject = "[Buildmate] Password Reset Confirmation"
            mail.template = "ResetConfirmation"
            mail.send()
        End Sub
    End Class
End Namespace
