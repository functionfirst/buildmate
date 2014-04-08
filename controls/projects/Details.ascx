<%@ Control Language="VB" AutoEventWireup="false" CodeFile="Details.ascx.vb" Inherits="controls_projects_Details" ClassName="ProjectDetails" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>


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

<h3>Complete your Project Details</h3>

<asp:FormView ID="fvCreateProject" runat="server"
    DataKeyNames="id"
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
                Width="300px"
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
                 Columns="60" Rows="3" Width="400"
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
            <asp:Label ID="lblLabelTenderType" runat="server"
                AssociatedControlID="rcbTenderType"
                CssClass="label"
                Text="Tender Type" />

            <telerik:RadComboBox ID="rcbTenderType" runat="server" SelectedValue='<%# Bind("tenderTypeId") %>'
                DataSourceID="tenderTypeDataSource" DataTextField="tenderType" DataValueField="id" />
        </div>        
        
        <div class="form-actions">
            <asp:LinkButton ID="lbBack" runat="server" CssClass="button" OnClick="lbBack_Click">
                &laquo; Back
            </asp:LinkButton>
            <asp:Button ID="btnCreate" runat="server"
                CommandName="Insert"
                CssClass="button button-create"
                Text="Create Project"
                OnClick="OnClick_Validate"
                ValidationGroup="projectGroup" />
                
        </div>
    </InsertItemTemplate>
</asp:FormView>

<asp:SqlDataSource ID="insertProjectDataSource" runat="server" 
    ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>" 
    InsertCommand="insertProject" InsertCommandType="StoredProcedure">
    <InsertParameters>
        <asp:SessionParameter Name="userId" SessionField="UserId" />
        <asp:SessionParameter Name="created_by" SessionField="UserId" />
        <asp:ControlParameter Name="projectTypeId" ControlID="hfEstimateType" PropertyName="Value" />
        <asp:ControlParameter Name="customerId" ControlID="hfCustomerId" PropertyName="Value" Type="Int64" />
        <asp:Parameter Name="statusId" Type="Byte" DefaultValue="1" />
        <asp:Parameter Name="retentionPeriod" Type="Byte" DefaultValue="0" />
        <asp:Parameter Name="retentionPercentage" Type="Byte" DefaultValue="0" />
        <asp:Parameter Name="newId" Direction="Output" Size="4" />
    </InsertParameters>
</asp:SqlDataSource>

<asp:SqlDataSource ID="retentionTypeDataSource" runat="server"
    ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
    SelectCommand="SELECT [id], [retentionType] FROM ProjectRetentionType" />

<asp:SqlDataSource ID="tenderTypeDataSource" runat="server"
    ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
    SelectCommand="getProjectTenderTypes" SelectCommandType="StoredProcedure" />