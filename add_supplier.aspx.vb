Imports Telerik.Web.UI

Partial Class manager_add_supplier
    Inherits System.Web.UI.Page

    Protected Sub defaultCountry(ByVal sender As Object, ByVal e As System.EventArgs)
        ' default country to UK
        Dim rcbCountry As RadComboBox = CType(sender, RadComboBox)
        rcbCountry.SelectedValue = 183
    End Sub

    Protected Sub Validate_Insert()
        Page.Validate("insertGroup")
    End Sub

    Protected Sub insertSupplierDataSource_Inserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles insertSupplierDataSource.Inserted
        Response.Redirect("suppliers.aspx")
    End Sub

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        Dim activeLink As HyperLink = CType(Master.FindControl("hlSuppliers"), HyperLink)
        activeLink.CssClass = "active"
    End Sub
End Class
