<%@ Page Title="Customer Details - BuildMate" Language="VB" MasterPageFile="~/common/Manager.master" AutoEventWireup="false" CodeFile="customer_details.aspx.vb" Inherits="manager_customer_details" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">

    <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlId="fvCustomerDetails">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="fvCustomerDetails" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    
    <div class="breadcrumb">
        <p>
            &lArr;
            <asp:HyperLink ID="hlBack" runat="server"
                NavigateUrl="customers.aspx"
                Text="Customers" />
        </p>
    </div>

                <asp:FormView ID="fvCustomerDetails" runat="server" DataSourceId="customerDataSource" DataKeyNames="id" Width="100%">
                    <ItemTemplate>
        <div class="box">
                    <h3>Customer Details</h3>
                    
                    <div class="boxcontent">

                        <div class="div33">
                            <div class="row">
                                <label title="Title" class="label">Title</label>
                                <%#Eval("title")%>
                            </div>
                            
                            <div class="row">
                                <label title="First Name" class="label">First Name</label>
                                <%#Eval("firstname")%>
                            </div>
                            
                            <div class="row">
                                <label title="Surname" class="label">Surname</label>
                                <%#Eval("surname")%>
                            </div>
                                                    
                            <div class="row">
                                <label title="Company" class="label">Company</label>
                                <%#Eval("company")%>&nbsp;
                            </div>
                                                    
                            <div class="row">
                                <label title="Job Title" class="label">Job Title</label>
                                <%#Eval("jobtitle")%>&nbsp;
                            </div>
                                                    
                            <div class="row">
                                <label title="Email" class="label">Email</label>
                                <asp:HyperLink ID="HyperLink1" runat="server"
                                    NavigateUrl='<%# "mailto:" & Eval("email")%>'
                                    Text='<%#Eval("email")%>' />&nbsp;
                            </div>
                            
                            <div class="row">
                                <label title="Payment Terms" class="label">Payment Terms</label>
                                <%#Eval("paymentTerm")%>&nbsp;
                            </div>
                            
                            </div>
                            
                            <div class="div33">

                            <div class="row">
                                <label title="Telephone" class="label">Telephone</label>
                                <%#Eval("tel")%>&nbsp;
                            </div>
                                                    
                            <div class="row">
                                <label title="Fax" class="label">Fax</label>
                                <%#Eval("fax")%>&nbsp;
                            </div>

                            <div class="row">
                                <label title="Mobile" class="label">Mobile</label>
                                <%#Eval("mobile")%>&nbsp;
                            </div>
                                                    
                            <div class="row">
                                <label title="Business" class="label">Business</label>
                                <%#Eval("business")%>&nbsp;
                            </div>
                                                    
                            <div class="row">
                                <label title="Extension" class="label">Extension</label>
                                <%#Eval("extension")%>&nbsp;
                            </div>
                            
                            </div>
                            
                            <div class="div33r">
                            <div class="row">
                                <label title="Address" class="label">Address</label>
                                <%#Eval("address1")%>&nbsp;
                            </div>
                                                    
                            <div class="row">
                                <label title="Address 2" class="label">&nbsp;</label>
                                <%#Eval("address2")%>&nbsp;
                            </div>
                                                    
                            <div class="row">
                                <label title="Address 3" class="label">&nbsp;</label>
                                <%#Eval("address3")%>&nbsp;
                            </div>
                            
                            <div class="row">
                                <label title="Town/City" class="label">Town/City</label>
                                <%#Eval("city")%>&nbsp;
                            </div>
                                                    
                            <div class="row">
                                <label title="County" class="label">County</label>
                                <%#Eval("county")%>&nbsp;
                            </div>
                                                    
                            <div class="row">
                                <label title="Postcode" class="label">Postcode</label>
                                <%#Eval("postcode")%>&nbsp;
                            </div>
                                                    
                            <div class="row">
                                <label title="Country" class="label">Country</label>
                                <%#Eval("countryName")%>&nbsp;
                            </div>
                            
                            </div>

                            
                                                    
                            <div class="row">
                                <label class="label">&nbsp;</label>
                                <asp:Button ID="btnEdit" runat="server" CommandName="Edit" Text="Edit Customer" />
                            </div>

                                <div class="clear"></div>
                        </div>
                        </div>


                    </ItemTemplate>
                    <EditItemTemplate> 
                    <div class="box">
                        <h3>Customer Details</h3>
                    
                        <div class="boxcontent">
                                <div class="div33">
                                
                                <div class="row">
                                    <asp:Label ID="Label3" runat="server"
                                        Text="Title"
                                        CssClass="label"
                                        AssociatedControlID="rcbTitle" />

                                    <telerik:RadComboBox ID="rcbTitle" runat="server"
                                        Width="50px"
                                        SelectedValue='<%# Bind("titleId") %>'
                                        DataSourceID="titleDataSource"
                                        DataTextField="title"
                                        DataValueField="id" />
                                </div>
                                
                                <div class="row">
                                    <asp:Label ID="Label2" runat="server"
                                        Text="First Name"
                                        CssClass="label"
                                        AssociatedControlID="rtbFirstName" />
                                        
                                    <telerik:RadTextBox ID="rtbFirstName" runat="server"
                                        Text='<%#Bind("firstname") %>'
                                        Columns="25"
                                        EmptyMessage="First Name" />
                               
                                    
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                        ControlToValidate="rtbFirstName"
                                        Display="Dynamic"
                                        ErrorMessage="First Name">
                                        <span class="req"></span>
                                    </asp:RequiredFieldValidator>
                                </div>
                               
                               <div class="row">
                                    <asp:Label ID="Label1" runat="server"
                                        Text="Surname"
                                        CssClass="label"
                                        AssociatedControlID="rtbSurname" />
                                        
                                    <telerik:RadTextBox ID="rtbSurname" runat="server"
                                        Text='<%#Bind("surname") %>'
                                        Columns="25"
                                        EmptyMessage="Surname" />

                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                                        ControlToValidate="rtbSurname"
                                        Display="Dynamic"
                                        ErrorMessage="Surname">
                                        <span class="req"></span>
                                    </asp:RequiredFieldValidator>
                                </div>
                                                        
                                <div class="row">
                                    <label for="rtbCompany" title="Company" class="label">Company</label>
                                    <telerik:RadTextBox ID="rtbCompany" runat="server"
                                        Text='<%#Bind("company") %>' EmptyMessage="Company" />
                                </div>
                                                        
                                <div class="row">
                                    <label for="rtbJobTitle" title="Job Title" class="label">Job Title</label>
                                    <telerik:RadTextBox ID="rtbJobTitle" runat="server"
                                        Text='<%#Bind("jobtitle") %>' EmptyMessage="Job Title" />
                                </div>
                                                        
                                <div class="row">
                                    <label for="rtbEmail" title="Email" class="label">Email</label>
                                    <telerik:RadTextBox ID="rtbEmail" runat="server"
                                        Text='<%#Bind("email") %>' EmptyMessage="Email" />
                                </div>
                                
                                
                                <div class="row">
                                    <label for="rcbPaymentTerms" title="Payment Terms" class="label">Payment Terms</label>
                                    <telerik:RadComboBox ID="rcbPaymentTerms" runat="server" Height="80px" Width="130px" SelectedValue='<%# Bind("paymentTermsId") %>'
                                        DataSourceID="paymentDataSource" DataTextField="paymentTerm" DataValueField="id" />
                                </div>
                                

                                </div>
                                
                                <div class="div33">
                                <div class="row">
                                    <label for="rtbTel" title="Telephone" class="label">Telephone</label>
                                    <telerik:RadTextBox ID="rtbTel" runat="server"
                                        Text='<%#Bind("tel") %>' EmptyMessage="Telephone" />
                                </div>
                                                        
                                <div class="row">
                                    <label for="rtbFax" title="Fax" class="label">Fax</label>
                                    <telerik:RadTextBox ID="rtbFax" runat="server" Text='<%#Bind("fax") %>' EmptyMessage="Fax" />
                                </div>

                                <div class="row">
                                    <label for="rtbMobile" title="Mobile" class="label">Mobile</label>
                                    <telerik:RadTextBox ID="rtbMobile" runat="server" Text='<%#Bind("mobile") %>' EmptyMessage="Mobile" />
                                </div>
                                                        
                                <div class="row">
                                    <label for="rtbBusiness" title="Business" class="label">Business</label>
                                    <telerik:RadTextBox ID="rtbBusiness" runat="server" Text='<%#Bind("business") %>' EmptyMessage="Business" />
                                </div>
                                                        
                                <div class="row">
                                    <label for="rtbExtension" title="Extension" class="label">Extension</label>
                                    <telerik:RadTextBox ID="rtbExtension" runat="server" Text='<%#Bind("extension") %>' EmptyMessage="Extension" Width="60px" />
                                </div>
                            </div>
                            <div class="div33r">
                                <div class="row">
                                    

                                    <label for="rtbAddress1" title="Address" class="label">Address*</label>
                                    <telerik:RadTextBox ID="rtbAddress1" runat="server" Text='<%#Bind("address1") %>' EmptyMessage="Address" />
                                    
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="rtbAddress1"
                                        Display="Dynamic" ErrorMessage="Address">
                                        <span class="req"></span>
                                    </asp:RequiredFieldValidator>
                                </div>
                                                        
                                <div class="row">
                                    <label for="rtbAddress2" title="Address 2" class="label">&nbsp;</label>
                                    <telerik:RadTextBox ID="rtbAddress2" runat="server" Text='<%#Bind("address2") %>' />
                                </div>
                                                        
                                <div class="row">
                                    <label for="rtbAddress3" title="Address 3" class="label">&nbsp;</label>
                                    <telerik:RadTextBox ID="rtbAddress3" runat="server" Text='<%#Bind("address3") %>' />
                                </div>
                                
                                <div class="row">
                                    <label for="rtbCity" title="Town/City" class="label">Town/City*</label>
                                    <telerik:RadTextBox ID="rtbCity" runat="server" Text='<%#Bind("city") %>' EmptyMessage="Town/City" />
                                    
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="rtbCity"
                                        Display="Dynamic" ErrorMessage="Town/City*">
                                        <span class="req"></span>
                                    </asp:RequiredFieldValidator>
                                </div>
                                                        
                                <div class="row">
                                    <label for="rtbCounty" title="County" class="label">County</label>
                                    <telerik:RadTextBox ID="rtbCounty" runat="server" Text='<%#Bind("county") %>' EmptyMessage="County" />
                                </div>

                                <div class="row">
                                    <label for="rtbPostcode" title="Postcode" class="label">Postcode*</label>
                                    <telerik:RadTextBox ID="rtbPostcode" runat="server" Text='<%#Bind("postcode") %>' EmptyMessage="Postcode" />
                                    
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="rtbPostcode"
                                        Display="Dynamic" ErrorMessage="Postcode*">
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
                                        Text="Save Changes" />
                                    <asp:LinkButton ID="btnCancel" runat="server" CommandName="Cancel"
                                       Text="Cancel" />
                                </div>

                                <div class="clear"></div>
                        </div>
                        </div>
                    </EditItemTemplate>
                </asp:FormView>

        <div class="box">
            <h3>Project History</h3>
            
            <div class="boxcontent">
       
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
                                UniqueName="startDate"
                                Headertext="Start Date"
                                HeaderStyle-HorizontalAlign="Center"
                                ItemStyle-HorizontalAlign="Center"
                                DataFormatString="{0:d}"
                                DataField="startDate" />

                            <telerik:GridBoundColumn
                                UniqueName="completionDate"
                                Headertext="Completion Date"
                                HeaderStyle-HorizontalAlign="Center"
                                ItemStyle-HorizontalAlign="Center"
                                DataFormatString="{0:d}"
                                DataField="completionDate" />

                            <telerik:GridBoundColumn
                                UniqueName="returnDate"
                                Headertext="Return Date"
                                HeaderStyle-HorizontalAlign="Center"
                                ItemStyle-HorizontalAlign="Center"
                                DataFormatString="{0:d}"
                                DataField="returnDate" />

                            <telerik:GridBoundColumn
                                UniqueName="creationDate"
                                Headertext="Creation Date"
                                HeaderStyle-HorizontalAlign="Center"
                                ItemStyle-HorizontalAlign="Center"
                                DataFormatString="{0:d}"
                                DataField="creationDate" />
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </div>
        </div>
                
    <asp:SqlDataSource ID="customerDataSource" runat="server" ConflictDetection="CompareAllValues"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>" OldValuesParameterFormatString="original_{0}"
        SelectCommand="getUserContactDetails" SelectCommandType="StoredProcedure"
        UpdateCommand="updateUserContactDetails" UpdateCommandType="StoredProcedure"
        InsertCommand="insertUserContactDetails" InsertCommandType="StoredProcedure">
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

    <asp:SqlDataSource
        ID="titleDataSource"
        runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="getUserTitle"
        SelectCommandType="StoredProcedure" />

    <asp:SqlDataSource
        ID="countryDataSource"
        runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="getCountries"
        SelectCommandType="StoredProcedure" /> 

    <asp:SqlDataSource ID="paymentDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="getProjectPaymentTerms"
        SelectCommandType="StoredProcedure" />
</asp:Content>