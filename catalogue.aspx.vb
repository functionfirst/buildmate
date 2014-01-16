Imports System.Data
Imports Telerik.Web.UI
Imports System.Data.SqlClient

Partial Class catalogue
    Inherits System.Web.UI.Page

    Protected Sub rcbResources_ItemsRequested1(ByVal o As Object, ByVal e As Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs) Handles rcbResources.ItemsRequested
        Dim sqlSelectCommand As String = "SELECT TOP 1000 id, unitId, resourceName, manufacturer, partId FROM tblResources WHERE resourceName LIKE '%@resourceName%' AND resourceTypeId = @resourceTypeId ORDER BY resourceName"
        Dim adapter As New SqlDataAdapter(sqlSelectCommand, System.Configuration.ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString)
        adapter.SelectCommand.Parameters.AddWithValue("@resourceName", e.Text)
        adapter.SelectCommand.Parameters.AddWithValue("@resourceTypeId", rcbresourceType.SelectedValue)
        Dim dataTable As New DataTable()
        adapter.Fill(dataTable)

        For Each dataRow As DataRow In dataTable.Rows
            Dim item As New RadComboBoxItem()

            item.Text = Server.HtmlDecode(dataRow("resourceName"))
            item.Value = dataRow("id")

            Dim manufacturer As String = DirectCast(dataRow("manufacturer"), String)
            Dim partId As String = DirectCast(dataRow("partId"), String)

            item.Attributes.Add("manufacturer", manufacturer)
            item.Attributes.Add("partId", partId)

            rcbResources.Items.Add(item)

            item.DataBind()
        Next
    End Sub


    'Private Const ItemsPerRequest As Integer = 100

    'Private Shared Function GetStatusMessage(ByVal offset As Integer, ByVal total As Integer) As String
    '    If total <= 0 Then
    '        Return "No matches"
    '    End If

    '    Return [String].Format("Items <b>1</b>-<b>{0}</b> out of <b>{1}</b>", offset, total)
    'End Function

    'Private Shared Function GetData(ByVal text As String, ByVal resourceType As String) As DataTable
    '    'Dim adapter As New SqlDataAdapter("SELECT id, unitId, resourceName FROM tblResources WHERE resourceName LIKE '%' + @text + '%' AND resourceTypeId = @resourceType", ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString)
    '    Dim adapter As New SqlDataAdapter("SELECT id, unitId, resourceName FROM tblResources WHERE resourceName LIKE '%' + @text + '%' AND resourceTypeId = @resourceType", ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString)
    '    adapter.SelectCommand.Parameters.AddWithValue("@resourceType", resourceType)
    '    adapter.SelectCommand.Parameters.AddWithValue("@text", text)

    '    Dim data As New DataTable()
    '    adapter.Fill(data)

    '    Return data
    'End Function

    'Protected Sub rcbResources_ItemsRequested(ByVal o As Object, ByVal e As Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs) Handles rcbResources.ItemsRequested
    '    If e.Text.Length >= 3 Then
    '        Dim data As DataTable = GetData(e.Text, rcbResourceType.SelectedValue)

    '        Dim itemOffset As Integer = e.NumberOfItems
    '        Dim endOffset As Integer = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count)
    '        e.EndOfItems = endOffset = data.Rows.Count

    '        For i As Integer = itemOffset To endOffset - 1
    '            rcbResources.Items.Add(New RadComboBoxItem(Server.HtmlDecode(data.Rows(i)("resourceName").ToString()), data.Rows(i)("id").ToString()))
    '        Next

    '        e.Message = GetStatusMessage(endOffset, data.Rows.Count)

    '    End If
    'End Sub

    'Protected Sub ApplyFilters()
    '    ' ensure either keywords or a category is selected
    '    ' nodevalue >= 4 so don't search for top level category
    '    If rtbFilter.Text.Length >= 1 Or NodeValue.Value >= 4 Then
    '        Dim filterExpr As String = ""

    '        ' check for keyword filter
    '        If rtbFilter.Text.Length >= 1 Then
    '            filterExpr += " AND (resourceName LIKE '%%%" & rtbFilter.Text & "%%%' OR keywords LIKE '%%%" & rtbFilter.Text & "%%%')"
    '        End If

    '        ' filter by category
    '        If NodeValue.Value >= 4 Then
    '            filterExpr += " AND categoryId = " & Convert.ToInt32(NodeValue.Value)
    '        End If

    '        ' apply filter expression and databind
    '        Dim sqlSelect As String = "SELECT tblResources.id, resourceName, unit, keywords, categoryId, categoryName" & _
    '                            " FROM tblResources " & _
    '                            " LEFT JOIN tblUnits ON tblUnits.id = tblResources.unitId " & _
    '                            " LEFT JOIN tblCategories ON tblCategories.id = tblResources.categoryId " & _
    '                            " WHERE 1=1 " & filterExpr & _
    '                            " ORDER BY resourceName"

    '        allResourceDataSource.SelectCommand = sqlSelect
    '        allResourceDataSource.DataBind()
    '        rgResources.DataBind()
    '    End If
    'End Sub

    Protected Sub btnApplyFilter_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnApplyFilter.Click
        'ApplyFilters()

        allCatalogueDataSource.DataBind()
        rgCatalogue.DataBind()

        ' enable add resource button 
        If rcbSupplier.SelectedValue > 0 And rcbResources.SelectedValue > 0 Then
            pAddCatalogue.Visible = True
            hlAddCatalogue.NavigateUrl = String.Format(hlAddCatalogue.NavigateUrl, rcbSupplier.SelectedValue, rcbResources.SelectedValue)
        Else
            pAddCatalogue.Visible = False
        End If
    End Sub

    Protected Sub rcbResourceType_SelectedIndexChanged(ByVal o As Object, ByVal e As Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs) Handles rcbResourceType.SelectedIndexChanged
        rcbResources.Text = ""
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Request.QueryString("rid") > 0 Then
            rcbResources.SelectedValue = Request.QueryString("rid")
            rcbSupplier.SelectedValue = Request.QueryString("sid")

            pAddCatalogue.Visible = True
        End If
    End Sub

    Protected Sub rcbSupplier_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles rcbSupplier.DataBound
        rcbSupplier.Items.Insert(0, New RadComboBoxItem("Select a Supplier", -1))
    End Sub

End Class
