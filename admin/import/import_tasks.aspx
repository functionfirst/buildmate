<%@ Page Language="VB" AutoEventWireup="false" CodeFile="import_tasks.aspx.vb" Inherits="non_web_import" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Untitled Page</title>
    <link href="../css/manager.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" />

        <div class="inner_container">
            <fieldset>
                <legend>Data Import</legend>
        
                <div class="row">
                    <label class="label" title="Filename">Filename</label>
					<asp:TextBox id="filename" runat="server" />
                </div>
        
                <div class="row">
                    <label class="label">&nbsp;</label>
                    <asp:Button ID="btnStart" runat="server" Text="Start Import" />
                </div>
                
            </fieldset>
        </div>
    </form>
</body>
</html>
