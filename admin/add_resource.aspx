<%@ Page Title="Add a Resource - Admin" Language="VB" MasterPageFile="~/common/admin.master" AutoEventWireup="false" CodeFile="add_resource.aspx.vb" Inherits="add_resource" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">


   <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlId="fvResource">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="fvResource" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    
    
    <p class="breadcrumb">
        <a href="resources.aspx" title="Resources">Resources</a> &raquo;
        Add a Resource
    </p>

    
    <div class="box">
        <h3>Resource Details</h3>
        
        <div class="boxcontent">
            <div class="errorBox">
                <p><strong>Note:</strong><br />Make sure you checked this resource doesn't already exist before you add it!</p>
            </div>

            <asp:FormView ID="fvResource" runat="server" DefaultMode="Insert"
                DataKeyNames="id"
                Width="100%"
                DataSourceID="resourceDataSource">
                <InsertItemTemplate>
                    <div class="row">
                        <asp:Label ID="Label9" runat="server"
                            CssClass="label"
                            AssociatedControlID="rtbResourceName"
                            Text="Supplier" />

                        <telerik:RadComboBox ID="rcbSupplier" runat="server"
                            SelectedValue='<%# Bind("supplierId") %>'
                            DataSourceID="supplierDataSource"
                            DataTextField="supplierName"
                            DataValueField="id" />
                            
                        <asp:SqlDataSource
                            ID="supplierDataSource"
                            runat="server"
                            ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
                            SelectCommand="SELECT id, supplierName FROM Supplier WHERE  global = 1">
                        </asp:SqlDataSource>
                    </div>
    
                    <div class="row">
                        <asp:Label ID="Label1" runat="server"
                            CssClass="label"
                            AssociatedControlID="rtbResourceName"
                            Text="Resource Name" />

                        <telerik:RadTextBox ID="rtbResourceName" runat="server"
                            Width="400px" MaxLength="255"
                            Text='<%# Bind("resourceName") %>' />
                        
                        <asp:RequiredFieldValidator
                            ID="RequiredFieldValidator2"
                            runat="server"
                            ControlToValidate="rtbResourceName"
                            Display="Dynamic"
                            ErrorMessage="*required">
                        </asp:RequiredFieldValidator>
                    </div>
            
                    <div class="row">
                        <asp:Label ID="Label10" runat="server"
                            CssClass="label"
                            AssociatedControlID="rtbKeywords"
                            Text="Keywords" />

                        <telerik:RadTextBox ID="rtbKeywords" runat="server"
                            Width="400px" MaxLength="255"
                            TextMode="MultiLine"
                            Height="67px"
                            Text='<%# Bind("keywords") %>' />
                    </div>
                    
                    <div class="row">
                        <asp:Label ID="Label2" runat="server"
                            CssClass="label"
                            AssociatedControlID="rtbManufacturer"
                            Text="Manufacturer" />

                        <telerik:RadTextBox
                            ID="rtbManufacturer"
                            runat="server"
                            Width="200" MaxLength="120"
                            Text='<%# Bind("manufacturer") %>' />
                    </div>
                    
                    <div class="row">
                        <asp:Label ID="Label3" runat="server"
                            CssClass="label"
                            AssociatedControlID="rtbPartId"
                            Text="Part ID" />

                        <telerik:RadTextBox
                            ID="rtbPartId"
                            runat="server"
                            Width="200" MaxLength="50"
                            Text='<%# Bind("partId") %>' />
                    </div>            
                    
                    <div class="row">
                        <asp:Label ID="Label4" runat="server"
                            CssClass="label"
                            AssociatedControlID="rcbResourceType"
                            Text="Resource Type" />

                        <telerik:RadComboBox ID="rcbResourceType" runat="server"
                            SelectedValue='<%# Bind("resourceTypeId") %>'
                            DataSourceID="resourceTypeDS"
                            DataTextField="resourceType"
                            DataValueField="id" />

                        <asp:SqlDataSource ID="resourceTypeDS" runat="server"
                            ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
                            SelectCommand="SELECT * FROM ResourceType" />
                    </div>            
                    
                    <div class="row">
                        <asp:Label ID="Label5" runat="server"
                            CssClass="label"
                            AssociatedControlID="rcbCategory"
                            Text="Category" />

                        <telerik:RadComboBox ID="rcbCategory" runat="server"
                            Height="120px"
                            SelectedValue='<%# Bind("categoryId") %>'
                            DataSourceID="categoryDS"
                            DataTextField="categoryName"
                            DataValueField="id" />
                            
                        <asp:SqlDataSource ID="categoryDS" runat="server"
                            ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
                            SelectCommand="SELECT * FROM ResourceCategory" />
                    </div>
                    
                    <div class="row">
                        <asp:Label ID="Label6" runat="server"
                            CssClass="label"
                            AssociatedControlID="rcbUnit"
                            Text="Unit" />

                        <telerik:RadComboBox ID="rcbUnit" runat="server"
                            Height="120px"
                            SelectedValue='<%# Bind("unitId") %>'
                            DataSourceID="unitDS"
                            DataTextField="unit"
                            DataValueField="id" />
                      
                        <asp:SqlDataSource ID="unitDS" runat="server"
                            ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
                            SelectCommand="SELECT * FROM ResourceUnit order by unit" />
                    </div>
                    
                    <div class="row">
                        <asp:Label ID="Label8" runat="server"
                            CssClass="label"
                            AssociatedControlID="rtbWaste"
                            Text="Waste" />

                        <telerik:RadNumericTextBox ID="rtbWaste" runat="server"
                            Value='<%# Bind("waste") %>'
                            EmptyMessage="%"
                            Width="60"
                            NumberFormat-DecimalDigits="2"
                            Type="Percent" />

                        <asp:RequiredFieldValidator
                            ID="RequiredFieldValidator1"
                            runat="server"
                            ControlToValidate="rtbWaste"
                            Display="Dynamic"
                            ErrorMessage="*required">
                        </asp:RequiredFieldValidator>   
                    </div>

                    <div class="row">
                        <label class="label">&nbsp;</label>

                        
                        <asp:Button ID="btnInsert" runat="server"
                            CausesValidation="True"
                            CommandName="Insert" Text="Add Resource" />
                    </div>
                </InsertItemTemplate>
            </asp:FormView>
        </div>
    </div>
    
    <asp:SqlDataSource ID="resourceDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        InsertCommand="INSERT INTO Resource (resourceName, manufacturer, partId, resourceTypeId, categoryId, unitId, waste, keywords)
            VALUES(@resourceName, @manufacturer, @partId, @resourceTypeId, @categoryId, @unitId, @waste, @keywords);">   
    </asp:SqlDataSource>

</asp:Content>