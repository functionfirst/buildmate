<%@ Page Title="Add a Task - BuildMate" Language="VB" MasterPageFile="~/common/Manager.master" AutoEventWireup="false" CodeFile="add_task_new.aspx.vb" Inherits="manager_add_task_new" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

<script type="text/javascript" src="/js/add_tasks.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlId="pTaskFilters">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="pTaskFilters" />
                     <telerik:AjaxUpdatedControl ControlID="RadTreeView1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlId="RadTreeView1">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="RadTreeView1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>

<div class="breadcrumb">
<p>
    <asp:HyperLink ID="hlBack" runat="server"
        NavigateUrl="project_details.aspx?pid={0}"
        Text="Project Details" />
        &raquo; 
        <asp:HyperLink ID="hlBack2" runat="server"
        NavigateUrl="build_element_details.aspx?pid={0}&rid={1}"
        Text="Build Element Details" />
        &raquo; Add Tasks
</p>
</div>

    <asp:Panel ID="pTaskFilters" runat="server" Visible="false">
        <fieldset>
            <legend title="Keywords">Keywords</legend>
                            
            <div class="row">
                <telerik:RadTextBox ID="rtbFilters" runat="server" />
                <asp:Button ID="btnFilter" runat="server" Text="Filter" />
                <asp:Button ID="btnClear" runat="server" Text="Clear" />
            </div>
        </fieldset>
    </asp:Panel>
    
    <asp:Panel ID="pAddTasks" runat="server" CssClass="box" Visible="false">
        <h3>
            <asp:LinkButton ID="btnAdd" runat="server" tooltip="Add Selected Task(s)"
                CssClass="button addButton" text="+" />
            Add Tasks</h3>
        
        <div class="boxcontent">
            <asp:Label ID="results" runat="server" />

     
        </div>
    </asp:Panel>

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
                    You are currently subscribed to use BuildMate's free customer database.
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
</asp:Content>

