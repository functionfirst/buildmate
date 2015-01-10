Imports Telerik.Web.UI
Imports System.Data.SqlClient
Imports System.Data

Partial Class view_resource
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim projectId As String = Request.QueryString("pid")
        HyperLink1.NavigateUrl = String.Format(HyperLink1.NavigateUrl, projectId)

        Select Case Request.QueryString("type")
            Case 1
                hlResource.Text = "Labour Costs"
                hlResource.NavigateUrl = String.Format("labour_costs.aspx?pid={0}", projectId)

            Case 2
                hlResource.Text = "Material Costs"
                hlResource.NavigateUrl = String.Format("material_costs.aspx?pid={0}", projectId)

            Case 3
                hlResource.Text = "Plant Costs"
                hlResource.NavigateUrl = String.Format("plant_costs.aspx?pid={0}", projectId)
        End Select
    End Sub

    Protected Sub allResourcesDataSource_Selected(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles allResourcesDataSource.Selected
        Dim itemCount As Integer = e.AffectedRows

        If itemCount >= 1000 Then
            lblCount.Visible = True
        Else
            lblCount.Visible = False
        End If
    End Sub

    Protected Sub rgResources_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles rgResources.SelectedIndexChanged
        Dim dataItem As GridDataItem = rgResources.SelectedItems(0)
        If Not dataItem Is Nothing Then
            btnSwapResource.Enabled = True
        End If
    End Sub

    Protected Sub btnSwapResource_Click(sender As Object, e As System.EventArgs) Handles btnSwapResource.Click
        Dim resourceId As String = 0
        ' get selected resource id
        Dim dataItem As GridDataItem = rgResources.SelectedItems(0)
        If Not dataItem Is Nothing Then
            ' create and execute sql command
            Dim dbCon As New SqlConnection(ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString)
            dbCon.Open()

            Dim cmd As New SqlCommand("swapTaskResource", dbCon)
            cmd.CommandType = CommandType.StoredProcedure

            resourceId = dataItem("id").Text

            cmd.Parameters.AddWithValue("@userId", Session("userId"))
            cmd.Parameters.AddWithValue("@projectId", Request.QueryString("pid"))
            cmd.Parameters.AddWithValue("@oldResourceId", Request.QueryString("id"))
            cmd.Parameters.AddWithValue("@resourceId", resourceId)

            ' bind to data adapter
            Dim adapter As SqlDataAdapter = New SqlDataAdapter(cmd)
            Dim dt As DataTable = New DataTable
            adapter.Fill(dt)
            dbCon.Close()

            Response.Redirect(String.Format("material_costs.aspx?pid={0}&action=swapped", Request.QueryString("pid")))
        End If
    End Sub

    Protected Sub btnApplyFilter_Click(sender As Object, e As EventArgs) Handles btnApplyFilter.Click
        applyFilters()
    End Sub

    Private Sub applyFilters()
        If rtbResourceName.Text.Length > 0 Then
            rgResources.Visible = True
        Else
            rgResources.Visible = False
        End If
    End Sub

    Protected Sub rtbResourceName_TextChanged(sender As Object, e As EventArgs) Handles rtbResourceName.TextChanged
        applyFilters()
    End Sub
End Class
