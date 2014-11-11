Imports Microsoft.VisualBasic
Imports System.Net.Mail

Namespace Buildmate
    Public Class Mail
        Dim token As Token = New Token

        Private _toAdd As String
        Private _fromAdd As String
        Private _fromName As String
        Private _template As String
        Private _replacements As System.Collections.IDictionary
        Private _subject As String

        Public Property toAdd() As String
            Get
                Return _toAdd
            End Get
            Set(ByVal value As String)
                _toAdd = value
            End Set
        End Property

        Public Property fromAdd() As String
            Get
                Return _fromAdd
            End Get
            Set(ByVal value As String)
                _fromAdd = value
            End Set
        End Property

        Public Property fromName() As String
            Get
                Return _fromName
            End Get
            Set(ByVal value As String)
                _fromName = value
            End Set
        End Property

        Public Property template() As String
            Get
                Return _template
            End Get
            Set(ByVal value As String)
                _template = value
            End Set
        End Property

        Public Property replacements() As System.Collections.IDictionary
            Get
                Return _replacements
            End Get
            Set(value As System.Collections.IDictionary)
                _replacements = value
            End Set
        End Property

        Public Property subject() As String
            Get
                Return _subject
            End Get
            Set(ByVal value As String)
                _subject = value
            End Set
        End Property

        Public Sub send()
            If template.Length > 1 Then
                Dim msg As System.Net.Mail.MailMessage = create()

                Try
                    Dim sc As SmtpClient
                    sc = New SmtpClient()
                    sc.Send(msg)
                Catch ex As Exception
                    'Trace.Write(ex.ToString())
                End Try
            End If
        End Sub

        Protected Function create() As System.Net.Mail.MailMessage
            Dim md As MailDefinition = New MailDefinition
            md.BodyFileName = template
            md.From = fromAdd
            md.Subject = subject
            md.Priority = MailPriority.Normal
            md.IsBodyHtml = True
            replacements.Add("<% token %>", token.token)

            Dim fileMsg As System.Net.Mail.MailMessage
            fileMsg = md.CreateMailMessage(toAdd, replacements, New System.Web.UI.Control)
            Return fileMsg
        End Function
    End Class
End Namespace
