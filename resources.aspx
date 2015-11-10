﻿<%@ Page Language="VB" MasterPageFile="~/common/Manager.master" AutoEventWireup="false"
    CodeFile="resources.aspx.vb" Inherits="resources" Title="Catalogue - Buildmate" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="head" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {
            $('.tab-nav').find('a').click(function () {
                var target = $(this).attr('href');
                showTab(target);
                return false;
            });

            if (window.location.hash === '#search') {
                $('#searchTabLink').click();
            }
        });

        function showTab(tabId) {
            $(tabId).addClass('tab-container-active').siblings().removeClass('tab-container-active');
            $('a[href="' + tabId + '"]').parent().addClass('active').siblings().removeClass('active');
        }
    </script>
</asp:Content>

<asp:Content ID="Content" ContentPlaceHolderID="MainContent" runat="Server">

    <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlId="Panel1">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="Panel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlId="rgUnresourced">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="rgUnresourced" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlId="rgYourResources">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="rgYourResources" />
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

        <div class="tabs">
            <ul class="tab-nav">
                <li class="active"><a href="#unresourced" id="unresourcedTabLink">Unresourced</a></li>
                <li><a href="#your" id="yourTabLink">Your Resources</a></li>
                <li><a href="#search" id="searchTabLink">Search all Resources</a></li>
            </ul>
            
            <div class="tab-container tab-container-active" id="unresourced">
                <div class="div66">

                <telerik:RadGrid
                    ID="rgUnresourced"
                    runat="server"
                    DataSourceID="unresourcedDataSource"
                    AllowPaging="true"
                    PageSize="20"
                    PagerStyle-Mode="NextPrev"
                    ShowGroupPanel="false"
                    AllowSorting="true"
                    GridLines="None"
                    ShowStatusBar="true">
                    <MasterTableView
                        AutoGenerateColumns="False"
                        DataSourceID="unresourcedDataSource"
                        DataKeyNames="id"
                        NoMasterRecordsText="&nbsp;No resources are currently Unresourced.">
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
                <div class="div33 div-last">
                    <div class="box-alert box-primary">
                        <h3>These resources are using Out of Date prices</h3>

                        <p>
                            This is a list of all of your Resources that are using Buildmate's Unresourced supplier, these prices may be out of date.
                        </p>
                        <p>
                            You will need to add Suppliers to these unresourced Resources to ensure these prices are up to date.
                        </p>
                    </div>
                </div>
            </div>

            <div class="tab-container" id="your">
                <div class="div66">

                <telerik:RadGrid
                    ID="rgYourResources"
                    runat="server"
                    DataSourceID="yourResourcesDataSource"
                    AllowPaging="true"
                    PageSize="20"
                    PagerStyle-Mode="NextPrev"
                    ShowGroupPanel="false"
                    AllowSorting="true"
                    GridLines="None"
                    ShowStatusBar="true">
                    <MasterTableView
                        AutoGenerateColumns="False"
                        DataSourceID="yourResourcesDataSource"
                        DataKeyNames="id"
                        NoMasterRecordsText="&nbsp;You don't currently have any Resources in your Projects.">
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
                <div class="div33 div-last">
                    <div class="box-alert box-primary">
                        <h3>Your Resources</h3>

                        <p>
                            This page lists every Resource you have used across all of your Projects.
                            This provides a convenient way for you to update pricing information for Resources you know you are using.
                        </p>
                    </div>
                </div>
            </div>


            <div class="tab-container" id="search">
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
                        <telerik:RadComboBox
                            ID="rcbResourceType"
                            runat="server"
                            DataSourceID="resourceTypesDataSource"
                            DataTextField="resourceType"
                            AutoPostBack="true"
                            DataValueField="id" />
                    </div>
                    <div class="div33 div-last">
                        <asp:Button ID="btnApplyFilter" runat="server" Text="Search" Visible="true" CssClass="button" />
                    </div>

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
            
                </asp:Panel>
            </div>
        </div>
    </div>

    <asp:SqlDataSource ID="allResourcesDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="getResourcesByNameAndType" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter Name="resourceName" ControlID="rtbResourceName" PropertyName="Text" />
            <asp:ControlParameter Name="resourceTypeId" ControlID="rcbResourceType" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    
    <asp:SqlDataSource ID="unresourcedDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="getUnresourced" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="UserId" SessionField="UserId" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="yourResourcesDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="getYourResources" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="UserId" SessionField="UserId" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource
        ID="resourceTypesDataSource"
        runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="getResourceTypes" SelectCommandType="StoredProcedure" />
</asp:Content>