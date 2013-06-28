Imports Telerik.Web.UI
Imports System.Data
Imports System.Data.SqlClient

Partial Class edit_task
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        hlAddTask.NavigateUrl = String.Format(hlAddTask.NavigateUrl, Request.QueryString("tid"))
    End Sub

    Protected Sub toggleHidden(sender As Object, e As System.EventArgs)
        Dim chk As CheckBox = sender
        Dim hfTaskId As HiddenField = chk.NamingContainer.FindControl("hfTaskId")
        Dim taskId As Integer = Convert.ToInt32(hfTaskId.Value)
        'If chk.Checked Then
        '    Trace.Write("Flag this as hidden")
        'Else
        '    Trace.Write("Flag this as unhidden")
        'End If
        toggleHidden(chk.Checked, taskId)
    End Sub

    Protected Sub toggleHidden(hidden As Boolean, taskId As Integer)
        ' create and execute sql command
        Dim dbCon As New SqlConnection(ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString)
        dbCon.Open()

        Dim cmd As New SqlCommand("UPDATE TaskData SET hidden = @hidden WHERE id = @id", dbCon)
        cmd.CommandType = CommandType.Text
        cmd.Parameters.AddWithValue("@id", taskId)
        cmd.Parameters.AddWithValue("@hidden", hidden)

        ' bind to data adapter
        Dim adapter As SqlDataAdapter = New SqlDataAdapter(cmd)
        Dim dt As DataTable = New DataTable
        adapter.Fill(dt)
        dbCon.Close()

        rgChildren.DataBind()
    End Sub

    Protected Sub rgChildren_ItemDataBound(sender As Object, e As Telerik.Web.UI.GridItemEventArgs) Handles rgChildren.ItemDataBound
        If TypeOf e.Item Is GridDataItem Then
            ' Get the total for each row and get a total to be used later.
            Dim item As GridDataItem = CType(e.Item, GridDataItem)
            Dim row As DataRowView = CType(item.DataItem, DataRowView)
            'Dim chk As CheckBox = item("hidden").Controls(0)
            Dim chk As CheckBox = item("hidden").FindControl("CheckBox1")
            Dim value As String = row("hidden").ToString()
            If value = "Yes" Or value = "1" Then
                chk.Checked = True
            Else
                chk.Checked = False
            End If

            ' Row total
            Dim isHidden As String = item("hidden").Text
            If isHidden = 1 Then
                item("taskName").CssClass = "hiddenTask"
            End If
            ' If IsNumeric(rowTotal) Then adhoctotal += rowTotal
        End If

        '    If (e.Item Is GridDataItem) Then
        '{ 
        '    GridDataItem item = (GridDataItem)e.Item; 
        '    DataRowView row = (DataRowView)item.DataItem; 
        '    CheckBox chk = (CheckBox)item["Discontinued"].Controls[0]; 
        '    string value = row["Discontinued"].ToString(); 

        '    if (value == "Yes" || (value == "1")) 
        '        chk.Checked = true; 
        '        Else
        '        chk.Checked = false; 
        '} 
    End Sub
End Class
