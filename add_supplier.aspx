<%@ Page Title="Add a Supplier - BuildMate" Language="VB" MasterPageFile="~/common/Manager.master" AutoEventWireup="false" CodeFile="add_supplier.aspx.vb" Inherits="manager_add_supplier" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlId="fvSupplierInsert">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="fvSupplierInsert" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    
    <div class="breadcrumb">
        <p>
            &lArr;
            <asp:HyperLink ID="hlBack" runat="server"
                NavigateUrl="~/suppliers.aspx"
                Text="Suppliers" />
        </p>
    </div>

    <asp:FormView ID="fvSupplierInsert" runat="server"
        DataSourceId="insertSupplierDataSource"
        DataKeyNames="id"
        DefaultMode="Insert"
        Width="100%">
        <InsertItemTemplate>
            <div class="box">
                <h3>Add a Supplier</h3>

                    <asp:Panel ID="Panel1" runat="server" DefaultButton="btnInsert" CssClass="boxcontent">
                    <table border="0" cellspacing="0" cellpadding="0" Width="100%">
                        <tr>
                            <td valign="top">
                                <div class="row">
                                    <label for="rtbSupplierName" title="Supplier Name" class="label">Supplier Name*</label>
                                    <telerik:RadTextBox ID="rtbSupplierName" runat="server"
                                        Text='<%#Bind("supplierName") %>'
                                        MaxLength="50"
                                        Columns="35"
                                        EmptyMessage="Supplier Name" />
                                    
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                        ControlToValidate="rtbSupplierName" ValidationGroup="insertGroup"
                                        Display="Dynamic" ErrorMessage="Supplier Name">
                                        <span class="req"></span>
                                    </asp:RequiredFieldValidator>
                                </div>

                                <div class="row">
                                    <label for="rtbTel" title="Telephone" class="label">Telephone*</label>
                                    <telerik:RadTextBox ID="rtbTel" runat="server" Text='<%#Bind("tel") %>' Columns="35" EmptyMessage="Telephone" />
                                    
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server"
                                        ControlToValidate="rtbTel" ValidationGroup="insertGroup"
                                        Display="Dynamic" ErrorMessage="Telephone">
                                        <span class="req"></span>
                                    </asp:RequiredFieldValidator>
                                </div>
                                                        
                                <div class="row">
                                    <label for="rtbFax" title="Fax" class="label">Fax</label>
                                    <telerik:RadTextBox ID="rtbFax" runat="server" Text='<%#Bind("fax") %>' Columns="35" EmptyMessage="Fax" />
                                </div>
                                
                                <div class="row">
                                    <label for="rtbEmail" title="Email" class="label">Email</label>
                                    <telerik:RadTextBox ID="rtbEmail" runat="server" Text='<%#Bind("email") %>' Columns="35" EmptyMessage="Email" />
                                </div>
                                
                                <div class="row">
                                    <label for="rtbURL" title="Website" class="label">Website</label>
                                    <telerik:RadTextBox ID="rtbURL" runat="server" Text='<%#Bind("URL") %>' Columns="35" EmptyMessage="Website" />
                                </div>

                                                        
                                <div class="row">
                                    <label for="btns" class="label">&nbsp;</label>
                                    <asp:Button ID="btnInsert" runat="server" CommandName="Insert"
                                        OnClick="Validate_Insert" Text="Add Supplier" />
                                </div>
                            </td>
                            <td>
                                <div class="row">
                                    <label for="rtbAddress1" title="Address" class="label">Address*</label>
                                    <telerik:RadTextBox ID="rtbAddress1" runat="server" Text='<%#Bind("address1") %>' Columns="35" EmptyMessage="Address" />
                                    
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                                        ControlToValidate="rtbAddress1" ValidationGroup="insertGroup"
                                        Display="Dynamic" ErrorMessage="Address">
                                        <span class="req"></span>
                                    </asp:RequiredFieldValidator>
                                </div>
                                                        
                                <div class="row">
                                    <label for="rtbAddress2" title="Address 2" class="label">&nbsp;</label>
                                    <telerik:RadTextBox ID="rtbAddress2" runat="server" Text='<%#Bind("address2") %>' Columns="35" />
                                </div>
                                                        
                                <div class="row">
                                    <label for="rtbAddress3" title="Address 3" class="label">&nbsp;</label>
                                    <telerik:RadTextBox ID="rtbAddress3" runat="server" Text='<%#Bind("address3") %>' Columns="35" />
                                </div>
                                
                                <div class="row">
                                    <label for="rtbCity" title="Town/City" class="label">Town/City</label>
                                    <telerik:RadTextBox ID="rtbCity" runat="server" Text='<%#Bind("city") %>' Columns="35" EmptyMessage="Town/City" />
                                </div>
                                                        
                                <div class="row">
                                    <label for="rtbCounty" title="County" class="label">County</label>
                                    <telerik:RadTextBox ID="rtbCounty" runat="server" Text='<%#Bind("county") %>' Columns="35" EmptyMessage="County" />
                                </div>
                                                        
                                <div class="row">
                                    <label for="rtbPostcode" title="Postcode" class="label">Postcode*</label>
                                    <telerik:RadTextBox ID="rtbPostcode" runat="server" Text='<%#Bind("postcode") %>' EmptyMessage="Postcode" />
                                    
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                                        ControlToValidate="rtbPostcode" ValidationGroup="insertGroup"
                                        Display="Dynamic" ErrorMessage="Postcode">
                                        <span class="req"></span>
                                    </asp:RequiredFieldValidator>
                                </div>
                                                        
                                <div class="row">
                                    <label for="rcbCountry" title="Country" class="label">Country</label>
                                    <telerik:RadComboBox ID="rcbCountry" runat="server" Height="140px" OnLoad="defaultCountry" SelectedValue='<%# Bind("countryId") %>'
                                        DataSourceID="countryDataSource" DataTextField="countryName" DataValueField="id" />
                                </div>
                            </td>
                        </tr>
                    </table>
                    </asp:Panel>
                </div>
        </InsertItemTemplate>
    </asp:FormView>
                    
    <asp:SqlDataSource
        ID="insertSupplierDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        InsertCommand="insertSupplier"
        InsertCommandType="StoredProcedure">
        <InsertParameters>
            <asp:SessionParameter name="UserId" SessionField="UserId" />
            <asp:Parameter Name="NewId" Type="Int64" Direction="Output" />
        </InsertParameters>
    </asp:SqlDataSource>
    
    <asp:SqlDataSource
        ID="countryDataSource"
        runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="getCountries"
        SelectCommandType="StoredProcedure" />
</asp:Content>

