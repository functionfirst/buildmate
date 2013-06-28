Imports Telerik.Web.UI
Imports System.Data
Imports System.Data.SqlClient

Partial Class manager_add_project
    Inherits System.Web.UI.Page

    Protected Sub rcbEstimateType_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles rcbEstimateType.DataBound
        ' add default option to estimate type
        If rcbEstimateType.Items.Count > 0 Then
            rcbEstimateType.Items.Insert(0, New RadComboBoxItem("Select an Estimate Type..", -1))
        End If
    End Sub

    Protected Sub rcbTitle_DataBound(ByVal sender As Object, ByVal e As System.EventArgs)
        ' add default option to estimate type
        Dim rcbTitle As RadComboBox = CType(sender, RadComboBox)
        If rcbTitle.Items.Count > 0 Then
            rcbTitle.Items.Insert(0, New RadComboBoxItem("Select a Title..", -1))
        End If
    End Sub

    Protected Sub rcbCustomer_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles rcbCustomer.DataBound
        ' add default option to customer
        If rcbCustomer.Items.Count > 0 Then
            rcbCustomer.Items.Insert(0, New RadComboBoxItem("Select a Customer..", -1))
        End If
    End Sub

    Protected Sub rcbEstimateType_SelectedIndexChanged(ByVal o As Object, ByVal e As Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs) Handles rcbEstimateType.SelectedIndexChanged
        If rcbEstimateType.SelectedIndex >= 1 Then
            rcbProjects.Enabled = True
        Else
            rcbProjects.Enabled = False
        End If
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

    Protected Sub OnClick_Validate()
        Page.Validate("projectGroup")
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

    Protected Sub CopyExistingProject(ByVal pid As Integer, ByVal npid As Integer)
        ' connect to the database
        Dim myConn As SqlConnection = New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString)
        myConn.Open()

        ' create commadn object
        Dim cmd As System.Data.SqlClient.SqlCommand = New System.Data.SqlClient.SqlCommand
        cmd.Connection = myConn
        cmd.CommandText = "copyBuildElementsToProject"
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@projectId", pid)
        cmd.Parameters.AddWithValue("@NewProjectId", npid)
        cmd.ExecuteNonQuery()

        Response.Redirect(String.Format("~/project_details.aspx?pid={0}&action=copy", npid))
    End Sub

    Protected Sub rcbProjects_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles rcbProjects.DataBound
        rcbProjects.Items.Insert(0, New RadComboBoxItem("Use Blank Project", -1))
    End Sub

    Protected Sub insertProjectDataSource_Inserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles insertProjectDataSource.Inserted
        Dim newProjectId As Integer = e.Command.Parameters("@newId").Value
        If rcbProjects.SelectedValue >= 1 And newProjectId >= 1 Then
            CopyExistingProject(rcbProjects.SelectedValue, newProjectId)
        Else
            Response.Redirect(String.Format("~/project_details.aspx?pid={0}&action=new", newProjectId))
        End If
    End Sub

    Protected Sub defaultCountry(ByVal sender As Object, ByVal e As System.EventArgs)
        ' default country to UK
        ' ?? possible to change this to default based on browser location
        Dim rcbCountry As RadComboBox = CType(sender, RadComboBox)
        rcbCountry.SelectedValue = 183
    End Sub

    Protected Sub insertCustomerDataSource_Inserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles insertCustomerDataSource.Inserted
        rcbCustomer.DataBind()
        Dim newId = e.Command.Parameters("@NewId").Value
        rcbCustomer.SelectedValue = newId
        rcbCustomer.SelectedIndex = rcbCustomer.FindItemIndexByValue(newId)
    End Sub

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        Dim activeLink As HyperLink = CType(Master.FindControl("hlProjects"), HyperLink)
        activeLink.CssClass = "active"
    End Sub

    Protected Sub fvCustomerInsert_ItemInserted(sender As Object, e As System.Web.UI.WebControls.FormViewInsertedEventArgs) Handles fvCustomerInsert.ItemInserted
        fvCustomerInsert.DataBind()
    End Sub
End Class