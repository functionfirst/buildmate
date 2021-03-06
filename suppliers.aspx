﻿<%@ Page Language="VB" MasterPageFile="~/common/Manager.master" AutoEventWireup="false" CodeFile="suppliers.aspx.vb" Inherits="manager_Default" title="Suppliers - Buildmate" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="head" ContentPlaceHolderID="head" Runat="Server">
    <asp:Panel ID="addSupplierScript" runat="server" Visible="false">
        <script>
            $(document).ready(function () {
                $('.js-open-modal').click();
            });
        </script>
    </asp:Panel>

    <telerik:RadScriptBlock ID="rsbPhase0" runat="server" Visible="false">
    <script type="text/javascript">
        var data = {
            target: "#ctl00_hlCustomers",
            progress: 0,
            tooltip: {
                title: "Welcome to Buildmate",
                content: "Add your first Customer. Click the Customers link above to begin.",
                videoId: "QxhB-S1UoG4"
            }
        };
        bm.tour(data);
    </script>
    </telerik:RadScriptBlock>

    <telerik:RadScriptBlock ID="rsbPhase1" runat="server" Visible="false">
    <script type="text/javascript">
        var data = {
            target: "#ctl00_hlProjects",
            progress: 1,
            tooltip: {
                title: "Managing Projects",
                content: "Now you've created your first Customer, the next step is to create a Project for them.<br /><br />Click Projects in the top menu to get started."
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
            target: "#ctl00_MainContent_rgSuppliers_ctl00 td:first-child a",
            progress: 2,
            tooltip: {
                title: "Suppliers Manager",
                content: "<strong>This is where you will find a list of all your suppliers.</strong><br><br>To Add 'Your Company Name' click the default Supplier Name blue text 'Your Company' located above. <em>Help: Suppliers provide all your resources and up to date prices. Buildmate has already set up your company as a default supplier called 'Your Company' but you will need to change this to your company name. Your Company will provide the labour and one or more Builders Merchants and Plant hire companies will provide you with the materials and plant for each project.</em>"
            }
        };

        $(document).ready(function () {
            bm.tour(data);
        });
    </script>
    </telerik:RadScriptBlock>

    <telerik:RadScriptBlock ID="rsbPhase7" runat="server" Visible="false">
    <script type="text/javascript">
        var data = {
            target: ".breadcrumb .button-create",
            progress: 2,
            tooltip: {
                title: "Suppliers",
                content: "Click on the green button 'New Supplier' located on the right.<br><br><em>Help: You can add unlimited suppliers and prioritise their use within each estimate.</em>"
            }
        };

        $(document).ready(function () {
            bm.tour(data);

            $('.breadcrumb .button-create').on('click', function () {

                var data = {
                    target: "#ctl00_MainContent_fvSupplierInsert_btnInsert",
                    progress: 2,
                    tooltip: {
                        title: "Adding a Supplier",
                        content: "Enter the supplier's details and click the green button 'Add Supplier' located at the bottom of the form to update the changes.<br><br><em>Help: You will need to add an 'ADDRESS' and a 'POSTCODE'. All other details are optional. On completion of the tutorial you can add unlimited suppliers and prioritise their use.</em>"
                    }
                };

                bm.tour(data);
            });
        });
    </script>
    </telerik:RadScriptBlock>

    <telerik:RadScriptBlock ID="rsbPhase8" runat="server" Visible="false">
    <script type="text/javascript">
        var data = {
            target: "#ctl00_hlResources",
            progress: 2,
            tooltip: {
                title: "Now that you have a supplier you will need to link the resource you added to your job task to your supplier",
                content: "<strong>Resources</strong><br>To Add a 'Resource to a Supplier' click 'Resources' on the tool bar above.<br><br><em>Help: Price maintenance - due to the variance in resource prices from region to region and the amount of trade discount your company receives. Buildmate is unable to provide you with accurate up to date prices for resources that are used within your estimates. To ensure you are using up to date prices you will need to link all the resources and their up to date prices you have used in your estimates to your suppliers.</em>"
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
    <div id="addSupplier" class="md-window" data-modal="addSupplier">
        <div class="md-content">
            <h3>Adding a Supplier..</h3>
            
            <asp:FormView ID="fvSupplierInsert" runat="server"
                DataSourceId="insertSupplierDataSource"
                Width="100%"
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
        <asp:Panel ID="pMainPanel" runat="server">
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
       </asp:Panel>
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