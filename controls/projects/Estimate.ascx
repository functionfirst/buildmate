<%@ Control Language="VB" AutoEventWireup="false" CodeFile="Estimate.ascx.vb" Inherits="controls_projects_Estimate" ClassName="ProjectEstimate" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

    <h3>1. Select an Estimate Type</h3>

    <div class="row">
        <label class="label">&nbsp;</label>
        <asp:RadioButtonList ID="rblEstimateType" runat="server"
            AutoPostBack="true"
            DataSourceID="projectTypeDataSource"
            DataTextField="projectType"
            DataValueField="id"></asp:RadioButtonList>
    </div>

    <div class="form-actions">
        <asp:LinkButton ID="lbTemplate" runat="server" CssClass="button button-primary">
            Next
        </asp:LinkButton>
    </div>
    
    <asp:SqlDataSource ID="projectTypeDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>" 
        SelectCommand="SELECT id, projectType FROM ProjectType" />

<telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
<script type="text/javascript">
    var data = {
        tooltip: {
            title: 'Create a Project - Step 1',
            content: "Click the 'Estimate Type' you want to create. Then click the blue button 'Next' located at bottom of the list.<br><br><em>Help: Projects/Estimates are creating using a four step wizard. 'Estimate type' is used to analyse your projects by their respective group heading. All of the details entered using the Project Wizard can be edited after the Project is completed.</em>"
        }
    };
    $(document).ready(function () {
        bm.tour(data);
    });
</script>
</telerik:RadScriptBlock>