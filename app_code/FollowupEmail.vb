Imports Microsoft.VisualBasic
Imports System.Net.Mail
Imports System.Data.SqlClient
Imports System.Data

Namespace Buildmate
    Public Class FollowupEmail
        Dim mailDigest As New Buildmate.MailDigest

        Public Sub introduction()
            Dim sqlSelectCommand As String = "SELECT aspnet_Membership.userid, firstname, aspnet_Membership.email" &
            " FROM aspnet_Membership" &
            " LEFT JOIN UserProfile ON aspnet_Membership.UserId = UserProfile.userid" &
            " WHERE aspnet_Membership.Email Is Not null" &
            " AND datediff(DD, createDate, getdate()) > 1" &
            " AND notifyByEmail=1" &
            " AND NOT EXISTS(" &
            " 	SELECT * FROM EmailNotification WHERE userid = aspnet_Membership.UserId AND EmailType='FOLLOWUP'" &
            " )"
            Try
                Dim adapter As New SqlDataAdapter(sqlSelectCommand, System.Configuration.ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString)
                Dim dataTable As New DataTable()
                adapter.Fill(dataTable)

                For Each dr In dataTable.Rows
                    Dim userid As String = dr("UserId").ToString()
                    Dim firstname As String = dr("firstname").ToString()
                    Dim email As String = dr("email").ToString()

                    ' email the daily digest for this user
                    mailDigest.introduction(email, firstname)
                    FollowupSent(userid)
                Next
            Catch ex As Exception
                'Trace.Write(ex.ToString)
            End Try
        End Sub

        Protected Sub FollowupSent(ByVal userid As String)
            Try
                Dim connString As String = System.Configuration.ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString
                Dim myConn As New SqlConnection(connString)
                Dim myCmd As New SqlCommand("INSERT INTO EmailNotification(UserId, EmailType) VALUES(@userId, 'FOLLOWUP');", myConn)
                myCmd.Parameters.AddWithValue("@UserId", userid)

                myConn.Open()
                myCmd.ExecuteScalar()
                myConn.Close()

                myCmd.Dispose()
                myConn.Dispose()
            Catch Ex As Exception
                'Response.End()
            End Try
        End Sub
    End Class
End Namespace