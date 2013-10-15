<%@ Page Language="VB" AutoEventWireup="false" CodeFile="login.aspx.vb" Inherits="login" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<html xmlns="http://www.w3.org/1999/xhtml" class="login-page">
<head runat="server">
    <title>Login - Buildmate</title>

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
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
    <script type="text/javascript" src="/js/functions.js"></script>
</head>
<body>
    <form id="form1" runat="server">

    <asp:ScriptManager ID="ScriptManager1" runat="server" />

       <div class="login-form">
            <div class="logo logo-black"><a href="http://www.getbuildmate.com" title="Buildmate">Buildmate</a></div>

            <div class="login-form-inner">
                <h1>Login</h1>

                <asp:Login ID="Login1" runat="server" RenderOuterTable="false">
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
                                    CssClass="button button-create"
                                    CommandName="Login"
                                    Text="Login" />
                                   
                                <a href="http://getbuildmate.com/signup/" class="button">Register</a>
                            </div>
                        </asp:Panel>
                    </LayoutTemplate>
                </asp:Login>
            </div>
        
        <div class="container centrealign">
            <p>
                <a href="/forgot_password/">Forgot your password?</a>
            </p>
        </div>
    </form>

       
    <script type="text/javascript">
        var _mfq = _mfq || [];
        (function () {
            var mf = document.createElement("script"); mf.type = "text/javascript"; mf.async = true;
            mf.src = "//cdn.mouseflow.com/projects/14253c8b-9914-4c12-9ff3-e5e56ce2c250.js";
            document.getElementsByTagName("head")[0].appendChild(mf);
        })();
</script>
</body>
</html>