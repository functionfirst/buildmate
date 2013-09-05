Imports Telerik.Web.UI

Partial Class controls_projects_estimate
    Inherits System.Web.UI.UserControl

    Protected Sub rblEstimateType_Init(sender As Object, e As EventArgs) Handles rblEstimateType.Init
        rblEstimateType.SelectedIndex = 0
    End Sub

    Protected Sub lbTemplate_Click(sender As Object, e As EventArgs) Handles lbTemplate.Click
        GoToTab()
        GoToPageView()
        UpdateNextPageView()
    End Sub

    Private Sub GoToTab()
        Dim pEstimate As Panel = DirectCast(Me.NamingContainer.FindControl("pTemplate"), Panel)
        pEstimate.CssClass = "project-tab active"
    End Sub

    Private Sub GoToPageView()
        Dim multiPage As RadMultiPage = DirectCast(Me.NamingContainer.FindControl("rmpProject"), RadMultiPage)
        Dim templatePageView As RadPageView = multiPage.FindPageViewByID("Template")
        If templatePageView Is Nothing Then
            templatePageView = New RadPageView()
            templatePageView.ID = "Template"
            multiPage.PageViews.Add(templatePageView)
        End If
        templatePageView.Selected = True
    End Sub

    Private Sub UpdateNextPageView()
        Dim hfEstimateType As HiddenField = DirectCast(Me.NamingContainer.FindControl("hfEstimateType"), HiddenField)
        hfEstimateType.Value = rblEstimateType.SelectedValue
    End Sub
End Class
