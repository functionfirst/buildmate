Partial Class add_notification
    Inherits System.Web.UI.Page

    Protected Sub notificationDataSource_Inserted(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles notificationDataSource.Inserted
        Response.Redirect("~/admin/notification.aspx")
    End Sub
End Class
