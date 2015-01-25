Imports System.Data.SqlClient

Public Class MyBaseClass
    Inherits System.Web.UI.Page

    Dim connectionString As String = System.Configuration.ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString

    Protected Overrides Sub OnLoad(ByVal e As EventArgs)
        ' call the base class OnLoad method!
        MyBase.OnLoad(e)
    End Sub

    Protected Sub loadMyControl(ByVal controlName As String, ByVal targetPanel As Panel)
        targetPanel.Controls.Clear()
        Dim userControl As New UserControl
        userControl = CType(Me.LoadControl(controlName), UserControl)
        targetPanel.Controls.Add(userControl)
    End Sub

    Protected Sub reportError(ByVal exception As Exception)
        Dim e = exception.ToString
        Trace.Write(e)      ' log the bug to the trace tool.
        sendErrorToAdmin(e) ' send the error to the admin email
    End Sub

    Protected Sub activateNavigationLink(ByVal linkName As String)
        Dim activeLink As HyperLink = CType(Master.FindControl(linkName), HyperLink)
        activeLink.CssClass = "active"
    End Sub

    Protected Sub sendErrorToAdmin(ByVal errorBody As String)
        ' send error to support
        Try
            Dim obj As System.Net.Mail.SmtpClient = New System.Net.Mail.SmtpClient
            Dim Mailmsg As New System.Net.Mail.MailMessage
            Mailmsg.To.Clear()
            Mailmsg.To.Add(New System.Net.Mail.MailAddress("Buildmate<alan@buildmateapp.com>"))
            Mailmsg.From = New System.Net.Mail.MailAddress("alan@buildmateapp.com")
            Mailmsg.Subject = "[Buildmate] - Error Report"
            Mailmsg.IsBodyHtml = False
            Mailmsg.Body = errorBody
            obj.Send(Mailmsg)
        Catch ex As Exception
            Trace.Write(ex.ToString)
        End Try
    End Sub

    Protected Sub showNotification(ByVal title As String, ByVal message As String, Optional ByVal isError As Boolean = False)
        Dim setClass = "flash flash-success"
        If isError Then setClass = "flash flash-error"
        Dim notification = CType(Master.FindControl("notification"), Panel)
        notification.CssClass = setClass
        CType(notification.FindControl("notificationTitle"), Literal).Text = title
        CType(notification.FindControl("notificationMessage"), Literal).Text = message

        notification.Visible = True
    End Sub

    Protected Sub hideNotification()
        Dim notification = CType(Master.FindControl("notification"), Panel)
        notification.Visible = False
    End Sub

    Protected Sub checkPermissions(ByVal type As String)
        Dim hasPermissions As Boolean = False

        ' Check if the Code already exists in the database
        Dim connString As String = System.Configuration.ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString
        Dim myConn As New SqlConnection(connString)
        Dim cmd As SqlCommand

        ' check object type
        Select Case type
            Case "UserContact"
                Dim id As String = Request.QueryString("id")
                cmd = New SqlCommand("SELECT id FROM UserContact WHERE id = @id and userid = @userid", myConn)
                cmd.Parameters.AddWithValue("@id", id)

            Case "Supplier"
                Dim id As String = Request.QueryString("id")
                cmd = New SqlCommand("SELECT id FROM Supplier WHERE id = @id and userid = @userid", myConn)
                cmd.Parameters.AddWithValue("@id", id)

            Case "SupportTickets"
                Dim id As String = Request.QueryString("id")
                cmd = New SqlCommand("SELECT id FROM SupportTickets WHERE id = @id and userid = @userid", myConn)
                cmd.Parameters.AddWithValue("@id", id)

            Case "CatalogueUseage"
                Dim id As String = Request.QueryString("id")
                cmd = New SqlCommand("select * FROM CatalogueUseage LEFT JOIN Catalogue ON Catalogue.id = CatalogueUseage.catalogueId LEFT JOIN Supplier ON Supplier.id = Catalogue.supplierId where CatalogueUseage.id = @id and userId = @userid", myConn)
                cmd.Parameters.AddWithValue("@id", id)

            Case Else
                Dim pid As String = Request.QueryString("pid")
                cmd = New SqlCommand("SELECT id FROM Project WHERE id = @pid and userid = @userid", myConn)
                cmd.Parameters.AddWithValue("@pid", pid)

        End Select

        cmd.Parameters.AddWithValue("@userid", Session("userid"))

        Try
            myConn.Open()
            If cmd.ExecuteScalar IsNot Nothing Then
                ' UserID was found matching this object
                hasPermissions = True
                myConn.Close()
            End If
        Catch ex As Exception
            ' Do nothing
        End Try

        If Not hasPermissions Then
            Response.Redirect("no_permissions.aspx")
        End If
    End Sub
End Class

