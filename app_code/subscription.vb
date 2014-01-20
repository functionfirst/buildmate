Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports Encore.PayPal.Nvp

Public Class subscription

    Public userid As String
    Public paypalPayerId As String
    Public email As String
    Public subscriptionType As Integer

    Private paypalUser As String = HttpContext.Current.Application("paypalUser")
    Private paypalPwd As String = HttpContext.Current.Application("paypalPwd")
    Private paypalSignature As String = HttpContext.Current.Application("paypalSignature")


    Protected Function generateProfileReference() As String
        Dim randomClass As New Random()
        Dim uid As String = randomClass.Next(1000, 9999)
        Dim profileReference = DateTime.Now.ToString("mmHH-ddMM-yyyy-") + uid
        Return profileReference
    End Function

    Public Function check() As String
        Dim trace As TraceContext = New TraceContext(HttpContext.Current)
        trace.Write(paypalPayerId)
        If Not paypalPayerId Is Nothing Then
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
        ppPay.Add(NvpGetRecurringPaymentsProfileDetails.Request.PROFILEID, paypalPayerId)

        ' post the API call
        If ppPay.Post Then
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

    Public Function CreateRecurringPaymentsProfile(ByVal token As String, ByVal firstname As String, ByVal surname As String) As String
        ' Generate a profile reference number
        Dim profileReference As String = generateProfileReference()

        ' retrieve the subscription type
        ' this was saved in the users profile before they were directed to paypal
        Dim connString As String = System.Configuration.ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString
        Dim myConn As New SqlConnection(connString)
        Dim cmd As SqlCommand = New SqlCommand("SELECT billingAmount, billingFrequency, billingPeriod, UserSubscriptionType.subscription FROM UserProfile LEFT JOIN UserSubscriptionType ON UserSubscriptionType.id = subscriptionType WHERE userId = @userId", myConn)
        cmd.Parameters.AddWithValue("@userId", Me.userid)
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
                ppPay.Add(NvpCreateRecurringPaymentsProfile.Request._TOKEN, token)
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
                    ' Payment was successful.
                    Dim profileId As String = ppPay.Get(NvpCreateRecurringPaymentsProfile.Response.PROFILEID)
                    savePaypalProfileId(profileId)
                    logSubscriptionEvent("Payment was succcessful.")

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
        cmd.Parameters.AddWithValue("@userId", Me.userid)
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
        ' manage the recurring payment
        Dim ppPay As NvpManageRecurringPaymentsProfileStatus = New NvpManageRecurringPaymentsProfileStatus
        ppPay.Add(NvpCommonRequest.USER, paypalUser)
        ppPay.Add(NvpCommonRequest.PWD, paypalPwd)
        ppPay.Add(NvpCommonRequest.SIGNATURE, paypalSignature)

        'ppPay.Add(NvpCommonRequest.USER, Application.Item("paypalUser"))
        'ppPay.Add(NvpCommonRequest.PWD, Application.Item("paypalPwd"))
        'ppPay.Add(NvpCommonRequest.SIGNATURE, Application.Item("paypalSignature"))
        ppPay.Add(NvpManageRecurringPaymentsProfileStatus.Request.PROFILEID, paypalPayerId)
        ppPay.Add(NvpManageRecurringPaymentsProfileStatus.Request.ACTION, actionType)

        ' post the API call
        If ppPay.Post Then
            logSubscriptionEvent(actionType)
            Return ppPay.Get(NvpManageRecurringPaymentsProfileStatus.Response.PROFILEID)
            'Else
            '    Dim errString As String = ppPay.ErrorList(0).Code
            '    errString += ppPay.ErrorList(0).Severity
            '    errString += ppPay.ErrorList(0).ShortMessage
            '    errString += ppPay.ErrorList(0).LongMessage

            'displayErrorToClient(errString)
        End If
        Return False
    End Function

    ' Logs any paypal related events to the UserSubscriptionLog table
    Protected Sub logSubscriptionEvent(ByVal actionDescription As String)
        Dim UserIPAddress As String = HttpContext.Current.Request.ServerVariables("REMOTE_ADDR")
        Try
            Dim connString As String = System.Configuration.ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString
            Dim myConn As New SqlConnection(connString)
            Dim myCmd As New SqlCommand("INSERT INTO UserSubscriptionLog(UserId, ActionDescription, UserIPAddress) VALUES (@UserId, @ActionDescription, @UserIPAddress);", myConn)
            myCmd.Parameters.AddWithValue("@UserId", Me.userid)
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

    Public Function create(ByVal subscriptionType As Integer) As String
        'Dim userId As String = Session("userId")
        Dim token = generateToken()

        If Not token Is Nothing Then
            ' get the subscription type from the selected radio button
            subscriptionType = subscriptionType
            update()
            Return token
        End If
        Return False
    End Function

    Protected Sub update()
        ' Update the users subscription information
        Dim connString As String = System.Configuration.ConfigurationManager.ConnectionStrings("LocalSqlServer").ConnectionString
        Dim myConn As New SqlConnection(connString)
        Dim cmd As SqlCommand = New SqlCommand("UPDATE UserProfile SET subscriptionType = @subscriptionType WHERE userId = @userId", myConn)
        cmd.Parameters.AddWithValue("@userId", Me.userid)
        cmd.Parameters.AddWithValue("@subscriptionType", Me.subscriptionType)
        Try
            myConn.Open()
            cmd.ExecuteReader()
        Catch ex As Exception
            myConn.Close()
        End Try
    End Sub

    Protected Function generateToken() As String
        If Not Me.email Is Nothing Then
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
            ppPay.Add(NvpSetCustomerBillingAgreement.Request.EMAIL, Me.email)

            ' post the API call
            If ppPay.Post Then
                ' successfully created a customer billing agreement
                Return ppPay.Get(NvpSetCustomerBillingAgreement.Response.TOKEN)
                'Else
                ' Error - Take appropriate action.
                'Dim errorString As String = ppPay.ErrorList(0).Code
                'errorString += ppPay.ErrorList(0).Severity
                'errorString += ppPay.ErrorList(0).ShortMessage
                'errorString += ppPay.ErrorList(0).LongMessage
                'displayErrorToClient(errorString)
            End If
        End If

        Return False
    End Function
End Class
