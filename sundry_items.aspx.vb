Imports Telerik.Web.UI

Partial Class manager_resource_costs
    Inherits System.Web.UI.Page

    Private total As Decimal

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        HyperLink1.NavigateUrl = String.Format(HyperLink1.NavigateUrl, Request.QueryString("pid"))
    End Sub

    Protected Sub rgSpaces_ItemDataBound(ByVal sender As Object, ByVal e As Telerik.Web.UI.GridItemEventArgs) Handles rgSpaces.ItemDataBound
        Select Case e.Item.ItemType
            Case GridItemType.Item, GridItemType.AlternatingItem
                ' Get the total for each row and get a total to be used later.
                Dim dataItem As GridDataItem = CType(e.Item, GridDataItem)
                ' Row total
                Dim rowTotal As String = dataItem("buildCost").Text
                If IsNumeric(rowTotal) Then total += rowTotal
            Case GridItemType.Footer
                If total > 0 Then
                    rgSpaces.MasterTableView.ShowFooter = True

                    ' Calculate the grand total and display this value in the footer
                    Dim footer As GridFooterItem = CType(e.Item, GridFooterItem)

                    footer("subcontractType").HorizontalAlign = HorizontalAlign.Center
                    footer("subcontractType").Controls.Add(New LiteralControl("Total:"))

                    footer("buildCost").HorizontalAlign = HorizontalAlign.Right
                    Dim lbl As Label = New Label
                    lbl.Text = String.Format("{0:c}", total)
                    footer("buildCost").Controls.Add(lbl)
                Else
                    rgSpaces.MasterTableView.ShowFooter = False
                End If
        End Select
    End Sub
End Class
