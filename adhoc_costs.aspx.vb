Imports Telerik.Web.UI

Partial Class manager_resource_costs
    Inherits System.Web.UI.Page

    Private total As Decimal

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        HyperLink1.NavigateUrl = String.Format(HyperLink1.NavigateUrl, Request.QueryString("pid"))
    End Sub

    Protected Sub rgAdhocCosts_ItemDataBound(ByVal sender As Object, ByVal e As Telerik.Web.UI.GridItemEventArgs) Handles rgAdhocCosts.ItemDataBound
        Select Case e.Item.ItemType
            Case GridItemType.Item, GridItemType.AlternatingItem
                ' Get the total for each row and get a total to be used later.
                Dim dataItem As GridDataItem = CType(e.Item, GridDataItem)
                ' Row total
                Dim rowTotal As String = dataItem("total").Text
                If IsNumeric(rowTotal) Then total += rowTotal
            Case GridItemType.Footer
                If total > 0 Then
                    rgAdhocCosts.MasterTableView.ShowFooter = True

                    ' Calculate the grand total and display this value in the footer
                    Dim footer As GridFooterItem = CType(e.Item, GridFooterItem)

                    footer("description").HorizontalAlign = HorizontalAlign.Right
                    footer("description").Controls.Add(New LiteralControl("Total:"))

                    footer("total").HorizontalAlign = HorizontalAlign.Right
                    Dim lbl As Label = New Label
                    lbl.Text = String.Format("{0:c}", total)
                    footer("total").Controls.Add(lbl)
                Else
                    rgAdhocCosts.MasterTableView.ShowFooter = False
                End If
        End Select
    End Sub
End Class
