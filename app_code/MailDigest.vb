Imports Microsoft.VisualBasic

Namespace Buildmate
    Public Class MailDigest
        ' Send email notification to customer confirming their ticket was reopened
        Public Sub digest(ByVal email As String, ByVal firstname As String, ByVal htmlbody As String, ByVal plainbody As String, ByVal token As String)
            Dim mail As New Buildmate.Mailgun
            mail.toAdd = email
            mail.subject = "[Buildmate] Daily Digest"
            mail.template = "DailyDigest"
            mail.replacements.Add("{FIRSTNAME}", firstname)
            mail.replacements.Add("{TOKEN}", token)
            mail.replacements.Add("{BODYTEXT}", htmlbody)
            mail.replacements.Add("{PLAINBODY}", plainbody)
            mail.send()
        End Sub

        ' Send email notification to customer confirming their ticket was reopened
        Public Sub introduction(ByVal email As String, ByVal firstname As String)
            Dim mail As New Buildmate.Mailgun
            mail.toAdd = email
            mail.subject = "[Buildmate] Introduction"
            mail.template = "Followup"
            mail.replacements.Add("{FIRSTNAME}", firstname)
            mail.send()
        End Sub
    End Class
End Namespace
