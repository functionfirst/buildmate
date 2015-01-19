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

    Protected Sub rtbResourceName_Init(sender As Object, e As EventArgs) Handles rtbResourceName.Init
        rtbResourceName.Text = Session("resourceKeywordSearch")
    End Sub

    Protected Sub rtbResourceName_TextChanged(sender As Object, e As EventArgs) Handles rtbResourceName.TextChanged
        Session("resourceKeywordSearch") = rtbResourceName.Text
    End Sub

    Protected Sub rcbResourceType_Init(sender As Object, e As EventArgs) Handles rcbResourceType.Init
        rcbResourceType.SelectedIndex = Session("resourceTypeSelected")
    End Sub

    Protected Sub rcbResourceType_SelectedIndexChanged(sender As Object, e As EventArgs) Handles rcbResourceType.SelectedIndexChanged
        Session("resourceTypeSelected") = rcbResourceType.SelectedIndex
    End Sub
End Class