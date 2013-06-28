<%@ Page Language="VB" AutoEventWireup="false" CodeFile="login.aspx.vb" Inherits="login" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login - BuildMate</title>
    
    <link rel="stylesheet" type="text/css" href="~/css/manager.css" />    
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
    <script type="text/javascript" src="/js/functions.js"></script>
</head>
<body>
    <form id="form1" runat="server">

    <asp:ScriptManager ID="ScriptManager1" runat="server" />

    <div class="container container_small">
       <div class="box">
            <div class="logo"><a href="http://www.getbuildmate.com" title="BuildMate">BuildMate</a></div>

          

            <div class="boxcontent">
                <asp:Login ID="Login1" runat="server" Width="100%">
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
                                    Width="180"
                                    TextMode="SingleLine" />

                                <asp:RequiredFieldValidator
                                    ID="RequiredFieldValidator1"
                                    runat="server"
                                    ControlToValidate="UserName">
                                    <span class="req"></span>
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
                                    Width="180"
                                    TextMode="Password" />

                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                                    ControlToValidate="Password"
                                    Display="Dynamic">
                                    <span class="req"></span>
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
                                    CssClass="button"
                                    CommandName="Login"
                                    Text="Login" />
                            </div>

                            <div class="row">
                                <ul>
                                    <li><a href="/forgot_password/">Forgot your password?</a></li>
                                    <li>Don't have an account? <a href="http://getbuildmate.com/signup/">Start your free 30 day trial</a></li>
                                </ul>
                            </div>
                        </asp:Panel>
                    </LayoutTemplate>
                </asp:Login>
            </div>
        </div>
        
        <p class="copy_footer">
            &copy; 2013 Pyramid Estimator Ltd &bull;
            <a href="http://www.getbuildmate.com/contact/">Contact</a> &bull;
            <a href="http://www.getbuildmate.com/privacy/">Privacy</a> &bull;
            <a href="http://www.getbuildmate.com/terms/">Terms of Use</a>
        </p>
    </form>
</body>
</html>