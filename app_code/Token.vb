Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports System.Data

Namespace Buildmate
    Public Class Token
        Private _token As String
        Private _userid As String

        Property token As String
            Get
                Return _token
            End Get
            Set(ByVal value As String)
                _token = value
            End Set
        End Property

        Property userid As String
            Get
                Return _userid
            End Get
            Set(ByVal value As String)
                _userid = value
            End Set
        End Property

        Public Sub New()
            generateToken()
        End Sub

        ' generateToken
        Public Sub generateToken()
            ' Generating random code
            Dim s As String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabdcefghijklmnopqrstuvwxyz0123456789!£$%^&*"
            Dim r As New Random
            Dim sb As New StringBuilder
            For i As Integer = 1 To 12
                Dim idx As Integer = r.Next(0, 68)
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
            Dim cmd As SqlCommand = New SqlCommand("INSERT INTO Token (UserId, Token) VALUES(@userid, @token);", myConn)
            cmd.Parameters.AddWithValue("@userid", userid)
            cmd.Parameters.AddWithValue("@token", token)

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
            Dim cmd As SqlCommand = New SqlCommand("SELECT token FROM Token WHERE token = @token and UserId = @userid", myConn)
            cmd.Parameters.AddWithValue("@userid", userid)
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