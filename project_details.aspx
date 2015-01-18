<%@ Page Language="VB" MasterPageFile="~/Common/Manager.master" AutoEventWireup="false" validateRequest="false"
    CodeFile="project_details.aspx.vb" Inherits="manager_Default" Title="Project Details - Buildmate" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="head" ContentPlaceHolderID="head" runat="Server">
<style type="text/css">
    
.rcbHeader ul,
.rcbFooter ul,
.rcbItem ul,
.rcbHovered ul,
.rcbDisabled ul {
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
    function checkVariationMode(item) {
        var currentStatus = $("#hiddenStatusId").val();
        var newStatus = item._value;
        if (newStatus <= 2 && currentStatus > 2) {
            alert("Show message")
        } else if (currentStatus <= 2 && newStatus >= 3) {
            showVariationMode();
        } else {
            hideVariationMode();
        }
    }
</script>
</asp:Content>

<asp:Content ID="Content" ContentPlaceHolderID="MainContent" runat="Server">
    
    <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlId="lbRefreshResources">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="rgBuildElements" />
                     <telerik:AjaxUpdatedControl ControlID="fvProjectCosts" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlId="fvElementDetailsInsert">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="rgBuildElements" />
                     <telerik:AjaxUpdatedControl ControlID="fvElementDetailsInsert" />
                     <telerik:AjaxUpdatedControl ControlID="fvProjectCosts" />
                     <telerik:AjaxUpdatedControl ControlID="FormView1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlId="pDocuments">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="pDocuments" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlId="btnExportToXLS">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="document" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlId="btnExportToPDF">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="document" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlId="rgBuildElements">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="rgBuildElements" />
                     <telerik:AjaxUpdatedControl ControlID="fvProjectCosts" />
                     <telerik:AjaxUpdatedControl ControlID="FormView1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlId="FormView1">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="FormView1" />
                     <telerik:AjaxUpdatedControl ControlID="notification" />
                     <telerik:AjaxUpdatedControl ControlID="fvProjectCosts" />
                     <telerik:AjaxUpdatedControl ControlID="fvElementDetailsInsert" />
                     <telerik:AjaxUpdatedControl ControlID="rgBuildElements" />
                     <telerik:AjaxUpdatedControl ControlID="addBuildElementLink" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlId="btnUnarchive">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="btnArchive" />
                     <telerik:AjaxUpdatedControl ControlID="btnUnarchive" />
                     <telerik:AjaxUpdatedControl ControlID="notification" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlId="btnArchive">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="btnArchive" />
                     <telerik:AjaxUpdatedControl ControlID="btnUnarchive" />
                     <telerik:AjaxUpdatedControl ControlID="notification" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>

    

    <iframe id="document" width="1px" height="1px" runat="server" style="position: absolute"></iframe>
    


    <script type="text/javascript">
        function PopupAbove(e, pickerID) {
            var datePicker = $find(pickerID);
            var textBox = datePicker.get_textBox();
            var popupElement = datePicker.get_popupContainer();
            var dimensions = datePicker.getElementDimensions(popupElement);
            var position = datePicker.getElementPosition(textBox);
            datePicker.showPopup(position.x, position.y - dimensions.height);
        }

        function checkReturnEndDate(sender, args) {
            args.IsValid = true;

            // default difference calculation
            var difference = Math.round((endDate - returnDate) / 86400000);
            var returnDate = $find("ctl00_MainContent_FormView1_rdtpReturnDate").get_selectedDate();
            var startDate = $find("ctl00_MainContent_FormView1_rdpStartDate").get_selectedDate();
            var endDate = $find("ctl00_MainContent_FormView1_rdpCompletionDate").get_selectedDate();

            if (startDate && endDate) {
                difference = Math.round((endDate - startDate) / 86400000);
            }

            if (difference < 0) {
                args.IsValid = false;
            }
        }

        function checkReturnStartDate(sender, args) {
            args.IsValid = true;

            var startDate = $find("ctl00_MainContent_FormView1_rdpStartDate").get_selectedDate();
            var returnDate = $find("ctl00_MainContent_FormView1_rdtpReturnDate").get_selectedDate();

            var difference = Math.round((startDate - returnDate) / 86400000);
            if (difference < 0) {
                args.IsValid = false;
            }
        }

        function validateModal() {
            if (typeof (Page_ClientValidate) == 'function') {
                Page_ClientValidate();
            }

            if (Page_IsValid) {
                // close modal
                hideModal();
                return true;
            }
            return false;
        }
    </script>


    <!-- project logs -->
    <div id="projectLogs" class="md-window">
        <div class="md-content">
            <h3>Project Logs</h3>

            <div class="md-details">
                <asp:Repeater ID="Repeater2" runat="server" DataSourceID="logDataSource">
                    <ItemTemplate>
                        <p>
                            <%#Container.DataItem("note")%><br />
                            <small>on <%#DataBinder.Eval(Container.DataItem, "created_at", "{0:D}")%> at <%#DataBinder.Eval(Container.DataItem, "created_at", "{0:H:mm:ss}")%></small>
                        </p>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
            <div class="md-footer">
                <a href="#" class="md-close button">Close</a>
            </div>
        </div>
    </div>

    <asp:SqlDataSource ID="logDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="getProjectLogs" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter Name="projectId" QueryStringField="pid" />
        </SelectParameters>
    </asp:SqlDataSource>

    <!-- documents -->
    <div id="documents" class="md-window">
        <div class="md-content">
            <h3>Create a Document...</h3>

        <asp:Panel ID="pDocuments" runat="server">
             <div class="md-details">
                <div class="row">
                    <asp:Label
                        ID="Label11"
                        CssClass="label"
                        runat="server"
                        Text="Document Type"
                        AssociatedControlID="rcbReportType" />

                    <asp:RadioButtonList ID="rcbReportType" runat="server" AutoPostBack="true">
                        <asp:ListItem Text="Resource break-down" Value="1" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="Acceptance Form" Value="2"></asp:ListItem>
                        <asp:ListItem Text="Offer Letter" Value="3"></asp:ListItem>
                    </asp:RadioButtonList>
                </div>

                <asp:panel class="row" runat="server" id="pTermsOfUse" Visible="false">
                    <asp:Label
                        ID="Label12"
                        CssClass="label"
                        runat="server"
                        Text="Attach Terms of Use"
                        AssociatedControlID="rblTermsOfUse" />

                    <asp:RadioButtonList
                        ID="rblTermsOfUse"
                        runat="server">
                        <asp:ListItem Text="None" Value="0" Selected="true" />
                        <asp:ListItem Text="Small Print" Value="1" />
                        <asp:ListItem Text="Large Print" Value="2" />
                    </asp:RadioButtonList>
                </asp:panel>

                <asp:panel class="row" runat="server" id="pResourceType">
                    <asp:Label
                        ID="Label13"
                        CssClass="label"
                        runat="server"
                        Text="Resource Type"
                        AssociatedControlID="rblResourceType" />

                    <asp:RadioButtonList
                        ID="rblResourceType"
                        runat="server">
                        <asp:ListItem Value="1" Text="Labour" Selected="True" />
                        <asp:ListItem Value="2" Text="Material" />
                        <asp:ListItem Value="3" Text="Plant" />
                    </asp:RadioButtonList>
                </asp:panel>
            </div>

            <div class="md-footer">
                <asp:Button
                    ID="btnExportToXLS"
                    runat="server"
                    Text="Download as Excel"
                    CssClass="button button-secondary" />

                <asp:Button
                    ID="btnExportToPDF"
                    runat="server"
                    Text="Download as PDF"
                    CssClass="button button-create" />
                
                <a href="#" class="md-close button">Close</a>
            </div>
        </asp:Panel>
        </div>
    </div>

    <!-- begin build element resources -->
    <div id="addBuildElement" class="md-window">
        <div class="md-content">
            <h3>Adding a Build Element..</h3>
        
            <asp:FormView
                ID="fvElementDetailsInsert"
                runat="server"
                EnableViewState="false"
                DefaultMode="Insert"
                Width="100%"
                DataSourceID="AllSpacesDataSource"
                DataKeyNames="id">
                <InsertItemTemplate>
                <asp:Panel ID="Panel4" runat="server" DefaultButton="btnInsert">
                    <div class="md-details">
                    <div class="row">
                        <asp:Label ID="Label3" runat="server"
                            CssClass="label"
                            AssociatedControlID="rtbSpaceName"
                            Text="Name*" />
                        
                        <telerik:RadTextBox ID="rtbSpaceName" runat="server"
                            Text='<%#Bind ("spaceName") %>'
                            Width="200px"
                            MaxLength="80"
                            EmptyMessage="Name" />

                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                            ControlToValidate="rtbSpaceName"
                            ValidationGroup="insertValidation"
                            Display="Dynamic"
                            ErrorMessage="Name">
                            <span class="req"></span>
                        </asp:RequiredFieldValidator>                   
                    </div>
                        
                    <div class="row">
                        <asp:Label ID="Label2" runat="server"
                            CssClass="label"
                            AssociatedControlID="rtbSpaceType"
                            Text="Type" />
                            
                        <telerik:RadComboBox ID="rtbSpaceType" runat="server"
                            SelectedValue='<%# Bind("buildElementTypeId") %>'
                            DataSourceID="spaceTypeDataSource"
                            DataTextField="spaceType"
                            DataValueField="buildElementTypeId" />
                    </div>

                    <h4>Additional Costs</h4>
                    
                    <div class="row">
                        <asp:Label ID="Label4" runat="server"
                            CssClass="label"
                            AssociatedControlID="rcbSubcontractType"
                            Text="Sundry Items" />
                            
                        <telerik:RadComboBox
                            ID="rcbSubcontractType"
                            runat="server"
                            width="110px"
                            SelectedValue='<%# Bind("subcontractTypeId")%>'
                            DataSourceID="subcontractTypesDataSource"
                            DataTextField="subcontractType"
                            DataValueField="id" />
                    </div>
                    
                    <div class="row">
                        <asp:Label
                            ID="Label5"
                            runat="server"
                            CssClass="label"
                            AssociatedControlID="rntbSpacePrice"
                            Text="Cost" />

                        <telerik:RadNumericTextBox
                            ID="rntbSpacePrice"
                            runat="server"
                            DBValue='<%# Bind("spacePrice") %>'
                            Type="Currency"
                            NumberFormat-DecimalDigits="2"
                            Width="70px"
                            EmptyMessage="£ (GBP)" />
                    </div>
                    
                    <div class="row">
                        <asp:Label
                            ID="Label6"
                            runat="server"
                            CssClass="label"
                            AssociatedControlID="rntbSubcontractPercent"
                            Text="Adjustment" />
                            
                        <telerik:RadNumericTextBox
                            ID="rntbSubcontractPercent"
                            runat="server"
                            Width="60px"
                            EmptyMessage="0 %"
                            ShowSpinButtons="true"
                            dbValue='<%#Bind("subcontractPercent") %>'
                            MinValue="0"
                            MaxValue="100"
                            Type="Percent"
                            NumberFormat-DecimalDigits="0" />
                    </div>

                    </div>
                    <div class="md-footer">
                        <asp:Button ID="btnInsert"
                            runat="server"
                            CssClass="button button-create"
                            CommandName="Insert"
                            Text="Add Build Element"
                            OnClientClick="validateModal()"
                            ValidationGroup="insertValidation" />
                
                        <a href="#" class="md-close button">Close</a>
                    </div>
                </asp:Panel>
            </InsertItemTemplate>
        </asp:FormView>

        </div>
    </div>
    
    
    <div class="breadcrumb">
        <div class="breadcrumb-container">
            <ul class="breadcrumb-options">
                <li>
                    <asp:HyperLink ID="addBuildElementLink" runat="server"
                        NavigateUrl="#"
                        data-target="addBuildElement"
                        CssClass="js-open-modal button button-create"
                        Text="Add a Build Element" />
                </li>
                <li>
                    <a href="#" class="js-open-modal button button-primary" data-target="documents">Download a Document</a>
                </li>
                <li>
                    <a href="#" class="js-open-modal button button-default" data-target="projectLogs">View Project Logs</a>
                </li>
                <li>
                    <asp:Button ID="btnArchive" runat="server"
                        CssClass="button button-error" Text="Archive this Project" />
                </li>
                <li>
                    <asp:Button ID="btnUnarchive" runat="server"
                        CssClass="button button-primary" Text="Unarchive this Project" />
                </li>
            </ul>
            <ul class="breadcrumb-list">
                <li>
                    <a href="projects.aspx">Projects</a>
                    <span class="divider">/</span>
                </li>
                <li class="active">
                    Project Details
                </li>
            </ul>
        </div>
    </div>

    <div class="main-container">

        <asp:Panel ID="NoProjectPanel" runat="server" CssClass="box-alert box-primary">
            <h3>Project Error</h3>
            Either the selected project doesn't exist or you do not have permissions to view it, please select a project from the <a href="projects.aspx">Project list</a>.
        </asp:Panel>
    
        <asp:Panel ID="completionBar" runat="server" CssClass="completionBar">
            <asp:Repeater ID="Repeater1" runat="server" DataSourceID="projectTimesDataSource">
                <ItemTemplate>
                    <span style='text-align: center; width: <%#Eval("percentComplete", "{0:00}")%>%'></span>
                        <div><%#Eval("percentComplete", "{0:0}")%>% complete</div>
                </ItemTemplate>
            </asp:Repeater>
        </asp:Panel>

 
        <div class="div25">
            <asp:FormView ID="fvProjectCosts" runat="server"
                Width="100%"
                DataSourceID="projectCostDataSource">
 
                <ItemTemplate>
                    <div class="box-alert box-primary centrealign ">
                        <h3>Estimate Total</h3>

                        <div class="boxcontent">
                            <asp:Literal ID="Label3" runat="server" Text='<%# Bind("grandtotal", "{0:c2}") %>' />
                        </div>
                    </div>
                
                    <div class="box">
                        <h3>Estimate Break-down</h3>

                        <div class="boxcontent">
                            <div class='row row-long'>
                                <label class="label">
                                    <asp:HyperLink ID="hpLabour" runat="server" CssClass="ajaxify"
                                        navigateurl="~/labour_costs.aspx?pid={0}" Text="Labour" />
                                </label>
                                <asp:Literal ID="litLabour" runat="server" Text='<%# Bind("labourCost", "{0:c2}") %>' />
                            </div>
                        
                            <div class='row row-long'>
                                <label class="label">
                                    <asp:HyperLink ID="hpMaterial" runat="server" 
                                        navigateurl="~/material_costs.aspx?pid={0}"
                                        Text="Materials" />                           
                                </label>

                                <asp:Literal ID="Literal1" runat="server"
                                    Text='<%# Bind("materialCost", "{0:c2}") %>' /><br />
                            </div>
                        
                            <div id="materialVAT" class="row row-long" runat="server"
                                visible='<%# IIF(Eval("materialVAT") >= 0, "True", "False") %>'>
                                <label class="label"><small>&nbsp;+ VAT</small></label>
                                <small>
                                    <asp:Literal ID="Literal12" runat="server"
                                        Text='<%# Bind("materialVAT", "{0:c2}") %>' />
                                </small>
                            </div>
                        
                            <div class='row row-long'>
                                <label class="label">
                                    <asp:HyperLink ID="hpPlantHire" runat="server"
                                        navigateurl="~/plant_costs.aspx?pid={0}"
                                        Text="Plant &amp; Equipment" />
                                </label>
                                <asp:Literal ID="Literal2" runat="server"
                                    Text='<%# Bind("plantCost", "{0:c2}") %>' />
                            </div>
                        
                            <div id="plantVAT" class="row row-long" runat="server"
                                Visible='<%# IIF(Eval("plantVAT") >= 0, "True", "False") %>'>
                                <label class="label"><small>&nbsp;+ VAT</small></label>
                                <small>
                                    <asp:Literal ID="Literal13" runat="server"
                                        Text='<%# Bind("plantVAT", "{0:c2}") %>' />
                                </small>
                            </div>
                        
                            <div class='row row-long'>
                                <label class="label">
                                    <asp:HyperLink ID="hpSundryItems" runat="server" 
                                        navigateurl="~/sundry_items.aspx?pid={0}"
                                        Text="Sundry Items" />                                
                                </label>

                                <asp:Literal ID="Literal3" runat="server" Text='<%# Bind("subcontractorTotal", "{0:c2}") %>' />
                            </div>
                        
                            <div class='row row-long'>
                                <label class="label">
                                    <asp:HyperLink ID="hpAdhocCosts" runat="server" 
                                        navigateurl="~/adhoc_costs.aspx?pid={0}"
                                        Text="Ad-hoc Costs" />                                
                                </label>

                                <asp:Literal ID="Literal4" runat="server" Text='<%# Bind("adhocCosts", "{0:c2}") %>' />
                            </div>

                            <div class='row row-long row-footer'>
                                <label class="label">Subtotal</label>
                                <asp:Literal ID="Literal5" runat="server" Text='<%# Eval("subtotal", "{0:c2}") %>' />
                            </div>
                        </div>
                    </div>
                
                    <div class="box">
                        <h3>Profit &amp; Overheads</h3>
                    
                        <div class="boxcontent">
                            <div class='row row-long'>
                                <label class="label"><%#Eval("overheadPercent", "Overhead ({0}%)") %></label>
                                <asp:Literal ID="Literal6" runat="server" Text='<%# Eval("overhead", "{0:c2}") %>' />
                            </div>
                        
                            <div class='row row-long'>
                                <label class="label"><%#Eval("profitPercent", "Profit ({0}%)") %></label>
                                <asp:Literal ID="Literal7" runat="server" Text='<%# Eval("profit", "{0:c2}") %>' />
                            </div>

                            <div class='row row-long row-footer'>
                                <label class="label">Subtotal</label>
                                <asp:Literal ID="Literal8" runat="server" Text='<%# Eval("profitOverheadTotal", "{0:c2}") %>' />
                            </div>
                        </div>
                    </div>
                
                    <asp:Panel ID="Panel3" runat="server" CssClass="box"
                        Visible='<%# IIF((Eval("incDiscount") OR (Eval("incVAT")) AND Eval("vatNumber").length > 0), "True", "False") %>'>
                        <h3>Additions</h3>

                        <div class="boxcontent">
                            <asp:Panel ID="Panel2" runat="server" CssClass="row row-long"
                                Visible='<%# IIF((Eval("incVAT") AND Eval("vatNumber").length > 0), "True", "False") %>'>
                                <label class="label"><%#String.Format("VAT ({0:#0.00}%)", Eval("vatRate"))%></label>
                                <asp:Literal ID="Literal10" runat="server" Text='<%# Eval("vatCost", "{0:c2}") %>' />
                            </asp:Panel>
                        
                            <asp:Panel ID="Panel1" runat="server" CssClass="row row-long"
                                Visible='<%# IIF(Eval("incDiscount"), "True", "False") %>'>
                                <label class="label">Contractor Discount (2.5%)</label>
                                <asp:Literal ID="Literal9" runat="server" Text='<%# Eval("discountCost", "{0:c2}") %>' />
                            </asp:Panel>

                            <div class='row row-long row-footer'>
                                <label class="label">Subtotal</label>
                                <asp:Literal ID="Literal11" runat="server" Text='<%# Eval("additionalCost", "{0:c2}") %>' />
                            </div>
                        </div>
                    </asp:Panel>
                </ItemTemplate>
            </asp:FormView>
        </div>

       <div class="div75 div-last">
           <div class="box">
                <asp:FormView ID="FormView1" runat="server"
                    DataKeyNames="id" Width="100%"
                    DataSourceID="SqlDataSource1">
                     <ItemTemplate>
                        <h3><asp:Label ID="Label2" runat="server" Text='<%# Bind("projectName") %>' /></h3>

                        <div class="boxcontent">
                            <p class="desc"><%#FormatString(Eval("description"))%></p>

                            <div class="row">
                                <label title="Project Type" class="label">Project Type</label>
                                <asp:Label ID="lblProjectType" runat="server" Text='<%# Bind("projectType") %>' />
                            </div>
                    
                            <div class="row">
                                <label title="Customer" class="label">Customer</label>
                                <asp:HyperLink ID="HyperLink1" runat="server"
                                    Text='<%# Bind("Name") %>' NavigateUrl='<%# "~/customer_details.aspx?id=" & eval("customerId")%>' />
                            </div>
                    
                            <div class="row">
                                <label title="Status" class="label">Status</label>
                                <asp:Label ID="statusLabel" runat="server" Text='<%# Bind("status") %>' />

                                <asp:HiddenField ID="hiddenStatusId" runat="server" Value='<%#Eval("projectStatusId") %>' />
                                <asp:HiddenField ID="hiddenIsLocked" runat="server" Value='<%#Eval("isLocked") %>' />
                                <asp:HiddenField ID="hiddenStatus" runat="server" Value='<%#Eval("status") %>' />
                            </div>

                            <div class="row">
                                <label title="Return Date" class="label">Return Date</label>
                                <asp:Label ID="lblReturnDate" runat="server" Text='<%# Bind("returnDate","{0:g}") %>' />&nbsp;
                            </div>
                
                            <div class="row">
                                <label title="Start Date" class="label">Start Date</label>
                                <asp:Label ID="startDateLabel" runat="server" Text='<%# Bind("startDate","{0:d}") %>' />&nbsp;
                            </div>
                    
                            <div class="row">
                                <label title="Completion Date" class="label">Completion Date</label>
                                <asp:Label ID="completionDateLabel" runat="server" Text='<%# Bind("completionDate","{0:d}") %>' />&nbsp;
                            </div>

                            <div class="row">
                                <label title="Retention" class="label">Retention</label>
                                <asp:Label ID="retentionPeriodLabel" runat="server" Text='<%# Bind("retentionPeriod") %>' />
                                <asp:Label ID="retentionTypeLabel" runat="server" Text='<%# Bind("retentionType") %>' />
                                at
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("retentionPercentage") %>' />%
                            </div>
                    
                            <div class="row">
                                <label title="Overhead (%)" class="label">Overhead (%)</label>
                                <asp:Label ID="lblOverhead" runat="server" Text='<%# Bind("Overhead") %>' /> %
                            </div>
                    
                            <div class="row">
                                <label title="Profit (%)" class="label">Profit (%)</label>
                                <asp:Label ID="lblProfit" runat="server" Text='<%# Bind("profit") %>' /> %
                            </div>
                    
                            <div class="row">
                                <label title="Tender Type" class="label">Tender Type</label>
                                <asp:Label ID="lblTenderType" runat="server" Text='<%# Bind("tenderType") %>' />
                            </div>
                    
                            <div class="row">
                                <label title="VAT" class="label">VAT</label>

                                <asp:Label ID="Label7" runat="server"
                                    Text='<%# Bind("vatRate", "{0:f2}%") %>'
                                    Visible='<%# IIF(Eval("incVAT"), "True", "False") %>' />
                            
                                <asp:Label ID="Label8" runat="server"
                                    Text='None'
                                    Visible='<%# IIF(Eval("incVAT"), "False", "True") %>' />
                            </div>
                    
                            <div class="row">
                                <label title="Discount" class="label">Discount</label>

                                <asp:Label ID="Label9" runat="server"
                                    Text="2.5% contractor discount"
                                    Visible='<%# IIF(Eval("incDiscount"), "True", "False") %>' />

                                <asp:Label ID="Label10" runat="server"
                                    Text="None"
                                    Visible='<%# IIF(Eval("incDiscount"), "False", "True") %>' />
                            </div>
                    
                            <div class="row">
                                <label class="label">&nbsp;</label>
                                <asp:Button ID="editButton" runat="server" CommandName="Edit"
                                CausesValidation="False" Text="Edit Project" CssClass="button" />
                            </div>

                            <asp:HiddenField ID="hfIsEditable" runat="server" Value='<%#eval("isEditable") %>' />
                        </div>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:Panel ID="Panel5" runat="server" DefaultButton="updateButton">
                
                            <telerik:RadCalendar ID="RadCalendar1" runat="server" Font-Names="Arial, Verdana, Tahoma"
                                EnableViewSelector="true" DayNameFormat="Short" FirstDayOfWeek="Monday" ForeColor="Black"
                                Style="border-color: #ececec">
                                <DayOverStyle BackColor="#bfdbff" />
                            </telerik:RadCalendar>

                            <div class="row">
                                <asp:Label ID="lblLabelProjectName" runat="server"
                                    AssociatedControlID="rtbProjectName"
                                    CssClass="label"
                                    Text="Project Name*" />

                                <telerik:RadTextBox ID="rtbProjectName" runat="server" Text='<%# Bind("projectName") %>'
                                    EmptyMessage="Project Name" Columns="50" MaxLength="150" Width="400" />
                        
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                    ControlToValidate="rtbProjectName"
                                    Display="Dynamic" ErrorMessage="Project Name">
                                    <span class="req"></span>
                                </asp:RequiredFieldValidator>
                            </div>
                    
                            <div class="row">
                                <asp:Label ID="lblLabelDescription" runat="server"
                                    AssociatedControlID="rtbDescription"
                                    CssClass="label"
                                    Text="Description" />
                        
                                <telerik:RadTextBox ID="rtbDescription" runat="server" Text='<%# Bind("description") %>'
                                    EmptyMessage="Description" TextMode="MultiLine" Columns="60" Rows="4" Width="400" />
                            </div>

                            <div class="row">
                                <asp:Label ID="lblLabelProjectType" runat="server"
                                    AssociatedControlID="rcbProjectType"
                                    CssClass="label"
                                    Text="Project Type" />

                                <telerik:RadComboBox ID="rcbProjectType" runat="server" SelectedValue='<%# Bind("projectTypeId") %>'
                                    DataSourceID="projectTypeDataSource" DataTextField="projectType" DataValueField="id" />
                            </div>
                    
                            <div class="row">
                                 <asp:Label ID="lblLabelCustomer" runat="server"
                                    AssociatedControlID="rcbCustomer"
                                    CssClass="label"
                                    Text="Customer" />

                                <telerik:RadComboBox ID="rcbCustomer" runat="server"
                                        DataSourceID="customerdataSource"
                                        DataTextField="customerName"
                                        Height="190px"
                                        DropDownWidth="600px"
                                        MarkFirstMatch="true"
                                        EnableLoadOnDemand="true"
                                        HighlightTemplatedItems="true"
                                        SelectedValue='<%# Bind("customerId") %>'
                                        DataValueField="id">
                                        <HeaderTemplate>
                                            <ul>
                                                <li class="col1">Customer Name</li>
                                                <li class="col2">Address</li>
                                            </ul>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <ul>
                                                <li class="col1"><%#Eval("customerName")%></li>
                                                <li class="col2">
                                                    <%#Eval("fullAddress")%>
                                                </li>
                                            </ul>
                                        </ItemTemplate>
                                    </telerik:RadComboBox>
                            </div>
                    
                            <div class="row">
                                <asp:Label ID="lblLabelStatus" runat="server"
                                    AssociatedControlID="rcbStatus"
                                    CssClass="label"
                                    Text="Status" />

                                <telerik:RadComboBox ID="rcbStatus" runat="server"
                                    AutoPostBack="false"
                                    SelectedValue='<%# Bind("projectStatusID") %>'
                                    DataSourceID="statusDataSource"
                                    DataTextField="status"
                                    DataValueField="id"
                                    OnClientSelectedIndexChanged="checkVariationMode" />

                                <asp:HiddenField ID="hiddenStatusId" runat="server" Value='<%#Eval("projectStatusID")%>' />
                                <asp:HiddenField ID="hiddenIsLocked" runat="server" Value='<%#Eval("isLocked") %>' />
                                <asp:HiddenField ID="hiddenStatus" runat="server" Value='<%#Eval("status") %>' />
                            </div>
                    
                            <div class="row">
                             <asp:Label ID="lblLabelDate" runat="server"
                                    AssociatedControlID="rdtpReturnDate"
                                    CssClass="label"
                                    Text="Return Date*" />

                                <telerik:RadDateTimePicker ID="rdtpReturnDate" runat="server"
                                    DbSelectedDate='<%# Bind("returnDate") %>'
                                    SharedCalendarID="RadCalendar1"
                                    DateInput-EmptyMessage="Return Date" />
                        
                                <asp:RequiredFieldValidator ID="rfvReturnDate" runat="server"
                                    ControlToValidate="rdtpReturnDate"
                                    Display="Dynamic">
                                    <small>Return date is required</small>
                                </asp:RequiredFieldValidator>
                            </div>

                            <div class="row">
                                <asp:Label ID="lblLabelStartDate" runat="server"
                                    AssociatedControlID="rdpStartDate"
                                    CssClass="label"
                                    Text="Start Date" />

                                <telerik:RadDatePicker ID="rdpStartDate" runat="server"
                                    DbSelectedDate='<%# Bind("startDate") %>'
                                    DateInput-EmptyMessage="Start Date" SharedCalendarID="RadCalendar1" />
                            
                                <asp:CustomValidator ID="CustomValidator1" runat="server"
                                    ControlToValidate="rdpStartDate"
                                    OnServerValidate="checkReturnStartDate" Display="Dynamic"
                                    ClientValidationFunction="checkReturnStartDate"
                                    ><small>Start Date must be after your Return Date.</small>
                                </asp:CustomValidator>
                            </div>
                    
                            <div class="row">
                                <asp:Label ID="lblLabelCompletionDate" runat="server"
                                    AssociatedControlID="rdpCompletionDate"
                                    CssClass="label"
                                    Text="Completion Date" />

                                <telerik:RadDatePicker ID="rdpCompletionDate" runat="server"
                                    DbSelectedDate='<%# Bind("completionDate") %>'
                                    DateInput-EmptyMessage="End Date" SharedCalendarID="RadCalendar1" />
                        
                                <asp:CustomValidator ID="CustomValidator2" runat="server"
                                    ControlToValidate="rdpCompletionDate"
                                    OnServerValidate="checkReturnEndDate" Display="Dynamic"
                                    ClientValidationFunction="checkReturnEndDate"
                                    ><small>Completion Date must be after your Return/Start Date.</small>
                                </asp:CustomValidator>
                            </div>

                            <div class="row">
                                <asp:Label ID="lblLabelRetention" runat="server"
                                    AssociatedControlID="rtbRetentionPeriod"
                                    CssClass="label"
                                    Text="Retention" />
                         
                                <telerik:RadNumericTextBox ID="rtbRetentionPeriod" runat="server"
                                    Type="Number"
                                    NumberFormat-DecimalDigits="0"
                                    Text='<%# Bind("retentionPeriod") %>'
                                    Width="30px"
                                    CssClass="formw" />
                            
                                <telerik:RadComboBox ID="RadComboBox1" runat="server"
                                    Width="80px"
                                    SelectedValue='<%# Bind("retentionTypeId") %>'
                                    DataSourceID="retentionTypeDataSource"
                                    DataTextField="retentionType"
                                    DataValueField="id"
                                    CssClass="formw" /> at
                            
                                <telerik:RadNumericTextBox ID="rtbRetentionPercentage" runat="server"
                                    Width="40px"
                                    NumberFormat-DecimalDigits="0"
                                    MinValue="0"
                                    MaxValue="100"
                                    CssClass="formw"
                                    Text='<%# Bind("retentionPercentage") %>'
                                    Type="Percent" />
                            </div>
                    
                            <div class="row">
                                <asp:Label ID="lblLabelOverhead" runat="server"
                                    AssociatedControlID="rntbOverhead"
                                    CssClass="label"
                                    Text="Overhead (%)" />

                                <telerik:RadNumericTextBox ID="rntbOverhead" runat="server" width="80px" ShowSpinButtons="true"
                                    Type="Percent" MinValue="-100" MaxValue="100" Text='<%#Bind("overhead") %>' />
                            </div>
                    
                            <div class="row">
                                <label for="rntbProfit" title="Profit (%)" class="label">Profit (%)</label>
                                <telerik:RadNumericTextBox ID="rntbProfit" runat="server" width="80px" ShowSpinButtons="true"
                                    Type="Percent" MinValue="-100" MaxValue="100" Text='<%#Bind("profit") %>' />
                            </div>
                    
                            <div class="row">
                                 <asp:Label ID="lblLabelTenderType" runat="server"
                                    AssociatedControlID="rcbTenderType"
                                    CssClass="label"
                                    Text="Tender Types" />

                                <telerik:RadComboBox ID="rcbTenderType" runat="server" SelectedValue='<%# Bind("tenderTypeId") %>'
                                    DataSourceID="tenderTypeDataSource" DataTextField="tenderType" DataValueField="id" />
                            </div>
                    
                            <div class="row">
                                 <asp:Label ID="lblLabelVAT" runat="server"
                                    AssociatedControlID="cbIncVAT"
                                    CssClass="label"
                                    Text="VAT" />

                                <asp:CheckBox ID="cbIncVAT" runat="server"
                                    AutoPostBack="true"
                                    OnCheckedChanged="cbIncVat_OnCheckedChanged"
                                    Checked='<%# Bind("incVAT") %>' Text="Apply VAT" />

                        
                                <telerik:RadNumericTextBox ID="rntbVatRate" runat="server"
                                    Width="50px"
                                    NumberFormat-DecimalDigits="2"
                                    MinValue="0"
                                    MaxValue="100"
                                    Enabled='<%# IIF(Eval("incVat"), "True", "False") %>'
                                    Text='<%# Bind("vatRate") %>'
                                    Type="Percent" />
                            </div>
                    
                            <div class="row">
                                <asp:Label ID="lblLabelDiscount" runat="server"
                                    AssociatedControlID="cbIncDiscount"
                                    CssClass="label"
                                    Text="Discount" />

                                <asp:CheckBox
                                    ID="cbIncDiscount" 
                                    runat="server"
                                    Checked='<%# Bind("incDiscount") %>'
                                    Text="Apply Contractor Discount (2.5%)" />
                            </div>

                            <div class="row">
                                <label class="label">&nbsp;</label>
                                <asp:Button ID="updateButton" runat="server" text="Update" CssClass="button button-create"
                                    CommandName="Update" CausesValidation="True" />
                        
                                <asp:Button ID="btnCancel" runat="server" CssClass="button"
                                    CommandName="Cancel" Text="Cancel" />
                            </div>

                            <asp:HiddenField ID="hfIsEditable" runat="server" Value='<%#eval("isEditable") %>' />

                        </asp:Panel>
                    </EditItemTemplate>
                </asp:FormView>
       
        </div>

        <asp:Panel ID="BuildElementsPanel" runat="server" CssClass="box">
            <h3>Build Elements</h3>

            <div class="boxcontent" id="rgBuildElementsPanel">
                <telerik:RadGrid ID="rgBuildElements" runat="server"
                    CssClass="clear"
                    DataSourceID="AllSpacesDataSource"
                    GridLines="None"
                    AllowPaging="true"
                    PageSize="50"
                    PagerStyle-Mode="NextPrev"
                    AllowSorting="true"
                    AutoGenerateColumns="False"
                    AllowAutomaticInserts="True"
                    AllowAutomaticDeletes="True"
                    Width="100%"
                    ShowStatusBar="true">
                    <MasterTableView
                        AutoGenerateColumns="False"
                        DataKeyNames="id"
                        NoMasterRecordsText="&nbsp;No Build Elements were found."
                        DataSourceID="AllSpacesDataSource"
                        EditMode="EditForms">
                        <Columns>
                            <telerik:GridBoundColumn
                                UniqueName="sid"
                                DataField="id"
                                Visible="false" />
                    
                            <telerik:GridHyperLinkColumn 
                                UniqueName="spaceName"
                                HeaderText="Name"
                                SortExpression="spaceName"
                                DataNavigateUrlFields="projectId, id"
                                DataTextField="spaceName"
                                DataNavigateUrlFormatString="build_element_details.aspx?pid={0}&rid={1}"
                                headerstyle-width="30%" Visible="false" />

                            <telerik:GridTemplateColumn
                                UniqueName="spaceName"
                                HeaderText="Name"
                                SortExpression="spaceName"
                                Headerstyle-Width="30%">
                                <ItemTemplate>
                                    <asp:Image ID="Image1" runat="server"
                                        ToolTip="This Build Element is locked"
                                        Visible='<%# Convert.ToBoolean(eval("isLocked")) %>' src="/images/lck.gif" />

                                    <a href="build_element_details.aspx?pid=<%#Eval("projectId")%>&rid=<%#Eval("id")%>"><%#Eval("spaceName")%></a>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            
                            <telerik:GridBoundColumn
                                UniqueName="spaceType"
                                HeaderText="Type"
                                HeaderStyle-Width="30%"
                                DataField="spaceType" />
                                
                            <telerik:GridBoundColumn
                                UniqueName="projectStatusId"
                                Visible="false"
                                DataField="projectStatusId" />
                           
                            <telerik:GridBoundColumn
                                UniqueName="spaceTypeId"
                                Visible="false"
                                DataField="spaceTypeId" />
                                    
                                <telerik:GridBoundColumn
                                UniqueName="subcontractType"
                                HeaderText="Sundry Items"
                                HeaderStyle-Width="15%"
                                HeaderStyle-HorizontalAlign="Center"
                                ItemStyle-HorizontalAlign="Center"
                                DataField="subcontractType" />
                                    
                                <telerik:GridBoundColumn
                                UniqueName="isLocked"
                                HeaderText="isLocked"
                                Visible="false"
                                DataField="isLocked" />
                
                            <telerik:GridNumericColumn
                                UniqueName="buildCost"
                                HeaderText="Build Cost"
                                DataField="buildCost"
                                HeaderStyle-Width="15%"
                                DataFormatString="{0:C}"
                                HeaderStyle-HorizontalAlign="Right"
                                ItemStyle-HorizontalAlign="Right" />
                                
                            <telerik:GridButtonColumn
                                ConfirmText="Delete this Build Element?"
                                ConfirmTitle="Delete"
                                ButtonType="ImageButton"
                                CommandName="Delete"
                                HeaderStyle-Width="5%"
                                Text="Delete"
                                UniqueName="DeleteColumn" />
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </div>
        </asp:Panel>

    </div>

    </div>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="Project_Select" SelectCommandType="StoredProcedure"
        UpdateCommand="updateProjectDetails" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="UserId" SessionField="UserId" />
            <asp:QueryStringParameter Name="projectId" QueryStringField="pid" />
        </SelectParameters>
        <UpdateParameters>
            <asp:SessionParameter Name="UserId" SessionField="UserId" />
            <asp:SessionParameter Name="modified_by" SessionField="UserId" />
            <asp:ControlParameter Name="OldStatusId" ControlID="ctl00$MainContent$FormView1$hiddenStatusId" PropertyName="value" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="projectCostDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>" 
        SelectCommand="getProjectCosts" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="UserId" SessionField="UserId" />
            <asp:QueryStringParameter Name="pid" QueryStringField="pid" />
        </SelectParameters>
    </asp:SqlDataSource>
    
    <asp:SqlDataSource ID="projectTimesDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>" 
        SelectCommand="getProjectCompletionPercentage"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="UserId" SessionField="UserId" />
            <asp:QueryStringParameter Name="pid" QueryStringField="pid" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="customerDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="getUserContactsByUser" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="UserId" SessionField="UserId" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="retentionTypeDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="getProjectRetentionType" SelectCommandType="StoredProcedure" />

    <asp:SqlDataSource ID="statusDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="getProjectStatusByProject" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter Name="projectId" QueryStringField="pid" />
        </SelectParameters>        
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="tenderTypeDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="getProjectTenderTypes" SelectCommandType="StoredProcedure" />

    <asp:SqlDataSource ID="projectTypeDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="getProjectType" SelectCommandType="StoredProcedure" />
        
    <asp:SqlDataSource
        ID="AllSpacesDataSource"
        runat="server"
        ConflictDetection="OverwriteChanges"
        OldValuesParameterFormatString="original_{0}"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        InsertCommand="insertBuildElement" InsertCommandType="StoredProcedure"
        SelectCommand="getBuildElementsByProjectAndUser" SelectCommandType="StoredProcedure"
        DeleteCommand="deleteBuildElementById" DeleteCommandType="StoredProcedure">
        <InsertParameters>
            <asp:QueryStringParameter Name="projectId" QueryStringField="pid" />
            <asp:Parameter Name="buildElementTypeId" Type="Int32" DefaultValue="7" />
            <asp:Parameter Name="spaceName" Type="String" />
            <asp:Parameter Name="spacePrice" DefaultValue="0" />
            <asp:Parameter Name="subcontractPercent" DefaultValue="0" />
            <asp:Parameter Name="completion" Type="Int16" DefaultValue="0" />
            <asp:Parameter Name="NewId" Type="Int64" Direction="Output" />
        </InsertParameters>
        <SelectParameters>
            <asp:SessionParameter Name="userID" SessionField="UserId" />
            <asp:QueryStringParameter Name="projectId" QueryStringField="pid" />
        </SelectParameters>
        <DeleteParameters>
            <asp:SessionParameter Name="userID" SessionField="UserId" />
            <asp:QueryStringParameter Name="projectId" QueryStringField="pid" />
            <asp:Parameter Name="original_id" Type="Int64" />
        </DeleteParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="spaceTypeDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="getBuildElementTypesByProject" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter Name="projectId" QueryStringField="pid" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="subcontractTypesDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="getBuildElementSundryItems">
    </asp:SqlDataSource>
</asp:Content>