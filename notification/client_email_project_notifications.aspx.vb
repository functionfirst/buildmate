Imports System.Data.SqlClient
Imports System.Data
Imports System.Net.Mail
Imports FollowupEmail

Partial Class services_client_email_project_notifications
    Inherits System.Web.UI.Page

    Dim followup As FollowupEmail = New FollowupEmail

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        getSubscriberList()
        followup.Send()
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


                Dim token As String = updateUserToken(Userid)
                getProjectList(Userid, firstName, email, token)
            Next
        Catch ex As Exception
            Trace.Write(ex.ToString)
        End Try
    End Sub

    Protected Function updateUserToken(ByVal userid As String) As String
        Dim token As String = generateToken()

        ' Update notifydate and add new subscription token for this user
        Dim connString As String = System.Configuration.ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString
        Dim myConn As New SqlConnection(connString)
        Dim cmd As SqlCommand = New SqlCommand("UPDATE UserProfile SET notifyDate = GETDATE(), token = @token WHERE userId = @userId", myConn)
        cmd.Parameters.AddWithValue("@userid", userid)
        cmd.Parameters.AddWithValue("@token", token)

        Try
            myConn.Open()
            cmd.ExecuteScalar()

        Catch ex As Exception
            Trace.Write(ex.ToString)
        Finally
            If myConn.State = ConnectionState.Open Then
                myConn.Close()
            End If
        End Try

        Return token
    End Function

    Protected Sub getProjectList(ByVal userid As String, ByVal firstname As String, ByVal email As String, ByVal token As String)
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
                sendByEmail(email, firstname, projectList, token)
            End If
        Catch ex As Exception
            Trace.Write(ex.ToString)
        End Try
    End Sub

    Protected Function generateToken() As String
        Dim code As String

        ' Generating random code
        Dim rf_code As Random = New Random()
        code = rf_code.Next(999999, 1000000).ToString()
        Return CheckGeneratedCode(code)

    End Function

    Public Function CheckGeneratedCode(Code As String) As String
        Dim ReturnCode As String = ""
        ' Check if the Code already exists in the database
        Dim connString As String = System.Configuration.ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString
        Dim myConn As New SqlConnection(connString)
        Dim cmd As SqlCommand = New SqlCommand("SELECT token FROM UserProfile WHERE token = @token", myConn)
        cmd.Parameters.AddWithValue("@token", Code)

        Try
            myConn.Open()
            If cmd.ExecuteScalar IsNot Nothing Then
                myConn.Close()
                Dim rs_code As New Random()
                Code = rs_code.Next(99999, 1000000).ToString()
                ReturnCode = CheckGeneratedCode(Code)
            Else
                ReturnCode = Code
                myConn.Close()
            End If

        Catch ex As Exception
            Trace.Write(ex.ToString)
        Finally
            If myConn.State = ConnectionState.Open Then
                myConn.Close()
            End If
        End Try

        Return ReturnCode
    End Function


    Protected Sub sendByEmail(ByVal toAddr As String, ByVal firstName As String, ByVal bodyText As String, ByVal token As String)
        If bodyText.Length > 1 Then
            Dim msg As System.Net.Mail.MailMessage = CreateMessage(toAddr, firstName, bodyText, token)

            Try
                Dim sc As SmtpClient
                sc = New SmtpClient()
                sc.Send(msg)
            Catch ex As Exception
                Trace.Write(ex.ToString())
            End Try
        End If
    End Sub

    Function CreateMessage(ByVal toAddr As String, ByVal firstName As String, ByVal bodyText As String, ByVal token As String) As System.Net.Mail.MailMessage
        Dim md As MailDefinition = New MailDefinition
        md.BodyFileName = "~/email_templates/DailyDigest.html"
        md.From = "support@buildmateapp.com"
        md.Subject = "[Buildmate] - Daily Digest"
        md.Priority = MailPriority.Normal
        md.IsBodyHtml = True

        Dim replacements As ListDictionary = New ListDictionary
        replacements.Add("<% firstName %>", firstName)
        replacements.Add("<% bodyText %>", bodyText)
        replacements.Add("<% token %>", token)
        Dim fileMsg As System.Net.Mail.MailMessage
        fileMsg = md.CreateMailMessage(toAddr, replacements, Me)
        Return fileMsg
    End Function
End Class