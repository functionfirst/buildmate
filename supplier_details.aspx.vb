Imports Telerik.Web.UI

Partial Class manager_supplier_details
    Inherits MyBaseClass

    Protected Sub Validate_OnClick()
        Page.Validate("editGroup")
    End Sub

    Protected Sub Page_Init(sender As Object, e As EventArgs) Handles Me.Init
        checkPermissions("Supplier")
    End Sub

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        Dim activeLink As HyperLink = CType(Master.FindControl("hlSuppliers"), HyperLink)
        activeLink.CssClass = "active"
    End Sub

    Protected Sub fvSupplierDetails_ItemUpdated(sender As Object, e As FormViewUpdatedEventArgs) Handles fvSupplierDetails.ItemUpdated
        showNotification("Supplier Updated", "Your changes were saved successfully")

        moveTourPhase()
    End Sub

    Protected Sub moveTourPhase()
        If Session("tourPhase") = 6 Then
            Response.Redirect(HttpContext.Current.Request.Url.AbsoluteUri)
        End If
    End Sub
End Class
