<%@ Page Title="Resources - Admin" Language="VB" MasterPageFile="~/common/admin.master" AutoEventWireup="false" CodeFile="suppliers.aspx.vb" Inherits="suppliers" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="head" ContentPlaceHolderID="head" Runat="Server"></asp:Content>

<asp:Content ID="Content" ContentPlaceHolderID="MainContent" Runat="Server">
    
    <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlId="rtsMain">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="rtsMain" />
                     <telerik:AjaxUpdatedControl ControlID="rmpMain" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlId="rgSuppliers">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="rtsMain" />
                     <telerik:AjaxUpdatedControl ControlID="rmpMain" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlId="rgResources">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rtsMain" />
                     <telerik:AjaxUpdatedControl ControlID="rmpMain" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlId="rgCatalogue">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rtsMain" />
                     <telerik:AjaxUpdatedControl ControlID="rmpMain" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    
    <p class="breadcrumb">
        Suppliers
    </p>
    
    <telerik:RadGrid ID="rgSuppliers" runat="server"
        DataSourceID="supplierDataSource"
        GridLines="None"
        AllowAutomaticUpdates="true"
        AllowAutomaticInserts="true">
        <MasterTableView
            AutoGenerateColumns="False"
            DataSourceID="supplierDataSource"
            DataKeyNames="id">
            <Columns>
                <telerik:GridHyperLinkColumn
                    UniqueName="supplierName"
                    HeaderText="Supplier Name"
                    DataNavigateUrlFields="id"
                    DataNavigateUrlFormatString="edit_supplier.aspx?sid={0}"
                    DataTextField="supplierName"
                    DataTextFormatString="{0}" />
            </Columns>
        </MasterTableView>
    </telerik:RadGrid>
    



    <asp:SqlDataSource
        ID="supplierDataSource"
        runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="SELECT id, supplierName FROM Supplier where global = 1">
    </asp:SqlDataSource>
</asp:Content>