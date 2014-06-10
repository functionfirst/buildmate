<%@ Page Title="Users" Language="VB" MasterPageFile="~/common/admin.master" AutoEventWireup="false" CodeFile="users.aspx.vb" Inherits="users" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">

       

    <p class="breadcrumb">
        Users
    </p>

    <telerik:RadGrid ID="rgUsers" runat="server" DataSourceID="SqlDataSource1" 
        GridLines="None">
<MasterTableView DataSourceID="SqlDataSource1" AutoGenerateColumns="False" AllowSorting="true">
<RowIndicatorColumn>
<HeaderStyle Width="20px"></HeaderStyle>
</RowIndicatorColumn>

<ExpandCollapseColumn>
<HeaderStyle Width="20px"></HeaderStyle>
</ExpandCollapseColumn>
    <Columns>

        <telerik:GridBoundColumn DataField="UserName" HeaderText="UserName" 
            SortExpression="UserName" UniqueName="UserName">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="LastActivityDate" 
            DataType="System.DateTime" HeaderText="LastActivityDate" 
            SortExpression="LastActivityDate" UniqueName="LastActivityDate">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="Email" HeaderText="Email" 
            SortExpression="Email" UniqueName="Email">
        </telerik:GridBoundColumn>
        <telerik:GridCheckBoxColumn DataField="IsApproved" DataType="System.Boolean" 
            HeaderText="IsApproved" SortExpression="IsApproved" UniqueName="IsApproved">
        </telerik:GridCheckBoxColumn>
        <telerik:GridCheckBoxColumn DataField="IsLockedOut" DataType="System.Boolean" 
            HeaderText="IsLockedOut" SortExpression="IsLockedOut" UniqueName="IsLockedOut">
        </telerik:GridCheckBoxColumn>
        <telerik:GridBoundColumn DataField="CreateDate" DataType="System.DateTime" 
            HeaderText="CreateDate" SortExpression="CreateDate" UniqueName="CreateDate">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="LastLoginDate" DataType="System.DateTime" 
            HeaderText="LastLoginDate" SortExpression="LastLoginDate" 
            UniqueName="LastLoginDate">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="Comment" HeaderText="Comment" 
            SortExpression="Comment" UniqueName="Comment">
        </telerik:GridBoundColumn>
    </Columns>
</MasterTableView>
    </telerik:RadGrid>
    
    <asp:SqlDataSource ID="SqlDataSource1" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="
            SELECT *
            FROM [aspnet_Users]
            LEFT JOIN [aspnet_Membership] ON [aspnet_Users].userId = [aspnet_membership].UserId">
    </asp:SqlDataSource>

</asp:Content>

