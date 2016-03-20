Imports System.Data.SqlClient
Imports System.Data
Imports System.Net.Mail
Imports Buildmate

Partial Class services_client_email_project_notifications
    Inherits System.Web.UI.Page

    Dim Followup As New Buildmate.FollowupEmail
    Dim MailDigest As New Buildmate.MailDigest

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        getSubscriberList()
        Followup.introduction()
    End Sub

    Protected Sub getSubscriberList()
        Dim sqlSelectCommand As String = "SELECT UserId, isNull(firstname, '') AS firstname, email " &
               "FROM UserProfile " &
               "WHERE notifyByEmail=1 " &
               "AND email IS NOT NULL " &
               "AND subscription >= GETDATE() AND dateDiff(d, getdate(), notifyDate) < 0"
        Try
            Dim adapter As New SqlDataAdapter(sqlSelectCommand, System.Configuration.ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString)
            Dim dataTable As New DataTable()
            adapter.Fill(dataTable)

            For Each dr In dataTable.Rows
                Dim Userid As String = dr("UserId").ToString()
                Dim firstName As String = dr("firstname")
                Dim email As String = dr("email")

                Dim client_ip As String = Request.UserHostAddress()

                Dim newToken As New Token()
                newToken.email = email
                newToken.ipaddress = client_ip
                newToken.generateToken()

                getProjectList(Userid, firstName, email, newToken.token)
            Next
        Catch ex As Exception
            Trace.Write(ex.ToString)
        End Try
    End Sub

    Protected Sub getProjectList(ByVal userid As String, ByVal firstname As String, ByVal email As String, ByVal token As String)
        ' get project list for this user
        Dim projectList As String = ""
        Dim plainBody As String = ""
        Dim sqlSelectProject As String = "SELECT id, projectName, CONVERT(VARCHAR(11), returnDate,106) AS returnDate, dateDiff(d, getdate(), returnDate) AS difference " &
                "FROM Project " &
                "WHERE userId = @userid " &
                "AND dateDiff(d, getdate(), returnDate) <= 3 " &
                "AND (projectStatusId = 1 OR projectStatusId = 2 OR projectStatusId = 9) " &
                "AND archived = 0 " &
                "ORDER BY returnDate ASC"
        Try
            Dim projectAdapter As New SqlDataAdapter(sqlSelectProject, System.Configuration.ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString)
            projectAdapter.SelectCommand.Parameters.AddWithValue("@userid", userid)
            Dim projectDataTable As New DataTable()
            projectAdapter.Fill(projectDataTable)

            ' check at least 1 project exists.
            If projectDataTable.Rows.Count > 0 Then
                ' get details for each project
                For Each project In projectDataTable.Rows
                    Dim pid As Integer = project("id")
                    Dim projectName As String = project("projectName")
                    Dim returnDate As String = project("returnDate")
                    Dim diff As Integer = project("difference")
                    Dim label As String

                    Select Case diff
                        Case 3, 2
                            label = String.Format("Due in {0} days", diff)
                        Case 1
                            label = "Due tomorrow"
                        Case 0
                            label = "Due today"
                        Case Else
                            label = "<strong style='font-weight:bold'>Overdue</strong>"
                    End Select

                    ' create a table row populated with the project details
                    projectList &= String.Format("<tr><td width='60%' style='font-family:'Helvetica','Arial',sans-serif;font-weight:normal;font-size:13px;'><a href='https://buildmateapp.com/project_details.aspx?pid={0}' style='color:#21759b;text-decoration:none!important;'>{1}</a></td>" &
                                                 "<td align='center' style='text-align:center;font-family:'Helvetica','Arial',sans-serif;font-weight:normal;font-size:13px;'>{2}</td>" &
                                                 "<td align='center' style='text-align:center;font-family:'Helvetica','Arial',sans-serif;font-weight:normal;font-size:13px;'>{3}</td></tr>",
                                                 pid, projectName, returnDate, label)

                    plainBody &= String.Format("{1} ('http://buildmateapp.com/project_details.aspx?pid={0})						{2}				{3}", pid, projectName, returnDate, label)
                Next

                ' email the daily digest for this user
                MailDigest.digest(email, firstname, projectList, plainBody, token)
            End If
        Catch ex As Exception
            Trace.Write(ex.ToString)
        End Try
    End Sub
End Class