Partial Class manager_Default
    Inherits MyBaseClass

    Protected Sub rbTickets_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles rbTickets.SelectedIndexChanged
        setTicketFilter()
    End Sub

    Protected Sub setTicketFilter()
        Select Case rbTickets.SelectedIndex
            Case 0
                ticketsDataSource.FilterExpression = "isLocked <> 1"
            Case 1
                ticketsDataSource.FilterExpression = "isLocked = 1"
            Case 2
                ticketsDataSource.FilterExpression = ""
        End Select
    End Sub

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        Dim activeLink As HyperLink = CType(Master.FindControl("hlSupport"), HyperLink)
        activeLink.CssClass = "active"
    End Sub
End Class
