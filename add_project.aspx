    <%@ Page Title="Add a Project - BuildMate" Language="VB" MasterPageFile="~/common/Manager.master" AutoEventWireup="false" CodeFile="add_project.aspx.vb" Inherits="manager_add_project" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

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

.ctl00MainContentrcbCustomerPanel { float: left; }

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

    <div class="main-container">
        <asp:Panel ID="pWizard" runat="server" CssClass="project-wizard">
            <asp:Panel ID="pEstimate" runat="server" CssClass="project-tab active">1. Estimate Type</asp:Panel>
            <asp:Panel ID="pTemplate" runat="server" CssClass="project-tab">2. Template</asp:Panel>
            <asp:Panel ID="pCustomer" runat="server" CssClass="project-tab">3. Customer</asp:Panel>
            <asp:Panel ID="pDetails" runat="server" CssClass="project-tab">4. Details</asp:Panel>

            <asp:HiddenField ID="hfEstimateType" runat="server" Value="0" />
            <asp:HiddenField ID="hfProjectId" runat="server" Value="0" />
            <asp:HiddenField ID="hfCustomerId" runat="server" Value="0" />
        </asp:Panel>

        <telerik:RadMultiPage ID="rmpProject" runat="server" SelectedIndex="0"></telerik:RadMultiPage>
    </div>

    
    <asp:SqlDataSource ID="retentionTypeDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="SELECT [id], [retentionType] FROM ProjectRetentionType" />


    <asp:SqlDataSource ID="projectsDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="
            SELECT Project.id, projectName, projectTypeId
            FROM Project
            WHERE userID = @userId OR Project.id IN (SELECT ProjectId FROM ProjectTemplate)
            ORDER BY projectName"
        FilterExpression="projectTypeId = {0}">
        <SelectParameters>
            <asp:SessionParameter name="userId" SessionField="userId" />
        </SelectParameters>
        <FilterParameters>
            <asp:ControlParameter ControlID="rcbEstimateType" PropertyName="SelectedValue" DefaultValue="0" />
        </FilterParameters>
    </asp:SqlDataSource>
    
    <asp:SqlDataSource ID="insertProjectDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>" 
        InsertCommand="insertProject" InsertCommandType="StoredProcedure">
        <InsertParameters>
            <asp:SessionParameter Name="userId" SessionField="UserId" />
            <asp:ControlParameter Name="projectTypeId" ControlID="rcbEstimateType" PropertyName="SelectedValue" />
            <asp:ControlParameter Name="customerId" ControlID="rcbCustomer" PropertyName="SelectedValue" Type="Int64" />
            <asp:Parameter Name="statusId" Type="Byte" DefaultValue="1" />
            <asp:Parameter Name="retentionPeriod" Type="Byte" DefaultValue="0" />
            <asp:Parameter Name="retentionPercentage" Type="Byte" DefaultValue="0" />
            <asp:Parameter Name="newId" Direction="Output" Size="4" />
        </InsertParameters>
    </asp:SqlDataSource>
    
    <asp:SqlDataSource ID="paymentDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="SELECT [id], [paymentTerm] FROM ProjectPaymentTerm" />
</asp:Content>