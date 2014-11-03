Imports System.Data.SqlClient
Imports Telerik.Web.UI
Imports System.Data

Partial Class manager_default
    Inherits MyBaseClass

    Private total As Decimal
    Private totalValue As Decimal

    Protected Sub rgStatistics_ItemDataBound(ByVal sender As Object, ByVal e As Telerik.Web.UI.GridItemEventArgs) Handles rgStatistics.ItemDataBound
        Select Case e.Item.ItemType
            Case GridItemType.Item, GridItemType.AlternatingItem
                ' Get the total for each row and get a total to be used later.
                Dim dataItem As GridDataItem = CType(e.Item, GridDataItem)
                Dim rowTotal As String = dataItem("totalCount").Text
                Dim rowTotalValue As String = dataItem("totalValue").Text
                If IsNumeric(rowTotal) Then total += rowTotal
                If IsNumeric(rowTotalValue) Then totalValue += rowTotalValue
            Case GridItemType.Footer
                ' Calculate the grand total and display this value in the footer
                Dim footer As GridFooterItem = CType(e.Item, GridFooterItem)

                ' project label
                footer("status").Controls.Add(New LiteralControl("Total Projects"))

                ' project total
                footer("totalCount").HorizontalAlign = HorizontalAlign.Center
                Dim lbl As Label = New Label
                lbl.Text = String.Format("{0:N0}", total)
                footer("totalCount").Controls.Add(lbl)

                ' project total value
                footer("totalValue").HorizontalAlign = HorizontalAlign.Right
                Dim lbl2 As Label = New Label
                lbl2.Text = String.Format("{0:c}", totalValue)
                footer("totalValue").Controls.Add(lbl2)
        End Select
    End Sub

    Protected Sub rgOverdueProjects_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles rgOverdueProjects.DataBound
        ' check for overdue projects.
        ' only display grid when there are overdue projects
        ' Dim pOverdueTenders As Panel = Me.Parent.FindControl("pOverdueTenders")
        Dim count As Integer = rgOverdueProjects.Items.Count
        If count >= 1 Then
            pOverdueTenders.Visible = True
        Else
            pOverdueTenders.Visible = False
        End If
    End Sub

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        Dim activeLink As HyperLink = CType(Master.FindControl("hlHome"), HyperLink)
        activeLink.CssClass = "active"
    End Sub
End Class

