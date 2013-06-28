Imports Telerik.Web.UI
Imports System.Data
Imports System.Data.SqlClient

Partial Class edit_notification
    Inherits System.Web.UI.Page

    Protected Sub btnSave_OnClick(sender As Object, e As System.EventArgs)
        Dim RichTextBox As TextBox = FormView1.FindControl("RichTextBox")
        Dim Label4 As Label = FormView1.FindControl("Label4")
        Label4.Text = RichTextBox.Text

        Dim connString As String = System.Configuration.ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString
        Dim myConn As New SqlConnection(connString)
        Dim cmd As SqlCommand = New SqlCommand("UPDATE Blogs SET article = '" + RichTextBox.Text + "' WHERE id = " + Request.QueryString("id"), myConn)

        Try
            myConn.Open()
            cmd.ExecuteReader()
            FormView1.DataBind()
        Catch ex As Exception
            Trace.Write(ex.ToString)
            myConn.Close()
        End Try
    End Sub
End Class
