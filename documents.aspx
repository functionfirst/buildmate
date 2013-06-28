<%@ Page Language="VB" MasterPageFile="~/common/Manager.master" AutoEventWireup="false" CodeFile="documents.aspx.vb" Inherits="manager_report" title="Documents - BuildMate" %>

<%@ Register Assembly="Telerik.ReportViewer.WebForms, Version=5.3.11.1116, Culture=neutral, PublicKeyToken=a9d7983dfcc261be"
    Namespace="Telerik.ReportViewer.WebForms" TagPrefix="telerik" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server">
        <div class="box">
            <h3>Document Options</h3>

            <div class="boxcontent">
                <div class="row">
                    <asp:Label
                        ID="Label5"
                        CssClass="label"
                        runat="server"
                        Text="Project Type"
                        AssociatedControlID="rcbProjectType" />

                    <telerik:RadComboBox
                        ID="rcbProjectType"
                        runat="server"
                        AutoPostBack="true"
                        DataSourceID="projectTypeDataSource"
                        DataTextField="projectType"
                        DataValueField="id" />
                </div>

                <div class="row">
                    <asp:Label
                        ID="Label2"
                        CssClass="label"
                        runat="server"
                        Text="Project"
                        AssociatedControlID="rcbProject" />

                    <telerik:RadComboBox
                        ID="rcbProject"
                        runat="server"
                        AutoPostBack="true"
                        Enabled="false"
                        DataSourceID="projectsDataSource"
                        DataTextField="projectName"
                        DataValueField="id"
                        Width="300" />
                </div>

                <div class="row">
                    <asp:Label
                        ID="Label3"
                        CssClass="label"
                        runat="server"
                        Text="Document Type"
                        AssociatedControlID="rcbReportType" />

                    <telerik:RadComboBox
                        ID="rcbReportType"
                        runat="server"
                        AutoPostBack="true"
                        Enabled="false"
                        Width="200">
                        <Items>
                            <telerik:RadComboBoxItem Value="0" Text="Select a document..." Selected="true" />
                            <telerik:RadComboBoxItem Value="1" Text="Resource break-down" />
                            <telerik:RadComboBoxItem Value="2" Text="Acceptance Form" />
                            <telerik:RadComboBoxItem Value="3" Text="Offer Letter" />
                        </Items>
                        </telerik:RadComboBox>
                </div>

                <asp:panel class="row" runat="server" id="pTermsOfUse" Visible="false">
                    <asp:Label
                        ID="Label4"
                        CssClass="label"
                        runat="server"
                        Text="Attach Terms of Use"
                        AssociatedControlID="rblTermsOfUse" />

                    <asp:RadioButtonList
                        ID="rblTermsOfUse"
                        runat="server"
                        AutoPostBack="true" RepeatDirection="Horizontal" RepeatLayout="Flow">
                        <asp:ListItem Text="None" Value="0" Selected="true" />
                        <asp:ListItem Text="Small Print" Value="1" />
                        <asp:ListItem Text="Large Print" Value="2" />
                    </asp:RadioButtonList>
                </asp:panel>

                <asp:panel class="row" runat="server" id="pResourceType" Visible="false">
                    <asp:Label
                        ID="Label1"
                        CssClass="label"
                        runat="server"
                        Text="Resource Type"
                        AssociatedControlID="rblResourceType" />

                    <asp:RadioButtonList
                        ID="rblResourceType"
                        runat="server"
                        AutoPostBack="true"
                        RepeatDirection="Horizontal"
                        RepeatLayout="Flow">
                        <asp:ListItem Value="1" Text="Labour" Selected="True" />
                        <asp:ListItem Value="2" Text="Material" />
                        <asp:ListItem Value="3" Text="Plant" />
                    </asp:RadioButtonList>
                </asp:panel>
                            
                <div class="row">
                    <label class="label">&nbsp;</label>
                    <asp:Button
                        ID="btnPreview"
                        runat="server"
                        Enabled="false"
                        Text="Preview"
                        CssClass="btn" />
                    
                    <asp:Button
                        ID="btnExportToPDF"
                        runat="server"
                        Enabled="false"
                        Text="Download as PDF"
                        CssClass="btn" />
                    
                    <asp:Button
                        ID="btnExportToXLS"
                        runat="server"
                        Enabled="false"
                        Text="Download as Excel"
                        CssClass="btn" />
                    
                    <asp:Button
                        ID="btnEmailToCustomer"
                        Visible="false"
                        runat="server"
                        Enabled="false"
                        Text="Email to customer"
                        CssClass="btn" />
                </div>
            </div>
        </div>

        <div class="clear"><br /></div>

        <telerik:ReportViewer ID="ReportViewer1" runat="server"
            Visible="false"
            Width="100%"
            Height="500px"
            ZoomPercent="150"
            ShowHistoryButtons="false"
            ShowZoomSelect="false"
            ShowPrintPreviewButton="true"
            ShowExportGroup="false"
            ShowPrintButton="false"
            ShowRefreshButton="false"
            ShowParametersButton="false" />
    </telerik:RadAjaxPanel>


    <asp:SqlDataSource ID="projectsDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        FilterExpression="projectTypeId={0}"
        SelectCommand="getProjects" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="UserId" SessionField="UserId" />
        </SelectParameters>
        <FilterParameters>
            <asp:ControlParameter ControlID="rcbProjectType" PropertyName="SelectedValue" DefaultValue="1" />
        </FilterParameters>
    </asp:SqlDataSource>


    <asp:SqlDataSource
        ID="projectTypeDataSource"
        runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>" 
        SelectCommand="getProjectType"
        SelectCommandType="StoredProcedure">
    </asp:SqlDataSource>


    <asp:SqlDataSource
        ID="SqlDataSource1"
        runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>" 
        SelectCommand="Select incVAT FROM Project WHERE projectId=@projectId">
        <SelectParameters>
            <asp:ControlParameter Name="projectId" ControlID="rcbProject" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>