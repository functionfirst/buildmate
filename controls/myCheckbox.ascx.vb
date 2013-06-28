
Partial Class controls_myCheckbox
    Inherits System.Web.UI.UserControl

    Private m_checked As Boolean = False

    Public Property checked() As Object
        Get
            Return m_checked
        End Get
        Set(ByVal value As Object)
            If value.GetType Is DBNull.Value.GetType Then
                m_checked = False
            ElseIf value Is Nothing Then
                m_checked = False
            ElseIf TypeOf value Is Boolean Then
                m_checked = value
            ElseIf value = 1 Then
                m_checked = True
            ElseIf value = 0 Then
                m_checked = False
            Else
                m_checked = False
            End If
        End Set
    End Property

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        m_checked = CheckBox1.Checked
    End Sub

    Protected Sub Page_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreRender
        CheckBox1.Checked = m_checked
    End Sub
End Class
