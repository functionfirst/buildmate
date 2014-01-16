Imports System.Data
Imports Telerik.Web.UI
Imports System.Data.SqlClient

Partial Class manager_add_task
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim activeLink As HyperLink = CType(Master.FindControl("hlProjects"), HyperLink)
        activeLink.CssClass = "active"

        If (Not Page.IsPostBack) Then
            initLoadRootNodes()
        End If

        hlBack.NavigateUrl = String.Format(hlBack.NavigateUrl, Request.QueryString("pid"))
        hlBack2.NavigateUrl = String.Format(hlBack2.NavigateUrl, Request.QueryString("pid"), Request.QueryString("rid"))
    End Sub

    'Private Function getFilters() As String
    '    ' check for keyword filters
    '    Dim filters As String = ""

    '    If Len(rtbFilters.Text) >= 1 Then
    '        Dim filter As String() = Split(rtbFilters.Text, " ")

    '        ' iterate through each keyword entered
    '        For Each keyword As String In filter
    '            ' check at least 1 keyword exists
    '            If Len(keyword) >= 1 Then
    '                ' check for first keyword
    '                If Len(filters) > 0 Then filters += " OR "

    '                ' construct filter string
    '                filters += String.Format("(taskName LIKE '%%%" & keyword & "%%%' OR keywords LIKE '%%%" & keyword & "%%%')")
    '            End If
    '        Next
    '    End If

    '    Return filters
    'End Function

    Private Sub LoadRootNodes()
        RadTreeView1.Nodes.Clear()
        Session.Remove("expandedNodes")

        ' get keyword filters
        'Dim filters As String = getFilters()

        ' define the datatable
        Dim sp As String = "TaskData_Select_Top_Level"
        Dim data As DataTable = GetNodeData(sp, 0)
        Dim rows As DataRow() = data.Select("", "taskName")
        'data.Select(filters, "taskName")

        'If (CType(rows.Length, Integer) = 0) Then
        '    results.Text = "No Tasks were found matching your keywords."
        'Else
        'results.Text = ""
        For Each row As DataRow In rows
            Dim node As RadTreeNode = New RadTreeNode
            node.Text = HttpUtility.HtmlDecode(CType(row("taskName"), String))
            node.Value = CType(row("id"), Integer).ToString
            node.Checkable = False
            node.ExpandMode = TreeNodeExpandMode.ServerSideCallBack
            RadTreeView1.Nodes.Add(node)
        Next
        'End If
    End Sub

    Private Sub AddChildNodes(ByVal node As RadTreeNode)
        ' get keyword filters
        'Dim filters As String = getFilters()

        ' defining the datatable
        Dim sp As String = "TaskData_Select_by_Parent"
        Dim data As DataTable = GetNodeData(sp, node.Value)
        Dim rows As DataRow() = data.Select("", "taskName")
        'data.Select(filters, "taskName")

        If rows.Length = 0 Then
            Dim childNode As RadTreeNode = New RadTreeNode
            childNode.Text = "No Tasks were found."
            node.Nodes.Add(childNode)
            childNode.Checkable = False
        End If

        For Each row As DataRow In rows
            Dim childNode As RadTreeNode = New RadTreeNode
            childNode.Text = HttpUtility.HtmlDecode(CType(row("taskName"), String))
            childNode.Value = CType(row("id"), Integer).ToString

            If (CType(row("HasChildren"), Integer) > 0) Then
                childNode.ExpandMode = TreeNodeExpandMode.ServerSideCallBack
                childNode.Checkable = False
            End If
            node.Nodes.Add(childNode)
        Next
    End Sub

    Protected Sub initLoadRootNodes()
        LoadRootNodes()
    End Sub

    Protected Sub RadTreeView1_NodeExpand(ByVal sender As Object, ByVal e As RadTreeNodeEventArgs) Handles RadTreeView1.NodeExpand
        AddChildNodes(e.Node)
    End Sub

    Protected Sub btnAdd_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAdd.Click
        ' iterate through all selected tasks nodes
        For Each node In RadTreeView1.CheckedNodes
            ' pass taskDataId to the insert procedure
            insertTask(node.Value)
        Next

        'redirect to build element details
        Response.Redirect(String.Format("build_element_details.aspx?pid={0}&rid={1}", Request.QueryString("pid"), Request.QueryString("rid")))
    End Sub

    Protected Sub insertTask(ByVal taskDataId As Integer)
        Dim roomId As Integer = Request.QueryString("rid")

        Dim dbCon As New SqlConnection(ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString)

        Dim cmd As New SqlCommand("insertTasks", dbCon)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@taskDataId", taskDataId)
        cmd.Parameters.AddWithValue("@roomId", roomId)
        cmd.Parameters.AddWithValue("@userId", Session("userId"))

        Try
            dbCon.Open()
            cmd.ExecuteScalar()

            dbCon.Close()
        Catch ex As Exception
            Trace.Write(ex.Message)
        End Try
    End Sub

    Private Function GetNodeData(ByVal sp As String, ByVal parentId As Integer) As DataTable
        ' get the roomId
        Dim roomId As Integer = Request.QueryString("rid")

        ' create and execute sql command
        Dim dbCon As New SqlConnection(ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString)
        dbCon.Open()

        Dim cmd As New SqlCommand(sp, dbCon)
        cmd.CommandType = CommandType.StoredProcedure
        'cmd.Parameters.AddWithValue("@roomId", roomId)
        cmd.Parameters.AddWithValue("@parentId", parentId)

        ' bind to data adapter
        Dim adapter As SqlDataAdapter = New SqlDataAdapter(cmd)
        Dim dt As DataTable = New DataTable
        adapter.Fill(dt)
        dbCon.Close()

        Return dt
    End Function

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Dim limitedAccount = Session("limitedAccount")
        pLimitedTasks.Visible = limitedAccount
        pAddTasks.Visible = Not limitedAccount
    End Sub
End Class