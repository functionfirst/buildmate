Imports System.Data
Imports Telerik.Web.UI
Imports System.Data.SqlClient

Partial Class manager_Default
    Inherits System.Web.UI.Page

    Private Function GetNodeData(ByVal sp As String, ByVal parentId As Integer) As DataTable
        ' get the roomId
        'Dim roomId As String = CType(Me.Parent.FindControl("roomId"), HiddenField).Value
        Dim roomId As String = 0

        ' create and execute sql command
        Dim dbCon As New SqlConnection(ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString)
        dbCon.Open()

        Dim cmd As New SqlCommand(sp, dbCon)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@roomId", roomId)
        cmd.Parameters.AddWithValue("@parentId", parentId)

        ' bind to data adapter
        Dim adapter As SqlDataAdapter = New SqlDataAdapter(cmd)
        Dim dt As DataTable = New DataTable
        adapter.Fill(dt)
        dbCon.Close()

        Return dt
    End Function

    Private Function getFilters() As String
        ' check for keyword filters
        Dim filters As String = ""
        'If Len(rtbFilters.Text) >= 1 Then
        '    Dim filter As String() = Split(rtbFilters.Text, " ")

        '    ' iterate through each keyword entered
        '    For Each keyword As String In filter
        '        ' check at least 1 keyword exists
        '        If Len(keyword) >= 1 Then
        '            ' check for first keyword
        '            If Len(filters) > 0 Then filters += " OR "

        '            ' construct filter string
        '            filters += String.Format("(taskName LIKE '%%%" & keyword & "%%%' OR keywords LIKE '%%%" & keyword & "%%%')")
        '        End If
        '    Next
        'End If

        '' check for existing tasks only
        'If cbExisting.Checked And Len(filters) > 0 Then
        '    filters = "(" & filters & ") AND taskId > 0"
        'ElseIf cbExisting.Checked Then
        '    filters = "taskId > 0"
        'End If

        Return filters
    End Function

    Private Sub LoadRootNodes()
        RadTreeView1.Nodes.Clear()
        Session.Remove("expandedNodes")

        ' get keyword filters
        Dim filters As String = getFilters()

        ' define the datatable
        Dim sp As String = "getTaskData"
        Dim data As DataTable = GetNodeData(sp, 0)
        Dim rows As DataRow() = data.Select(filters)

        If (CType(rows.Length, Integer) = 0) Then
            'results.Text = "No Tasks were found matching your keywords."
        Else
            'results.Text = ""
            For Each row As DataRow In rows
                Dim node As RadTreeNode = New RadTreeNode
                node.Text = HttpUtility.HtmlDecode(CType(row("taskName"), String))
                node.ToolTip = HttpUtility.HtmlDecode(CType(row("taskName"), String))
                node.Value = CType(row("id"), Integer).ToString
                node.ExpandMode = TreeNodeExpandMode.ServerSideCallBack
                node.NavigateUrl = String.Format("edit_task.aspx?tid={0}", CType(row("id"), Integer))

                RadTreeView1.Nodes.Add(node)
            Next
        End If
    End Sub

    Private Sub AddChildNodes(ByVal node As RadTreeNode)
        ' get keyword filters
        Dim filters As String = getFilters()

        ' defining the datatable
        Dim sp As String = "getChildTaskData"
        Dim data As DataTable = GetNodeData(sp, node.Value)
        Dim rows As DataRow() = data.Select(filters)

        For Each row As DataRow In rows
            Dim childNode As RadTreeNode = New RadTreeNode
            childNode.Text = HttpUtility.HtmlDecode(CType(row("taskName"), String))
            childNode.ToolTip = HttpUtility.HtmlDecode(CType(row("taskName"), String))
            childNode.Value = CType(row("id"), Integer).ToString
            childNode.NavigateUrl = String.Format("edit_task.aspx?tid={0}", CType(row("id"), Integer))

            If (CType(row("HasChildren"), Integer) > 0) Then
                childNode.ExpandMode = TreeNodeExpandMode.ServerSideCallBack
                'childNode.Checkable = False
            End If
            node.Nodes.Add(childNode)
        Next
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (Not Page.IsPostBack) Then
            initLoadRootNodes()
        End If
    End Sub

    Protected Sub initLoadRootNodes()
        LoadRootNodes()
        Session("treeViewState") = RadTreeView1.GetXml
    End Sub

    Protected Sub RadTreeView1_NodeClick(ByVal sender As Object, ByVal e As Telerik.Web.UI.RadTreeNodeEventArgs) Handles RadTreeView1.NodeClick
        Trace.Write("node clicked")
        Dim taskId = e.Node.Attributes("taskId")
        Trace.Write(taskId)

        If IsNumeric(taskId) Then
            Response.Redirect("~/edit_task.aspx?tid=" + taskId)
            Trace.Write("~/edit_task.aspx?tid=" + taskId)
        End If
    End Sub

    Protected Sub RadTreeView1_NodeExpand(ByVal sender As Object, ByVal e As RadTreeNodeEventArgs) Handles RadTreeView1.NodeExpand
        AddChildNodes(e.Node)

        Dim treeViewState As String = CType(Session("treeViewState"), String)
        Dim cachedTreeView As RadTreeView = New RadTreeView
        cachedTreeView.LoadXmlString(treeViewState)

        'it is important that the nodes have unique values so that they can be added to the cached treeview
        Dim cachedNodeClicked As RadTreeNode = cachedTreeView.FindNodeByValue(e.Node.Value)
        AddChildNodes(cachedNodeClicked)
        cachedNodeClicked.ExpandMode = TreeNodeExpandMode.ClientSide
        cachedNodeClicked.Expanded = True
        Session("treeViewState") = cachedTreeView.GetXml
    End Sub
End Class
