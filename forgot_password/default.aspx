<%@ Page Language="VB" AutoEventWireup="false" CodeFile="default.aspx.vb" Inherits="login" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Forgot your password? - BuildMate</title>
    
    <link rel="stylesheet" type="text/css" href="~/css/manager.css" />    
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js"></script>
    <script type="text/javascript" src="/js/functions.js"></script>
</head>
<body>
    <form id="form1" runat="server">

    <asp:ScriptManager ID="ScriptManager1" runat="server" />

    <div class="container container_small">

   <div class="logo"><a href="http://www.getbuildmate.com" title="BuildMate">BuildMate</a></div>

        <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server">

            <div class="box">
                <h3>Forgotten your password?</h3>
            
                <div class="boxcontent">
                    <asp:PasswordRecovery ID="PasswordRecovery2" runat="server">
                        <UserNameTemplate>
                            <asp:Panel ID="Panel1" runat="server" DefaultButton="btnLogin">
                                <p>
                                    To recover your password, enter your email address below. If we recognise your email address, we'll send an email confirmation to you straight away.
                                </p>

                                <div class="row">
                                    <asp:Label
                                        ID="Label1"
                                        runat="server"
                                        Text="Email"
                                        CssClass="label"
                                        AssociatedControlID="UserName" />

                                    <telerik:RadTextBox
                                        ID="UserName"
                                        runat="server"
                                        Width="240"
                                        EmptyMessage="Enter your email..."
                                        TextMode="SingleLine" />

                                    <asp:RequiredFieldValidator
                                        ID="RequiredFieldValidator1"
                                        runat="server"
                                        ControlToValidate="UserName"
                                        Display="Dynamic"
                                        ValidationGroup="PasswordRecovery1">
                                        <span class="req"></span>
                                    </asp:RequiredFieldValidator>
                                </div>

                                <asp:RegularExpressionValidator
                                        ID="RegularExpressionValidator1"
                                        runat="server"
                                        ControlToValidate="UserName"
                                        ValidationGroup="PasswordRecovery1"
                                        Display="Dynamic"
                                        ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">
                                        <div class="row">
                                            <label class="label">&nbsp;</label>
                                            <p class="error">This email isn't valid.</p>
                                        </div>
                                    </asp:RegularExpressionValidator>

                                    <asp:label
                                        ID="FailureText"
                                        runat="server"
                                        EnableViewState="False"
                                        CssClass="warning" style="color: Red" />

                                <div class="row">
                                    <label class="label">&nbsp;</label>

                                    <asp:Button ID="btnLogin" runat="server"
                                        CommandName="Submit"
                                        CssClass="button"
                                        ValidationGroup="PasswordRecovery1"
                                        Text="Recover your Password" />
                                </div>
                               
                                
                            </asp:Panel>
                        </UserNameTemplate>
                        <SuccessTemplate>
                            <p>We've sent you an email confirming your password.</p>
                        </SuccessTemplate>
                        <MailDefinition
                            From="support@buildmateapp.com"
                            Subject="[BuildMate] Password Confirmation"
                            IsBodyHtml="true"
                            BodyFileName="~/email_templates/RecoverPassword.txt" />
                    </asp:PasswordRecovery>

                    <div class="row">
                        <ul>
                            <li><a href="../">Go back to login the page</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </telerik:RadAjaxPanel>
        
        <p class="copy_footer">
            &copy; 2012 Pyramid Estimator Ltd &bull;
            <a href="http://www.getbuildmate.com/contact/">Contact</a> &bull;
            <a href="http://www.getbuildmate.com/privacy/">Privacy</a> &bull;
            <a href="http://www.getbuildmate.com/terms/">Terms of Use</a>
        </p>
    </div>
    </form>
</body>
</html>