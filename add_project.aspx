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
        // close modal
        $(".modal-window").animate({ "top": "-50%" }, function () {
            $(".modal-wrapper").fadeOut();
        });
        return true;
    } else {
        return false;
    }
}
</script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlId="Panel1">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="Panel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlId="fvCustomerInsert">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="rcbCustomer" />
                     <telerik:AjaxUpdatedControl ControlID="fvCustomerInsert" />
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

    <div id="addCustomer" class="modal-window">
        <h3><a href="#" class="close">&times;</a> Add a Customer</h3>

        <div class="boxcontent">
            <asp:FormView
                ID="fvCustomerInsert"
                runat="server"
                DataSourceId="insertCustomerDataSource"
                DefaultMode="Insert"
                DataKeyNames="id"
                Width="600px">
                <InsertItemTemplate>
                    <div class="row">
                        <asp:Label
                            ID="Label10"
                            runat="server"
                            Text="Title*"
                            CssClass="label"
                            AssociatedControlID="rcbTitle" />
                        
                        <telerik:RadComboBox ID="rcbTitle" runat="server"
                            Width="120px"
                            OnDataBound="rcbTitle_DataBound"
                            SelectedValue='<%# Bind("titleId") %>'
                            DataSourceID="titleDataSource"
                            DataTextField="title"
                            DataValueField="id" />
                        
                        <asp:RequiredFieldValidator
                            ID="RequiredFieldValidator8"
                            runat="server"
                            ControlToValidate="rcbTitle"
                            ValidationGroup="insertGroup"
                            Display="Dynamic"
                            InitialValue="Select a Title.."
                            ErrorMessage="Customer Title">
                            <span class="req"></span>
                        </asp:RequiredFieldValidator>
                    </div>
                                                    
                    <div class="row">
                        <asp:Label
                            ID="Label11"
                            runat="server"
                            Text="First Name*"
                            CssClass="label"
                            AssociatedControlID="rtbFirstName" />
                            
                        <telerik:RadTextBox
                            ID="rtbFirstName"
                            runat="server"
                            Text='<%#Bind("firstname") %>'
                            Columns="35"
                            EmptyMessage="First Name" />
                        
                        <asp:RequiredFieldValidator
                            ID="RequiredFieldValidator1"
                            runat="server"
                            ControlToValidate="rtbFirstName"
                            ValidationGroup="insertGroup"
                            Display="Dynamic"
                            ErrorMessage="First Name">
                            <span class="req"></span>
                        </asp:RequiredFieldValidator>
                    </div>

                    <div class="row">                            
                        <asp:Label
                            ID="Label12"
                            runat="server"
                            Text="Surname*"
                            CssClass="label"
                            AssociatedControlID="rtbSurname" />

                        <telerik:RadTextBox
                            ID="rtbSurname"
                            runat="server"
                            Text='<%#Bind("surname") %>'
                            Columns="35"
                            EmptyMessage="Surname" />
                        
                        <asp:RequiredFieldValidator
                            ID="RequiredFieldValidator2"
                            runat="server"
                            ControlToValidate="rtbSurname"
                            ValidationGroup="insertGroup"
                            Display="Dynamic"
                            ErrorMessage="Surname">
                            <span class="req"></span>
                        </asp:RequiredFieldValidator>
                    </div>
                                            
                    <div class="row">
                        <asp:Label
                            ID="Label13"
                            runat="server"
                            Text="Company"
                            CssClass="label"
                            AssociatedControlID="rtbCompany" />
                            
                        <telerik:RadTextBox
                            ID="rtbCompany"
                            runat="server"
                            Text='<%#Bind("company") %>'
                            Columns="35"
                            EmptyMessage="Company" />
                    </div>

                    <div class="row">
                        <asp:Label
                            ID="Label14"
                            runat="server"
                            Text="Address*"
                            CssClass="label"
                            AssociatedControlID="rtbAddress1" />

                        <telerik:RadTextBox
                            ID="rtbAddress1"
                            runat="server"
                            Text='<%#Bind("address1") %>'
                            Columns="35"
                            EmptyMessage="Address" />
                        
                        <asp:RequiredFieldValidator
                            ID="RequiredFieldValidator5"
                            runat="server"
                            ControlToValidate="rtbAddress1"
                            ValidationGroup="insertGroup"
                            Display="Dynamic"
                            ErrorMessage="Address">
                            <span class="req"></span>
                        </asp:RequiredFieldValidator>
                    </div>
                    
                    <div class="row">
                        <asp:Label
                            ID="Label15"
                            runat="server"
                            Text="Town/City"
                            CssClass="label"
                            AssociatedControlID="rtbCity" />

                        <telerik:RadTextBox
                            ID="rtbCity"
                            runat="server"
                            Text='<%#Bind("city") %>'
                            Columns="35"
                            EmptyMessage="Town/City" />
                        
                        <asp:RequiredFieldValidator
                            ID="RequiredFieldValidator6"
                            runat="server"
                            ControlToValidate="rtbCity"
                            ValidationGroup="insertGroup"
                            Display="Dynamic"
                            ErrorMessage="Town/City">
                            <span class="req"></span>
                        </asp:RequiredFieldValidator>
                    </div>

                    <div class="row">
                        <asp:Label
                            ID="Label16"
                            runat="server"
                            Text="Postcode*"
                            CssClass="label"
                            AssociatedControlID="rtbPostcode" />

                        <telerik:RadTextBox
                            ID="rtbPostcode"
                            runat="server"
                            Text='<%#Bind("postcode") %>'
                            EmptyMessage="Postcode" />
                        
                        <asp:RequiredFieldValidator
                            ID="RequiredFieldValidator7"
                            runat="server"
                            ControlToValidate="rtbPostcode"
                            ValidationGroup="insertGroup"
                            Display="Dynamic"
                            ErrorMessage="Postcode">
                            <span class="req"></span>
                        </asp:RequiredFieldValidator>
                    </div>
      
                    <div class="row">
                        <asp:Label
                            ID="Label17"
                            runat="server"
                            Text="Country"
                            CssClass="label"
                            AssociatedControlID="rcbCountry" />

                        <telerik:RadComboBox
                            ID="rcbCountry"
                            runat="server"
                            Height="140px"
                            OnLoad="defaultCountry"
                            SelectedValue='<%# Bind("countryId") %>'
                            DataSourceID="countryDataSource"
                            DataTextField="countryName"
                            DataValueField="id" />
                    </div>
                    
                    <div class="row">
                        <asp:Label
                            ID="Label18"
                            runat="server"
                            Text="Payment Terms"
                            CssClass="label"
                            AssociatedControlID="rcbPaymentTerms" />

                        <telerik:RadComboBox
                            ID="rcbPaymentTerms"
                            runat="server"
                            Height="80px"
                            Width="130px"
                            SelectedValue='<%# Bind("paymentTermsId") %>'
                            DataSourceID="paymentDataSource" 
                            DataTextField="paymentTerm"
                            DataValueField="id" />
                    </div>
                                            
                    <div class="row">
                        <label class="label">&nbsp;</label>
                                
                        <asp:Button ID="btnInsert" runat="server"
                            CommandName="Insert"
                            OnClientClick="validateModal()"
                            Text="Add Customer"
                            ValidationGroup="insertGroup" />
                    </div>
                </InsertItemTemplate>
            </asp:FormView>
        </div>
    </div>
    <div class="modal-wrapper" title="Click or press Esc to cancel"></div>
<div class="breadcrumb">
<p>
    <asp:HyperLink ID="HyperLink1" runat="server"
        NavigateUrl="~/projects.aspx"
        Text="Projects" />
    &raquo; Add a Project
</p>
</div>

    <asp:Panel ID="Panel1" runat="server" CssClass="box">
                <h3>Add a Project</h3>
                
                <div class="boxcontent">

                    <div class="row">
                        <asp:Label ID="Label2" runat="server"
                            CssClass="label"
                            Text="Estimate Type"
                            AssociatedControlID="rcbEstimateType" />

                        <telerik:RadComboBox
                            ID="rcbEstimateType"
                            runat="server"
                            AutoPostBack="true"
                            DataSourceId="projectTypeDataSource"
                            DataTextField="projectType"
                            DataValueField="id"
                            MaxHeight="190px"
                            DropDownWidth="300px" />
                        
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                            ErrorMessage="Estimate Type required"
                            ControlToValidate="rcbEstimateType"
                            CssClass="req"
                            ValidationGroup="projectGroup"
                            InitialValue="Select an Estimate Type.." />
                    </div>

                    <div class="row">
                        <asp:Label ID="Label1" runat="server"
                            Text="Copy from Project"
                            CssClass="label"
                            AssociatedControlID="rcbProjects" />

                        <telerik:RadComboBox
                            ID="rcbProjects"
                            runat="server"
                            EmptyMessage="Requires an Estimate Type"
                            DataSourceID="projectsDataSource"
                            DataTextField="projectName"
                            DataValueField="id"
                            Enabled="false"
                            Width="300px"
                            MaxHeight="190px"
                            DropDownWidth="300px" />

                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server"
                            ErrorMessage="Estimate Type required"
                            ControlToValidate="rcbProjects" Enabled="false"
                            CssClass="req"
                            ValidationGroup="projectGroup"
                            InitialValue="Select a Template.." />
                    </div>

                    <div class="row">
                        <asp:Label
                            ID="Label3"
                            runat="server"
                            Text="Customer*"
                            CssClass="label"
                            AssociatedControlID="rcbCustomer" />
                            
                            <div class="ctl00MainContentrcbCustomerPanel">
                        <telerik:RadComboBox
                            ID="rcbCustomer"
                            runat="server"
                            DataSourceID="customersDataSource"
                            DataTextField="customerName"
                            DataValueField="id"
                            Width="300px"
                            MaxHeight="190px"
                            DropDownWidth="300px" />
                            </div>
                            
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                            ErrorMessage="Customer required"
                            ControlToValidate="rcbCustomer"
                            CssClass="req"
                            ValidationGroup="projectGroup"
                            InitialValue="Select a Customer.." />

                        <a href="#" class="open_modal button create" rel="addCustomer">+ Add a Customer</a>
                    </div>
                    

                    <asp:FormView ID="fvCreateProject" runat="server"
                        DataKeyNames="id"
                        Width="100%"
                        DefaultMode="Insert"
                        DataSourceID="insertProjectDataSource">
                        <InsertItemTemplate>
                            <telerik:RadCalendar ID="RadCalendar1" runat="server"
                                EnableViewSelector="true"
                                DayNameFormat="Short"
                                FirstDayOfWeek="Monday" />
                                    
                            <div class="row">
                                <asp:Label ID="Label4" runat="server"
                                    Text="Project Name*"
                                    CssClass="label"
                                    AssociatedControlID="rtbProjectName" />
                                    
                                <telerik:RadTextBox ID="rtbProjectName" runat="server"
                                    Width="200px"
                                    Text='<%# Bind("projectName") %>'
                                    EmptyMessage="Project Name" />
                                                
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                    ControlToValidate="rtbProjectName"
                                    ValidationGroup="projectGroup"
                                    ErrorMessage="Project Name required"
                                    CssClass="req" />
                            </div>

                            <div class="row">
                                <asp:Label ID="Label5" runat="server"
                                    Text="Description"
                                    CssClass="label"
                                    AssociatedControlID="rtbDescription" />
                                
                                <telerik:RadTextBox ID="rtbDescription" runat="server"
                                    Width="300px"
                                    Height="60px"
                                    TextMode="MultiLine"
                                    Text='<%# Bind("description") %>'
                                    EmptyMessage="Description" />
                            </div>
                            
                            <div class="row">
                                <asp:Label ID="Label6" runat="server"
                                    Text="Return Date*"
                                    CssClass="label"
                                    AssociatedControlID="rdtpReturnDate" />
                                
                                <telerik:RadDateTimePicker ID="rdtpReturnDate" runat="server"
                                    DbSelectedDate='<%# Bind("returnDate") %>'
                                    SharedCalendarID="RadCalendar1"
                                    DateInput-EmptyMessage="Return Date" />
                                                
                                <asp:RequiredFieldValidator ID="rfvReturnDate" runat="server"
                                    ControlToValidate="rdtpReturnDate"
                                    ValidationGroup="projectGroup"
                                    ErrorMessage="Return Date required"
                                    CssClass="req" />   
                            </div>
                                            
                            <div class="row">
                                <asp:Label ID="Label7" runat="server"
                                    Text="Start Date"
                                    CssClass="label"
                                    AssociatedControlID="rdpStartDate" />
                                
                                <telerik:RadDatePicker ID="rdpStartDate" runat="server"
                                    AutoPostBack="true"
                                    DbSelectedDate='<%# Bind("startDate") %>'
                                    OnSelectedDateChanged="OnSelectedDateChanged"
                                    DateInput-EmptyMessage="Start Date"
                                    SharedCalendarID="RadCalendar1" />
                            </div>
                                
                            <div class="row">
                                <asp:Label ID="Label8" runat="server"
                                    Text="Completion"
                                    CssClass="label"
                                    AssociatedControlID="rdpCompletionDate" />
                                
                                <telerik:RadDatePicker ID="rdpCompletionDate" runat="server"
                                    DbSelectedDate='<%# Bind("completionDate") %>'
                                    DateInput-EmptyMessage="Completion Date"
                                    SharedCalendarID="RadCalendar1" />
             
                                <asp:CompareValidator ID="CompareValidator1" runat="server"
                                    ValidationGroup="projectGroup"
                                    Enabled="false"
                                    ControlToValidate="rdpCompletionDate"
                                    ControlToCompare="rdpStartDate"
                                    Operator="GreaterThanEqual"
                                    Type="Date"
                                    CssClass="req"
                                    ErrorMessage="Completion Date must be after your Start Date" />
                            </div>
                            
                            <div class="row">
                                <asp:Label ID="Label9" runat="server"
                                    Text="Retention"
                                    CssClass="label"
                                    AssociatedControlID="rtbRetentionPeriod" />
                                
                                <telerik:RadNumericTextBox ID="rtbRetentionPeriod" runat="server"
                                    EmptyMessage="0"
                                    Type="Number"
                                    NumberFormat-DecimalDigits="0"
                                    MinValue="1"
                                    Text='<%# Bind("retentionPeriod") %>'
                                    Width="30px"
                                    CssClass="formw" />
                                
                                <telerik:RadComboBox ID="rcbRetentionType" runat="server"
                                    Width="100px"
                                    SelectedValue='<%# Bind("retentionTypeId") %>'
                                    DataSourceID="retentionTypeDataSource"
                                    DataTextField="retentionType"
                                    DataValueField="id" />
                                
                                at
                                                
                                <telerik:RadNumericTextBox ID="rtbRetentionPercentage" runat="server"
                                    EmptyMessage="%"
                                    Width="40px"
                                    NumberFormat-DecimalDigits="0"
                                    MinValue="0"
                                    MaxValue="100"
                                    CssClass="formw"
                                    Text='<%# Bind("retentionPercentage") %>'
                                    Type="Percent" />
                            </div>         
                            <div class="row">
                                <label class="label">&nbsp;</label>
                                
                                <asp:Button ID="btnCreate" runat="server"
                                    CommandName="Insert"
                                    Text="Create Project"
                                    OnClick="OnClick_Validate"
                                    ValidationGroup="projectGroup" />
                            </div>
                        </InsertItemTemplate>
                    </asp:FormView>
                </div>
            </asp:Panel>

    
    <asp:SqlDataSource ID="projectTypeDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>" 
        SelectCommand="SELECT * FROM ProjectType" />

    
    <asp:SqlDataSource ID="statusDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="SELECT [id], [status] FROM Status ORDER BY [setorder]" />

    
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


    <asp:SqlDataSource ID="customersDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="
            SELECT UserContact.id, (title + ' ' + firstname + ' ' + surname) AS customerName, address1, city, county, postcode
            FROM UserContact, UserTitle
            WHERE (titleId = UserTitle.id) AND (UserContact.UserId = @UserId) AND archived = 0
            ORDER BY surname, firstname">
        <SelectParameters>
            <asp:SessionParameter Name="UserId" SessionField="UserId" />
        </SelectParameters>
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
    
    <asp:SqlDataSource ID="insertCustomerDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        InsertCommand="insertUserContactDetails" InsertCommandType="StoredProcedure">
        <InsertParameters>
            <asp:SessionParameter name="UserId" SessionField="UserId" />
            <asp:Parameter Name="jobtitle" />
	        <asp:Parameter Name="address2" />
	        <asp:Parameter Name="address3" />
	        <asp:Parameter Name="county" />
	        <asp:Parameter Name="tel" />
	        <asp:Parameter Name="fax" />
	        <asp:Parameter Name="mobile" />
	        <asp:Parameter Name="business" />
	        <asp:Parameter Name="extension " />
	        <asp:Parameter Name="email" />
	        <asp:Parameter Name="paymentTermsId" DefaultValue="0" />
            <asp:Parameter Name="NewId" Direction="Output" Size="4" />
        </InsertParameters>
    </asp:SqlDataSource>
    
    <asp:SqlDataSource ID="titleDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="SELECT [id], [title] FROM UserTitle" />

    <asp:SqlDataSource ID="countryDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="SELECT [id], [countryName] FROM Country" />  
        
</asp:Content>