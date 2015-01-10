Imports System.Data
Imports Telerik.Web.UI
Imports System.Data.SqlClient

Partial Class manager_build_element_details
    Inherits MyBaseClass

    Dim isLocked As Boolean = False

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        ' check subscription date and calculate access permissions
        Dim subscriptionDate = Session("subscriptionDate")
        'Dim paypalPayerId = Session("paypalPayerId").ToString
        Dim dateDiff As TimeSpan = DateTime.Today - Convert.ToDateTime(subscriptionDate)
        Dim duration As String = dateDiff.TotalDays.ToString

        If duration >= 1 Then
            ' user had a subscription but now expired so just limit their account
            'Session("limitedAccount") = True
            pLimitedTasks.Visible = True
            pTasks.Visible = False
        Else
            ' subscription is valid
            'Session("limitedAccount") = False
            pLimitedTasks.Visible = False
            pTasks.Visible = True
        End If
    End Sub

    Protected Sub rntbCompletion_OnTextChanged(ByVal sender As Object, ByVal e As EventArgs)
        Dim lblCompletion As Label = fvElementDetails.FindControl("lblCompletion")
        lblCompletion.Visible = True
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        hlBack.NavigateUrl = String.Format(hlBack.NavigateUrl, Request.QueryString("pid"))
        isLocked = checkLockState()

        ' output message about lock state
        If isLocked Then
            panelIsLocked.Visible = True
            hlAddTask.Visible = False
        Else
            panelIsLocked.Visible = False
            hlAddTask.Visible = True
        End If

        Dim activeLink As HyperLink = CType(Master.FindControl("hlProjects"), HyperLink)
        activeLink.CssClass = "active"
    End Sub

    Protected Sub hlAddTask_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim hlAddTask As HyperLink = CType(sender, HyperLink)
        hlAddTask.NavigateUrl = String.Format(hlAddTask.NavigateUrl, Request.QueryString("pid"), Request.QueryString("rid"))
    End Sub

    Protected Function checkLockState() As Boolean
        Dim returnVal As Boolean
        Dim dvSql As DataView = DirectCast(elementDataSource.Select(DataSourceSelectArguments.Empty), DataView)
        For Each drvSql As DataRowView In dvSql
            returnVal = Convert.ToBoolean(drvSql("isLocked"))
        Next

        Return returnVal
    End Function

    Protected Sub rgCurrentTasks_ItemDeleted(ByVal source As Object, ByVal e As Telerik.Web.UI.GridDeletedEventArgs) Handles rgCurrentTasks.ItemDeleted
        fvElementDetails.DataBind()
    End Sub

    Protected Sub rgCurrentTasks_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles rgCurrentTasks.PreRender
        ' hide delete action if build element is locked
        If isLocked Then
            rgCurrentTasks.MasterTableView.Columns(2).Visible = False
        End If
    End Sub

    Protected Sub fvElementDetails_ItemCommand(sender As Object, e As FormViewCommandEventArgs) Handles fvElementDetails.ItemCommand
        hideNotification()
    End Sub

    Protected Sub fvElementDetails_ItemUpdated(sender As Object, e As System.Web.UI.WebControls.FormViewUpdatedEventArgs) Handles fvElementDetails.ItemUpdated
        showNotification("Build Element Updated", "Your changes were saved successfully")
        completionBar.DataBind()
    End Sub
End Class
