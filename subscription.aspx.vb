Imports System.Data.SqlClient
Imports Encore.PayPal.Nvp
Imports Telerik.Web.UI

Partial Class manager_subscription
    'Inherits System.Web.UI.Page
    Inherits MyBaseClass

    Dim userId As String
    'Dim paypalPayerId As String
    'Dim token As String

    Const subscriptionActive As String = "Active"
    Const subscriptionPending As String = "Pending"
    Const subscriptionCancelled As String = "Cancelled"
    Const subscriptionSuspended As String = "Suspended"
    Const subscriptionExpired As String = "Expired"
    Const subscriptionError As String = "Error"

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        userId = Session("userId")
        'paypalPayerId = Session("paypalPayerId")    ' check for paypalPayerId. Allows us to identify an account with a subscription, expired or otherwise
        'token = Request.QueryString("token")

        'Dim lockedAccount As Boolean = Convert.ToBoolean(Session("lockedAccount"))

        ' If User has a PaypalPayerID display their payment profile details
        checkSubscription()

        ' Check for a subscription confirmation
        'showSubscriptionConfirmation()

        ' Check if the subscription sign-up was successful
        'displaySuccess()
    End Sub

    'Protected Sub displaySuccess()
    '    ' Check if the subscription sign-up was successful
    '    ' This comes as a redirect from CreateRecurringPaymentsProfile()
    '    If Request.QueryString("subscription") = "success" Then
    '        showNotification("Subscription Activated", "You have successfully subscribed to Buildmate. Thank you for your continued support :)")
    '        pSuccess.Visible = True
    '    End If
    'End Sub

    Protected Sub showSubscriptionConfirmation()
        ' Check if Token was returned from paypal
        Dim token As String = Request.QueryString("token")

        ' If so, the user is attempting to subscribe
        If Len(token) > 0 Then
            ' The user still needs to confirm their subscription
            ' Display the confirmation form

            ' show confirmation of the subscription details selected by the user
            'lblPaymentPlan.Text = subscription
            fvConfirmSubscription.Visible = True
            'panelSubscribe.Visible = False
            'btnConfirmSubscription.Visible = True
            'Label1.Text = "Confirm your Subscription"
            'rtFirstname.Text = Session("firstname")
            'rtSurname.Text = Session("lastname")
            'rmpSubscription.SelectedIndex = 1

            ' Retrieve the subscription type
            ' The Type was saved to the Users profile before they were directed to Paypal
            'Dim connString As String = System.Configuration.ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString
            'Dim myConn As New SqlConnection(connString)
            'Dim cmd As SqlCommand = New SqlCommand("SELECT firstname, surname, UserSubscriptionType.subscription FROM UserProfile LEFT JOIN UserSubscriptionType ON UserSubscriptionType.id = subscriptionType WHERE userId = @userId", myConn)
            'cmd.Parameters.AddWithValue("@userId", userId)
            'Dim reader As SqlDataReader

            'Try
            '    myConn.Open()
            '    reader = cmd.ExecuteReader

            '    While reader.Read
            '        ' subscription details
            '        Dim subscription As String = reader("subscription").ToString

            '        ' show confirmation of the subscription details selected by the user
            '        lblPaymentPlan.Text = subscription
            '        btnConfirmSubscription.Visible = True
            '        Label1.Text = "Confirm your Subscription"
            '        rtFirstname.Text = Session("firstname")
            '        rtSurname.Text = Session("lastname")
            '        rmpSubscription.SelectedIndex = 1
            '    End While

            'Catch ex As Exception
            '    Trace.Write(ex.ToString)
            '    myConn.Close()
            'End Try
        End If
    End Sub

    'Protected Sub displaySubscriptionStatus()
    '    ' subscription is currently active
    '    Label1.Text = "Active Subscription"
    '    rmpSubscription.SelectedIndex = 0
    '    setSubscription.Visible = False
    '    panelSubscribe.Visible = False
    '    btnReactivate.Visible = False
    '    btnSuspend.Visible = True ' display suspend button
    '    btnCancel.Visible = True ' display cancel button
    'End Sub

    Protected Sub checkSubscription()
        ' get existing token from somewhere??
        Dim paypalPayerId As String = Session("paypalPayerId")

        ' Check if the subscription sign-up was successful
        ' This comes as a redirect from CreateRecurringPaymentsProfile()
        If Request.QueryString("subscription") = "success" Then
            showNotification("Subscription Activated", "You have successfully subscribed to Buildmate. Thank you for your continued support :)")
            Return
        End If

        ' check for existing paypalPayerId
        If Len(paypalPayerId) >= 1 Then
            ' profile exists - check if the profile is active
            Dim checkPayPalAccountStatus = getRecurringPaymentsProfileDetails(paypalPayerId)

            checkPayPalAccountStatus = subscriptionPending
            Select Case checkPayPalAccountStatus
                Case subscriptionActive
                    ' subscription is currently active
                    paneleSubscriptionActive.Visible = panelSuspend.Visible = panelCancel.Visible = True

                Case subscriptionPending
                    ' subscription is pending approval?
                    panelSubscriptionPending.Visible = panelSuspend.Visible = panelCancel.Visible = True

                Case subscriptionCancelled
                    ' your subscription is currently cancelled
                    panelSubscriptionCancelled.Visible = setSubscription.Visible = panelReactivate.Visible = True
                    'Label1.Text = "Subscription Cancelled"
                    'setSubscription.Visible = True
                    'panelSubscribe.Visible = True
                    panelReactivate.Visible = True
                    'btnReactivate.Visible = False
                    'panelSuspend.Visible = False
                    'panelCancel.Visible = False

                    'SetCustomerBillingAgreement()       ' create a customer billing agreement

                Case subscriptionSuspended
                    ' your subscription is currently suspended
                    ' display reactivate button.
                    ' display cancel button
                    panelSubscriptionSuspended.Visible = panelReactivate.Visible = True
                    Label1.Text = "Subscription Suspended"
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
            End Select
        Else
            ' PROFILE DOESN'T EXIST
            confirmSubscription()


            ' check for returned token in querystring or if we need to show the subscribe form


            ' display the subscribe via paypal button.
            'Label1.Text = "You do not have a subscription"
            'setSubscription.Visible = True
            ''panelSubscribe.Visible = True
            'btnReactivate.Visible = False
            'btnSuspend.Visible = False
            'btnCancel.Visible = False

            'SetCustomerBillingAgreement()       ' create a customer billing agreement
        End If
    End Sub

    Protected Sub confirmSubscription()
        Dim token As String = Request.QueryString("token")
        Trace.Write("Token : " + token)
        If Len(token) >= 1 Then
            Trace.Write("confirm subscrtiption")
            ' confirm subscription 
            panelSubscribe.Visible = False
            fvConfirmSubscription.Visible = True
        Else
            'Label1.Text = "You do not have a subscription"
            panelSubscribe.Visible = True
        End If
    End Sub

    Protected Sub createLabel(ByVal label As String, ByVal body As String)
        lblProfile.Text += "<div class='row'><label class='label'>" & label & "</label>&nbsp;" & body & "</div>"
    End Sub

    Protected Function getRecurringPaymentsProfileDetails(ByVal paypalPayerId As String) As String
        Dim getAccountStatus As String = ""

        ' Retrieve the account status using GetRecurringPaymentsProfileDetails
        Dim ppPay As NvpGetRecurringPaymentsProfileDetails = New NvpGetRecurringPaymentsProfileDetails
        ppPay.Add(NvpCommonRequest.USER, Application.Item("paypalUser"))
        ppPay.Add(NvpCommonRequest.PWD, Application.Item("paypalPwd"))
        ppPay.Add(NvpCommonRequest.SIGNATURE, Application.Item("paypalSignature"))
        ppPay.Add(NvpGetRecurringPaymentsProfileDetails.Request.PROFILEID, paypalPayerId)

        ' post the API call
        If ppPay.Post Then
            getAccountStatus = ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.STATUS)

            ' 
            lblProfile.Text = ""
            createLabel("Description", ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.DESC))
            createLabel("Status", getAccountStatus)
            createLabel("Subscriber", ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.SUBSCRIBERNAME))
            createLabel("Account Ref", ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.PROFILEREFERENCE))
            createLabel("Billing Period", ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.BILLINGPERIOD))
            createLabel("Amount", String.Format("{0:c}", Double.Parse(ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.AMT))))
            createLabel("Start Date ", String.Format("{0:dd MMM yyyy}", Convert.ToDateTime(ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.PROFILESTARTDATE))))
            createLabel("Last Payment Date", String.Format("{0:dd MMM yyyy}", Convert.ToDateTime(ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.LASTPAYMENTDATE))))
            createLabel("Next Billing Date", String.Format("{0:dd MMM yyyy}", Convert.ToDateTime(ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.NEXTBILLINGDATE))))

            'createLabel("Billing Amount", ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.AUTOBILLOUTAMT))
            'createLabel("MAXFAILEDPAYMENTS", ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.MAXFAILEDPAYMENTS))
            'createLabel("BILLINGFREQUENCY", ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.BILLINGFREQUENCY))
            'createLabel("TOTALBILLINGCYCLES", ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.TOTALBILLINGCYCLES))

            ' recurring payments summary
            'createLabel("NUMCYCYLESCOMPLETED", ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.NUMCYCLESCOMPLETED))
            'createLabel("NUMCYCLESREMAINING", ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.NUMCYCLESREMAINING))
            'createLabel("OUTSTANDINGBALANCE", ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.OUTSTANDINGBALANCE))
            'createLabel("FAILEDPAYMENTCOUNT", ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.FAILEDPAYMENTCOUNT))
            'createLabel("LASTPAYMENTAMT", ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.LASTPAYMENTAMT))

            'credit card details
            'createLabel("ACCT", ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.ACCT))
            'createLabel("CREDITCARDTYPE", ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.CREDITCARDTYPE))
            'createLabel("EXPDATE", ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.EXPDATE))
            'createLabel("ISSUENUMBER", ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.ISSUENUMBER))

            ' payer info
            'createLabel("First Name", ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.FIRSTNAME))
            'createLabel("Last Name", ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.LASTNAME))

            ' address
            'createLabel("Street", ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.STREET))
            'createLabel("Street 2", ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.STREET2))
            'createLabel("City", ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.CITY))
            'createLabel("State", ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.STATE))
            'createLabel("Country", ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.COUNTRYCODE))
            'createLabel("Postcode", ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.ZIP))
        Else
            ' Check was unsuccessful. Take appropriate action.
            pSubscriptionNotFound.Visible = True
            pPaypalPanel.Visible = False
            pSubscriptionPanel.Visible = False

            'lblProfile.Text = "<p>We were unable to retrieve your PayPal Subscription details right now, please check again later.</p><p>If this problem persists, please <a href='support.aspx'>contact support</a></p>"

            ' hide subscription block

            ' email support with error notification
            If ppPay.ErrorList.Count > 0 Then
                Dim errorText As String = ppPay.ErrorList(0).Code & "<br />"
                errorText += ppPay.ErrorList(0).Severity & "<br />"
                errorText += ppPay.ErrorList(0).ShortMessage & "<br />"
                errorText += ppPay.ErrorList(0).LongMessage
                errorMsg.Text = errorText
                'sendErrorToAdmin(errorText)
            End If
            getAccountStatus = "Error"
        End If

        Return getAccountStatus
    End Function

    Protected Sub btnReactivate_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim profileId As String = ManageRecurringPaymentsProfileStatus("Reactivate")
        If profileId.Length > 0 Then
            checkSubscription()
            logEvent("Reactivated Subscription")
        End If
    End Sub

    Protected Sub btnSuspend_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim profileId As String = ManageRecurringPaymentsProfileStatus("Suspend")

        If profileId.Length > 0 Then
            checkSubscription()
            logEvent("Suspended Subscription")
        End If

    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim profileId As String = ManageRecurringPaymentsProfileStatus("Cancel")

        If profileId.Length > 0 Then
            checkSubscription()
            logEvent("Cancelled Subscription")
        End If
    End Sub

    ' This allows us to reactive, suspend or cancel the current subscription
    Protected Function ManageRecurringPaymentsProfileStatus(ByVal actionType As String) As String
        Dim paypalPayerId As String = Session("paypalPayerId")
        ' manage the recurring payment
        Dim ppPay As NvpManageRecurringPaymentsProfileStatus = New NvpManageRecurringPaymentsProfileStatus
        ppPay.Add(NvpCommonRequest.USER, Application.Item("paypalUser"))
        ppPay.Add(NvpCommonRequest.PWD, Application.Item("paypalPwd"))
        ppPay.Add(NvpCommonRequest.SIGNATURE, Application.Item("paypalSignature"))
        ppPay.Add(NvpManageRecurringPaymentsProfileStatus.Request.PROFILEID, paypalPayerId)
        ppPay.Add(NvpManageRecurringPaymentsProfileStatus.Request.ACTION, actionType)

        ' post the API call 
        If ppPay.Post Then
            Return ppPay.Get(NvpManageRecurringPaymentsProfileStatus.Response.PROFILEID)
        Else
            Dim errString As String = ppPay.ErrorList(0).Code
            errString += ppPay.ErrorList(0).Severity
            errString += ppPay.ErrorList(0).ShortMessage
            errString += ppPay.ErrorList(0).LongMessage

            Return errString
        End If
    End Function

    Protected Function generateToken() As String
        Dim token As String = ""
        Dim userEmail As String = Session("email")

        If Len(userEmail) > 0 Then
            ' create the DoDirectpayment object
            Dim ppPay As NvpSetCustomerBillingAgreement = New NvpSetCustomerBillingAgreement
            ppPay.Add(NvpCommonRequest.USER, Application.Item("paypalUser"))
            ppPay.Add(NvpCommonRequest.PWD, Application.Item("paypalPwd"))
            ppPay.Add(NvpCommonRequest.SIGNATURE, Application.Item("paypalSignature"))

            ' add the required parameters
            ppPay.Add(NvpSetCustomerBillingAgreement.Request._RETURNURL, "http://buildmateapp.com/subscription.aspx")
            ppPay.Add(NvpSetCustomerBillingAgreement.Request._CANCELURL, "http://buildmateapp.com/subscription_cancel.aspx")
            ppPay.Add(NvpSetCustomerBillingAgreement.Request._BILLINGTYPE, NvpBillingCodeType.RecurringPayments)
            ppPay.Add(NvpSetCustomerBillingAgreement.Request.BILLINGAGREEMENTDESCRIPTION, "Buildmate Subscription")
            ppPay.Add(NvpSetCustomerBillingAgreement.Request.EMAIL, userEmail)

            ' post the API call
            If ppPay.Post Then
                ' successfully created a customer billing agreement
                token = ppPay.Get(NvpSetCustomerBillingAgreement.Response.TOKEN)
                'panelSubscribe.Visible = True
            Else
                ' Error - Take appropriate action.
                Label1.Text = ppPay.ErrorList(0).Code
                Label1.Text += ppPay.ErrorList(0).Severity
                Label1.Text += ppPay.ErrorList(0).ShortMessage
                Label1.Text += ppPay.ErrorList(0).LongMessage
            End If
        End If

        Return token
    End Function

    Protected Sub btnConfirmSubscription_OnClick(ByVal sender As Object, ByVal e As System.EventArgs)
        CreateRecurringPaymentsProfile()
    End Sub

    Protected Function generateProfileReference() As String
        Dim randomClass As New Random()
        Dim uid As String = randomClass.Next(1000, 9999)
        Dim profileReference = DateTime.Now.ToString("mmHH-ddMM-yyyy-") + uid
        Return profileReference
    End Function

    Protected Sub CreateRecurringPaymentsProfile()
        ' Generate a profile reference number
        Dim profileReference As String = generateProfileReference()

        ' get firstname/surname from the form
        Dim firstname As String = CType(fvConfirmSubscription.FindControl("rtFirstName"), RadTextBox).Text.ToString
        Dim surname As String = CType(fvConfirmSubscription.FindControl("rtSurname"), RadTextBox).Text.ToString

        ' retrieve the subscription type
        ' this was saved in the users profile before they were directed to paypal
        Dim connString As String = System.Configuration.ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString
        Dim myConn As New SqlConnection(connString)
        Dim cmd As SqlCommand = New SqlCommand("SELECT billingAmount, billingFrequency, billingPeriod, UserSubscriptionType.subscription FROM UserProfile LEFT JOIN UserSubscriptionType ON UserSubscriptionType.id = subscriptionType WHERE userId = @userId", myConn)
        cmd.Parameters.AddWithValue("@userId", userId)
        Dim reader As SqlDataReader

        Try
            myConn.Open()
            reader = cmd.ExecuteReader

            While reader.Read
                ' subscription details
                Dim subscription As String = reader("subscription").ToString
                Dim billingAmount As Double = Double.Parse(reader("billingAmount").ToString)
                Dim billingFrequency As String = reader("billingFrequency").ToString
                Dim billingPeriod As String = reader("billingPeriod").ToString

                'Trace.Write("PROFILREFERENCE: PID " & userId)
                'Trace.Write("PROFILESTARTDATE: " & DateTime.Now.ToUniversalTime().ToString("o"))
                'Trace.Write("CURRENCYCODE: " & NvpCurrencyCodeType.PoundSterling)
                'Trace.Write("FIRSTNAME: " & rtFirstname.Text)
                'Trace.Write("LASTNAME: " & rtSurname.Text)
                'Trace.Write("DESC: Buildmate Subscription (" & subscription & ")")
                'Trace.Write("_BILLINGPERIOD: " & billingPeriod)
                'Trace.Write("_BILLINGFREQUENCY: " & billingFrequency)
                'Trace.Write("_AMT:" & billingAmount)
                'Trace.Write("_TOKEN: " & Request.QueryString("token"))
                'Trace.Write("MAXFAILEDPAYMENTS: 0")
                'Trace.Write("AUTOBILLOUTAMT:" & NvpAutoBillType.AddToNextBilling)

                ' instantiate the recurring payment profile
                Dim ppPay As NvpCreateRecurringPaymentsProfile = New NvpCreateRecurringPaymentsProfile
                ppPay.Add(NvpCommonRequest.USER, Application.Item("paypalUser"))
                ppPay.Add(NvpCommonRequest.PWD, Application.Item("paypalPwd"))
                ppPay.Add(NvpCommonRequest.SIGNATURE, Application.Item("paypalSignature"))

                ' add the required parameters
                ppPay.Add(NvpCreateRecurringPaymentsProfile.Request.PROFILEREFERENCE, profileReference)
                ppPay.Add(NvpCreateRecurringPaymentsProfile.Request._PROFILESTARTDATE, DateTime.Now.ToUniversalTime().ToString("o"))
                ppPay.Add(NvpCreateRecurringPaymentsProfile.Request.CURRENCYCODE, NvpCurrencyCodeType.PoundSterling)
                ppPay.Add(NvpCreateRecurringPaymentsProfile.Request._FIRSTNAME, firstname)
                ppPay.Add(NvpCreateRecurringPaymentsProfile.Request._LASTNAME, surname)
                ppPay.Add(NvpCreateRecurringPaymentsProfile.Request._DESC, "Buildmate Subscription")
                ppPay.Add(NvpCreateRecurringPaymentsProfile.Request._BILLINGPERIOD, billingPeriod)
                ppPay.Add(NvpCreateRecurringPaymentsProfile.Request._BILLINGFREQUENCY, billingFrequency)
                ppPay.Add(NvpCreateRecurringPaymentsProfile.Request._AMT, billingAmount)
                ppPay.Add(NvpCreateRecurringPaymentsProfile.Request._TOKEN, Request.QueryString("token"))
                ppPay.Add(NvpCreateRecurringPaymentsProfile.Request.MAXFAILEDPAYMENTS, 0)
                ppPay.Add(NvpCreateRecurringPaymentsProfile.Request.AUTOBILLOUTAMT, NvpAutoBillType.AddToNextBilling)


                'ppPay.Add(NvpCreateRecurringPaymentsProfile.Request._BILLINGPERIOD, billingPeriod)
                'ppPay.Add(NvpCreateRecurringPaymentsProfile.Request._BILLINGFREQUENCY, billingFrequency)
                'ppPay.Add(NvpCreateRecurringPaymentsProfile.Request._AMT, billingAmount)
                'ppPay.Add(NvpCreateRecurringPaymentsProfile.Request._TOKEN, Request.QueryString("token"))
                'ppPay.Add(NvpCreateRecurringPaymentsProfile.Request.MAXFAILEDPAYMENTS, 0)
                'ppPay.Add(NvpCreateRecurringPaymentsProfile.Request.AUTOBILLOUTAMT, NvpAutoBillType.AddToNextBilling)



                ' post the API call
                If ppPay.Post Then
                    ' Payment was successful. Display the results
                    Dim profileId As String = ppPay.Get(NvpCreateRecurringPaymentsProfile.Response.PROFILEID)

                    If profileId.Length > 0 Then
                        ' insert profileid for recurring payment plan
                        savePaypalProfileId(profileId)
                        logEvent("Payment was succcessful.")
                        Response.Redirect("subscription.aspx?subscription=success")
                    End If
                Else
                    ' creation of recurring payment failed
                    ' check if payment profile exists (maybe due to a duplicate post-back)
                    'rmpSubscription.SelectedIndex = 0

                    Dim errString As String = ppPay.ErrorList(0).Code
                    errString += ppPay.ErrorList(0).Severity
                    errString += ppPay.ErrorList(0).ShortMessage
                    errString += ppPay.ErrorList(0).LongMessage
                    Trace.Write(errString)
                    sendErrorToAdmin(errString)

                    lblError.Text = "<b>Subscription Problem</b><br />There was a problem while trying to subscribe, it may be because you have already created a subscription."
                    pError.Visible = True
                End If
            End While
        Catch ex As Exception
            Trace.Write(ex.ToString)
            myConn.Close()
        End Try
    End Sub

    Protected Sub savePaypalProfileId(ByVal profileId As String)
        Dim connString As String = System.Configuration.ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString
        Dim myConn As New SqlConnection(connString)
        Dim cmd As SqlCommand = New SqlCommand("UPDATE UserProfile SET paypalPayerId = @profileId WHERE userId = @userId", myConn)
        cmd.Parameters.AddWithValue("@userId", userId)
        cmd.Parameters.AddWithValue("@profileId", profileId)
        Try
            myConn.Open()
            cmd.ExecuteReader()
            'rmpSubscription.SelectedIndex = 0
            btnSuspend.Visible = True
            btnCancel.Visible = True

        Catch ex As Exception
            Trace.Write(ex.ToString)
            myConn.Close()
        End Try
    End Sub

    Protected Sub pSubscription_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles pSubscription.Load
        checkSubscription()
    End Sub

    'Protected Sub getRecurringPaymentsProfileDetails()
    '    ' crete the DoDirectpayment object
    '    Dim ppPay As NvpGetRecurringPaymentsProfileDetails = New NvpGetRecurringPaymentsProfileDetails
    '    ppPay.Add(NvpCommonRequest.USER, Application.Item("paypalUser"))
    '    ppPay.Add(NvpCommonRequest.PWD, Application.Item("paypalPwd"))
    '    ppPay.Add(NvpCommonRequest.SIGNATURE, Application.Item("paypalSignature"))

    '    ' add the required parameters
    '    ppPay.Add(NvpGetRecurringPaymentsProfileDetails.Request.PROFILEID, paypalPayerId)

    '    ' post the API call
    '    If ppPay.Post Then
    '        ' Payment was successful. Display the results
    '        lblProfile.Text = "<label class=""label"">Status</label> " & ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.STATUS) & "<br />"
    '        'lblProfile.Text += "<label>DESC</label> " & ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.DESC) & "<br />"
    '        lblProfile.Text += "<label>AUTOBILLAMT</label> " & ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.AUTOBILLOUTAMT) & "<br />"
    '        lblProfile.Text += "<label>MAXFAILEDPAYMENTS</label> " & ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.MAXFAILEDPAYMENTS) & "<br />"
    '        lblProfile.Text += "<label>SUBSCRIBERNAME</label> " & ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.SUBSCRIBERNAME) & "<br />"
    '        lblProfile.Text += "<label>PROFILESTARTDATE</label> " & ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.PROFILESTARTDATE) & "<br />"
    '        lblProfile.Text += "<label>PROFILEREFERENCE</label> " & ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.PROFILEREFERENCE) & "<br />"
    '        lblProfile.Text += "<label>BILLINGPERIOD</label> " & ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.BILLINGPERIOD) & "<br />"
    '        lblProfile.Text += "<label>BILLINGFREQUENCY</label> " & ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.BILLINGFREQUENCY) & "<br />"
    '        lblProfile.Text += "<label>TOTALBILLINGCYCLES</label> " & ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.TOTALBILLINGCYCLES) & "<br />"
    '        lblProfile.Text += "<label>AMT</label> " & ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.AMT) & "<br />"

    '        ' recurring payments summary
    '        lblProfile.Text += "<label>NEXTBILLINGDATE</label> " & ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.NEXTBILLINGDATE) & "<br />"
    '        lblProfile.Text += "<label>NUMCYCYLESCOMPLETED</label> " & ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.NUMCYCLESCOMPLETED) & "<br />"
    '        lblProfile.Text += "<label>NUMCYCLESREMAINING</label> " & ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.NUMCYCLESREMAINING) & "<br />"
    '        lblProfile.Text += "<label>OUTSTANDINGBALANCE</label> " & ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.OUTSTANDINGBALANCE) & "<br />"
    '        lblProfile.Text += "<label>FAILEDPAYMENTCOUNT</label> " & ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.FAILEDPAYMENTCOUNT) & "<br />"
    '        lblProfile.Text += "<label>LASTPAYMENTDATE</label> " & ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.MAXFAILEDPAYMENTS) & "<br />"
    '        lblProfile.Text += "<label>LASTPAYMENTAMT</label>" & ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.LASTPAYMENTAMT) & "<br />"

    '        'credit card details
    '        'lblProfile.Text = "<label>ACCT</label> " & ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.ACCT) & "<br />"
    '        'lblProfile.Text += "<label>CREDITCARDTYPE</label" & ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.CREDITCARDTYPE) & "<br />"
    '        'lblProfile.Text += "<label>ACCT</label>" & ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.ACCT) & "<br />"
    '        'lblProfile.Text += "<label>EXPDATE</label> " & ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.EXPDATE) & "<br />"
    '        'lblProfile.Text += "<label>ISSUENUMBER</label> " & ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.ISSUENUMBER) & "<br />"

    '        ' payer info
    '        lblProfile.Text += "<label>First Name</label> " & ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.FIRSTNAME) & "<br />"
    '        lblProfile.Text += "<label>Last Name</label> " & ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.LASTNAME) & "<br />"

    '        ' address
    '        lblProfile.Text += "<label>Street</label> " & ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.STREET)
    '        lblProfile.Text += "<label>Street 2</label> " & ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.STREET2)
    '        lblProfile.Text += "<label>City</label> " & ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.CITY)
    '        lblProfile.Text += "<label>State</label> " & ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.STATE)
    '        lblProfile.Text += "<label>Country</label> " & ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.COUNTRYCODE)
    '        lblProfile.Text += "<label>Postcode</label> " & ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.ZIP)

    '        'I-7WD5N4HU9ENB
    '    Else
    '        ' Payment was unsuccessful. Take appropriate action.
    '        lblProfile.Text = "<p>We're unable to retrieve your PayPal Subscription details right now. Please check back later.</p><p>If this problem persists, please <a href='support.aspx'>contact support</a></p>"

    '        ' send error notification
    '        Dim errorText As String = ppPay.ErrorList(0).Code & "<br />"
    '        errorText += ppPay.ErrorList(0).Severity & "<br />"
    '        errorText += ppPay.ErrorList(0).ShortMessage & "<br />"
    '        errorText += ppPay.ErrorList(0).LongMessage
    '        sendErrorToAdmin(errorText)
    '    End If
    'End Sub

    ' set default subscription to the first in the list
    Protected Sub rblSubscription_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles rblSubscription.Init
        rblSubscription.SelectedIndex = 0
    End Sub

    ' Logs any paypal related events to the UserSubscriptionLog table
    Protected Sub logEvent(actionDescription As String)
        Dim UserIPAddress As String = Request.ServerVariables("REMOTE_ADDR")

        ' insert task
        Try
            Dim connString As String = System.Configuration.ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString
            Dim myConn As New SqlConnection(connString)
            Dim myCmd As New SqlCommand("INSERT INTO UserSubscriptionLog(UserId, ActionDescription, UserIPAddress) VALUES (@UserId, @ActionDescription, @UserIPAddress);", myConn)
            myCmd.Parameters.AddWithValue("@UserId", userId)
            myCmd.Parameters.AddWithValue("@ActionDescription", actionDescription)
            myCmd.Parameters.AddWithValue("@UserIPAddress", UserIPAddress)

            myConn.Open()
            myCmd.ExecuteScalar()
            myConn.Close()

            myCmd.Dispose()
            myConn.Dispose()
        Catch Ex As Exception

            Response.End()
        End Try
    End Sub

    Protected Sub btnSubscribe_Click(sender As Object, e As EventArgs) Handles btnSubscribe.Click
        createSubscription()
    End Sub

    Protected Sub createSubscription()
        'SetCustomerBillingAgreement()
        Dim token = generateToken()

        ' check we have the token that was just generated
        If Len(token) > 0 Then
            ' get the subscription type from the selected radio button
            Dim subscriptionType As String = rblSubscription.SelectedValue

            ' Update the user profile with the subscriptionType selected
            Dim connString As String = System.Configuration.ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString
            Dim myConn As New SqlConnection(connString)
            Dim cmd As SqlCommand = New SqlCommand("UPDATE UserProfile SET subscriptionType = @subscriptionType WHERE userId = @userId", myConn)
            cmd.Parameters.AddWithValue("@userId", userId)
            cmd.Parameters.AddWithValue("@subscriptionType", subscriptionType)
            Try
                myConn.Open()
                cmd.ExecuteReader()
            Catch ex As Exception
                Trace.Write(ex.ToString)
                myConn.Close()
            End Try

            ' redirect the user to paypal where they can continue with the subscription
            Response.Redirect("https://www.sandbox.paypal.com/webscr?cmd=_customer-billing-agreement&token=" & token)
        End If
    End Sub
End Class
