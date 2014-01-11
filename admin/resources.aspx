<%@ Page Title="Manage System Resources - Admin" Language="VB" MasterPageFile="~/common/admin.master" AutoEventWireup="false" CodeFile="resources.aspx.vb" Inherits="edit_resource" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">

   <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlId="Panel1">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="Panel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>

    <div class="breadcrumb">
        <div class="breadcrumb-container">
            Manage System Resources
        </div>
    </div>

    <div class="container">
        <asp:Panel ID="Panel1" runat="server" DefaultButton="btnApplyFilter">
            <div class="sidebar">
                <fieldset>
                    <legend title="Search Resources">Search Catalogue</legend>
                
                    <div class="row">
                        <asp:Label ID="Label1" runat="server"
                            AssociatedControlID="rcbResourceType"
                            CssClass="label"
                            Text="Resource Type" />

                        <telerik:RadComboBox ID="rcbResourceType" runat="server" AutoPostBack="true">
                            <Items>
                                <telerik:RadComboBoxItem Text="Labour" Value="1" Selected="true" />
                                <telerik:RadComboBoxItem Text="Material" Value="2" />
                                <telerik:RadComboBoxItem Text="Plant &amp; Equipment" Value="3" />
                            </Items>
                        </telerik:RadComboBox>
                    </div>
                
                    <div class="row">
                        <asp:Label ID="Label2" runat="server"
                            AssociatedControlID="rtbResourceName"
                            CssClass="label"
                            Text="Keywords" />

                        <telerik:RadTextBox
                            ID="rtbResourceName"
                            runat="server"
                            Width="180"
                            EmptyMessage="contains any word(s)"
                            AutoPostBack="true" />
                    </div>

                    <div class="row">
                        <asp:Button ID="btnApplyFilter" runat="server" Text="Search" />
                    </div>
                </fieldset>
        
                <asp:HyperLink ID="hlAddCatalogue" runat="server"
                    CssClass="AddItem fullAddItem"
                    NavigateUrl="~/admin/add_resource.aspx">
                    <span></span>Add a Resource
                </asp:HyperLink>
            </div>


            <div class="maincontent">
                <asp:Label ID="lblCount" runat="server" Visible="false">
                    <div class="successBox">Your search returned more than 1,000 results, please be more specific with your search</div>
                </asp:Label>

                <telerik:RadGrid ID="rgResources" runat="server" 
                    DataSourceID="allResourceDataSource"
                    AllowSorting="true"
                    GridLines="None"
                    AllowAutomaticDeletes="True"
                    ShowStatusBar="true"
                    AllowPaging="true"
                    PageSize="20">
                    <MasterTableView
                        AutoGenerateColumns="False"
                        NoMasterRecordsText="&nbsp; No resources were found matching your criteria."
                        DataSourceID="allResourceDataSource"
                        AllowSorting="true"
                        DataKeyNames="id">
                        <Columns>
                            <telerik:GridHyperLinkColumn
                                UniqueName="Resource"
                                HeaderText="Resource"
                                DataNavigateUrlFields="id"
                                HeaderStyle-Width="50%"
                                SortExpression="ResourceName"
                                DataNavigateUrlFormatString="edit_resource.aspx?rid={0}"
                                DataTextField="resourceName"
                                DataTextFormatString="{0}" />

                             <telerik:GridBoundColumn
                                UniqueName="manufacturer"
                                HeaderText="Manufacturer"
                                DataField="manufacturer"
                                HeaderStyle-width="15%"
                                HeaderStyle-HorizontalAlign="Center"
                                ItemStyle-HorizontalAlign="Center"
                                SortExpression="manufacturer" />
                            
                             <telerik:GridBoundColumn
                                UniqueName="partId"
                                HeaderText="Part Id"
                                DataField="partId"
                                HeaderStyle-width="15%"
                                HeaderStyle-HorizontalAlign="Center"
                                ItemStyle-HorizontalAlign="Center"
                                SortExpression="partId" />
                            
                             <telerik:GridBoundColumn
                                UniqueName="category"
                                HeaderText="Category"
                                DataField="categoryName"
                                HeaderStyle-width="15%"
                                HeaderStyle-HorizontalAlign="Center"
                                ItemStyle-HorizontalAlign="Center"
                                SortExpression="categoryName" />
                        
                            <telerik:GridBoundColumn
                                UniqueName="unit"
                                HeaderText="Unit"
                                DataField="Unit"
                                HeaderStyle-width="10%"
                                HeaderStyle-HorizontalAlign="Center"
                                ItemStyle-HorizontalAlign="Center"
                                SortExpression="unit" />
     
                            <telerik:GridButtonColumn
                                ConfirmText="Delete this Resource?"
                                ConfirmTitle="Delete"
                                ButtonType="ImageButton"
                                CommandName="Delete"
                                CommandArgument="id"
                                Text="Delete"
                                UniqueName="DeleteColumn" />
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </div>


        <asp:SqlDataSource ID="allResourceDataSource" runat="server"
            ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
            DeleteCommand="DELETE FROM Catalogue WHERE resourceId = @id; DELETE FROM Resource WHERE id = @id"
            SelectCommand="getResourcesByNameAndType" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter Name="resourceName" ControlID="rtbResourceName" PropertyName="Text" />
                <asp:ControlParameter Name="resourceTypeId" ControlID="rcbResourceType" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
        </asp:Panel>
    </div>
</asp:Content>