<%@ Page Title="Customer Details - Buildmate" Language="VB" MasterPageFile="~/common/Manager.master" AutoEventWireup="false" CodeFile="customer_details.aspx.vb" Inherits="manager_customer_details" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">

    <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlId="fvCustomerDetails">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="fvCustomerDetails" />
                     <telerik:AjaxUpdatedControl ControlID="notification" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlId="btnArchive">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="btnArchive" />
                     <telerik:AjaxUpdatedControl ControlID="btnUnarchive" />
                     <telerik:AjaxUpdatedControl ControlID="notification" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlId="btnUnarchive">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="btnArchive" />
                     <telerik:AjaxUpdatedControl ControlID="btnUnarchive" />
                     <telerik:AjaxUpdatedControl ControlID="notification" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    
    <div class="breadcrumb">
        <div class="breadcrumb-container">
        <ul class="breadcrumb-options">
            <li>
                <asp:Button ID="btnArchive" runat="server"
                    CssClass="button button-error" Text="Archive this customer" />
            </li>
            <li>
                <asp:Button ID="btnUnarchive" runat="server"
                    CssClass="button button-primary" Text="Unarchive this Customer" />
            </li>
        </ul>
        <ul class="breadcrumb-list">
            <li>
                <asp:HyperLink ID="hlBack" runat="server"
                    NavigateUrl="customers.aspx"
                    Text="Customers" />
                <span class="divider">/</span>
            </li>
            <li class="active">
                Customer Details
            </li>
        </ul>
        </div>
    </div>

    <div class="main-container">
        <div class="div50">
        <h3>Customer Details</h3>

            <asp:FormView ID="fvCustomerDetails"
                runat="server"
                DefaultMode="Edit"
                DataSourceId="customerDataSource"
                DataKeyNames="id">
                <EditItemTemplate> 
                    <div class="row">
                        <asp:Label ID="Label2" runat="server"
                            Text="Name*"
                            CssClass="label"
                            AssociatedControlID="rtbName" />
                                        
                        <telerik:RadTextBox ID="rtbName" runat="server"
                            Text='<%#Bind("name")%>'
                            Width="300px"
                            EmptyMessage="Name" />

                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                            ControlToValidate="rtbName"
                            Display="Dynamic"
                            CssClass="required">
                            Name is required
                        </asp:RequiredFieldValidator>
                    </div>
                                                        
                    <div class="row">
                        <label for="rtbCompany" title="Company" class="label">Company</label>
                    
                        <telerik:RadTextBox ID="rtbCompany" runat="server"
                            Width="300px"
                            Text='<%#Bind("company") %>' EmptyMessage="Company" />
                    </div>
                                                        
                    <div class="row">
                        <label for="rtbJobTitle" title="Job Title" class="label">Job Title</label>
                    
                        <telerik:RadTextBox ID="rtbJobTitle" runat="server"
                            Width="300px"
                            Text='<%#Bind("jobtitle") %>' EmptyMessage="Job Title" />
                    </div>

                    <div class="row">
                        <label for="rtbAddress" title="Address" class="label">Address*</label>

                        <telerik:RadTextBox ID="rtbAddress" runat="server" Text='<%#Bind("address")%>'
                            InputType="Text" TextMode="MultiLine" Rows="4" Columns="80" Width="300" MaxLength="255" EmptyMessage="Address" />
                                    
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="rtbAddress"
                            Display="Dynamic" ErrorMessage="Address">
                            <span class="req"></span>
                        </asp:RequiredFieldValidator>
                    </div>

                    <div class="row">
                        <label for="rtbPostcode" title="Postcode" class="label">Postcode*</label>

                        <telerik:RadTextBox ID="rtbPostcode" runat="server" Text='<%#Bind("postcode") %>' Columns="35" MaxLength="8" EmptyMessage="Postcode" />

                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="rtbPostcode"
                            Display="Dynamic" ErrorMessage="Postcode">
                            <span class="req"></span>
                        </asp:RequiredFieldValidator>
                    </div>
                                                        
                    <div class="row">
                        <label for="rtbEmail" title="Email" class="label">Email</label>
                        <telerik:RadTextBox ID="rtbEmail" runat="server"
                            Text='<%#Bind("email") %>' EmptyMessage="Email" />
                    </div>

                    <div class="row">
                        <label for="rtbTel" title="Telephone" class="label">Telephone</label>
                        <telerik:RadTextBox ID="rtbTel" runat="server"
                            Text='<%#Bind("tel") %>' EmptyMessage="Telephone" />
                    </div>

                    <div class="row">
                        <label for="rtbMobile" title="Mobile" class="label">Mobile</label>
                        <telerik:RadTextBox ID="rtbMobile" runat="server" Text='<%#Bind("mobile") %>' EmptyMessage="Mobile" />
                    </div>
                                                        
                    <div class="row">
                        <label for="rtbFax" title="Fax" class="label">Fax</label>
                        <telerik:RadTextBox ID="rtbFax" runat="server" Text='<%#Bind("fax") %>' EmptyMessage="Fax" />
                    </div>

                    <div class="row">
                        <label for="rcbPaymentTerms" title="Payment Terms" class="label">Payment Terms</label>
                        <telerik:RadComboBox ID="rcbPaymentTerms" runat="server" Height="80px" Width="130px" SelectedValue='<%# Bind("paymentTermsId") %>'
                            DataSourceID="paymentDataSource" DataTextField="paymentTerm" DataValueField="id" />
                    </div>

                    <div class="form-actions">
                        <asp:Button ID="btnUpdate" runat="server" CommandName="Update" CssClass="button button-create" Text="Save Changes" />
                    </div>
                </EditItemTemplate>
            </asp:FormView>
        </div>

        <div class="div50 div-last">
            <h3>Customer Projects</h3>
            
                <telerik:RadGrid
                ID="rgProjects"
                runat="server"
                DataSourceID="projectsDataSource"
                GridLines="None"
                AutoGenerateColumns="False">
                <MasterTableView
                NoMasterRecordsText="&nbsp;No Projects were found for this customer"
                    DataSourceID="projectsDataSource"
                    DataKeyNames="id">
                    <Columns>
                        <telerik:GridHyperLinkColumn
                            UniqueName="projectLink"
                            HeaderText="Project Name"
                            DataTextField="projectName"
                            DataNavigateUrlFields="id"
                            DataTextFormatString="{0}"
                            DataNavigateUrlFormatString="~/project_details.aspx?pid={0}" />
                            
                        <telerik:GridBoundColumn
                            UniqueName="status"
                            Headertext="Status"
                            DataField="status" />
                            
                        <telerik:GridBoundColumn
                            UniqueName="projectType"
                            Headertext="Type"
                            DataField="projectType" />

                        <telerik:GridBoundColumn
                            UniqueName="created_at"
                            Headertext="Creation Date"
                            HeaderStyle-HorizontalAlign="Center"
                            ItemStyle-HorizontalAlign="Center"
                            DataFormatString="{0:d}"
                            DataField="created_at" />

                        <telerik:GridBoundColumn
                            UniqueName="returnDate"
                            Headertext="Return Date"
                            HeaderStyle-HorizontalAlign="Center"
                            ItemStyle-HorizontalAlign="Center"
                            DataFormatString="{0:d}"
                            DataField="returnDate" />
                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>
        </div>

    </div>
    
    <asp:SqlDataSource ID="customerDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="UserContact_Select" SelectCommandType="StoredProcedure"
        UpdateCommand="UserContact_Update" UpdateCommandType="StoredProcedure"
        InsertCommand="UserContact_Insert" InsertCommandType="StoredProcedure">
        <InsertParameters>
            <asp:SessionParameter name="UserId" SessionField="UserId" />
            <asp:Parameter Name="NewId" Type="Int64" Direction="Output" />
        </InsertParameters>
        <SelectParameters>
            <asp:SessionParameter name="UserId" SessionField="UserId" />
            <asp:QueryStringParameter Name="CustomerId" QueryStringField="id" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="projectsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="getProjectsByUserContact" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter name="UserId" SessionField="UserId" />
            <asp:QueryStringParameter Name="CustomerId" QueryStringField="id" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="paymentDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="getProjectPaymentTerms"
        SelectCommandType="StoredProcedure" />
</asp:Content>