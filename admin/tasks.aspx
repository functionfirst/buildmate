<%@ Page Language="VB" MasterPageFile="~/common/admin.master" AutoEventWireup="false" CodeFile="tasks.aspx.vb" Inherits="manager_Default" title="Tasks - Pyramid Estimator Tool Kit" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="head" ContentPlaceHolderID="head" Runat="Server"></asp:Content>

<asp:Content ID="Content" ContentPlaceHolderID="MainContent" Runat="Server">
    
    <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlId="RadTreeView1">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="RadTreeView1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    
    <p class="breadcrumb">
        Task Manager
    </p>

    
    <asp:HyperLink ID="hlAddTask" runat="server"
        CssClass="floatright"
        NavigateUrl="~/admin/add_task.aspx">
        <span></span>Add a Top-level Task
    </asp:HyperLink>
    
    <telerik:RadTreeView runat="server" ID="RadTreeView1"
        SingleExpandPath="true"
        style="white-space: normal;"
        ShowLineImages="false" />

</asp:Content>