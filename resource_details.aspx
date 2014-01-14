<%@ Page Language="VB" MasterPageFile="~/common/Manager.master" AutoEventWireup="false"
    CodeFile="resource_details.aspx.vb" Inherits="resource_details" Title="Resource - Buildmate"  %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="head" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>


<asp:Content ID="Content" ContentPlaceHolderID="MainContent" Runat="Server">

   <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlId="fvResource">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="fvResource" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlId="fvResourceInsert">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="rgCatalogue" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    
    <script type="text/javascript">
    function validateModal() {
        if (typeof (Page_ClientValidate) == 'function') {
            Page_ClientValidate();
        }

        if (Page_IsValid) {
            hideModal();
            return true;
        }
        return false;
    }
    </script>

    <!-- begin add resource -->
    <div id="addResource" class="md-window">
        <div class="md-content">
            <h3>Adding a Resource Supplier..</h3>
            
            <asp:FormView
                ID="fvResourceInsert"
                runat="server"
                RenderOuterTable="false"
                EnableViewState="false"
                DefaultMode="Insert"
                DataSourceID="catalogueDataSource"
                DataKeyNames="id">
                <InsertItemTemplate>
                <asp:Panel ID="Panel4" runat="server" DefaultButton="btnInsert">
                    <div class="md-details">
                    <div class="row">
                        <asp:Label ID="Label1" runat="server"
                            CssClass="label"
                            AssociatedControlID="rcbSupplier"
                            Text="Supplier*" />

                        <telerik:RadComboBox
                            ID="rcbSupplier"
                            runat="server"
                            SelectedValue='<%# Bind("supplierId") %>'
                            DataSourceID="supplierDataSource"
                            DataTextField="supplierName"
                            DataValueField="id" />
                    </div>

                    <div class="row">
                        <asp:Label ID="Label8" runat="server"
                            CssClass="label"
                            AssociatedControlID="rtbProductCode"
                            Text="Product Code" />

                        <telerik:RadTextBox ID="rtbProductCode" runat="server"
                            MaxLength="30"
                            Text='<%# Bind("productCode") %>'/>
                    </div>
                    
                    
                    <div class="row">
                        <asp:Label
                            ID="Label10"
                            runat="server"
                            CssClass="label"
                            AssociatedControlID="rtbSuffix"
                            Text="Suffix" />

                        <telerik:RadTextBox ID="rtbSuffix" runat="server"
                            MaxLength="50"
                            Text='<%# Bind("suffix") %>'/>
                    </div>

                    <div class="row">
                        <asp:Label ID="Label5" runat="server"
                            CssClass="label"
                            AssociatedControlID="rtbPrice"
                            Text="Price*" />

                        <telerik:RadNumericTextBox ID="rtbPrice" runat="server"
                            dbValue='<%# Bind("price") %>'
                            Width="90px"
                            NumberFormat-DecimalDigits="2"
                            Type="Currency" />

                        <asp:RequiredFieldValidator
                            ID="RequiredFieldValidator1"
                            runat="server"
                            ControlToValidate="rtbPrice"
                            ValidationGroup="insertValidation"
                            Display="Dynamic"
                            ErrorMessage="Price">
                            <span class="req"></span>
                        </asp:RequiredFieldValidator>
                    </div>

                    <div class="row">
                        <asp:Label ID="Label6" runat="server"
                            CssClass="label"
                            AssociatedControlID="rntbLeadTime"
                            Text="Lead Time" />

                        <telerik:RadNumericTextBox ID="rntbLeadTime" runat="server"
                            dbValue='<%# Bind("leadTime") %>'
                            Width="30px"
                            NumberFormat-DecimalDigits="0"
                            Value="0"
                            MinValue="0"
                            Type="Number" /> (days)

                        <asp:RequiredFieldValidator
                            ID="RequiredFieldValidator3"
                            runat="server"
                            ControlToValidate="rntbLeadTime"
                            ValidationGroup="insertValidation"
                            Display="Dynamic"
                            ErrorMessage="Lead Time">
                            <span class="req"></span>
                        </asp:RequiredFieldValidator>
                    </div>

                    <div class="row">
                        <asp:Label ID="Label9" runat="server"
                            CssClass="label"
                            AssociatedControlID="rntbUseage"
                            Text="Useage*" />

                        <telerik:RadNumericTextBox ID="rntbUseage" runat="server"
                            Type="Number"
                            Width="60px"
                            NumberFormat-DecimalDigits="2"
                            dbValue='<%# Bind("useage") %>'/>

                        <asp:RequiredFieldValidator
                            ID="RequiredFieldValidator4"
                            runat="server"
                            ControlToValidate="rntbUseage"
                            ValidationGroup="insertValidation"
                            Display="Dynamic"
                            ErrorMessage="Useage">
                            <span class="req"></span>
                        </asp:RequiredFieldValidator>
                    </div>
                    </div>
            
                    <div class="md-footer">
                        <asp:Button
                            ID="btnInsert"
                            runat="server"
                            CommandName="Insert"
                            Text="Add Resource"
                            CssClass="button button-create"
                            OnClientClick="validateModal()"
                            ValidationGroup="insertValidation" />
                        <a href="#" class="button md-close">Close</a>
                    </div>
                </asp:Panel>
            </InsertItemTemplate>
        </asp:FormView>
        </div>
    </div>   

    <div class="breadcrumb">
        <div class="breadcrumb-container">
            <ul class="breadcrumb-options">
                <li><a href="#" data-target="addResource" class="js-open-modal button button-create">New Supplier</a></li>
            </ul>
            <ul class="breadcrumb-list">
                <li>
                    <a href="resources.aspx" title="Resources">Resources</a>
                    <span class="divider">/</span>
                </li>
                <li class="active">
                    Resource Details
                </li>
            </ul>
        </div>
    </div>

    <div class="main-container">

        <div class="div25">
        <div class="box">
            <h3>Resource Details</h3>
        
            <div class="boxcontent">
                <asp:FormView
                    ID="fvResource"
                    runat="server"
                    DataKeyNames="id"
                    Width="100%"
                    DataSourceID="resourceDataSource">
                    <ItemTemplate>
                            <div class="row">
                                <label class="label">Resource Name</label>
                                <asp:Label ID="resourceNameLabel" runat="server" 
                                    Text='<%# Bind("resourceName") %>' />
                            </div>

                            <div class="row">
                                <label class="label">Category</label>
                                <asp:Label ID="categoryIdLabel" runat="server" 
                                    Text='<%# Bind("categoryName") %>' />
                            </div>

                            <div class="row">
                                <label class="label">Unit</label>
                                <asp:Label ID="unitIdLabel" runat="server" Text='<%# Bind("unit") %>' />
                            </div>

                            <div class="row">
                                <label class="label">Waste</label>
                                <asp:Label ID="wasteLabel" runat="server" Text='<%# Bind("waste") %>' />%
                            </div>

            
                            <div class="row">
                                <label class="label">Manufacturer</label>
                                <asp:Label ID="manufacturerLabel" runat="server" 
                                    Text='<%# Bind("manufacturer") %>' />
                            </div>
            
                            <div class="row">
                                <label class="label">Part ID</label>
                                <asp:Label ID="partIdLabel" runat="server" Text='<%# Bind("partId") %>' />
                            </div>

                    </ItemTemplate>
                </asp:FormView>
    
                <asp:SqlDataSource ID="resourceDataSource" runat="server"
                    ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
                    SelectCommand="getResourceDetailsById" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:QueryStringParameter QueryStringField="rid" Name="resourceId" />
                    </SelectParameters>    
                </asp:SqlDataSource>
            </div>
        </div>
        </div>
    
        <div class="div75 div-last">
        <div class="box">
            <h3>Suppliers for this Resource</h3>
        
            <div class="boxcontent">
                <telerik:RadGrid
                    ID="rgCatalogue"
                    runat="server"
                    DataSourceID="catalogueDataSource" 
                    GridLines="None">
                    <MasterTableView
                        AutoGenerateColumns="False"
                        DataSourceID="catalogueDataSource">
                        <Columns>
                            <telerik:GridTemplateColumn
                                HeaderStyle-Width="16px">
                                <ItemTemplate>
                                    <span
                                        id="spandisc"
                                        runat="server"
                                        title="Discontinued"
                                        visible='<%#(IIF(Eval("discontinued"),"true", "false"))%>'
                                        style="display: block; width: 16px; height: 16px; background: url(http://www.buildmateapp.com/icons/error.png)"></span>

                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridHyperLinkColumn
                                HeaderStyle-Width="40%"
                                DataTextField="supplierName"
                                HeaderText="Supplier Name"
                                SortExpression="supplierName"
                                UniqueName="supplierName"
                                DataNavigateUrlFields="resourceId, id"
                                DataNavigateUrlFormatString="edit_catalogue.aspx?rid={0}&id={1}" />
                    
                            <telerik:GridBoundColumn
                                HeaderStyle-HorizontalAlign="Center"
                                ItemStyle-HorizontalAlign="Center"
                                DataField="suffix"
                                HeaderText="Suffix" 
                                SortExpression="suffix"
                                UniqueName="suffix"/>
                    
                            <telerik:GridBoundColumn
                                HeaderStyle-HorizontalAlign="Center"
                                ItemStyle-HorizontalAlign="Center"
                                DataField="productCode"
                                HeaderText="Product Code" 
                                SortExpression="productCode"
                                UniqueName="productCode"/>

                            <telerik:GridBoundColumn
                                HeaderStyle-HorizontalAlign="Right"
                                ItemStyle-HorizontalAlign="Right"
                                DataField="price"
                                DataType="System.Decimal" 
                                DataFormatString="{0:c2}"
                                HeaderText="Price"
                                SortExpression="price"
                                UniqueName="price" />
                    
                            <telerik:GridBoundColumn
                                HeaderStyle-HorizontalAlign="Center"
                                ItemStyle-HorizontalAlign="Center"
                                DataField="leadTime"
                                DataType="System.Int32" 
                                HeaderText="Lead Time"
                                SortExpression="leadTime"
                                UniqueName="leadTime" />
                        
                            <telerik:GridBoundColumn
                                HeaderStyle-HorizontalAlign="Center"
                                ItemStyle-HorizontalAlign="Center"
                                DataField="useage"
                                DataType="System.Double" 
                                HeaderText="Useage"
                                SortExpression="useage"
                                UniqueName="useage" />
                    
                            <telerik:GridBoundColumn
                                HeaderStyle-HorizontalAlign="Center"
                                ItemStyle-HorizontalAlign="Center"
                                DataField="lastUpdated"
                                DataType="System.DateTime" 
                                HeaderText="Last Updated"
                                SortExpression="lastUpdated"
                                UniqueName="lastUpdated" />
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </div>
        </div>
        </div>
    
    </div>
    <asp:SqlDataSource ID="catalogueDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        InsertCommand="insertCatalogueUseageByUser"
        InsertCommandType="StoredProcedure"
        SelectCommand="getCatalogueUseageByResourceAndUser"
        SelectCommandType="StoredProcedure">
        <InsertParameters>
            <asp:SessionParameter Name="UserId" SessionField="UserId" />
            <asp:QueryStringParameter Name="resourceId" QueryStringField="rid" />
            <asp:Parameter Name="discontinued" DefaultValue="0" />
        </InsertParameters>
        <SelectParameters>
            <asp:QueryStringParameter Name="resourceId" QueryStringField="rid" />
            <asp:SessionParameter Name="userId" SessionField="userId" />
        </SelectParameters>    
    </asp:SqlDataSource>

    <asp:SqlDataSource
        ID="supplierDataSource"
        runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="getSupplierByUser"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="userId" SessionField="userId" />
        </SelectParameters>    
    </asp:SqlDataSource>
</asp:Content>