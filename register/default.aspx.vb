Imports System.Data.SqlClient

Partial Class login
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        Response.Status = "301 Moved Permanently"
        Response.AddHeader("Location", "http://getbuildmate.com/signup/")
    End Sub
End Class