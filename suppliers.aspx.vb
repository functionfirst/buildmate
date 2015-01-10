Imports System.Data
Imports Telerik.Web.UI
Imports System.Data.SqlClient

Partial Class manager_Default
    Inherits System.Web.UI.Page

    Protected Sub rgSuppliers_ItemCommand(ByVal source As Object, ByVal e As Telerik.Web.UI.GridCommandEventArgs) Handles rgSuppliers.ItemCommand
        ' change Suppliers order of priority
        If (e.CommandName = "MoveUp") Or (e.CommandName = "MoveDown") Then
            If (TypeOf e.Item Is GridItem) Then
                Dim item As GridItem = DirectCast(e.Item, GridItem)
                Dim position As String = e.CommandArgument
                Dim id As String = CType(item.FindControl("hiddenId"), HiddenField).Value

                ' check for direction of movement
                Dim direction As Boolean = True
                If (e.CommandName = "MoveUp") Then direction = False
                changePosition(id, position, direction)
            End If
        End If
    End Sub

    Protected Sub changePosition(ByVal id As Integer, ByVal position As String, ByVal direction As Boolean)
        Dim connString As String = System.Configuration.ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString
        Dim myConn As New SqlConnection(connString)
        Dim cmd As New SqlCommand
        cmd.Parameters.Clear()
        cmd.CommandText = "updateSupplierPriority"
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Connection = myConn

        cmd.Parameters.AddWithValue("@id", id)
        cmd.Parameters.AddWithValue("@direction", direction)
        cmd.Parameters.AddWithValue("@position", position)
        cmd.Parameters.AddWithValue("@userId", Session("userId"))

        Try
            myConn.Open()
            cmd.ExecuteScalar()

        Catch ex As Exception
            Trace.Write(ex.ToString)
            myConn.Close()
        End Try
        rgSuppliers.DataBind()
    End Sub

    Protected Sub rgSuppliers_ItemDataBound(sender As Object, e As Telerik.Web.UI.GridItemEventArgs) Handles rgSuppliers.ItemDataBound
        ' hide delete option for build elements that were created before variation mode
        If (TypeOf (e.Item) Is GridDataItem) Then
            'Get the instance of the right type
            Dim item As GridDataItem = e.Item
            Dim deleteColumn = item("DeleteColumn")
            Dim isLocked = item("isLocked").Text


            ' hide unresourced
            Dim supplierId = item("supplierId").Text
            Dim supplierName = item("supplierName").Text
            Dim supplier = item("supplier")
            Dim hlSupplier As HyperLink = supplier.FindControl("hlSupplier")
            Dim lblSupplier As Label = supplier.FindControl("lblSupplier")

            hlSupplier.Text = supplierName
            hlSupplier.NavigateUrl = String.Format("~/supplier_details.aspx?id={0}", supplierId)
            hlSupplier.Visible = True
            lblSupplier.Visible = False

            ' don't allow user to delete themselves from the supplier list
            ' indicate their supplier
            If isLocked Then
                deleteColumn.Visible = False
            End If

            ' check for last or first item
            Dim itemIndex = e.Item.DataSetIndex

            If (itemIndex = 0) Then
                ' first item
                Dim lbUp As LinkButton = DirectCast(item("position").FindControl("lbUp"), LinkButton)
                lbUp.Visible = False
            ElseIf (itemIndex = e.Item.OwnerTableView.DataSourceCount - 1) Then
                ' last item
                Dim lbDown As LinkButton = DirectCast(item("position").FindControl("lbDown"), LinkButton)
                lbDown.Visible = False
            End If
        End If
    End Sub

    Protected Sub rgSuppliers_ItemDeleted(source As Object, e As Telerik.Web.UI.GridDeletedEventArgs) Handles rgSuppliers.ItemDeleted
        rcbSuppliers.DataBind()
    End Sub

    Protected Sub rcbSuppliers_DataBound(sender As Object, e As System.EventArgs) Handles rcbSuppliers.DataBound
        If rcbSuppliers.Items.Count = 0 Then
            pNewSuppliers.Visible = False
        Else
            pNewSuppliers.Visible = True
        End If
    End Sub

    Protected Sub btnAddSupplier_Click(sender As Object, e As System.EventArgs) Handles btnAddSupplier.Click
        btnAddSupplier.Enabled = False
        Dim supplierId = rcbSuppliers.SelectedValue
        If supplierId > 0 Then
            AddSupplierToPriorityList(supplierId)
        End If

        rcbSuppliers.DataBind()
        rgSuppliers.DataBind()
        btnAddSupplier.Enabled = True
    End Sub

    Protected Sub AddSupplierToPriorityList(ByVal supplierId As String)
        Dim connString As String = System.Configuration.ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString
        Dim myConn As New SqlConnection(connString)
        Dim cmd As New SqlCommand
        cmd.Parameters.Clear()
        cmd.CommandText = "insertSupplierPriority"
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Connection = myConn

        cmd.Parameters.AddWithValue("@supplierId", supplierId)
        cmd.Parameters.AddWithValue("@userId", Session("userId"))

        Try
            myConn.Open()
            cmd.ExecuteScalar()

        Catch ex As Exception
            Trace.Write(ex.ToString)
            myConn.Close()
        End Try
    End Sub

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        Dim activeLink As HyperLink = CType(Master.FindControl("hlSuppliers"), HyperLink)
        activeLink.CssClass = "active"

        addSupplierShortcut()
    End Sub

    Protected Sub addSupplierShortcut()
        Dim action As String = Request.QueryString("action")
        If action = "add_supplier" Then
            addSupplierScript.Visible = True
        End If
    End Sub


    Protected Sub fvSupplierInsert_ItemInserted(sender As Object, e As FormViewInsertedEventArgs) Handles fvSupplierInsert.ItemInserted
        rgSuppliers.DataBind()

        moveTourPhase()
    End Sub

    Protected Sub moveTourPhase()
        If Session("tourPhase") = 7 Then
            Response.Redirect(HttpContext.Current.Request.Url.AbsoluteUri)
        End If
    End Sub
End Class
