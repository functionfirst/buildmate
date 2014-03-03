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
    
    <h1>Buildmate Email Subscriptions</h1>

    <p>Enter your email address below to unsubscribe from all Buildmate email subscriptions.</p>

    <asp:Panel ID="pUnsubscribe" runat="server" DefaultButton="btnUnsubscribe">
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
            <asp:Button ID="btnUnsubscribe" runat="server" Text="Unsubscribe" CssClass="button" />
        </div>
    </asp:Panel>
</asp:Content>