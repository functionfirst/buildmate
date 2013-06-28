Imports Telerik.Web.UI

Partial Class manager_customer_details
    Inherits System.Web.UI.Page

    Protected Sub defaultCountry(ByVal sender As Object, ByVal e As System.EventArgs)
        ' default country to UK
        ' ?? possible to change this to default based on browser location
        Dim rcbCountry As RadComboBox = CType(sender, RadComboBox)
        rcbCountry.SelectedValue = 183
    End Sub

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        Dim activeLink As HyperLink = CType(Master.FindControl("hlCustomers"), HyperLink)
        activeLink.CssClass = "active"
    End Sub
End Class
