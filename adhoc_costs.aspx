<%@ Page Title="Ad-hoc Costs - Buildmate" Language="VB" MasterPageFile="~/common/Manager.master" AutoEventWireup="false" CodeFile="adhoc_costs.aspx.vb" Inherits="manager_resource_costs" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"></asp:Content>

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
        <div class="breadcrumb-container">
            <ul class="breadcrumb-list">
                <li>
                    <asp:HyperLink ID="HyperLink1" runat="server"
                        NavigateUrl="~/project_details.aspx?pid={0}"
                        Text="Project Details" />
                    <span class="divider">/</span>
                </li>
                <li class="active">Ad-hoc Costs</li>
            </ul>
        </div>
    </div>

    <div class="main-container">
        <h1>Ad-hoc Costs</h1>
        
        <telerik:RadGrid ID="rgAdhocCosts" runat="server"
                CssClass="clear"
                DataSourceID="adhocCostDataSource"
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
                    NoMasterRecordsText="&nbsp;No Ad-hoc Costs were found."
                    DataSourceID="adhocCostDataSource">
                    <Columns>
                        <telerik:GridHyperLinkColumn 
                            UniqueName="description"
                            HeaderText="Description"
                            DataNavigateUrlFields="projectId, buildElementid, taskId"
                            DataTextField="description"
                            DataNavigateUrlFormatString="task_details.aspx?pid={0}&rid={1}&tid={2}" />
                
                        <telerik:GridNumericColumn
                            UniqueName="total"
                            HeaderText="Total"
                            DataField="total"
                            HeaderStyle-Width="5%"
                            DataFormatString="{0:C}"
                            HeaderStyle-HorizontalAlign="Right"
                            ItemStyle-HorizontalAlign="Right" />
                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>
    </div>

    <asp:SqlDataSource ID="adhocCostDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="getAdhocAdditionsByProject" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="UserId" SessionField="userid" />
            <asp:QueryStringParameter Name="pid" QueryStringField="pid" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>