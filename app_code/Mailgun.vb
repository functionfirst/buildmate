Imports System.IO
Imports Microsoft.VisualBasic
Imports RestSharp
Imports RestSharp.Authenticators

Namespace Buildmate
    Public Class Mailgun

        Private _toAdd As String
        Private _fromAdd As String
        Private _fromName As String
        Private _template As String
        Private _replacements As System.Collections.Generic.Dictionary(Of String, String)
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

        Public Property replacements() As System.Collections.Generic.Dictionary(Of String, String)
            Get
                Return _replacements
            End Get
            Set(value As System.Collections.Generic.Dictionary(Of String, String))
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

        Public Sub New()
            _replacements = New Dictionary(Of String, String)
        End Sub

        Protected Function getTemplate(ByVal fileType As String) As String
            'Dim templateFile As String = ""

            ' Identify location of email template
            'Select Case template
            '    Case "NewAccount"
            '        templateFile = "~/email_templates/NewAccount"
            '    Case "Followup"
            '        templateFile = "~/email_templates/Followup"
            '    Case "Welcome"
            '        templateFile = "~/email_templates/Welcome"
            'End Select

            ' get template file content
            Dim templateFile As String = HttpContext.Current.Server.MapPath("~/email_templates/" + template + fileType)
            Dim templateContent As String
            Using sr As New StreamReader(templateFile)
                ' Read the stream to a string and write the string to the console.
                templateContent = sr.ReadToEnd()
            End Using

            ' replace placeholder content
            If replacements.Count > 0 Then
                For Each item As KeyValuePair(Of String, String) In replacements
                    templateContent = templateContent.Replace(item.Key, item.Value)
                Next
            End If

            Return templateContent
        End Function

        Public Function send() As RestResponse
            Dim client As New RestClient("https://api.mailgun.net/v3")
            client.Authenticator = New HttpBasicAuthenticator("api", "key-43cf21afeaa006e596f279ffb1021800")
            Dim request As New RestRequest()
            request.AddParameter("domain", "mg.buildmateapp.com", ParameterType.UrlSegment)
            request.Resource = "{domain}/messages"
            request.AddParameter("from", "Buildmate <support@buildmateapp.com>")
            request.AddParameter("to", toAdd)
            request.AddParameter("subject", subject)
            request.AddParameter("html", getTemplate(".html"))
            request.AddParameter("text", getTemplate(".txt"))
            request.Method = Method.POST
            Return client.Execute(request)
        End Function
    End Class
End Namespace