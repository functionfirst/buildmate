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
            <asp:Panel ID="pReset" runat="server" Visible="false">
                <h1>Password Reset</h1>

                <asp:ValidationSummary ID="ValidationSummary1" runat="server"
                    DisplayMode="BulletList"
                    ShowSummary="true"
                    HeaderText="Your password must meet the following criteria"
                    ValidationGroup="PasswordReset" />

                <div class="row">
                    <asp:Label
                        ID="Label1"
                        runat="server"
                        Text="Password"
                        CssClass="label"
                        AssociatedControlID="rtbPassword" />

                    <telerik:RadTextBox
                        ID="rtbPassword"
                        runat="server"
                        Width="210px"
                        TextMode="Password" />

                    <asp:RequiredFieldValidator
                        ID="RequiredFieldValidator1"
                        runat="server"
                        ControlToValidate="rtbPassword"
                        Display="None"
                        ErrorMessage="New Password is required"
                        ValidationGroup="PasswordReset">
                    </asp:RequiredFieldValidator>
                    
                    <asp:RegularExpressionValidator runat="server"
                        ValidationGroup="PasswordReset"
                        ControlToValidate="rtbPassword"
                        Display="None"
                        ErrorMessage="Password must be 6-12 nonblank characters."
                        ValidationExpression="[^\s]{4,12}" />
                </div>
                <div class="row">
                    <asp:Label
                        ID="Label2"
                        runat="server"
                        Text="Confirm Password"
                        CssClass="label"
                        AssociatedControlID="rtbConfirmPassword" />

                    <telerik:RadTextBox
                        ID="rtbConfirmPassword"
                        runat="server"
                        Width="210px"
                        TextMode="Password" />

                    <asp:RequiredFieldValidator
                        ID="RequiredFieldValidator2"
                        runat="server"
                        ControlToValidate="rtbConfirmPassword"
                        Display="None"
                        ErrorMessage="Confirmation Password is required"
                        ValidationGroup="PasswordReset">
                        
                    </asp:RequiredFieldValidator>

                    <asp:CompareValidator ID="CompareValidator1" runat="server"
                        ControlToCompare="rtbPassword"
                        ControlToValidate="rtbConfirmPassword"
                        ValidationGroup="PasswordReset"
                        Display="None"
                        ErrorMessage="Passwords must match">
                    </asp:CompareValidator>
                </div>

                <div class="row">
                    <label class="label">&nbsp;</label>

                    <asp:Button ID="btnReset" runat="server"
                        CommandName="Submit"
                        CssClass="button"
                        ValidationGroup="PasswordReset"
                        Text="ChangePassword" />
                </div>

            </asp:Panel>

            <asp:Panel ID="pInvalidToken" runat="server" Visible="false">
                <h1>Reset link has expired</h1>

                <p>This password reset link has expired. If you still wish to reset your password please goto the <a href="/forgotten_password/">Forgotten Password</a> page.</p>
            </asp:Panel>

            <asp:Panel ID="pConfirmed" runat="server" Visible="false">
                <h1>Password reset successfully!</h1>

                <p>Your Password has been reset succesfully, you should now be able to <a href="/">login</a>.</p>
            </asp:Panel>
        </telerik:RadAjaxPanel>
                
        <p class="centrealign">
            <a href="../">Go back to login the page</a>
        </p>
    </div>
    </form>
</body>
</html>