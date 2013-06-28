Imports Telerik.Web.UI
Imports System.Data.SqlClient

Partial Class top_tasks
    Inherits System.Web.UI.Page

    '    protected void RadGrid1_PreRender(object sender, EventArgs e)  
    '    {  
    '        foreach (GridDataItem item in RadGrid1.MasterTableView.Items)  
    '        {  
    '            CheckBox chkbx1 = (CheckBox)item["CheckTemp"].FindControl("CheckBox1");  

    '            if (chkbx1.Checked)  
    '            {  
    '                item.Edit = true;  

    '            }  
    '        }  
    '}  

    Protected Sub rgTopTasks_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles rgTopTasks.PreRender
        For Each item As GridDataItem In rgTopTasks.MasterTableView.Items
            Dim id As Integer = CType(item("isEnabled").FindControl("hfID"), HiddenField).Value
            Dim chkbx1 As CheckBox = item("isEnabled").FindControl("CheckBox1")
            Dim setval = System.DBNull.Value

            ' update the task 
            Dim queryString As String = "UPDATE TaskData SET parentId = @parentId WHERE id = @id"
            Using conn As New SqlConnection(ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString)
                Dim command As New SqlCommand(queryString, conn)
                conn.Open()
                command.Parameters.Add("@id", Data.SqlDbType.Int).Value = id
                If chkbx1.Checked Then
                    ' null the parentid so we can see this task
                    command.Parameters.Add("@parentId", Data.SqlDbType.Int).Value = System.DBNull.Value
                Else
                    ' set parentid = 0 effectively hiding this task
                    command.Parameters.Add("@parentId", Data.SqlDbType.Int).Value = 0
                End If
                command.ExecuteNonQuery()
            End Using
        Next
    End Sub
End Class
