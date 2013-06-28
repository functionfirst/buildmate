<%@ Page Title="Edit Catalogue - Admin" Language="VB" MasterPageFile="~/common/admin.master" AutoEventWireup="false" CodeFile="edit_catalogue.aspx.vb" Inherits="edit_catalogue" %>

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
        Edit Catalogue
    </p>


    <div class="box">
        <h3>Catalogue Details</h3>
        
        <div class="boxcontent">
        
            <asp:FormView ID="fvCatalogueDetails" runat="server" DataKeyNames="id" Width="100%" 
                DataSourceID="catalogueDS">
                <EditItemTemplate>
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
                            Text="Price" />

                        <telerik:RadNumericTextBox ID="rtbPrice" runat="server"
                            dbValue='<%# Bind("price") %>'
                            Width="90px"
                            NumberFormat-DecimalDigits="2"
                            ShowSpinButtons="true"
                            Type="Currency" />
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
                            ShowSpinButtons="true"
                            MinValue="0"
                            Type="Number" /> (days)
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
                            ShowSpinButtons="true"
                            dbValue='<%# Bind("useage") %>'/>
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
                        <label class="label">Product Code:</label>
                        <asp:Label ID="productCodeLabel" runat="server" 
                            Text='<%# Bind("productCode") %>' />&nbsp;
                    </div>

                    <div class="row">
                        <label class="label">Suffix:</label>
                        <asp:Label ID="Label11" runat="server" 
                            Text='<%# Bind("suffix") %>' />&nbsp;
                    </div>
                    
                    <div class="row">
                        <label class="label">Price:</label>
                        <asp:Label ID="Label1" runat="server" 
                            Text='<%#String.Format("{0:C2}", Container.DataItem("price"))%> ' />
                    </div>
                    
                    <div class="row">
                        <label class="label">Lead Time:</label>
                        <asp:Label ID="Label2" runat="server" 
                            Text='<%# Bind("leadTime") %>' />
                    </div>

                    <div class="row">
                        <label class="label">Useage:</label>
                        <asp:Label ID="Label4" runat="server" 
                            Text='<%# Bind("useage") %>' />
                    </div>
                    
                    <div class="row">
                        <label class="label">Discontinued:</label>
                        <asp:CheckBox ID="discontinuedCheckBox" runat="server" 
                            Checked='<%# Bind("discontinued") %>' Enabled="false" />
                    </div>
                    
                    <div class="row">
                        <label class="label">Last Updated:</label>
                        <asp:Label ID="Label3" runat="server" 
                            Text='<%#String.Format("{0:f}", Container.DataItem("lastUpdated"))%> ' />
                    </div>

                    <div class="row">
                        <label class="label">&nbsp;</label>
                        <asp:Button ID="Button1" runat="server" CommandName="Edit" Text="Edit" />
                    </div>
                </ItemTemplate>
            </asp:FormView>

            <asp:SqlDataSource ID="catalogueDS" runat="server"
                ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
                UpdateCommand="
                    UPDATE CatalogueUseage
                    SET productCode=@productCode, suffix=@suffix, price=@price, leadTime=@leadTime, discontinued=@discontinued, lastUpdated=getdate(), useage=@useage
                    WHERE id = @id"
                SelectCommand="
                    SELECT  * FROM CatalogueUseage
                    WHERE id = @catalogueId">
                <SelectParameters>
                    <asp:QueryStringParameter QueryStringField="id" Name="catalogueId" />
                </SelectParameters>    
            </asp:SqlDataSource>
        </div>
    </div>    
</asp:Content>

