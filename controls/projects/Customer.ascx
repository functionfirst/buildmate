<%@ Control Language="VB" AutoEventWireup="false" CodeFile="Customer.ascx.vb" Inherits="controls_projects_customer" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

    <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlId="fvCustomerInsert">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="fvCustomerInsert" />
                     <telerik:AjaxUpdatedControl ControlID="notification" />
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
                            <asp:Label
                                ID="Label11"
                                runat="server"
                                Text="Name*"
                                CssClass="label"
                                AssociatedControlID="rtbFirstName" />
                            
                            <telerik:RadTextBox ID="rtbFirstName" runat="server"
                                Text='<%#Bind("firstname") %>' 
                                Width="300px"
                                EmptyMessage="Name" />
                        
                            <asp:RequiredFieldValidator
                                ID="RequiredFieldValidator1"
                                runat="server"
                                ControlToValidate="rtbFirstName"
                                ValidationGroup="insertGroup"
                                Display="Dynamic"
                                ErrorMessage="First Name">
                                <span class="req"></span>
                            </asp:RequiredFieldValidator>
                        </div>

                        <div class="row">
                            <asp:Label
                                ID="Label13"
                                runat="server"
                                Text="Company"
                                CssClass="label"
                                AssociatedControlID="rtbCompany" />
                            
                            <telerik:RadTextBox
                                ID="rtbCompany"
                                runat="server"
                                Text='<%#Bind("company") %>'
                                Columns="35"
                                EmptyMessage="Company" />
                        </div>
                                                    
                            <div class="row">
                            <asp:Label
                                ID="Label1"
                                runat="server"
                                Text="Job Title"
                                CssClass="label"
                                AssociatedControlID="rtbJobTitle" />
                    
                                <telerik:RadTextBox ID="rtbJobTitle" Width="300px" runat="server" Text='<%#Bind("jobtitle") %>' Columns="35" EmptyMessage="Job Title" />
                            </div>

                        <div class="row">
                            <asp:Label
                                ID="Label14"
                                runat="server"
                                Text="Address*"
                                CssClass="label"
                                AssociatedControlID="rtbAddress1" />
                            
                            <telerik:RadTextBox ID="rtbAddress1" runat="server" Text='<%#Bind("address1") %>'
                                TextMode="MultiLine" Width="300px" Rows="8" Columns="80" EmptyMessage="Address" />
                        
                            <asp:RequiredFieldValidator
                                ID="RequiredFieldValidator5"
                                runat="server"
                                ControlToValidate="rtbAddress1"
                                ValidationGroup="insertGroup"
                                Display="Dynamic"
                                ErrorMessage="Address">
                                <span class="req"></span>
                            </asp:RequiredFieldValidator>
                        </div>
                    
                        <div class="row">
                            <asp:Label
                                ID="Label18"
                                runat="server"
                                Text="Payment Terms"
                                CssClass="label"
                                AssociatedControlID="rcbPaymentTerms" />

                            <telerik:RadComboBox
                                ID="rcbPaymentTerms"
                                runat="server"
                                Height="80px"
                                Width="130px"
                                SelectedValue='<%# Bind("paymentTermsId") %>'
                                DataSourceID="paymentDataSource" 
                                DataTextField="paymentTerm"
                                DataValueField="id" />
                        </div>
                    </div>

                    <div class="md-footer">
                        <asp:Button ID="btnInsert" runat="server"
                            CommandName="Insert"
                            OnClientClick="validateModal()"
                            Text="Add Customer"
                            CssClass="button button-create"
                            ValidationGroup="insertGroup" />

                        <a href="#" class="md-close button">Close</a>
                    </div>
                </InsertItemTemplate>
            </asp:FormView>
        </div>
    </div>


<h3>Assign this Project to an existing Customer or create a New Customer</h3>

<p class="rightalign">
    <a href="#" class="js-open-modal button button-primary" data-target="addCustomer">Add a Customer</a>
</p>

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
                UniqueName="customerName"
                HeaderText="Name"
                SortExpression="customerName"
                DataTextField="customerName"
                DataNavigateUrlFields="id"
                DataNavigateUrlFormatString="customer_details.aspx?id={0}" />
                        
            <telerik:GridBoundColumn
                Visible="false"
                UniqueName="firstname"
                DataField="firstname"
                HeaderText="firstname"
                SortExpression="firstname" />
         
            <telerik:GridBoundColumn
                UniqueName="address"
                DataField="customerAddress"
                HeaderText="Address"
                SortExpression="customerAddress" />

            <telerik:GridBoundColumn
                DataField="city"
                HeaderText="Town/City" 
                SortExpression="city"
                UniqueName="city" />

            <telerik:GridBoundColumn
                DataField="county"
                HeaderText="County" 
                SortExpression="county"
                UniqueName="county" />

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
</div>
    
    <asp:HiddenField ID="hfProjectId" runat="server" Value="0" />

    <asp:SqlDataSource ID="customersDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="
            SELECT UserContact.id, (title + ' ' + firstname + ' ' + surname) AS customerName, address1, city, county, postcode
            FROM UserContact, UserTitle
            WHERE (titleId = UserTitle.id) AND (UserContact.UserId = @UserId) AND archived = 0
            ORDER BY surname, firstname">
        <SelectParameters>
            <asp:SessionParameter Name="UserId" SessionField="UserId" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="titleDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="SELECT [id], [title] FROM UserTitle" />

    <asp:SqlDataSource ID="countryDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="SELECT [id], [countryName] FROM Country" />  

    <asp:SqlDataSource ID="insertCustomerDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        InsertCommand="insertUserContactDetails" InsertCommandType="StoredProcedure">
        <InsertParameters>
            <asp:SessionParameter name="UserId" SessionField="UserId" />
            <asp:Parameter Name="jobtitle" />
	        <asp:Parameter Name="address2" />
	        <asp:Parameter Name="address3" />
	        <asp:Parameter Name="county" />
	        <asp:Parameter Name="tel" />
	        <asp:Parameter Name="fax" />
	        <asp:Parameter Name="mobile" />
	        <asp:Parameter Name="business" />
	        <asp:Parameter Name="extension " />
	        <asp:Parameter Name="email" />
	        <asp:Parameter Name="paymentTermsId" DefaultValue="0" />
            <asp:Parameter Name="NewId" Direction="Output" Size="4" />
        </InsertParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="paymentDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="SELECT [id], [paymentTerm] FROM ProjectPaymentTerm" />