Imports System.Data.SqlClient

Partial Class unsubscribe_default
    Inherits MyBaseClass



    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        emailAddr.Text = Request.QueryString("email")
        checkToken()
    End Sub

    Protected Sub btnUnsubscribe_Click(sender As Object, e As EventArgs) Handles btnUnsubscribe.Click
        Dim unsubscribed As String = unsubscribe()

        If unsubscribed Then

            'showNotification("Unsubscribed", "You have successfully unsubscribed from Buildmate")
        Else
            'showNotification("Email Error", "Your email address was not recognised.", True)
        End If
    End Sub

    Private Function unsubscribe() As String
        Dim token As String = Request.QueryString("token")
        Dim email As String = emailAddr.Text

        If token IsNot Nothing And email IsNot Nothing Then
            Dim isTokenValid = validateToken(token, email)
            If isTokenValid Then
                ' Token is valid, continue with unsubscribe
                If disableNotifyByEmail(token, email) Then
                    ' Successfully turned off notifyByEmail for this User
                    pUnsubscribe.Visible = True
                Else
                    pFailed.Visible = True
                End If
            Else
                ' Token isn't valid, display an error message
                pInvalidToken.Visible = True
            End If
        End If
        Return False
    End Function

    Function disableNotifyByEmail(ByVal email As String, ByVal token As String) As Boolean
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
        Return False
    End Function

    Protected Sub checkToken()
        Dim token As String = Request.QueryString("token")
        Dim email As String = emailAddr.Text

        If token IsNot Nothing And email IsNot Nothing Then
            Dim isTokenValid = validateToken(token, email)
            If isTokenValid Then
                pUnsubscribe.Visible = True
            Else
                pInvalidToken.Visible = True
            End If
        End If
    End Sub

    Function validateToken(ByVal token As String, ByVal email As String) As Boolean
        ' Check if the Code already exists in the database
        Dim connString As String = System.Configuration.ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString
        Dim myConn As New SqlConnection(connString)
        Dim cmd As SqlCommand = New SqlCommand("SELECT token FROM Token WHERE token = @token and email = @email AND getdate() < DateAdd(day, 1, DateCreated)", myConn)
        cmd.Parameters.AddWithValue("@email", email)
        cmd.Parameters.AddWithValue("@token", token)

        Try
            myConn.Open()
            If cmd.ExecuteScalar IsNot Nothing Then
                ' Token exists
                Return True
                myConn.Close()
            End If
        Catch ex As Exception
            ' Do nothing
        End Try

        Return False
    End Function
End Class
