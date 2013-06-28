<%@ Page Language="VB" MasterPageFile="~/common/Manager.master" AutoEventWireup="false"
    CodeFile="catalogue.aspx.vb" Inherits="catalogue" Title="Catalogue - BuildMate" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="head" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content" ContentPlaceHolderID="MainContent" runat="Server">

    <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlId="Panel1">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="Panel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlId="btnApplyFilter">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="rgCatalogue" />
                     <telerik:AjaxUpdatedControl ControlID="pAddCatalogue" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlId="rgCatalogue">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="rgCatalogue" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>

    <p class="breadcrumb">
        Catalogue
    </p>
    
    <asp:Panel ID="pNoSupplier" runat="server" Visible="false" CssClass="errorBox">
        <p>
            <strong>Supplier required</strong><br />
            You will need to <a href="add_supplier.aspx">add your own supplier</a> before you can customise your Resource Catalogue.
        </p>
    </asp:Panel>

    <div class="sidebar">
        <asp:Panel ID="Panel1" runat="server" DefaultButton="btnApplyFilter">
        <fieldset>
            <legend title="Search Catalogue">Search Catalogue</legend>
            
            <div class="row">
                <asp:Label ID="Label3" runat="server"
                    Text="Supplier"
                    CssClass="label"
                    AssociatedControlID="rcbSupplier" />

                <telerik:RadComboBox ID="rcbSupplier" runat="server"
                    Width="180px"
                    DataSourceID="supplierDataSource"
                    DataTextField="supplierName"
                    DataValueField="id" />
                    
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                        ControlToValidate="rcbSupplier"
                        Display="Dynamic"
                        ErrorMessage="Supplier">
                        <span class="req"></span>
                    </asp:RequiredFieldValidator>
            </div>
            
            <div class="row">
                <asp:Label ID="Label1" runat="server"
                    AssociatedControlID="rcbresourceType"
                    CssClass="label"
                    Text="Resource Type" />

                <telerik:RadComboBox ID="rcbresourceType" runat="server"
                    AutoPostBack="true">
                    <Items>
                        <telerik:RadComboBoxItem Text="Labour" Value="1" Selected="true" />
                        <telerik:RadComboBoxItem Text="Material" Value="2" />
                        <telerik:RadComboBoxItem Text="Plant &amp; Equipment" Value="3" />
                    </Items>
                </telerik:RadComboBox>
            </div>
            
            <div class="row">
                <asp:Label ID="Label2" runat="server"
                    AssociatedControlID="rcbResources"
                    CssClass="label"
                    Text="Resource Name" />

                    <telerik:RadComboBox ID="rcbResources" runat="server"
                        Width="180px"
                        Height="150px"
                        IsCaseSensitive="false"
                        ItemsPerRequest="20"
                        DropDownWidth="380px"
                        EmptyMessage="contains any word(s)"
                        EnableLoadOnDemand="true"
                        ShowMoreResultsBox="true"
                        EnableVirtualScrolling="true"
                        MarkFirstMatch="true"
                        HighlightTemplatedItems="true"
                        Filter="Contains">
                        <HeaderTemplate>
                            <table border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td style="width: 200px;">Product Name</td>
                                    <td style="width: 100px;">Manufacturer</td>
                                    <td style="width: 80px;">Part ID</td>
                                </tr>
                            </table>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <table border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td style="width: 200px;">
                                        <%# DataBinder.Eval(Container, "Text")%>
                                    </td>
                                    <td style="width: 100px;">
                                        <%#DataBinder.Eval(Container, "Attributes['manufacturer']")%>
                                    </td>
                                    <td style="width: 80px;">
                                        <%#DataBinder.Eval(Container, "Attributes['partId']")%>
                                    </td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </telerik:RadComboBox>
                    
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                        ControlToValidate="rcbResources"
                        Display="Dynamic"
                        ErrorMessage="Resource Name">
                        <span class="req"></span>
                    </asp:RequiredFieldValidator>
            </div>

            <div class="row">
                <asp:Button ID="btnApplyFilter" runat="server" Text="Search" />
            </div>
        </fieldset>
    </asp:Panel>
    
    
        <asp:Panel ID="pAddCatalogue" runat="server" Visible="false">
            <asp:HyperLink ID="hlAddCatalogue" runat="server" CssClass="button fullButton"
                NavigateUrl="~/add_catalogue.aspx?sid={0}&rid={1}" Text="Add a Resource" />
        </asp:Panel>
    </div>

    <div class="maincontent">

    <telerik:RadGrid ID="rgCatalogue" runat="server"
        DataSourceID="allCatalogueDataSource"
        AllowAutomaticDeletes="true"
        GridLines="None">
        <MasterTableView
            AutoGenerateColumns="False"
            DataSourceID="allCatalogueDataSource"
            DataKeyNames="id"
            NoMasterRecordsText="&nbsp;No Catalogue Resources were found.">
            <Columns>
                <telerik:GridHyperLinkColumn
                    UniqueName="productCode"
                    HeaderText="Product Code"
                    HeaderStyle-Width="15%" 
                    SortExpression="productCode"
                    DataNavigateUrlFields="id"
                    DataNavigateUrlFormatString="~/catalogue_details.aspx?id={0}"
                    DataTextField="productCode" />
                
                <telerik:GridHyperLinkColumn
                    UniqueName="resourceName"
                    HeaderText="Resource Name"
                    HeaderStyle-Width="40%" 
                    SortExpression="resourceName"
                    DataNavigateUrlFields="id"
                    DataNavigateUrlFormatString="~/catalogue_details.aspx?id={0}"
                    DataTextField="resourceName" />
                
                <telerik:GridBoundColumn
                    DataField="price"
                    DataType="System.Decimal"
                    DataFormatString="{0:C2}"
                    HeaderStyle-Width="10%"
                    EmptyDataText="&amp;nbsp;"
                    HeaderText="Price"
                    SortExpression="price" 
                    UniqueName="price" />
                        
                <telerik:GridBoundColumn
                    UniqueName="useage"
                    HeaderText="Useage"
                    SortExpression="useage"
                    DataField="useage"
                    HeaderStyle-Width="10%"
                    ItemStyle-HorizontalAlign="Center"
                    HeaderStyle-HorizontalAlign="Center" />
                
                <telerik:GridBoundColumn
                    UniqueName="leadTime"
                    HeaderText="Lead Time (days)"
                    SortExpression="leadTime"
                    DataField="leadTime"
                    HeaderStyle-Width="15%"
                    ItemStyle-HorizontalAlign="Center"
                    HeaderStyle-HorizontalAlign="Center" />
                    
                
                <telerik:GridTemplateColumn
                    UniqueName="discontinued"
                    HeaderText="Discontinued"
                    HeaderStyle-Width="10%"
                    HeaderStyle-horizontalAlign="Center"
                    ItemStyle-horizontalAlign="Center">
                    <ItemTemplate>
                        <asp:Image ID="Image1" runat="server"
                            Visible='<%# Not isDbNull(Eval("discontinued")) %>'
                            ImageUrl="~/icons/success.png" />
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                
                <telerik:GridButtonColumn
                    ConfirmText="Delete this Catalogue Resource?"
                    ConfirmTitle="Delete"
                    ButtonType="ImageButton"
                    CommandName="Delete"
                    Text="Delete"
                    UniqueName="DeleteColumn" />
            </Columns>
        </MasterTableView>
    </telerik:RadGrid>
    </div>

    <asp:SqlDataSource ID="allCatalogueDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        DeleteCommand="DELETE FROM tblCatalogueUseage WHERE id = @id"
        SelectCommand="Catalogue_SELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter Name="resourceId" ControlID="rcbResources" PropertyName="SelectedValue" DefaultValue="0" />
            <asp:ControlParameter Name="supplierId" ControlID="rcbSupplier" PropertyName="SelectedValue" DefaultValue="0" />
        </SelectParameters>
    </asp:SqlDataSource>
    
                    
    <asp:SqlDataSource ID="supplierDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="SELECT tblSuppliers.id, supplierName
            FROM tblSuppliers
            LEFT JOIN tblSupplierPriority ON tblSuppliers.id = supplierId
            WHERE tblSupplierPriority.userid = @userid AND tblSuppliers.userId = @userId
            ORDER BY position">
        <SelectParameters>
            <asp:SessionParameter Name="UserId" SessionField="userId" />
        </SelectParameters>
    </asp:SqlDataSource>


    <asp:SqlDataSource  runat="server" ID="categoryDataSource"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="SELECT * From tblCategories" />
</asp:Content>
