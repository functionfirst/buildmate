<%@ Page Title="Task Details - BuildMate" Language="VB" MasterPageFile="~/common/Manager.master" AutoEventWireup="false" CodeFile="task_details.aspx.vb" Inherits="manager_task_details" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="~/controls/myCheckBox.ascx" TagName="myCheckbox" TagPrefix="myChk" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<script type="text/javascript">
    function validateModal() {
        if (typeof (Page_ClientValidate) == 'function') {
            Page_ClientValidate();
        }

        if (Page_IsValid) {
            // close modal
            $(".modal-window").animate({ "top": "-50%" }, function() {
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
            <telerik:AjaxSetting AjaxControlId="lbRefreshResources">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="fvTaskTotals" />
                     <telerik:AjaxUpdatedControl ControlID="rgResources" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlId="rmpResources">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="rmpResources" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlId="fvDefaultResources">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="fvDefaultResources" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlId="fvAddAdhoc">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="rgAdditions" />
                     <telerik:AjaxUpdatedControl ControlID="fvAddAdhoc" />
                     <telerik:AjaxUpdatedControl ControlID="fvTaskTotals" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlId="rgResources">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="fvTaskAdjustments" />
                     <telerik:AjaxUpdatedControl ControlID="fvTaskTotals" />
                     <telerik:AjaxUpdatedControl ControlID="rgResources" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlId="fvTaskAdjustments">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="fvTaskTotals" />
                     <telerik:AjaxUpdatedControl ControlID="pCurrentResources" />
                     <telerik:AjaxUpdatedControl ControlID="pRequiresTaskQty" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlId="Panel1">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="Panel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlId="btnAddResources">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="rgResources" />
                     <telerik:AjaxUpdatedControl ControlID="fvTaskTotals" />
                     <telerik:AjaxUpdatedControl ControlID="fvTaskAdjustments" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlId="btnUpdateQty">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="fvTaskAdjustments" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlId="btnAdd">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="btnAdd" />
                    <telerik:AjaxUpdatedControl ControlID="fvAddCalc" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlId="btnCancel">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="btnAdd" />
                    <telerik:AjaxUpdatedControl ControlID="fvAddCalc" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlId="fvAddCalc">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgCalculator" />
                    <telerik:AjaxUpdatedControl ControlID="btnAdd" />
                    <telerik:AjaxUpdatedControl ControlID="qtyTotal" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlId="rgCalculator">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="qtyTotal" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlId="rgAdditions">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="fvTaskTotals" />
                     <telerik:AjaxUpdatedControl ControlID="rgAdditions" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlId="rcbResources">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="lblUnitName" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlId="fvCompletion">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="fvCompletion" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    
    <!-- add resources modal -->
    <div id="addResources" class="modal-window">
        <h3><a href="#" class="close">&times;</a> Add a Resource</h3>

        <div class="boxcontent">
            <asp:Panel ID="Panel1" runat="server" DefaultButton="btnAddResources">
    
            <div class="row">
                <asp:Label ID="Label10" runat="server"
                    Text="Type:"
                    CssClass="label"
                    AssociatedControlID="rblResourceType" />
            
                <asp:RadioButtonList ID="rblResourceType" runat="server"
                    AutoPostBack="true"
                    RepeatDirection="Horizontal">
                    <asp:ListItem Value="1" Text="Labour" Selected="True" />
                    <asp:ListItem Value="2" Text="Material" />
                    <asp:ListItem Value="3" Text="Plant &amp; Equipment" />
                </asp:RadioButtonList>
            </div>

            <div class="row">
                <asp:Label ID="Label9" runat="server"
                    Text="Search in..."
                    CssClass="label"
                    AssociatedControlID="rcbSearchType" />

                <telerik:RadComboBox ID="rcbSearchType" runat="server" 
                    AutoPostBack="true">
                    <Items>
                        <telerik:RadComboBoxItem Value="1" Text="All Resources" />
                        <telerik:RadComboBoxItem Value="2" Text="Current Project" />
                        <telerik:RadComboBoxItem Value="3" Text="All Projects" />
                    </Items>
                </telerik:RadComboBox>
            </div>
            
            <div class="row">
                <asp:Label ID="Label12" runat="server"
                    Text="Resource:"
                    CssClass="label"
                    AssociatedControlID="rcbResources" />
                        <telerik:RadComboBox
                            ID="rcbResources"
                            runat="server"
                            AutoPostBack="true"
                            Width="215px"
                            Height="150px"
                            IsCaseSensitive="false"
                            DropDownWidth="480px"
                            EmptyMessage="contains any of the word(s)"
                            EnableLoadOnDemand="true"
                            ShowMoreResultsBox="true"
                            EnableVirtualScrolling="false"
                            MarkFirstMatch="false"
                            HighlightTemplatedItems="true">
                        <HeaderTemplate>
                            <table border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td style="width: 300px;">
                                        Product Name</td>
                                    <td style="width: 100px;">
                                        Manufacturer</td>
                                    <td style="width: 80px;">
                                        Part ID</td>
                                </tr>
                            </table>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <table border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td style="width: 300px;">
                                        <%# DataBinder.Eval(Container, "Text")%>
                                    </td>
                                    <td style="width: 100px;">
                                        <%#DataBinder.Eval(Container, "Attributes['manufacturer']")%>
                                    </td>
                                    <td style="width: 80px;">
                                        <%#DataBinder.Eval(Container, "Attributes['partId']")%>
                                    </td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </telerik:RadComboBox>
                    x
                    <telerik:RadNumericTextBox
                        ID="rntbQty"
                        runat="server"
                        Value="1"
                        Width="50px"
                        Type="Number"
                        MinValue="1"
                        NumberFormat-DecimalDigits="0" />
            </div>

            <div class="row">
                        
                <asp:Label ID="Label14" runat="server"
                    Text="Usage:"
                    CssClass="label"
                    AssociatedControlID="rntbUses" />
                        <telerik:RadNumericTextBox
                            ID="rntbUses"
                            runat="server"
                            Value="0"
                            Width="60px"
                            Type="Number"
                            MinValue="0"
                            NumberFormat-DecimalDigits="2" />

                    <asp:Literal ID="lblUnitName" runat="server"></asp:Literal>
                </div>
            
            <div class="row">
                <label class="label">&nbsp;</label>
                    <asp:Button ID="btnAddResources" runat="server" Text="Add Resource" />
            </div>
        </asp:Panel>
        </div>
    </div>
    
    <!-- add adhoc modal -->
    <div id="addAddition" class="modal-window">
        <h3><a href="#" class="close">&times;</a> Add an Addition</h3>
        
        <div class="boxcontent">
            <asp:FormView ID="fvAddAdhoc" runat="server"
                DefaultMode="Insert"
                DataSourceID="additionsDataSource"
                Width="100%"
                DataKeyNames="id">
                <InsertItemTemplate>
                    <div class="row">
                        <asp:Label
                            ID="Label13"
                            runat="server"
                            CssClass="label"
                            AssociatedControlID="rtbDescription"
                            Text="Description" />

                        <telerik:RadTextBox
                            ID="rtbDescription"
                            runat="server"
                            TextMode="MultiLine"
                            Columns="40"
                            Height="50px"
                            Text='<%#Bind("description") %>'
                            MaxLength="255" />
                        
                        <asp:RequiredFieldValidator
                            ID="RequiredFieldValidator1"
                            runat="server"
                            ControlToValidate="rtbDescription"
                            ErrorMessage="Descripion"
                            ValidationGroup="insertAdditionValidation">
                            <span class="req"></span>
                        </asp:RequiredFieldValidator>
                    </div>

                    <div class="row">
                        <asp:Label
                            ID="Label15"
                            runat="server"
                            CssClass="label"
                            AssociatedControlID="rntbCost"
                            Text="Cost" />

                        <telerik:RadNumericTextBox
                            ID="rntbCost"
                            runat="server"
                            EmptyMessage="£0.00"
                            Width="80px"
                            Value='<%#Bind("price") %>'
                            Type="Currency"
                            NumberFormat-DecimalDigits="2" />
                        
                        <asp:RequiredFieldValidator
                            ID="RequiredFieldValidator2"
                            runat="server"
                            ControlToValidate="rntbCost"
                            ErrorMessage="Cost"
                            ValidationGroup="insertAdditionValidation">
                            <span class="req"></span>
                        </asp:RequiredFieldValidator>
                    </div>
                    
                    <div class="row">
                        <asp:Label
                            ID="Label16"
                            runat="server"
                            CssClass="label"
                            AssociatedControlID="rntbPercentage"
                            Text="Adjustment (%)" />

                        <telerik:RadNumericTextBox
                            ID="rntbPercentage"
                            runat="server"
                            EmptyMessage="0 %"
                            MinValue="0"
                            MaxValue="100"
                            Width="60px"
                            Value='<%#Bind("percentage") %>'
                            Type="Percent" />
                    </div>
                    
                    <div class="row">
                        <asp:Label
                            ID="Label17"
                            runat="server"
                            CssClass="label"
                            AssociatedControlID="rcbType"
                            Text="Cost Modifier" />

                        <telerik:RadComboBox
                            ID="rcbType"
                            runat="server"
                            DataSourceID="adhocTypeDataSource"
                            SelectedValue='<%#Bind("adhocTypeId") %>'
                            DataTextField="type"
                            DataValueField="id"  />
                    </div>
                    
                     <div class="row">
                        <label class="label">&nbsp;</label>
                        <asp:Button
                            ID="btnInsert"
                            runat="server"
                            CausesValidation="True" 
                            CommandName="Insert"
                            ValidationGroup="insertAdditionValidation"
                            OnClientClick="validateModal()"
                            Text="Add Addition" />
                    </div>
                </InsertItemTemplate>
            </asp:FormView>
        </div>
    </div>
    
    
    <!-- calculator modal -->
    <div id="calculator" class="modal-window">
        <h3><a href="#" class="close">&times;</a> Calculator</h3>

        <asp:HiddenField ID="qtyTotal" runat="server" />
    
        <div class="boxcontent">
            <p class="rightalign">
                <asp:LinkButton ID="btnAdd" runat="server" CssClass="button">
                    Add a dimension
                </asp:LinkButton>
            </p>
                
            <asp:FormView ID="fvAddCalc" runat="server"
                Width="100%"
                Visible="false"
                DefaultMode="Insert"
                EnableViewState="false"
                DataSourceId="calcDataSource">
                <InsertItemTemplate>
                    <fieldset>
                        <legend title="Add a Dimension">Add a Dimension</legend>

                        <div class="row">
                            <asp:Label ID="Label4" runat="server" 
                                CssClass="label"
                                AssociatedControlID="rtbComment"
                                Text="Comment" />

                            <telerik:RadTextBox ID="rtbComment" runat="server"
                                Text='<%# Bind("comment") %>'
                                Width="160px" />
                        </div>

                        <div class="row">
                            <asp:Label ID="Label1" runat="server"
                                CssClass="label"
                                AssociatedControlID="rntbLength"
                                Text="Dimensions" />
                                
                            <telerik:RadNumericTextBox ID="rntbLength" runat="server"
                                Type="Number"
                                NumberFormat-DecimalDigits="2"
                                Text='<%#Bind("length") %>'
                                Value='1'
                                Width="40px" /> x
                                    
                            <telerik:RadNumericTextBox ID="rntbWidth" runat="server"
                                Type="Number"
                                NumberFormat-DecimalDigits="2"
                                Text='<%#Bind("width") %>'
                                Value='1'
                                Width="40px" /> x
                                    
                            <telerik:RadNumericTextBox ID="rntbHeight" runat="server"
                                Type="Number"
                                NumberFormat-DecimalDigits="2"
                                Text='<%#Bind("height") %>'
                                Value='1'
                                Width="40px" />
                        </div>
                                
                        <div class="row">
                            <asp:Label runat="server" ID="Label3"
                                CssClass="label"
                                AssociatedControlID="rntbMultiplier"
                                Text="Multiplier" />
                                    
                            <telerik:RadNumericTextBox ID="rntbMultiplier" runat="server"
                                Type="Number"
                                NumberFormat-DecimalDigits="2"
                                Text='<%#Bind("multiplier") %>'
                                Value='1'
                                Width="50px" />
                        </div>
                            
                        <div class="row">
                            <asp:Label ID="Label2" runat="server"
                                CssClass="label"
                                AssociatedControlID="chkMyBox"
                                Text="Subtract" />

                            <myChk:myCheckbox ID="chkMyBox" runat="server"
                                Checked='<%# Bind("subtract") %>' />
                        </div>
                            
                        <div class="row">
                            <label class="label">&nbsp;</label>
                                
                            <asp:Button ID="btnUpdate" runat="server"
                                CommandName="Insert"
                                Text='Insert' />
                                
                            <asp:LinkButton ID="btnCancel" runat="server"
                                CausesValidation="false"
                                OnClick="btnCancel_Click"
                                Text="Cancel" />
                        </div>
                    </fieldset>
                </InsertItemTemplate>
            </asp:FormView>
        

            <telerik:RadGrid ID="rgCalculator" runat="server"
                width="100%"
                DataSourceID="calcDataSource"
                GridLines="None"
                ShowStatusBar="true"
                ShowFooter="true"
                AutoGenerateColumns="False"
                AllowAutomaticInserts="True"
                AllowAutomaticDeletes="True"
                AllowAutomaticUpdates="True">
                <MasterTableView
                    AutoGenerateColumns="False"
                    DataKeyNames="id"
                    AllowAutomaticDeletes="true"
                    AllowAutomaticUpdates="true"
                    NoMasterRecordsText="&nbsp;No dimensions were found."
                    EditMode="EditForms"
                    DataSourceID="calcDataSource"
                    InsertItemDisplay="Bottom">
                    <Columns>
                        <telerik:GridBoundColumn
                            UniqueName="dimensions"
                            HeaderText="Dimensions"
                            HeaderStyle-width="30%"
                            DataField="dimensions" />

                        <telerik:GridBoundColumn
                            UniqueName="multiplier"
                            HeaderText="Multiplier"
                            HeaderStyle-Width="10%"
                            HeaderStyle-HorizontalAlign="Center"
                            ItemStyle-HorizontalAlign="Center"
                            DataField="multiplier" />

                        <telerik:GridBoundColumn
                            UniqueName="total" 
                            HeaderText="Total"
                            HeaderStyle-Width="15%"
                            DataFormatString="{0:N2}"
                            HeaderStyle-HorizontalAlign="Center"
                            ItemStyle-HorizontalAlign="Center"
                            DataField="total" />

                        <telerik:GridBoundColumn
                            UniqueName="comment"
                            HeaderText="Comment"
                            HeaderStyle-Width="30%"
                            DataField="comment" />
                            
                        <telerik:GridEditCommandColumn
                            UniqueName="EditCommandColumn"
                            ButtonType="ImageButton" />

                        <telerik:GridButtonColumn
                            ConfirmText="Delete this item?"
                            ConfirmTitle="Delete"
                            ButtonType="ImageButton"
                            CommandName="Delete"
                            Text="Delete"
                            UniqueName="DeleteColumn" />
                        
                    </Columns>
                    <EditFormSettings EditFormType="Template">
                        <FormTemplate>
                            <h3>Editing a Dimension</h3>
                                
                            <div class="row">
                                <asp:Label CssClass="label" ID="Label4" AssociatedControlID="rntbMultiplier" runat="server" Text="Comment" />
                                <telerik:RadTextBox ID="rtbComment" runat="server"
                                    Text='<%# Bind("comment") %>' Width="160px" />
                            </div>
                            
                            <div class="row">
                                <asp:Label CssClass="label" ID="Label1" AssociatedControlID="rntbLength" runat="server" Text="Dimensions" />
                                    
                                <telerik:RadNumericTextBox ID="rntbLength" runat="server"
                                    dbValue='<%# Bind("length") %>' Width="40px" /> x
                                <telerik:RadNumericTextBox ID="rntbWidth" runat="server"
                                    dbValue='<%# Bind("width") %>' Width="40px" /> x
                                <telerik:RadNumericTextBox ID="rntbHeight" runat="server"
                                    dbValue='<%# Bind("height") %>' Width="40px" />
                            </div>
                                
                            <div class="row">
                                <asp:Label CssClass="label" ID="Label3" AssociatedControlID="rntbMultiplier" runat="server" Text="Multiplier" />
                                <telerik:RadNumericTextBox ID="rntbMultiplier" runat="server"
                                    NumberFormat-DecimalDigits="2" Width="50px"
                                    Type="Number" dbValue='<%# Bind("multiplier") %>' />
                            </div>
                                
                            <div class="row">
                                <asp:Label CssClass="label" ID="Label2" AssociatedControlID="chkMyBox" runat="server" Text="Subtract" />
                                <myChk:myCheckbox ID="chkMyBox" runat="server"
                                            Checked='<%# Bind("subtract") %>' />
                            </div>
                                
                            <div class="row">
                                <label class="label">&nbsp;</label>
                                <asp:Button ID="btnUpdate" runat="server"
                                    CommandName='<%# IIf((TypeOf(Container) is GridEditFormInsertItem), "PerformInsert", "Update")%>'
                                    Text='<%#IIf((TypeOf (Container) Is GridEditFormInsertItem), "Insert", "Update")%>' />
                                    
                                <asp:LinkButton ID="btnCancel" runat="server"
                                    CausesValidation="false"
                                    CommandName="Cancel"
                                    Text="Cancel" />
                            </div>
                        </FormTemplate>
                    </EditFormSettings>
                </MasterTableView>
            </telerik:RadGrid>

            <p runat="server" id="showupdate" class="rightalign">
                <asp:Button ID="btnUpdateQty" runat="server"
                    OnClientClick="closeModal()"
                    Text="Use this Total as the Task Quantity" />
            </p>
        </div>
    </div>
    
    <!-- modal wrapper -->
    <div class="modal-wrapper" title="Click here or press Esc to cancel"></div>

        <div class="breadcrumb">
            <p>
                &lArr;
                <asp:HyperLink ID="hlBack" runat="server"
                    NavigateUrl="project_details.aspx?pid={0}"
                    Text="Project Details" />
            </p>
        </div>

        <div class="breadcrumb">
            <p>
                &lArr;
                <asp:HyperLink ID="hlBack2" runat="server"
                    NavigateUrl="build_element_details.aspx?pid={0}&rid={1}"
                    Text="Build Element Details" />
            </p>
        </div>

    <!-- task details -->
    <div class="div33">
        <div class="box_total">
            <h3>Task Break-down</h3>
                    
            <div class="boxcontent">
                    
    <asp:FormView
        ID="fvTaskTotals"
        runat="server" Width="100%"
        DataSourceID="taskTotalsDataSource">
        <ItemTemplate>
                    <div class="row">
                        <label title="Labour Cost" class="label">Labour Cost</label>
                        <div class="rightalign">
                            <asp:Label ID="lblLabourCost" runat="server"
                                Text='<%#Bind("labourCost", "{0:C}") %>' />
                        </div>
                    </div>

                    <div class="row">
                        <label title="Material Cost" class="label">Material Cost</label>
                        <div class="rightalign">
                            <asp:Label ID="lblMaterialCost" runat="server"
                                Text='<%#Bind("materialCost", "{0:C}") %>' />
                        </div>
                    </div>
                    
                    <div class="row">
                        <label title="Plant &amp; Equipment Cost" class="label">Plant &amp; Equipment Cost</label>
                        
                        <div class="rightalign">
                            <asp:Label ID="lblPlantCost" runat="server"
                                Text='<%#Bind("plantCost", "{0:C}") %>' />
                        </div>
                    </div>
                    
                    <div class="row">
                        <label title="Ad-hoc Cost" class="label">Ad-hoc Cost</label>
                        <div class="rightalign">
                            <asp:Label ID="lblAdhocCost" runat="server"
                                Text='<%#Bind("adHocCost", "{0:C}") %>' />
                        </div>
                    </div>

                    <hr />
                    
                    <div class="row">
                        <label title="Task Total" class="label">Task Total</label>
                        <div class="rightalign">
                            <asp:Label ID="lblTotalCost" runat="server"
                                Text='<%#Bind("total", "{0:C}") %>' />
                        </div>
                    </div>
        </ItemTemplate>
    </asp:FormView>
                </div>
            </div>

    <div class="box">
            <h3>Ad-hoc Additions</h3>
            
            <div class="boxcontent">
                <asp:Panel ID="pAddAdditions" runat="server" CssClass="rightalign" style="margin-bottom: 10px">
                    <a href="#" rel="addAddition" class="open_modal button create">+ Add an Addition</a>
                </asp:Panel>

                <telerik:RadGrid ID="rgAdditions" runat="server"
                    CssClass="clear"
                    DataSourceID="additionsDataSource"
                    GridLines="None"
                    AllowSorting="true"
                    AllowAutomaticDeletes="True"
                    AllowAutomaticUpdates="True">
                    <MasterTableView
                        AutoGenerateColumns="False"
                        CellSpacing="-1"
                        DataKeyNames="id"
                        ShowFooter="true"
                        AllowAutomaticUpdates="True"
                        DataSourceID="additionsDataSource"
                        NoMasterRecordsText="&nbsp;No Ad-Hoc Items were found."
                        EditMode="EditForms">
                        <RowIndicatorColumn>
                            <HeaderStyle Width="20px"></HeaderStyle>
                        </RowIndicatorColumn>
            <ExpandCollapseColumn>
                <HeaderStyle Width="20px"></HeaderStyle>
            </ExpandCollapseColumn>
            <Columns>
                <telerik:GridTemplateColumn
                    HeaderText="Description"
                    SortExpression="description"
                    HeaderStyle-Width="75%"
                    UniqueName="description">
                    <ItemTemplate>
                        <asp:LinkButton ID="lbEdit" runat="server"
                            CommandName="Edit"
                            Text='<%#Eval("description")%>' />
                    </ItemTemplate>    
                </telerik:GridTemplateColumn>

                <telerik:GridBoundColumn
                    UniqueName="description"
                    SortExpression="description"
                    HeaderText="Description"
                    HeaderStyle-Width="75%"
                    DataField="description" />
                    
                    <telerik:GridBoundColumn
                        DataField="total"
                        DataType="System.Decimal"
                        DataFormatString="{0:C2}"
                        HeaderText="Total"
                        SortExpression="total"
                        UniqueName="total"
                        HeaderStyle-Width="20%"
                        HeaderStyle-HorizontalAlign="Right"
                        ItemStyle-HorizontalAlign="Right" />

                     <telerik:GridButtonColumn
                        ConfirmText="Delete this item?"
                        ConfirmTitle="Delete"
                        ButtonType="ImageButton"
                        CommandName="Delete"
                        Text="Delete"
                        HeaderStyle-Width="5%"
                        UniqueName="DeleteColumn" />
            </Columns>
            <EditFormSettings EditFormType="Template">
                <FormTemplate>
                    <div style="padding: 5px">
                    <asp:HiddenField ID="hiddenId" runat="server" Value='<%#Bind("id") %>' />
                        <div class="row">
                            <asp:Label ID="lblrtbDescription" runat="server"
                                Text="Description"
                                AssociatedControlID="rtbDescription"
                                CssClass="label" />

                            <telerik:RadTextBox ID="rtbDescription" runat="server"
                                TextMode="MultiLine"
                                width="130px"
                                Height="50px"
                                MaxLength="255"
                                Text='<%#Bind("description") %>' />
                        </div>
                        
                        <div class="row">
                            <asp:Label ID="lblrntbCost" runat="server"
                                Text="Cost"
                                AssociatedControlID="rntbCost"
                                CssClass="label" />
                                
                            <telerik:RadNumericTextBox ID="rntbCost" runat="server"
                                EmptyMessage="£0.00"
                                Width="70px"
                                Value='<%#Bind("price", "{0:C2}") %>'
                                Type="Currency"
                                NumberFormat-DecimalDigits="2" />
                        </div>
                            
                        <div class="row">
                            <asp:Label ID="lblrntbPercentage" runat="server"
                                Text="Adjustment"
                                AssociatedControlID="rntbPercentage"
                                CssClass="label" />
                            
                            <telerik:RadNumericTextBox ID="rntbPercentage" runat="server"
                                EmptyMessage="0 %"
                                MinValue="0"
                                MaxValue="100"
                                Width="80px"
                                Value='<%#Bind("percentage", "{0:0}") %>'
                                Type="Percent" />
                        </div> 
                        
                        <div class="row">
                            <asp:Label ID="lblrcbType" runat="server"
                                Text="Cost Modifier"
                                AssociatedControlID="rcbType"
                                CssClass="label" />
                            <telerik:RadComboBox ID="rcbType" runat="server"
                                DataSourceID="adhocTypeDataSource"
                                Width="130px"
                                SelectedValue='<%#Bind("adhocTypeId") %>'
                                DataTextField="type" DataValueField="id"  />
                        </div>              

                        <div class="row">
                                
                            <asp:Button ID="btnUpdate" runat="server"
                                Text="Update"
                                CommandName="Update" />
                            <asp:LinkButton ID="btnCancel" runat="server"
                                Text="Cancel"
                                CausesValidation="false"
                                CommandName="Cancel" />
                        </div>
                    </div>
                </FormTemplate>
            </EditFormSettings>
        </MasterTableView>
    </telerik:RadGrid>
                
                  
            </div>
        </div>
    </div>


    <div class="div66r">
    
    <div class="box">
        <h3>Task Details</h3>
        <div id="editMode" class="box_top_edit" runat="server" visible="false"><span>Editing Task Details...</span></div>
        
        <div id="errorbox" runat="server" visible="false" class="box_error">
            <span>The following required fields are missing:
                <asp:ValidationSummary ID="ValidationSummary2" runat="server"
                    ForeColor="#ffffff"
                    ValidationGroup="editGroup" />
            </span>
        </div>

        <div class="boxcontent">
            <asp:FormView
                ID="fvTaskAdjustments"
                runat="server"
                DataKeyNames="id"
                Width="100%"
                DataSourceID="taskDataSource">
                <ItemTemplate>
                    <div class="row">
                        <label title="Description" class="label">Description</label>
                        <span style="display: table-cell"><%#Eval("taskName")%></span>
                    </div>

                    <div class="row">
                        <label title="Note" class="label">Note</label>
                        <span style="display: table-cell; color: #900; font-weight: bold"><%#Eval("note")%>&nbsp;</span>
                    </div>

                        <div class="row">
                            <label title="Build Phase" class="label">Build Phase</label>
                            <%#Eval("buildPhase")%>
                        </div>

                        <div class="row">
                            <label title="Quantity" class="label">Quantity</label>
                            <asp:Label ID="Label3" runat="server" Text='<%# Eval("qty") & " " & Eval("unit") %>' />
                        </div>
                    
                        <div class="row">
                            <label title="Task Time" class="label">Task Time</label>
                            <asp:Label ID="Label4" runat="server" Text='<%# Eval("minutes") & " minutes per " & Eval("unit") %>' />
                        </div>
                        
                        <div class="row">
                            <label title="Estimated Time" class="label">Estimated Time</label>
                            <asp:Label ID="Label6" runat="server" Text='<%# Eval("labourTime", "{0:N2}") & " minutes" %>' />
                        </div>

                        <div class="row">
                            <label title="Total Duration" class="label">Total Duration</label>
                            <asp:Label ID="minutesLabel" runat="server" Text='<%# Eval("totalTime", "{0:N0}") & " minutes" %>' />
                        </div>

                        <div class="row">
                            <label class="label">&nbsp;</label>
                            <asp:Button
                                ID="btnEdit"
                                runat="server"
                                Enabled='<%#iif(Eval("isLocked"), "false", "true") %>'
                                Text="Edit Task Details"
                                CommandName="Edit" />
                        </div>
                </ItemTemplate>
                <EditItemTemplate>
                    
                    <div class="row">
                        <label title="Description" class="label">Description</label>
                        <span style="display: table-cell"><%#Eval("taskName")%></span>
                    </div>
                    
                    <div class="row">
                        <label for="lblProjectNotes" title="Note" class="label">Note</label>
                        <telerik:RadTextBox ID="rtbProjectNotes" runat="server"
                            TextMode="MultiLine" Columns="60" Rows="3"
                            Text='<%# Bind("note") %>' />
                    </div>

                        <div class="row">
                            <asp:Label ID="Label5" runat="server"
                                AssociatedControlID="rcbBuildPhaseId"
                                Text="Build Phase"
                                CssClass="label" />
                                
                            <telerik:RadComboBox ID="rcbBuildPhaseId" runat="server"
                                Height="200px"
                                SelectedValue='<%# Bind("buildPhaseId")%>'
                                DataSourceID="buildPhaseDataSource"
                                DataTextField="buildPhase"
                                DataValueField="id" />
                        </div>

                        <div class="row">
                            <asp:Label ID="Label11" runat="server"
                                CssClass="label"
                                Text="Quantity"
                                AssociatedControlID="rntbQuantity" />

                            <telerik:RadNumericTextBox
                                ID="rntbQuantity"
                                runat="server"
                                NumberFormat-DecimalDigits="2"
                                Text='<%# Bind("qty") %>'
                                Value="0"
                                IncrementSettings-Step="1"
                                Type="Number"
                                Width="40px" />

                            <asp:Label
                                ID="Label2"
                                runat="server"
                                Text='<%# Eval("unit") %>' />
                            
                            <asp:RequiredFieldValidator
                                ID="RequiredFieldValidator1"
                                runat="server"
                                ControlToValidate="rntbQuantity"
                                Display="Dynamic"
                                ErrorMessage="Quantity"
                                ValidationGroup="editGroup">
                                <span class="req"></span>
                            </asp:RequiredFieldValidator>
                            
                            <a href="#" rel="calculator" class="open_modal calc-open" title="Open Calculator">Calculator</a>
                        </div>
                    
                        <div class="row">
                            <label title="Task Time" class="label">Task Time</label>
                            <asp:Label ID="taskTimeLabel" runat="server" Text='<%# Eval("minutes") & " minutes per " & Eval("unit") %>' />
                        </div>
                        
                        <div class="row">
                            <label title="Estimated Time" class="label">Estimated Time</label>
                            <asp:Label ID="Label6" runat="server" Text='<%# Eval("labourTime", "{0:N2}") & " minutes" %>' />
                        </div>

                        <div class="row">
                            <label title="Total Time" class="label">Total Duration</label>
                            <asp:Label ID="minutesLabel" runat="server" Text='<%# Eval("totalTime", "{0:N0}") & " minutes" %>' />
                        </div>
    
                        <div class="row">
                            <label class="label">&nbsp;</label>

                            <asp:Button ID="UpdateButton" runat="server"
                                CommandName="Update"
                                CausesValidation="true"
                                OnClick="Validate_Edit"
                                ValidationGroup="editGroup"
                                Text="Update" />
 
                            <asp:LinkButton ID="btnCancel" runat="server"
                                CommandName="Cancel"
                                CausesValidation="false"
                                Text="Cancel" />
                        </div>
                    </fieldset>
                </EditItemTemplate>
            </asp:FormView>

            <asp:FormView
                ID="fvCompletion"
                runat="server"
                DataSourceID="completionDataSource"
                DataKeyNames="id"
                Width="100%">
                <EditItemTemplate>
                    <div class="row">
                        <asp:Label ID="Label7" runat="server"
                            AssociatedControlID="rntbActualMinutes"
                            Text="Actual Time"
                            CssClass="label" />
                                
                        <telerik:RadNumericTextBox ID="rntbActualMinutes" runat="server"
                            ShowSpinButton="true"
                            NumberFormat-DecimalDigits="0"
                            Text='<%# Bind("actualMinutes") %>'
                            IncrementSettings-Step="1"
                            Type="Number"
                            MinValue="0"
                            Width="40px" />
                        minutes
                    </div>
            
                    <div class="row">
                        <label class="label">Completion</label>

                        <div style="margin-left: 110px">
                        <table border="0" cellspacing="0">
                            <colgroup>
                                <col />
                                <col width="30" />
                            </colgroup>
                            <tr>
                                <td>
                            <telerik:RadSlider
                                ID="RadSlider1"
                                runat="server"
                                Value='<%#Bind("percentComplete") %>'
                                MinValue="0"
                                MaxValue="100"
                                Width="240px"
                                OnClientValueChanged="HandleValueChanged"
                                OnClientLoad="HandleValueChanged"
                                AnimationDuration="300"
                                ThumbsInteractionMode="Free" />
                            </td>
                                <td>
                                    <input type="text" style="width: 30px;" id="sliderValue" disabled="disabled" />
                                </td>
                            </tr>
                           </table>
                        </div>
                    </div>

                    <div class="row">
                        <label class="label">&nbsp;</label>

                        <asp:Button
                            ID="btnUpdate"
                            runat="server"
                            CommandName="Update"
                            Text="Save Completion" />

                        <asp:LinkButton
                            ID="btnCancel"
                            runat="server"
                            CausesValidation="false"
                            CommandName="Cancel"
                            Text="Cancel" />
                    </div>
                </EditItemTemplate>
                <ItemTemplate>
                    <div class="row">
                        <label title="Actual Time" class="label">Actual Time</label>
                        <%#Eval("actualMinutes") & " minutes"%>
                    </div>

                    <div class="row">
                        <label class="label">Completion</label>


                        <div style="margin-left: 110px">
                        <table border="0" cellspacing="0">
                            <colgroup>
                                <col />
                                <col width="30" />
                            </colgroup>
                            <tr>
                                <td>
                            <telerik:RadSlider
                                ID="RadSlider1"
                                runat="server"
                                Value='<%#Bind("percentComplete") %>'
                                MinValue="0"
                                Enabled="false"
                                MaxValue="100"
                                Width="240px"
                                AnimationDuration="300"
                                ThumbsInteractionMode="Free" />
                            </td>
                                <td>
                                <asp:TextBox
                                    ID="TextBox1"
                                    runat="server"
                                    Style="width: 30px"
                                    Text='<%#Eval("percentComplete", "{0}%") %>'
                                    Enabled="false" />
                                </td>
                                <td>
                                </td>
                            </tr>
                        </table>
                    </div>
                    </div>
                
                    <div class="row">
                        <label class="label">&nbsp;</label>
                    
                        <asp:Button
                            ID="btnEdit"
                            runat="server"
                            CommandName="Edit"
                            Text="Edit Completion" />
                    </div>

                    <script type="text/javascript">
                        function HandleValueChanged(sender, eventArgs) {
                            $get("sliderValue").value = sender.get_value() + "%";
                        }
                    </script>
                </ItemTemplate>
            </asp:FormView>
        </div>
    </div>
    
      <asp:Panel ID="pRequiresTaskQty" runat="server" Visible="false" CssClass="box_info">
            <div class="box_content">
                <p>
                    <strong>Task Quantity is required</strong><br />
                    You must enter a Task quantity before adding Resources to this Task. Click <strong>Edit Task Details</strong> above to begin.
                </p>
            </div>
        </asp:Panel>
        
        <asp:Panel ID="pCurrentResources" runat="server" CssClass="box">
            <h3>Current Resources</h3>
        <div class="boxcontent">

        <div class="div50">
            <asp:FormView
                ID="fvDefaultResources"
                DefaultMode="Edit"
                runat="server"
                DataKeyNames="id"
                Width="100%"
                DataSourceID="taskDataSource">
                <EditItemTemplate>
                    <asp:CheckBox ID="CheckBox1" runat="server" 
                        AutoPostBack="true"
                        OnCheckedChanged="setDefaultResources"
                        Text="Set as default Task Resources"
                        Visible='<%# IIF(Eval("isDefaultResource"), "False", "True") %>' />

                        
                    <asp:CheckBox ID="CheckBox2" runat="server" 
                        AutoPostBack="true"
                        OnCheckedChanged="setDefaultResources"
                        Text="Current default Task Resources"
                        Enabled="false"
                        Visible='<%# IIF(Eval("isDefaultResource"), "True", "False") %>'
                        Checked='True' />
                </EditItemTemplate>
            </asp:FormView>
            </div>

            <div class="div50r rightalign" style="margin-bottom: 10px">
                <asp:HyperLink ID="hlAddResources" runat="server"
                    rel="addResources"
                    CssClass="open_modal button create"
                    Text="+ Add a Resource" />
            </div>

            <div class="clear"></div>

            <asp:HiddenField ID="resourcePrice" runat="server" />
                    
            <telerik:RadGrid ID="rgResources" runat="server"
                AutoGenerateColumns="False"
                AllowSorting="true"
                AllowAutomaticDeletes="true"
                AllowAutomaticUpdates="true"
                DataSourceID="resourceDataSource"
                ShowFooter="true"
                GridLines="None">
                <MasterTableView
                    DataKeyNames="id"
                    ShowFooter="true"
                    DataSourceID="resourceDataSource"
                    EditMode="EditForms"
                    NoMasterRecordsText="&nbsp;No resources were found.">
                        <RowIndicatorColumn>
                            <HeaderStyle Width="20px" />
                        </RowIndicatorColumn>
                        <ExpandCollapseColumn>
                            <HeaderStyle Width="20px" />
                        </ExpandCollapseColumn>
                        <Columns>
                            <telerik:GridTemplateColumn
                                HeaderText="Resource"
                                SortExpression="resourceName"
                                UniqueName="resourceNameLink">
                                <ItemTemplate>
                                    <%#Eval("Qty")%> x 
                                    <asp:LinkButton ID="lbEdit" runat="server"
                                        CommandName="Edit"
                                        Text='<%#Eval("resourceName")%>' /><br />
                                    
                                    <small style='color: #666'><strong><%#Eval("supplierName")%></strong> - <%#Eval("resourceType")%></small>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn
                                HeaderText="Resource"
                                SortExpression="resourceName"
                                UniqueName="resourceName">
                                <ItemTemplate>
                                    <asp:Image ID="Image1" runat="server" src="/images/lck.gif" title="This Resource is locked" />
                                    <%#Eval("Qty")%> x 
                                    <asp:Literal ID="literalTitle" runat="server"
                                        Text='<%#Eval("resourceName")%>' /><br />
                                    
                                    <small style='color: #666'><strong><%#Eval("supplierName")%></strong> - <%#Eval("resourceType")%></small>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            
                            <telerik:GridTemplateColumn 
                                HeaderText="Useage"
                                SortExpression="uses"
                                UniqueName="uses"
                                HeaderStyle-Width="20%"
                                HeaderStyle-HorizontalAlign="Center"
                                ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                <%#Eval("uses")%>
                                
                                <%#Eval("unit")%>
                                </ItemTemplate>    
                            </telerik:GridTemplateColumn>
                                
                            <telerik:GridNumericColumn
                                NumericType="Percent"
                                DataField="waste"
                                DataType="System.Double"
                                ReadOnly="true"
                                HeaderStyle-HorizontalAlign="Center"
                                ItemStyle-HorizontalAlign="Center"
                                HeaderText="Waste"
                                DataFormatString="{0}%"
                                SortExpression="waste"
                                UniqueName="waste"
                                HeaderStyle-Width="10%" />
                                
                            <telerik:GridNumericColumn
                                NumericType="Currency"
                                DataField="cost"
                                HeaderStyle-HorizontalAlign="Right"
                                ItemStyle-HorizontalAlign="Right"
                                DataType="System.Double"
                                HeaderText="Cost"
                                ReadOnly="true"
                                SortExpression="cost"
                                UniqueName="cost"
                                HeaderStyle-Width="20%"/>
                                
                            <telerik:GridButtonColumn
                                ConfirmText="Delete this resource?"
                                ConfirmTitle="Delete"
                                ButtonType="ImageButton"
                                CommandName="Delete"
                                Text="Delete"
                                UniqueName="DeleteColumn"
                                HeaderStyle-Width="5%" />
                        </Columns>
                        <EditFormSettings EditFormType="Template">
                            <FormTemplate>
                             <div class="row">
                                    <label title="Resource Name" class="label">Resource</label>
                                    <telerik:RadNumericTextBox ID="rntbQuantity" runat="server"
                                        dbvalue='<%# Bind("qty") %>'
                                        NumberFormat-DecimalDigits="0"
                                        Width="50px"
                                        MinValue="1"
                                        Type="Number" /> 
                                    x <%#Eval("resourceName")%>
                                </div>
                                    
                                <div class="div50">
                                   
                                    
                                    <div class="row">
                                        <label title="Useage" class="label">Useage</label>
                                        
                                        <telerik:RadNumericTextBox ID="rntbUses" runat="server"
                                            dbvalue='<%# Bind("uses") %>'
                                            NumberFormat-DecimalDigits="2"
                                            Width="80px"
                                            Type="Number" />
                                            <%#Eval("unit")%>
                                    </div>
                                    
                                    <div class="row">
                                        <label title="Cost" class="label">Cost</label>
                                        <%#Eval("cost", "{0:C}")%>
                                    </div>
                                    
                                    <div class="row">
                                        <label class="label">&nbsp;</label>

                                        <asp:Button ID="btnUpdate" runat="server"
                                            Text="Update"
                                            CommandName="Update" />

                                        <asp:LinkButton ID="btnCancel" runat="server"
                                            Text="Cancel"
                                            CommandName="Cancel" />
                                    </div>
                                    
                                    
                                    </div>
                                    
                                    <div class="div50r">
                                        <div class="row">
                                            <label title="Supplier" class="label">Supplier</label>
                                            <%#Eval("supplierName")%>
                                        </div>

                                        <div class="row">
                                            <label title="Waste Cost" class="label">Waste Cost</label>
                                            <%#Eval("wasteCost", "{0:C}")%> (<%#Eval("waste")%>%)
                                        </div>
                                    </div>
                                    <div class="clear"></div>
                            </FormTemplate>
                        </EditFormSettings>
                    </MasterTableView>
                </telerik:RadGrid>
            </div>
        </asp:Panel>      
    </div>
    <!-- /task adjustments -->
    
    <asp:Panel ID="panelIsLocked" runat="server" Visible="false">
        <style type="text/css">
        .variationMode{ display: block; }
        </style>
    </asp:Panel>

    <asp:SqlDataSource ID="taskDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="getTaskDetails" SelectCommandType="StoredProcedure"
        UpdateCommand="updateTaskDetails" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter Name="taskId" QueryStringField="tid" />
        </SelectParameters>
        <UpdateParameters>
            <asp:SessionParameter Name="userId" SessionField="userId" />
            <asp:QueryStringParameter Name="projectId" QueryStringField="pid" />
        </UpdateParameters>
    </asp:SqlDataSource>
    
    <asp:SqlDataSource ID="buildPhaseDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="getTaskBuildPhases" />

    <asp:SqlDataSource ID="taskTotalsDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="getTaskTotals" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter Name="projectId" QueryStringField="pid" />
            <asp:QueryStringParameter Name="taskId" QueryStringField="tid" />
            <asp:SessionParameter Name="UserId" SessionField="UserId" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="resourceDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        UpdateCommand="updateTaskResource" UpdateCommandType="StoredProcedure"
        SelectCommand="getTaskResources" SelectCommandType="StoredProcedure"
        DeleteCommand="deleteTaskResource" DeleteCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter Name="taskId" QueryStringField="tid" />
            <asp:QueryStringParameter Name="projectId" QueryStringField="pid" />
            <asp:SessionParameter Name="UserId" SessionField="UserId" />
        </SelectParameters>
        <UpdateParameters>
            <asp:SessionParameter Name="UserId" SessionField="UserId" />
            <asp:QueryStringParameter Name="projectId" QueryStringField="pid" />
        </UpdateParameters>
        <DeleteParameters>
            <asp:SessionParameter Name="UserId" SessionField="UserId" />
            <asp:QueryStringParameter Name="projectId" QueryStringField="pid" />
        </DeleteParameters>
    </asp:SqlDataSource>
    
    <asp:SqlDataSource ID="additionsDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        UpdateCommand="updateTaskAddition" UpdateCommandType="StoredProcedure"
        InsertCommand="insertTaskAddition" InsertCommandType="StoredProcedure"
        DeleteCommand="deleteTaskAddition" DeleteCommandType="StoredProcedure"
        SelectCommand="getTaskAdditions" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter Name="taskId" QueryStringField="tid" />
            <asp:SessionParameter Name="UserId" SessionField="UserId" />
        </SelectParameters>
        <InsertParameters>
            <asp:QueryStringParameter Name="taskId" QueryStringField="tid" />
            <asp:Parameter Name="percentage" DefaultValue="0" />
        </InsertParameters>
    </asp:SqlDataSource>
    
    <asp:SqlDataSource ID="adhocTypeDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="getTaskAdditionTypes" />
        
    <asp:SqlDataSource ID="calcDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        InsertCommand="insertTaskCalculation" InsertCommandType="StoredProcedure"
        DeleteCommand="deleteTaskCalculation" DeleteCommandType="StoredProcedure"
        SelectCommand="getTaskCalculations" SelectCommandType="StoredProcedure"
        UpdateCommand="updateTaskCalculation" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter Name="taskId" QueryStringField="tid" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="length" DefaultValue="1" />
            <asp:Parameter Name="width" DefaultValue="1" />
            <asp:Parameter Name="height" DefaultValue="1" />
            <asp:Parameter Name="multiplier" DefaultValue="1" />
        </UpdateParameters>
        <InsertParameters>
            <asp:QueryStringParameter Name="taskId" QueryStringField="tid" />
            <asp:Parameter Name="length" DefaultValue="1" />
            <asp:Parameter Name="width" DefaultValue="1" />
            <asp:Parameter Name="height" DefaultValue="1" />
            <asp:Parameter Name="multiplier" DefaultValue="1" />
        </InsertParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="completionDataSource" runat="server"
        ConflictDetection="OverwriteChanges"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        UpdateCommand="updateTaskCompletion" UpdateCommandType="StoredProcedure"
        SelectCommand="getTaskCompletion"  SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter Name="taskId" QueryStringField="tid" />
            <asp:SessionParameter Name="UserId" SessionField="UserId" />
        </SelectParameters>
        <UpdateParameters>
            <asp:SessionParameter Name="UserId" SessionField="UserId" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>