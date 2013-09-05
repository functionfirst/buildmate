Partial Class resource_details
    Inherits MyBaseClass

    Protected Sub fvResourceInsert_ItemInserted(sender As Object, e As System.Web.UI.WebControls.FormViewInsertedEventArgs) Handles fvResourceInsert.ItemInserted
        rgCatalogue.DataBind()
        fvResourceInsert.DataBind()

        showNotification("Resource Supplier Added", "Your suppler was added successfully")
    End Sub

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        Dim activeLink As HyperLink = CType(Master.FindControl("hlResources"), HyperLink)
        activeLink.CssClass = "active"
    End Sub
End Class
