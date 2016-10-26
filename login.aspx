<%@ Page Language="VB" AutoEventWireup="false" CodeFile="login.aspx.vb" MasterPageFile="~/common/Guest.master" Inherits="login"  Title="Login - Buildmate" %>

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

    <h1>Login</h1>

    <asp:Login ID="Login1" runat="server">
        <LayoutTemplate>
            <asp:Panel ID="Panel1" runat="server" DefaultButton="btnLogin">
                <div class="row">
                    <asp:Label
                        ID="Label1"
                        CssClass="label"
                        runat="server"
                        AssociatedControlID="userName"
                        Text="Email" />

                    <asp:TextBox
                        ID="userName"
                        runat="server"
                        Width="210px"
                        TextMode="SingleLine" />

                    <asp:RequiredFieldValidator
                        ID="RequiredFieldValidator1"
                        runat="server"
                        Display="Dynamic"
                        CssClass="required"
                        ControlToValidate="UserName">
                        Username is required
                    </asp:RequiredFieldValidator>
                </div>

                <div class="row">
                    <asp:Label
                        ID="Label2"
                        runat="server"
                        CssClass="label"
                        AssociatedControlID="Password"
                        Text="Password" />
                                
                    <asp:TextBox
                        ID="Password"
                        runat="server"
                        Width="210px"
                        TextMode="Password" />

                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                        ControlToValidate="Password"
                        CssClass="required"
                        Display="Dynamic">
                        Password is required
                    </asp:RequiredFieldValidator>

                    <div>
                        <asp:label id="FailureText" runat="server" style="font-size: 10px; color: Red" />
                    </div>
                </div>
                            
                <div class="row">
                    <label class="label">&nbsp;</label>

                    <asp:Button
                        ID="btnLogin"
                        runat="server"
                        CssClass="button button-large button-create"
                        CommandName="Login"
                        Text="Login" />
                                   
                    <a href="/register/" class="button button-large button-secondary">Register</a>
                </div>

                <div class="row">
                    <label class="label">&nbsp;</label>

                    
                    <a href="/forgot_password/">Forgot your password?</a>
                </div>
            </asp:Panel>
        </LayoutTemplate>
    </asp:Login>
</asp:Content>