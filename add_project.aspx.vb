Imports Telerik.Web.UI
Imports System.Data
Imports System.Data.SqlClient

Partial Class manager_add_project
    Inherits MyBaseClass

    'Protected Sub rcbEstimateType_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles rcbEstimateType.DataBound
    '    ' add default option to estimate type
    '    If rcbEstimateType.Items.Count > 0 Then
    '        rcbEstimateType.Items.Insert(0, New RadComboBoxItem("Select an Estimate Type..", -1))
    '    End If
    'End Sub

    'Protected Sub rcbEstimateType_SelectedIndexChanged(ByVal o As Object, ByVal e As Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs) Handles rcbEstimateType.SelectedIndexChanged
    '    If rcbEstimateType.SelectedIndex >= 1 Then
    '        rcbProjects.Enabled = True
    '    Else
    '        rcbProjects.Enabled = False
    '    End If
    'End Sub

    'Protected Sub OnSelectedDateChanged(ByVal sender As Object, ByVal e As Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs)
    '    Dim rdpStartDate As RadDatePicker = sender
    '    ' set the minimum end date to be equal to or more than the start date
    '    Dim rdpCompletionDate As RadDatePicker = CType(fvCreateProject.FindControl("rdpCompletionDate"), RadDatePicker)
    '    Dim CompareValidator1 As CompareValidator = CType(fvCreateProject.FindControl("CompareValidator1"), CompareValidator)

    '    If Not rdpCompletionDate Is Nothing Then
    '        rdpCompletionDate.MinDate = rdpStartDate.SelectedDate
    '        CompareValidator1.Enabled = True
    '    Else
    '        rdpCompletionDate.MinDate = Nothing
    '        CompareValidator1.Enabled = False
    '    End If
    'End Sub

    'Protected Sub OnClick_Validate()
    '    Page.Validate("projectGroup")
    'End Sub

    'Protected Sub fvCreateProject_ItemCreated(ByVal sender As Object, ByVal e As System.EventArgs) Handles fvCreateProject.ItemCreated
    '    If fvCreateProject.CurrentMode = FormViewMode.Insert Then
    '        ' set attributes to force popup calendar to open upwards
    '        Dim rdpStartDate As RadDatePicker = CType(fvCreateProject.FindControl("rdpStartDate"), RadDatePicker)
    '        rdpStartDate.DatePopupButton.Attributes.Add("onclick", "PopupAbove(event, '" + rdpStartDate.ClientID + "');return false;")

    '        Dim rdpCompletionDate As RadDatePicker = CType(fvCreateProject.FindControl("rdpCompletionDate"), RadDatePicker)
    '        rdpCompletionDate.DatePopupButton.Attributes.Add("onclick", "PopupAbove(event, '" + rdpCompletionDate.ClientID + "');return false;")

    '        Dim rdtpReturnDate As RadDatePicker = CType(fvCreateProject.FindControl("rdtpReturnDate"), RadDatePicker)
    '        rdtpReturnDate.DatePopupButton.Attributes.Add("onclick", "PopupAbove(event, '" + rdtpReturnDate.ClientID + "');return false;")
    '    End If
    'End Sub

    'Protected Sub rcbProjects_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles rcbProjects.DataBound
    '    rcbProjects.Items.Insert(0, New RadComboBoxItem("Use Blank Project", -1))
    'End Sub

    'Protected Sub insertProjectDataSource_Inserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles insertProjectDataSource.Inserted
    '    Dim projectId = hfProjectId.Value
    '    Dim newProjectId As Integer = e.Command.Parameters("@newId").Value
    '    If projectId >= 1 Then
    '        CopyExistingProject(projectId, newProjectId)
    '    Else
    '        Response.Redirect(String.Format("~/project_details.aspx?pid={0}&action=new", newProjectId))
    '    End If
    'End Sub

    'Protected Sub CopyExistingProject(ByVal pid As Integer, ByVal npid As Integer)
    '    ' connect to the database
    '    Dim myConn As SqlConnection = New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString)
    '    myConn.Open()

    '    ' create commadn object
    '    Dim cmd As System.Data.SqlClient.SqlCommand = New System.Data.SqlClient.SqlCommand
    '    cmd.Connection = myConn
    '    cmd.CommandText = "copyBuildElementsToProject"
    '    cmd.CommandType = CommandType.StoredProcedure
    '    cmd.Parameters.AddWithValue("@projectId", pid)
    '    cmd.Parameters.AddWithValue("@NewProjectId", npid)
    '    cmd.ExecuteNonQuery()

    '    Response.Redirect(String.Format("~/project_details.aspx?pid={0}&action=copy", npid))
    'End Sub

    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Dim activeLink As HyperLink = CType(Master.FindControl("hlProjects"), HyperLink)
        activeLink.CssClass = "active"

        'If Not Page.IsPostBack Then
        '    AddTab("Estimate", True)

        '    Dim pageView As New RadPageView()
        '    pageView.ID = "Estimate"
        '    rmpProject.PageViews.Add(pageView)

        '    AddTab("Template", False)
        '    AddTab("Customer", False)
        '    AddTab("Details", False)
        'End If
    End Sub

    'Private Sub AddTab(ByVal tabName As String, ByVal enabled As Boolean)
    '    Dim tab As New RadTab(tabName)
    '    tab.Enabled = enabled

    '    Select Case tab.Text
    '        Case "Estimate"
    '            tab.Text = "1. Estimate Type"
    '            Exit Select
    '        Case "Template"
    '            tab.Text = "1a. Template"
    '            Exit Select
    '        Case "Customer"
    '            tab.Text = "2. Customer"
    '            Exit Select
    '        Case "Details"
    '            tab.Text = "3. Project Details"
    '            Exit Select
    '        Case Else
    '            Exit Select
    '    End Select
    'End Sub

    'Protected Sub rmpProject_PageViewCreated(sender As Object, e As RadMultiPageEventArgs) Handles rmpProject.PageViewCreated
    '    Dim pageViewContents As Control = LoadControl("/controls/projects/" & e.PageView.ID & ".ascx")
    '    pageViewContents.ID = e.PageView.ID & "UserControl"

    '    e.PageView.Controls.Add(pageViewContents)
    'End Sub
End Class