Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports System.IO
Imports System.Data.OleDb


Partial Class non_web_import
    Inherits System.Web.UI.Page


    Protected Sub btnStart_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnStart.Click
        importDataFile()
        'processImport()
        btnStart.Text = "Next &raquo;"

        Response.Write("Import started at " & Now() & "<br />")
    End Sub

    Protected Sub importDataFile()
        ' set filereader and file to import
        Dim filetoread As String
        Dim filestream As StreamReader
        filetoread = Server.MapPath(filename.Text)
        filestream = File.OpenText(filetoread)

        ' variables
        Dim line As String = filestream.ReadLine
        Dim splitout As Array
        Dim counter As Integer = 0
        Dim taskName As String = ""
        Dim parentId As String = 0
        Dim taskId As Integer
        Dim keywords As String = ""
        Dim prevLevel As Integer = 0
        Dim k As Integer = 0
        Dim unitId As String, minutes As String, buildPhase As String

        Dim taskParentId(99) As String
        'If startPoint > 0 Then taskParentId = Session("taskParentId")

        Response.Write("Import started " & Now() & "<br />")
        Response.Flush()

        ' iterate through the import file line by line
        Do While Not line Is Nothing

            Response.Write("<br />")

            If k >= 100 Then
                System.Threading.Thread.Sleep(10000)
                Response.Flush()
                k = 0
            End If

            ' break the line up on vbTab
            splitout = line.Split(vbTab)
            Dim _RECORDS As Integer = splitout.Length
            counter = counter + 1

            ' assign data fields
            Dim taskNameArray As New ArrayList
            Dim recCount As Integer
            For recCount = 0 To _RECORDS - 4
                taskNameArray.Add(splitout(recCount))
            Next

            unitId = splitout(_RECORDS - 3)
            minutes = splitout(_RECORDS - 2)
            buildPhase = splitout(_RECORDS - 1)

            Dim i As Integer = 0

            For i = 0 To taskNameArray.Count - 1

                If Len(taskNameArray(i)) > 1 Then
                    ' reset counter and parentId for top level tasks
                    If i = 0 Then
                        counter = 0
                        parentId = 0
                    End If

                    taskName = taskNameArray(i).ToString.Replace("&comma;", "'")        ' get new taskname

                    ' check if current task appears beneath the previous task
                    If i > prevLevel Then
                        ' assign previous taskId as the parentId
                        parentId = taskId
                        ' store parentID for this 'level' of the task structure
                        '                        Response.Write("parentid: " & parentId & ". i: " & i & "<br />")
                        taskParentId(i) = parentId

                        Session("taskParentId") = taskParentId
                    Else
                        ' use parentId from the level above
                        parentId = taskParentId(i)
                    End If

                    ' insert a new task and retrieve its id as parentId
                    Try
                        taskId = insertTask(taskName, keywords, unitId, minutes, buildPhase, parentId, counter)
                        'Response.Write("<b>" & counter & ". " & taskName & "</b><br /><small>Keywords: " & keywords & ". ParentId: " & parentId & ".</small><br />")
                        Response.Write(i & ".<br />")
                        Response.Flush()
                    Catch ex As Exception
                        Response.Write("ERROR:" & ex.Message)
                        Response.End()
                    End Try

                    Response.Flush()
                    prevLevel = i                           ' store the current task level
                End If

            Next
            counter += 1

            'Try
            '    insertValues(taskId, unitId, minutes, buildPhase)
            '    'Response.Write("<blockquote><small>TaskId: " & taskId & ".<br />UnitId: " & unitId & ".<br />Minutes: " & minutes & ".<br />BuildPhase: " & buildPhase & "</small></blockquote>")
            '    Response.Write(".")
            '    Response.Flush()
            'Catch ex As Exception
            '    Response.Write("ERROR:" & ex.Message)
            '    Response.End()
            'End Try

            k += 1
            line = filestream.ReadLine
        Loop

        filestream.Close()

        Response.Write("<h1>Import Complete</h1>")
        Response.End()
    End Sub


    Protected Function insertTask(ByVal taskName As String, ByVal keywords As String, ByVal unitId As String, ByVal minutes As String, ByVal buildPhase As String, ByVal parentId As String, ByVal sequence As String) As Integer
        ' insert task
        Try
            Dim connString As String = System.Configuration.ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString
            Dim myConn As New SqlConnection(connString)
            Dim myCmd As New SqlCommand("INSERT INTO tblTaskData(taskName, keywords, unitId, minutes, buildPhaseId, parentId, sequence) VALUES (@taskName, @keywords, @unitId, @minutes, @buildPhaseId, @parentId, @sequence); SELECT scope_identity() AS returnidentity", myConn)
            myCmd.Parameters.AddWithValue("@taskName", taskName)
            myCmd.Parameters.AddWithValue("@unitId", unitId)
            myCmd.Parameters.AddWithValue("@minutes", minutes)
            myCmd.Parameters.AddWithValue("@buildPhaseId", buildPhase)
            myCmd.Parameters.AddWithValue("@keywords", keywords)
            If Not IsNumeric(parentId) Then parentId = 0
            myCmd.Parameters.AddWithValue("@parentId", parentId)
            myCmd.Parameters.AddWithValue("@sequence", sequence)

            myConn.Open()
            parentId = myCmd.ExecuteScalar()
            myConn.Close()

            myCmd.Dispose()
            myConn.Dispose()
        Catch Ex As Exception
            Response.Write("<div style=""border: 1px solid #600; background: #dedede; padding: 1em; margin: 1em"">")
            Response.Write("<h2>An error occured.</h2>")
            Response.Write(Ex.Message & "<br />")
            Response.Write("Date: " & Now() & "<br />")
            Response.Write("Task Name: " & taskName & "<br />")
            Response.Write("Keywords: " & keywords & "<br />")
            Response.Write("ParentId: " & parentId & "<br />")
            Response.Write("Sequence: " & sequence & "<br />")
            Response.Write("</div>")
            Response.End()
        End Try

        Return parentId
    End Function

End Class
