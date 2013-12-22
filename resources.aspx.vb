Partial Class resources
    Inherits System.Web.UI.Page

    Protected Sub allResourcesDataSource_Selected(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles allResourcesDataSource.Selected
        Dim itemCount As Integer = e.AffectedRows

        If itemCount >= 500 Then
            lblCount.Visible = True
        Else
            lblCount.Visible = False
        End If
    End Sub

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        Dim activeLink As HyperLink = CType(Master.FindControl("hlResources"), HyperLink)
        activeLink.CssClass = "active"
    End Sub

    Protected Sub rblResourceType_Init(sender As Object, e As System.EventArgs) Handles rblResourceType.Init
        rblResourceType.SelectedIndex = 0
    End Sub
End Class
