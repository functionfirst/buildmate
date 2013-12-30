<%@ Page Title="Resource Details - Buildmate" Language="VB" MasterPageFile="~/common/Manager.master" AutoEventWireup="false" CodeFile="catalogue_details.aspx.vb" Inherits="manager_catalogue_details" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">

    <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlId="fvCatalogue">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="fvCatalogue" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>

    <p class="breadcrumb">
        <asp:HyperLink ID="hlBack" runat="server"
            NavigateUrl="catalogue.aspx"
            Text="Catalogue" />
            &raquo; Catalogue Resource Details
    </p>

    <div class="box">
        <div class="box_top">Catalogue Resource Details</div>
                    
        <div class="boxcontent">
            <asp:FormView ID="fvCatalogue" runat="server"
                DataSourceID="catalogueDataSource"
                DataKeyNames="id"
                Width="100%">
                <ItemTemplate>
                    <div class="row">
                        <label for="rtbProductCode"  title="Product Code" class="label">Product Code</label>
                        <%#Eval("productCode")%>
                    </div>
                            
                            <div class="row">
                                <label for="rntbPrice"  title="Price" class="label">Price</label>
                                <%#Eval("price", "{0:C}")%>
                            </div>
                            
                            <div class="row">
                                <label for="rntbPrice"  title="Useage" class="label">Useage</label>
                                <%#Eval("useage", "{0:F2}")%>
                            </div>
                            
                            <div class="row">
                                <label for="cbDiscontinued"  title="Discontinued" class="label">Discontinued</label>
                                <asp:Image ID="Image1" runat="server"
                                    ImageUrl="~/icons/success.png"
                                    Visible='<%# Not isDbNull(Eval("discontinued")) %>' />
                            </div>
                            
                            <div class="row">
                                <label for="rntbLeadTime"  title="Lead Time" class="label">Lead Time</label>
                                <%#Eval("leadTime") & " days"%>
                            </div>
                            
                            <div class="row">
                                <label for="rtbLastUpdated"  title="Last Updated" class="label">Last Updated</label>
                                <%#Eval("lastUpdated", "{0:d}")%>
                            </div>
                            
                            <div class="row">
                                <label for="btns" class="label">&nbsp;</label>
                                <asp:Button ID="btnEdit" runat="server"
                                    Text="Edit" CommandName="Edit" />
                            </div>
                </ItemTemplate>

                <EditItemTemplate>
                    <div class="row">
                        <label for="rtbProductCode" title="Product Code" class="label">Product Code*</label>
                        <telerik:RadTextBox ID="rtbProductCode" runat="server" Text='<%#Bind("productCode") %>' Columns="20" EmptyMessage="Product Code " />

                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="rtbProductCode"
                            ErrorMessage="Product Code" ValidationGroup="editGroup">
                            <span class="req"></span>
                        </asp:RequiredFieldValidator>
                    </div>
                            
                    <div class="row">
                        <label for="rntbPrice"  title="Price" class="label">Price*</label>
                        <telerik:RadNumericTextBox ID="rntbPrice" runat="server"
                            dbvalue='<%#Bind("price") %>'
                            Width="60px"
                            EmptyMessage="GBP"
                            Type="Currency"
                            NumberFormat-DecimalDigits="2" />
                                
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                            ControlToValidate="rntbPrice"
                            ErrorMessage="Price" ValidationGroup="editGroup">
                            <span class="req"></span>
                        </asp:RequiredFieldValidator>
                    </div>
                    
                    <div class="row">
                        <label for="rntbPrice"  title="Useage" class="label">Useage*</label>
                        <telerik:RadNumericTextBox ID="rntbUseage" runat="server"
                            dbvalue='<%#Bind("useage") %>'
                            Width="60px"
                            EmptyMessage="Useage"
                            Type="Number"
                            NumberFormat-DecimalDigits="2" />
                                
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                            ControlToValidate="rntbUseage"
                            ErrorMessage="Useage" ValidationGroup="editGroup">
                            <span class="req"></span>
                        </asp:RequiredFieldValidator>
                    </div>
                            
                    <div class="row">
                        <label for="cbDiscontinued"  title="Discontinued" class="label">Discontinued</label>
                        <asp:CheckBox ID="cbDiscontinued" runat="server" Checked='<%#Bind("discontinued")%>' />
                    </div>
                            
                    <div class="row">
                        <label for="rntbLeadTime"  title="Lead Time" class="label">Lead Time</label>
                        <telerik:RadNumericTextBox ID="RadNumericTextBox1" runat="server" dbvalue='<%#Bind("leadTime") %>'
                            Width="40px" NumberFormat-DecimalDigits="0" Type="Number" /> days
                    </div>
                            
                    <div class="row">
                        <label for="rtbLastUpdated"  title="Last Updated" class="label">Last Updated</label>
                        <%#Eval("lastUpdated", "{0:d}")%>
                    </div>

                    <div class="row">
                        <label for="btns" class="label">&nbsp;</label>
                        <asp:Button ID="btnUpdate" runat="server"
                            CommandName="Update"
                            OnClick="Validate_OnClick"
                            ValidationGroup="editGroup"
                            Text="Update" />

                        <asp:Button ID="btnCancel" runat="server"
                            CommandName="Cancel"
                            Text="Cancel"
                            CausesValidation="false" />
                            
                    </div>
                </EditItemTemplate>
            </asp:FormView>
        </div>
    </div>
                
    <asp:SqlDataSource ID="catalogueDataSource" runat="server" ConflictDetection="CompareAllValues"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>" OldValuesParameterFormatString="original_{0}"
        SelectCommand="sp_tblCatalogueUseage_SELECT" SelectCommandType="StoredProcedure"
        UpdateCommand="sp_tblCatalogueUseage_UPDATE" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter Name="catalogueUseageId" QueryStringField="id" DefaultValue="0" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

