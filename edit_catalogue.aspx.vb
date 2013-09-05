Partial Class edit_catalogue
    Inherits MyBaseClass

    Protected Sub Page_Init(sender As Object, e As System.EventArgs) Handles Me.Init
        hlResource.NavigateUrl = String.Format("resource_details.aspx?rid={0}", Request.QueryString("rid"))
    End Sub

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        Dim activeLink As HyperLink = CType(Master.FindControl("hlResources"), HyperLink)
        activeLink.CssClass = "active"
    End Sub

    Protected Sub fvCatalogueDetails_ItemUpdated(sender As Object, e As FormViewUpdatedEventArgs) Handles fvCatalogueDetails.ItemUpdated
        showNotification("Resource Supplier Updated", "Your changes were saved successfully")
    End Sub
End Class
