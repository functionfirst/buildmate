Partial Class add_resource
    Inherits System.Web.UI.Page

    Protected Sub resourceDataSource_Inserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles resourceDataSource.Inserted
        Response.Redirect("~/admin/resources.aspx")
    End Sub
End Class
