<%@ Control Language="VB" AutoEventWireup="false" CodeFile="Customer.ascx.vb" Inherits="controls_projects_customer" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

    <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlId="fvCustomerInsert">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="fvCustomerInsert" />
                     <telerik:AjaxUpdatedControl ControlID="notification" />
                     <telerik:AjaxUpdatedControl ControlID="rgCustomers" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>

<script type="text/javascript">
    function validateModal() {
        if (typeof (Page_ClientValidate) == 'function') {
            Page_ClientValidate('insertGroup');
        }
        if (Page_IsValid) {
            hideModal()
            return true;
        }
        return false;
    }
</script>


    <div id="addCustomer" class="md-window">
        <div class="md-content">
            <h3>Add a Customer</h3>

            <asp:FormView
                ID="fvCustomerInsert"
                runat="server"
                DataSourceId="insertCustomerDataSource"
                DefaultMode="Insert"
                DataKeyNames="id"
                Width="100%">
                <InsertItemTemplate>
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
                </InsertItemTemplate>
            </asp:FormView>
        </div>
    </div>


<h3>3. Assign this Project to an existing Customer or create a New Customer</h3>

<telerik:RadGrid
    ID="rgCustomers"
    runat="server"
    EnableLinqExpressions="false"
    DataSourceID="customersDataSource"
    AllowAutomaticDeletes="true"
    AllowPaging="true"
    EnableAJAX="True"
    GridLines="None"
    PageSize="10"
    AllowRowSelect="True"
    PagerStyle-Mode="NextPrev"
    AutoGenerateColumns="false"
    ShowStatusBar="true"
    AllowSorting="true">
    <MasterTableView
        DataSourceID="customersDataSource"
        AutoGenerateColumns="False"
        GridLines="None"
        DataKeyNames="id"
        NoMasterRecordsText="&nbsp;No Customers were found.">
        <Columns>
            <telerik:GridTemplateColumn UniqueName="CheckBoxTemplateColumn">
                <ItemTemplate>
                  <asp:CheckBox ID="CheckBox1" runat="server" OnCheckedChanged="ToggleRowSelection"
                    AutoPostBack="True" />
                </ItemTemplate>
              </telerik:GridTemplateColumn>
                        
            <telerik:GridBoundColumn
                DataField="id"
                UniqueName="id"
                Visible="false" />

            <telerik:GridHyperLinkColumn
                UniqueName="name"
                HeaderText="Name"
                SortExpression="name"
                DataTextField="name"
                DataNavigateUrlFields="id"
                DataNavigateUrlFormatString="customer_details.aspx?id={0}" />
         
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

<div class="form-actions">
    <asp:LinkButton ID="lbBack" runat="server" CssClass="button">
        &laquo; Back
    </asp:LinkButton>
    <asp:LinkButton ID="lbDetails" runat="server" CssClass="button button-primary" Enabled="false">
        You must select a Customer above
    </asp:LinkButton>

    <a href="#" class="js-open-modal button button-create" data-target="addCustomer">New Customer</a>
</div>
    
    <asp:HiddenField ID="hfProjectId" runat="server" Value="0" />

    <asp:SqlDataSource ID="customersDataSource" runat="server"
        FilterExpression="archived = 0"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="UserContact_GetByUserId"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="UserId" SessionField="UserId" />
        </SelectParameters>
    </asp:SqlDataSource>
 
    <asp:SqlDataSource ID="insertCustomerDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        InsertCommand="UserContact_Insert" InsertCommandType="StoredProcedure">
        <InsertParameters>
            <asp:SessionParameter name="UserId" SessionField="UserId" />
            <asp:Parameter Name="NewId" Direction="Output" Size="4" />
        </InsertParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="paymentDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="SELECT [id], [paymentTerm] FROM ProjectPaymentTerm" />