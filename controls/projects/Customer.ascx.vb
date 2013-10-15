Imports Telerik.Web.UI

Partial Class controls_projects_customer
    Inherits System.Web.UI.UserControl

    Dim customerId As String

    Protected Sub rcbTitle_DataBound(ByVal sender As Object, ByVal e As System.EventArgs)
        ' add default option to estimate type
        Dim rcbTitle As RadComboBox = CType(sender, RadComboBox)
        If rcbTitle.Items.Count > 0 Then
            rcbTitle.Items.Insert(0, New RadComboBoxItem("Select a Title..", -1))
        End If
    End Sub

    Protected Sub defaultCountry(ByVal sender As Object, ByVal e As System.EventArgs)
        ' default country to UK
        ' ?? possible to change this to default based on browser location
        Dim rcbCountry As RadComboBox = CType(sender, RadComboBox)
        rcbCountry.SelectedValue = 183
    End Sub

    Protected Sub ToggleRowSelection(ByVal sender As Object, ByVal e As EventArgs)
        CheckSelectedItem(sender)
        ToggleTemplateButton(sender)
    End Sub

    Private Sub CheckSelectedItem(ByVal sender As Object)
        customerId = 0
        TryCast(TryCast(sender, CheckBox).NamingContainer, GridItem).Selected = TryCast(sender, CheckBox).Checked

        For Each dataItem As GridDataItem In rgCustomers.Items
            TryCast(dataItem.FindControl("CheckBox1"), CheckBox).Checked = False
        Next

        For Each dataItem As GridDataItem In rgCustomers.SelectedItems


            TryCast(dataItem.FindControl("CheckBox1"), CheckBox).Checked = True
            customerId = dataItem.Item("id").Text.ToString()
            UpdateNextPageView()
        Next
    End Sub

    Private Sub ToggleTemplateButton(ByVal sender As Object)
        If TryCast(sender, CheckBox).Checked Then
            lbDetails.Text = "Use the selected Customer"
            lbDetails.Enabled = True
        Else
            lbDetails.Text = "You must select a Customer above"
            lbDetails.Enabled = False
        End If
    End Sub
    Protected Sub lbBack_Click(sender As Object, e As EventArgs) Handles lbBack.Click
        GoBack()
    End Sub

    Private Sub GoBack()
        Dim pEstimate As Panel = DirectCast(Me.NamingContainer.FindControl("pTemplate"), Panel)
        pEstimate.CssClass = "project-tab active"

        Dim pTemplate As Panel = DirectCast(Me.NamingContainer.FindControl("pCustomer"), Panel)
        pTemplate.CssClass = "project-tab"

        GoToPageView("rpvTemplate")
    End Sub

    Protected Sub lbDetails_Click(sender As Object, e As EventArgs) Handles lbDetails.Click
        GoToNextTab()
        GoToPageView("rpvDetails")
    End Sub

    Private Sub GoToNextTab()
        Dim pDetails As Panel = DirectCast(Me.NamingContainer.FindControl("pDetails"), Panel)
        pDetails.CssClass = "project-tab active"
    End Sub

    Private Sub GoToPageView(ByVal pageViewId As String)
        Dim multiPage As RadMultiPage = DirectCast(Me.NamingContainer.FindControl("rmpProject"), RadMultiPage)
        Dim templatePageView As RadPageView = multiPage.FindPageViewByID(pageViewId)
        'If templatePageView Is Nothing Then
        '    templatePageView = New RadPageView()
        '    templatePageView.ID = pageViewId
        '    multiPage.PageViews.Add(templatePageView)
        'End If
        templatePageView.Selected = True
    End Sub

    Private Sub UpdateNextPageView()
        Dim hfCustomerId As HiddenField = DirectCast(Me.NamingContainer.FindControl("hfCustomerId"), HiddenField)
        hfCustomerId.Value = customerId
    End Sub

    Protected Sub fvCustomerInsert_ItemInserted(sender As Object, e As FormViewInsertedEventArgs) Handles fvCustomerInsert.ItemInserted
        rgCustomers.DataBind()
    End Sub
End Class
