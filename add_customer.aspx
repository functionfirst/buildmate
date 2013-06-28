<%@ Page Title="Add a Customer - BuildMate" Language="VB" MasterPageFile="~/common/Manager.master" AutoEventWireup="false" CodeFile="add_customer.aspx.vb" Inherits="manager_add_customer" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
        <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlId="fvCustomerInsert">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="fvCustomerInsert" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>



<div class="breadcrumb">
    <p>
       &laquo; <asp:HyperLink ID="HyperLink1" runat="server"
            NavigateUrl="customers.aspx"
            Text="Customers" />
    </p>
</div>



    <asp:FormView
        ID="fvCustomerInsert"
        runat="server"
        DataSourceId="insertCustomerDataSource"
        DefaultMode="Insert"
        DataKeyNames="id"
        Width="100%">
        <InsertItemTemplate>
            <div class="box">
                <h3>Add a Customer</h3>
                
                <asp:Panel
                    ID="Panel1"
                    runat="server"
                    DefaultButton="btnInsert"
                    CssClass="boxcontent">
                    
                    <table border="0" cellspacing="0" cellpadding="0" width="100%">
                        <tr>
                            <td width="50%">
                            <div class="row">
                                <label for="rcbTitle" title="Title" class="label">Title</label>
                                <telerik:RadComboBox ID="rcbTitle" runat="server" Width="70px" SelectedValue='<%# Bind("titleId") %>'
                                    DataSourceID="titleDataSource" DataTextField="title" DataValueField="id" />
                            </div>
                                                    
                            <div class="row">

                                <label for="rtbFirstname" title="First Name" class="label">First Name*</label>
                                <telerik:RadTextBox ID="rtbFirstName" runat="server" Text='<%#Bind("firstname") %>' Columns="35" EmptyMessage="First Name" />
                                
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="rtbFirstName" ValidationGroup="insertGroup"
                                    Display="Dynamic" ErrorMessage="First Name">
                                    <span class="req"></span>
                                </asp:RequiredFieldValidator>
                            </div>

                            <div class="row">
                                

                                <label for="rtbSurname" title="Surname" class="label">Surname*</label>
                                <telerik:RadTextBox ID="rtbSurname" runat="server" Text='<%#Bind("surname") %>' Columns="35" EmptyMessage="Surname" />
                                
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="rtbSurname" ValidationGroup="insertGroup"
                                    Display="Dynamic" ErrorMessage="Surname">
                                    <span class="req"></span>
                                </asp:RequiredFieldValidator>
                            </div>
                                                    
                            <div class="row">
                                <label for="rtbCompany" title="Company" class="label">Company</label>
                                <telerik:RadTextBox ID="rtbCompany" runat="server" Text='<%#Bind("company") %>' Columns="35" EmptyMessage="Company" />
                            </div>
                                                    
                            <div class="row">
                                <label for="rtbJobTitle" title="Job Title" class="label">Job Title</label>
                                <telerik:RadTextBox ID="rtbJobTitle" runat="server" Text='<%#Bind("jobtitle") %>' Columns="35" EmptyMessage="Job Title" />
                            </div>
                                                    
                            <div class="row">
                                <label for="rtbEmail" title="Email" class="label">Email</label>
                                <telerik:RadTextBox ID="rtbEmail" runat="server"
                                Text='<%#Bind("email") %>' Columns="35" EmptyMessage="Email" />
                            </div>

                            <div class="row">
                                <label for="rtbTel" title="Telephone" class="label">Telephone</label>
                                <telerik:RadTextBox ID="rtbTel" runat="server"
                                    Text='<%#Bind("tel") %>'  Columns="35" EmptyMessage="Telephone" />
                            </div>
                                                    
                            <div class="row">
                                <label for="rtbFax" title="Fax" class="label">Fax</label>
                                <telerik:RadTextBox ID="rtbFax" runat="server" Text='<%#Bind("fax") %>'  Columns="35" EmptyMessage="Fax" />
                            </div>

                            <div class="row">
                                <label for="rtbMobile" title="Mobile" class="label">Mobile</label>
                                <telerik:RadTextBox ID="rtbMobile" runat="server" Text='<%#Bind("mobile") %>'  Columns="35" EmptyMessage="Mobile" />
                            </div>
                                                    
                            <div class="row">
                                <label for="rtbBusiness" title="Business" class="label">Business</label>
                                <telerik:RadTextBox ID="rtbBusiness" runat="server" Text='<%#Bind("business") %>'  Columns="35" EmptyMessage="Business" />
                            </div>
                                                    
                            <div class="row">
                                <label for="rtbExtension" title="Extension" class="label">Extension</label>
                                <telerik:RadTextBox ID="rtbExtension" runat="server" Text='<%#Bind("extension") %>' EmptyMessage="Extension" />
                            </div>
                                                    
                            <div class="row">
                                <label for="btns" class="label">&nbsp;</label>
                                <asp:Button ID="btnInsert" runat="server" CommandName="Insert"
                                    OnClick="Validate_Insert" Text="Add Customer" />
                            </div>
                        </td>
                        <td valign="top">

                            <div class="row">
                                

                                <label for="rtbAddress1" title="Address" class="label">Address*</label>
                                <telerik:RadTextBox ID="rtbAddress1" runat="server" Text='<%#Bind("address1") %>' Columns="35"  EmptyMessage="Address" />
                                
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="rtbAddress1" ValidationGroup="insertGroup"
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
                                
                            
                                <label for="rtbCity" title="Town/City" class="label">Town/City*</label>
                                <telerik:RadTextBox ID="rtbCity" runat="server" Text='<%#Bind("city") %>'  Columns="35" EmptyMessage="Town/City" />
                                
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="rtbCity" ValidationGroup="insertGroup"
                                    Display="Dynamic" ErrorMessage="Town/City">
                                    <span class="req"></span>
                                </asp:RequiredFieldValidator>
                            </div>
                                                    
                            <div class="row">
                                <label for="rtbCounty" title="County" class="label">County</label>
                                <telerik:RadTextBox ID="rtbCounty" runat="server" Text='<%#Bind("county") %>'  Columns="35" EmptyMessage="County" />
                            </div>

                            <div class="row">
                                

                                <label for="rtbPostcode" title="Postcode" class="label">Postcode*</label>
                                <telerik:RadTextBox ID="rtbPostcode" runat="server" Text='<%#Bind("postcode") %>' EmptyMessage="Postcode" />
                                
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="rtbPostcode"  ValidationGroup="insertGroup"
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
                                <label for="rcbPaymentTerms" title="Payment Terms" class="label">Payment Terms</label>
                                <telerik:RadComboBox ID="rcbPaymentTerms" runat="server" Height="80px" Width="130px" SelectedValue='<%# Bind("paymentTermsId") %>'
                                    DataSourceID="paymentDataSource" DataTextField="paymentTerm" DataValueField="id" />
                            </div>
                            </td>
                        </tr>
                    </table>
                
                </asp:Panel>
            </div> 
        </InsertItemTemplate>
    </asp:FormView>

    <asp:SqlDataSource
        ID="insertCustomerDataSource"
        runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        InsertCommand="insertUserContactDetails"
        InsertCommandType="StoredProcedure">
        <InsertParameters>
            <asp:SessionParameter name="UserId" SessionField="UserId" />
            <asp:Parameter Name="NewId" Type="Int64" Direction="Output" />
        </InsertParameters>
    </asp:SqlDataSource>
    
    <asp:SqlDataSource
        ID="titleDataSource"
        runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="getUserTitle" />

    <asp:SqlDataSource
        ID="countryDataSource"
        runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="getCountries" />  

    <asp:SqlDataSource
        ID="paymentDataSource"
        runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="getProjectPaymentTerms" />   
</asp:Content>

