    <%@ Page Title="Add a Project - Buildmate" Language="VB" MasterPageFile="~/common/Manager.master" AutoEventWireup="false" CodeFile="add_project.aspx.vb" Inherits="manager_add_project" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<%@ Register TagPrefix="bm" TagName="Estimate" Src="~/controls/projects/Estimate.ascx" %>
<%@ Register TagPrefix="bm" TagName="Template" Src="~/controls/projects/Template.ascx" %>
<%@ Register TagPrefix="bm" TagName="Customer" Src="~/controls/projects/Customer.ascx" %>
<%@ Register TagPrefix="bm" TagName="Details" Src="~/controls/projects/Details.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<style type="text/css">
    
.rcbHeader ul,
.rcbFooter ul,
.rcbItem ul, .rcbHovered ul, .rcbDisabled ul
{
    width: 100%;
    display: inline-block;
    margin: 0;
    padding: 0;
    list-style-type: none;
}

.col1 { width: 145px }

.col2 { width: 345px }

.col1, .col2, .col3
{
    float: left;
    margin: 0;
    padding: 0 5px 0 0;
    line-height: 14px;
}
</style>

<script type="text/javascript">
function validateModal() {
    if (typeof (Page_ClientValidate) == 'function') {
        Page_ClientValidate('insertGroup');
    }
    if (Page_IsValid) {
        hideModal()
        return true;
    }
    return false;
}
</script>

    <telerik:RadScriptBlock ID="rsbPhase1" runat="server">
    <script type="text/javascript">
        var data = {
            target: '#ctl00_MainContent_bmEstimate_lbTemplate',
            progress: 1,
            tooltip: {
                title: 'Create a Project - Step 1',
                content: "Click the 'Estimate Type' you want to create. Then click the blue button 'Next' located at bottom of the list.<br><br><em>Help: Projects/Estimates are creating using a four step wizard. 'Estimate type' is used to analyse your projects by their respective group heading. All of the details entered using the Project Wizard can be edited after the Project is completed.</em>"
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
            <telerik:AjaxSetting AjaxControlId="rmpProject">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="pWizard" />
                     <telerik:AjaxUpdatedControl ControlID="rmpProject" />
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
            <ul class="breadcrumb-list">
                <li>
                    <asp:HyperLink ID="HyperLink1" runat="server"
                        NavigateUrl="~/projects.aspx"
                        Text="Projects" />
                    <span class="divider">/</span>
                </li>
                <li class="active">
                    Add a Project
                </li>
            </ul>
        </div>
    </div>

    <div class="main-container">
        <asp:Panel ID="pWizard" runat="server" CssClass="project-wizard">
            <asp:Panel ID="pEstimate" runat="server" CssClass="project-tab active"><span>1</span> Estimate Type</asp:Panel>
            <asp:Panel ID="pTemplate" runat="server" CssClass="project-tab"><span>2</span> Template</asp:Panel>
            <asp:Panel ID="pCustomer" runat="server" CssClass="project-tab"><span>3</span> Customer</asp:Panel>
            <asp:Panel ID="pDetails" runat="server" CssClass="project-tab"><span>4</span> Details</asp:Panel>
            
            <asp:HiddenField ID="hfEstimateType" runat="server" Value="0" />
            <asp:HiddenField ID="hfProjectId" runat="server" Value="0" />
            <asp:HiddenField ID="hfCustomerId" runat="server" Value="0" />
        </asp:Panel>

        <div class="wizard-panel">
            <telerik:RadMultiPage ID="rmpProject" runat="server" SelectedIndex="0" RenderSelectedPageOnly="true">
                <telerik:RadPageView runat="server" ID="rpvEstimate">
                   <bm:Estimate id="bmEstimate" runat="server"  />
                </telerik:RadPageView>

                <telerik:RadPageView runat="server" ID="rpvTemplate">
                   <bm:Template id="bmTemplate" runat="server"  />
                </telerik:RadPageView>

                <telerik:RadPageView runat="server" ID="rpvCustomer">
                   <bm:Customer id="bmCustomer" runat="server"  />
                </telerik:RadPageView>

                <telerik:RadPageView runat="server" ID="rpvDetails">
                   <bm:Details id="bmDetails" runat="server"  />
                </telerik:RadPageView>
            </telerik:RadMultiPage>
        </div>
    </div>
</asp:Content>