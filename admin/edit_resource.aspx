    <%@ Page Title="Edit Resource - Admin" Language="VB" MasterPageFile="~/common/admin.master" AutoEventWireup="false" CodeFile="edit_resource.aspx.vb" Inherits="edit_resource" %>

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
        Edit Resource
    </p>

    
    <div class="box">
        <h3>Resource Details</h3>
        
        <div class="boxcontent">
    <asp:FormView ID="fvResource" runat="server"
        DataKeyNames="id"
        Width="100%"
        DataSourceID="resourceDataSource">
        <EditItemTemplate>
            <div class="row">
                <asp:Label ID="Label1" runat="server"
                    CssClass="label"
                    AssociatedControlID="rtbResourceName"
                    Text="Resource Name" />

                <telerik:RadTextBox ID="rtbResourceName" runat="server"
                    Width="400px" MaxLength="255"
                    Text='<%# Bind("resourceName") %>' />
            </div>
            
            <div class="row">
                <asp:Label ID="Label9" runat="server"
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

                <telerik:RadTextBox ID="rtbManufacturer" runat="server" MaxLength="120"
                    Text='<%# Bind("manufacturer") %>' />
            </div>
            
            <div class="row">
                <asp:Label ID="Label3" runat="server"
                    CssClass="label"
                    AssociatedControlID="rtbPartId"
                    Text="Part ID" />

                <telerik:RadTextBox ID="rtbPartId" runat="server" MaxLength="50"
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
                    NumberFormat-DecimalDigits="2"
                    Type="Percent" />
            </div>
            
            <div class="row">
                <asp:Button ID="UpdateButton" runat="server"
                    CausesValidation="True" 
                    CommandName="Update" Text="Update" />
            
                <asp:LinkButton ID="UpdateCancelButton" runat="server" 
                    CausesValidation="False"
                    CommandName="Cancel"
                    Text="Cancel" />
            </div>
        </EditItemTemplate>
        <ItemTemplate>
            <div class="row">
                <label class="label">Resource Name</label>
                <asp:Label ID="resourceNameLabel" runat="server" 
                    Text='<%# Bind("resourceName") %>' />
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
            
            <div class="row">
                <label class="label">Resource Type</label>
                <asp:Label ID="resourceTypeIdLabel" runat="server" 
                    Text='<%# Bind("resourceType") %>' />
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
                <label class="label">Keywords</label>
                <asp:Label ID="keywordsLabel" runat="server" Text='<%# Bind("keywords") %>' />
            </div>
            
            <div class="row">
                <label class="label">&nbsp;</label>
                <asp:Button ID="Button1" runat="server" CommandName="Edit" Text="Edit" />
            </div>
        </ItemTemplate>
    </asp:FormView>
    
    <asp:SqlDataSource ID="resourceDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        UpdateCommand="updateResource" UpdateCommandType="StoredProcedure"
        SelectCommand="getResourceDetails" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="rid" Name="resourceId" />
        </SelectParameters>    
    </asp:SqlDataSource>
    </div>
    </div>
    
    <div class="box">
        <h3>
        <asp:HyperLink ID="hlAddCatalogue" runat="server" CssClass="floatright"
            NavigateUrl="add_catalogue.aspx?rid=">Add Catalogue</asp:HyperLink>
        Catalogue Resources</h3>
        
        <div class="boxcontent">
        
            
        <telerik:RadGrid
            ID="rgCatalogue"
            runat="server"
            AllowAutomaticDeletes="True"
            DataSourceID="catalogueDS" 
            GridLines="None">
            <MasterTableView
                AutoGenerateColumns="False"
                NoMasterRecordsText="&nbsp; No Catalogue Resource were found matching your criteria."
                DataSourceID="catalogueDS"
                DataKeyNames="id">
                <Columns>
                    <telerik:GridTemplateColumn
                        HeaderStyle-Width="16px">
                        <ItemTemplate>
                            <span
                                id="spandisc"
                                runat="server"
                                title="Discontinued"
                                visible='<%#(IIF(Eval("discontinued"),"true", "false"))%>'
                                style="display: block; width: 16px; height: 16px; background: url(http://www.pyramidestimator.com/icons/error.png)"></span>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridHyperLinkColumn
                        HeaderStyle-Width="40%"
                        DataTextField="supplierName"
                        HeaderText="Supplier Name"
                        SortExpression="supplierName"
                        UniqueName="supplierName"
                        DataNavigateUrlFields="id"
                        DataNavigateUrlFormatString="edit_catalogue.aspx?id={0}" />
                    
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
     
                    <telerik:GridButtonColumn
                        ConfirmText="Delete this Catalogue Resource?"
                        ConfirmTitle="Delete"
                        ButtonType="ImageButton"
                        CommandName="Delete"
                        CommandArgument="id"
                        Text="Delete"
                        UniqueName="DeleteColumn" />
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
        </div>
        
        <asp:SqlDataSource ID="catalogueDS" runat="server"
            ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
            DeleteCommand="DELETE FROM CatalogueUseage WHERE id = @id"
            SelectCommand="
                SELECT
                    CatalogueUseage.id,
                    isnull(discontinued, 0) AS discontinued,
                    supplierName,
                    productCode,
                    price,
                    leadTime,
                    lastUpdated,
                    useage
                    , suffix
                FROM Catalogue
                RIGHT JOIN CatalogueUseage ON Catalogue.id = CatalogueUseage.catalogueId
                RIGHT JOIN Supplier ON Catalogue.supplierId = Supplier.id 
                WHERE resourceId = @resourceid">
            <SelectParameters>
                <asp:QueryStringParameter QueryStringField="rid" Name="resourceId" />
            </SelectParameters>    
        </asp:SqlDataSource>
    </div>
    
    

</asp:Content>