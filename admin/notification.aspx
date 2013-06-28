<%@ Page Title="Notification" Language="VB" MasterPageFile="~/common/admin.master" AutoEventWireup="false" CodeFile="notification.aspx.vb" Inherits="notification_base" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">

   <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlId="btnApplyFilter">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="RadGrid1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlId="rcbCategory">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="RadGrid1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlId="rtbKeywords">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="RadGrid1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>

    <p class="breadcrumb">
        Notification
    </p>

    <asp:Panel ID="Panel1" runat="server" DefaultButton="btnApplyFilter">
        <div class="sidebar">
            <fieldset>
                <legend title="Search Blog">Search Notification</legend>

                <div class="row">
                    <asp:Label ID="Label2" runat="server"
                        AssociatedControlID="rtbKeywords"
                        CssClass="label"
                        Text="Keywords" />

                        <telerik:RadTextBox
                            ID="rtbKeywords"
                            runat="server"
                            AutoPostBack="true"
                            EmptyMessage="contains any word(s)" />
                </div>

                <div class="row">
                    <asp:Button ID="btnApplyFilter" runat="server" Text="Search" />
                </div>
            </fieldset>
        
            <asp:HyperLink ID="hlAddArticle" runat="server"
                CssClass="AddItem fullAddItem"
                NavigateUrl="~/admin/add_notification.aspx">
                <span></span>Add a Notification
            </asp:HyperLink>
        </div>
        </asp:Panel>
        <div class="maincontent">

    <telerik:RadGrid
        ID="RadGrid1"
        runat="server" 
        DataSourceID="notificationDataSource"
        AllowSorting="true"
        GridLines="None"
        ShowStatusBar="true"
        AllowPaging="true"
        PageSize="100">
        <MasterTableView
            AutoGenerateColumns="False"
            NoMasterRecordsText="&nbsp; No Notifications were found matching your criteria."
            DataSourceID="notificationDataSource"
            AllowSorting="true"
            DataKeyNames="Id">
            <Columns>
                <telerik:GridHyperLinkColumn
                    DataTextField="title"
                    HeaderText="Title"
                    SortExpression="title"
                    UniqueName="title"
                    DataNavigateUrlFields="Id"
                    DataNavigateUrlFormatString="edit_notification.aspx?id={0}" />

                <telerik:GridBoundColumn
                    DataField="DateStart"
                    DataType="System.DateTime"
                    HeaderStyle-Width="20%" 
                    HeaderText="Start Date"
                    SortExpression="DateStart"
                    DataFormatString="{0:D}" 
                    ItemStyle-HorizontalAlign="Center"
                    HeaderStyle-HorizontalAlign="Center"
                    UniqueName="returndate" />

                <telerik:GridBoundColumn
                    DataField="DateCreated"
                    DataType="System.DateTime"
                    HeaderStyle-Width="20%" 
                    HeaderText="Date Created"
                    SortExpression="DateCreated"
                    DataFormatString="{0:D}" 
                    ItemStyle-HorizontalAlign="Center"
                    HeaderStyle-HorizontalAlign="Center"
                    UniqueName="DateCreated" />

                <telerik:GridTemplateColumn
                    HeaderText="Visible"
                    ItemStyle-HorizontalAlign="Center"
                    HeaderStyle-HorizontalAlign="Center"
                    ItemStyle-Width="10%">
                    <ItemTemplate>
                         <asp:Image ID="Image1" runat="server"
                                Visible='<%# IIf(eval("Hidden")=0, "True", "False")%>'
                                ToolTip="Hidden"
                                Src="/icons/success.png" />
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
            </Columns>
        </MasterTableView>
    </telerik:RadGrid>
    </div>

    <asp:SqlDataSource ID="notificationDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="
            SELECT Id, Title, Hidden, DateStart
            FROM SystemNotification">
    </asp:SqlDataSource>
</asp:Content>

