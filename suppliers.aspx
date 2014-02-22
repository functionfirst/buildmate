<%@ Page Language="VB" MasterPageFile="~/common/Manager.master" AutoEventWireup="false" CodeFile="suppliers.aspx.vb" Inherits="manager_Default" title="Suppliers - Buildmate" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="head" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>

<asp:Content ID="Content" ContentPlaceHolderID="MainContent" Runat="Server">

    <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlId="rgSuppliers">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="rgSuppliers" />
                     <telerik:AjaxUpdatedControl ControlID="pNewSuppliers" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlId="pNewSuppliers">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="rgSuppliers" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlId="btnAddSupplier">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="rgSuppliers" />
                     <telerik:AjaxUpdatedControl ControlID="rcbSuppliers" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlId="fvSupplierInsert">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="fvSupplierInsert" />
                     <telerik:AjaxUpdatedControl ControlID="rgSuppliers" />
                     <telerik:AjaxUpdatedControl ControlID="notification" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>        
    </telerik:RadAjaxManagerProxy>

     <!-- begin add resource -->
    <div id="addSupplier" class="md-window">
        <div class="md-content">
            <h3>Adding a Supplier..</h3>
            
            <asp:FormView ID="fvSupplierInsert" runat="server"
                RenderOuterTable="false"
                DataSourceId="insertSupplierDataSource"
                DataKeyNames="id"
                DefaultMode="Insert">
                <InsertItemTemplate>
                    <asp:Panel ID="Panel1" runat="server" DefaultButton="btnInsert">
                        <div class="md-details">
                            <div class="row">
                                <label for="rtbSupplierName" title="Supplier Name" class="label">Supplier Name*</label>
                                <telerik:RadTextBox ID="rtbSupplierName" runat="server"
                                    Text='<%#Bind("supplierName") %>'
                                    MaxLength="50"
                                    Width="300px"
                                    Columns="35"
                                    EmptyMessage="Supplier Name" />
                                    
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                    ControlToValidate="rtbSupplierName" ValidationGroup="insertGroup"
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
                                    ControlToValidate="rtbAddress" ValidationGroup="insertGroup"
                                    Display="Dynamic" ErrorMessage="Address">
                                    <span class="req"></span>
                                </asp:RequiredFieldValidator>
                            </div>
                            
                            <div class="row">
                                <label for="rtbPostcode" title="Postcode" class="label">Postcode*</label>

                                <telerik:RadTextBox ID="rtbPostcode" runat="server" Text='<%#Bind("postcode")%>' Columns="35" EmptyMessage="Postcode" />

                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                                    ControlToValidate="rtbPostcode" ValidationGroup="insertGroup"
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

                        </div>

                        <div class="md-footer">
                            <asp:Button ID="btnInsert" runat="server" CommandName="Insert"
                                OnClientClick="validateModal()"
                                ValidationGroup="insertGroup" Text="Add Supplier" CssClass="button button-create" />
                    
                            <a href="#" class="button md-close">Close</a>
                        </div>
                    </asp:Panel>
                </InsertItemTemplate>
            </asp:FormView>
        </div>
    </div>

    <div class="breadcrumb">
        <div class="breadcrumb-container">
            <ul class="breadcrumb-options">
                <li><a href="#" data-target="addSupplier" class="js-open-modal button button-create">New Supplier</a></li>
            </ul>
        
            <ul class="breadcrumb-list">
                <li class="active">Suppliers</li>
            </ul>
        </div>
    </div>

    <div class="main-container">
        <div class="div75">
            <telerik:RadGrid ID="rgSuppliers" runat="server"
                    DataSourceID="suppliersDataSource"
                    AllowAutomaticUpdates="true"
                    AllowAutomaticDeletes="true"
                    AutoGenerateColumns="false"
                    GridLines="None"
                    AllowSorting="true"
                    ShowStatusBar="true">
                    <MasterTableView
                        DataSourceID="suppliersDataSource"
                        AutoGenerateColumns="False"
                        GridLines="None"
                        NoMasterRecordsText="&nbsp;No Suppliers were found."
                        DataKeyNames="id">
                 
                        <Columns>
                            <telerik:GridTemplateColumn
                                UniqueName="supplier"
                                HeaderText="Supplier Name">
                                <ItemTemplate>
                                    <asp:HyperLink ID="hlSupplier" runat="server" />
                                    <asp:Label ID="lblSupplier" runat="server" />
                                    <asp:Label ID="lblIsYou" runat="server" Visible="false"><br /><small>This is you..</small></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn
                                UniqueName="position"
                                HeaderText="Change Priority"
                                HeaderStyle-HorizontalAlign="Center" 
                                ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:HiddenField ID="hiddenId" runat="server" Value='<%# Bind("id") %>' />

                                    <asp:LinkButton ID="lbUp" runat="server"
                                        CommandArgument='<%# eval("position") %>'
                                        CssClass="pinArrow"
                                        ToolTip="Move Up"
                                        CommandName="MoveUp">&uArr;</asp:LinkButton>

                                    <asp:LinkButton ID="lbDown" runat="server" 
                                        CommandArgument='<%# eval("position") %>'
                                        ToolTip="Move Down"
                                        CssClass="pinArrow"
                                        CommandName="MoveDown">&dArr;</asp:LinkButton>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                    
                            <telerik:GridBoundColumn
                                UniqueName="isLocked"
                                HeaderText="isLocked"
                                Visible="false"
                                DataField="isLocked" />

                            <telerik:GridBoundColumn
                                UniqueName="supplierId"
                                HeaderText="supplierId"
                                Visible="false"
                                DataField="supplierId" />

                            <telerik:GridBoundColumn
                                UniqueName="supplierName"
                                HeaderText="supplierName"
                                Visible="false"
                                DataField="supplierName" />


                            <telerik:GridButtonColumn
                                ConfirmText="Remove this Supplier?"
                                ConfirmTitle="Delete"
                                ButtonType="ImageButton"
                                CommandName="Delete"
                                HeaderStyle-Width="5%"
                                Text="Delete"
                                UniqueName="DeleteColumn" />
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>    
        </div>

        <div class="div25 div-last">
            <asp:Panel ID="pNewSuppliers" runat="server">
                <div class="box">
                    <h3>Unused Suppliers</h3>

                    <div class="boxcontent">

                        <p>
                            Select a Supplier to use in your Projects.
                        </p>

                        <p>
                            <telerik:RadComboBox
                                ID="rcbSuppliers"
                                runat="server"
                                DataSourceID="newSupplierDataSource"
                                DataTextField="supplierName"
                                DataValueField="id" />
                        </p>

                        <div class="form-actions">
                            <asp:Button ID="btnAddSupplier" runat="server" Text="Add this Supplier" CssClass="button button-create" />
                        </div>
                    </div>
                </div>
            </asp:Panel>
        </div>
    </div>

    <asp:SqlDataSource
        ID="suppliersDataSource"
        runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        Deletecommand="deleteSupplierPriority"
        DeleteCommandType="StoredProcedure"
        SelectCommand="getSupplierPriorityListByUserId"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="UserId" SessionField="UserId" />
        </SelectParameters>
        <DeleteParameters>
            <asp:SessionParameter Name="UserId" SessionField="UserId" />
        </DeleteParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource
        ID="newSupplierDataSource"
        runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="getSuppliersNotAssignedToUser"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="UserId" SessionField="UserId" />
        </SelectParameters>
    </asp:SqlDataSource>

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


<asp:Content ID="SidebarContent" ContentPlaceHolderID="Sidebar" Runat="Server">
    <div class="tour-block">
        <div class="tour-inner">
            <a href="#" class="close" data-tour="close">&times;</a>
            
            <h1>Suppliers <span>Take a Tour</span></h1>

            <div class="tour-nav" data-tour="menu">
                <ul>
                    <li class="active"><a href="#" data-tab="step1">1. Suppliers</a></li>
                    <li><a href="#" data-tab="step2">2. Advanced Suppliers</a></li>
                </ul>
            </div>
            <div class="tour-content">
                <div data-target="step1">
                    <iframe width="640" height="480" src="//www.youtube.com/embed/FnVXWuZkhpQ" frameborder="0" allowfullscreen></iframe>

                    <div class="tour-control">
                        Step 1
                        <a href="#" data-tab-control="step2">Next</a>
                    </div>
                </div>
                
                <div data-target="step2" class="hide">
                    <iframe width="640" height="480" src="//www.youtube.com/embed/xxx" frameborder="0" allowfullscreen></iframe>
                    <div class="tour-control">
                        Step 2
                        <a href="#" class="restart" data-tab-control="step13">Restart</a>
                    </div>
                </div>
              
            </div>
        </div>
    </div>
</asp:Content>