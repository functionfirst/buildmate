Imports Telerik.Web.UI

Partial Class manager_supplier_details
    Inherits System.Web.UI.Page

    Protected Sub defaultCountry(ByVal sender As Object, ByVal e As System.EventArgs)
        ' default country to UK
        Dim rcbCountry As RadComboBox = CType(sender, RadComboBox)
        rcbCountry.SelectedValue = 183
    End Sub

    Protected Sub Validate_OnClick()
        Page.Validate("editGroup")
    End Sub

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        Dim activeLink As HyperLink = CType(Master.FindControl("hlSuppliers"), HyperLink)
        activeLink.CssClass = "active"
    End Sub
End Class
