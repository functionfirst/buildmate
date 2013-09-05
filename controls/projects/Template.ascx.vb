Imports Telerik.Web.UI

Partial Class controls_projects_Template
    Inherits System.Web.UI.UserControl

    Dim projectId As String

    Protected Sub ToggleRowSelection(ByVal sender As Object, ByVal e As EventArgs)
        ToggleTemplateButton(sender)
        CheckSelectedItem(sender)
    End Sub

    Private Sub ToggleTemplateButton(ByVal sender As Object)
        If TryCast(sender, CheckBox).Checked Then
            lbBlankTemplate.Visible = False
            lbProject.Visible = True
            'lbProject.Text = "Use this Project Template"
            'lbProject.Enabled = True
        Else
            lbBlankTemplate.Visible = True
            lbProject.Visible = False
            'lbProject.Text = "You must select a Template above"
            'lbProject.Enabled = False
        End If
    End Sub

    Private Sub CheckSelectedItem(ByVal sender As Object)
        TryCast(TryCast(sender, CheckBox).NamingContainer, GridItem).Selected = TryCast(sender, CheckBox).Checked

        For Each dataItem As GridDataItem In rgProjects.Items
            TryCast(dataItem.FindControl("CheckBox1"), CheckBox).Checked = False
        Next

        For Each dataItem As GridDataItem In rgProjects.SelectedItems
            TryCast(dataItem.FindControl("CheckBox1"), CheckBox).Checked = True
            projectId = dataItem.Item("id").ToString()
        Next
    End Sub

    Protected Sub rgProjects_ItemEvent(sender As Object, e As GridItemEventArgs) Handles rgProjects.ItemEvent
        If TypeOf e.EventInfo Is GridInitializePagerItem Then
            Dim rowCount As Integer = TryCast(e.EventInfo, GridInitializePagerItem).PagingManager.DataSourceCount

            If rowCount = 0 Then
                noProjectsExist.Visible = True
                rgProjects.Visible = False
            Else
                noProjectsExist.Visible = False
                rgProjects.Visible = True
            End If
        End If
    End Sub

    Protected Sub lbBack_Click(sender As Object, e As EventArgs) Handles lbBack.Click
        GoBack()
    End Sub

    Protected Sub lbBlankTemplate_Click(sender As Object, e As EventArgs) Handles lbBlankTemplate.Click
        UseBlankTemplate()
    End Sub

    Protected Sub lbProject_Click(sender As Object, e As EventArgs) Handles lbProject.Click
        GoToNextTab()
        GoToPageView("Customer")
        UpdateNextPageView()
    End Sub

    Private Sub GoBack()
        Dim pEstimate As Panel = DirectCast(Me.NamingContainer.FindControl("pEstimate"), Panel)
        pEstimate.CssClass = "project-tab active"

        Dim pTemplate As Panel = DirectCast(Me.NamingContainer.FindControl("pTemplate"), Panel)
        pTemplate.CssClass = "project-tab"

        GoToPageView("Estimate")
    End Sub

    Private Sub UseBlankTemplate()
        GoToNextTab()
        GoToPageView("Customer")
    End Sub

    Private Sub GoToNextTab()
        Dim pCustomer As Panel = DirectCast(Me.NamingContainer.FindControl("pCustomer"), Panel)
        pCustomer.CssClass = "project-tab active"
    End Sub

    Private Sub GoToPageView(ByVal pageViewId As String)
        Dim multiPage As RadMultiPage = DirectCast(Me.NamingContainer.FindControl("rmpProject"), RadMultiPage)
        Dim templatePageView As RadPageView = multiPage.FindPageViewByID(pageViewId)
        If templatePageView Is Nothing Then
            templatePageView = New RadPageView()
            templatePageView.ID = pageViewId
            multiPage.PageViews.Add(templatePageView)
        End If
        templatePageView.Selected = True
    End Sub

    Private Sub UpdateNextPageView()
        Dim hfProjectId As HiddenField = DirectCast(Me.NamingContainer.FindControl("hfProjectId"), HiddenField)
        hfProjectId.Value = projectId
    End Sub
End Class
