Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports System.Data
Imports Buildmate.Mail

Public Class ProjectManager
    'Dim token As Token = New Token

    Dim mail As Buildmate.Mail = New Buildmate.Mail

    Public Sub Send()
        mail.template = "~/email_templates/DailyDigest.html"
        mail.fromAdd = "support@buildmateapp.com"
        mail.subject = "[Buildmate] Daily Digest"

        getSubscriberList()
    End Sub

    Protected Sub getSubscriberList()
        Dim sqlSelectCommand As String = "SELECT UserId, isNull(firstname, '') AS firstname, email " & _
               "FROM UserProfile " & _
               "WHERE notifyByEmail=1 " & _
               "AND email IS NOT NULL " & _
               "AND subscription >= GETDATE() AND dateDiff(d, getdate(), notifyDate) < 0"
        Try
            Dim adapter As New SqlDataAdapter(sqlSelectCommand, System.Configuration.ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString)
            Dim dataTable As New DataTable()
            adapter.Fill(dataTable)

            For Each dr In dataTable.Rows
                Dim Userid As String = dr("UserId").ToString()
                Dim firstName As String = dr("firstname")
                Dim email As String = dr("email")

                getProjectList(Userid, firstName, email)
            Next
        Catch ex As Exception
            'Trace.Write(ex.ToString)
        End Try
    End Sub

    Protected Sub getProjectList(ByVal userid As String, ByVal firstname As String, ByVal email As String)
        'Dim token As String = token.update(userid)

        ' get project list for this user
        Dim projectList As String = ""
        Dim sqlSelectProject As String = "SELECT id, projectName, CONVERT(VARCHAR(11), returnDate,106) AS returnDate, dateDiff(d, getdate(), returnDate) AS difference " & _
                "FROM Project " & _
                "WHERE userId = @userid " & _
                "AND dateDiff(d, getdate(), returnDate) <= 3 " & _
                "AND (projectStatusId = 1 OR projectStatusId = 2 OR projectStatusId = 9) " & _
                "AND archived = 0 " & _
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
                    projectList &= String.Format("<tr><td width='60%' style='font-family:'Helvetica','Arial',sans-serif;font-weight:normal;font-size:13px;'><a href='http://buildmateapp.com/project_details.aspx?pid={0}' style='color:#21759b;text-decoration:none!important;'>{1}</a></td>" & _
                      "<td align='center' style='text-align:center;font-family:'Helvetica','Arial',sans-serif;font-weight:normal;font-size:13px;'>{2}</td>" & _
                    "<td align='center' style='text-align:center;font-family:'Helvetica','Arial',sans-serif;font-weight:normal;font-size:13px;'>{3}</td></tr>", pid, projectName, returnDate, label)
                Next

                ' email the daily digest for this user
                mail.toAdd = email
                mail.replacements.Add("<% firstName %>", firstname)
                mail.replacements.Add("<% bodyText %>", projectList)
                'mail.replacements.Add("<% token %>", Token)
                mail.send()
                'sendByEmail(email, firstname, projectList, token)
            End If
        Catch ex As Exception
            'Trace.Write(ex.ToString)
        End Try
    End Sub

End Class
