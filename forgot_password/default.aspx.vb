﻿Imports System.Data.SqlClient
Imports Buildmate
Imports System.Net.Mail

Partial Class login
    Inherits MyBaseClass

    Dim mailRegister As New Buildmate.MailRegister

    Protected Sub btnRecover_Click(sender As Object, e As EventArgs) Handles btnRecover.Click
        resetPassword(email.Text)
    End Sub

    Sub resetPassword(ByVal email As String)
        ' check if account exists
        Try
            Dim accountExists As String = checkAccount(email)
            If accountExists Then
                ' Account exists, unlock it just in case it was locked
                unlockAccount(email)
                sendResetEmail(email)

                pReset.Visible = False
                pConfirmed.Visible = True
            Else
                ' Account doesn't exist
                pReset.Visible = False
                pUnconfirmed.Visible = True
            End If
        Catch ex As Exception
            Trace.Write(ex.InnerException.ToString)
            Trace.Write(ex.Message)
        End Try
    End Sub

    Function checkAccount(ByVal email As String) As String
        Dim connString As String = System.Configuration.ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString
        Dim myConn As New SqlConnection(connString)
        Dim cmd As SqlCommand = New SqlCommand("SELECT username FROM aspnet_users WHERE username = @email", myConn)
        cmd.Parameters.AddWithValue("@email", email)
        Dim reader As SqlDataReader

        Try
            myConn.Open()
            reader = cmd.ExecuteReader

            If reader.HasRows Then
                Return True
            End If
        Catch ex As Exception
            ' Do nothing
            Trace.Write(ex.InnerException.ToString)
            Trace.Write(ex.Message)
        End Try
        Return False
    End Function

    Sub unlockAccount(ByVal email As String)
        Dim connString As String = System.Configuration.ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString
        Dim sql As String = "aspnet_Membership_UnlockUser"

        Using conn As New SqlConnection(connString)
            Dim cmd As New SqlCommand(sql, conn)
            cmd.CommandType = Data.CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@ApplicationName", "/")
            cmd.Parameters.AddWithValue("@UserName", email)
            Try
                conn.Open()
                cmd.ExecuteScalar()

            Catch ex As Exception
                ' do nothing
            End Try
        End Using
    End Sub

    Sub sendResetEmail(ByVal email As String)
        Dim domain As String = HttpContext.Current.Request.Url.Host
        Dim client_ip As String = Request.UserHostAddress()

        Dim token As New Token()
        token.email = email
        token.ipaddress = client_ip
        token.generateToken()

        mailRegister.resetPassword(email, token.token, domain)
    End Sub
End Class