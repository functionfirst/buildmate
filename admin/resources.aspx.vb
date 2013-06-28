Partial Class edit_resource
    Inherits System.Web.UI.Page

    Protected Sub btnApplyFilter_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnApplyFilter.Click
        '    allResourceDataSource.DataBind()
    End Sub

    Protected Sub allResourceDataSource_Selected(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles allResourceDataSource.Selected
        Dim itemCount As Integer = e.AffectedRows

        If itemCount >= 1000 Then
            lblCount.Visible = True
        Else
            lblCount.Visible = False
        End If
    End Sub
End Class