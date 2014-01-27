Imports Telerik.Web.UI
Imports System.Data.SqlClient

Partial Class manager_Default
    Inherits MyBaseClass

    Protected Sub Page_Init(sender As Object, e As EventArgs) Handles Me.Init
        'addCustomerShortcut()
    End Sub

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        activateNavigationLink("hlCustomers")
        addCustomerShortcut()
    End Sub

    Protected Sub addCustomerShortcut()
        Dim action As String = Request.QueryString("action")
        Trace.Write(action)
        If action = "add_customer" Then
            addCustomerScript.Visible = True
            'addCustomer.CssClass = "md-window md-show"
        End If
    End Sub

    Protected Sub btnApplyFilter_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnApplyFilter.Click
        applyFilters()
    End Sub

    Protected Sub btnRemoveFilter_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnRemoveFilter.Click
        resetFilters()
    End Sub

    Private Sub resetFilters()
        rtbFilter.Text = Nothing
        cbArchived.Checked = False

        applyFilters()
    End Sub

    Private Sub applyFilters()
        Dim filter As String = ""
        filter = String.Format("(name LIKE '%%%{0}%%%' OR jobtitle LIKE '%%%{0}%%%' OR address LIKE '%%%{0}%%%' OR postcode LIKE '%%%{0}%%%')", rtbFilter.Text)

        If Not cbArchived.Checked Then filter += " AND archived = 0"

        rgCustomers.MasterTableView.FilterExpression = filter
        rgCustomers.MasterTableView.Rebind()

        allCustomersDataSource.FilterExpression = filter
    End Sub

    Protected Sub rgCustomers_PageIndexChanged(source As Object, e As Telerik.Web.UI.GridPageChangedEventArgs) Handles rgCustomers.PageIndexChanged
        applyFilters()
    End Sub

    Protected Sub cbArchived_CheckedChanged(sender As Object, e As EventArgs) Handles cbArchived.CheckedChanged
        applyFilters()
    End Sub

    Protected Sub rtbFilter_TextChanged(sender As Object, e As EventArgs) Handles rtbFilter.TextChanged
        applyFilters()
    End Sub

    Protected Sub fvCustomerInsert_ItemInserted(sender As Object, e As FormViewInsertedEventArgs) Handles fvCustomerInsert.ItemInserted
        rgCustomers.DataBind()
    End Sub
End Class
