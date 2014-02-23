Imports System.Data.SqlClient

Partial Class unsubscribe_default
    Inherits MyBaseClass

    Private Function unsubscribe() As String
        Dim token As String = Request.QueryString("token")
        Dim email As String = emailAddr.Text

        If token IsNot Nothing And email IsNot Nothing Then
            ' Unsubscribe from the daily digest
            Dim connString As String = System.Configuration.ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString
            Dim myConn As New SqlConnection(connString)
            Dim cmd As SqlCommand = New SqlCommand("UPDATE UserProfile SET notifyByEmail = 0 WHERE token=@token AND email=@email ", myConn)
            cmd.Parameters.AddWithValue("token", token)
            cmd.Parameters.AddWithValue("email", email)

            Try
                myConn.Open()
                Return cmd.ExecuteNonQuery()

            Catch ex As Exception
                Trace.Write(ex.ToString)
                myConn.Close()
            End Try
        End If
        Return False
    End Function

    Protected Sub btnUnsubscribe_Click(sender As Object, e As EventArgs) Handles btnUnsubscribe.Click
        Dim unsubscribed As String = unsubscribe()

        If unsubscribed Then
            showNotification("Unsubscribed", "You have successfully unsubscribed from Buildmate")
        Else
            showNotification("Email Error", "Your email address was not recognised.", True)
        End If
    End Sub
End Class
