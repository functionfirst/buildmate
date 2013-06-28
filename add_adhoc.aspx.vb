
Partial Class manager_adhoc
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        hlBack.NavigateUrl = String.Format(hlBack.NavigateUrl, Request.QueryString("pid"))
        hlBack2.NavigateUrl = String.Format(hlBack2.NavigateUrl, Request.QueryString("pid"), Request.QueryString("rid"))
        hlBack3.NavigateUrl = String.Format(hlBack3.NavigateUrl, Request.QueryString("pid"), Request.QueryString("rid"), Request.QueryString("tid"))
    End Sub

    Protected Sub additionsDataSource_Inserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles additionsDataSource.Inserted
        Response.Redirect(hlBack3.NavigateUrl)
    End Sub
End Class
