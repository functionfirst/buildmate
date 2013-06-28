Imports System.Data.SqlClient

Partial Class login
    Inherits System.Web.UI.Page

    Protected Sub Login1_LoginError(sender As Object, e As System.EventArgs) Handles Login1.LoginError
        Dim userInfo As MembershipUser = Membership.GetUser(Login1.UserName)

        If Not userInfo Is Nothing Then
            If userInfo.IsLockedOut Then
                Login1.FailureText = "You failed to login correctly too many times, please <a href='/forgot_password/'>recover your password</a> to continue."
            End If
        End If
    End Sub
End Class