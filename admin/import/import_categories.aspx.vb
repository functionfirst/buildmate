Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports System.IO
Imports System.Threading


Partial Class non_web_import
    Inherits System.Web.UI.Page

    Protected Sub btnImportCategories_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnImportCategories.Click
        runImport()
    End Sub


    Protected Sub runImport()
        Dim filename As String = "categories.txt"
        Dim filetoread As String = Server.MapPath(filename)
        Dim filestream As StreamReader
        filestream = File.OpenText(filetoread)
        Response.Write("Beginning import: " & filename & "<br />")
        Response.Flush()

        Dim line As String = filestream.ReadLine
        Dim splitout As Array

        Dim resourceId As Integer = -1
        Dim supplierId As Integer = 1
        Dim counter As Integer = 0
        Dim lastResourceId As Integer = 0
        Dim lastResourceName As String = ""

        Do While Not line Is Nothing
            splitout = line.Split(vbTab)
            counter = counter + 1

            Dim categoryName As String
            Dim parentId As String

            categoryName = splitout(0)
            parentId = splitout(1)

            ' check resource task exists.
            Try
                Dim connString As String = System.Configuration.ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString
                Dim myConn As New SqlConnection(connString)
                Dim myCmd As New SqlCommand("INSERT INTO tblCategories(categoryName, catParent) VALUES (@categoryName, @parentId)", myConn)
                myCmd.Parameters.AddWithValue("@categoryName", categoryName)
                myCmd.Parameters.AddWithValue("@parentId", parentId)

                myConn.Open()
                resourceId = myCmd.ExecuteScalar()
                lastResourceId = resourceId

                myConn.Close()

                myCmd.Dispose()
                myConn.Dispose()

                Response.Write(counter & ". " & categoryName & " <br />")
                Response.Flush()

            Catch Ex As Exception
                Trace.Write(Ex.Message)
                Response.Write("<font color=""red"">" & vbCrLf)
                Response.Write(categoryName & "<br />")
                Response.Write(Ex.Message)
                Response.Write("</font><br /><br />")
                Response.End()
                filestream.Close()
            End Try
            line = filestream.ReadLine
        Loop

        filestream.Close()

        Response.Write("<h1>Import Complete: " & filename & "</h1>")
        Response.Flush()
    End Sub
End Class

