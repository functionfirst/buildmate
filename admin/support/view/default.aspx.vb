Imports System.Data.SqlClient
Imports System.Data
Imports System.Net.Mail

Partial Class view_ticket
    Inherits System.Web.UI.Page

    Dim mailSupport As New Buildmate.MailSupport

    Protected Sub btnClose_OnClick()
        ' close the support ticket
        toggleTicketStatus(True)

        ' Send an email notifying the User their ticket has been closed
        Dim id As Integer = Request.QueryString("id")
        Dim email As Literal = fvViewTicket.FindControl("litEmail")
        Dim firstname As Literal = fvViewTicket.FindControl("litFirstName")

        mailsupport.supportClosed(id, firstname.Text, email.Text)
    End Sub

    Protected Sub btnOpen_OnClick()
        ' re-open the support ticket
        toggleTicketStatus(False)

        ' Send an email notifying the User their ticket has been re-opened
        Dim id As Integer = Request.QueryString("id")
        Dim email As Literal = fvViewTicket.FindControl("litEmail")
        Dim firstname As Literal = fvViewTicket.FindControl("litFirstName")

        mailSupport.supportReopened(id, firstname.Text, email.Text)
    End Sub

    Protected Sub toggleTicketStatus(ByVal isLocked As Boolean)
        ' toggle opened/closed of this support ticket
        Dim dbCon As New SqlConnection(ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString)

        Dim cmd As New SqlCommand("updateSupportRequest", dbCon)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@id", Request.QueryString("id"))
        cmd.Parameters.AddWithValue("@isLocked", isLocked)
        dbCon.Open()
        cmd.ExecuteNonQuery()
        dbCon.Close()

        fvViewTicket.DataBind()
    End Sub

    Protected Sub btnAddReply_Click(sender As Object, e As System.EventArgs) Handles btnAddReply.Click
        ' add new reply to this ticket
        Dim dbCon As New SqlConnection(ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString)

        Dim cmd As New SqlCommand("insertSupportReply", dbCon)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@ticketId", Request.QueryString("id"))
        cmd.Parameters.AddWithValue("@userId", Session("UserId"))
        cmd.Parameters.AddWithValue("@repContent", rtbReplyContent.Text)
        dbCon.Open()
        cmd.ExecuteNonQuery()
        dbCon.Close()

        ' Send an email reply to the User
        Dim id As Integer = Request.QueryString("id")
        Dim email As Literal = fvViewTicket.FindControl("litEmail")
        Dim firstname As Literal = fvViewTicket.FindControl("litFirstName")

        mailSupport.supportReply(id, firstname.Text, rtbReplyContent.Text, email.Text)

        ' reset/reload
        rtbReplyContent.Text = ""
        rReplies.DataBind()
    End Sub
End Class
