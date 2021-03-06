﻿<%@ Control Language="VB" AutoEventWireup="false" CodeFile="Template.ascx.vb" Inherits="controls_projects_Template" ClassName="ProjectTemplate" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>


<telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlId="rmpProject">
            <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rblProjectSource" />
                    <telerik:AjaxUpdatedControl ControlID="rgProjects" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>



<h3>2. Select a Project to copy <em>or</em> create a Blank project</h3>

<asp:Panel ID="noProjectsExist" runat="server" Visible="false">
    <p>
        There are no Templates matching the Estimate Type you selected.
    </p>
    <p>
        To use a Template click Back and select a different Estimate Type.
    </p>
</asp:Panel>

<asp:RadioButtonList ID="rblProjectSource" runat="server" RepeatDirection="Horizontal" AutoPostBack="true">
    <asp:ListItem Text="My Projects" Value="1" Selected="True" />
    <asp:ListItem Text="Buildmate Projects" Value="2" id="rblBuildmateProjects" />
</asp:RadioButtonList>

<telerik:RadGrid
    ID="rgProjects"
    runat="server"
    DataSourceID="projectsDataSource"
    AllowPaging="true"
    PageSize="10"
    AllowMultiRowSelection="false"
    AllowRowSelect="True"
    PagerStyle-Mode="NextPrev"
    ShowGroupPanel="false"
    AllowSorting="false"
    GridLines="None"
    ShowStatusBar="true">
    <MasterTableView
        DataSourceID="projectsDataSource"
        AutoGenerateColumns="False"
        NoMasterRecordsText="&nbsp;No Templates found.">
        <Columns>
            <telerik:GridTemplateColumn UniqueName="CheckBoxTemplateColumn">
                <ItemTemplate>
                  <asp:CheckBox ID="CheckBox1" runat="server" OnCheckedChanged="ToggleRowSelection"
                    AutoPostBack="True" />
                </ItemTemplate>
              </telerik:GridTemplateColumn>
            
            <telerik:GridBoundColumn
                DataField="id"
                UniqueName="id"
                Visible="false" />

            <telerik:GridHyperLinkColumn UniqueName="projectName"
                HeaderText="Project Name"
                DataNavigateUrlFormatString="~/project_details.aspx?pid={0}"
                DataNavigateUrlFields="id"
                DataTextField="projectName"
                SortExpression="projectName"
                HeaderStyle-Width="35%" />

            <telerik:GridBoundColumn
                DataField="projectType"
                HeaderText="Type"
                UniqueName="projecType"
                HeaderStyle-HorizontalAlign="Center"
                ItemStyle-HorizontalAlign="Center"
                SortExpression="projectType"
                HeaderStyle-Width="35%" />

            <telerik:GridBoundColumn
                DataField="returnDate"
                DataFormatString="{0:d}"
                HeaderStyle-HorizontalAlign="Center"
                ItemStyle-HorizontalAlign="Center"
                HeaderStyle-Width="10%"
                HeaderText="Return Date"
                UniqueName="returnDate"
                SortExpression="returnDate" />

            <telerik:GridBoundColumn
                DataField="startDate"
                DataFormatString="{0:d}"
                HeaderStyle-HorizontalAlign="Center"
                ItemStyle-HorizontalAlign="Center"
                HeaderStyle-Width="10%"
                HeaderText="Start Date"
                UniqueName="startDate"
                SortExpression="startDate" />

            <telerik:GridBoundColumn
                DataField="completionDate"
                DataFormatString="{0:d}"
                HeaderStyle-HorizontalAlign="Center"
                ItemStyle-HorizontalAlign="Center"
                HeaderStyle-Width="10%"
                HeaderText="Finish Date"
                UniqueName="completionDate"
                SortExpression="completionDate" />
        </Columns>
    </MasterTableView>
</telerik:RadGrid>


    <div class="form-actions">
        <asp:LinkButton ID="lbBack" runat="server" CssClass="button">
            &laquo; Back
        </asp:LinkButton>
        <asp:LinkButton ID="lbProject" runat="server" CssClass="button button-primary" Enabled="false">
            Copy the selected Project
        </asp:LinkButton>
        <asp:LinkButton ID="lbBlankTemplate" runat="server" CssClass="button button-secondary">
            Create a Blank Project
        </asp:LinkButton>
    </div>
    
<asp:SqlDataSource ID="projectsDataSource" runat="server"
    ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
    SelectCommand="PROJECT_select_template"
    SelectCommandType="StoredProcedure"
    FilterExpression="projectTypeId = {0}">
    <SelectParameters>
        <asp:SessionParameter name="userId" SessionField="userId" />
        <asp:ControlParameter Name="projectSource" ControlID="rblProjectSource" PropertyName="SelectedValue" DefaultValue="1" />
    </SelectParameters>
    <FilterParameters>
        <asp:ControlParameter ControlID="hfEstimateType" PropertyName="Value" DefaultValue="0" />
        
    </FilterParameters>
</asp:SqlDataSource>

<telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
    <script type="text/javascript">
        var data = {
            target: '#ctl00_MainContent_bmTemplate_lbBlankTemplate',
            tooltip: {
                title: 'Creating a Project - Step 2',
                content: "Click the blue button 'Create a Blank Project' located above.<br><br><em>Help: As this is your first project there are no templates to copy so you will need to create a blank project. Once you have created a project you will be able to copy it as a template to create new projects.</em>"
            }
        };

        bm.tour(data);
    </script>
</telerik:RadScriptBlock>
