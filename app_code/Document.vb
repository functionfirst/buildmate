Imports Microsoft.VisualBasic

Public Class BMDocument

    Private projectId As String
    Dim projectName As String
    Dim reportTypeId As String
    Dim reportTypeName As String
    Dim resourceTypeId As String
    Dim reportFormat As String
    Dim termsId As String
    Dim incVat As String

    Property Id() As String
        Get
            Return projectId
        End Get
        Set(ByVal Value As String)
            projectId = Value
        End Set
    End Property

    Property Name() As String
        Get
            Return projectName
        End Get
        Set(ByVal Value As String)
            projectName = Value
        End Set
    End Property

    Property ReportType() As String
        Get
            Return reportTypeId
        End Get
        Set(ByVal Value As String)
            reportTypeId = Value
        End Set
    End Property

    Property ReportName() As String
        Get
            Return reportTypeName
        End Get
        Set(ByVal Value As String)
            reportTypeName = Value
        End Set
    End Property

    Property ResourceType() As String
        Get
            Return resourceTypeId
        End Get
        Set(ByVal Value As String)
            resourceTypeId = Value
        End Set
    End Property

    Property Format() As String
        Get
            Return reportFormat
        End Get
        Set(ByVal Value As String)
            reportFormat = Value
        End Set
    End Property

    Property Terms() As String
        Get
            Return termsId
        End Get
        Set(ByVal Value As String)
            termsId = Value
        End Set
    End Property

    Property VAT() As String
        Get
            Return incVat
        End Get
        Set(ByVal Value As String)
            incVat = Value
        End Set
    End Property

End Class
