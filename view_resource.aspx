<%@ Page Title="View Resource - Buildmate" Language="VB" MasterPageFile="~/common/Manager.master" AutoEventWireup="false" CodeFile="view_resource.aspx.vb" Inherits="view_resource" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">

    <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlId="Panel1">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="Panel1" />
                     <telerik:AjaxUpdatedControl ControlID="rgResources" />
                     <telerik:AjaxUpdatedControl ControlID="lblCount" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlId="rgResources">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="rgResources" />
                     <telerik:AjaxUpdatedControl ControlID="btnSwapResource" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlId="rtbResourceName">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="rgResources" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlId="btnApplyFilter">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="rgResources" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>

    <div class="breadcrumb">
        <ul class="breadcrumb-list">
            <li>
             <asp:HyperLink ID="HyperLink1" runat="server"
                NavigateUrl="~/project_details.aspx?pid={0}"
                Text="Project Details" />
                <span class="divider">/</span>
            </li>
            <li>
                <asp:HyperLink ID="hlResource" runat="server"
                NavigateUrl="~/project_details.aspx?pid={0}"
                Text="Resource Costs" />
                <span class="divider">/</span>
            </li>
            <li class="active">Resource Details</li>
        </ul>
    </div>

    
    <div class="main-container">

    <div class="div33">
    <div class="box">
        <h3>Resource Details</h3>

        <div class="boxcontent">
            <asp:FormView ID="fvResourceDetails" runat="server" 
                DataSourceID="SqlDataSource1" EnableModelValidation="True">
                <ItemTemplate>
                    <div class="row">
                        <label class="label">Resource Name</label>
                        <asp:Label ID="Label1" runat="server" 
                            Text='<%# Bind("resourceName") %>' />
                    </div>
        
                    <div class="row">
                        <label class="label">Manufacturer</label>
                        <asp:Label ID="manufacturerLabel" runat="server" 
                            Text='<%# Bind("manufacturer") %>' />
                    </div>

                    <div class="row">
                        <label class="label">Part Id</label>
                        <asp:Label ID="partIdLabel" runat="server" Text='<%# Bind("partId") %>' />
                    </div>
                    
                    <div class="row">
                        <label class="label">Waste</label>
                        <asp:Label ID="wasteLabel" runat="server" Text='<%# Bind("waste", "{0}%") %>' />
                    </div>
                    
                    <div class="row">
                        <label class="label">Resource Type</label>
                        <asp:Label ID="resourceTypeLabel" runat="server" 
                            Text='<%# Bind("resourceType") %>' />
                    </div>
                    
                    <div class="row">
                        <label class="label">Category</label>
                        <asp:Label ID="categoryNameLabel" runat="server" 
                            Text='<%# Bind("categoryName") %>' />
                    </div>
                    
                    <div class="row">
                        <label class="label">Unit</label>
                        <asp:Label ID="UnitLabel" runat="server" Text='<%# Bind("Unit") %>' />
                   </div>

                </ItemTemplate>
            </asp:FormView>
        
        </div>
    </div>
    </div>

    <div class="div66 last">
        <div class="box">
            <h3>Use a different Resource</h3>

            <div class="boxcontent">
          
            <asp:Panel ID="Panel1" runat="server" DefaultButton="btnApplyFilter">
                Search for a resource by entering some keywords below.
                
                Once you've found the resource you need, click to highlight it then save your change by clicking 'Swap this Resource'.

              <table border="0" cellpadding="5" cellspacing="0">
                <tr>
                    <td>
                        <asp:Label ID="Label2" runat="server"
                            AssociatedControlID="rtbResourceName"
                            CssClass="label"
                            Text="Keywords" />
                    </td>
                    <td>
                        <telerik:RadTextBox
                            ID="rtbResourceName"
                            runat="server"
                            Width="180"
                            EmptyMessage="contains any word(s)"
                            AutoPostBack="true" />
                    </td>
                    <td>
                        <asp:Button ID="btnApplyFilter" CssClass="button" runat="server" Text="Search" />
                    </td>
                    <td class="rightalign">
                        <asp:Button ID="btnSwapResource" runat="server"
                            Text="Swap this Resource"
                            CssClass="button button-primary"
                            Enabled="false" OnClientClick="confirm('Are you sure you wish to swap this resource?')" />
                    </td>
                </tr>
              </table>
            </asp:Panel>

            <asp:Label ID="lblCount" runat="server" Visible="false">
                <div class="successBox">Your search returned more than 1,000 results, please be more specific with your search</div>
            </asp:Label>

            <telerik:RadGrid
                ID="rgResources"
                runat="server"
                DataSourceID="allResourcesDataSource"
                AllowPaging="true"
                PageSize="20"
                Visible="false"
                PagerStyle-Mode="NextPrev"
                ShowGroupPanel="false"
                AllowSorting="true"
                GridLines="None"
                ShowStatusBar="true">
                <ClientSettings EnablePostBackOnRowClick="true">
                    <Selecting AllowRowSelect="true" />
                </ClientSettings>
                <MasterTableView
                    AutoGenerateColumns="False"
                    DataSourceID="allResourcesDataSource"
                    DataKeyNames="id"
                    NoMasterRecordsText="&nbsp;No Resources were found.">
                    <Columns>
                        <telerik:GridBoundColumn
                            UniqueName="id"
                            HeaderText="id"
                            Visible="false"
                            SortExpression="id"
                            DataField="id" />

                        <telerik:GridBoundColumn
                            UniqueName="resourceName"
                            HeaderText="Resource Name"
                            SortExpression="resourceName"
                            DataField="resourceName" />
                        
                        <telerik:GridBoundColumn
                            UniqueName="manufacturer"
                            HeaderText="Manufacturer"
                            SortExpression="manufacturer"
                            DataField="manufacturer"
                            HeaderStyle-Width="15%"
                            ItemStyle-HorizontalAlign="Center"
                            HeaderStyle-HorizontalAlign="Center" />

                        <telerik:GridBoundColumn
                            UniqueName="partId"
                            HeaderText="Part Id"
                            SortExpression="partId"
                            DataField="partId"
                            HeaderStyle-Width="15%"
                            ItemStyle-HorizontalAlign="Center"
                            HeaderStyle-HorizontalAlign="Center" />
                
                        <telerik:GridBoundColumn
                            UniqueName="unit"
                            HeaderText="Unit"
                            SortExpression="unit"
                            DataField="unit"
                            HeaderStyle-Width="15%"
                            ItemStyle-HorizontalAlign="Center"
                            HeaderStyle-HorizontalAlign="Center" />
                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>
            </div>
        </div>
    </div>
    </div>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="getResourceDetails" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter Name="resourceId" QueryStringField="id" />
        </SelectParameters>
    </asp:SqlDataSource>
    
    <asp:SqlDataSource ID="allResourcesDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="getResourcesByNameAndType" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter Name="resourceName" ControlID="rtbResourceName" PropertyName="Text" />
            <asp:QueryStringParameter Name="resourceTypeId" QueryStringField="type" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

