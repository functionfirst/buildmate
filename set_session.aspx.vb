
Partial Class set_session
    Inherits System.Web.UI.Page

    Protected Sub btnSet_Click(sender As Object, e As System.EventArgs) Handles btnSet.Click
        Session("CustomerID") = RadTextBox1.Text
    End Sub
End Class
