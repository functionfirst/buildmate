Imports Telerik.Web.UI
Imports System.Data.SqlClient
Imports System.Data

Partial Class controls_projects_Details
    Inherits System.Web.UI.UserControl

    Protected Sub OnClick_Validate()
        Page.Validate("projectGroup")
    End Sub

    Protected Sub lbBack_Click(sender As Object, e As EventArgs)
        GoBack()
    End Sub

    Private Sub GoBack()
        Dim pEstimate As Panel = DirectCast(Me.NamingContainer.FindControl("pCustomer"), Panel)
        pEstimate.CssClass = "project-tab active"

        Dim pDetails As Panel = DirectCast(Me.NamingContainer.FindControl("pDetails"), Panel)
        pDetails.CssClass = "project-tab"

        GoToPageView("rpvCustomer")
    End Sub

    Private Sub GoToPageView(ByVal pageViewId As String)
        Dim multiPage As RadMultiPage = DirectCast(Me.NamingContainer.FindControl("rmpProject"), RadMultiPage)
        Dim templatePageView As RadPageView = multiPage.FindPageViewByID(pageViewId)
        templatePageView.Selected = True
    End Sub

    Protected Sub OnSelectedDateChanged(ByVal sender As Object, ByVal e As Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs)
        Dim rdpStartDate As RadDatePicker = sender
        ' set the minimum end date to be equal to or more than the start date
        Dim rdpCompletionDate As RadDatePicker = CType(fvCreateProject.FindControl("rdpCompletionDate"), RadDatePicker)
        Dim CompareValidator1 As CompareValidator = CType(fvCreateProject.FindControl("CompareValidator1"), CompareValidator)

        If Not rdpCompletionDate Is Nothing Then
            rdpCompletionDate.MinDate = rdpStartDate.SelectedDate
            CompareValidator1.Enabled = True
        Else
            rdpCompletionDate.MinDate = Nothing
            CompareValidator1.Enabled = False
        End If
    End Sub

    Protected Sub fvCreateProject_ItemCreated(ByVal sender As Object, ByVal e As System.EventArgs) Handles fvCreateProject.ItemCreated
        If fvCreateProject.CurrentMode = FormViewMode.Insert Then
            ' set attributes to force popup calendar to open upwards
            Dim rdpStartDate As RadDatePicker = CType(fvCreateProject.FindControl("rdpStartDate"), RadDatePicker)
            rdpStartDate.DatePopupButton.Attributes.Add("onclick", "PopupAbove(event, '" + rdpStartDate.ClientID + "');return false;")

            Dim rdpCompletionDate As RadDatePicker = CType(fvCreateProject.FindControl("rdpCompletionDate"), RadDatePicker)
            rdpCompletionDate.DatePopupButton.Attributes.Add("onclick", "PopupAbove(event, '" + rdpCompletionDate.ClientID + "');return false;")

            Dim rdtpReturnDate As RadDatePicker = CType(fvCreateProject.FindControl("rdtpReturnDate"), RadDatePicker)
            rdtpReturnDate.DatePopupButton.Attributes.Add("onclick", "PopupAbove(event, '" + rdtpReturnDate.ClientID + "');return false;")
        End If
    End Sub

    Protected Sub insertProjectDataSource_Inserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles insertProjectDataSource.Inserted
        Dim projectId As HiddenField = DirectCast(Me.NamingContainer.FindControl("hfProjectId"), HiddenField)
        Dim newProjectId As Integer = e.Command.Parameters("@newId").Value
        If projectId.Value >= 1 Then
            CopyExistingProject(projectId.Value, newProjectId)
        Else
            Response.Redirect(String.Format("~/project_details.aspx?pid={0}&action=new", newProjectId))
        End If
    End Sub

    Protected Sub CopyExistingProject(ByVal pid As Integer, ByVal npid As Integer)
        ' connect to the database
        Dim myConn As SqlConnection = New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString)
        myConn.Open()

        ' create commadn object
        Dim cmd As System.Data.SqlClient.SqlCommand = New System.Data.SqlClient.SqlCommand
        cmd.Connection = myConn
        cmd.CommandText = "copyBuildElementsToProject"
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@Userid", Session("userid"))
        cmd.Parameters.AddWithValue("@projectId", pid)
        cmd.Parameters.AddWithValue("@NewProjectId", npid)
        cmd.ExecuteNonQuery()

        Response.Redirect(String.Format("~/project_details.aspx?pid={0}&action=copy", npid))
    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        getProfitOverhead()
    End Sub

    Protected Sub getProfitOverhead()
        Dim rntbOverhead As RadNumericTextBox = fvCreateProject.FindControl("rntbOverhead")
        Dim rntbProfit As RadNumericTextBox = fvCreateProject.FindControl("rntbProfit")

        Dim sqlSelectCommand As String = "SELECT defaultOverhead, defaultProfit FROM UserProfile WHERE userid = @userid;"
        Dim adapter As New SqlDataAdapter(sqlSelectCommand, System.Configuration.ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString)
        adapter.SelectCommand.Parameters.AddWithValue("@userid", Session("userId"))

        Dim dataTable As New DataTable
        adapter.Fill(dataTable)

        ' check item exists
        If dataTable.Rows.Count >= 1 Then
            rntbOverhead.Value = dataTable.Rows.Item(0)("defaultOverhead").ToString()
            rntbProfit.Value = dataTable.Rows.Item(0)("defaultprofit").ToString()
        End If
    End Sub
End Class
