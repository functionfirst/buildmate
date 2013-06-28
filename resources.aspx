<%@ Page Language="VB" MasterPageFile="~/common/Manager.master" AutoEventWireup="false"
    CodeFile="resources.aspx.vb" Inherits="resources" Title="Catalogue - BuildMate" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="head" ContentPlaceHolderID="head" runat="Server">
</asp:Content>

<asp:Content ID="Content" ContentPlaceHolderID="MainContent" runat="Server">

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
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlId="btnApplyFilter">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="rgResources" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    
    <div class="box clear">
        <h3>Resources</h3>

        <div class="boxcontent">

    <asp:Panel ID="Panel1" runat="server" DefaultButton="btnApplyFilter">

        <div class="div50">
            <div class="search">
            <telerik:RadTextBox
                ID="rtbResourceName"
                runat="server"
                Width="220"
                CssClass="searchInput"
                EmptyMessage="Search by Name, Manufacturer or Part Id"
                AutoPostBack="true" />
            </div>
            </div>

            <div class="div50r">
            <asp:RadioButtonList ID="rblResourceType" runat="server"
                RepeatDirection="Horizontal"
                DataSourceID="resourceTypesDataSource"
                DataTextField="resourceType"
                DataValueField="id"
                AutoPostBack="true" />
            </div>

            <asp:Button ID="btnApplyFilter" runat="server" Text="Search" Visible="false" />
    </asp:Panel>

    <div class="clear"></div>
        <asp:Label ID="lblCount" runat="server" Visible="false">
            <div class="successBox">Your search returned more than 1,000 results, please be more specific with your search</div>
        </asp:Label>

        <telerik:RadGrid
            ID="rgResources"
            runat="server"
            DataSourceID="allResourcesDataSource"
            AllowPaging="true"
            PageSize="20"
            PagerStyle-Mode="NextPrev"
            ShowGroupPanel="false"
            AllowSorting="true"
            GridLines="None"
            ShowStatusBar="true">
            <MasterTableView
                AutoGenerateColumns="False"
                DataSourceID="allResourcesDataSource"
                DataKeyNames="id"
                NoMasterRecordsText="&nbsp;No Resources were found.">
                <Columns>
                    <telerik:GridHyperLinkColumn
                        UniqueName="resourceName"
                        HeaderText="Resource Name"
                        SortExpression="resourceName"
                        DataNavigateUrlFields="id"
                        DataNavigateUrlFormatString="~/resource_details.aspx?rid={0}"
                        DataTextField="resourceName" />
                        
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

    <asp:SqlDataSource ID="allResourcesDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="getResourcesByNameAndType" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter Name="resourceName" ControlID="rtbResourceName" PropertyName="Text" />
            <asp:ControlParameter Name="resourceTypeId" ControlID="rblResourceType" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource
        ID="resourceTypesDataSource"
        runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="getResourceTypes" SelectCommandType="StoredProcedure" />
    
</asp:Content>
