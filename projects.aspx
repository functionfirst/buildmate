<%@ Page Language="VB" MasterPageFile="~/common/Manager.master" AutoEventWireup="false" CodeFile="projects.aspx.vb" Inherits="manager_Default" title="Projects - Buildmate" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="head" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {
            $('.tab-nav').find('a').click(function () {
                var target = $(this).attr('href');
                showTab(target);
                return false;
            });

            if (window.location.hash === '#archived') {
                $('#archiveTabLink').click();
            }
        });

        function showTab(tabId) {
            $(tabId).addClass('tab-container-active').siblings().removeClass('tab-container-active');
            $('a[href="' + tabId + '"]').parent().addClass('active').siblings().removeClass('active');
        }
    </script>
</asp:Content>

<asp:Content ID="Content" ContentPlaceHolderID="MainContent" Runat="Server">

    <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlId="pSearchProjects">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="pSearchProjects" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlId="btnApplyFilter">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgProjects" />
                     <telerik:AjaxUpdatedControl ControlID="rgArchived" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlId="btnRemoveFilter">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="rgProjects" />
                     <telerik:AjaxUpdatedControl ControlID="rgArchived" />
                     <telerik:AjaxUpdatedControl ControlID="pSearchProjects" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlId="rgProjects">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="rgProjects" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlId="rgArchived">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="rgArchived" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    
    <script type="text/javascript"> 
    function PopupAbove(e, pickerID) { 
        var datePicker = $find(pickerID); 
        var textBox = datePicker.get_textBox(); 
        var popupElement = datePicker.get_popupContainer();     
        var dimensions = datePicker.getElementDimensions(popupElement); 
        var position = datePicker.getElementPosition(textBox);     
        datePicker.showPopup(position.x, position.y - dimensions.height);     
    }
    </script>

    <div class="breadcrumb">
        <div class="breadcrumb-container">
            <ul class="breadcrumb-options">
                <li>
                    <a href="add_project.aspx" class="button button-create" data-step="1" data-intro="Click to create your project" data-position="left">New Project</a>
                </li>
            </ul>

            <ul class="breadcrumb-list">
                <li class="active">Projects</li>
            </ul>
        </div>
    </div>

    <div class="main-container">
        <asp:Panel ID="pSearchProjects" runat="server" DefaultButton="btnApplyFilter" CssClass="search-box">
  
        <telerik:RadTextBox
            ID="rtbKeywords"
            runat="server"
            data-step="3"
            data-intro="Search your active projects"
            CssClass="searchInput"
            EmptyMessage="Search by project name or description"
            Width="310px" />
                
        <a href="#advSearch" class="toggleSearch" data-step="4" data-intro="Advanced search options"><span></span></a>
            <asp:LinkButton
                ID="btnRemoveFilter"
                runat="server"
                Text="clear" />

          <div id="advSearch" class="advanced-search">
                    <div class="panel">
                        <div class="row">
                            <asp:Label ID="Label2" CssClass="label" runat="server" AssociatedControlID="rcbStatus" Text="Project Status" />
                            <telerik:RadComboBox
                                ID="rcbStatus"
                                runat="server"
                                DataSourceID="statusDataSource"
                                DataTextField="status"
                                DataValueField="id" />
                        </div>

                    <div class="row">

                        <asp:Label ID="Label3" CssClass="label" runat="server" AssociatedControlID="rcbProjectType" Text="Project Type" />
                        <telerik:RadComboBox
                            ID="rcbProjectType"
                            runat="server"
                            DataSourceID="projectTypeDataSource"
                            DataTextField="projectType"
                            DataValueField="id" />
                        </div>

                    <div class="row">
                        <asp:Label ID="Label4" CssClass="label" runat="server" AssociatedControlID="rdpStartDate" Text="Start Date" />

                        <telerik:RadDatePicker ID="rdpStartDate" runat="server"
                            Calendar-ShowRowHeaders="false"
                            Width="100px" Calendar-FastNavigationStep="12" />
                    </div>

                    <div class="row">
                        <asp:Label ID="Label5" CssClass="label" runat="server" AssociatedControlID="rdpEndDate" Text="Finish Date" />

                        <telerik:RadDatePicker ID="rdpEndDate" runat="server" 
                            Calendar-ShowRowHeaders="false"
                            Width="100px" Calendar-FastNavigationStep="12" />
                    </div>

                    <div class="row">
                        <asp:Button ID="btnApplyFilter" runat="server" Text="Apply Filters" CssClass="button button-primary"  />
                    </div>
                </div>
            </div>
        </asp:Panel>


         <div class="tabs">
            <ul class="tab-nav">
                <li class="active" data-step="1" data-intro="View a list of your active projects"><a href="#currentProjects" id="currentTabLink">Current Projects</a></li>
                <li data-step="2" data-intro="View a list of your archived projects"><a href="#archived" id="archiveTabLink">Archived</a></li>
            </ul>
            
            <div class="tab-container tab-container-active" id="currentProjects">
                <telerik:RadGrid
                    ID="rgProjects"
                    runat="server"
                    DataSourceID="projectsDataSource"
                    AllowPaging="true"
                    PageSize="20"
                    PagerStyle-Mode="NextPrev"
                    ShowGroupPanel="false"
                    AllowSorting="false"
                    GridLines="None"
                    ShowStatusBar="true">
                    <MasterTableView
                        DataSourceID="projectsDataSource"
                        AutoGenerateColumns="False"
                        NoMasterRecordsText="&nbsp;You have not added a Project yet.">
                        <GroupByExpressions>
                            <telerik:GridGroupByExpression>
                                <GroupByFields>
                                    <telerik:GridGroupByField FieldName="projectStatusId" SortOrder="Descending" />
                                </GroupByFields>
                                <SelectFields>
                                    <telerik:GridGroupByField FieldName="status" FieldAlias="Status" />
                                </SelectFields>
                            </telerik:GridGroupByExpression>
                        </GroupByExpressions>
                        <Columns>
                            <telerik:GridHyperLinkColumn UniqueName="projectName"
                                HeaderText="Project Name"
                                DataNavigateUrlFormatString="~/project_details.aspx?pid={0}"
                                DataNavigateUrlFields="id"
                                DataTextField="projectName"
                                SortExpression="projectName"
                                HeaderStyle-Width="35%" />

                            <telerik:GridBoundColumn
                                DataField="projectType"
                                HeaderText="Type"
                                UniqueName="projecType"
                                HeaderStyle-HorizontalAlign="Center"
                                ItemStyle-HorizontalAlign="Center"
                                SortExpression="projectType"
                                HeaderStyle-Width="35%" />

                            <telerik:GridBoundColumn
                                DataField="returnDate"
                                DataFormatString="{0:d}"
                                HeaderStyle-HorizontalAlign="Center"
                                ItemStyle-HorizontalAlign="Center"
                                HeaderStyle-Width="10%"
                                HeaderText="Return Date"
                                UniqueName="returnDate"
                                SortExpression="returnDate" />

                            <telerik:GridBoundColumn
                                DataField="startDate"
                                DataFormatString="{0:d}"
                                HeaderStyle-HorizontalAlign="Center"
                                ItemStyle-HorizontalAlign="Center"
                                HeaderStyle-Width="10%"
                                HeaderText="Start Date"
                                UniqueName="startDate"
                                SortExpression="startDate" />

                            <telerik:GridBoundColumn
                                DataField="completionDate"
                                DataFormatString="{0:d}"
                                HeaderStyle-HorizontalAlign="Center"
                                ItemStyle-HorizontalAlign="Center"
                                HeaderStyle-Width="10%"
                                HeaderText="Finish Date"
                                UniqueName="completionDate"
                                SortExpression="completionDate" />
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </div>

            <div class="tab-container" id="archived">
                <telerik:RadGrid
                    ID="rgArchived"
                    runat="server"
                    DataSourceID="ArchivedProjects"
                    AllowPaging="true"
                    PageSize="20"
                    PagerStyle-Mode="NextPrev"
                    ShowGroupPanel="false"
                    AllowSorting="false"
                    GridLines="None"
                    ShowStatusBar="true">
                    <MasterTableView
                        DataSourceID="ArchivedProjects"
                        AutoGenerateColumns="False"
                        NoMasterRecordsText="&nbsp;You have not added a Project yet.">
                        <GroupByExpressions>
                            <telerik:GridGroupByExpression>
                                <GroupByFields>
                                    <telerik:GridGroupByField FieldName="projectStatusId" SortOrder="Descending" />
                                </GroupByFields>
                                <SelectFields>
                                    <telerik:GridGroupByField FieldName="status" FieldAlias="Status" />
                                </SelectFields>
                            </telerik:GridGroupByExpression>
                        </GroupByExpressions>
                        <Columns>
                            <telerik:GridHyperLinkColumn UniqueName="projectName"
                                HeaderText="Project Name"
                                DataNavigateUrlFormatString="~/project_details.aspx?pid={0}"
                                DataNavigateUrlFields="id"
                                DataTextField="projectName"
                                SortExpression="projectName"
                                HeaderStyle-Width="35%" />

                            <telerik:GridBoundColumn
                                DataField="projectType"
                                HeaderText="Type"
                                UniqueName="projecType"
                                HeaderStyle-HorizontalAlign="Center"
                                ItemStyle-HorizontalAlign="Center"
                                SortExpression="projectType"
                                HeaderStyle-Width="35%" />

                            <telerik:GridBoundColumn
                                DataField="returnDate"
                                DataFormatString="{0:d}"
                                HeaderStyle-HorizontalAlign="Center"
                                ItemStyle-HorizontalAlign="Center"
                                HeaderStyle-Width="10%"
                                HeaderText="Return Date"
                                UniqueName="returnDate"
                                SortExpression="returnDate" />

                            <telerik:GridBoundColumn
                                DataField="startDate"
                                DataFormatString="{0:d}"
                                HeaderStyle-HorizontalAlign="Center"
                                ItemStyle-HorizontalAlign="Center"
                                HeaderStyle-Width="10%"
                                HeaderText="Start Date"
                                UniqueName="startDate"
                                SortExpression="startDate" />

                            <telerik:GridBoundColumn
                                DataField="completionDate"
                                DataFormatString="{0:d}"
                                HeaderStyle-HorizontalAlign="Center"
                                ItemStyle-HorizontalAlign="Center"
                                HeaderStyle-Width="10%"
                                HeaderText="Finish Date"
                                UniqueName="completionDate"
                                SortExpression="completionDate" />
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </div>
        </div>




        <div class="clear"></div>
    </div>


    <asp:SqlDataSource
        ID="statusDataSource"
        runat="server" 
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>" 
        SelectCommand="getProjectStatus" SelectCommandType="StoredProcedure">
    </asp:SqlDataSource>

    <asp:SqlDataSource
        ID="projectsDataSource"
        runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        FilterExpression="archived = 0"
        SelectCommand="getProjects"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="UserId" SessionField="UserId" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource
        ID="ArchivedProjects"
        runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        FilterExpression="archived = 1"
        SelectCommand="getProjects"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="UserId" SessionField="UserId" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource
        ID="projectTypeDataSource"
        runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>" 
        SelectCommand="getProjectType"
        SelectCommandType="StoredProcedure">
    </asp:SqlDataSource>
 </asp:Content>

<asp:Content ID="SidebarContent" ContentPlaceHolderID="Sidebar" Runat="Server">
<h1>Projects <span>Take a Tour</span></h1>

<div class="tour-nav" data-tour="menu">
    <ul>
        <li class="active"><a href="#" data-tab="step1">1. Introduction</a></li>
        <li><a href="#" data-tab="step2">2. Creating Projects</a></li>
        <li><a href="#" data-tab="step3">3. Build Elements</a></li>
        <li><a href="#" data-tab="step4">4. Tasks</a></li>
    </ul>
</div>

<div class="tour-content">
    <div data-target="step1">
        <iframe width="640" height="480" src="//www.youtube.com/embed/oB15uiihBO4" frameborder="0" allowfullscreen></iframe>
    </div>
                
    <div data-target="step2" class="hide">
        <iframe width="640" height="480" src="//www.youtube.com/embed/vR0tY0_HuhE" frameborder="0" allowfullscreen></iframe>
    </div>
                
    <div data-target="step3" class="hide">
        <iframe width="640" height="480" src="//www.youtube.com/embed/V40sfqKKmEU" frameborder="0" allowfullscreen></iframe>
    </div>
                
    <div data-target="step4" class="hide">
        <iframe width="640" height="480" src="//www.youtube.com/embed/w7qJyXVeSBA" frameborder="0" allowfullscreen></iframe>
    </div>
</div>
</asp:Content>