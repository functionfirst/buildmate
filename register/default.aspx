<%@ Page Language="VB" AutoEventWireup="false" CodeFile="default.aspx.vb" Inherits="login" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Register - BuildMate</title>
    
    <link rel="stylesheet" type="text/css" href="~/css/manager.css" />    
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js"></script>
    <script type="text/javascript" src="/js/functions.js"></script>
</head>
<body>
    <form id="form1" runat="server">

    <asp:ScriptManager ID="ScriptManager1" runat="server" />

    <div class="container container_small">
        <div class="logo"><a href="http://www.getbuildmate.com" title="BuildMate">BuildMate</a></div>
        
        <div class="box">
            <h3>Start your free 30 day trial</h3>
            <p>You will be redirected shortly...</p>
        </div>
    </div>
        
    <p class="copy_footer">
        &copy; 2012 Pyramid Estimator Ltd &bull;
        <a href="http://www.getbuildmate.com/contact/">Contact</a> &bull;
        <a href="http://www.getbuildmate.com/privacy/">Privacy</a> &bull;
        <a href="http://www.getbuildmate.com/terms/">Terms of Use</a>
    </p>
    </form>
</body>
</html>