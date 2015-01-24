Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports System.Data

Namespace Buildmate
    Public Class Token
        Private _token As String
        Private _email As String
        Private _ipaddress As String

        Property token As String
            Get
                Return _token
            End Get
            Set(ByVal value As String)
                _token = value
            End Set
        End Property

        Property email As String
            Get
                Return _email
            End Get
            Set(ByVal value As String)
                _email = value
            End Set
        End Property

        Property ipaddress As String
            Get
                Return _ipaddress
            End Get
            Set(ByVal value As String)
                _ipaddress = value
            End Set
        End Property

        'Public Sub New()
        '    generateToken()
        'End Sub

        ' generateToken
        Public Sub generateToken()
            ' Generating random code
            Dim s As String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabdcefghijklmnopqrstuvwxyz0123456789!£$^*"
            Dim r As New Random
            Dim sb As New StringBuilder
            For i As Integer = 1 To 12
                Dim idx As Integer = r.Next(0, 66)
                sb.Append(s.Substring(idx, 1))
            Next
            token = sb.ToString()

            checkToken()
        End Sub

        'updateUserToken
        Protected Sub saveToken()
            ' Update notifydate and add new subscription token for this user
            Dim connString As String = System.Configuration.ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString
            Dim myConn As New SqlConnection(connString)
            Dim cmd As SqlCommand = New SqlCommand("DELETE token FROM Token WHERE email = @email; INSERT INTO Token (email, Token, IPAddress) VALUES(@email, @token, @ipaddress);", myConn)
            cmd.Parameters.AddWithValue("@email", email)
            cmd.Parameters.AddWithValue("@token", token)
            cmd.Parameters.AddWithValue("@ipaddress", ipaddress)

            Try
                myConn.Open()
                cmd.ExecuteScalar()

            Catch ex As Exception
                ' Do nothing
            Finally
                If myConn.State = ConnectionState.Open Then
                    myConn.Close()
                End If
            End Try
        End Sub

        ' CheckGeneratedCode
        Public Sub checkToken()
            ' Check if the Code already exists in the database
            Dim connString As String = System.Configuration.ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString
            Dim myConn As New SqlConnection(connString)
            Dim cmd As SqlCommand = New SqlCommand("SELECT token FROM Token WHERE token = @token and email = @email", myConn)
            cmd.Parameters.AddWithValue("@email", email)
            cmd.Parameters.AddWithValue("@token", token)

            Try
                myConn.Open()
                If cmd.ExecuteScalar IsNot Nothing Then
                    ' Token already exists so create a new one
                    generateToken()

                    myConn.Close()
                Else
                    ' Token doesn't exist so save it
                    saveToken()
                End If

            Catch ex As Exception
                ' Do nothing
            Finally
                If myConn.State = ConnectionState.Open Then
                    myConn.Close()
                End If
            End Try
        End Sub
    End Class
End Namespace