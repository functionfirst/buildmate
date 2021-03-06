﻿<%@ Page Language="VB" MasterPageFile="~/common/Manager.master" AutoEventWireup="false" CodeFile="customers.aspx.vb" Inherits="manager_Default" title="Customers - Buildmate" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="head" ContentPlaceHolderID="head" Runat="Server">
    <asp:Panel ID="addCustomerScript" runat="server" Visible="false">
        <script>
            $(document).ready(function () {
                $('.js-open-modal').click();
            });
        </script>
    </asp:Panel>

    <telerik:RadScriptBlock ID="rsbPhase0" runat="server" Visible="false">
    <script type="text/javascript">
        var data = {
            target: "#newCustomer",
            progress: 0,
            tooltip: {
                title: "Customer Manager",
                content: "<strong>This is where you will find a list of all your customers.</strong><br/><br/>To 'Add a Customer' - Click on the green button 'New Customer' located to the right.<br/><br/><em>Help: As you have not yet added any customers there are no customer details to display.</em>",
                direction: "right"
            }
        };

        $(document).ready(function () {
            bm.tour(data);

            $('#newCustomer').on('click', function () {
                var data = {
                    target: "#ctl00_MainContent_fvCustomerInsert_btnInsert",
                    progress: 0,
                    tooltip: {
                        title: "Creating a Customer",
                        content: "Enter your customer/client details and then click the green button 'Add Customer' located at the bottom of the form.<br><br><em>Help: 'NAME', 'ADDRESS' AND 'POSTCODE' are required fields; you will also need to select a payment method from the drop down menu ‘PAYMENT TERMS’. ‘COMPANY NAME’ is the name of the customer’s company if they have one and 'TITLE' is their company title.</em>",
                        direction: "right"
                    }
                };

                bm.tour(data);
            })
        });
    </script>
    </telerik:RadScriptBlock>

    <telerik:RadScriptBlock ID="rsbPhase1" runat="server" Visible="false">
    <script type="text/javascript">
        var data = {
            target: "#ctl00_hlProjects",
            progress: 1,
            tooltip: {
                title: "Managing Projects",
                content: "To 'Add a Project/Estimate' - Click 'Projects' located on the tool bar above.<br><br><em>Help: Now that you have added a customer you can create a Project/Estimate for them.</em>"
            }
        };

        $(document).ready(function () {
            bm.tour(data);
        });
    </script>
    </telerik:RadScriptBlock>

    <telerik:RadScriptBlock ID="rsbPhase6" runat="server" Visible="false">
    <script type="text/javascript">
        var data = {
            target: "#ctl00_hlSuppliers",
            progress: 2,
            tooltip: {
                title: "Managing your Suppliers",
                content: "Now that you've added your first Resource, it's important you understand how Suppliers work.<br /><br />Click the Suppliers link above to begin."
            }
        };

        $(document).ready(function () {
            bm.tour(data);
        });
    </script>
    </telerik:RadScriptBlock>

    <telerik:RadScriptBlock ID="rsbPhase8" runat="server" Visible="false">
    <script type="text/javascript">
        var data = {
            target: "#ctl00_hlResources",
            progress: 2,
            tooltip: {
                title: "Managing Resources",
                content: "Now that you've setup some Suppliers lets link your Resources to your Suppliers.<br /><br />Click the Resources link above to begin."
            }
        };

        $(document).ready(function () {
            bm.tour(data);
        });
    </script>
    </telerik:RadScriptBlock>
</asp:Content>

<asp:Content ID="Content" ContentPlaceHolderID="MainContent" Runat="Server">

    <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlId="pCustomerSearch">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="rgCustomers" />
                     <telerik:AjaxUpdatedControl ControlID="pCustomerSearch" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlId="rgCustomers">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="rgCustomers" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
  
    <!-- begin add customer -->
    <asp:Panel ID="addCustomer" runat="server" class="md-window" data-modal="addCustomer">
        <div class="md-content">
            <h3>Adding a Customer..</h3>

            <asp:FormView
                ID="fvCustomerInsert"
                runat="server"
                Width="100%"
                DataSourceId="insertCustomerDataSource"
                DefaultMode="Insert"
                DataKeyNames="id">
                <InsertItemTemplate>
                    <asp:Panel ID="pCustomerInsert" runat="server" DefaultButton="btnInsert">
                        <div class="md-details">
                            <div class="row">
                                <label for="rtbName" title="Name" class="label">Name*</label>
                    
                                <telerik:RadTextBox ID="rtbName" runat="server" Text='<%#Bind("name")%>' 
                                    Width="300px" EmptyMessage="Name" />
                                
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="rtbName" ValidationGroup="insertGroup"
                                    Display="Dynamic" ErrorMessage="Name">
                                    <span class="req"></span>
                                </asp:RequiredFieldValidator>
                            </div>
                                                    
                            <div class="row">
                                <label for="rtbCompany" title="Company" class="label">Company</label>
                    
                                <telerik:RadTextBox ID="rtbCompany" Width="300px" runat="server" Text='<%#Bind("company") %>' Columns="35" EmptyMessage="Company" />
                            </div>
                                                    
                            <div class="row">
                                <label for="rtbJobTitle" title="Job Title" class="label">Job Title</label>
                    
                                <telerik:RadTextBox ID="rtbJobTitle" Width="300px" runat="server" Text='<%#Bind("jobtitle") %>' Columns="35" EmptyMessage="Job Title" />
                            </div>

                            <div class="row">
                                <label for="rtbAddress" title="Address" class="label">Address*</label>
                    
                                <telerik:RadTextBox ID="rtbAddress" runat="server" Text='<%#Bind("address")%>' TextMode="MultiLine"
                                    Width="300px" Rows="4" Columns="80"  EmptyMessage="Address" />
                                
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="rtbAddress" ValidationGroup="insertGroup"
                                    Display="Dynamic" ErrorMessage="Address">
                                    <span class="req"></span>
                                </asp:RequiredFieldValidator>
                            </div>

                            <div class="row">
                                <label for="rtbPostcode" title="Postcode" class="label">Postcode*</label>

                                <telerik:RadTextBox ID="rtbPostcode" runat="server" Text='<%#Bind("postcode") %>' Columns="35" EmptyMessage="Postcode" />

                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="rtbPostcode" ValidationGroup="insertGroup"
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
                    
                                <telerik:RadTextBox ID="rtbTel" runat="server" Text='<%#Bind("tel") %>'  Columns="35" EmptyMessage="Telephone" />
                            </div>

                            <div class="row">
                                <label for="rtbMobile" title="Mobile" class="label">Mobile</label>
                    
                                <telerik:RadTextBox ID="rtbMobile" runat="server" Text='<%#Bind("mobile") %>'  Columns="35" EmptyMessage="Mobile" />
                            </div>
                                                    
                            <div class="row">
                                <label for="rtbFax" title="Fax" class="label">Fax</label>
                    
                                <telerik:RadTextBox ID="rtbFax" runat="server" Text='<%#Bind("fax") %>'  Columns="35" EmptyMessage="Fax" />
                            </div>

                            <div class="row">
                                <label for="rcbPaymentTerms" title="Payment Terms" class="label">Payment Terms</label>
                    
                                <telerik:RadComboBox ID="rcbPaymentTerms" runat="server" Height="80px" Width="130px" SelectedValue='<%# Bind("paymentTermsId") %>'
                                    DataSourceID="paymentDataSource" DataTextField="paymentTerm" DataValueField="id" />
                            </div>
                        </div>
                   
                        <div class="md-footer">
                            <asp:Button ID="btnInsert" runat="server" CommandName="Insert" CssClass="button button-create"
                            OnClientClick="validateModal()" Text="Add Customer" />
                            
                            <a href="#" class="button md-close">Close</a>
                        </div>
                    </asp:Panel>
                </InsertItemTemplate>
            </asp:FormView>
        </div>
    </asp:Panel>
    
    <div class="breadcrumb">
        <div class="breadcrumb-container">
            <ul class="breadcrumb-options">
                <li><a href="#" id="newCustomer" data-target="addCustomer" class="js-open-modal button button-create">New Customer</a></li>
            </ul>

            <ul class="breadcrumb-list">
                <li class="active">Customers</li>
            </ul>
        </div>
    </div>

    <div class="main-container">
        <asp:Panel ID="pMainPanel" runat="server" Visible="true">
            <asp:Panel ID="pCustomerSearch" runat="server" DefaultButton="btnApplyFilter" CssClass="search-panel">
                <telerik:RadTextBox
                    ID="rtbFilter"
                    runat="server"
                    AutoPostBack="true"
                    CssClass="search-input"
                    EmptyMessage="Search by customer name or address"
                    Width="220px" />

                <asp:CheckBox
                    ID="cbArchived"
                    runat="server"
                    AutoPostBack="true"
                    Text="Include archived customers" />

                <asp:Button
                    ID="btnApplyFilter"
                    runat="server"
                    CssClass="button button-primary"
                    Text="Apply Filters" />

                <asp:LinkButton
                        ID="btnRemoveFilter"
                        runat="server"
                        CssClass="button"
                        Text="clear" />
            </asp:Panel>
    
            <telerik:RadGrid
                ID="rgCustomers"
                runat="server"
                EnableLinqExpressions="false"
                DataSourceID="allCustomersDataSource"
                AllowAutomaticDeletes="true"
                AllowPaging="true"
                EnableAJAX="True"
                GridLines="None"
                PageSize="20"
                PagerStyle-Mode="NextPrev"
                AutoGenerateColumns="false"
                ShowStatusBar="true"
                AllowSorting="true">
                <MasterTableView
                    DataSourceID="allCustomersDataSource"
                    AutoGenerateColumns="False"
                    FilterExpression=""
                    GridLines="None"
                    DataKeyNames="id"
                    NoMasterRecordsText="&nbsp;You have not added any Customers yet.">
                    <Columns>
                        <telerik:GridTemplateColumn UniqueName="name" HeaderText="Name" SortExpression="name">
                            <ItemTemplate>
                                <asp:HyperLink ID="HyperLink1" runat="server"
                                    NavigateUrl='<%#Eval("id", "~/customer_details.aspx?id={0}")%>'><%#Eval("name") %></asp:HyperLink>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        
                        <telerik:GridBoundColumn
                            UniqueName="address"
                            DataField="address"
                            HeaderText="Address"
                            SortExpression="address" />

                        <telerik:GridBoundColumn
                            DataField="postcode"
                            HeaderText="Postcode" 
                            SortExpression="postcode"
                            UniqueName="postcode" />
                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>

        </asp:Panel>
    </div>


    <asp:SqlDataSource
        ID="allCustomersDataSource"
        runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        FilterExpression="archived = 0"
        SelectCommand="UserContact_GetByUserId"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter
                Name="UserId"
                SessionField="UserId" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource
        ID="insertCustomerDataSource"
        runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        InsertCommand="UserContact_Insert"
        InsertCommandType="StoredProcedure">
        <InsertParameters>
            <asp:SessionParameter name="UserId" SessionField="UserId" />
            <asp:Parameter Name="NewId" Type="Int64" Direction="Output" />
        </InsertParameters>
    </asp:SqlDataSource>
    
    <asp:SqlDataSource
        ID="paymentDataSource"
        runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="getProjectPaymentTerms" /> 
</asp:Content>