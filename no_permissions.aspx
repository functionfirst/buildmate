<%@ Page Title="Permissions - Buildmate" Language="VB" MasterPageFile="~/common/Manager.master" AutoEventWireup="false" CodeFile="no_permissions.aspx.vb" Inherits="notifications" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    
    <div class="breadcrumb">
        <div class="breadcrumb-container">
            <ul class="breadcrumb-list">
                <li class="active">
                    No Permissions
                </li>
            </ul>
        </div>
    </div>

    <div class="main-container">
        <h2>Permission Error!</h2>

        <p>
            You do not have permission to view the previous page. If you believe you should be able to see this page, please contact the <a href="support.aspx">Support team</a>.
        </p>
     </div>
</asp:Content>