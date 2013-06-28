<%@ Page Title="Change Password" Language="VB" MasterPageFile="~/common/Manager.master" AutoEventWireup="false" CodeFile="changepassword.aspx.vb" Inherits="manager_account" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">

    <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlId="ChangePassword1">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="ChangePassword1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    
    <p class="breadcrumb">
        Change Password
    </p>

        <div class="box">
            <div class="box_top">Change Password</div>

            <div class="boxcontent">
                <asp:ChangePassword ID="ChangePassword1" runat="server"
                    Width="100%">
                    <ChangePasswordTemplate>
                        <asp:ValidationSummary ID="ValidationSummary2" runat="server"
                            ValidationGroup="ChangePassword1" HeaderText="The following fields are required:" />
                        
                        <div class="row">
                            <asp:Label ID="lblCurrentPassword" CssClass="label" runat="server" AssociatedControlID="CurrentPassword">Password</asp:Label>
                            <telerik:RadTextBox ID="CurrentPassword" runat="server" TextMode="Password" />
                            
                            <asp:RequiredFieldValidator ID="CurrentPasswordRequired" runat="server" ControlToValidate="CurrentPassword"
                                Display="None" ErrorMessage="Password" ValidationGroup="ChangePassword1" />
                        </div>
                        
                        <div class="row">
                            <asp:Label ID="lblNewPassword" CssClass="label" runat="server" AssociatedControlID="NewPassword">New Password</asp:Label>
                            <telerik:RadTextBox ID="NewPassword" runat="server" TextMode="Password" />
                            
                            <asp:RequiredFieldValidator ID="NewPasswordRequired" runat="server" ControlToValidate="NewPassword"
                                Display="None" ErrorMessage="New Password" ValidationGroup="ChangePassword1" />
                        </div>
                        
                        <div class="row">
                            <asp:Label ID="lblConfirmNewPassword" CssClass="label" runat="server" AssociatedControlID="ConfirmNewPassword">Confirmation</asp:Label>
                            <telerik:RadTextBox ID="ConfirmNewPassword" runat="server" TextMode="Password" />
                            
                            <asp:RequiredFieldValidator ID="ConfirmNewPasswordRequired" runat="server" ControlToValidate="ConfirmNewPassword"
                                Display="None" ErrorMessage="Confirmation Password" ValidationGroup="ChangePassword1" />
                            </asp:RequiredFieldValidator>
                            
                            <asp:CompareValidator ID="NewPasswordCompare" runat="server" ControlToCompare="NewPassword"
                                ControlToValidate="ConfirmNewPassword" Display="None" ErrorMessage="New Passwords (do not match)"
                                Font-Bold="False" ValidationGroup="ChangePassword1" />
                        </div>
                        
                        <div class="row">
                            <asp:Literal ID="FailureText" runat="server" EnableViewState="False" />
                        </div>
                        
                        <div class="row">
                            <asp:Label class="label" ID="lblChangePasswordPushButton" runat="server"
                                AssociatedControlID="ChangePasswordPushButton">&nbsp;</asp:Label>
                            
                            <asp:Button ID="ChangePasswordPushButton" runat="server"
                                CommandName="ChangePassword" ValidationGroup="ChangePassword1"
                                OnClick="Validate_Change" Text="Change Password" />
                        </div>
                    </ChangePasswordTemplate>
                    <SuccessTemplate>
                        <div class="row">Your password has been changed!</div>
                    </SuccessTemplate>
                    <MailDefinition
                        BodyFileName="~/email_templates/PasswordChanged.txt"
                        From="support@buildmateapp.com"
                        IsBodyHtml="true"
                        Subject="[BuildMate] Your password has been changed"
                    />
                </asp:ChangePassword>
            </div>
        </div>
        
</asp:Content>

