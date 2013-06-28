Partial Class add_catalogue
    Inherits System.Web.UI.Page

    Protected Sub catalogueDS_Inserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles catalogueDS.Inserted
        Response.Redirect(String.Format("~/admin/edit_resource.aspx?rid={0}", Request.QueryString("rid")))
    End Sub
End Class
