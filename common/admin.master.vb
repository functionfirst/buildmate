Imports Telerik.Web.UI

Partial Class Manager
    Inherits System.Web.UI.MasterPage

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Dim User As MembershipUser = Membership.GetUser()
        If Not IsNothing(User) Then
            Dim UserId As Object = User.ProviderUserKey.ToString
            Session("UserID") = UserId
        End If
    End Sub

End Class

