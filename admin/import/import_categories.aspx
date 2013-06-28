<%@ Page Language="VB" AutoEventWireup="false" CodeFile="import_categories.aspx.vb" Inherits="non_web_import" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Import to Labour</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>      
        <p>Use filename "categories.txt"</p>
        <asp:Button ID="btnImportCategories" runat="server" Text="Import Categories" />
    </div>
    </form>
</body>
</html>
