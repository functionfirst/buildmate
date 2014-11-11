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
            generate()
        End Sub

        ' generateToken
        Public Sub generate()
            ' Generating random code
            Dim rf_code As Random = New Random()
            token = rf_code.Next(999999, 1000000).ToString()
            check()
            update()
        End Sub

        'updateUserToken
        Protected Sub update()
            ' Update notifydate and add new subscription token for this user
            Dim connString As String = System.Configuration.ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString
            Dim myConn As New SqlConnection(connString)
            Dim cmd As SqlCommand = New SqlCommand("UPDATE UserProfile SET notifyDate = GETDATE(), token = @token WHERE userId = @userId", myConn)
            cmd.Parameters.AddWithValue("@userid", userid)
            cmd.Parameters.AddWithValue("@token", token)

            Try
                myConn.Open()
                cmd.ExecuteScalar()

            Catch ex As Exception
                'Trace.Write(ex.ToString)
            Finally
                If myConn.State = ConnectionState.Open Then
                    myConn.Close()
                End If
            End Try
        End Sub

        ' CheckGeneratedCode
        Public Sub check()
            ' Check if the Code already exists in the database
            Dim connString As String = System.Configuration.ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString
            Dim myConn As New SqlConnection(connString)
            Dim cmd As SqlCommand = New SqlCommand("SELECT token FROM UserProfile WHERE token = @token", myConn)
            cmd.Parameters.AddWithValue("@token", token)

            Try
                myConn.Open()
                If cmd.ExecuteScalar IsNot Nothing Then
                    Dim rs_code As New Random()
                    token = rs_code.Next(99999, 1000000).ToString()
                    myConn.Close()
                End If

            Catch ex As Exception
                'Trace.Write(ex.ToString)
            Finally
                If myConn.State = ConnectionState.Open Then
                    myConn.Close()
                End If
            End Try
        End Sub
    End Class
End Namespace