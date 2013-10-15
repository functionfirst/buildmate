Imports Telerik.Web.UI
Imports System.Data.SqlClient
Imports System.Data

Partial Class manager_customer_details
    Inherits MyBaseClass

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        Dim activeLink As HyperLink = CType(Master.FindControl("hlCustomers"), HyperLink)
        activeLink.CssClass = "active"
    End Sub

    Protected Sub fvCustomerDetails_DataBound(sender As Object, e As EventArgs) Handles fvCustomerDetails.DataBound
        Dim archived As Boolean = DirectCast(fvCustomerDetails.DataItem, DataRowView)("archived")
        toggleArchiveButtons(archived)
    End Sub

    Protected Sub toggleArchiveButtons(ByVal archived As Boolean)
        btnArchive.Visible = Not archived
        btnUnarchive.Visible = archived
    End Sub

    Protected Sub fvCustomerDetails_ItemUpdated(sender As Object, e As FormViewUpdatedEventArgs) Handles fvCustomerDetails.ItemUpdated
        If e.Exception Is Nothing Then
            showNotification("Customer Updated", "Your changes were saved successfully")
        Else
            showNotification("Error while saving :(", "Your changes were not saved! The error has been automatically reported to an administrator", True)

            reportError(e.Exception)
            e.ExceptionHandled = True
        End If
    End Sub

    Protected Sub archiveCustomer(ByVal archived As Boolean)
        Dim customerId = CType(Request.QueryString("id"), Integer)
        Dim connString As String = System.Configuration.ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString
        Dim sql As String = "UPDATE UserContact SET archived = '" & archived & "' WHERE id = " & customerId & " AND UserId = '" & Session("userId") & "'"

        Using conn As New SqlConnection(connString)
            Dim cmd As New SqlCommand(sql, conn)
            Try
                conn.Open()
                cmd.ExecuteScalar()

                If archived Then
                    showNotification("Archived", "The customer was successfully archived")
                Else
                    showNotification("Unarchived", "You unarchived this customer")
                End If
                toggleArchiveButtons(archived)
            Catch ex As Exception
                Trace.Write(ex.Message)
            End Try
        End Using
    End Sub

    Protected Sub btnArchive_Click(sender As Object, e As EventArgs) Handles btnArchive.Click
        archiveCustomer(True)
    End Sub

    Protected Sub btnUnarchive_Click(sender As Object, e As EventArgs) Handles btnUnarchive.Click
        archiveCustomer(False)
    End Sub
End Class
