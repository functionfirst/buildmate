﻿Imports System.Data
Imports Telerik.Web.UI
Imports System.Data.SqlClient

Partial Class manager_Default
    Inherits MyBaseClass

    Protected Sub rdpStartDate_SelectedDateChanged(ByVal sender As Object, ByVal e As Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs) Handles rdpStartDate.SelectedDateChanged
        applyFilters()
        If rdpStartDate.DateInput.SelectedDate.HasValue Then
            rdpEndDate.MinDate = rdpStartDate.DateInput.SelectedDate
        End If
    End Sub

    Protected Sub rcbStatus_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles rcbStatus.DataBound
        If rcbStatus.Items.Count > 0 Then
            rcbStatus.Items.Insert(0, New RadComboBoxItem("Project Status (Any)", 0))
        End If
    End Sub

    Protected Sub btnApplyFilter_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnApplyFilter.Click
        applyFilters()
    End Sub

    Protected Sub btnRemoveFilter_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnRemoveFilter.Click
        ' reset filter form
        rcbStatus.SelectedValue = 0
        rcbProjectType.SelectedIndex = 0
        rtbKeywords.Text = ""

        rdpStartDate.SelectedDate = Nothing
        rdpEndDate.SelectedDate = Nothing

        ' apply default filters
        applyFilters()
    End Sub

    Protected Sub applyFilters()
        Dim filter As String = ""

        ' project type
        If (rcbProjectType.SelectedIndex >= 1) Then
            filter += String.Format("projectTypeId = {0}", rcbProjectType.SelectedValue)
        Else
            filter += "1=1"
        End If

        ' keyword filter
        If Not String.IsNullOrEmpty(rtbKeywords.Text.ToString) Then
            filter += String.Format(" AND (projectName LIKE '%%%{0}%%%' OR description LIKE '%%%{0}%%%')", rtbKeywords.Text)
        End If

        ' check start and end date filters
        If Not rdpStartDate.IsEmpty Then
            filter += String.Format(" AND startDate >= #{0:M/dd/yyyy}#", rdpStartDate.SelectedDate)
        End If

        If Not rdpEndDate.IsEmpty Then
            filter += String.Format(" AND completionDate <= #{0:M/dd/yyyy}#", rdpEndDate.SelectedDate)
        End If

        ' check project status filter
        If rcbStatus.SelectedIndex > 0 Then filter += " AND projectStatusId = " & rcbStatus.SelectedValue

        addGroupingToGrid()

        projectsDataSource.FilterExpression = filter
        projectsDataSource.DataBind()

    End Sub

    Protected Sub rcbStatus_SelectedIndexChanged(ByVal o As Object, ByVal e As Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs) Handles rcbStatus.SelectedIndexChanged
        applyFilters()

        ' apply group filters to grid if no status selected
        If rcbStatus.SelectedIndex = 0 Then
            addGroupingToGrid()
        Else
            rgProjects.MasterTableView.GroupByExpressions.Clear()
        End If
    End Sub

    Protected Sub addGroupingToGrid()
        Dim gbbExpression As GridGroupByExpression = New GridGroupByExpression
        Dim groupField As GridGroupByField = New GridGroupByField
        Dim selectField As GridGroupByField = New GridGroupByField
        groupField.FieldName = "projectStatusId"
        groupField.SortOrder = GridSortOrder.Descending
        selectField.FieldName = "status"
        selectField.FieldAlias = "Status"
        gbbExpression.GroupByFields.Add(groupField)
        gbbExpression.SelectFields.Add(selectField)
        rgProjects.MasterTableView.GroupByExpressions.Clear()
        rgProjects.MasterTableView.GroupByExpressions.Add(gbbExpression)
    End Sub

    Protected Sub rdpEndDate_SelectedDateChanged(ByVal sender As Object, ByVal e As Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs) Handles rdpEndDate.SelectedDateChanged
        applyFilters()
    End Sub

    Protected Sub rtbKeywords_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles rtbKeywords.TextChanged
        applyFilters()
    End Sub

    Protected Sub rgProjects_ItemDataBound(ByVal sender As Object, ByVal e As Telerik.Web.UI.GridItemEventArgs) Handles rgProjects.ItemDataBound
        If TypeOf e.Item Is GridGroupHeaderItem Then
            Dim item As GridGroupHeaderItem = CType(e.Item, GridGroupHeaderItem)
            Dim groupDataRow As DataRowView = CType(e.Item.DataItem, DataRowView)
            item.DataCell.Text = (item.DataCell.Text.Split(":")(1))
        End If
    End Sub

    Protected Sub rcbProjectType_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles rcbProjectType.DataBound
        If rcbProjectType.Items.Count > 0 Then
            rcbProjectType.Items.Insert(0, New RadComboBoxItem("Project Type (Any)", 0))
        End If
    End Sub

    Protected Sub rgProjects_PageIndexChanged(source As Object, e As Telerik.Web.UI.GridPageChangedEventArgs) Handles rgProjects.PageIndexChanged
        applyFilters()
    End Sub

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        Dim activeLink As HyperLink = CType(Master.FindControl("hlProjects"), HyperLink)
        activeLink.CssClass = "active"

        filterByStatus()
    End Sub

    Protected Sub filterByStatus()
        Dim status = Request.QueryString("status")
        If (IsNumeric(status)) Then
            rcbStatus.SelectedValue = status
            Dim filter As String = "projectStatusId = " & status & " AND archived = 0"

            addGroupingToGrid()

            projectsDataSource.FilterExpression = filter
            projectsDataSource.DataBind()
        End If
    End Sub
End Class
