<%@ Page Title="Blog" Language="VB" MasterPageFile="~/common/admin.master" AutoEventWireup="false" CodeFile="blog.aspx.vb" Inherits="blog_base" %>

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
        Blog
    </p>

    <asp:Panel ID="Panel1" runat="server" DefaultButton="btnApplyFilter">
        <div class="sidebar">
            <fieldset>
                <legend title="Search Blog">Search Blog</legend>
                
                <div class="row">
                    <asp:Label ID="Label1" runat="server"
                        AssociatedControlID="rcbCategory"
                        CssClass="label"
                        Text="Category" />

                    <telerik:RadComboBox
                        ID="rcbCategory"
                        runat="server"
                        AutoPostBack="true"
                        DataSourceID="categoryDataSource"
                        DataTextField="Name"
                        DataValueField="BlogCategoryId" />
                </div>
                
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
                NavigateUrl="~/admin/add_blog.aspx">
                <span></span>Add a Blog
            </asp:HyperLink>
        </div>
        </asp:Panel>
        <div class="maincontent">

    <telerik:RadGrid
        ID="RadGrid1"
        runat="server" 
        DataSourceID="blogDataSource"
        AllowSorting="true"
        GridLines="None"
        ShowStatusBar="true"
        AllowPaging="true"
        PageSize="100">
        <MasterTableView
            AutoGenerateColumns="False"
            NoMasterRecordsText="&nbsp; No blogs were found matching your criteria."
            DataSourceID="blogDataSource"
            AllowSorting="true"
            DataKeyNames="BlogId">
            <Columns>
                <telerik:GridHyperLinkColumn
                    DataTextField="title"
                    HeaderText="Title"
                    SortExpression="title"
                    UniqueName="title"
                    DataNavigateUrlFields="BlogId"
                    DataNavigateUrlFormatString="edit_blog.aspx?id={0}" />
                <telerik:GridBoundColumn DataField="Name" HeaderText="Category" 
                    SortExpression="Name" UniqueName="Name">
                </telerik:GridBoundColumn>
            </Columns>
        </MasterTableView>
    </telerik:RadGrid>
    </div>

    <asp:SqlDataSource ID="blogDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="
            SELECT Blogs.BlogId, title, BlogCategories.name
            FROM Blogs
            LEFT JOIN BlogCategories ON Blogs.CategoryId = BlogCategories.BlogCategoryId">
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="categoryDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="
            SELECT *
            FROM BlogCategories ORDER BY Name">
    </asp:SqlDataSource>
</asp:Content>

