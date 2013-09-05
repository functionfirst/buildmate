<%@ Control Language="VB" AutoEventWireup="false" CodeFile="Template.ascx.vb" Inherits="controls_projects_Template" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<h3>Select a Project to use as a Template <em>or</em> use a Blank Template</h3>

<asp:Panel ID="noProjectsExist" runat="server">
    <p>
        There are no Templates matching the Estimate Type you selected.
    </p>
    <p>
        To use a Template click Back and select a different Estimate Type.
    </p>
</asp:Panel>

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
        NoMasterRecordsText="&nbsp;No Projects were found.">
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
        <asp:LinkButton ID="lbProject" runat="server" CssClass="button button-primary" Visible="false">
            Use this Project Template &raquo;
        </asp:LinkButton>
        <asp:LinkButton ID="lbBlankTemplate" runat="server" CssClass="button button-primary">
            Use a Blank Template &raquo;
        </asp:LinkButton>
    </div>
    
<asp:SqlDataSource ID="projectsDataSource" runat="server"
    ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
    SelectCommand="
        SELECT Project.id, projectName, projectTypeId
        FROM Project
        WHERE userID = @userId OR Project.id IN (SELECT ProjectId FROM ProjectTemplate)
        ORDER BY projectName"
    FilterExpression="projectTypeId = {0}">
    <SelectParameters>
        <asp:SessionParameter name="userId" SessionField="userId" />
    </SelectParameters>
    <FilterParameters>
        <asp:ControlParameter ControlID="hfEstimateType" PropertyName="Value" DefaultValue="0" />
    </FilterParameters>
</asp:SqlDataSource>
