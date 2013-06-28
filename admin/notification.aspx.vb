Imports Telerik.Web.UI

Partial Class notification_base
    Inherits System.Web.UI.Page


    Protected Sub setSearch()
        Dim keywords = rtbKeywords.Text
        Dim sql As String

        If keywords.Length > 0 Then
            sql = "SELECT Id, Title, Hidden, DateStart " & _
            " FROM SystemNotification " & _
            " WHERE (Title LIKE '%%%" & keywords & "%%%' " & _
            " OR Abstract LIKE '%%%" & keywords & "%%%') "
        Else
            sql = "SELECT Id, Title, Hidden, DateStart " & _
            "FROM SystemNotification "
        End If

        notificationDataSource.SelectCommand = sql

        notificationDataSource.DataBind()
    End Sub

    Protected Sub btnApplyFilter_Click(sender As Object, e As System.EventArgs) Handles btnApplyFilter.Click
        setSearch()
    End Sub

    Protected Sub rtbKeywords_TextChanged(sender As Object, e As System.EventArgs) Handles rtbKeywords.TextChanged
        setSearch()
    End Sub

End Class
