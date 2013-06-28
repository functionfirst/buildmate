<%@ Page Language="VB" MasterPageFile="~/common/Manager.master" AutoEventWireup="false" CodeFile="suppliers.aspx.vb" Inherits="manager_Default" title="Suppliers - BuildMate" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="head" ContentPlaceHolderID="head" Runat="Server"></asp:Content>

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
        </AjaxSettings>        
    </telerik:RadAjaxManagerProxy>


    <div class="clear">

    <div class="div75">
    <div class="box">
        <h3>Suppliers</h3>

        <div class="boxcontent">
        
            <div class=" rightalign">
                <a href="add_supplier.aspx" class="button create">+ Add a Supplier</a>
            </div>

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
                        HeaderText="Change Position"
                        HeaderStyle-HorizontalAlign="Center" 
                        ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:HiddenField ID="hiddenId" runat="server" Value='<%# Bind("id") %>' />

                            <asp:LinkButton ID="LinkButton1" runat="server"
                                CommandArgument='<%# eval("position") %>'
                                CssClass="pinArrow"
                                ToolTip="Move Up"
                                CommandName="MoveUp">&uArr;</asp:LinkButton>

                            <asp:LinkButton ID="LinkButton2" runat="server" 
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
        </div>
    </div>

    <div class="div25r">
        <asp:Panel ID="pNewSuppliers" runat="server">
            <div class="box">
                <h3>Unused Suppliers</h3>

                <div class="boxcontent">

                        Select a Supplier to use in your Projects.

                    <p>
                        <telerik:RadComboBox
                            ID="rcbSuppliers"
                            runat="server"
                            DataSourceID="newSupplierDataSource"
                            DataTextField="supplierName"
                            DataValueField="id" />
                    </p>

                    <asp:Button ID="btnAddSupplier" runat="server" Text="Add" />
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
 </asp:Content>