Imports System.Data
Imports System.Data.SqlClient

Partial Class Manager
    Inherits System.Web.UI.MasterPage

    Dim user As MembershipUser
    Dim userId As String
    Dim subscriptionDate As Date
    Dim paypalPayerId As String
    Public user_email As String

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        user = Membership.GetUser
        userId = user.ProviderUserKey.ToString

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
    End Sub

    Protected Sub getUserProfile()
        If Not IsNothing(user) Then
            ' get user profile information
            Dim connString As String = System.Configuration.ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString
            Dim myConn As New SqlConnection(connString)
            Dim cmd As SqlCommand = New SqlCommand("SELECT name, email, vatnumber, help, tourPhase, tooltips, subscription, paypalPayerId FROM UserProfile WHERE userId = @userId", myConn)
            cmd.Parameters.AddWithValue("@userId", userId)
            Dim reader As SqlDataReader

            Try
                myConn.Open()
                reader = cmd.ExecuteReader

                While reader.Read
                    Session("tooltips") = reader("tooltips").ToString
                    Session("subscriptionDate") = reader("subscription").ToString
                    subscriptionDate = Session("subscriptionDate")
                    Session("paypalPayerId") = reader("paypalPayerId").ToString
                    paypalPayerId = Session("paypalPayerId").ToString
                    Session("name") = reader("name").ToString
                    Session("tourPhase") = reader("tourPhase").ToString
                    Session("email") = reader("email").ToString
                    Session("vatnumber") = reader("vatnumber").ToString
                    user_email = Session("email")
                End While

            Catch ex As Exception
                myConn.Close()
            End Try
        End If
    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        setTour()
    End Sub

    Protected Sub setTour()
        ' Define the name and type of the client scripts on the page.
        Dim csname1 As String = "TourScript"
        Dim cstype As Type = Me.GetType()

        ' Get a ClientScriptManager reference from the Page class.
        Dim cs As ClientScriptManager = Page.ClientScript

        ' Check to see if the startup script is already registered.
        If (Not cs.IsStartupScriptRegistered(cstype, csname1)) Then
            Dim cstext1 As String = "bm.tour.current_phase = " + Session("tourPhase") + ";"
            cs.RegisterStartupScript(cstype, csname1, cstext1, True)
        End If
    End Sub
End Class