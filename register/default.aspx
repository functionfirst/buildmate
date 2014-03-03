<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/common/Guest.master" CodeFile="default.aspx.vb" Inherits="login" Title="Register - Buildmate" %>

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
        <h1>Register for your free 30 day trial</h1>

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
            <MailDefinition
                From="support@buildmateapp.com"
                Subject="[Buildmate] Welcome to Buildmate"
                IsBodyHtml="true"
                BodyFileName="~/email_templates/Welcome.txt" />
        </asp:CreateUserWizard>
    </asp:Panel>
</asp:Content>