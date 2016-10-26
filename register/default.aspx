<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/common/Guest.master" CodeFile="default.aspx.vb" Inherits="register" Title="Register - Buildmate" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content" ContentPlaceHolderID="MainContent" runat="Server">
    <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlId="pRegister">
                <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="pRegister" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    
    <asp:Panel ID="pRegister" runat="server">
        <div class="div50">
            <h1>
                Sign up for a free 12 month Trial
                <small>No credit card or personal details required</small>
            </h1>
            
            <asp:CreateUserWizard ID="CreateUserWizard1" runat="server" RequireEmail="false"
                CreateUserButtonStyle-CssClass="button button-create button-large"
                ErrorMessageStyle-CssClass="box-alert"
                DuplicateUserNameErrorMessage="This email address is already in use.">
                <WizardSteps>
                    <asp:CreateUserWizardStep ID="CreateUserWizardStep1" runat="server">
                        <CustomNavigationTemplate>
                        </CustomNavigationTemplate>
                        <ContentTemplate>
                            <div class="row">
                                <asp:Label ID="lblEmail" runat="server" Text="Label" CssClass="label" AssociatedControlID="Username">Email</asp:Label>
                                <asp:TextBox ID="Username" runat="server" Width="210" AutoCompleteType="Disabled" autocomplete="off"></asp:TextBox>
                                <asp:RequiredFieldValidator   
                                    ID="RequiredFieldValidator1"  
                                    ForeColor=""
                                    runat="server"
                                    CssClass="label-error"
                                    Display="Dynamic"
                                    ControlToValidate="Username"  
                                    Text="Please enter your email address."></asp:RequiredFieldValidator>  
                                <asp:RegularExpressionValidator   
                                    ID="RegularExpressionValidator1"  
                                    runat="server"
                                    ForeColor=""
                                    CssClass="label-error"
                                    Display="Dynamic"
                                    ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"  
                                    ControlToValidate="Username"  
                                    ErrorMessage="Your email address is not valid"></asp:RegularExpressionValidator> 
                            </div>
                        
                            <div class="row">
                                <asp:Label ID="lblConfirmEmail" runat="server" Text="Label" CssClass="label" AssociatedControlID="tbUsername2">Confirm Email</asp:Label>
                                <asp:TextBox ID="tbUsername2" runat="server" Width="210" AutoCompleteType="Disabled" autocomplete="off" />

                                <asp:RequiredFieldValidator   
                                    ID="RequiredFieldValidator3"  
                                    ForeColor=""
                                    runat="server"
                                    CssClass="label-error"
                                    Display="Dynamic"
                                    ControlToValidate="tbUsername2"  
                                    Text="Please confirm your email address."></asp:RequiredFieldValidator>  

                                <asp:RegularExpressionValidator   
                                    ID="RegularExpressionValidator2"  
                                    runat="server"
                                    ForeColor=""
                                    CssClass="label-error"
                                    Display="Dynamic"
                                    ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"  
                                    ControlToValidate="tbUsername2"  
                                    ErrorMessage="Your Confirmation Email address is not valid"></asp:RegularExpressionValidator>

                                <asp:CompareValidator ID="CompareValidator1" runat="server"
                                    ForeColor=""
                                    CssClass="label-error"
                                    Display="Dynamic"
                                    ErrorMessage="Your Email address must match"
                                    ControlToValidate="Username"
                                    ControlToCompare="tbUsername2">
                                </asp:CompareValidator>
                            </div>

                            <div class="row">
                                <asp:Label ID="Label1" runat="server" Text="Label" CssClass="label" AssociatedControlID="Password">Password</asp:Label>

                                <asp:TextBox ID="Password" runat="server" Width="210" TextMode="Password" AutoCompleteType="Disabled" autocomplete="off"></asp:TextBox>
                            
                                <asp:RequiredFieldValidator   
                                     ID="RequiredFieldValidator2"  
                                     runat="server"
                                    ForeColor=""
                                    CssClass="label-error"
                                     Display="Dynamic"
                                     ControlToValidate="Password"  
                                     Text="Please enter a password."></asp:RequiredFieldValidator>  

                            </div>

                            <asp:Literal ID="ErrorMessage" runat="server" EnableViewState="False"></asp:Literal>

                            <div class="row">
                                <label class="label"></label>

                                <asp:Button
                                    ID="btnCreate"
                                    runat="server"
                                    CssClass="button button-create button-large"
                                    CommandName="MoveNext"
                                    Text="Confirm Registration" />
                            </div>

                            <div class="row">
                                <small>
                                    By clicking Confirm Registration you agree to the
                                    <a href="/terms/" target="_blank">Terms of Use</a>
                                    and <a href="/privacy/" target="_blank">Privacy Policy</a>.
                                </small>
                            </div>
                        </ContentTemplate>
                    </asp:CreateUserWizardStep>
                    <asp:CompleteWizardStep ID="CompleteWizardStep1" runat="server">
                        <ContentTemplate>
                            <p>
                                <strong>Thank you for registering.</strong><br />
                                You should receive an email confirming your account information shortly.
                            </p>

                            <p class="rightalign">
                                <a href="/" class="button button-create button-large">Login to Buildmate &rarr;</a>
                            </p>
                        </ContentTemplate>
                    </asp:CompleteWizardStep>
                </WizardSteps>
            </asp:CreateUserWizard>
        </div>
        <div class="div50">
            <h2>Questions and Answers</h2>

            <p>
                <strong>Do I need to give my credit card or personal details to sign-up?</strong><br />
                No credit card or personal details are required, we want your company to benefit first by using
                Buildmate before you make any financial commitment.
            </p>

            <p>
                <strong>Are there any restrictions or limited access during the trial?</strong><br />
                Buildmate is a fully inclusive estimating system; there is no lite version or trial limitations what you see is
                what you get - complete, ready to go and working estimating system.
            </p>
            
            <p>
                <strong>What happens at the end of the trial period?</strong><br />
                You will receive 30 days notice by Email that the trial will be ending. At which point you will be able to
                assess if using Buildmate has been an asset to the profitability of your company. If you decide to continue
                using Buildmate you can subscribe to a further period of use using a monthly or annual subscription.
            </p>
            
            <p>
                <strong>What happens to my account if do not subscribe to Buildmate?</strong><br />
                If you decide not to continue to use Buildmate you will still have full access to all of your project estimates.
                However you will not be able to create any new project/estimates, at any point should you change your mind
                and subscribe to Buildmate you will be able to create new projects.
            </p>
            
            <p>
                <strong>What about support if I need help or need to ask a question?</strong><br />
                There are no limitations or additional costs for support. Full support is provided 24/7 all request of help
                will be responded to within 12hrs. Including after 6pm, weekends and holiday periods when you are
                estimating someone will be available to support you and your business.
            </p>

            <p>
                <strong>I still have questions, who should I contact?</strong><br />
                Send us an email with your question(s) to <a href="mailto:support@buildmateapp.com">support@buildmateapp.com</a>.
            </p> 
        </div>
        <div style="clear: both"></div>
    </asp:Panel>
</asp:Content>