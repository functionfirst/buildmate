Imports Telerik.Web.UI

Partial Class edit_supplier
    Inherits System.Web.UI.Page

    Protected Sub defaultCountry(ByVal sender As Object, ByVal e As System.EventArgs)
        ' default country to UK
        Dim rcbCountry As RadComboBox = CType(sender, RadComboBox)
        rcbCountry.SelectedValue = 183
    End Sub

    Protected Sub Validate_OnClick()
        Page.Validate("editGroup")
    End Sub

End Class
