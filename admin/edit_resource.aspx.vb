Partial Class edit_resource
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        hlAddCatalogue.NavigateUrl = String.Format("add_catalogue.aspx?rid={0}", Request.QueryString("rid"))
    End Sub
End Class
