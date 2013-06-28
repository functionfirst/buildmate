Imports System.Data.SqlClient

Partial Class subscription_cancel
    Inherits System.Web.UI.Page

    Protected Sub Page_Init(sender As Object, e As System.EventArgs) Handles Me.Init
        ' save the currently selected subscription type to the users profile
        Dim connString As String = System.Configuration.ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString
        Dim myConn As New SqlConnection(connString)
        Dim cmd As SqlCommand = New SqlCommand("UPDATE UserProfile SET subscriptionType = @subscriptionType WHERE userId = @userId", myConn)
        cmd.Parameters.AddWithValue("@userId", Session("userId"))
        cmd.Parameters.AddWithValue("@subscriptionType", 0)
        Try
            myConn.Open()
            cmd.ExecuteReader()

            ' redirect the user to paypal where they can continue with the subscription
            Response.Redirect("https://www.sandbox.paypal.com/webscr?cmd=_customer-billing-agreement&token=" & token)
        Catch ex As Exception
            Trace.Write(ex.ToString)
            myConn.Close()
        End Try
    End Sub
End Class
