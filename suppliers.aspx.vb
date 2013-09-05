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
                Dim direction As Boolean = False
                If (e.CommandName = "MoveUp") Then direction = True
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

    Protected Sub defaultCountry(ByVal sender As Object, ByVal e As System.EventArgs)
        ' default country to UK
        ' ?? possible to change this to default based on browser location
        Dim rcbCountry As RadComboBox = CType(sender, RadComboBox)
        rcbCountry.SelectedValue = 183
    End Sub

    Protected Sub rgSuppliers_ItemDataBound(sender As Object, e As Telerik.Web.UI.GridItemEventArgs) Handles rgSuppliers.ItemDataBound
        ' hide delete option for build elements that were created before variation mode
        If (TypeOf (e.Item) Is GridDataItem) Then
            'Get the instance of the right type
            Dim dataBoundItem As GridDataItem = e.Item
            Dim deleteColumn = dataBoundItem("DeleteColumn")
            Dim isLocked = dataBoundItem("isLocked").Text

            If isLocked Then
                deleteColumn.Visible = False
            End If

            ' hide unresourced
            Dim supplierId = dataBoundItem("supplierId").Text
            Dim supplierName = dataBoundItem("supplierName").Text
            Dim supplier = dataBoundItem("supplier")
            Dim hlSupplier As HyperLink = supplier.FindControl("hlSupplier")
            Dim lblSupplier As Label = supplier.FindControl("lblSupplier")

            If supplierId = 1 Then
                lblSupplier.Text = supplierName
                lblSupplier.Visible = True
            Else
                hlSupplier.Text = supplierName
                hlSupplier.NavigateUrl = String.Format("~/supplier_details.aspx?id={0}", supplierId)
                hlSupplier.Visible = True
                lblSupplier.Visible = False
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
    End Sub

    Protected Sub fvSupplierInsert_ItemInserted(sender As Object, e As FormViewInsertedEventArgs) Handles fvSupplierInsert.ItemInserted

    End Sub
End Class
