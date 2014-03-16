<%@ Page Title="Edit Catalogue - Admin" Language="VB" MasterPageFile="~/common/Manager.master" AutoEventWireup="false" CodeFile="edit_catalogue.aspx.vb" Inherits="edit_catalogue" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="head" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="content" ContentPlaceHolderID="MainContent" Runat="Server">

   <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlId="fvCatalogueDetails">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="fvCatalogueDetails" />
                     <telerik:AjaxUpdatedControl ControlID="notification" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>

    <div class="breadcrumb">
        <div class="breadcrumb-container">
            <ul class="breadcrumb-list">
                <li>
                    <a href="resources.aspx" title="Resources">Resources</a>
                    <span class="divider">/</span>
                </li>
                <li>
                    <asp:HyperLink ID="hlResource" runat="server">Resource Details</asp:HyperLink>
                    <span class="divider">/</span>
                </li>
                <li class="active">Resource Supplier Details</li>
            </ul>
        </div>
    </div>

    <div class="main-container">
        <div class="box">
        <h3>Resource Supplier Details</h3>
        
        
            <asp:FormView ID="fvCatalogueDetails" runat="server" DataKeyNames="id" DefaultMode="Edit" 
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
                            MaxValue="999999"
                            NumberFormat-DecimalDigits="2"
                            Type="Currency" />
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
                            MinValue="0"
                            MaxValue="999"
                            Type="Number" /> (days)
                    </div>

                    <div class="row">
                        <asp:Label ID="Label9" runat="server"
                            CssClass="label"
                            AssociatedControlID="rntbUseage"
                            Text="Useage" />

                        <telerik:RadNumericTextBox ID="rntbUseage" runat="server"
                            Type="Number"
                            Width="60px"
                            MaxValue="999999"
                            NumberFormat-DecimalDigits="2"
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
                        <label class="label">Last Updated:</label>
                        <asp:Label ID="Label3" runat="server" 
                            Text='<%#String.Format("{0:f}", Container.DataItem("lastUpdated"))%> ' />
                    </div>
            
                    <div class="form-actions">
                        <asp:Button ID="UpdateButton" runat="server"
                            CausesValidation="True"
                            CssClass="button button-create"
                            CommandName="Update" Text="Update" />
                    </div>
                </EditItemTemplate>
            </asp:FormView>
        </div>
    </div>

    <asp:SqlDataSource
        ID="catalogueDS" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        UpdateCommand="updateCatalogueUseageDetailsById" UpdateCommandType="StoredProcedure"
        SelectCommand="getCatalogueUseageDetailsById" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="id" Name="catalogueId" />
        </SelectParameters>
        <UpdateParameters>
            <asp:SessionParameter Name="userId" SessionField="UserId" />
            <asp:QueryStringParameter Name="resourceId" QueryStringField="rid" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>

