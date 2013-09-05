Imports PyramidReports
Imports Telerik.Web.UI
Imports System.Data.SqlClient
Imports System.Data
Imports Telerik.Reporting.Processing

Partial Class manager_Default
    Inherits MyBaseClass

    Dim isEditable As String
    Dim projectName As String

    Protected Sub logChange(ByVal sender As Object, ByVal e As System.EventArgs)
        ' log change made to the project status
        Dim connString As String = System.Configuration.ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString

        Dim userId As String = Session("userId")
        Dim projectId As String = Request("pid")
        Dim rcbStatus As RadComboBox = CType(sender, RadComboBox)
        Dim note As String = "Changed status to " & rcbStatus.Text
        Dim sql As String = "INSERT INTO ProjectLog (userId, projectId, note, date) VALUES('" & userId & "', " & projectId & ", '" & note & "', getdate())"

        Using conn As New SqlConnection(connString)
            Dim cmd As New SqlCommand(sql, conn)
            Try
                conn.Open()
                cmd.ExecuteScalar()
            Catch ex As Exception
                Trace.Write(ex.Message)
            End Try
        End Using

        'Dim lblStatus = CType(FormView1.FindControl("lblStatus"), Panel)
        Dim updateButton = CType(FormView1.FindControl("updateButton"), Button)


        Dim hiddenStatusId As Integer = CType(FormView1.FindControl("hiddenStatusId"), HiddenField).Value

        '' check for status change that will lock down to variations only
        'If (hiddenStatusId <= 2 And rcbStatus.SelectedValue <= 2) Or (hiddenStatusId >= 3 And rcbStatus.SelectedValue >= 3) Then
        '    ' no change to status
        '    lblStatus.Visible = False
        '    updateButton.OnClientClick = ""
        'ElseIf (hiddenStatusId <= 2 And rcbStatus.SelectedValue >= 3) Or (hiddenStatusId >= 3 And rcbStatus.SelectedValue <= 2) Then
        '    ' changing status from normal to protected state
        '    lblStatus.Visible = True
        '    updateButton.OnClientClick = "if(!confirm('Click okay to move this project forward and only allow Variations from this point.')){return false;};"
        'End If

        ' check for status change that will lock down to variations only
        If (hiddenStatusId <= 2 And rcbStatus.SelectedValue >= 3) Then
            'updateButton.OnClientClick = "return showLockConfirmation()"

            Dim sb As StringBuilder = New StringBuilder
            sb.Append("<script type='text/javascript'>")
            sb.Append("$(document).ready(function(){showVariationMode(); alert('test');});")
            sb.Append("</script>")
            ClientScript.RegisterClientScriptBlock(Me.GetType(), "showvarmode", sb.ToString())
        Else
            updateButton.OnClientClick = ""
        End If
    End Sub

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

    Protected Sub setProjectName()
        Dim rowView As DataRowView = CType(FormView1.DataItem, DataRowView)
        projectName = rowView("projectName").ToString()
    End Sub

    Protected Sub FormView1_DataBound(sender As Object, e As System.EventArgs) Handles FormView1.DataBound
        'Dim rowView As DataRowView = CType(FormView1.DataItem, DataRowView)
        'projectName = rowView("projectName").ToString()
        setProjectName()

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

        Dim ScriptManager1 As ScriptManager = Page.Master.FindControl("ScriptManager1")
        ScriptManager1.RegisterPostBackControl(btnExportToPDF)
        ScriptManager1.RegisterPostBackControl(btnExportToXLS)
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
    End Sub

    'Protected Sub lbRefreshResources_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbRefreshResources.Click
    '    ' resynchronise prices and useage for all resources
    '    Dim connString As String = System.Configuration.ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString
    '    Dim sql As String = "modifyResourceStack"

    '    Using conn As New SqlConnection(connString)
    '        Dim cmd As New SqlCommand(sql, conn)
    '        cmd.CommandType = Data.CommandType.StoredProcedure
    '        cmd.Parameters.AddWithValue("@userId", Session("userId"))
    '        cmd.Parameters.AddWithValue("@projectId", Request("pid"))
    '        cmd.Parameters.AddWithValue("@rid", "")
    '        cmd.Parameters.AddWithValue("@isEditable", isEditable)
    '        Try
    '            conn.Open()
    '            cmd.ExecuteScalar()

    '            'rgBuildElements.DataBind()
    '            'fvProjectCosts.DataBind()
    '        Catch ex As Exception
    '            Trace.Write(ex.Message)
    '        End Try
    '    End Using
    'End Sub

    'Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
    '    isEditable = CType(FormView1.FindControl("hfIsEditable"), HiddenField).Value
    'End Sub

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
        ' only show resource type for resource break-down
        Select Case rcbReportType.SelectedValue
            Case 1
                ' resource break-down
                pResourceType.Visible = True
            Case 2, 3, 4
                ' acceptance form OR company with no VAT OR Inc. VAT OR Exc. VAT
                pResourceType.Visible = False
        End Select

        toggleButtons()
    End Sub

    Protected Sub rblResourceType_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles rblResourceType.SelectedIndexChanged
        'ReportViewer1.Visible = False
        toggleButtons()
    End Sub

    'Protected Sub btnPreview_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnPreview.Click
    '    loadReport()
    'End Sub

    'Protected Sub loadReport()
    '    Dim projectId = Request.QueryString("pid")

    '    Select Case rcbReportType.SelectedValue
    '        Case 1
    '            ' Resource break-down
    '            ReportViewer1.Report = New SupplierResources
    '            Dim report1 As Telerik.Reporting.Report = ReportViewer1.Report
    '            report1.ReportParameters("pid").Value = projectId
    '            report1.ReportParameters("resourceTypeId").Value = rblResourceType.SelectedValue
    '        Case 2
    '            ' Acceptance Form
    '            ReportViewer1.Report = New AcceptanceForm
    '            Dim report1 As Telerik.Reporting.Report = ReportViewer1.Report
    '            report1.ReportParameters("pid").Value = projectId
    '        Case 3
    '            ' check if the current project should include VAT
    '            Dim incVat As Boolean = getIncludeVAT(projectId)

    '            If IsNumeric(Session("vatnumber")) Then
    '                If incVat Then
    '                    ' Company inc VAT
    '                    ReportViewer1.Report = New NewCompanyIncVAT
    '                    Dim report1 As Telerik.Reporting.Report = ReportViewer1.Report
    '                    report1.ReportParameters("pid").Value = projectId
    '                    report1.ReportParameters("TermsOfUse").Value = rblTermsOfUse.SelectedValue
    '                Else
    '                    ' Company exc VAT
    '                    ReportViewer1.Report = New NewCompanyExcVAT
    '                    Dim report1 As Telerik.Reporting.Report = ReportViewer1.Report
    '                    report1.ReportParameters("pid").Value = projectId
    '                    report1.ReportParameters("TermsOfUse").Value = rblTermsOfUse.SelectedValue
    '                End If
    '            Else
    '                If incVat Then
    '                    ' Soletrader including VAT
    '                    ReportViewer1.Report = New NewSoletraderIncVAT
    '                    Dim report1 As Telerik.Reporting.Report = ReportViewer1.Report
    '                    report1.ReportParameters("pid").Value = projectId
    '                    report1.ReportParameters("TermsOfUse").Value = rblTermsOfUse.SelectedValue
    '                Else
    '                    ' Company excluding VAT
    '                    ReportViewer1.Report = New NewSoletraderExcVAT
    '                    Dim report1 As Telerik.Reporting.Report = ReportViewer1.Report
    '                    report1.ReportParameters("pid").Value = projectId
    '                    report1.ReportParameters("TermsOfUse").Value = rblTermsOfUse.SelectedValue
    '                End If
    '            End If
    '    End Select

    '    ReportViewer1.Visible = True
    'End Sub

    Protected Function getIncludeVAT(ByVal projectId As Integer) As Boolean
        Dim sqlSelectCommand As String = "Select incVAT FROM Project WHERE id=@projectId"
        Dim adapter As New SqlDataAdapter(sqlSelectCommand, System.Configuration.ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString)
        adapter.SelectCommand.Parameters.AddWithValue("@projectId", projectId)
        Dim dataTable As New DataTable
        adapter.Fill(dataTable)

        ' check item exists
        If dataTable.Rows.Count >= 1 Then
            Return Convert.ToBoolean(dataTable.Rows.Item(0)("incVat").ToString)
        End If

        Return False
    End Function

    Protected Sub toggleButtons()
        'btnPreview.Enabled = True
        btnExportToXLS.Enabled = True
        btnExportToPDF.Enabled = True
        btnEmailToCustomer.Enabled = True

        Select Case rcbReportType.SelectedValue
            Case 3, 4
                pTermsOfUse.Visible = True
            Case Else
                pTermsOfUse.Visible = False
        End Select
    End Sub

    Protected Sub btnExportToXLS_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnExportToXLS.Click
        ExportToFile("xls")
    End Sub

    Protected Sub btnExportToPDF_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnExportToPDF.Click
        ExportToFile("pdf")
    End Sub

    Sub ExportToFile(ByVal reportFormat As String)
        Dim projectId = Request.QueryString("pid")

        Select Case rcbReportType.SelectedValue
            Case 1
                ' Resource break-down
                Dim reportToExport As PyramidReports.SupplierResources = New PyramidReports.SupplierResources

                Dim reportParameters As Telerik.Reporting.ReportParameterCollection = reportToExport.ReportParameters
                reportParameters("pid").Value = projectId
                reportParameters("resourceTypeId").Value = rblResourceType.SelectedValue
                renderAsFile(reportToExport, reportParameters, reportFormat)
            Case 2
                ' Acceptance Form
                Dim reportToExport As PyramidReports.AcceptanceForm = New PyramidReports.AcceptanceForm

                Dim reportParameters As Telerik.Reporting.ReportParameterCollection = reportToExport.ReportParameters
                reportParameters("pid").Value = projectId

                renderAsFile(reportToExport, reportParameters, reportFormat)
            Case 3
                ' check if the current project should include VAT
                Dim incVat As Boolean = getIncludeVAT(projectId)

                ' offer letter
                If IsNumeric(Session("vatnumber")) Then
                    If incVat Then
                        ' show including VAT
                        Dim reportToExport As PyramidReports.NewCompanyIncVAT = New PyramidReports.NewCompanyIncVAT
                        Dim reportParameters As Telerik.Reporting.ReportParameterCollection = reportToExport.ReportParameters
                        reportParameters("pid").Value = projectId
                        reportParameters("TermsOfUse").Value = rblTermsOfUse.SelectedValue

                        renderAsFile(reportToExport, reportParameters, reportFormat)
                    Else
                        ' show excluding VAT
                        Dim reportToExport As PyramidReports.NewCompanyExcVAT = New PyramidReports.NewCompanyExcVAT
                        Dim reportParameters As Telerik.Reporting.ReportParameterCollection = reportToExport.ReportParameters
                        reportParameters("pid").Value = projectId
                        reportParameters("TermsOfUse").Value = rblTermsOfUse.SelectedValue

                        renderAsFile(reportToExport, reportParameters, reportFormat)
                    End If
                Else
                    If incVat Then
                        Dim reportToExport As PyramidReports.NewSoletraderIncVAT = New PyramidReports.NewSoletraderIncVAT
                        Dim reportParameters As Telerik.Reporting.ReportParameterCollection = reportToExport.ReportParameters
                        reportParameters("pid").Value = projectId
                        reportParameters("TermsOfUse").Value = rblTermsOfUse.SelectedValue

                        renderAsFile(reportToExport, reportParameters, reportFormat)
                    Else
                        Dim reportToExport As PyramidReports.NewSoletraderExcVAT = New PyramidReports.NewSoletraderExcVAT
                        Dim reportParameters As Telerik.Reporting.ReportParameterCollection = reportToExport.ReportParameters
                        reportParameters("pid").Value = projectId
                        reportParameters("TermsOfUse").Value = rblTermsOfUse.SelectedValue

                        renderAsFile(reportToExport, reportParameters, reportFormat)

                    End If
                End If
                'Case 4
                '    ' New Company inc VAT
                '    Dim reportToExport As PyramidReports.NewCompanyIncVAT = New PyramidReports.NewCompanyIncVAT

                '    Dim reportParameters As Telerik.Reporting.ReportParameterCollection = reportToExport.ReportParameters
                '    reportParameters("pid").Value = rcbProject.SelectedValue
                '    reportParameters("TermsOfUse").Value = rblTermsOfUse.SelectedValue

                '    renderAsFile(reportToExport, reportParameters, reportFormat)
        End Select
    End Sub

    Sub renderAsFile(reportToExport As Telerik.Reporting.ReportObject, ByVal reportParameters As Telerik.Reporting.ReportParameterCollection, ByVal reportFormat As String)
        ' create report
        Dim reportProcessor As New ReportProcessor()
        Dim result As RenderingResult = reportProcessor.RenderReport(reportFormat, reportToExport, Nothing)
        Dim fileName As String = projectName + " " + rcbReportType.SelectedItem.Text + "." + reportFormat

        Response.Clear()
        Response.ContentType = result.MimeType
        Response.Cache.SetCacheability(HttpCacheability.Private)
        Response.Expires = -1
        Response.Buffer = True
        Response.AddHeader("Content-Disposition", String.Format("{0};FileName=""{1}""", "attachment", fileName))
        Response.BinaryWrite(result.DocumentBytes)
        Response.End()
    End Sub
End Class