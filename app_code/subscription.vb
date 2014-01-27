Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports Encore.PayPal.Nvp

Public Class subscription

    'Public userid As String
    'Public email As String
    'Public subscriptionType As Integer

    Private paypalUser As String = HttpContext.Current.Application("paypalUser")
    Private paypalPwd As String = HttpContext.Current.Application("paypalPwd")
    Private paypalSignature As String = HttpContext.Current.Application("paypalSignature")

    Private _userId As String
    Public Property UserId() As String
        Get
            Return _userId
        End Get
        Private Set(ByVal value As String)
            _userId = value
        End Set
    End Property

    Private _email As String
    Public Property Email() As String
        Get
            Return _email
        End Get
        Private Set(ByVal value As String)
            _email = value
        End Set
    End Property

    Private _subscriptionType As String
    Public Property SubscriptionType() As String
        Get
            Return _subscriptionType
        End Get
        Private Set(ByVal value As String)
            _subscriptionType = value
        End Set
    End Property

    Private _token As String
    Public Property Token() As String
        Get
            Return _token
        End Get
        Private Set(ByVal value As String)
            _token = value
        End Set
    End Property

    Private _paypalPayerId As String
    Public Property PaypalPayerId() As String
        Get
            Return _paypalPayerId
        End Get
        Private Set(ByVal value As String)
            _paypalPayerId = value
        End Set
    End Property

    Public Sub setPaypalPayerIdFromSession(ByVal session As HttpSessionState)
        Dim sessionPaypalPayerId = session("paypalPayerId")
        If Not sessionPaypalPayerId Is Nothing Then
            PaypalPayerId = sessionPaypalPayerId
        End If
    End Sub

    Public Sub setSessionData(ByVal session As HttpSessionState)
        UserId = session("userId")
        Email = session("email")

        Dim sessionPaypalPayerId = session("paypalPayerId")
        If Not sessionPaypalPayerId Is Nothing Then
            PaypalPayerId = sessionPaypalPayerId
        End If
    End Sub

    Protected Function generateProfileReference() As String
        Dim randomClass As New Random()
        Dim uid As String = randomClass.Next(1000, 9999)
        Dim profileReference = DateTime.Now.ToString("mmHH-ddMM-yyyy-") + uid
        Return profileReference
    End Function

    Public Function check() As String
        HttpContext.Current.Trace.Write("PaypalPayerId = " + PaypalPayerId)

        If Not PaypalPayerId Is Nothing Then
            Return getRecurringPaymentsProfileDetails()
        End If
        Return "Error"
    End Function

    Public Function getRecurringPaymentsProfileDetails() As String
        'Dim getAccountStatus As String = ""

        ' Retrieve the account status using GetRecurringPaymentsProfileDetails
        Dim ppPay As NvpGetRecurringPaymentsProfileDetails = New NvpGetRecurringPaymentsProfileDetails
        ppPay.Add(NvpCommonRequest.USER, paypalUser)
        ppPay.Add(NvpCommonRequest.PWD, paypalPwd)
        ppPay.Add(NvpCommonRequest.SIGNATURE, paypalSignature)
        ppPay.Add(NvpGetRecurringPaymentsProfileDetails.Request.PROFILEID, PaypalPayerId)

        ' post the API call
        If ppPay.Post Then

            ' write paypal account details to UserSubscriptionDetail


            HttpContext.Current.Trace.Write("Description", ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.DESC))
            HttpContext.Current.Trace.Write("Status", ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.STATUS))
            HttpContext.Current.Trace.Write("Subscriber", ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.SUBSCRIBERNAME))
            HttpContext.Current.Trace.Write("Account Ref", ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.PROFILEREFERENCE))
            HttpContext.Current.Trace.Write("Billing Period", ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.BILLINGPERIOD))
            HttpContext.Current.Trace.Write("Amount", String.Format("{0:c}", Double.Parse(ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.AMT))))
            HttpContext.Current.Trace.Write("Start Date ", String.Format("{0:dd MMM yyyy}", Convert.ToDateTime(ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.PROFILESTARTDATE))))
            HttpContext.Current.Trace.Write("Last Payment Date", String.Format("{0:dd MMM yyyy}", Convert.ToDateTime(ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.LASTPAYMENTDATE))))
            HttpContext.Current.Trace.Write("Next Billing Date", String.Format("{0:dd MMM yyyy}", Convert.ToDateTime(ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.NEXTBILLINGDATE))))

            HttpContext.Current.Trace.Write("Billing Amount", ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.AUTOBILLOUTAMT))
            HttpContext.Current.Trace.Write("MAXFAILEDPAYMENTS", ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.MAXFAILEDPAYMENTS))
            HttpContext.Current.Trace.Write("BILLINGFREQUENCY", ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.BILLINGFREQUENCY))
            HttpContext.Current.Trace.Write("TOTALBILLINGCYCLES", ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.TOTALBILLINGCYCLES))

            ' recurring payments summary
            HttpContext.Current.Trace.Write("NUMCYCYLESCOMPLETED", ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.NUMCYCLESCOMPLETED))
            HttpContext.Current.Trace.Write("NUMCYCLESREMAINING", ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.NUMCYCLESREMAINING))
            HttpContext.Current.Trace.Write("OUTSTANDINGBALANCE", ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.OUTSTANDINGBALANCE))
            HttpContext.Current.Trace.Write("FAILEDPAYMENTCOUNT", ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.FAILEDPAYMENTCOUNT))
            HttpContext.Current.Trace.Write("LASTPAYMENTAMT", ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.LASTPAYMENTAMT))

            ' credit card details
            HttpContext.Current.Trace.Write("ACCT", ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.ACCT))
            HttpContext.Current.Trace.Write("CREDITCARDTYPE", ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.CREDITCARDTYPE))
            HttpContext.Current.Trace.Write("EXPDATE", ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.EXPDATE))
            HttpContext.Current.Trace.Write("ISSUENUMBER", ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.ISSUENUMBER))

            ' payer info
            HttpContext.Current.Trace.Write("First Name", ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.FIRSTNAME))
            HttpContext.Current.Trace.Write("Last Name", ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.LASTNAME))

            ' address
            HttpContext.Current.Trace.Write("Street", ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.STREET))
            HttpContext.Current.Trace.Write("Street 2", ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.STREET2))
            HttpContext.Current.Trace.Write("City", ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.CITY))
            HttpContext.Current.Trace.Write("State", ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.STATE))
            HttpContext.Current.Trace.Write("Country", ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.COUNTRYCODE))
            HttpContext.Current.Trace.Write("Postcode", ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.ZIP))

            Return ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.STATUS)

            '' 
            'lblProfile.Text = ""
            'createLabel("Description", ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.DESC))
            'createLabel("Status", getAccountStatus)
            'createLabel("Subscriber", ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.SUBSCRIBERNAME))
            'createLabel("Account Ref", ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.PROFILEREFERENCE))
            'createLabel("Billing Period", ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.BILLINGPERIOD))
            'createLabel("Amount", String.Format("{0:c}", Double.Parse(ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.AMT))))
            'createLabel("Start Date ", String.Format("{0:dd MMM yyyy}", Convert.ToDateTime(ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.PROFILESTARTDATE))))
            'createLabel("Last Payment Date", String.Format("{0:dd MMM yyyy}", Convert.ToDateTime(ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.LASTPAYMENTDATE))))
            'createLabel("Next Billing Date", String.Format("{0:dd MMM yyyy}", Convert.ToDateTime(ppPay.Get(NvpGetRecurringPaymentsProfileDetails.Response.NEXTBILLINGDATE))))

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
            'pSubscriptionNotFound.Visible = True
            'pPaypalPanel.Visible = False
            'pSubscriptionPanel.Visible = False

            'lblProfile.Text = "<p>We were unable to retrieve your PayPal Subscription details right now, please check again later.</p><p>If this problem persists, please <a href='support.aspx'>contact support</a></p>"

            ' hide subscription block

            ' email support with error notification
            'If ppPay.ErrorList.Count > 0 Then
            '    Dim errorText As String = ppPay.ErrorList(0).Code & "<br />"
            '    errorText += ppPay.ErrorList(0).Severity & "<br />"
            '    errorText += ppPay.ErrorList(0).ShortMessage & "<br />"
            '    errorText += ppPay.ErrorList(0).LongMessage
            '    displayErrorToClient(errorText)
            '    'sendErrorToAdmin(errorText)
            'End If
            Return "Error"
        End If
    End Function

    Public Function CreatePaymentProfile(ByVal firstname As String, ByVal surname As String) As String
        ' Generate a profile reference number
        Dim profileReference As String = generateProfileReference()

        ' retrieve the subscription type
        ' this was saved in the users profile before they were directed to paypal
        Dim connString As String = System.Configuration.ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString
        Dim myConn As New SqlConnection(connString)
        Dim cmd As SqlCommand = New SqlCommand("SELECT billingAmount, billingFrequency, billingPeriod, UserSubscriptionType.subscription FROM UserProfile LEFT JOIN UserSubscriptionType ON UserSubscriptionType.id = subscriptionType WHERE userId = @userId", myConn)
        cmd.Parameters.AddWithValue("@userId", UserId)
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
                ppPay.Add(NvpCommonRequest.USER, HttpContext.Current.Application("paypalUser"))
                ppPay.Add(NvpCommonRequest.PWD, HttpContext.Current.Application("paypalPwd"))
                ppPay.Add(NvpCommonRequest.SIGNATURE, HttpContext.Current.Application("paypalSignature"))
                'ppPay.Add(NvpCommonRequest.USER, Application.Item("paypalUser"))
                'ppPay.Add(NvpCommonRequest.PWD, Application.Item("paypalPwd"))
                'ppPay.Add(NvpCommonRequest.SIGNATURE, Application.Item("paypalSignature"))

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
                ppPay.Add(NvpCreateRecurringPaymentsProfile.Request._TOKEN, Token)
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
                    ' Payment was successful

                    Dim profileId As String = ppPay.Get(NvpCreateRecurringPaymentsProfile.Response.PROFILEID)
                    savePaypalProfileId(profileId)
                    logSubscriptionEvent("Payment profile was succcessfully created.")

                    Return profileId
                    'Else
                    ' creation of recurring payment failed

                    'Dim errString As String = ppPay.ErrorList(0).Code
                    'errString += ppPay.ErrorList(0).Severity
                    'errString += ppPay.ErrorList(0).ShortMessage
                    'errString += ppPay.ErrorList(0).LongMessage
                    'Trace.Write(errString)
                    'sendErrorToAdmin(errString)
                End If
            End While
        Catch ex As Exception
            'Trace.Write(ex.ToString)
            myConn.Close()
        End Try

        Return False
    End Function

    Public Function reactivate() As String
        HttpContext.Current.Trace.Write("initial re-activate request")
        Return ManageRecurringPaymentsProfileStatus("Reactivate")
    End Function

    Public Function suspend() As String
        Return ManageRecurringPaymentsProfileStatus("Suspend")
    End Function

    Public Function cancel() As String
        Return ManageRecurringPaymentsProfileStatus("Cancel")
    End Function

    Protected Sub savePaypalProfileId(ByVal profileId As String)
        'Dim userId As String = Session("userId")

        Dim connString As String = System.Configuration.ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString
        Dim myConn As New SqlConnection(connString)
        Dim cmd As SqlCommand = New SqlCommand("UPDATE UserProfile SET paypalPayerId = @profileId WHERE userId = @userId", myConn)
        cmd.Parameters.AddWithValue("@userId", UserId)
        cmd.Parameters.AddWithValue("@profileId", profileId)
        Try
            myConn.Open()
            cmd.ExecuteReader()
            'rmpSubscription.SelectedIndex = 0
            'btnSuspend.Visible = True
            'btnCancel.Visible = True

        Catch ex As Exception
            'Trace.Write(ex.ToString)
            myConn.Close()
        End Try
    End Sub

    Protected Function ManageRecurringPaymentsProfileStatus(ByVal actionType As String) As String
        HttpContext.Current.Trace.Write("Manage recurring payments profile status : " + actionType)
        ' manage the recurring payment
        Dim ppPay As NvpManageRecurringPaymentsProfileStatus = New NvpManageRecurringPaymentsProfileStatus
        ppPay.Add(NvpCommonRequest.USER, paypalUser)
        ppPay.Add(NvpCommonRequest.PWD, paypalPwd)
        ppPay.Add(NvpCommonRequest.SIGNATURE, paypalSignature)

        'ppPay.Add(NvpCommonRequest.USER, Application.Item("paypalUser"))
        'ppPay.Add(NvpCommonRequest.PWD, Application.Item("paypalPwd"))
        'ppPay.Add(NvpCommonRequest.SIGNATURE, Application.Item("paypalSignature"))
        ppPay.Add(NvpManageRecurringPaymentsProfileStatus.Request.PROFILEID, PaypalPayerId)
        ppPay.Add(NvpManageRecurringPaymentsProfileStatus.Request.ACTION, actionType)

        ' post the API call
        If ppPay.Post Then
            logSubscriptionEvent(actionType)

            HttpContext.Current.Trace.Write("log subscription event : " + actionType)
            HttpContext.Current.Trace.Write("ppay.get profileid : " + ppPay.Get(NvpManageRecurringPaymentsProfileStatus.Response.PROFILEID))

            Return ppPay.Get(NvpManageRecurringPaymentsProfileStatus.Response.PROFILEID)
        Else
            Dim errString As String = ppPay.ErrorList(0).Code
            errString += ppPay.ErrorList(0).Severity
            errString += ppPay.ErrorList(0).ShortMessage
            errString += ppPay.ErrorList(0).LongMessage

            'displayErrorToClient(errString)
            Return "Error message from ppay.post : " + errString
            'trace.Write("Error message from ppay.post : " + errString)

        End If
        Return False
    End Function


    ' Logs any paypal related events to the UserSubscriptionLog table
    Protected Sub logSubscriptionEvent(ByVal actionDescription As String)
        Dim UserIPAddress As String = HttpContext.Current.Request.ServerVariables("REMOTE_ADDR")
        Try
            Dim connString As String = System.Configuration.ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString
            Dim myConn As New SqlConnection(connString)
            Dim myCmd As New SqlCommand("INSERT INTO UserSubscriptionLog(UserId, PaypalPayerId, ActionDescription, UserIPAddress) VALUES (@UserId, @PaypalPayerId, @ActionDescription, @UserIPAddress);", myConn)
            myCmd.Parameters.AddWithValue("@UserId", UserId)
            myCmd.Parameters.AddWithValue("@PaypalPayerId", PaypalPayerId)
            myCmd.Parameters.AddWithValue("@ActionDescription", actionDescription)
            myCmd.Parameters.AddWithValue("@UserIPAddress", UserIPAddress)

            myConn.Open()
            myCmd.ExecuteScalar()
            myConn.Close()

            myCmd.Dispose()
            myConn.Dispose()
        Catch Ex As Exception

            'Response.End()
        End Try
    End Sub

    Public Sub create(ByVal subType As Integer)
        ' create a new billing agreement with paypal
        generateToken()

        HttpContext.Current.Trace.Write("generate token done, so token is: " + Token)

        'If Not Token Is Nothing Then
        '    ' store the new subscription type
        '    update(subType)
        'End If
    End Sub

    Public Sub confirm(ByVal tkn As String)
        'HttpContext.Current.Trace.Write("Confirm ")
        Token = tkn
        logSubscriptionEvent("Customer completed initial step in Paypal sign-up. Awaiting confirmation.")
    End Sub

    Public Sub confirmComplete(ByVal tkn As String)
        'HttpContext.Current.Trace.Write("Confirm ")
        Token = tkn
        logSubscriptionEvent("Customer completed Paypal sign-up.")
        createUserSubscriptionDetails()
    End Sub

    Protected Sub createUserSubscriptionDetails()
        ' create or update user subscription details

    End Sub

    Protected Sub update(ByVal subscriptionType As Integer)
        ' Update the users subscription information
        Dim connString As String = System.Configuration.ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString
        Dim myConn As New SqlConnection(connString)
        Dim cmd As SqlCommand = New SqlCommand("UPDATE UserProfile SET subscriptionType = @subscriptionType WHERE userId = @userId", myConn)
        cmd.Parameters.AddWithValue("@userId", UserId)
        cmd.Parameters.AddWithValue("@subscriptionType", subscriptionType)
        Try
            logSubscriptionEvent("Updated userprofile to Subscription Type : " + subscriptionType)
            myConn.Open()
            cmd.ExecuteReader()
        Catch ex As Exception
            myConn.Close()
        End Try
    End Sub

    Protected Sub generateToken()
        HttpContext.Current.Trace.Write("Check for email :" + Email)

        If Not Email Is Nothing Then
            ' create the DoDirectpayment object
            Dim ppPay As NvpSetCustomerBillingAgreement = New NvpSetCustomerBillingAgreement
            ppPay.Add(NvpCommonRequest.USER, paypalUser)
            ppPay.Add(NvpCommonRequest.PWD, paypalPwd)
            ppPay.Add(NvpCommonRequest.SIGNATURE, paypalSignature)

            ' add the required parameters
            ppPay.Add(NvpSetCustomerBillingAgreement.Request._RETURNURL, "http://buildmateapp.com/subscription.aspx")
            ppPay.Add(NvpSetCustomerBillingAgreement.Request._CANCELURL, "http://buildmateapp.com/subscription_cancel.aspx")
            ppPay.Add(NvpSetCustomerBillingAgreement.Request._BILLINGTYPE, NvpBillingCodeType.RecurringPayments)
            ppPay.Add(NvpSetCustomerBillingAgreement.Request.BILLINGAGREEMENTDESCRIPTION, "Buildmate Subscription")
            ppPay.Add(NvpSetCustomerBillingAgreement.Request.EMAIL, Email)

            ' post the API call
            If ppPay.Post Then
                ' successfully created a customer billing agreement
                logSubscriptionEvent("Created a customer billing agreement")
                Token = ppPay.Get(NvpSetCustomerBillingAgreement.Response.TOKEN)

                HttpContext.Current.Trace.Write("Within generate token method. Token = " + Token)
                'Else
                ' Error - Take appropriate action.
                'Dim errorString As String = ppPay.ErrorList(0).Code
                'errorString += ppPay.ErrorList(0).Severity
                'errorString += ppPay.ErrorList(0).ShortMessage
                'errorString += ppPay.ErrorList(0).LongMessage
                'displayErrorToClient(errorString)
            Else
                logSubscriptionEvent("Error while trying to create a customer billing agreement")
                Token = False
            End If
        End If
    End Sub
End Class
