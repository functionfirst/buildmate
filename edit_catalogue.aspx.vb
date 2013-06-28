Partial Class edit_catalogue
    Inherits System.Web.UI.Page

    Protected Sub Page_Init(sender As Object, e As System.EventArgs) Handles Me.Init
        hlResource.NavigateUrl = String.Format("resource_details.aspx?rid={0}", Request.QueryString("rid"))
    End Sub

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        Dim activeLink As HyperLink = CType(Master.FindControl("hlResources"), HyperLink)
        activeLink.CssClass = "active"
    End Sub
End Class
