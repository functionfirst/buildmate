Imports Telerik.Web.UI

Partial Class view_ticket
    Inherits MyBaseClass

    Dim mailSupport As New Buildmate.MailSupport

    Protected Sub fvReply_ItemInserted(sender As Object, e As System.Web.UI.WebControls.FormViewInsertedEventArgs) Handles fvReply.ItemInserted
        Dim rtbReplyContent As RadTextBox = fvReply.FindControl("rtbReplyContent")

        ' Send email notification to admin
        mailSupport.customerReply(Request.QueryString("id"), rtbReplyContent.Text)

        ' Clear/reload ticket data
        fvReply.DataBind()
        rReplies.DataBind()

        showNotification("Note Added", "Your note was successfully added")
    End Sub

    Protected Sub Page_Init(sender As Object, e As EventArgs) Handles Me.Init
        checkPermissions("SupportTickets")
    End Sub
End Class