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

    Protected Sub sendError(ByVal subject As String, ByVal errorBody As String)
        ' send error to support
        Try
            Dim obj As System.Net.Mail.SmtpClient = New System.Net.Mail.SmtpClient
            Dim Mailmsg As New System.Net.Mail.MailMessage
            Mailmsg.To.Clear()
            Mailmsg.To.Add(New System.Net.Mail.MailAddress("BuildMate<alan@buildmateapp.com>"))
            Mailmsg.From = New System.Net.Mail.MailAddress("alan@buildmateapp.com")
            Mailmsg.Subject = subject & " - Error Report - BuildMate"
            Mailmsg.IsBodyHtml = True
            Mailmsg.Body = errorBody
            obj.Send(Mailmsg)
        Catch ex As Exception
            Trace.Write(ex.ToString)
        End Try
    End Sub

    Protected Function hasCustomer() As Boolean

        Dim queryString As String = "SELECT COUNT(id) FROM UserContact WHERE userId = @userId;"
        Using connection As New SqlConnection(connectionString)
            Dim command As New SqlCommand(queryString, connection)
            command.Parameters.AddWithValue("userId", Session("userId"))
            connection.Open()
            Dim reader As SqlDataReader = command.ExecuteReader()
            Try
                If reader.HasRows Then
                    Return True
                End If
            Catch

            End Try
        End Using

        Return False
    End Function
End Class

