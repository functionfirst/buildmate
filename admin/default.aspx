<%@ Page Language="VB" MasterPageFile="~/common/admin.master" AutoEventWireup="false" CodeFile="default.aspx.vb" Inherits="manager_Default" title="Dashboard - Admin" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Charting" tagprefix="telerik" %>

<asp:Content ID="head" ContentPlaceHolderID="head" Runat="Server"></asp:Content>

<asp:Content ID="Content" ContentPlaceHolderID="MainContent" Runat="Server">
    
    <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlId="tabWizard" EventName="click">
            <UpdatedControls>
                 <telerik:AjaxUpdatedControl ControlID="tabWizard" />
                 <telerik:AjaxUpdatedControl ControlID="RadMultiPage1" LoadingPanelID="RadAjaxLoadingPanel1" />
            </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    

    <p class="breadcrumb">
        Dashboard
    </p>

    <div style="float: right; width: 200px">
      
    <asp:Repeater ID="Repeater4" runat="server" DataSourceID="SqlDataSource1">
        <ItemTemplate>
            <div class="stat">
                <h4>Users</h4>
                <p><%#String.Format("{0:#,###}", Eval("total"))%></p>
            </div>
        </ItemTemplate>
    </asp:Repeater>
            
    <asp:SqlDataSource ID="SqlDataSource1" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="
            SELECT count(userid) AS total FROM aspnet_users">
    </asp:SqlDataSource>
    


    <asp:Repeater ID="Repeater5" runat="server" DataSourceID="SqlDataSource2">
        <ItemTemplate>
            <div class="stat">
                <h4>Projects</h4>
                <p><%#String.Format("{0:#,###}", Eval("total"))%></p>
            </div>
        </ItemTemplate>
    </asp:Repeater>
            
    <asp:SqlDataSource ID="SqlDataSource2" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="
            SELECT count(id) AS total FROM project">
    </asp:SqlDataSource>


            <asp:Repeater ID="Repeater1" runat="server" DataSourceID="totalTasksDS">
            <ItemTemplate>
                <div class="stat">
                    <h4>Total Tasks</h4>
                    <p><%#String.Format("{0:#,###}", Eval("total"))%></p>
                </div>
            </ItemTemplate>
            </asp:Repeater>
            
            <asp:SqlDataSource ID="totalTasksDS" runat="server"
                ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
                SelectCommand="
                    SELECT count(id) AS total FROM TaskData">
            </asp:SqlDataSource>
            
            
            
            <asp:Repeater ID="Repeater2" runat="server" DataSourceID="totalTasksInUseDS">
            <ItemTemplate>
                <div class="stat">
                    <h4>Tasks in Use</h4>
                    <p><%#String.Format("{0:#,###}", Eval("total"))%></p>
                </div>
            </ItemTemplate>
            </asp:Repeater>
            
            <asp:SqlDataSource ID="totalTasksInUseDS" runat="server"
                ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
                SelectCommand="
                    SELECT count(id) AS total FROM Task">
            </asp:SqlDataSource>
            
            
            
            <asp:Repeater ID="Repeater3" runat="server" DataSourceID="totalResourcesDS">
            <ItemTemplate>
                <div class="stat">
                    <h4>Resources</h4>
                    <p><%#String.Format("{0:#,###}", Eval("total"))%></p>
                </div>
            </ItemTemplate>
            </asp:Repeater>
            
            <asp:SqlDataSource ID="totalResourcesDS" runat="server"
                ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
                SelectCommand="
                    SELECT count(id) AS total FROM Resource">
            </asp:SqlDataSource>
    </div>
</asp:Content>