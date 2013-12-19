<%@ Page Language="VB" MasterPageFile="~/common/Manager.master" AutoEventWireup="false" CodeFile="projects.aspx.vb" Inherits="manager_Default" title="Projects - Buildmate" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="head" ContentPlaceHolderID="head" Runat="Server"></asp:Content>

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
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlId="btnRemoveFilter">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="rgProjects" />
                     <telerik:AjaxUpdatedControl ControlID="pSearchProjects" />
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
                    <a href="add_project.aspx" class="button button-create">New Project</a>
                </li>
            </ul>

            <ul class="breadcrumb-list">
                <li class="active">Projects</li>
            </ul>
        </div>
    </div>

    <div class="main-container">

        <div id="lblDeleted" runat="server" class="errorBox" visible="false">
            <b>Project Deleted</b><br />
            The project was deleted successfully.
        </div>

    
        <asp:Panel ID="noCustomerPanel" runat="server" visible="true" CssClass="help-panel">
            <h3>1. Before you begin you'll need to create your first Customer which you can assign a Project to.</h3>
            <p>
                Click the button below to create your first Customer.<br />
                <small>Note, anytime you see a green button like this you'll be able to Add or Update something on the page.</small>
            </p>
            <p>
                <a href="add_customer.aspx" class="button button-create">New Customer</a>
            </p>
        </asp:Panel>

        <asp:Panel ID="noProjectPanel" runat="server" Visible="false" CssClass="help-panel">
            <h3>2. You've created your first Customer so lets move on and create a Project for them.</h3>
        
            <p>Click the button below to create your first Project.</p>
        
            <p><a href="add_project.aspx" class="button button-create">New Project</a></p>
        </asp:Panel>

        <asp:Panel ID="projectPanel" runat="server">

                <asp:Panel ID="pSearchProjects" runat="server" DefaultButton="btnApplyFilter">
                    <div id="advSearch" class="search">
                        <a href="#" class="toggleSearch"><span></span></a>
             
                        <telerik:RadTextBox
                            ID="rtbKeywords"
                            runat="server"
                            CssClass="searchInput"
                            EmptyMessage="Search by project name or description"
                            Width="220px" />

                            <asp:LinkButton
                                ID="btnRemoveFilter"
                                runat="server"
                                Text="clear" />
                                                                                                                                                                                               
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
                                <asp:CheckBox ID="cbArchived" runat="server" Text="Include archived projects" />
                            </div>

                            <div class="row">
                                <asp:Button ID="btnApplyFilter" runat="server" Text="Apply Filters"  />
                            </div>
                        </div>
                    </div>
                </asp:Panel>



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
                    NoMasterRecordsText="&nbsp;No Projects were found.">
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
    
        </asp:Panel>
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
        ID="projectTypeDataSource"
        runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>" 
        SelectCommand="getProjectType"
        SelectCommandType="StoredProcedure">
    </asp:SqlDataSource>
 </asp:Content>