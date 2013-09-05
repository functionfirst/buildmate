<%@ Control Language="VB" AutoEventWireup="false" CodeFile="Estimate.ascx.vb" Inherits="controls_projects_estimate" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

    <h3>Select an Estimate Type</h3>

    <div class="row">
        <label class="label">&nbsp;</label>
        <asp:RadioButtonList ID="rblEstimateType" runat="server" DataSourceID="projectTypeDataSource" DataTextField="projectType" DataValueField="id"></asp:RadioButtonList>
    </div>

    <div class="form-actions">
        <asp:LinkButton ID="lbTemplate" runat="server" CssClass="button button-primary">
            Continue &raquo;
        </asp:LinkButton>
    </div>
    
    <asp:SqlDataSource ID="projectTypeDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>" 
        SelectCommand="SELECT id, projectType FROM ProjectType" />