Imports System.Net.Mail
Imports System.Data.SqlClient
Imports System.Data

Partial Class error_GeneralError
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        Dim lastErrorWrapper As HttpException = CType(Server.GetLastError, HttpException)

        If Not lastErrorWrapper Is Nothing Then
            Dim lastError As Exception = lastErrorWrapper.InnerException

            Dim lastErrorTypeName As String = lastError.GetType.ToString
            Dim lastErrorMessage As String = lastError.Message
            Dim lastErrorStackTrace As String = lastError.StackTrace

            Const ToAddress As String = "support@buildmateapp.com"
            Const FromAddress As String = "support@buildmateapp.com"
            Const Subject As String = "[Buildmate] - Error Report"

            Dim md As MailDefinition = New MailDefinition
            md.BodyFileName = "~/error/email_error.txt"
            md.From = FromAddress
            md.Subject = Subject
            md.Priority = MailPriority.Normal
            md.IsBodyHtml = True

            Dim replacements As ListDictionary = New ListDictionary
            replacements.Add("<% Type %>", lastErrorTypeName)
            replacements.Add("<% Message %>", lastErrorMessage)
            replacements.Add("<% StackTrace %>", lastErrorStackTrace)
            replacements.Add("<% url %>", Request.Url.AbsoluteUri)

            Dim fileMsg As System.Net.Mail.MailMessage
            fileMsg = md.CreateMailMessage(ToAddress, replacements, Me)
            Dim msg As System.Net.Mail.MailMessage = fileMsg

            Try
                Dim sc As SmtpClient
                sc = New SmtpClient()
                sc.Send(msg)
            Catch ex As Exception
                Trace.Write(ex.ToString())
            End Try
        End If
    End Sub
End Class
