<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/common/Guest.master" CodeFile="default.aspx.vb" Inherits="unsubscribe_default" Title="Unsubscribe - Buildmate" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content" ContentPlaceHolderID="MainContent" runat="Server">
    <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlId="pUnsubscribe">
                <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="pUnsubscribe" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    
    <asp:Panel ID="pUnsubscribe" runat="server" DefaultButton="btnUnsubscribe" Visible="false">
        <h1>Unsubscribe</h1>

        <p>
            To stop receiving commercial and marketing related messages from us, enter your email address below and click 'Unsubscribe'.
        </p>

        <p>
            Once unsubscribed, you may still receive transactional emails from us such as subscription related information.
        </p>

        <p>
            Note: You'll need to enter the email address to which we sent the email message. If the email address you enter is not
            recognised, we may be sending it to an old email address of yours, or an email alias that you're part of (for example, 'info@', 'sales@' and so on).
        </p>

        <strong>Confirm your email address</strong>
        
        <div class="row">
            <telerik:RadTextBox
                ID="emailAddr"
                runat="server"
                Width="210px"
                EmptyMessage="Enter your email address"
                TextMode="SingleLine" />
            
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                ControlToValidate="emailAddr"
                Display="Dynamic">*required
            </asp:RequiredFieldValidator>
        </div>

        <div class="row">
            <asp:Button ID="btnUnsubscribe" runat="server" Text="Unsubscribe" CssClass="button button-error" />
        </div>
    </asp:Panel>

    <asp:Panel ID="pInvalidToken" runat="server" Visible="false">
        <h1>Your unsubscribe link has expired</h1>

        <p>To unsubscribe please login to your <a href="../settings.aspx">settings page</a> and disable the Digest by clicking the "Receive email Notifications" checkbox in the Notifications tab.</p>
    </asp:Panel>

    <asp:Panel ID="pConfirmed" runat="server" Visible="false">
        <h1>Your Buildmate Digest has been cancelled!</h1>

        <p>Thank you, you will no longer receive emails from the Buildmate Digest.</p>
    </asp:Panel>

    <asp:Panel ID="pFailed" runat="server" Visible="false">
        <h1>We were unable to unsubscribe you!</h1>

        <p>Unfortunately we were unable to cancel your Buildmate Digest, please contact our <a href="mailto:support@buildmateapp.com">support team</a></p>
    </asp:Panel>
</asp:Content>