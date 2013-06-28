Partial Class add_task
    Inherits System.Web.UI.Page

    Protected Sub taskDetailsDataSource_Inserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles taskDetailsDataSource.Inserted
        Response.Redirect(String.Format("~/admin/edit_task.aspx?tid={0}", Request.QueryString("pid")))
    End Sub
End Class
