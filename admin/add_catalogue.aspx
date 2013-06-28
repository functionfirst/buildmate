<%@ Page Title="Add Catalogue - Admin" Language="VB" MasterPageFile="~/common/admin.master" AutoEventWireup="false" CodeFile="add_catalogue.aspx.vb" Inherits="add_catalogue" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">

   <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlId="fvCatalogueDetails">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="fvCatalogueDetails" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    
    
    <p class="breadcrumb">
        <a href="resources.aspx" title="Resources">Resources</a> &raquo;
        Add Catalogue
    </p>

    <div class="box">
        <h3>Catalogue Details</h3>
        
        <div class="boxcontent">
        
            <asp:FormView ID="fvCatalogueDetails" runat="server"
                DataKeyNames="id"
                Width="100%" 
                DataSourceID="catalogueDS"
                DefaultMode="Insert">
                <InsertItemTemplate>
                    <div class="row">
                        <asp:Label ID="Label1" runat="server"
                            CssClass="label"
                            AssociatedControlID="rcbSupplier"
                            Text="Supplier" />
                        
                        <telerik:RadComboBox ID="rcbSupplier" runat="server"
                            SelectedValue='<%# Bind("supplierId") %>'
                            DataSourceID="supplierDS"
                            DataTextField="supplierName"
                            DataValueField="id" />
                        
                        <asp:SqlDataSource ID="supplierDS" runat="server"
                            ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
                            SelectCommand="SELECT * FROM Supplier WHERE global = 1">   
                        </asp:SqlDataSource>
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
                        <asp:Label ID="Label2" runat="server"
                            CssClass="label"
                            AssociatedControlID="rtbSuffix"
                            Text="Suffix" />

                        <telerik:RadTextBox ID="rtbSuffix" runat="server"
                            MaxLength="50"
                            Text='<%# Bind("suffix") %>' />
                    </div>

                    <div class="row">
                        <asp:Label ID="Label5" runat="server"
                            CssClass="label"
                            AssociatedControlID="rtbPrice"
                            Text="Price" />

                        <telerik:RadNumericTextBox ID="rtbPrice" runat="server"
                            dbValue='<%# Bind("price") %>'
                            Width="90px"
                            NumberFormat-DecimalDigits="2"
                            Type="Currency" />
                        
                        <asp:RequiredFieldValidator
                            ID="RequiredFieldValidator2"
                            runat="server"
                            ControlToValidate="rtbPrice"
                            Display="Dynamic"
                            ErrorMessage="*required">
                        </asp:RequiredFieldValidator>
                    </div>

                    <div class="row">
                        <asp:Label ID="Label6" runat="server"
                            CssClass="label"
                            AssociatedControlID="rntbLeadTime"
                            Text="Lead Time" />

                        <telerik:RadNumericTextBox ID="rntbLeadTime" runat="server"
                            dbValue='<%# Bind("leadTime") %>'
                            Width="60px"
                            NumberFormat-DecimalDigits="0"
                            Type="Number" /> (days)
                        
                        <asp:RequiredFieldValidator
                            ID="RequiredFieldValidator1"
                            runat="server"
                            ControlToValidate="rntbLeadTime"
                            Display="Dynamic"
                            ErrorMessage="*required">
                        </asp:RequiredFieldValidator>
                    </div>

                    <div class="row">
                        <asp:Label ID="Label9" runat="server"
                            CssClass="label"
                            AssociatedControlID="rntbUseage"
                            Text="Useage" />

                        <telerik:RadNumericTextBox ID="rntbUseage" runat="server"
                            Type="Number"
                            Width="90px"
                            NumberFormat-DecimalDigits="2"
                            dbValue='<%# Bind("useage") %>'/>

                        <asp:RequiredFieldValidator
                            ID="RequiredFieldValidator3"
                            runat="server"
                            ControlToValidate="rntbUseage"
                            Display="Dynamic"
                            ErrorMessage="*required">
                        </asp:RequiredFieldValidator>
                    </div>
                    
                    <div class="row">
                        <asp:Label ID="Label7" runat="server"
                            CssClass="label"
                            AssociatedControlID="discontinuedCheckBox"
                            Text="Discontinued" />

                        <asp:CheckBox ID="discontinuedCheckBox" runat="server" 
                            Checked='<%# Bind("discontinued") %>' />
                    </div>
                    
                    <div class="row">
                        <label class="label">&nbsp;</label>
                        <asp:Button ID="btnInsert" runat="server"
                            CausesValidation="True" 
                            CommandName="Insert" Text="Add Resource" />
                    </div>
                </InsertItemTemplate>
            </asp:FormView>
        
            <asp:SqlDataSource ID="catalogueDS" runat="server"
                ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
                InsertCommand="insertCatalogueUseage" InsertCommandType="StoredProcedure">
                <InsertParameters>
                    <asp:QueryStringParameter Name="resourceId" QueryStringField="rid" />
                </InsertParameters>    
            </asp:SqlDataSource>
        </div>
    </div>    
</asp:Content>