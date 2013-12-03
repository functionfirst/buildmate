<%@ Page Title="Edit Task - Admin" Language="VB" MasterPageFile="~/common/admin.master" AutoEventWireup="false" CodeFile="edit_task.aspx.vb" Inherits="edit_task" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">


    <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlId="fvTaskDetails">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="fvTaskDetails" />
                     <telerik:AjaxUpdatedControl ControlID="fvTaskName" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlId="rgChildren">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="rgChildren" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>

    <p class="breadcrumb">
        <a href="tasks.aspx">Task Manager</a> &raquo;
        Task Details
    </p>

    <div class="div66">
        <div class="box">
            <h3>Task Name</h3>
            
            <div class="boxcontent">
                <asp:FormView ID="fvTaskName" runat="server"
                    Width="100%"
                    DataSourceID="taskNameDataSource">
                    <ItemTemplate>
                        <div class="row">
                            <label title="Name" class="label">Parent Task</label>
                            <div style="display: block; margin-left: 110px">
                                <asp:HyperLink ID="link1" runat="server"
                                    Text='<%#Eval("taskName")%>'
                                    NavigateUrl='<%# String.Format("~/admin/edit_task.aspx?tid={0}", Eval("parentId")) %>'></asp:HyperLink>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:FormView>
            
            
                <asp:FormView ID="fvTaskDetails" runat="server"
                    Width="100%"
                    DataKeyNames="id"
                    DataSourceID="TaskDetailsDataSource">
                    <ItemTemplate>
                        <div class="row">
                            <label title="Name" class="label">Name</label>
                            <%#Eval("taskName")%>
                        </div>

                        <div class="row">
                            <label title="Keywords" class="label">Keywords</label>
                            <%#Eval("keywords")%>
                        </div>

                        <div class="row">
                            <label title="Build Phase" class="label">Build Phase</label>
                            <%#Eval("buildPhase")%>
                        </div>
                        
                        <div class="row">
                            <label title="Unit" class="label">Unit</label>
                            <%#Eval("unit")%>
                        </div>
                        
                        <div class="row">
                            <label title="Minutes" class="label">Minutes</label>
                            <%#Eval("minutes")%> minutes
                        </div>
                        
                        <div class="row">
                            <label title="Minutes" class="label">Hidden</label>
                            <%#Eval("hidden")%>
                        </div>
                        
                        <div class="row">
                           <label class="label">&nbsp;</label>
                            <asp:Button ID="LinkButton1" runat="server"
                                CommandName="Edit"
                                Text="Edit" />
                        </div>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:HiddenField ID="id" runat="server" Value='<%#Bind("id") %>' />
                    
                        <div class="row">
                            <asp:Label ID="Label1" runat="server"
                                CssClass="label"
                                AssociatedControlID="rtbTaskName"
                                Text="Name" />

                            <telerik:RadTextBox ID="rtbTaskName" runat="server"
                                Width="400px"
                                TextMode="MultiLine"
                                Height="67px"
                                Text='<%#bind("taskname") %>' />

                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                ControlToValidate="rtbTaskName"
                                ErrorMessage="Task Name required" />
                        </div>

                        <div class="row">
                            <asp:Label ID="Label7" runat="server"
                                CssClass="label"
                                AssociatedControlID="rtbKeywords"
                                Text="Keywords" />

                            <telerik:RadTextBox ID="rtbKeywords" runat="server"
                                Width="400px"
                                TextMode="MultiLine"
                                Height="67px"
                                Text='<%#bind("keywords") %>' />
                        </div>

                        <hr />
                        
                        <div class="row">
                            <asp:Label ID="Label2" runat="server"
                                CssClass="label"
                                AssociatedControlID="rcbBuildPhase"
                                Text="Build Phase" />

                            <telerik:RadComboBox ID="rcbBuildPhase" runat="server"
                                SelectedValue='<%# Bind("buildPhaseId")%>'
                                DataSourceID="buildPhaseDataSource"
                                DataTextField="buildPhase"
                                DataValueField="id" />
                        </div>
                        
                        <div class="row">
                            <asp:Label ID="Label3" runat="server"
                                CssClass="label"
                                AssociatedControlID="rcbUnit"
                                Text="Unit" />

                            <telerik:RadComboBox ID="rcbUnit" runat="server"
                                SelectedValue='<%# Bind("unitId")%>'
                                DataSourceID="unitDataSource"
                                DataTextField="unit"
                                DataValueField="id" />
                        </div>
                        
                        <div class="row">
                            <asp:Label ID="Label4" runat="server"
                                CssClass="label"
                                AssociatedControlID="rntbMinutes"
                                Text="Minutes" />

                            <telerik:RadNumericTextBox ID="rntbMinutes" runat="server"
                                MinValue="0"
                                NumberFormat-DecimalDigits="0"
                                Width="70"
                                DbValue='<%#bind("minutes") %>' />
                            minutes
                        </div>
                        
                        <div class="row">
                            <asp:Label ID="Label5" runat="server"
                                CssClass="label"
                                AssociatedControlID="cbHidden"
                                Text="Hidden" />
                            
                            <asp:CheckBox ID="cbHidden" runat="server"
                                Checked='<%# Bind("hidden") %>' Text="Hidden" />
                        </div>
                        
                        
                        <div class="row">
                            <label class="label">&nbsp;</label>
                            <asp:Button ID="btnUpdate" runat="server"
                                CommandName="Update"
                                Text="Update" />
                            
                            <asp:Button ID="btnCancel" runat="server"
                                CausesValidation="false"
                                CommandName="Cancel"
                                Text="Cancel" />
                        </div>
                    </EditItemTemplate>
                </asp:FormView>
            </div>    
        </div>
        
        
        <div class="box">
            <h3>Resources</h3>
            
            <div class="boxcontent">
            list of default resources for the task should go here.
            These would be automatically added to the project when a user adds a task to a build element.
            </div>
        </div>    
    </div>

    <div class="div33r">
        <div class="box">
            <h3>
                <asp:HyperLink ID="hlAddTask" runat="server"
                    CssClass="floatright"
                    NavigateUrl="add_task.aspx?pid={0}"
                    Text="Add Child Task" />
                Child Tasks
            </h3>
            
            <div class="boxcontent">
            
                <telerik:RadGrid ID="rgChildren" runat="server"
                    GridLines="None"
                    DataSourceID="taskChildrenDataSource">
                    <MasterTableView
                        AutoGenerateColumns="False"
                        DataSourceID="taskChildrenDataSource"
                        NoMasterRecordsText="&nbsp;No child tasks found."
                        DataKeyNames="id">
                        <Columns>
                            <telerik:GridHyperLinkColumn
                                HeaderText="Task Name"
                                UniqueName="taskName"
                                DataNavigateUrlFields="id"
                                DataNavigateUrlFormatString="edit_task.aspx?tid={0}"
                                DataTextField="taskName"
                                DataTextFormatString="{0}" />
                            
                            <telerik:GridBoundColumn DataField="id" UniqueName="id" Visible="false" />
                            <telerik:GridBoundColumn DataField="hidden" UniqueName="hidden" Visible="false" />

                            <telerik:GridTemplateColumn
                                UniqueName="hidden"
                                HeaderText="Hidden"
                                HeaderStyle-Width="20%"
                                HeaderStyle-HorizontalAlign="Center"
                                ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:CheckBox ID="CheckBox1" runat="server" AutoPostBack="true" OnCheckedChanged="toggleHidden" />
                                    <asp:HiddenField ID="hfTaskId" runat="server" Value='<%#Bind("id") %>' />
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </div>
        </div>
    </div>

    <asp:SqlDataSource ID="taskDetailsDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        UpdateCommand="
            UPDATE TaskData SET taskName = @taskName, unitId = @unitId, minutes = @minutes,
            keywords = @keywords,
            buildPhaseId = @buildPhaseId, hidden=@hidden WHERE id= @id;"
        SelectCommand="
            SELECT
                TaskData.id,
                TaskData.taskName,
                keywords,
                unitId,
                buildPhaseId,
                minutes,
                unitId,
                unit,
                buildPhase, hidden = 
                CASE
                    WHEN hidden IS NULL THEN 'False'
                    WHEN hidden = 0 THEN 'False'
                    ELSE 'True'
                END
            FROM TaskData
            LEFT JOIN TaskBuildPhase on TaskData.buildPhaseId = TaskBuildPhase.id
            LEFT JOIN ResourceUnit ON TaskData.unitId = ResourceUnit.id
            WHERE TaskData.id = @taskId">
        <UpdateParameters>
            <asp:QueryStringParameter QueryStringField="tid" Name="taskId" />
        </UpdateParameters>
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="tid" Name="taskId" />
        </SelectParameters>
    </asp:SqlDataSource>


    <asp:SqlDataSource ID="taskNameDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="getTaskDataFullName" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="tid" Name="taskId" />
        </SelectParameters>
    </asp:SqlDataSource>
    
    <asp:SqlDataSource ID="taskChildrenDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="getTaskDataChildren" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="tid" Name="taskId" />
            <asp:Parameter  name="showall" DefaultValue="1" />
        </SelectParameters>
    </asp:SqlDataSource>
    
    <asp:SqlDataSource ID="buildPhaseDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="
           SELECT * FROM TaskBuildPhase ORDER BY buildPhase">
    </asp:SqlDataSource>
    
    <asp:SqlDataSource ID="unitDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="
           SELECT * FROM ResourceUnit ORDER BY unit">
    </asp:SqlDataSource>    
</asp:Content>