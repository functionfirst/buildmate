Imports System.Data.SqlClient

Partial Class toggle_help
    Inherits System.Web.UI.Page

    Private Sub form1_Load(sender As Object, e As EventArgs) Handles form1.Load
        Dim setHelp As Boolean = Request.QueryString("show")

        ' Update User profile information
        Dim connString As String = System.Configuration.ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString
        Dim myConn As New SqlConnection(connString)
        Dim cmd As SqlCommand = New SqlCommand("UPDATE UserProfile SET help = @state WHERE userid = @userId", myConn)
        cmd.Parameters.AddWithValue("@userId", Session("UserID"))
        cmd.Parameters.AddWithValue("@state", setHelp)

        Try
            Session("help") = setHelp
            myConn.Open()
            cmd.ExecuteScalar()

        Catch ex As Exception
            myConn.Close()
        End Try
    End Sub
End Class
