
Partial Class manager_adhoc
    Inherits MyBaseClass

    Protected Sub fvReply_ItemInserted(sender As Object, e As System.Web.UI.WebControls.FormViewInsertedEventArgs) Handles fvReply.ItemInserted
        ' send email notification to admin
        Dim obj As System.Net.Mail.SmtpClient = New System.Net.Mail.SmtpClient
        Dim Mailmsg As New System.Net.Mail.MailMessage
        Mailmsg.To.Clear()
        Mailmsg.To.Add(New System.Net.Mail.MailAddress("BuildMate<support@buildmateapp.com>"))
        Mailmsg.From = New System.Net.Mail.MailAddress("support@buildmateapp.com")
        Mailmsg.Subject = "Ticket ID: " + Request.QueryString("id") + " - Support Request- BuildMate"
        Mailmsg.IsBodyHtml = True
        Mailmsg.Body = String.Format("<p>The Support Ticket has been updated.</p><p><a href='http://buildmateapp.com/view_ticket.aspx?id={0}'>View this ticket</a></p>", Request.QueryString("id"))
        obj.Send(Mailmsg)

        fvReply.DataBind()
        rReplies.DataBind()

        showNotification("Note Added", "Your note was successfully added")
    End Sub

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        Dim activeLink As HyperLink = CType(Master.FindControl("hlSupport"), HyperLink)
        activeLink.CssClass = "active"
    End Sub
End Class
