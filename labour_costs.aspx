<%@ Page Title="Labour Costs - BuildMate" Language="VB" MasterPageFile="~/common/Manager.master" AutoEventWireup="false" CodeFile="labour_costs.aspx.vb" Inherits="manager_resource_costs" %>

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
            <li class="active">
                Labour Costs
            </li>
        </ul>
    </div>

    <div class="main-container">
        <div class="box">
        <h3>Labour Costs</h3>
        
            <div class="boxcontent">
        <asp:Repeater ID="Repeater1" runat="server"
            DataSourceID="resourceDataSource">
            <HeaderTemplate>
                <table border="0" cellpadding="0" cellspacing="0" class="table" width="100%">
                <colgroup>
                    <col />
                    <col width="10%" />
                    <col width="5%" />
                    <col width="10%" />
                    <col width="10%" />
                    <col width="10%" />
                    <col width="10%" />
                </colgroup>
                <thead>
                    <tr>
                        <th></th>
                        <th class="firstcol centrealign" colspan="3">Purchase Cost</th>
                        <th class="firstcol centrealign" colspan="3">Project Cost</th>
                    </tr>
                    <tr>
                        <th class="leftalign">Resource Name</th>
                        <th class="firstcol">Unit</th>
                        <th>Qty</th>
                        <th class="rightalign">Cost (&pound;)</th>
                        <th class="firstcol rightalign">Cost (&pound;)</th>
                        <th class="rightalign">Waste</th>
                        <th class="rightalign">Total Cost (&pound;)</th>
                    </tr>
                </thead>
                <tbody>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td>
                        <asp:Image ID="Image1" runat="server"
                            Visible='<%# IIf(eval("isEditable")=0, "True", "False")%>'
                            ToolTip="Non-Variation Resource"
                            Src="/images/editable0.gif" />
                        
                        <asp:Image ID="Image2" runat="server"
                            Visible='<%# IIf(eval("isEditable")=1, "True", "False")%>'
                            ToolTip="Variation Resource" src="/images/editable1.gif" />
                        <%# eval("resourceName") %>
                    </td>
                    <td class="centrealign purchasecol firstcol"><%#Eval("purchaseUnit")%></td>
                    <td class="centrealign purchasecol"><%#Eval("purchaseQty")%></td>
                    <td class="rightalign purchasecol"><%#Eval("purchaseCost", "{0:C2}")%></td>
                    <td class="rightalign projectcol firstcol"><%#Eval("projectCost", "{0:C2}")%></td>
                    <td class="rightalign projectcol"><%# checkWaste(Eval("incWaste"), Eval("projectWaste"), Eval("wastePercent")) %></td>
                    <td class="rightalign projectcol lastcol"><%#Eval("projectTotalCost", "{0:C2}")%></td>
                </tr>
            </ItemTemplate>
            <FooterTemplate>
                    </tbody>
                    <tfoot>
                        <tr>
                            <th colspan="6" class="rightalign">Total Cost:</th>
                            <th class="rightalign"><asp:Label ID="lblGrandTotal" runat="server" /></th>
                        </tr>
                    </tfoot>
                </table>
            </FooterTemplate>
        </asp:Repeater>
    </div>
    </div>
</div>

    <asp:SqlDataSource ID="resourceDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="getTaskResourceStackByProjectAndResourceType" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="UserId" SessionField="userid" />
            <asp:QueryStringParameter Name="projectId" QueryStringField="pid" />
            <asp:Parameter Name="resourceTypeId" DefaultValue="1" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>