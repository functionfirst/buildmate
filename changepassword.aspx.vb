Imports Telerik.Web.UI
Imports System.IO

Partial Class manager_account
    Inherits System.Web.UI.Page

    Protected Sub Validate_Change()
        Page.Validate("ChangePassword1")
    End Sub

    'Protected Sub ChangePassword1_ChangedPassword(ByVal sender As Object, ByVal e As System.EventArgs) Handles ChangePassword1.ChangedPassword
    '    Dim user As MembershipUser = Membership.GetUser

    '    If Not user Is Nothing Then
    '        ' send email to user
    '        Try
    '            Dim userid As Guid = user.ProviderUserKey
    '            Dim username As String = user.UserName
    '            Dim mailTo As String = user.Email.ToString
    '            Dim body As String = "Dear " & username & ", " & "<br />Your New Password: <br />" & ChangePassword1.NewPassword.ToString
    '            Dim subject As String = "Password Changed Successfully via Buildmate"
    '            Dim email As String = "support@buildmateapp.com"

    '            ' send mail
    '            Dim obj As System.Net.Mail.SmtpClient = New System.Net.Mail.SmtpClient
    '            Dim Mailmsg As New System.Net.Mail.MailMessage
    '            Mailmsg.To.Clear()

    '            Mailmsg.To.Add(New System.Net.Mail.MailAddress(username & "<" & mailTo & ">"))
    '            Mailmsg.From = New System.Net.Mail.MailAddress("Buildmate<support@buildmateapp.com>")
    '            Mailmsg.Subject = subject
    '            Mailmsg.Body = body
    '            obj.Send(Mailmsg)

    '        Catch ex As Exception
    '            Trace.Write(ex.Message.ToString)
    '        End Try
    '    End If

    'End Sub
End Class
