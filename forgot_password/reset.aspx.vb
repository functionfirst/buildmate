Imports System.Data.SqlClient
Imports System.Web.Mail

Partial Class login
    Inherits MyBaseClass

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim token As String = Request.QueryString("token")
        Dim email As String = Request.QueryString("email")
        Dim isTokenValid = validateToken(token, email)
        If isTokenValid Then
            pReset.Visible = True
        Else
            pInvalidToken.Visible = True
        End If
    End Sub

    Function validateToken(ByVal token As String, ByVal email As String) As Boolean
        ' Check if the Code already exists in the database
        Dim connString As String = System.Configuration.ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString
        Dim myConn As New SqlConnection(connString)
        Dim cmd As SqlCommand = New SqlCommand("SELECT token FROM Token WHERE token = @token and email = @email", myConn)
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

    Protected Sub btnReset_Click(sender As Object, e As EventArgs) Handles btnReset.Click
        If Page.IsValid Then
            Dim email As String = Request.QueryString("email")
            ' reset password
            Dim u As MembershipUser = Membership.GetUser(email)
            u.ChangePassword(u.ResetPassword(), rtbPassword.Text)

            pReset.Visible = False
            pConfirmed.Visible = True

            sendConfirmationEmail(email)
        End If
    End Sub

    Sub sendConfirmationEmail(ByVal email As String)
        Try
            Dim md As MailDefinition = New MailDefinition
            md.BodyFileName = "~/email_templates/ResetPassword.html"
            md.From = "support@buildmateapp.com"
            md.Subject = "[Buildmate] Password Reset "
            md.Priority = MailPriority.Normal
            md.IsBodyHtml = True
            Dim replacements As ListDictionary = New ListDictionary

            Dim fileMsg As System.Net.Mail.MailMessage
            fileMsg = md.CreateMailMessage(email, replacements, Me)
            Dim msg As System.Net.Mail.MailMessage = fileMsg
            Dim obj As System.Net.Mail.SmtpClient = New System.Net.Mail.SmtpClient
            obj.Send(msg)
        Catch ex As Exception
            ' Do nothing
        End Try
    End Sub
End Class