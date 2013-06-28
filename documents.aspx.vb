﻿Imports PyramidReports
Imports Telerik.Reporting.Processing
Imports System.IO
Imports Telerik.Web.UI
Imports System.Data.SqlClient
Imports System.Data
Imports System.Net.Mail

Partial Class manager_report
    Inherits System.Web.UI.Page

    Dim pid As Integer
    Dim resourceTypeId As Integer

    Protected Sub btnPreview_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnPreview.Click
        loadReport()
    End Sub

    Protected Sub loadReport()
        Select Case rcbReportType.SelectedValue
            Case 1
                ' Resource break-down
                ReportViewer1.Report = New SupplierResources
                Dim report1 As Telerik.Reporting.Report = ReportViewer1.Report
                report1.ReportParameters("pid").Value = rcbProject.SelectedValue
                report1.ReportParameters("resourceTypeId").Value = rblResourceType.SelectedValue
            Case 2
                ' Acceptance Form
                ReportViewer1.Report = New AcceptanceForm
                Dim report1 As Telerik.Reporting.Report = ReportViewer1.Report
                report1.ReportParameters("pid").Value = rcbProject.SelectedValue
            Case 3
                ' check if the current project should include VAT
                Dim incVat As Boolean = getIncludeVAT()

                If IsNumeric(Session("vatnumber")) Then
                    If incVat Then
                        ' Company inc VAT
                        ReportViewer1.Report = New NewCompanyIncVAT
                        Dim report1 As Telerik.Reporting.Report = ReportViewer1.Report
                        report1.ReportParameters("pid").Value = rcbProject.SelectedValue
                        report1.ReportParameters("TermsOfUse").Value = rblTermsOfUse.SelectedValue
                    Else
                        ' Company exc VAT
                        ReportViewer1.Report = New NewCompanyExcVAT
                        Dim report1 As Telerik.Reporting.Report = ReportViewer1.Report
                        report1.ReportParameters("pid").Value = rcbProject.SelectedValue
                        report1.ReportParameters("TermsOfUse").Value = rblTermsOfUse.SelectedValue
                    End If
                Else
                    If incVat Then
                        ' Soletrader including VAT
                        ReportViewer1.Report = New NewSoletraderIncVAT
                        Dim report1 As Telerik.Reporting.Report = ReportViewer1.Report
                        report1.ReportParameters("pid").Value = rcbProject.SelectedValue
                        report1.ReportParameters("TermsOfUse").Value = rblTermsOfUse.SelectedValue
                    Else
                        ' Company excluding VAT
                        ReportViewer1.Report = New NewSoletraderExcVAT
                        Dim report1 As Telerik.Reporting.Report = ReportViewer1.Report
                        report1.ReportParameters("pid").Value = rcbProject.SelectedValue
                        report1.ReportParameters("TermsOfUse").Value = rblTermsOfUse.SelectedValue
                    End If
                End If
        End Select

        ReportViewer1.Visible = True
    End Sub

    Sub renderAsFile(reportToExport As Telerik.Reporting.ReportObject, ByVal reportParameters As Telerik.Reporting.ReportParameterCollection, ByVal reportFormat As String)
        ' create report
        Dim reportProcessor As New ReportProcessor()
        Dim result As RenderingResult = reportProcessor.RenderReport(reportFormat, reportToExport, Nothing)
        Dim fileName As String = rcbProject.SelectedItem.Text + " - " + rcbReportType.SelectedItem.Text + "." + reportFormat

        Response.Clear()
        Response.ContentType = result.MimeType
        Response.Cache.SetCacheability(HttpCacheability.Private)
        Response.Expires = -1
        Response.Buffer = True
        Response.AddHeader("Content-Disposition", String.Format("{0};FileName=""{1}""", "attachment", fileName))
        Response.BinaryWrite(result.DocumentBytes)
        Response.End()
    End Sub

    Protected Sub rcbProject_DataBound(sender As Object, e As System.EventArgs) Handles rcbProject.DataBound
        rcbProject.Items.Insert(0, New RadComboBoxItem("Select a project...", 0))
    End Sub

    Protected Sub rcbProject_SelectedIndexChanged(o As Object, e As Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs) Handles rcbProject.SelectedIndexChanged
        If rcbProject.SelectedValue = 0 Then
            rcbReportType.Enabled = False
            rcbReportType.SelectedIndex = 0
        Else
            rcbReportType.Enabled = True
        End If

        ReportViewer1.Visible = False
        toggleButtons()
    End Sub

    Protected Function getIncludeVAT() As Boolean
        Dim sqlSelectCommand As String = "Select incVAT FROM Project WHERE id=@projectId"
        Dim adapter As New SqlDataAdapter(sqlSelectCommand, System.Configuration.ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString)
        adapter.SelectCommand.Parameters.AddWithValue("@projectId", rcbProject.SelectedValue)
        Dim dataTable As New DataTable
        adapter.Fill(dataTable)

        ' check item exists
        If dataTable.Rows.Count >= 1 Then
            Return Convert.ToBoolean(dataTable.Rows.Item(0)("incVat").ToString)
        End If

        Return False
    End Function

    Protected Sub rcbReportType_SelectedIndexChanged(o As Object, e As Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs) Handles rcbReportType.SelectedIndexChanged
        ReportViewer1.Visible = False

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

    Protected Sub toggleButtons()
        If rcbProject.SelectedValue = 0 Or rcbReportType.SelectedValue = 0 Then
            btnPreview.Enabled = False
            btnExportToXLS.Enabled = False
            btnExportToPDF.Enabled = False
            btnEmailToCustomer.Enabled = False
        Else
            btnPreview.Enabled = True
            btnExportToXLS.Enabled = True
            btnExportToPDF.Enabled = True
            btnEmailToCustomer.Enabled = True

            Select Case rcbReportType.SelectedValue
                Case 3, 4
                    pTermsOfUse.Visible = True
                Case Else
                    pTermsOfUse.Visible = False
            End Select
        End If
    End Sub

    Protected Sub rblTermsOfUse_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles rblTermsOfUse.SelectedIndexChanged
        ReportViewer1.Visible = False
        toggleButtons()
    End Sub

    Protected Sub rblResourceType_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles rblResourceType.SelectedIndexChanged
        ReportViewer1.Visible = False
        toggleButtons()
    End Sub

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        Dim activeLink As HyperLink = CType(Master.FindControl("hlDocuments"), HyperLink)
        activeLink.CssClass = "active"

        Dim ScriptManager1 As ScriptManager = Page.Master.FindControl("ScriptManager1")
        ScriptManager1.RegisterPostBackControl(btnExportToPDF)
        ScriptManager1.RegisterPostBackControl(btnExportToXLS)
    End Sub

    Protected Sub rcbProjectType_DataBound(sender As Object, e As System.EventArgs) Handles rcbProjectType.DataBound
        rcbProjectType.Items.Insert(0, New RadComboBoxItem("Select a project type...", 0))
    End Sub

    Protected Sub rcbProjectType_SelectedIndexChanged(o As Object, e As Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs) Handles rcbProjectType.SelectedIndexChanged
        If rcbProjectType.SelectedValue = 0 Then
            rcbProject.Enabled = False
            rcbProject.SelectedIndex = 0
            rcbReportType.SelectedIndex = 0
        Else
            rcbProject.Enabled = True
            rcbReportType.SelectedIndex = 0
            rcbReportType.Enabled = False
        End If

        ReportViewer1.Visible = False
    End Sub

    Protected Sub btnExportToXLS_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnExportToXLS.Click
        ExportToFile("xls")
    End Sub

    Protected Sub btnExportToPDF_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnExportToPDF.Click
        ExportToFile("pdf")
    End Sub

    Sub ExportToFile(ByVal reportFormat As String)
        Select Case rcbReportType.SelectedValue
            Case 1
                ' Resource break-down
                Dim reportToExport As PyramidReports.SupplierResources = New PyramidReports.SupplierResources

                Dim reportParameters As Telerik.Reporting.ReportParameterCollection = reportToExport.ReportParameters
                reportParameters("pid").Value = rcbProject.SelectedValue
                reportParameters("resourceTypeId").Value = rblResourceType.SelectedValue
                renderAsFile(reportToExport, reportParameters, reportFormat)
            Case 2
                ' Acceptance Form
                Dim reportToExport As PyramidReports.AcceptanceForm = New PyramidReports.AcceptanceForm

                Dim reportParameters As Telerik.Reporting.ReportParameterCollection = reportToExport.ReportParameters
                reportParameters("pid").Value = rcbProject.SelectedValue

                renderAsFile(reportToExport, reportParameters, reportFormat)
            Case 3
                ' check if the current project should include VAT
                Dim incVat As Boolean = getIncludeVAT()

                ' offer letter
                If IsNumeric(Session("vatnumber")) Then
                    If incVat Then
                        ' show including VAT
                        Dim reportToExport As PyramidReports.NewCompanyIncVAT = New PyramidReports.NewCompanyIncVAT
                        Dim reportParameters As Telerik.Reporting.ReportParameterCollection = reportToExport.ReportParameters
                        reportParameters("pid").Value = rcbProject.SelectedValue
                        reportParameters("TermsOfUse").Value = rblTermsOfUse.SelectedValue

                        renderAsFile(reportToExport, reportParameters, reportFormat)
                    Else
                        ' show excluding VAT
                        Dim reportToExport As PyramidReports.NewCompanyExcVAT = New PyramidReports.NewCompanyExcVAT
                        Dim reportParameters As Telerik.Reporting.ReportParameterCollection = reportToExport.ReportParameters
                        reportParameters("pid").Value = rcbProject.SelectedValue
                        reportParameters("TermsOfUse").Value = rblTermsOfUse.SelectedValue

                        renderAsFile(reportToExport, reportParameters, reportFormat)
                    End If
                Else
                    If incVat Then
                        Dim reportToExport As PyramidReports.NewSoletraderIncVAT = New PyramidReports.NewSoletraderIncVAT
                        Dim reportParameters As Telerik.Reporting.ReportParameterCollection = reportToExport.ReportParameters
                        reportParameters("pid").Value = rcbProject.SelectedValue
                        reportParameters("TermsOfUse").Value = rblTermsOfUse.SelectedValue

                        renderAsFile(reportToExport, reportParameters, reportFormat)
                    Else
                        Dim reportToExport As PyramidReports.NewSoletraderExcVAT = New PyramidReports.NewSoletraderExcVAT
                        Dim reportParameters As Telerik.Reporting.ReportParameterCollection = reportToExport.ReportParameters
                        reportParameters("pid").Value = rcbProject.SelectedValue
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

    Protected Sub btnEmailToCustomer_Click(sender As Object, e As System.EventArgs) Handles btnEmailToCustomer.Click
        ' send report to customer via email


        'Dim obj As System.Net.Mail.SmtpClient = New System.Net.Mail.SmtpClient
        'Dim Mailmsg As New System.Net.Mail.MailMessage
        'Mailmsg.To.Clear()
        'Mailmsg.To.Add(New System.Net.Mail.MailAddress("BuildMate<support@buildmateapp.com>"))
        'Mailmsg.From = New System.Net.Mail.MailAddress("support@buildmateapp.com")
        'Mailmsg.Subject = " 404 Error - BuildMate"
        'Mailmsg.IsBodyHtml = True
        'Mailmsg.Body = "Someone found a 404, here's the url: <a href='" + Request.Url.AbsoluteUri + "'>" + Request.Url.AbsoluteUri + "</a>"
        'Mailmsg.Attachments = 
        'obj.Send(Mailmsg)

        Dim report As PyramidReports.NewCompanyIncVAT = New PyramidReports.NewCompanyIncVAT
        MailReport(report, "alan@buildmateapp.com", "alan@buildmateapp.com", "Attached report", "my body content")
    End Sub


    Private Sub MailReport(report As Telerik.Reporting.Report, from As String, [to] As String, subject As String, body As String)
        Dim reportProcessor As ReportProcessor = New ReportProcessor
        Dim result As RenderingResult = reportProcessor.RenderReport("PDF", report, Nothing)

        Dim ms As New MemoryStream(result.DocumentBytes)
        ms.Position = 0

        Dim attachment As New Attachment(ms, report.Name + ".pdf")

        Dim obj As System.Net.Mail.SmtpClient = New System.Net.Mail.SmtpClient

        Dim Mailmsg As New System.Net.Mail.MailMessage
        Mailmsg.To.Clear()
        Mailmsg.To.Add(New System.Net.Mail.MailAddress("BuildMate<admin@buildmateapp.com>"))
        Mailmsg.From = New System.Net.Mail.MailAddress("admin@buildmateapp.com")
        Mailmsg.Subject = subject
        Mailmsg.IsBodyHtml = True
        Mailmsg.Body = body
        Mailmsg.Attachments.Add(attachment)
        obj.Send(Mailmsg)

        'Dim msg As New MailMessage(from, [to], subject, body)
        'msg.Attachments.Add(attachment)
        'Dim smtpHost As String = "255.255.255.0"
        'Dim client As New SmtpClient(smtpHost)
        'client.Send(msg)
    End Sub
End Class
