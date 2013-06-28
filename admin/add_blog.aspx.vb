Partial Class add_blog
    Inherits System.Web.UI.Page

    Protected Sub blogDataSource_Inserted(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles blogDataSource.Inserted
        Response.Redirect("~/admin/blog.aspx")
    End Sub
End Class
