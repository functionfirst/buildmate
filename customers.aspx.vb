Imports Telerik.Web.UI
Imports System.Data.SqlClient

Partial Class manager_Default
    Inherits MyBaseClass

    Protected Sub OnCheckChanged(ByVal sender As Object, ByVal e As EventArgs)
        ' flip the archive flag for the selected customer
        ' Identify the customerId from a hidden label within the datagrid row
        Dim grdCell As GridTableCell = CType(sender, CheckBox).Parent
        Dim customerId As String = CType(grdCell.FindControl("hiddenCustomerId"), HiddenField).Value
        Dim checkState As Boolean = CType(sender, CheckBox).Checked
        Dim connString As String = System.Configuration.ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString
        Dim sql As String = "UPDATE UserContact SET archived = '" & checkState & "' WHERE id = " & customerId

        Using conn As New SqlConnection(connString)
            Dim cmd As New SqlCommand(sql, conn)
            Try
                conn.Open()
                cmd.ExecuteScalar()
            Catch ex As Exception
                Trace.Write(ex.Message)
            End Try
        End Using
        rgCustomers.DataBind()
        applyFilters()
    End Sub

    Protected Sub btnApplyFilter_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnApplyFilter.Click
        applyFilters()
    End Sub

    Protected Sub btnRemoveFilter_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnRemoveFilter.Click
        rtbFilter.Text = Nothing
        cbArchived.Checked = False

        applyFilters()
    End Sub

    Protected Sub applyFilters()
        Dim filter As String
        filter = String.Format("(firstname LIKE '%%%{0}%%%' OR surname LIKE '%%%{0}%%%' OR jobtitle LIKE '%%%{0}%%%' OR customerAddress LIKE '%%%{0}%%%' OR postcode LIKE '%%%{0}%%%')", rtbFilter.Text)

        If Not cbArchived.Checked Then filter += " AND archived = 0"

        rgCustomers.MasterTableView.FilterExpression = rgCustomers.MasterTableView.FilterExpression + filter
        rgCustomers.MasterTableView.Rebind()

        'RadGrid1.MasterTableView.FilterExpression = "([versionId] = "+VersionsCB.SelectedValue+")";    
        'GridColumn column = RadGrid1.MasterTableView.GetColumnSafe("versionId");    
        'column.CurrentFilterFunction = GridKnownFunction.EqualTo;    
        'column.CurrentFilterValue = VersionsCB.SelectedValue;    
        'RadGrid1.Rebind();

        allCustomersDataSource.FilterExpression = filter
    End Sub

    Protected Sub rgCustomers_PageIndexChanged(source As Object, e As Telerik.Web.UI.GridPageChangedEventArgs) Handles rgCustomers.PageIndexChanged
        applyFilters()
    End Sub

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        Dim activeLink As HyperLink = CType(Master.FindControl("hlCustomers"), HyperLink)
        activeLink.CssClass = "active"

        If hasCustomer() Then
            customerPanel.Visible = True
            noCustomerPanel.Visible = False
        Else
            customerPanel.Visible = False
            noCustomerPanel.Visible = True
        End If
    End Sub
End Class
