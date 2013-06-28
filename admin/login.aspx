<%@ Page Language="VB" AutoEventWireup="false" CodeFile="login.aspx.vb" Inherits="login" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin PyramidEstimator - Login</title>
    <style type="text/css">
	BODY {
		font: 12px/1.7em "Helvetica Neue",Helvetica,Arial,Geneva,sans-serif;
		background: #efefea;
		color: #2c2c2c
	}
	
	.container { width: 380px; margin: 100px auto }
	
	.logo { margin: 15px 0 }
	.logo a { background: url(http://www.pyramidestimator.com/images/logo_s.png); display: block; height: 53px; width: 227px; text-indent: -999em }
	
	.box { border: 1px solid #ccc; padding: 20px; background: #fff; -moz-border-radius: 12px;  }
	
	p { margin: 0 0 10px; }
	
	.label { font-weight: bold; display: block }
	
	p span { display: block; color: #666; margin: 5px 0 }
	
	ul { list-style: none; margin: 10px 0 10px 95px; padding: 0 5px 0 0 }
	
	li { display: inline-block; margin: 0 20px 0 0}
	
	li:last-child { border: 0 }
	
	a:link, a:visited{ color: #2C2C2C; font-weight: bold }
	
	a:hover { color: #8b8b8b }
	
	input[type='text'], input[type='password']
	{
	    color: #333;
	    width: 316px;
	    padding: 5px 7px;
	    border: 1px solid #ccc;
	    -moz-border-radius: 3px;
	    -webkit-border-radius: 3px;
	    border-radius: 3px;
	    -moz-box-shadow: 0 1px 4px #D3D3D3 inset;
	    -webkit-box-shadow: 0 1px 4px #D3D3D3 inset;
	    box-shadow: 0 1px 4px #D3D3D3 inset
    }
	
	.button { width: auto; font-weight: bold; cursor: pointer;
        background: -moz-linear-gradient(#555, #333) #333;
        border: 0;
        color: #fff;
        padding: 8px 12px;
        -moz-border-radius: 6px;
        -webkit-border-radius: 6px;
        border-radius: 6px;
        -moz-box-shadow: 0 1px 3px #666, 0 0 3px #777 inset;
        -webkit-box-shadow: 0 1px 3px #666, 0 0 3px #777 inset;
        box-shadow: 0 1px 3px #666, 0 0 3px #777 inset;
        }
    
    .button:hover, .create:hover { background: #555}
    
    .cancel:link, .cancel:visited 
    {
        color: #fff; text-decoration: none; padding: 8px 12px;
        background: -moz-linear-gradient(#888, #666) #666;
        font-weight: normal; margin-right: 20px
    }
    
    .right { text-align: right }
    
    
    </style>
</head>
<body>
    <form id="form1" runat="server">

    <asp:ScriptManager ID="ScriptManager1" runat="server" />


<div class="container">

   <div class="logo"><a href="http://www.pyramidestimator.com" title="Pyramid Estimator">Pyramid Estimator</a></div>

    <div class="box">
    

                <asp:Login ID="Login1" runat="server" Width="100%">
                    <LayoutTemplate>
             
                        <p class="row">
                            <asp:Label ID="lblUserName" runat="server"
                                CssClass="label"
                                AssociatedControlID="UserName"
                                Text="Email" />

                            <asp:TextBox ID="userName" runat="server" TextMode="SingleLine" />

                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                ControlToValidate="UserName"
                                Display="Dynamic"
                                ErrorMessage="Please enter your email address"
                                ToolTip="Email is required" 
                                ValidationGroup="Login1" />
                        </p>
                        
                        <p class="row">
                            <asp:Label ID="lblPassword" runat="server" CssClass="label"
                                AssociatedControlID="Password">Password </asp:Label>
                            
                            <asp:TextBox ID="Password" runat="server" TextMode="Password" />
                            
                            
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                                ControlToValidate="Password"
                                Display="Dynamic"
                                ErrorMessage="You must enter your password to continue"
                                ValidationGroup="Login1" />
                        </p>
                        
                        <p class="warning">
                            <asp:Literal id="FailureText" runat="server" />
                        </p>
                        
                        <p class="right">
                            <asp:Button ID="btnLogin" runat="server" CssClass="button"
                                CommandName="Login" ValidationGroup="Login1" Text="Login" />
                        </p>
                    </LayoutTemplate>
                </asp:Login>
    </form>
</body>
</html>