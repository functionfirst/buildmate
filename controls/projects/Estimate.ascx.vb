Imports Telerik.Web.UI

Partial Class controls_projects_Estimate
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
        Dim templatePageView As RadPageView = multiPage.FindPageViewByID("rpvTemplate")
        templatePageView.Selected = True
    End Sub

    Private Sub UpdateNextPageView()
        Dim hfEstimateType As HiddenField = DirectCast(Me.NamingContainer.FindControl("hfEstimateType"), HiddenField)
        hfEstimateType.Value = rblEstimateType.SelectedValue
    End Sub

    Protected Sub rblEstimateType_SelectedIndexChanged(sender As Object, e As EventArgs) Handles rblEstimateType.SelectedIndexChanged
        resetSelectedProject()
    End Sub

    Private Sub resetSelectedProject()
        Dim bmTemplate As UserControl = DirectCast(Me.NamingContainer.FindControl("bmTemplate"), UserControl)
        Dim rgProjects As RadGrid = DirectCast(bmTemplate.FindControl("rgProjects"), RadGrid)
        rgProjects.SelectedIndexes.Clear()
        Dim lbProject As LinkButton = DirectCast(bmTemplate.FindControl("lbProject"), LinkButton)
        lbProject.Enabled = False
        'rgProjects.Visible = True
        'rgProjects.DataBind()

        'Dim noProjectsExist As Panel = DirectCast(bmTemplate.FindControl("noProjectsExist"), Panel)
        'noProjectsExist.Visible = False
    End Sub
End Class