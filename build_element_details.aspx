<%@ Page Title="Build Element Details - Buildmate" Language="VB" MasterPageFile="~/common/Manager.master" AutoEventWireup="false" CodeFile="build_element_details.aspx.vb" Inherits="manager_build_element_details" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy2" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlId="lbRefreshResources">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="pBuildElementDetails" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlId="pBuildElementDetails">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="pBuildElementDetails" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlId="rgCurrentTasks">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="rgCurrentTasks" />
                     <telerik:AjaxUpdatedControl ControlID="fvElementDetails" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlId="fvElementDetails">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="completionBar" />
                     <telerik:AjaxUpdatedControl ControlID="notification" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>

    <div class="breadcrumb">
        <div class="breadcrumb-container">
            <ul class="breadcrumb-options">
                <li>
                    <asp:HyperLink ID="hlAddTask" runat="server"
                            CssClass="button button-create"
                            OnLoad="hlAddTask_Load"
                            Text="Add Tasks"
                            NavigateUrl="add_task.aspx?pid={0}&rid={1}" />
                </li>
            </ul>
            <ul class="breadcrumb-list">
                <li>
                    <a href="projects.aspx">Projects</a>
                    <span class="divider">/</span>
                </li>
                <li>
                    <asp:HyperLink ID="hlBack" runat="server"
                        NavigateUrl="project_details.aspx?pid={0}"
                        Text="Project Details" />
                    <span class="divider">/</span>
                </li>
                <li class="active">
                    Build Element Details
                </li>
            </ul>
        </div>
    </div>
    
    <div class="main-container">
        <asp:Panel ID="completionBar" runat="server" CssClass="completionBar">
            <asp:Repeater ID="Repeater1" runat="server" DataSourceID="buildElementTimesDataSource">
                <ItemTemplate>
                    <span style='text-align: center; width: <%#Eval("completion", "{0:00}")%>%'></span>
                        <div><%#Eval("completion", "{0:0}")%>% complete</div>
                </ItemTemplate>
            </asp:Repeater>
        </asp:Panel>

    <div class="div33">
        <asp:Panel ID="pBuildElementDetails" runat="server" CssClass="box">

            <h3 id="readMode" runat="server">Build Element Details</h3>
             
            <h3 id="editMode" class="box_top_edit" runat="server" visible="false">Editing Build Element Details...</h3>

            <div id="successbox" class="box_update" runat="server" visible="false">
                <span>Build Element Details saved</span>
            </div>
            
            <div id="insertbox" class="box_update" runat="server" visible="false">
                <span>New Build Element saved</span>
            </div>
            
            <div id="errorbox" class="box_error" runat="server" visible="false">
                <span>The indicated fields are required</span>
            </div>
            
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" HeaderText="Error...." />
            
            <div class="boxcontent">
            <asp:FormView
                ID="fvElementDetails"
                runat="server"
                DataSourceID="elementDataSource"
                DataKeyNames="id" Width="100%">
                <EmptyDataTemplate></EmptyDataTemplate>
                <ItemTemplate>
                    <div class="row">
                        <label title="Name" class="label">Name</label>
                        <%#Eval("spaceName")%>
                    </div>
                    
                    <div class="row">
                        <label title="Type" class="label">Type</label>
                        <%#Eval("spaceType")%>
                    </div>
                
                    <div class="row">
                        <label title="Build Cost" class="label">Build Cost</label>
                        <%#Eval("buildCost", "{0:C}")%>
                    </div>
                    
                    <h4>Additional Costs</h4>
                

                    <div class="row">
                        <label for="rntbSpacePrice" title="Sundry Items" class="label">Sundry Items</label>
                        <span style="display: table-cell"><%#Eval("subcontractType")%></span>
                    </div>
                    
                    <div class="row">
                        <label for="rntbSpacePrice" title="Cost" class="label">Cost</label>
                        <%#Eval("spacePrice", "{0:C}")%>
                    </div>
                    
                    <div class="row">
                        <label title="Adjustment" class="label">Adjustment</label>
                        <%#Eval("subcontractPercent", "{0:N0}" & "%")%>
                    </div>
                    
                    <div class="row">
                        <label title="Completion" class="label">Completion</label>
                        <%#Eval("completion", "{0:N0}" & "%")%>
                    </div>
     
                    <div class="row">
                        <label class="label">&nbsp;</label>
                        <asp:Button ID="btnEdit" runat="server"
                            Enabled='<%#iif(Eval("isLocked"), "false", "true") %>'
                            CssClass="button"
                            CommandName="Edit" Text="Edit Build Element" />
                    </div>
                </ItemTemplate>
                <EditItemTemplate>
                    <div class="row">
                        <asp:Label
                            ID="Label1"
                            runat="server"   
                            CssClass="label"
                            AssociatedControlID="rtbSpaceName"
                            Text="Name*" />
                        
                        <telerik:RadTextBox
                            ID="rtbSpaceName"
                            runat="server"
                            Text='<%#Bind ("spaceName") %>'
                            Width="110px"
                            EmptyMessage="Name" />

                        <asp:RequiredFieldValidator
                            ID="RequiredFieldValidator1"
                            runat="server"
                            ControlToValidate="rtbSpaceName"
                            ValidationGroup="editValidation"
                            Display="Dynamic"
                            ErrorMessage="Element Name">
                            <span class="req"></span>
                        </asp:RequiredFieldValidator>                     
                    </div>
                    
                    <div class="row">
                        <asp:Label
                            ID="Label2"
                            runat="server"   
                            CssClass="label"
                            AssociatedControlID="rtbSpaceType"
                            Text="Type" />

                        <telerik:RadComboBox ID="rtbSpaceType" runat="server"
                            SelectedValue='<%# Bind("buildElementTypeId") %>'
                            DataSourceID="spaceTypeDataSource"
                            DataTextField="spaceType"
                            DataValueField="buildElementTypeId" />
                    </div>
                    
                    <div class="row">
                        <asp:Label ID="labelBuildCost" runat="server"   
                            CssClass="label"
                            Text="Build Cost"
                            AssociatedControlID="lblBuildCost" />

                        <asp:Label ID="lblBuildCost" runat="server"
                            Text='<%#Eval("buildCost", "{0:C}")%>' />
                    </div>

                    <h4>Additional Costs</h4>
                    
                    <div class="row">
                        <label for="rcbSubcontractType" title="Sundry Items" class="label">Sundry Items</label>
                        <telerik:RadComboBox ID="rcbSubcontractType" runat="server"
                            width="110px" SelectedValue='<%# Bind("subcontractTypeId")%>'
                            DataSourceID="subcontractTypesDataSource" DataTextField="subcontractType" DataValueField="id" />
                    </div>
                    
                    <div class="row">
                        <label for="rntbSpacePrice" title="Cost" class="label">Cost</label>
                        <telerik:RadNumericTextBox ID="rntbSpacePrice" runat="server"
                            DBValue='<%# Bind("spacePrice") %>' Type="Currency"
                            NumberFormat-DecimalDigits="2" Width="110px" EmptyMessage="£ (GBP)" />
                    </div>
                    
                    <div class="row">
                        <label for="rntbSubcontractPercent" title="Adjustment" class="label">Adjustment</label>
                        <telerik:RadNumericTextBox ID="rntbSubcontractPercent" runat="server"
                            Width="80px" ShowSpinButtons="true" DBValue='<%#Bind("subcontractPercent") %>'
                            MinValue="0" MaxValue="100" Type="Percent" NumberFormat-DecimalDigits="0" />
                    </div>
                    
                    <div class="row">
                        <label for="rntbSubcontractPercent" title="Completion" class="label">Completion</label>
                        <telerik:RadNumericTextBox ID="rntbCompletion" runat="server"
                            Width="80px" ShowSpinButtons="true" DBValue='<%#Bind("completion") %>'
                            MinValue="0" MaxValue="100" Type="Percent" NumberFormat-DecimalDigits="0" />
                    </div>
            
                    <div class="row">
                        <label for="btns" class="label">&nbsp;</label>
                        <asp:Button ID="btnUpdate" runat="server"
                            CssClass="button button-create"
                            CommandName="Update" OnClick="validate"
                            ValidationGroup="editValidation" Text="Update" />
                        
                        <asp:LinkButton ID="btnCancel" runat="server"
                            CssClass="button"
                            CommandName="Cancel" Text="Cancel" />
                    </div>

                </EditItemTemplate>
            </asp:FormView>
        </div>
    </asp:Panel>
    </div>
    
    <div class="div66 div-last">
        <asp:Panel ID="pLimitedTasks" runat="server" CssClass="box_info" Visible="false">
            <h3>Limited Subscription</h3>

            <div class="boxcontent">
                <ul>
                   <li>
                    <a href="settings.aspx">Update your subscription</a> to get instant access
                    to Tasks &amp; Resources.
                    </li>
                </ul>
                
                <h4>What does this mean?</h4>
                
                <p>
                    You are currently subscribed to use Buildmate's free customer database.
                </p>

                <ol>
                    <li>
                        This allows you to store your customer information together with all
                        verbal or lump sum projects created for the individual customers.
                        
                        <ol style="list-style: lower-alpha">
                            <li>
                                You also have access to all other aspects of the application
                                including letters and reports, with the exception of creating
                                detailed projects using tasks and resources.
                            </li>
                        </ol>
                    </li>
                    <li>
                        You will need to subscribe to the application in order to access Tasks
                        and Resources to create detailed estimates quotations and tenders.
                        <ol style="list-style: lower-alpha">
                            <li>
                                To subscribe you will need to access your account and select subscribe.
                            </li>
                        </ol>
                    </li>
                </ol>
            </div>
        </asp:Panel>
        
        <asp:Panel ID="pTasks" runat="server" CssClass="box">
            <h3>Current Tasks</h3>

            <div class="boxcontent">
                <telerik:RadGrid ID="rgCurrentTasks" runat="server"
                    CssClass="clear"
                    AutoGenerateColumns="False"
                    AllowSorting="True"
                    AllowAutomaticDeletes="True"
                    AllowAutomaticUpdates="True"
                    AllowAutomaticInserts="True"
                    DataSourceID="currentTasksDataSource"
                    GridLines="None">
                    <MasterTableView
                        AutoGenerateColumns="false"
                        DataKeyNames="id"
                        NoMasterRecordsText="&nbsp;No Current Tasks found"
                        DataSourceID="currentTasksDataSource"
                        GroupsDefaultExpanded="true">
                        <GroupByExpressions>
                            <telerik:GridGroupByExpression>
                                <GroupByFields>
                                    <telerik:GridGroupByField FieldName="groupName" SortOrder="Descending" />
                                </GroupByFields>
                                    <SelectFields>
                                        <telerik:GridGroupByField FieldName="groupName" FieldAlias="Phase" />
                                    </SelectFields>
                            </telerik:GridGroupByExpression>
                        </GroupByExpressions>
                        <RowIndicatorColumn>
                            <HeaderStyle Width="20px" />
                        </RowIndicatorColumn>
                        <ExpandCollapseColumn>
                            <HeaderStyle Width="20px" />
                        </ExpandCollapseColumn>
                        <Columns>
                            
                            <telerik:GridHyperLinkColumn 
                                UniqueName="taskName"
                                HeaderText="Task Name"
                                SortExpression="taskName"
                                DataNavigateUrlFields="pid, rid, id"
                                DataTextField="taskName"
                                DataNavigateUrlFormatString="task_details.aspx?pid={0}&rid={1}&tid={2}"
                                headerstyle-width="80%" />
                                    
                            <telerik:GridBoundColumn
                                DataField="qty"
                                DataType="System.Double" 
                                HeaderText="qty"
                                ReadOnly="True"
                                SortExpression="qty"
                                UniqueName="qty" />
                                    
                            <telerik:GridButtonColumn
                                ConfirmText="Delete this Task?"
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
        </asp:Panel>
    </div>

    
    <asp:Panel ID="panelIsLocked" runat="server" Visible="false">
        <style>
        .variationMode{ display: block; }
        </style>
    </asp:Panel>

    </div>

    <asp:SqlDataSource ID="elementDataSource" runat="server"
        ConflictDetection="OverwriteChanges" OldValuesParameterFormatString="original_{0}"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        UpdateCommand="updateBuildElement" UpdateCommandType="StoredProcedure"
        SelectCommand="getBuildElementDetails"  SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter Name="projectId" QueryStringField="pid" />
            <asp:QueryStringParameter Name="buildElementId" QueryStringField="rid" />
            <asp:SessionParameter Name="UserId" SessionField="UserId" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="original_id" Type="Int64" />
            <asp:Parameter Name="spacePrice" DefaultValue="0" />
            <asp:Parameter Name="subcontractPercent" DefaultValue="0" />
        </UpdateParameters>
    </asp:SqlDataSource>
    
    <asp:SqlDataSource ID="spaceTypeDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="getBuildElementStatuses" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter Name="roomId" QueryStringField="rid" />
        </SelectParameters>
    </asp:SqlDataSource>
     
    <asp:SqlDataSource ID="subcontractTypesDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="getBuildElementSundryItems" SelectCommandType="StoredProcedure">
    </asp:SqlDataSource>
    
    <asp:SqlDataSource ID="currentTasksDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        DeleteCommand="deleteTask" DeleteCommandType="StoredProcedure"
        SelectCommand="getCurrentTaskDataByBuildElement" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter Name="roomid" QueryStringField="rid" />
        </SelectParameters>
        <DeleteParameters>
            <asp:SessionParameter Name="userId" SessionField="userId" />
            <asp:QueryStringParameter Name="projectId" QueryStringField="pid" />
            <asp:Parameter Name="id" Type="Int64" />
        </DeleteParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="buildElementTimesDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>" 
        SelectCommand="getBuildElementCompletion" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="UserId" SessionField="UserId" />
            <asp:QueryStringParameter Name="roomId" QueryStringField="rid" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>