Imports System.Data.SqlClient
Imports Encore.PayPal.Nvp
Imports Telerik.Web.UI
Imports subscription

Partial Class manager_subscription
    Inherits MyBaseClass

    Dim subscription As subscription = New subscription

    Const subscriptionActive As String = "Active"
    Const subscriptionPending As String = "Pending"
    Const subscriptionCancelled As String = "Cancelled"
    Const subscriptionSuspended As String = "Suspended"
    Const subscriptionExpired As String = "Expired"
    Const subscriptionError As String = "Error"

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        'subscription.userid = Session("userId")
        'subscription.email = Session("email")
        subscription.setSessionData(Session)
        'subscription.setPaypalPayerIdFromSession(Session)

        checkSubscription()
    End Sub

    Protected Sub checkSubscription()
        ' get existing token from somewhere??
        'subscription.paypalPayerId = Session("paypalPayerId")
        'Dim paypalPayerId As String = Session("paypalPayerId")
        'subscription.paypalPayerId = Session("paypalPayerId")

        ' Check if the subscription sign-up was successful
        ' This comes as a redirect from CreateRecurringPaymentsProfile()
        If Request.QueryString("subscription") = "success" Then
            showNotification("Subscription Activated", "You have successfully subscribed to Buildmate. Thank you for your continued support :)")
            Return
        End If

        ' check for a new subscription sign-up
        confirmNewSubscription()

        Dim accountStatus As String = subscription.check()

        ' If User has a PaypalPayerID display their payment profile details
        'If subscription.paypalPayerId Then
        ' profile exists - check if the profile is active
        'Dim checkPayPalAccountStatus = subscription.getRecurringPaymentsProfileDetails()

        Select Case accountStatus
            Case subscriptionActive
                ' subscription is currently active
                panelSubscriptionActive.Visible = True
                panelSuspend.Visible = True
                panelCancel.Visible = True

            Case subscriptionPending
                ' subscription is pending approval?
                panelSubscriptionPending.Visible = True
                panelSuspend.Visible = True
                panelCancel.Visible = True

            Case subscriptionCancelled
                ' your subscription is currently cancelled
                panelSubscriptionCancelled.Visible = True
                'setSubscription.Visible = True
                'panelSubscribe.Visible = True
                'panelReactivate.Visible = True
                'Label1.Text = "Subscription Cancelled"
                'setSubscription.Visible = True
                'panelSubscribe.Visible = True
                'panelReactivate.Visible = True
                'btnReactivate.Visible = False
                'panelSuspend.Visible = False
                'panelCancel.Visible = False

                'SetCustomerBillingAgreement()       ' create a customer billing agreement

            Case subscriptionSuspended
                ' your subscription is currently suspended
                ' display reactivate button.
                ' display cancel button
                panelSubscriptionSuspended.Visible = panelReactivate.Visible = True
                'Label1.Text = "Subscription Suspended"
                setSubscription.Visible = False
                'panelSubscribe.Visible = False
                panelReactivate.Visible = True
                'btnReactivate.Visible = True
                btnSuspend.Visible = False
                btnCancel.Visible = True

            Case subscriptionExpired
                ' your subscription has expired
                ' click here to renew your subscription
                panelSubscriptionExpired.Visible = setSubscription.Visible = True
                'Label1.Text = "Subscription Expired."
                setSubscription.Visible = True
                'panelSubscribe.Visible = True
                'btnReactivate.Visible = False
                btnSuspend.Visible = False
                btnCancel.Visible = False
            Case subscriptionError
                ' something bad happened. the paypalPayID might be wrong
                panelSubscriptionError.Visible = True
                pSubscriptionNotFound.Visible = True
                'confirmSubscription()
        End Select
    End Sub

    Protected Sub confirmNewSubscription()
        Dim queryToken = Request.QueryString("token")
        Trace.Write("Query Token = " + queryToken)
        Trace.Write("Subscription.token = " + subscription.Token)
        If Not queryToken Is Nothing Then
            subscription.confirm(queryToken)
            'subscription.Token = queryToken
            ' display confirm subscription form
            'subscription.Token
            'subscription.setToken(queryToken)
            fvConfirmSubscription.Visible = True
        Else
            panelSubscribe.Visible = True
        End If


        ''subscription.token = Request.QueryString("token")
        ''Dim token As String = Request.QueryString("token")
        'If Not token Is Nothing Then
        '    ' confirm subscription 
        '    panelSubscribe.Visible = False
        '    fvConfirmSubscription.Visible = True
        'Else
        '    'Label1.Text = "You do not have a subscription"
        '    panelSubscribe.Visible = True
        'End If
    End Sub

    'Protected Sub createLabel(ByVal label As String, ByVal body As String)
    '    lblProfile.Text += "<div class='row'><label class='label'>" & label & "</label>&nbsp;" & body & "</div>"
    'End Sub

    Protected Sub btnReactivate_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim profileId As String = subscription.reactivate()
        Trace.Write(profileId)
        'If Not profileId Is Nothing Then Response.Redirect("subscription.aspx")
    End Sub

    Protected Sub btnSuspend_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim profileId As String = subscription.suspend()
        If Not profileId Is Nothing Then Response.Redirect("subscription.aspx")
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim profileId As String = subscription.cancel()
        If Not profileId Is Nothing Then Response.Redirect("subscription.aspx")
    End Sub

    Protected Sub displayErrorToClient(ByVal errString As String)
        pError.Visible = True
        lblError.Text = errString
    End Sub

    Protected Sub btnConfirmSubscription_OnClick(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim firstname As String = CType(fvConfirmSubscription.FindControl("rtFirstName"), RadTextBox).Text.ToString
        Dim surname As String = CType(fvConfirmSubscription.FindControl("rtSurname"), RadTextBox).Text.ToString
        'Dim token As String = Request.QueryString("token")
        subscription.CreatePaymentProfile(firstname, surname)
        'subscription.PaypalPayerId

        If Not subscription.PaypalPayerId Is Nothing Then
            Response.Redirect("subscription.aspx?subscription=success")
        Else
            ' there was an error
            lblError.Text = "<b>Subscription Problem</b><br />There was a problem while trying to subscribe, it may be because you have already created a subscription."
            pError.Visible = True
        End If
    End Sub

    ' set default subscription to the first in the list
    Protected Sub rblSubscription_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles rblSubscription.Init
        rblSubscription.SelectedIndex = 0
    End Sub

    Protected Sub btnSubscribe_Click(sender As Object, e As EventArgs) Handles btnSubscribe.Click
        Dim subscriptionType As String = rblSubscription.SelectedValue
        subscription.create(subscriptionType)
        'Dim token As String = subscription.create(subscriptionType)
        If Not subscription.Token Is Nothing Then
            ' redirect the user to paypal where they can continue with the subscription
            Response.Redirect("https://www.sandbox.paypal.com/webscr?cmd=_customer-billing-agreement&token=" & subscription.Token)
        Else
            lblError.Text = "<b>Subscription Problem</b><br />There was a problem while trying to create a payment token."
            pError.Visible = True
        End If
    End Sub
End Class