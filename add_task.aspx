﻿<%@ Page Title="Add a Task - Buildmate" Language="VB" MasterPageFile="~/common/Manager.master" AutoEventWireup="false" CodeFile="add_task.aspx.vb" Inherits="manager_add_task" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<script language="javascript">
function ClientNodeClicked(sender, eventArgs) {
    var node = eventArgs.get_node();
    node.toggle();
    if (node.get_checked()) {
        node.uncheck();
    } else {
        node.check();
    }
}
</script>

    <telerik:RadScriptBlock ID="rsbPhase3" runat="server" Visible="false">
    <script type="text/javascript">
        var data = {
            target: "#toolHook",
            progress: 1,
            tooltip: {
                title: "Job Tasks",
                content: "<strong>Job tasks are grouped under 23 main section headings.</strong><br><br>1. For the purposes of this tutorial click the section heading 'Existing/site/building/services' (blue text) from the list located on the left.<br><br>2. With the section heading open drill down and build-up a job task description then click the check box found at the end of the description. <br><br>3. With a Job Task checked navigate to the bottom of the page and click 'Add Selected Tasks'<br><br><em>Help: Opening 'Add tasks' accesses Buildmate’s current Job Task database of over 1,000,000 Individual Job Tasks. These are accessed by clicking on a main section heading and then drilling down through the options provided to create individual Job Tasks. More than one Job Task can be selected and added simultaneously. </em>",
                direction: "none"
            }
        };

        $(document).ready(function () {
            bm.tour(data);
        });
    </script>
    </telerik:RadScriptBlock>
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
        <div class="breadcrumb-container">
            <ul class="breadcrumb-list">
                <li>
                    <asp:HyperLink ID="hlBack" runat="server"
                        NavigateUrl="project_details.aspx?pid={0}"
                        Text="Project Details" />
                    <span class="divider">/</span>
                </li>
                <li>
                    <asp:HyperLink ID="hlBack2" runat="server"
                        NavigateUrl="build_element_details.aspx?pid={0}&rid={1}"
                        Text="Build Element Details" />
                    <span class="divider">/</span>
                </li>
                <li class="active">
                    Add Tasks
                </li>
            </ul>
        </div>
    </div>

    <div class="main-container">
        <div id="toolHook" class="floatright"></div>
        <asp:Panel ID="pAddTasks" runat="server" Visible="false">
            <telerik:RadTreeView runat="server" ID="RadTreeView1"
                OnClientNodeClicked="ClientNodeClicked"
                CheckBoxes="true"
                Style="white-space: normal;"
                ShowLineImages="true" />

            <div class="form-actions">
                <asp:LinkButton ID="btnAdd" runat="server" tooltip="Add Selected Task(s)"
                        CssClass="button button-create" text="Add Selected Tasks" />
            </div>
        </asp:Panel>

    <asp:Panel ID="pLimitedTasks" runat="server" CssClass="box-alert box-primary" Visible="false">
        <h3>Limited Subscription</h3>

            <div class="boxcontent">
                <a href="subscription.aspx" class="button button-large">Update your subscription</a>
                
                <p>Update your subscription to get instant access to Tasks &amp; Resources.</p>
                
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
    </div>
</asp:Content>