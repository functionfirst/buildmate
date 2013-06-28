Imports Telerik.Web.UI

Partial Class manager_add_customer
    Inherits System.Web.UI.Page

    Protected Sub defaultCountry(ByVal sender As Object, ByVal e As System.EventArgs)
        ' default country to UK
        ' ?? possible to change this to default based on browser location
        Dim rcbCountry As RadComboBox = CType(sender, RadComboBox)
        rcbCountry.SelectedValue = 183
    End Sub

    Protected Sub Validate_Insert()
        Page.Validate("insertGroup")
        ' validate check for the insert customer form
        Dim errorBox2 As HtmlControl = CType(fvCustomerInsert.FindControl("errorbox2"), HtmlControl)
        If Not IsNothing(errorBox2) Then
            If Me.Page.IsValid Then
                errorBox2.Visible = False
            Else
                errorBox2.Visible = True
            End If
        End If
    End Sub

    Protected Sub fvCustomerInsert_ItemInserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewInsertedEventArgs) Handles fvCustomerInsert.ItemInserted
        Response.Redirect(String.Format("customers.aspx?action=added"))
    End Sub

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        Dim activeLink As HyperLink = CType(Master.FindControl("hlCustomers"), HyperLink)
        activeLink.CssClass = "active"
    End Sub
End Class
