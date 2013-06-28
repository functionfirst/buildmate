Imports System.Data.SqlClient
Imports System.Data
Imports System.Net.Mail

Partial Class services_client_email_project_notifications
    Inherits System.Web.UI.Page

    Dim debugMode As Boolean = False

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        SendDigest()
    End Sub

    Protected Sub SendDigest()
        ' iterate through the user list
        Dim sqlSelectCommand As String = "SELECT UserId, isNull(firstname, 'Subscriber') AS firstname, email " & _
                "FROM UserProfile " & _
                "WHERE notifyByEmail=1 " & _
                "AND email IS NOT NULL " & _
                "AND subscription >= GETDATE() AND dateDiff(d, getdate(), notifyDate) < 0; UPDATE UserProfile SET notifyDate = GETDATE()"
        Try
            Dim adapter As New SqlDataAdapter(sqlSelectCommand, System.Configuration.ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString)
            Dim dataTable As New DataTable()
            adapter.Fill(dataTable)

            For Each dr In dataTable.Rows
                Dim Userid As String = dr("UserId").ToString()
                Dim firstName As String = dr("firstname")
                Dim email As String = dr("email")

                ' get project list for this user
                Dim projectList As String = ""
                Dim sqlSelectProject As String = "SELECT id, projectName, CONVERT(VARCHAR(11), returnDate,106) AS returnDate, dateDiff(d, getdate(), returnDate) AS difference " & _
                        "FROM Project " & _
                        "WHERE userId = '" & Userid & "' " & _
                        "AND dateDiff(d, getdate(), returnDate) <= 3 " & _
                        "AND (projectStatusId = 1 OR projectStatusId = 2 OR projectStatusId = 9) " & _
                        "AND archived = 0 " & _
                        "ORDER BY returnDate ASC"
                Try
                    Dim projectAdapter As New SqlDataAdapter(sqlSelectProject, System.Configuration.ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString)
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
                                    label = "<strong>Overdue</strong>"
                            End Select

                            ' create a table row populated with the project details
                            projectList &= String.Format("<tr><td width='60%' style='border-bottom: 1px solid #ccc; '><a href='http://buildmateapp.com/project_details.aspx?pid={0}'>{1}</a></td>" & _
                              "<td style='border-bottom: 1px solid #ccc; text-align: center'>{2}</td>" & _
                            "<td style='border-bottom: 1px solid #ccc; text-align: center'>{3}</td></tr>", pid, projectName, returnDate, label)
                        Next

                        If debugMode Then
                            ' output the project list in a table
                            Response.Write("<p><strong>" & firstName & "&lt;" & email & " &gt;</strong></p>")
                            Response.Write("<table>")
                            Response.Write(projectList)
                            Response.Write("</table>")
                        Else
                            ' email the daily digest for this user
                            sendByEmail(email, firstName, projectList)
                        End If
                    End If
                Catch ex As Exception
                    Trace.Write(ex.ToString)
                End Try
            Next
        Catch ex As Exception
            Trace.Write(ex.ToString)
        End Try
    End Sub

    Protected Sub sendByEmail(ByVal toAddr As String, ByVal firstName As String, ByVal bodyText As String)
        If bodyText.Length > 1 Then
            Dim msg As System.Net.Mail.MailMessage = CreateMessage(toAddr, firstName, bodyText)

            Try
                Dim sc As SmtpClient
                sc = New SmtpClient()
                sc.Send(msg)
            Catch ex As Exception
                Trace.Write(ex.ToString())
            End Try
        End If
    End Sub

    Function CreateMessage(ByVal toAddr As String, ByVal firstName As String, ByVal bodyText As String) As System.Net.Mail.MailMessage
        Dim md As MailDefinition = New MailDefinition
        md.BodyFileName = "~/email_templates/DailyDigest.txt"
        md.From = "support@buildmateapp.com"
        md.Subject = "[BuildMate] - Daily Digest"
        md.Priority = MailPriority.Normal
        md.IsBodyHtml = True

        Dim replacements As ListDictionary = New ListDictionary
        replacements.Add("<% firstName %>", firstName)
        replacements.Add("<% bodyText %>", bodyText)
        Dim fileMsg As System.Net.Mail.MailMessage
        fileMsg = md.CreateMailMessage(toAddr, replacements, Me)
        Return fileMsg
    End Function
End Class