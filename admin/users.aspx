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
        <telerik:GridHyperLinkColumn
            UniqueName="username"
            HeaderText="Username"
            SortExpression="Username"
            DataNavigateUrlFields="userid"
            DataTextField="username"
            DataNavigateUrlFormatString="/admin/users/details/index.aspx?userid={0}" />

        <telerik:GridBoundColumn DataField="tourPhase" HeaderText="Tour Phase" 
            SortExpression="tourPhase" UniqueName="tourPhase">
        </telerik:GridBoundColumn>
<%--        <telerik:GridBoundColumn DataField="LastActivityDate" 
            DataType="System.DateTime" HeaderText="LastActivityDate" 
            SortExpression="LastActivityDate" UniqueName="LastActivityDate">
        </telerik:GridBoundColumn>--%>
        <%--<telerik:GridBoundColumn DataField="Email" HeaderText="Email" 
            SortExpression="Email" UniqueName="Email">
        </telerik:GridBoundColumn>--%>
<%--        <telerik:GridCheckBoxColumn DataField="IsApproved" DataType="System.Boolean" 
            HeaderText="IsApproved" SortExpression="IsApproved" UniqueName="IsApproved">
        </telerik:GridCheckBoxColumn>--%>
        
        <telerik:GridBoundColumn DataField="CreateDate" DataType="System.DateTime" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"
            HeaderText="Sign-up Date" SortExpression="CreateDate" UniqueName="CreateDate">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="LastLoginDate" DataType="System.DateTime" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"
            HeaderText="Last Logged-in" SortExpression="LastLoginDate" 
            UniqueName="LastLoginDate">
        </telerik:GridBoundColumn>
        <telerik:GridCheckBoxColumn DataField="notifyByEmail" DataType="System.Boolean" HeaderStyle-Width="10%" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"
            HeaderText="Notify by Email" SortExpression="notifyByEmail" UniqueName="notifyByEmail">
        </telerik:GridCheckBoxColumn>
        <telerik:GridCheckBoxColumn DataField="IsLockedOut" DataType="System.Boolean" HeaderStyle-Width="10%" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"
            HeaderText="Locked Out" SortExpression="IsLockedOut" UniqueName="IsLockedOut">
        </telerik:GridCheckBoxColumn>
    </Columns>
</MasterTableView>
    </telerik:RadGrid>
    
    <asp:SqlDataSource ID="SqlDataSource1" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="
            SELECT *
            FROM [aspnet_Users]
            LEFT JOIN [aspnet_Membership] ON [aspnet_Users].userId = [aspnet_membership].UserId
            LEFT JOIN [UserProfile] ON [UserProfile].userId= [aspnet_Users].userId
            ORDER BY createDate DESC">
    </asp:SqlDataSource>

</asp:Content>

