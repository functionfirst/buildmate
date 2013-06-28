Imports System.Data.SqlClient

Partial Class login
    Inherits System.Web.UI.Page

    Protected Sub PasswordRecovery2_VerifyingUser(sender As Object, e As System.Web.UI.WebControls.LoginCancelEventArgs) Handles PasswordRecovery2.VerifyingUser
        Dim username As String = PasswordRecovery2.UserName

        Dim connString As String = System.Configuration.ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString
        Dim sql As String = "aspnet_Membership_UnlockUser"

        Trace.Write(username)

        Using conn As New SqlConnection(connString)
            Dim cmd As New SqlCommand(sql, conn)
            cmd.CommandType = Data.CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@ApplicationName", "/")
            cmd.Parameters.AddWithValue("@UserName", username)
            Try
                conn.Open()
                cmd.ExecuteScalar()

            Catch ex As Exception
                Trace.Write(ex.Message)
            End Try
        End Using
    End Sub
End Class