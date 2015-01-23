Imports System.Data.SqlClient

Partial Class login
    Inherits MyBaseClass

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim isTokenValid = validateToken()
        If isTokenValid Then
            pReset.Visible = True
        Else
            pInvalidToken.Visible = True
        End If
    End Sub

    Function validateToken() As Boolean
        Return True
    End Function

    Protected Sub btnReset_Click(sender As Object, e As EventArgs) Handles btnReset.Click
        If Page.IsValid Then
            Dim username As String = Request.QueryString("email")
            ' reset password
            Dim u As MembershipUser = Membership.GetUser(username)
            u.ChangePassword(u.ResetPassword(), rtbPassword.Text)

            pReset.Visible = False
            pConfirmed.Visible = True
        End If
    End Sub
End Class