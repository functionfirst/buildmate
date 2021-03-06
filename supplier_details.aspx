﻿<%@ Page Title="Supplier Details - Buildmate" Language="VB" MasterPageFile="~/common/Manager.master" AutoEventWireup="false" CodeFile="supplier_details.aspx.vb" Inherits="manager_supplier_details" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <telerik:RadScriptBlock ID="rsbPhase6" runat="server" Visible="false">
    <script type="text/javascript">
        var data = {
            target: ".button-create",
            progress: 2,
            tooltip: {
                title: "Add your Company as a Supplier",
                content: "Click on the name 'My Company' and change this to your company name, then enter your 'ADDRESS' and 'POSTCODE'. Click the green button 'Save Changes' located at the bottom of the form to update the changes.<br><br><em>Help: Click the Supplier Name 'Your Company' in blue text to open the Supplier Details. Click the SUPPLIER NAME field to change the name and then add your COMPANY ADDRESS and POSTCODE. All other details are optional.</em>"
            }
        };

        $(document).ready(function () {
            bm.tour(data);
        });
    </script>
    </telerik:RadScriptBlock>

    <telerik:RadScriptBlock ID="rsbPhase7" runat="server" Visible="false">
    <script type="text/javascript">
        var data = {
            target: "#ctl00_hlSuppliers",
            progress: 2,
            tooltip: {
                title: "With your Company setup as a Supplier you will need to setup one more supplier.",
                content: "To 'Add a Supplier' click 'Suppliers' on the main menu above.<br><br><em>Help: For the tutorial you will need to add one of your Suppliers you can add additional suppliers at anytime.</em>"
            }
        };

        $(document).ready(function () {
            bm.tour(data);
        });
    </script>
    </telerik:RadScriptBlock>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">

    <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlId="fvSupplierDetails">
                <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="fvSupplierDetails" />
                        <telerik:AjaxUpdatedControl ControlID="notification" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
   
    <div class="breadcrumb">
        <div class="breadcrumb-container">
            <ul class="breadcrumb-list">
                <li><asp:HyperLink ID="HyperLink4" runat="server"
                    NavigateUrl="~/suppliers.aspx"
                    Text="Suppliers" />
                    <span class="divider">/</span>
                </li>
                <li class="active">Supplier Details</li>
            </ul>
        </div>
    </div>

    <div class="main-container">
        <h3>Supplier Details</h3>
    
        <asp:FormView ID="fvSupplierDetails" runat="server" DataSourceId="supplierDataSource" DataKeyNames="id" DefaultMode="Edit">
            <EditItemTemplate>
                <div class="row">
                    <label for="rtbSupplierName" title="Supplier Name" class="label">Supplier Name*</label>
                    <telerik:RadTextBox ID="rtbSupplierName" runat="server" Text='<%#Bind("supplierName") %>'
                        MaxLength="50" Columns="35" Width="300px" EmptyMessage="Supplier Name" />
                                                    
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                        ControlToValidate="rtbSupplierName" ValidationGroup="editGroup"
                        Display="Dynamic" ErrorMessage="Supplier Name">
                        <span class="req"></span>
                    </asp:RequiredFieldValidator>
                </div>

                <div class="row">
                    <label for="rtbAddress" title="Address" class="label">Address*</label>

                    <telerik:RadTextBox ID="rtbAddress" runat="server"
                        Width="300px" Rows="4" Columns="80"
                        Text='<%#Bind("address")%>' TextMode="MultiLine" EmptyMessage="Address" />

                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                        ControlToValidate="rtbAddress" ValidationGroup="editGroup"
                        Display="Dynamic" ErrorMessage="Address">
                        <span class="req"></span>
                    </asp:RequiredFieldValidator>
                </div>

                <div class="row">
                    <label for="rtbPostcode" title="Postcode" class="label">Postcode*</label>

                    <telerik:RadTextBox ID="rtbPostcode" runat="server" Text='<%#Bind("postcode")%>' Columns="35" EmptyMessage="Postcode" />

                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                        ControlToValidate="rtbPostcode" ValidationGroup="editGroup"
                        Display="Dynamic" ErrorMessage="Postcode">
                        <span class="req"></span>
                    </asp:RequiredFieldValidator>
                </div>
                                                
                <div class="row">
                    <label for="rtbEmail" title="Email" class="label">Email</label>
                    <telerik:RadTextBox ID="rtbEmail" runat="server" Text='<%#Bind("email") %>' Columns="35" EmptyMessage="Email" />
                </div>

                <div class="row">
                    <label for="rtbTel" title="Telephone" class="label">Telephone</label>
                    <telerik:RadTextBox ID="rtbTel" runat="server" Text='<%#Bind("tel") %>' Columns="35" EmptyMessage="Telephone" />
                </div>
                                                                        
                <div class="row">
                    <label for="rtbFax" title="Fax" class="label">Fax</label>
                    <telerik:RadTextBox ID="rtbFax" runat="server" Text='<%#Bind("fax") %>' Columns="35" EmptyMessage="Fax" />
                </div>
                                                
                <div class="row">
                    <label for="rtbURL" title="Website" class="label">Website</label>
                    <telerik:RadTextBox ID="rtbURL" runat="server" Text='<%#Bind("URL") %>' Columns="35" EmptyMessage="Website" />
                </div>
                
                <div class=" form-actions">
                    <asp:Button ID="btnUpdate" runat="server" CommandName="Update" CssClass="button button-create"
                        OnClick="Validate_OnClick" Text="Save Changes" />
                </div>
            </EditItemTemplate>
        </asp:FormView>
    </div>
                     
    <asp:SqlDataSource ID="supplierDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="getSupplierDetails" SelectCommandType="StoredProcedure"
        UpdateCommand="updateSupplierDetails" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter Name="SupplierId" QueryStringField="id" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

