Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports System.IO
Imports System.Threading


Partial Class non_web_import
    Inherits System.Web.UI.Page

    Protected Sub btnImportMaterials_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnImportMaterials.Click
        runImport()
    End Sub


    Protected Sub runImport()
        Dim filename As String = "labour.txt"
        Dim filetoread As String = Server.MapPath(filename)
        Dim filestream As StreamReader
        filestream = File.OpenText(filetoread)
        Response.Write("Beginning import: " & filename & "<br />")
        Response.Flush()

        Dim line As String = filestream.ReadLine
        Dim splitout As Array

        Dim resourceId As Integer = -1
        Dim supplierId As Integer = 1
        Dim catalogueId As Integer
        Dim counter As Integer = 0
        Dim lastResourceId As Integer = 0
        Dim lastResourceName As String = ""

        Do While Not line Is Nothing
            splitout = line.Split(vbTab)
            counter = counter + 1

            Dim resourceName As String
            Dim manufacturer As String
            Dim partId As String
            Dim resourceTypeId As String
            Dim categoryId As String
            Dim unitId As String
            Dim suffix As String
            Dim price As String
            Dim useage As String
            Dim waste As String

            resourceName = splitout(0)
            manufacturer = splitout(1)
            partId = splitout(2)
            resourceTypeId = splitout(3)
            categoryId = splitout(4)
            unitId = splitout(5)
            suffix = splitout(6)
            price = splitout(7)
            useage = splitout(8)
            waste = splitout(9)

            ' check resource exists
            If Len(resourceName) >= 1 And resourceName <> lastResourceName Then
                ' insert the new resource
                Try
                    Dim connString As String = System.Configuration.ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString
                    Dim myConn As New SqlConnection(connString)
                    Dim myCmd As New SqlCommand("INSERT INTO tblResources(resourceName, manufacturer, partId, resourceTypeId, categoryId, unitId, suffix, waste) VALUES (@resourceName, @manufacturer, @partId, @resourceTypeId, @categoryId, @unitId, @suffix, @waste); SELECT scope_identity() AS returnidentity", myConn)
                    myCmd.Parameters.AddWithValue("@resourceName", resourceName)
                    myCmd.Parameters.AddWithValue("@manufacturer", manufacturer)
                    myCmd.Parameters.AddWithValue("@partId", partId)
                    myCmd.Parameters.AddWithValue("@resourceTypeId", resourceTypeId)
                    myCmd.Parameters.AddWithValue("@categoryId", categoryId)
                    myCmd.Parameters.AddWithValue("@unitId", unitId)
                    myCmd.Parameters.AddWithValue("@waste", waste)
                    myCmd.Parameters.AddWithValue("@suffix", suffix)

                    myConn.Open()
                    resourceId = myCmd.ExecuteScalar()
                    lastResourceId = resourceId
                    lastResourceName = resourceName

                    myConn.Close()

                    myCmd.Dispose()
                    myConn.Dispose()

                    Response.Write(counter & ". " & resourceName & " <br />")
                    Response.Flush()

                Catch Ex As Exception
                    Trace.Write(Ex.Message)
                    Response.Write("<font color=""red"">" & vbCrLf)
                    Response.Write(resourceName & "<br />")
                    Response.Write(Ex.Message)
                    Response.Write("</font><br /><br />")
                    Response.End()
                    filestream.Close()

                End Try
            Else
                ' use the same resource
                resourceId = lastResourceId
            End If

            Dim prodCode As String

            ' check resource exists.
            If IsNumeric(resourceId) Then
                ' loop through each supplier
                prodCode = " "

                ' only insert records for unresourced (supplierId = 1)
                ' or for suppliers with existing product codes
                If supplierId = 1 Or Len(prodCode) > 1 Then
                    ' insert catalogue record
                    Try
                        Dim connString As String = System.Configuration.ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString
                        Dim myConn As New SqlConnection(connString)
                        Dim myCmd As New SqlCommand("INSERT INTO tblCatalogue(supplierId, resourceId) VALUES (@supplierId, @resourceId); SELECT scope_identity() AS returnidentity", myConn)
                        myCmd.Parameters.AddWithValue("@supplierId", supplierId)
                        myCmd.Parameters.AddWithValue("@resourceId", resourceId)

                        myConn.Open()
                        catalogueId = myCmd.ExecuteScalar()
                        myConn.Close()

                        myCmd.Dispose()
                        myConn.Dispose()
                        Response.Flush()
                    Catch Ex As Exception
                        Trace.Write(Ex.Message)
                        Response.Write("<font color=""#900"">" & vbCrLf)
                        Response.Write(resourceName & "<br />")
                        Response.Write(Ex.Message)
                        Response.Write("</font><br /><br />")
                        Response.Flush()
                    End Try


                    ' check useage exists.
                    If IsNumeric(catalogueId) And IsNumeric(supplierId) Then
                        ' insert catalogue useage
                        Try
                            Dim connString As String = System.Configuration.ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString
                            Dim myConn As New SqlConnection(connString)
                            Dim myCmd As New SqlCommand("INSERT INTO tblCatalogueUseage(catalogueId, useage, productCode, price, leadTime, discontinued, lastUpdated) VALUES (@catalogueId, @useage, @productCode, @price, 1, 0, getdate());", myConn)
                            myCmd.Parameters.AddWithValue("@catalogueId", catalogueId)
                            myCmd.Parameters.AddWithValue("@useage", useage)
                            myCmd.Parameters.AddWithValue("@productCode", prodCode)
                            myCmd.Parameters.AddWithValue("@price", price)

                            myConn.Open()
                            myCmd.ExecuteScalar()
                            myConn.Close()

                            myCmd.Dispose()
                            myConn.Dispose()
                        Catch Ex As Exception
                            Trace.Write(Ex.Message)
                            Response.Write("<font color=""red"">" & vbCrLf)
                            Response.Write(resourceName & "<br />")
                            Response.Write(Ex.Message)
                            Response.Write("</font><br /><br />")
                            Response.Flush()
                        End Try
                    End If

                End If

                ' Next
            End If



            line = filestream.ReadLine
        Loop

        filestream.Close()

        Response.Write("<h1>Import Complete: " & filename & "</h1>")
        Response.Flush()
    End Sub
End Class

