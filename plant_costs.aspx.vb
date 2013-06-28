
Partial Class manager_resource_costs
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        HyperLink1.NavigateUrl = String.Format(HyperLink1.NavigateUrl, Request.QueryString("pid"))
    End Sub

    Dim grandtotal As Decimal = 0

    Protected Sub Repeater1_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles Repeater1.ItemDataBound
        If e.Item.ItemType = ListItemType.Header Then
            grandtotal = 0
        ElseIf e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Then
            grandtotal += e.Item.DataItem("projectTotalCost")
        ElseIf e.Item.ItemType = ListItemType.Footer Then
            Dim lblGrandTotal As Label = e.Item.FindControl("lblGrandTotal")
            lblGrandTotal.Text = String.Format("{0:C2}", grandtotal)
        End If
    End Sub

    Protected Function checkWaste(incWaste As Boolean, projectWaste As Double, wastePercent As String) As String
        If incWaste Then
            Return String.Format("{0:C2}", projectWaste) + " (" + String.Format("{0}%", wastePercent) + ")"
        Else
            Return String.Format("<strong title='Waste is inclusive for this Resource' style='color: #090'>n/a ({0}%)</strong>", wastePercent)
        End If
    End Function
End Class
