Partial Class resource_details
    Inherits MyBaseClass

    Protected Sub fvResourceInsert_ItemInserted(sender As Object, e As System.Web.UI.WebControls.FormViewInsertedEventArgs) Handles fvResourceInsert.ItemInserted
        rgCatalogue.DataBind()
        fvResourceInsert.DataBind()

        showNotification("Resource Supplier Added", "Your suppler was added successfully")

        moveTourPhase()
    End Sub

    Protected Sub moveTourPhase()
        If Session("tourPhase") = 8 Then
            Response.Redirect(HttpContext.Current.Request.Url.AbsoluteUri)
        End If
    End Sub

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        Dim activeLink As HyperLink = CType(Master.FindControl("hlResources"), HyperLink)
        activeLink.CssClass = "active"
    End Sub
End Class
