Imports Microsoft.VisualBasic

Namespace Buildmate
    Public Class MailSupport
        ' Send email notification to customer confirming their ticket was closed
        Public Sub supportClosed(ByVal id As Integer, ByVal firstname As String, ByVal email As String)
            Dim mail As New Buildmate.Mailgun
            mail.toAdd = email
            mail.subject = String.Format("[Buildmate] Ticket ID: {0}. Ticket Closed", id)
            mail.template = "SupportClosed"

            mail.replacements.Add("{ID}", id)
            mail.replacements.Add("{FIRSTNAME}", firstname)
            mail.send()
        End Sub

        ' Send email notification to customer confirming their ticket was reopened
        Public Sub supportReopened(ByVal id As Integer, ByVal firstname As String, ByVal email As String)
            Dim mail As New Buildmate.Mailgun
            mail.toAdd = email
            mail.subject = String.Format("[Buildmate] Ticket ID: {0}. Ticket Re-opened", id)
            mail.template = "SupportReopened"

            mail.replacements.Add("{ID}", id)
            mail.replacements.Add("{FIRSTNAME}", firstname)
            mail.send()
        End Sub


        ' Send email notification to customer confirming they opened a new issue
        Public Sub newIssue(ByVal id As Integer, ByVal subject As String, ByVal content As String)
            Dim mail As New Buildmate.Mailgun
            mail.toAdd = "Buildmate<support@buildmateapp.com>"
            mail.subject = String.Format("[Buildmate] Ticket ID: {0}. {1}", id, subject)
            mail.template = "SupportNew"
            mail.replacements.Add("{ID}", id)
            mail.replacements.Add("{SUBJECT}", subject)
            mail.replacements.Add("{CONTENT}", content)
            mail.send()
        End Sub

        ' Send email notification to customer confirming they opened a new issue
        Public Sub confirmIssue(ByVal id As Integer, ByVal subject As String, ByVal content As String, ByVal email As String)
            Dim mail As New Buildmate.Mailgun
            mail.toAdd = email
            mail.subject = String.Format("[Buildmate] Ticket ID: {0}. {1}", id, subject)
            mail.template = "SupportConfirm"
            mail.replacements.Add("{ID}", id)
            mail.replacements.Add("{SUBJECT}", subject)
            mail.replacements.Add("{CONTENT}", content)
            mail.send()

            ' send notification to Support account
            newIssue(id, subject, content)
        End Sub

        ' Email support account informing them of a new Reply from a customer
        Public Sub customerReply(ByVal id As Integer, ByVal content As String)
            Dim mail As New Buildmate.Mailgun
            mail.toAdd = "Buildmate<support@buildmateapp.com>"
            mail.subject = String.Format("[Buildmate] Ticket ID: {0}. Customer Reply", id)
            mail.template = "SupportCustomerReply"

            mail.replacements.Add("{ID}", id)
            mail.replacements.Add("{CONTENT}", content)
            mail.send()
        End Sub


        ' Email customer informing them of a new Reply from Support
        Public Sub supportReply(ByVal id As Integer, ByVal firstname As String, ByVal content As String, ByVal email As String)
            Dim mail As New Buildmate.Mailgun
            mail.toAdd = email
            mail.subject = String.Format("[Buildmate] Ticket ID: {0}. Support Reply", id)
            mail.template = "SupportReply"

            mail.replacements.Add("{ID}", id)
            mail.replacements.Add("{FIRSTNAME}", firstname)
            mail.replacements.Add("{CONTENT}", content)
            mail.send()
        End Sub

    End Class
End Namespace