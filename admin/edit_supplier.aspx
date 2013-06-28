<%@ Page Title="Edit Supplier - Admin" Language="VB" MasterPageFile="~/common/admin.master" AutoEventWireup="false" CodeFile="edit_supplier.aspx.vb" Inherits="edit_supplier" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="head" ContentPlaceHolderID="head" Runat="Server"></asp:Content>

<asp:Content ID="Content" ContentPlaceHolderID="MainContent" Runat="Server">

 <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlId="fvSupplierDetails">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="fvSupplierDetails" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
   
   <p class="breadcrumb">
    <asp:HyperLink ID="hlBack" runat="server"
            NavigateUrl="~/suppliers.aspx"
            Text="Suppliers" />
        &raquo; Supplier Details
   </p>
   
   <div class="box">
    <h3>Supplier Details</h3>
    
    <asp:FormView
        ID="fvSupplierDetails"
        runat="server"
        DataSourceId="supplierDataSource"
        DataKeyNames="id"
        Width="100%">
        <ItemTemplate>
            <div class="boxcontent">
            
                                <div class="row">
                                    <label for="rtbSupplierName" title="Supplier Name" class="label">Supplier Name:</label>
                                    <%#Eval("supplierName")%>&nbsp;
                                </div>

                                <div class="row">
                                    <label for="rtbTel" title="Tel" class="label">Tel:</label>
                                    <%#Eval("tel")%>&nbsp;
                                </div>
                                                        
                                <div class="row">
                                    <label for="rtbFax" title="Tel" class="label">Fax:</label>
                                    <%#Eval("fax")%>&nbsp;
                                </div>
                                
                                <div class="row">
                                    <label for="rtbEmail" title="Email" class="label">Email:</label>
                                    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# "mailto:" & Eval("email")%>' Text='<%#Eval("email")%>' />&nbsp;
                                </div>
                                
                                <div class="row">
                                    <label for="rtbWebsite" title="Website" class="label">Website:</label>
                                    <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl='<%# Eval("url")%>' Text='<%#Eval("url")%>' Target="_blank" />&nbsp;
                                </div>

                                <div class="row">
                                    <label for="rtbAddress1" title="Address" class="label">Address:</label>
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
                                    <label for="rtbCity" title="Town/City" class="label">Town/City:</label>
                                    <%#Eval("city")%>&nbsp;
                                </div>
                                                        
                                <div class="row">
                                    <label for="rtbCounty" title="County" class="label">County:</label>
                                    <%#Eval("county")%>&nbsp;
                                </div>
                                                        
                                <div class="row">
                                    <label for="rtbPostcode" title="Postcode" class="label">Postcode:</label>
                                    <%#Eval("postcode")%>&nbsp;
                                </div>
                                                        
                                <div class="row">
                                    <label for="rcbCountry" title="Country" class="label">Country:</label>
                                    <%#Eval("countryName")%>&nbsp;
                                </div>
                                                                         
                                <div class="row">
                                    <label for="btns" class="label">&nbsp;</label>
                                    <asp:Button ID="btnEdit" runat="server" CommandName="Edit" Text="Edit" />
                                </div>
                            </div>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <div class="boxcontent">
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
                                    <telerik:RadTextBox ID="rtbPostcode" runat="server" Text='<%#Bind("postcode") %>' EmptyMessage="Telephone" />
                                    
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
                                                        
                                <div class="row">
                                    <label for="btns" class="label">&nbsp;</label>
                                    <asp:Button ID="btnUpdate" runat="server" CommandName="Update"
                                        OnClick="Validate_OnClick" Text="Update" />
                                    
                                    <asp:Button ID="btnCancel" runat="server" CommandName="Cancel"
                                        CausesValidation="False" Text="Cancel" />
                                </div>
                            </div>
                        </EditItemTemplate>
                    </asp:FormView>
                    
                     </div>
                     
    <asp:SqlDataSource
        ID="supplierDataSource"
        runat="server"
        ConflictDetection="CompareAllValues"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        OldValuesParameterFormatString="original_{0}"
        SelectCommand="
            SELECT Supplier.id, supplierName, tel, fax, email, url, address1, address2, address3, city, county, postcode, countryId, countryName, userId
            FROM Supplier, Country
            WHERE Country.id = countryId AND Supplier.id = @supplierId"
        UpdateCommand="UPDATE Supplier SET
                supplierName = @supplierName,
                address1 = @address1,
                address2 = @address2,
                address3 = @address3,
                 city = @city,
                 county = @county,
                 postcode = @postcode,
                 countryId = @countryId,
                 tel = @tel,
                 fax = @fax,
                 email = @email,
                 url = @url
	        WHERE id = @original_id">
        <SelectParameters>
            <asp:QueryStringParameter Name="SupplierId" QueryStringField="sid" />
        </SelectParameters>
    </asp:SqlDataSource>
    
    <asp:SqlDataSource ID="countryDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="SELECT [id], [countryName] FROM Country" />
</asp:Content>