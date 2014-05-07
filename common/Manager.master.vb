Imports System.Data
Imports System.Data.SqlClient

Partial Class Manager
    Inherits System.Web.UI.MasterPage

    Dim user As MembershipUser = Membership.GetUser
    Dim userId As String = user.ProviderUserKey.ToString
    Dim subscriptionDate As Date
    Dim paypalPayerId As String
    Dim showHelp As Boolean
    Public user_email As String

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        ' set userid
        Session("UserID") = userId

        ' get user profile
        getUserProfile()

        ' check for project id
        If Request.QueryString("pid") > 0 Then
            ' link back to project and variation in the Variation Mode statusbar
            hlAddVariation.NavigateUrl = String.Format("~/project_details.aspx?pid={0}&action=add_variation", Request.QueryString("pid"))
            hlProjectStatus.NavigateUrl = String.Format("~/project_details.aspx?pid={0}", Request.QueryString("pid"))
        End If

        ' check if tour alert has been confirmed already this session
        If Session("tour_alert") Then pTourAlert.Visible = False

        '' check subscription date and calculate access permissions
        'Dim dateDiff As TimeSpan = DateTime.Today - Convert.ToDateTime(subscriptionDate)
        'Dim duration As String = dateDiff.TotalDays.ToString

        'Select Case duration
        '    Case Is >= 180
        '        ' expired account. there has been no subscription for 6 months. prevent access to the system
        '        Session("lockedAccount") = True
        '        nav.Visible = False
        '    Case Is >= 30
        '        ' lock the account, the subscription is over 30 days out of date
        '        Session("lockedAccount") = True
        '        nav.Visible = False
        '    Case Is >= 1
        '        ' subscription has expired. check for paypal account
        '        If IsNumeric(paypalPayerId) Then
        '            ' user had a subscription but now expired so just limit their account
        '            Session("limitedAccount") = True
        '        Else
        '            ' trial account so lock it
        '            Session("lockedAccount") = True
        '            nav.Visible = False
        '        End If

        '    Case Else
        '        ' subscription is valid
        '        Session("limitedAccount") = False
        'End Select

        '' account is locked, redirect to the subscription page if not already there
        'Dim currentpage As String = System.IO.Path.GetFileName(System.Web.HttpContext.Current.Request.Url.AbsolutePath)
        'If Session("lockedAccount") And currentpage <> "subscription.aspx" Then
        '    Response.Redirect("~/subscription.aspx")
        'End If
    End Sub

    Protected Sub getUserProfile()
        If Not IsNothing(user) Then
            ' get user profile information
            Dim connString As String = System.Configuration.ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString
            Dim myConn As New SqlConnection(connString)
            Dim cmd As SqlCommand = New SqlCommand("SELECT name, email, vatnumber, help, tooltips, subscription, paypalPayerId FROM UserProfile WHERE userId = @userId", myConn)
            cmd.Parameters.AddWithValue("@userId", userId)
            Dim reader As SqlDataReader

            Try
                myConn.Open()
                reader = cmd.ExecuteReader

                While reader.Read
                    Session("help") = reader("help").ToString
                    showHelp = Session("help")
                    Session("tooltips") = reader("tooltips").ToString
                    Session("subscriptionDate") = reader("subscription").ToString
                    subscriptionDate = Session("subscriptionDate")
                    Session("paypalPayerId") = reader("paypalPayerId").ToString
                    paypalPayerId = Session("paypalPayerId").ToString
                    Session("name") = reader("name").ToString
                    Session("email") = reader("email").ToString
                    Session("vatnumber") = reader("vatnumber").ToString
                    user_email = Session("email")

                    lblFirstname.Text = Session("name").ToString
                End While

            Catch ex As Exception
                Trace.Write(ex.ToString)
                myConn.Close()
            End Try
        End If
    End Sub

    Protected Sub btnTourCancel_Click(sender As Object, e As EventArgs) Handles btnTourCancel.Click
        Session("tour_alert") = True
        showHelp = 0
        Session("help") = showHelp
        pTourAlert.Visible = False
        hfTour.Value = 0

        ' update user profile to record the fact we don't want to see the help any more
        Dim connString As String = System.Configuration.ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString
        Dim myConn As New SqlConnection(connString)
        Dim cmd As SqlCommand = New SqlCommand("UPDATE UserProfile SET help=0 WHERE userId = @userId", myConn)
        cmd.Parameters.AddWithValue("@userId", userId)

        Try
            myConn.Open()
            cmd.ExecuteScalar()

        Catch ex As Exception
            Trace.Write(ex.ToString)
            myConn.Close()
        End Try
    End Sub

    Protected Sub btnTourConfirm_Click(sender As Object, e As EventArgs) Handles btnTourConfirm.Click
        Session("tour_alert") = True
        pTourAlert.Visible = False
    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        ' if help is false then don't pop-up the tour window
        If Not showHelp Then
            hfTour.Value = 0
            pTourAlert.Visible = False
            Session("tour_alert") = True
        End If
    End Sub
End Class