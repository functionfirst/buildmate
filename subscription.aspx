<%@ Page Title="Subscription - BuildMate" Language="VB" MasterPageFile="~/common/Manager.master" AutoEventWireup="false" CodeFile="subscription.aspx.vb" Inherits="manager_subscription" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">

    <p class="breadcrumb">
        Subscription
    </p>

    <asp:Panel ID="pError" runat="server" CssClass="errorBox" Visible="false">
        <p><asp:Label ID="lblError" runat="server" /></p>
    </asp:Panel>

    <asp:Panel ID="pSuccess" runat="server" CssClass="successBox" Visible="false">
        <p>Your subscription has been successfully created.</p>
    </asp:Panel>
    
    <asp:Panel ID="pErrorMessage" runat="server" CssClass="errorBox" Visible="false">
        <p>
            <strong>Your subscription has expired.</strong><br />
            You will need to subscribe to re-gain full access to the system.
        </p>
    </asp:Panel>
    
    <asp:Panel ID="pSubscriptionNotFound" runat="server" CssClass="errorBox" Visible="false">
        <p>
            <strong>Error with Subscription</strong><br />
            We were unable to retrieve your PayPal Subscription details right now, please check again later.<br /><br />

            If this problem persists, please <a href="mailto:support@buildmateapp.com">contact support</a>
        </p>
    </asp:Panel>
    
    <div class="div50">
        <asp:Panel ID="pSubscriptionPanel" runat="server" CssClass="box">
            <h3>Subscription Details</h3>

            <div class="boxcontent">
                <asp:literal ID="lblProfile" runat="server" Text="You are not currently subscribed to BuildMate." />
                
                <asp:FormView ID="fvUserSubscriptionDetails" runat="server" DataSourceID="subscriptionDetailsDataSource">
                    <EmptyDataTemplate>
         
                    </EmptyDataTemplate>
                    <ItemTemplate>
                        UserId:
                        <asp:Label ID="UserIdLabel" runat="server" Text='<%# Bind("UserId") %>' />
                        <br />
                        Description:
                        <asp:Label ID="DescriptionLabel" runat="server" 
                            Text='<%# Bind("Description") %>' />
                        <br />
                        status:
                        <asp:Label ID="statusLabel" runat="server" Text='<%# Bind("status") %>' />
                        <br />
                        SubscriberName:
                        <asp:Label ID="SubscriberNameLabel" runat="server" 
                            Text='<%# Bind("SubscriberName") %>' />
                        <br />
                        ProfileReference:
                        <asp:Label ID="ProfileReferenceLabel" runat="server" 
                            Text='<%# Bind("ProfileReference") %>' />
                        <br />
                        BillingPeriod:
                        <asp:Label ID="BillingPeriodLabel" runat="server" 
                            Text='<%# Bind("BillingPeriod") %>' />
                        <br />
                        Amt:
                        <asp:Label ID="AmtLabel" runat="server" Text='<%# Bind("Amt") %>' />
                        <br />
                        ProfileStartDate:
                        <asp:Label ID="ProfileStartDateLabel" runat="server" 
                            Text='<%# Bind("ProfileStartDate") %>' />
                        <br />
                        LastPaymentDate:
                        <asp:Label ID="LastPaymentDateLabel" runat="server" 
                            Text='<%# Bind("LastPaymentDate") %>' />
                        <br />
                        NextBillingDate:
                        <asp:Label ID="NextBillingDateLabel" runat="server" 
                            Text='<%# Bind("NextBillingDate") %>' />
                        <br />
                        AutoBilloutAmt:
                        <asp:Label ID="AutoBilloutAmtLabel" runat="server" 
                            Text='<%# Bind("AutoBilloutAmt") %>' />
                        <br />
                        MaxFailedPayments:
                        <asp:Label ID="MaxFailedPaymentsLabel" runat="server" 
                            Text='<%# Bind("MaxFailedPayments") %>' />
                        <br />
                        BillingFrequency:
                        <asp:Label ID="BillingFrequencyLabel" runat="server" 
                            Text='<%# Bind("BillingFrequency") %>' />
                        <br />
                        TotalBillingCycles:
                        <asp:Label ID="TotalBillingCyclesLabel" runat="server" 
                            Text='<%# Bind("TotalBillingCycles") %>' />
                        <br />
                        NumCyclesCompleted:
                        <asp:Label ID="NumCyclesCompletedLabel" runat="server" 
                            Text='<%# Bind("NumCyclesCompleted") %>' />
                        <br />
                        NumCyclesRemaining:
                        <asp:Label ID="NumCyclesRemainingLabel" runat="server" 
                            Text='<%# Bind("NumCyclesRemaining") %>' />
                        <br />
                        OutstandingBalance:
                        <asp:Label ID="OutstandingBalanceLabel" runat="server" 
                            Text='<%# Bind("OutstandingBalance") %>' />
                        <br />
                        FailedPaymentCount:
                        <asp:Label ID="FailedPaymentCountLabel" runat="server" 
                            Text='<%# Bind("FailedPaymentCount") %>' />
                        <br />
                        LastPaymentAmt:
                        <asp:Label ID="LastPaymentAmtLabel" runat="server" 
                            Text='<%# Bind("LastPaymentAmt") %>' />
                        <br />
                        Acct:
                        <asp:Label ID="AcctLabel" runat="server" Text='<%# Bind("Acct") %>' />
                        <br />
                        CreditCardType:
                        <asp:Label ID="CreditCardTypeLabel" runat="server" 
                            Text='<%# Bind("CreditCardType") %>' />
                        <br />
                        ExpDate:
                        <asp:Label ID="ExpDateLabel" runat="server" Text='<%# Bind("ExpDate") %>' />
                        <br />
                        IssueNumber:
                        <asp:Label ID="IssueNumberLabel" runat="server" 
                            Text='<%# Bind("IssueNumber") %>' />
                        <br />
                        FirstName:
                        <asp:Label ID="FirstNameLabel" runat="server" Text='<%# Bind("FirstName") %>' />
                        <br />
                        LastName:
                        <asp:Label ID="LastNameLabel" runat="server" Text='<%# Bind("LastName") %>' />
                        <br />
                        Street:
                        <asp:Label ID="StreetLabel" runat="server" Text='<%# Bind("Street") %>' />
                        <br />
                        Street2:
                        <asp:Label ID="Street2Label" runat="server" Text='<%# Bind("Street2") %>' />
                        <br />
                        City:
                        <asp:Label ID="CityLabel" runat="server" Text='<%# Bind("City") %>' />
                        <br />
                        State:
                        <asp:Label ID="StateLabel" runat="server" Text='<%# Bind("State") %>' />
                        <br />
                        CountryCode:
                        <asp:Label ID="CountryCodeLabel" runat="server" 
                            Text='<%# Bind("CountryCode") %>' />
                        <br />
                        Zip:
                        <asp:Label ID="ZipLabel" runat="server" Text='<%# Bind("Zip") %>' />
                        <br />
                        LastUpdated:
                        <asp:Label ID="LastUpdatedLabel" runat="server" 
                            Text='<%# Bind("LastUpdated") %>' />
                        <br />
                    </ItemTemplate>
                </asp:FormView>
            </div>
        </asp:Panel>
    </div>

    <div class="div50r">
        <asp:Panel ID="pPaypalPanel" runat="server" CssClass="box">
            <h3><asp:Label ID="Label1" runat="server" /></h3>

            <asp:Panel ID="pSubscription" runat="server" CssClass="boxcontent">
                <div class="row" runat="server" id="setSubscription">
                    <asp:Label ID="Label2" runat="server"
                        CssClass="label"
                        AssociatedControlID="rblSubscription"
                        Text="Subscription">Subscribe now:</asp:Label>
                    
                    <asp:RadioButtonList ID="rblSubscription" runat="server"
                        DataSourceId="subscriptionTypeDataSource"
                        DataTextField="subscription"
                        DataValueField="id">
                    </asp:RadioButtonList>
                </div>
                    
                <asp:panel ID="panelSubscribe" runat="server" CssClass="row">
                    <label class="label">&nbsp;</label>

                    <asp:ImageButton ID="btnSubscribe" runat="server"
                        ImageUrl="~/images/paypal-subscribe.gif"
                        OnClick="btnSubscribe_Click" />
                </asp:panel>

                <asp:LinkButton
                    ID="btnReactivate"
                    runat="server"
                    CssClass="button paypal_btn paypal_reactivate"
                    OnClick="btnReactivate_Click">
                    <em></em>
                    <span>
                        <strong>Re-activate Subscription</strong>
                        You'll start where you left off.
                    </span>
                </asp:LinkButton>
                    
                <asp:LinkButton
                    ID="btnSuspend"
                    runat="server"
                    CssClass="button paypal_btn paypal_suspend"
                    OnClick="btnSuspend_Click">
                    <em></em>
                    <span>
                        <strong>Suspend Subscription</strong>
                        You'll be able to come back and re-activate at any time.
                    </span>
                </asp:LinkButton>
                    
                <asp:LinkButton
                    ID="btnCancel"
                    runat="server"
                    CssClass="button paypal_btn paypal_cancel"
                    OnClick="btnCancel_Click">
                    <em></em>
                    <span>
                        <strong>Cancel Subscription</strong>
                        Once your current payment period ends you'll have limited access to BuildMate.
                    </span>
                </asp:LinkButton>    
            </asp:Panel>
        </asp:Panel>

        <asp:FormView ID="fvConfirmSubscription" runat="server" 
            DataSourceID="confirmSubscriptionDataSource"
            Visible="false"
            Width="100%">
            <ItemTemplate>
                <div class="box">
                    <h3>Confirm your Subscription</h3>

                    <div class="boxcontent">
                        <p>Please enter your First name and Surname to activate your subscription.</p>

                        <div class="row">
                            <label class="label" title="First Name">First Name</label>
                            <telerik:RadTextBox ID="rtFirstname" runat="server" Text='<%# Bind("firstname") %>' />

                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                ControlToValidate="rtFirstname"
                                ValidationGroup="confirmValidation"
                                Display="Dynamic"
                                ErrorMessage="First Name">
                                <span class="req"></span>
                            </asp:RequiredFieldValidator> 
                        </div>

                        <div class="row">
                            <label class="label" title="Surname">Surname</label>
                            <telerik:RadTextBox ID="rtSurname" runat="server" Text='<%# Bind("surname") %>' />

                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                                ControlToValidate="rtSurname"
                                ValidationGroup="confirmValidation"
                                Display="Dynamic"
                                ErrorMessage="Surname">
                                <span class="req"></span>
                            </asp:RequiredFieldValidator> 
                        </div>
                        
                        <div class="row">
                            <label class="label" title="Payment Plan">Payment Plan</label>
                        
                            <asp:Label ID="subscriptionLabel" runat="server" Text='<%# Bind("subscription") %>' />
                        </div>

                        <div class="row">
                            <label class="label">&nbsp;</label>
                            <asp:Button ID="btnConfirmSubscription" runat="server"
                                ValidationGroup="confirmValidation"
                                OnClick="btnConfirmSubscription_OnClick"
                                Text="Activate my Subscription" />
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:FormView>
    </div>

    
    <!-- PayPal Logo -->
    <table border="0" cellpadding="10" cellspacing="0" align="center">
        <tr>
            <td align="center"></td>
        </tr>
        <tr>
            <td align="center">
                <a href="#" onclick="javascript:window.open('https://www.paypal.com/uk/cgi-bin/webscr?cmd=xpt/Marketing/popup/OLCWhatIsPayPal-outside','olcwhatispaypal','toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=yes, resizable=yes, width=400, height=350');"><img  src="https://www.paypal.com/en_GB/i/bnr/horizontal_solution_PP.gif" border="0" alt="Solution Graphics"></a>
            </td>
        </tr>
    </table>
    <!-- PayPal Logo -->

    <asp:SqlDataSource ID="subscriptionTypeDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>" 
        SelectCommand="getUserSubscriptionTypes" SelectCommandType="StoredProcedure">
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="subscriptionDetailsDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>" 
        SelectCommand="getUserSubscriptionDetails" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="UserId" SessionField="UserId" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="confirmSubscriptionDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>" 
        SelectCommand="SELECT firstname, surname, UserSubscriptionType.subscription FROM UserProfile LEFT JOIN UserSubscriptionType ON UserSubscriptionType.id = subscriptionType WHERE userId = @userId">
        <SelectParameters>
            <asp:SessionParameter Name="UserId" SessionField="UserId" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>