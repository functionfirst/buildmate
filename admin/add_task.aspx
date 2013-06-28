<%@ Page Title="Add Task - Admin" Language="VB" MasterPageFile="~/common/admin.master" AutoEventWireup="false" CodeFile="add_task.aspx.vb" Inherits="add_task" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">


    <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlId="fvTaskDetails">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="fvTaskDetails" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>


    <p class="breadcrumb">
        <a href="tasks.aspx">Task Manager</a> &raquo;
        Add Task
    </p>


    <div class="box">
        <h3>Task Name</h3>
        
        <div class="boxcontent">
            <asp:FormView ID="fvTaskDetails" runat="server"
                Width="100%"
                DefaultMode="Insert"
                DataKeyNames="id"
                DataSourceID="TaskDetailsDataSource">
                <InsertItemTemplate>
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
                        <asp:Label ID="Label5" runat="server"
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
                            Value='<%#bind("minutes") %>' />
                        minutes
                    </div>
                    
                    <div class="row">
                        <label class="label">&nbsp;</label>
                        <asp:Button ID="btnInsert" runat="server"
                            CommandName="Insert"
                            Text="Insert" />
                    </div>
                </InsertItemTemplate>
            </asp:FormView>
        </div>    
    </div>


    <asp:SqlDataSource ID="taskDetailsDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        InsertCommand="
            INSERT INTO TaskData (taskName, keywords, parentId, unitId, buildPhaseId, minutes)
            VALUES(@taskName, @keywords, @parentId, @unitId, @buildPhaseId, @minutes)">
        <InsertParameters>
            <asp:QueryStringParameter QueryStringField="pid" Name="parentId" />
        </InsertParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="buildPhaseDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="getTaskBuildPhases" SelectCommandType="StoredProcedure">
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="unitDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="getResourceUnits" SelectCommandType="StoredProcedure">
    </asp:SqlDataSource>    
</asp:Content>