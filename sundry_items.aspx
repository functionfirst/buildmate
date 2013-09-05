<%@ Page Title="Sundry Item Costs - BuildMate" Language="VB" MasterPageFile="~/common/Manager.master" AutoEventWireup="false" CodeFile="sundry_items.aspx.vb" Inherits="manager_resource_costs" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">


    <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlId="rgResources">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="rgResources" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>

    <div class="breadcrumb">
        <ul class="breadcrumb-list">
            <li>
                <asp:HyperLink ID="HyperLink1" runat="server"
                    NavigateUrl="~/project_details.aspx?pid={0}"
                    Text="Project Details" />
                <span class="divider">/</span>
            </li>
            <li class="active">Sundry Item Costs</li>
        </ul>
    </div>
    
    <div class="main-container">
        <h1>Sundry Item Costs</h1>
        
        <telerik:RadGrid ID="rgSpaces" runat="server"
            CssClass="clear"
            DataSourceID="sundryItemsDataSource"
            GridLines="None"
            AutoGenerateColumns="False"
            AllowAutomaticInserts="True"
            AllowAutomaticDeletes="True"
            ShowFooter="true"
            Width="100%"
            ShowStatusBar="true">
            <MasterTableView
                AutoGenerateColumns="False"
                DataKeyNames="id"
                NoMasterRecordsText="&nbsp;No Sundry Items were found."
                DataSourceID="sundryItemsDataSource">
                <Columns>
                    <telerik:GridHyperLinkColumn 
                        UniqueName="buildElementName"
                        HeaderText="Element Name"
                        DataNavigateUrlFields="projectId, id"
                        DataTextField="buildElementName"
                        DataNavigateUrlFormatString="build_element_details.aspx?pid={0}&rid={1}"
                        headerstyle-width="30%" />

                    <telerik:GridBoundColumn
                        UniqueName="buildElementType"
                        HeaderText="Element Type"
                        HeaderStyle-Width="30%"
                        DataField="buildElementType" />
                           
                                
                        <telerik:GridBoundColumn
                        UniqueName="subcontractType"
                        HeaderText="Sundry Items"
                        HeaderStyle-Width="15%"
                        HeaderStyle-HorizontalAlign="Center"
                        ItemStyle-HorizontalAlign="Center"
                        DataField="subcontractType" />
                
                    <telerik:GridNumericColumn
                        UniqueName="buildCost"
                        HeaderText="Build Cost"
                        DataField="spaceprice"
                        HeaderStyle-Width="15%"
                        DataFormatString="{0:C}"
                        HeaderStyle-HorizontalAlign="Right"
                        ItemStyle-HorizontalAlign="Right" />
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>

    <asp:SqlDataSource ID="SundryItemsDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="getSundryItems" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="UserId" SessionField="userid" />
            <asp:QueryStringParameter Name="projectId" QueryStringField="pid" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>