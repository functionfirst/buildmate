Imports Telerik.Web.UI
Imports System.Data
Imports System.Data.SqlClient

Partial Class manager_add_project
    Inherits MyBaseClass

    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Dim activeLink As HyperLink = CType(Master.FindControl("hlProjects"), HyperLink)
        activeLink.CssClass = "active"
    End Sub
End Class