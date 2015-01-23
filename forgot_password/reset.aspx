<%@ Page Language="VB" AutoEventWireup="false" CodeFile="reset.aspx.vb" Inherits="login" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<html xmlns="http://www.w3.org/1999/xhtml" class="login-page">
<head runat="server">
    <title>Forgot your password? - Buildmate</title>
    
    <meta name="description" content="Buildmate application" />
    <meta name="author" content="Alan Jenkins" />
	<meta name="viewport" content="width=device-width,initial-scale=1" />
    
    <!-- css -->
    <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,600,300' rel='stylesheet' type='text/css' />
    <link rel="stylesheet" href="~/css/manager.less" />
        
    <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js"></script>
    <script type="text/javascript" src="/js/functions.js"></script>
</head>
<body>
    <form id="form1" runat="server">

    <asp:ScriptManager ID="ScriptManager1" runat="server" />

    <div class="login-form">
            <div class="logo logo-black"><a href="http://www.getbuildmate.com" title="Buildmate">Buildmate</a></div>

        <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" CssClass="login-form-inner">

            <h1>Forgotten your password?</h1>
            
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
                                Width="210px"
                                EmptyMessage="Enter your email..."
                                TextMode="SingleLine" />

                            <asp:RequiredFieldValidator
                                ID="RequiredFieldValidator1"
                                runat="server"
                                ControlToValidate="UserName"
                                Display="Dynamic"
                                CssClass="required"
                                ValidationGroup="PasswordRecovery1">
                                An email address is required
                            </asp:RequiredFieldValidator>
                        </div>

                        <asp:RegularExpressionValidator
                                ID="RegularExpressionValidator1"
                                runat="server"
                                ControlToValidate="UserName"
                                ValidationGroup="PasswordRecovery1"
                                Display="Dynamic"
                                CssClass="required"
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
            </asp:PasswordRecovery>
        </telerik:RadAjaxPanel>

                
        <p class="centrealign">
            <a href="../">Go back to login the page</a>
        </p>
    </div>
    </form>
</body>
</html>