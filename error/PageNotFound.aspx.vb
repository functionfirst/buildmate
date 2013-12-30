
Partial Class error_PageNotFound
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        Dim obj As System.Net.Mail.SmtpClient = New System.Net.Mail.SmtpClient
        Dim Mailmsg As New System.Net.Mail.MailMessage
        Mailmsg.To.Clear()
        Mailmsg.To.Add(New System.Net.Mail.MailAddress("Buildmate<support@buildmateapp.com>"))
        Mailmsg.From = New System.Net.Mail.MailAddress("support@buildmateapp.com")
        Mailmsg.Subject = "[Buildmate] -  404 Error"
        Mailmsg.IsBodyHtml = True
        Mailmsg.Body = "Someone found a 404, here's the url: <a href='" + Request.Url.AbsoluteUri + "'>" + Request.Url.AbsoluteUri + "</a>"
        obj.Send(Mailmsg)
    End Sub
End Class
