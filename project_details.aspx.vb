Imports PyramidReports
Imports Telerik.Web.UI
Imports System.Data.SqlClient
Imports System.Data
Imports Telerik.Reporting.Processing
Imports System.IO

Partial Class manager_Default
    Inherits MyBaseClass

    Dim isEditable As String

    Protected Sub checkReturnStartDate(ByVal sender As Object, ByVal args As ServerValidateEventArgs)
        args.IsValid = True

        Dim startDate As RadDatePicker = CType(FormView1.FindControl("rdpStartdate"), RadDatePicker)
        Dim returnDate As RadDateTimePicker = CType(FormView1.FindControl("rdtpReturnDate"), RadDateTimePicker)

        If IsDate(startDate.SelectedDate) Then
            If startDate.SelectedDate <= returnDate.SelectedDate Then
                args.IsValid = False
            End If
        End If
    End Sub

    Protected Sub checkReturnEndDate(ByVal sender As Object, ByVal args As ServerValidateEventArgs)
        args.IsValid = True

        Dim startDate As RadDatePicker = CType(FormView1.FindControl("rdpStartDate"), RadDatePicker)
        Dim endDate As RadDatePicker = CType(FormView1.FindControl("rdpCompletionDate"), RadDatePicker)
        Dim returnDate As RadDateTimePicker = CType(FormView1.FindControl("rdtpReturnDate"), RadDateTimePicker)
        Dim CustomValidator2 As CustomValidator = CType(FormView1.FindControl("CustomValidator2"), CustomValidator)

        ' check if enddate and return date are set
        If IsDate(returnDate.SelectedDate) And IsDate(endDate.SelectedDate) Then
            If endDate.SelectedDate <= returnDate.SelectedDate Then
                args.IsValid = False
                CustomValidator2.Text = "<small>Completion Date must be after your Return Date.</small>"
            End If
        End If

        ' check if startdate and enddate are set first
        If IsDate(startDate.SelectedDate) And IsDate(endDate.SelectedDate) Then
            If endDate.SelectedDate <= startDate.SelectedDate Then
                args.IsValid = False
                CustomValidator2.Text = "<small>Completion Date must be after your Start Date.</small>"
            End If
        End If
    End Sub

    Protected Sub archiveProject(ByVal archived As Boolean)
        Dim projectId = CType(Request.QueryString("pid"), Integer)
        Dim connString As String = System.Configuration.ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString
        Dim sql As String = "UPDATE Project SET archived = '" & archived & "' WHERE id = " & projectId & " AND UserId = '" & Session("userId") & "'"

        Using conn As New SqlConnection(connString)
            Dim cmd As New SqlCommand(sql, conn)
            Try
                conn.Open()
                cmd.ExecuteScalar()

                If archived Then
                    showNotification("Archived", "The project was successfully archived")
                Else
                    showNotification("Unarchived", "You unarchived this project")
                End If
                toggleArchiveButtons(archived)
            Catch ex As Exception
                Trace.Write(ex.Message)
            End Try
        End Using
    End Sub

    Protected Sub toggleArchiveButtons(ByVal archived As Boolean)
        btnArchive.Visible = Not archived
        btnUnarchive.Visible = archived
    End Sub

    Protected Sub btnArchive_Click(sender As Object, e As EventArgs) Handles btnArchive.Click
        archiveProject(True)
    End Sub

    Protected Sub btnUnarchive_Click(sender As Object, e As EventArgs) Handles btnUnarchive.Click
        archiveProject(False)
    End Sub

    Protected Sub FormView1_DataBound(sender As Object, e As System.EventArgs) Handles FormView1.DataBound
        ' hide appropriate archive button
        Dim item = FormView1.DataItem
        If Not item Is Nothing Then
            Dim archived As Boolean = DirectCast(item, DataRowView)("archived")
            toggleArchiveButtons(archived)

            ' check if we need to hide the add build element button
            ' indicates we're now in a fully locked state for this project
            If Not FormView1.FindControl("hfIseditable") Is Nothing Then
                isEditable = CType(FormView1.FindControl("hfIsEditable"), HiddenField).Value
                'Dim addBuildElementLink = CType(FormView1.FindControl("addBuildElementLink"), HyperLink)
                If isEditable = 2 Then
                    addBuildElementLink.Visible = False
                Else
                    addBuildElementLink.Visible = True
                End If
            End If

            ' check if a project exists for this pid
            If FormView1.DataItemCount = 0 Then
                ' nothing found, display a notification to the user.
                NoProjectPanel.Visible = True
                completionBar.Visible = False
                FormView1.Visible = False
                BuildElementsPanel.Visible = False
                'pViewLogs.Visible = False
                fvProjectCosts.Visible = False
            Else
                ' project was found so make sure appropriate panels are visible
                NoProjectPanel.Visible = False
                completionBar.Visible = True
                FormView1.Visible = True
                BuildElementsPanel.Visible = True
                'pViewLogs.Visible = True
                fvProjectCosts.Visible = True
            End If
        End If
    End Sub

    Protected Sub cbIncVat_OnCheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim rntbVatRate As RadNumericTextBox = FormView1.FindControl("rntbVatRate")
        Dim cbIncVat As System.Web.UI.WebControls.CheckBox = sender
        If cbIncVat.Checked Then
            rntbVatRate.Enabled = True
        Else
            rntbVatRate.Enabled = False
        End If
    End Sub

    Protected Sub FormView1_ItemCommand(sender As Object, e As FormViewCommandEventArgs) Handles FormView1.ItemCommand
        hideNotification()
    End Sub

    Protected Sub FormView1_ItemUpdated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewUpdatedEventArgs) Handles FormView1.ItemUpdated
        fvProjectCosts.DataBind()
        fvElementDetailsInsert.DataBind()
        rgBuildElements.DataBind()

        showNotification("Project Updated", "Your changes were saved successfully")
    End Sub

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        Dim activeLink As HyperLink = CType(Master.FindControl("hlProjects"), HyperLink)
        activeLink.CssClass = "active"

        checkForProjectCopy()
    End Sub

    Protected Sub checkForProjectCopy()
        ' if action = copy then this was just copied from a project
        Dim action As String = Request.QueryString("action")

        If action = "copy" Then
            showNotification("Project Copied", "Your project was copied successfully")
        ElseIf action = "new" Then
            showNotification("Project Created", "Your project was created successfully")
        End If
    End Sub

    Protected Sub FormView1_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles FormView1.PreRender
        If IsNumeric(Request.QueryString("pid")) Then
            Dim hplabour As HyperLink = fvProjectCosts.Row.FindControl("hplabour")
            hplabour.NavigateUrl = String.Format(hplabour.NavigateUrl, Request.QueryString("pid"))

            Dim hpMaterial As HyperLink = fvProjectCosts.Row.FindControl("hpMaterial")
            hpMaterial.NavigateUrl = String.Format(hpMaterial.NavigateUrl, Request.QueryString("pid"))

            Dim hpPlantHire As HyperLink = fvProjectCosts.Row.FindControl("hpPlantHire")
            hpPlantHire.NavigateUrl = String.Format(hpPlantHire.NavigateUrl, Request.QueryString("pid"))

            Dim hpSundryItems As HyperLink = fvProjectCosts.Row.FindControl("hpSundryItems")
            hpSundryItems.NavigateUrl = String.Format(hpSundryItems.NavigateUrl, Request.QueryString("pid"))

            Dim hpAdhocCosts As HyperLink = fvProjectCosts.Row.FindControl("hpAdhocCosts")
            hpAdhocCosts.NavigateUrl = String.Format(hpAdhocCosts.NavigateUrl, Request.QueryString("pid"))
        End If
    End Sub

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Dim setVisible = False
        ' check if project id query exists
        If Request.QueryString("pid") > 0 Then
            setVisible = True
        End If

        NoProjectPanel.Visible = Not setVisible
        completionBar.Visible = setVisible
        FormView1.Visible = setVisible
        'pViewLogs.Visible = setVisible
        BuildElementsPanel.Visible = setVisible
        fvProjectCosts.Visible = setVisible

        checkPermissions()
    End Sub

    Protected Sub rgBuildElements_ItemDataBound(ByVal sender As Object, ByVal e As Telerik.Web.UI.GridItemEventArgs) Handles rgBuildElements.ItemDataBound
        ' hide delete option for build elements that were created before variation mode
        If (TypeOf (e.Item) Is GridDataItem) Then
            'Get the instance of the right type
            Dim dataBoundItem As GridDataItem = e.Item

            Dim statusID = dataBoundItem("projectStatusId").Text
            Dim spaceTypeId = dataBoundItem("spaceTypeId").Text
            Dim deleteColumn = dataBoundItem("DeleteColumn")
            Dim isLocked = dataBoundItem("isLocked").Text

            If isLocked Then
                deleteColumn.Visible = False
            End If
        End If
    End Sub

    Protected Sub AllSpacesDataSource_Deleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles AllSpacesDataSource.Deleted
        FormView1.DataBind()
        fvProjectCosts.DataBind()
    End Sub

    Protected Sub fvElementDetailsInsert_ItemInserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewInsertedEventArgs) Handles fvElementDetailsInsert.ItemInserted
        rgBuildElements.DataBind()
        fvProjectCosts.DataBind()
        fvElementDetailsInsert.DataBind()
        FormView1.DataBind()

        checkForFirstBuildElement()
    End Sub

    Protected Sub checkForFirstBuildElement()
        Dim d As DataView = AllSpacesDataSource.Select(DataSourceSelectArguments.Empty)
        If d.Count = 1 Then
            Response.Redirect(HttpContext.Current.Request.Url.AbsoluteUri)
        End If
    End Sub

    Protected Sub Page_LoadComplete(sender As Object, e As System.EventArgs) Handles Me.LoadComplete
        ' check for an action in the url
        If Request.QueryString("action") = "add_variation" Then
            Dim sb As StringBuilder = New StringBuilder
            sb.Append("<script type='text/javascript'>")
            sb.Append("$(document).ready(function(){$('.open_modal').click();});")
            sb.Append("</script>")
            ClientScript.RegisterClientScriptBlock(Me.GetType(), "urlaction", sb.ToString())
        End If
    End Sub

    Function FormatString(str As String) As String
        Return Regex.Replace(str, "\r", "<br />", RegexOptions.Multiline)
    End Function

    Protected Sub rgBuildElements_ItemDeleted(sender As Object, e As Telerik.Web.UI.GridDeletedEventArgs) Handles rgBuildElements.ItemDeleted
        FormView1.DataBind()
    End Sub

    Protected Sub rcbReportType_SelectedIndexChanged(sender As Object, e As EventArgs) Handles rcbReportType.SelectedIndexChanged
        toggleButtons()
    End Sub

    Protected Sub rblResourceType_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles rblResourceType.SelectedIndexChanged
        toggleButtons()
    End Sub

    Protected Sub toggleButtons()
        Select Case rcbReportType.SelectedValue
            Case 1
                ' resource break-down
                pTermsOfUse.Visible = False
                pResourceType.Visible = True
                btnExportToXLS.Visible = True
            Case 2
                ' resource break-down
                pTermsOfUse.Visible = False
                pResourceType.Visible = False
                btnExportToXLS.Visible = False
            Case 3
                ' acceptance form OR company with no VAT OR Inc. VAT OR Exc. VAT
                pTermsOfUse.Visible = True
                pResourceType.Visible = False
                btnExportToXLS.Visible = False
        End Select
    End Sub

    Protected Sub btnExportToXLS_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnExportToXLS.Click
        ExportToFile("xls")
    End Sub

    Protected Sub btnExportToPDF_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnExportToPDF.Click
        ExportToFile("pdf")
    End Sub

    Sub ExportToFile(ByVal reportFormat As String)
        Dim projectId As String = Request.QueryString("pid")
        Dim reportTypeId As String = rcbReportType.SelectedValue
        Dim reportTypeName As String = rcbReportType.SelectedItem.Text
        Dim resourceTypeId As String = rblResourceType.SelectedValue
        Dim termsId As String = rblTermsOfUse.SelectedValue

        Dim url As String = String.Format("document.aspx?pid={0}&type={1}&typeName={2}&resource={3}&format={4}&terms={5}",
                                          projectId,
                                          reportTypeId,
                                          reportTypeName,
                                          resourceTypeId,
                                          reportFormat,
                                          termsId)

        document.Attributes.Add("src", url)
    End Sub
End Class