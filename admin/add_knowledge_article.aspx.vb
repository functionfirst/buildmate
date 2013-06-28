Partial Class edit_knowledge_article
    Inherits System.Web.UI.Page

    Protected Sub knowledgeBaseDataSource_Inserted(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles knowledgeBaseDataSource.Inserted
        Response.Redirect("~/admin/knowledge_base.aspx")
    End Sub
End Class
