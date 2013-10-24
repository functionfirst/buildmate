Imports Telerik.Reporting.Processing
Imports System.Data.SqlClient
Imports System.Data
Imports BMDocument


Partial Class document
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim document As BMDocument = New BMDocument
        document.Id = Request.QueryString("pid")
        document.Name = getProjectName(document.Id)
        document.ReportType = Request.QueryString("type")
        document.ReportName = Request.QueryString("typename")
        document.ResourceType = Request.QueryString("resource")
        document.Format = Request.QueryString("format")
        document.Terms = Request.QueryString("terms")
        document.VAT = getIncludeVAT(document.Id)

        ExportToFile(document)
    End Sub

    Protected Function getProjectName(ByVal projectId As Integer) As String
        Dim sqlSelectCommand As String = "Select projectName FROM Project WHERE id=@projectId"
        Dim adapter As New SqlDataAdapter(sqlSelectCommand, System.Configuration.ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString)
        adapter.SelectCommand.Parameters.AddWithValue("@projectId", projectId)
        Dim dataTable As New DataTable
        adapter.Fill(dataTable)

        ' check item exists
        If dataTable.Rows.Count >= 1 Then
            Return dataTable.Rows.Item(0)("projectName").ToString
        End If

        Return False
    End Function

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

    Sub ExportToFile(ByVal document As BMDocument)
        Dim reportToExport As Telerik.Reporting.Report = New PyramidReports.SupplierResources

        Select Case document.ReportType
            Case 1
                ' Resource break-down
                reportToExport = New PyramidReports.SupplierResources
                reportToExport.ReportParameters("resourceTypeId").Value = document.ResourceType
            Case 2
                ' Acceptance Form
                reportToExport = New PyramidReports.AcceptanceForm
                reportToExport.ReportParameters("pid").Value = document.Id
            Case 3
                ' offer letter
                If IsNumeric(Session("vatnumber")) Then
                    If document.VAT Then
                        ' show including VAT
                        reportToExport = New PyramidReports.NewCompanyIncVAT
                    Else
                        ' show excluding VAT
                        reportToExport = New PyramidReports.NewCompanyExcVAT
                    End If
                Else
                    If document.VAT Then
                        reportToExport = New PyramidReports.NewSoletraderIncVAT
                    Else
                        reportToExport = New PyramidReports.NewSoletraderExcVAT
                    End If
                End If

                reportToExport.ReportParameters("TermsOfUse").Value = document.Terms
        End Select
        Trace.Write("foo")
        reportToExport.ReportParameters("pid").Value = document.Id

        Dim filename As String = String.Format("{0} - {1}.{2}", document.Name, document.ReportName, document.Format)
        renderAsFile(reportToExport, document.Format, filename)
    End Sub


    Sub renderAsFile(reportToExport As Telerik.Reporting.Report, ByVal reportFormat As String, ByVal filename As String)

        ' create report
        Dim reportProcessor As New ReportProcessor()
        Dim instanceReportSource As New Telerik.Reporting.InstanceReportSource()
        instanceReportSource.ReportDocument = reportToExport
        Dim result As RenderingResult = reportProcessor.RenderReport(reportFormat, instanceReportSource, Nothing)

        Response.Clear()
        Response.ContentType = result.MimeType
        Response.Cache.SetCacheability(HttpCacheability.Private)
        Response.Expires = -1
        Response.Buffer = True
        Response.AddHeader("Content-Disposition", String.Format("{0};FileName=""{1}""", "attachment", filename))
        Response.BinaryWrite(result.DocumentBytes)
        Response.End()
    End Sub

End Class
