Imports System.Data.SqlClient
Imports Telerik.Web.UI
Imports System.Data

Partial Class manager_task_details
    Inherits System.Web.UI.Page

    Dim isLocked As Boolean = False
    Private Const ItemsPerRequest As Integer = 100

    Protected Sub rcbResources_ItemsRequested(ByVal o As Object, ByVal e As Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs) Handles rcbResources.ItemsRequested
        ' define whereby clause
        Dim whereBy As String = ""
        Select Case rcbSearchType.SelectedValue
            Case 2
                ' resource exists in current project
                whereBy += " AND Resource.id IN (" & _
                    "   SELECT DISTINCT TaskResource.resourceId" & _
                    "   FROM TaskResource " & _
                    "   LEFT JOIN Task ON TaskResource.taskId = Task.id " & _
                    "   LEFT JOIN BuildElement ON Task.buildElementId = BuildElement.id " & _
                    "   WHERE BuildElement.projectId = @projectId" & _
                    ")"
            Case 3
                ' all resource used by this user in any of their projects
                whereBy += " AND Resource.id IN (" & _
                    "   SELECT DISTINCT TaskResource.resourceId " & _
                    "   FROM TaskResource " & _
                    "   LEFT JOIN Task ON TaskResource.taskId = Task.id " & _
                    "   LEFT JOIN BuildElement ON Task.buildElementId = BuildElement.id " & _
                    "   LEFT JOIN Project ON BuildElement.projectId = Project.id " & _
                    "   WHERE Project.userId = @userId" & _
                    ") "
        End Select

        Dim txt_array As Array = e.Text.Split(" ")
        Dim searchTerms As String = ""
        For Each item As String In txt_array
            If searchTerms = "" Then
                searchTerms += " (resourceName LIKE '%" + item + "%' OR keywords LIKE '%" + item + "%' OR manufacturer LIKE '%" + item + "%')"
            Else
                searchTerms += " AND (resourceName LIKE '%" + item + "%' OR keywords LIKE '%" + item + "%' OR manufacturer LIKE '%" + item + "%')"
            End If
        Next

        Dim sqlSelectCommand As String = "SELECT TOP 1000 Resource.id, unitId, resourceName, manufacturer, partId FROM Resource " & _
            "WHERE " & searchTerms & _
            " AND resourceTypeId = " + rblResourceType.SelectedValue + "" & _
            whereBy & _
            " ORDER BY resourceName"
        Try
            Dim adapter As New SqlDataAdapter(sqlSelectCommand, System.Configuration.ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString)
            adapter.SelectCommand.Parameters.AddWithValue("@projectId", Request.QueryString("pid"))
            adapter.SelectCommand.Parameters.AddWithValue("@userId", Session("userId"))
            Dim dataTable As New DataTable()
            adapter.Fill(dataTable)

            Dim itemOffset As Integer = e.NumberOfItems
            Dim endOffset As Integer = Math.Min(itemOffset + ItemsPerRequest, dataTable.Rows.Count)

            For i As Integer = itemOffset To endOffset - 1
                ' check item exists
                If Not dataTable.Rows.Item(i) Is Nothing Then
                    Dim item As New RadComboBoxItem()

                    item.Text = Server.HtmlDecode(dataTable.Rows.Item(i)("resourceName").ToString)
                    item.Value = dataTable.Rows.Item(i)("id").ToString
                    item.Attributes.Add("manufacturer", dataTable.Rows.Item(i)("manufacturer").ToString)
                    item.Attributes.Add("partId", dataTable.Rows.Item(i)("partId").ToString)
                    rcbResources.Items.Add(item)

                    item.DataBind()
                End If
            Next

            If dataTable.Rows.Count <= 0 Then
                e.Message = "No resources were found"
            Else
                Dim maxpage As Integer = Math.Min(itemOffset + ItemsPerRequest, dataTable.Rows.Count)
                e.Message = String.Format("Items <b>1</b>-<b>{0}</b> out of <b>{1}</b>", maxpage, dataTable.Rows.Count)
            End If

        Catch ex As Exception
            Trace.Write(ex.ToString)
        End Try
    End Sub

    Protected Sub Validate_Edit()
        Page.Validate("editGroup")
    End Sub

    Protected Sub fvTaskAdjustments_DataBound(sender As Object, e As System.EventArgs) Handles fvTaskAdjustments.DataBound
        Dim taskQty As Object = DirectCast(fvTaskAdjustments.DataItem, DataRowView)("qty")
        If taskQty > 0 Then
            pRequiresTaskQty.Visible = False
            pCurrentResources.Visible = True
        Else
            pRequiresTaskQty.Visible = True
            pCurrentResources.Visible = False
        End If
    End Sub

    Protected Sub fvTaskAdjustments_ItemUpdated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewUpdatedEventArgs) Handles fvTaskAdjustments.ItemUpdated
        fvTaskTotals.DataBind()
        rgResources.DataBind()

        nextStepInTour()
    End Sub

    Protected Sub nextStepInTour()
        If Session("tourPhase") = 4 Then
            Response.Redirect(HttpContext.Current.Request.Url.AbsoluteUri)
        End If
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim hlAddResources As HyperLink = CType(fvDefaultResources.FindControl("hlAddResources"), HyperLink)
        Dim activeLink As HyperLink = CType(Master.FindControl("hlProjects"), HyperLink)
        activeLink.CssClass = "active"

        hlBack.NavigateUrl = String.Format(hlBack.NavigateUrl, Request.QueryString("pid"))
        hlBack2.NavigateUrl = String.Format(hlBack2.NavigateUrl, Request.QueryString("pid"), Request.QueryString("rid"))

        ' check for lockstate of the project
        isLocked = checkLockState()

        If isLocked Then
            pAddResources.Visible = False
            pAddAdditions.Visible = False
            hlAddResources.Visible = False
            panelIsLocked.Visible = True
        Else
            pAddResources.Visible = True
            pAddAdditions.Visible = True
            hlAddResources.Visible = True
            panelIsLocked.Visible = False
        End If
    End Sub

    Protected Function checkLockState() As Boolean
        'taskDataSource
        Dim returnVal As Boolean
        Dim dvSql As DataView = DirectCast(taskDataSource.Select(DataSourceSelectArguments.Empty), DataView)

        For Each drvSql As DataRowView In dvSql
            returnVal = Convert.ToBoolean(drvSql("isLocked"))
        Next

        Return returnVal
    End Function

    Protected Sub setDefaultResources(ByVal sender As Object, ByVal e As System.EventArgs)
        ' create and execute sql commandresourceId
        Dim dbCon As New SqlConnection(ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString)
        dbCon.Open()

        Dim cmd As New SqlCommand("setDefaultTaskResources", dbCon)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.AddWithValue("@userId", Session("userId"))
        cmd.Parameters.AddWithValue("@taskId", Request.QueryString("tid"))

        ' bind to data adapter
        Dim adapter As SqlDataAdapter = New SqlDataAdapter(cmd)
        Dim dt As DataTable = New DataTable
        adapter.Fill(dt)
        dbCon.Close()

        fvDefaultResources.DataBind()
    End Sub

    Private Sub insertResource(ByVal resourceId As String)
        ' create and execute sql command
        Dim dbCon As New SqlConnection(ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString)
        dbCon.Open()

        Dim cmd As New SqlCommand("insertTaskResource", dbCon)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.AddWithValue("@taskId", Request.QueryString("tid"))
        cmd.Parameters.AddWithValue("@projectId", Request.QueryString("pid"))
        cmd.Parameters.AddWithValue("@resourceId", resourceId)
        cmd.Parameters.AddWithValue("@uses", rntbUses.Value)
        cmd.Parameters.AddWithValue("@qty", rntbQty.Value)
        cmd.Parameters.AddWithValue("@userId", Session("userId"))

        ' bind to data adapter
        Dim adapter As SqlDataAdapter = New SqlDataAdapter(cmd)
        Dim dt As DataTable = New DataTable
        adapter.Fill(dt)
        dbCon.Close()

        rgResources.DataBind()
        rebindSiblingData()

        movetoPhaseSix()
    End Sub

    Protected Sub btnAddResources_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAddResources.Click
        ' grab the resourceid
        Dim resourceid As String = rcbResources.SelectedValue

        If IsNumeric(resourceid) Then
            ' if resourceid exists, insert resource
            insertResource(resourceid)

            ' reset the add resource form
            rntbUses.Text = 0
            rntbQty.Text = 1
            rcbResources.ClearSelection()
            rcbResources.Text = ""
        End If
    End Sub

    Protected Sub rebindSiblingData()
        fvTaskTotals.DataBind()
        fvTaskAdjustments.DataBind()
    End Sub

    Protected Sub rblResourceType_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles rblResourceType.SelectedIndexChanged
        rcbResources.Text = ""
    End Sub

    Protected Sub rgResources_ItemCommand(ByVal source As Object, ByVal e As Telerik.Web.UI.GridCommandEventArgs) Handles rgResources.ItemCommand
        If (e.CommandName = "deleteResource") Then
            ' create and execute sql command
            Dim dbCon As New SqlConnection(ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString)
            dbCon.Open()

            Dim cmd As New SqlCommand("sp_TaskResource_DELETE", dbCon)
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@id", e.CommandArgument)

            ' bind to data adapter
            Dim adapter As SqlDataAdapter = New SqlDataAdapter(cmd)
            Dim dt As DataTable = New DataTable
            adapter.Fill(dt)
            dbCon.Close()

            rebindSiblingData()
        End If
    End Sub

    Private total As Decimal
    Protected Sub rgResources_ItemDataBound(ByVal sender As Object, ByVal e As Telerik.Web.UI.GridItemEventArgs) Handles rgResources.ItemDataBound
        Select Case e.Item.ItemType
            Case GridItemType.Item, GridItemType.AlternatingItem
                ' Get the total for each row and get a total to be used later.
                Dim dataItem As GridDataItem = CType(e.Item, GridDataItem)
                ' Row total
                Dim rowTotal As String = dataItem("cost").Text
                If IsNumeric(rowTotal) Then total += rowTotal

                ' check for a locked stack resource
                'Dim isStackLocked As Boolean = dataItem("isStackLocked").Text
                'If isStackLocked Or isLocked Then
                '    dataItem("resourceName").Controls(1).Visible = True
                '    dataItem("resourceName").Controls(3).Visible = True
                '    dataItem("resourceName").Controls(5).Visible = False
                '    'dataItem("resourceNameLink").Visible = False
                '    dataItem("DeleteColumn").Visible = False
                'Else
                '    dataItem("resourceName").Controls(1).Visible = False
                '    dataItem("resourceName").Controls(3).Visible = False
                '    dataItem("resourceName").Controls(5).Visible = True
                '    'dataItem("resourceNameLink").Visible = True
                '    dataItem("DeleteColumn").Visible = True
                'End If

            Case GridItemType.Footer
                If total > 0 Then
                    rgResources.MasterTableView.ShowFooter = True

                    ' Calculate the grand total and display this value in the footer
                    Dim footer As GridFooterItem = CType(e.Item, GridFooterItem)

                    footer("waste").HorizontalAlign = HorizontalAlign.Right
                    footer("waste").Controls.Add(New LiteralControl("Total:"))

                    footer("cost").HorizontalAlign = HorizontalAlign.Right
                    Dim lbl As Label = New Label
                    lbl.Text = String.Format("{0:c}", total)
                    footer("cost").Controls.Add(lbl)
                Else
                    rgResources.MasterTableView.ShowFooter = False
                End If
        End Select
    End Sub

    Protected Sub rgResources_ItemUpdated(ByVal source As Object, ByVal e As Telerik.Web.UI.GridUpdatedEventArgs) Handles rgResources.ItemUpdated
        rebindSiblingData()
    End Sub

    Protected Sub rgResources_ItemInserted(ByVal source As Object, ByVal e As Telerik.Web.UI.GridInsertedEventArgs) Handles rgResources.ItemInserted
        rebindSiblingData()
    End Sub

    Protected Sub movetoPhaseSix()
        If Session("tourPhase") = 5 Then
            Response.Redirect(HttpContext.Current.Request.Url.AbsoluteUri)
        End If
    End Sub

    Protected Sub rgResources_ItemDeleted(ByVal source As Object, ByVal e As Telerik.Web.UI.GridDeletedEventArgs) Handles rgResources.ItemDeleted
        rebindSiblingData()
    End Sub

    Dim adhoctotal As Decimal

    Protected Sub rgAdditions_ItemDataBound(ByVal sender As Object, ByVal e As Telerik.Web.UI.GridItemEventArgs) Handles rgAdditions.ItemDataBound
        If TypeOf e.Item Is GridDataItem Then
            ' Get the total for each row and get a total to be used later.
            Dim dataItem As GridDataItem = CType(e.Item, GridDataItem)

            ' Row total
            Dim rowTotal As String = dataItem("total").Text
            If IsNumeric(rowTotal) Then adhoctotal += rowTotal
        ElseIf TypeOf e.Item Is GridFooterItem Then
            If adhoctotal > 0 Then
                rgAdditions.MasterTableView.ShowFooter = True

                ' Calculate the grand total and display this value in the footer
                Dim footer As GridFooterItem = CType(e.Item, GridFooterItem)

                footer("description").HorizontalAlign = HorizontalAlign.Right
                footer("description").Controls.Add(New LiteralControl("Total:"))

                footer("total").HorizontalAlign = HorizontalAlign.Right
                Dim lbl As Label = New Label
                lbl.Text = String.Format("{0:c}", adhoctotal)
                footer("total").Controls.Add(lbl)
            Else
                rgAdditions.MasterTableView.ShowFooter = False
            End If
        End If
    End Sub

    Protected Sub rgAdditions_ItemDeleted(ByVal source As Object, ByVal e As Telerik.Web.UI.GridDeletedEventArgs) Handles rgAdditions.ItemDeleted
        rebindSiblingData()
    End Sub

    Protected Sub rgAdditions_ItemUpdated(ByVal source As Object, ByVal e As Telerik.Web.UI.GridUpdatedEventArgs) Handles rgAdditions.ItemUpdated
        rebindSiblingData()
    End Sub

    Protected Sub rgAdditions_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles rgAdditions.PreRender
        If (rgAdditions.EditItems.Count > 0) Then
            For Each item As GridDataItem In rgAdditions.MasterTableView.Items
                If (item Is rgAdditions.EditItems(0)) Then
                    item.Visible = False
                End If
            Next
        End If

        ' prevent /editdelete of additions
        If isLocked Then
            rgAdditions.MasterTableView.Columns(0).Visible = False
            rgAdditions.MasterTableView.Columns(1).Visible = True
            rgAdditions.MasterTableView.Columns(3).Visible = False
        Else
            rgAdditions.MasterTableView.Columns(0).Visible = True
            rgAdditions.MasterTableView.Columns(1).Visible = False
            rgAdditions.MasterTableView.Columns(3).Visible = True
        End If
    End Sub

    Protected Sub rgResources_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles rgResources.PreRender
        If (rgResources.EditItems.Count > 0) Then
            For Each item As GridDataItem In rgResources.MasterTableView.Items
                If (item Is rgResources.EditItems(0)) Then
                    item.Visible = False
                End If
            Next
        End If

        ' prevent delete/edit of resources
        If isLocked Then
            rgResources.MasterTableView.Columns(0).Visible = False
            rgResources.MasterTableView.Columns(1).Visible = True
            rgResources.MasterTableView.Columns(5).Visible = False
        Else
            rgResources.MasterTableView.Columns(0).Visible = True
            rgResources.MasterTableView.Columns(1).Visible = False
            rgResources.MasterTableView.Columns(5).Visible = True
        End If
    End Sub


    Private calctotal As Decimal = 0

    Protected Sub rgCalculator_ItemDataBound(ByVal sender As Object, ByVal e As Telerik.Web.UI.GridItemEventArgs) Handles rgCalculator.ItemDataBound
        If TypeOf e.Item Is GridDataItem Then
            ' Get the total for each row and get a total to be used later.
            Dim dataItem As GridDataItem = CType(e.Item, GridDataItem)

            ' Row total
            Dim rowTotal As String = FormatNumber(dataItem("total").Text, 2)
            If IsNumeric(rowTotal) Then
                calctotal += rowTotal
            End If
        ElseIf TypeOf e.Item Is GridFooterItem Then
            ' Calculate the grand total and display this value in the footer
            Dim footer As GridFooterItem = CType(e.Item, GridFooterItem)

            footer("multiplier").HorizontalAlign = HorizontalAlign.Right
            footer("multiplier").Controls.Add(New LiteralControl("<b>Total:</b><br />"))

            footer("multiplier").HorizontalAlign = HorizontalAlign.Right

            footer("total").HorizontalAlign = HorizontalAlign.Center
            footer("total").Controls.Add(New LiteralControl(calctotal))

            qtyTotal.Value = calctotal
        End If
    End Sub

    Protected Sub rgCalculator_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles rgCalculator.PreRender
        ' hide the currently editable item - iterate through each row
        For Each item As GridDataItem In rgCalculator.Items
            ' hide the row if it is being edited
            If item.Edit Then
                item.Visible = False
            End If
        Next
    End Sub

    Protected Sub btnUpdateQty_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnUpdateQty.Click
        ' Find main form quantity container and update the value
        Dim rntbQuantity As RadNumericTextBox = CType(fvTaskAdjustments.Row.FindControl("rntbQuantity"), RadNumericTextBox)
        rntbQuantity.Value = qtyTotal.Value
    End Sub

    Protected Sub btnAdd_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAdd.Click
        fvAddCalc.Visible = True
        btnAdd.Visible = False
    End Sub

    Protected Sub btnCancel_Click()
        fvAddCalc.Visible = False
        btnAdd.Visible = True
    End Sub

    Protected Sub lbClose_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim Calculator As Panel = fvTaskAdjustments.FindControl("Calculator")
        Calculator.Visible = False
    End Sub

    Protected Sub fvAddCalc_ItemInserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewInsertedEventArgs) Handles fvAddCalc.ItemInserted
        fvAddCalc.Visible = False
        btnAdd.Visible = True
        rgCalculator.DataBind()
    End Sub

    Protected Sub rcbSearchType_SelectedIndexChanged(ByVal o As Object, ByVal e As Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs) Handles rcbSearchType.SelectedIndexChanged
        rcbResources.Text = ""
    End Sub

    Protected Sub rcbResources_SelectedIndexChanged(ByVal o As Object, ByVal e As Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs) Handles rcbResources.SelectedIndexChanged
        ' get the unit of the current resource
        Dim sqlSelectCommand As String = "SELECT unit FROM Resource "
        sqlSelectCommand += "LEFT JOIN ResourceUnit ON ResourceUnit.id = unitId WHERE Resource.id = @resourceId"
        Dim adapter As New SqlDataAdapter(sqlSelectCommand, System.Configuration.ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString)
        adapter.SelectCommand.Parameters.AddWithValue("@resourceId", e.Value)
        Dim dataTable As New DataTable()
        adapter.Fill(dataTable)

        ' check item exists
        If dataTable.Rows.Count >= 1 Then
            Label14.Text = "Usage (" + dataTable.Rows.Item(0)("unit").ToString + "):"
        End If
    End Sub

    Protected Sub fvAddAdhoc_ItemInserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewInsertedEventArgs) Handles fvAddAdhoc.ItemInserted
        fvAddAdhoc.DataBind()
        fvTaskTotals.DataBind()
    End Sub

    Protected Sub additionsDataSource_Inserted(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles additionsDataSource.Inserted
        rgAdditions.DataBind()
        fvTaskTotals.DataBind()
    End Sub
End Class