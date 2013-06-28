<%@ Page Title="Supplier Details - BuildMate" Language="VB" MasterPageFile="~/common/Manager.master" AutoEventWireup="false" CodeFile="supplier_details.aspx.vb" Inherits="manager_supplier_details" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">

 <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlId="fvSupplierDetails">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="fvSupplierDetails" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
   
   
    <div class="breadcrumb">
        <p>
            &laquo; <asp:HyperLink ID="HyperLink3" runat="server"
                NavigateUrl="~/suppliers.aspx"
                Text="Suppliers" />
        </p>
    </div>

   <div class="box">
        <div id="readMode" class="box_top" runat="server"><span>Supplier Details</span></div>
        <div id="editMode" class="box_top_edit" runat="server" visible="false"><span>Editing Supplier Details..</span></div>
                        
        <div id="successbox" class="box_update" runat="server" visible="false"><span>Supplier Details saved</span></div>
        <div id="insertbox" class="box_update" runat="server" visible="false"><span>New Supplier saved</span></div>
        <div id="errorbox" class="box_error" runat="server" visible="false">
            <span>The following required fields are missing:
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="#ffffff" ValidationGroup="editGroup" />
            </span>
        </div>
    
    <asp:FormView ID="fvSupplierDetails" runat="server" DataSourceId="supplierDataSource" DataKeyNames="id" Width="100%">
        <ItemTemplate>
            <div class="boxcontent">           
                <div id="disabled" class="errorBox" runat="server" Visible='<%# iif(Eval("global"), true, false) %>'>
                    <p>You can't edit this Supplier.</p>
                </div>

                <div class="div50">
                    <div class="row">
                        <label for="rtbSupplierName" title="Supplier Name" class="label">Supplier Name</label>
                        <%#Eval("supplierName")%>&nbsp;
                    </div>

                    <div class="row">
                        <label for="rtbTel" title="Tel" class="label">Telephone</label>
                        <%#Eval("tel")%>&nbsp;
                    </div>
                                                                        
                    <div class="row">
                        <label for="rtbFax" title="Tel" class="label">Fax</label>
                        <%#Eval("fax")%>&nbsp;
                    </div>
                                                
                    <div class="row">
                        <label for="rtbEmail" title="Email" class="label">Email</label>
                        <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# "mailto:" & Eval("email")%>' Text='<%#Eval("email")%>' />&nbsp;
                    </div>
                                                
                    <div class="row">
                        <label for="rtbWebsite" title="Website" class="label">Website</label>
                        <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl='<%# Eval("url")%>' Text='<%#Eval("url")%>' Target="_blank" />&nbsp;
                    </div>
                </div>

                <div class="div50r">
                    <div class="row">
                        <label for="rtbAddress1" title="Address" class="label">Address</label>
                        <%#Eval("address1")%>&nbsp;
                    </div>
                                                                        
                    <div class="row">
                        <label for="rtbAddress2" title="Address 2" class="label">&nbsp;</label>
                        <%#Eval("address2")%>&nbsp;
                    </div>
                                                                        
                    <div class="row">
                        <label for="rtbAddress3" title="Address 3" class="label">&nbsp;</label>
                        <%#Eval("address3")%>&nbsp;
                    </div>
                                                
                    <div class="row">
                        <label for="rtbCity" title="Town/City" class="label">Town/City</label>
                        <%#Eval("city")%>&nbsp;
                    </div>
                                                                        
                    <div class="row">
                        <label for="rtbCounty" title="County" class="label">County</label>
                        <%#Eval("county")%>&nbsp;
                    </div>
                                                                        
                    <div class="row">
                        <label for="rtbPostcode" title="Postcode" class="label">Postcode</label>
                        <%#Eval("postcode")%>&nbsp;
                    </div>
                                                                        
                    <div class="row">
                        <label for="rcbCountry" title="Country" class="label">Country</label>
                        <%#Eval("countryName")%>&nbsp;
                    </div>
                </div>
                                                                                         
                <div id="Div1" class="row" runat="server">
                    <label for="btns" class="label">&nbsp;</label>
                    <asp:Button
                        ID="btnEdit"
                        runat="server"
                        CommandName="Edit"
                        Text="Edit"
                        Enabled='<%# iif(Eval("global"), false, true) %>' />
                </div>
            </div>
        </ItemTemplate>
        <EditItemTemplate>
            <div class="boxcontent">
                <div class="div50">
                    <div class="row">
                        <label for="rtbSupplierName" title="Supplier Name" class="label">Supplier Name*</label>
                        <telerik:RadTextBox ID="rtbSupplierName" runat="server" Text='<%#Bind("supplierName") %>' Columns="35" EmptyMessage="Supplier Name" />
                                                    
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                            ControlToValidate="rtbSupplierName" ValidationGroup="editGroup"
                            Display="Dynamic" ErrorMessage="Supplier Name">
                            <span class="req"></span>
                        </asp:RequiredFieldValidator>
                    </div>

                    <div class="row">
                        <label for="rtbTel" title="Telephone" class="label">Telephone*</label>
                        <telerik:RadTextBox ID="rtbTel" runat="server" Text='<%#Bind("tel") %>' Columns="35" EmptyMessage="Telephone" />
                                                    
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server"
                            ControlToValidate="rtbTel" ValidationGroup="editGroup"
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
                </div>

                <div class="div50r">
                    <div class="row">
                        <label for="rtbAddress1" title="Address" class="label">Address*</label>
                        <telerik:RadTextBox ID="rtbAddress1" runat="server" Text='<%#Bind("address1") %>' Columns="35" EmptyMessage="Address" />
                                                    
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                            ControlToValidate="rtbAddress1" ValidationGroup="editGroup"
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
                            ControlToValidate="rtbPostcode" ValidationGroup="editGroup"
                            Display="Dynamic" ErrorMessage="Postcode">
                            <span class="req"></span>
                        </asp:RequiredFieldValidator>
                    </div>
                                                                        
                    <div class="row">
                        <label for="rcbCountry" title="Country" class="label">Country</label>
                        <telerik:RadComboBox ID="rcbCountry" runat="server" Height="140px" OnLoad="defaultCountry" SelectedValue='<%# Bind("countryId") %>'
                            DataSourceID="countryDataSource" DataTextField="countryName" DataValueField="id" />
                    </div>
                </div>
                
                <div class="row">
                    <label for="btns" class="label">&nbsp;</label>
                    <asp:Button ID="btnUpdate" runat="server" CommandName="Update"
                        OnClick="Validate_OnClick" Text="Update" />
                                                    
                    <asp:LinkButton ID="btnCancel" runat="server" CommandName="Cancel"
                        CausesValidation="False" Text="Cancel" />
                </div>
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
    
    <asp:SqlDataSource ID="countryDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="getCountries" />
</asp:Content>

