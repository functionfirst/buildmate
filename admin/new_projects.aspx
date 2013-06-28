<%@ Page Language="VB" MasterPageFile="~/common/admin.master" AutoEventWireup="false" CodeFile="new_projects.aspx.vb" Inherits="new_projects" title="New Projects - Admin" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="head" ContentPlaceHolderID="head" Runat="Server"></asp:Content>

<asp:Content ID="Content" ContentPlaceHolderID="MainContent" Runat="Server">


    <p class="breadcrumb">
        New Projects
    </p>


    <telerik:RadGrid ID="RadGrid1" runat="server" CellSpacing="0" GridLines="None" DataSourceID="SqlDataSource1">
<MasterTableView AutoGenerateColumns="False" DataSourceID="SqlDataSource1">
<CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>

<RowIndicatorColumn Visible="True">
<HeaderStyle Width="20px"></HeaderStyle>
</RowIndicatorColumn>

<ExpandCollapseColumn Visible="True">
<HeaderStyle Width="20px"></HeaderStyle>
</ExpandCollapseColumn>

    <Columns>
        <telerik:GridBoundColumn DataField="customerName" HeaderText="Customer Name" ReadOnly="True" SortExpression="customerName" UniqueName="customerName">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="email" HeaderText="Email" SortExpression="email" UniqueName="email">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="company" HeaderText="Company Name" SortExpression="company" UniqueName="company">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="creationDate" HeaderText="Creation Date" SortExpression="creationDate" UniqueName="creationDate">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="projectName" HeaderText="Project" SortExpression="projectName" UniqueName="projectName">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="subscription" DataType="System.DateTime" HeaderText="Subscription Expires" SortExpression="subscription" UniqueName="subscription">
        </telerik:GridBoundColumn>
    </Columns>


</MasterTableView>
    </telerik:RadGrid>
            
    <asp:SqlDataSource ID="SqlDataSource1" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="
            SELECT top 100 isNull(firstname + ' ' + surname, 'Unknown') AS customerName, email, company, projectName, subscription, creationDate
            FROM Project
            LEFT JOIN UserProfile ON Project.userID = UserProfile.userid
            ORDER BY creationDate DESC">
    </asp:SqlDataSource>
    
</asp:Content>