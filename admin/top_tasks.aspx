<%@ Page Title="Top level Tasks" Language="VB" MasterPageFile="~/common/admin.master" AutoEventWireup="false" CodeFile="top_tasks.aspx.vb" Inherits="top_tasks" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">


<telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlId="rgTopTasks">
            <UpdatedControls>
                 <telerik:AjaxUpdatedControl ControlID="rgTopTasks" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>

    <p class="breadcrumb">
        Top Level Tasks
    </p>

    <telerik:RadGrid ID="rgTopTasks" runat="server"
        DataSourceID="taskDataSource" 
        GridLines="None">
        <MasterTableView
            AutoGenerateColumns="False"
            DataKeyNames="id"
            AllowAutomaticUpdates="true"
            AllowSorting="true"
            DataSourceID="taskDataSource">
            <RowIndicatorColumn>
<HeaderStyle Width="20px"></HeaderStyle>
</RowIndicatorColumn>

<ExpandCollapseColumn>
<HeaderStyle Width="20px"></HeaderStyle>
</ExpandCollapseColumn>
    <Columns>
        <telerik:GridTemplateColumn
            HeaderText="Enabled"
            UniqueName="isEnabled"
            HeaderStyle-Width="10%">
            <ItemTemplate>
            <asp:CheckBox ID="CheckBox1" runat="server"
                AutoPostBack="true"
                Checked='<%# Iif(isDBNull(eval("parentId")), "true", "false") %>' />
                <asp:HiddenField ID="hfID" runat="server" Value='<%#eval("id") %>' />
            </ItemTemplate>
        </telerik:GridTemplateColumn>
        <telerik:GridBoundColumn DataField="taskName" HeaderText="Task Name" 
            SortExpression="taskName" UniqueName="taskName">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="id" DataType="System.Int64" HeaderText="Order" 
            ReadOnly="True" SortExpression="id" UniqueName="id">
        </telerik:GridBoundColumn>
    </Columns>
</MasterTableView>
    </telerik:RadGrid>


    <asp:SqlDataSource ID="taskDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="SELECT * FROM TaskData where parentid = 0 or parentid is null">
    </asp:SqlDataSource>
</asp:Content>

