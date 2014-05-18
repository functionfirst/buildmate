<%@ Page Language="VB" MasterPageFile="~/common/Manager.master" AutoEventWireup="false"
    CodeFile="resources.aspx.vb" Inherits="resources" Title="Catalogue - Buildmate" %>

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

    <div class="breadcrumb">
        <div class="breadcrumb-container">
            <ul class="breadcrumb-list">
                <li class="active">Resources</li>
            </ul>
        </div>
    </div>

    <div class="main-container">
    
    <asp:Panel ID="Panel1" runat="server" DefaultButton="btnApplyFilter">
        <div class="div33">
            <div class="search">
                <telerik:RadTextBox
                    ID="rtbResourceName"
                    runat="server"
                    Width="300"
                    CssClass="searchInput"
                    EmptyMessage="Search by Name, Manufacturer or Part ID"
                    AutoPostBack="true" />
            </div>
        </div>

        <div class="div33">
            <asp:RadioButtonList ID="rblResourceType" runat="server"
                RepeatDirection="Horizontal"
                DataSourceID="resourceTypesDataSource"
                DataTextField="resourceType"
                DataValueField="id"
                AutoPostBack="true" />
        </div>
        <div class="div33 div-last">
            <asp:Button ID="btnApplyFilter" runat="server" Text="Search" Visible="true" CssClass="button" />
        </div>
    </asp:Panel>

    <div class="clear"></div>
        <asp:Label ID="lblCount" runat="server" Visible="false">
            <div class="box-alert box-primary">We found more than 500 results matching your keywords, please be more specific with your search..</div>
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


<asp:Content ID="SidebarContent" ContentPlaceHolderID="Sidebar" Runat="Server">
    <h1>Resources <span>Take a Tour</span></h1>

    <div class="tour-nav" data-tour="menu">
        <ul>
            <li class="active"><a href="#" data-tab="step1">1. Introduction</a></li>
            <li><a href="#" data-tab="step2">2. Adding Resources</a></li>
        </ul>
    </div>

    <div class="tour-content">
        <div data-target="step1">
            <iframe width="640" height="480" src="//www.youtube.com/embed/lFoRphIIcmQ" frameborder="0" allowfullscreen></iframe>
        </div>
                
        <div data-target="step2" class="hide">
            <iframe width="640" height="480" src="//www.youtube.com/embed/HZVaNAClGGg" frameborder="0" allowfullscreen></iframe>
        </div>
    </div>
</asp:Content>
