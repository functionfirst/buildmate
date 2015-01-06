Imports System.Data.SqlClient

Partial Class end_tutorial
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        completeTour()
    End Sub

    Sub completeTour()
        Try
            Dim connString As String = System.Configuration.ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString
            Dim myConn As New SqlConnection(connString)
            Dim myCmd As New SqlCommand("UPDATE UserProfile SET tourPhase=10 WHERE userId = @userId", myConn)
            myCmd.Parameters.AddWithValue("@UserId", Session("UserId"))

            myConn.Open()
            myCmd.ExecuteScalar()
            myConn.Close()

            myCmd.Dispose()
            myConn.Dispose()
            Response.Redirect("~/")
        Catch Ex As Exception
            'Response.End()
        End Try
    End Sub
End Class
