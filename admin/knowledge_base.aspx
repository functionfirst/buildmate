<%@ Page Title="Knowledge Base" Language="VB" MasterPageFile="~/common/admin.master" AutoEventWireup="false" CodeFile="knowledge_base.aspx.vb" Inherits="knowledge_base" %>

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
        Knowledge Base
    </p>

    <asp:Panel ID="Panel1" runat="server" DefaultButton="btnApplyFilter">
        <div class="sidebar">
            <fieldset>
                <legend title="Search Knowledge Base">Search Knowledge Base</legend>
                
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
                        DataValueField="KnowledgeCategoryId" />
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
                NavigateUrl="~/admin/add_knowledge_article.aspx">
                <span></span>Add an Article
            </asp:HyperLink>
        </div>
        </asp:Panel>
        <div class="maincontent">

    <telerik:RadGrid
        ID="RadGrid1"
        runat="server" 
        DataSourceID="knowledgeBaseDataSource"
        AllowSorting="true"
        GridLines="None"
        ShowStatusBar="true"
        AllowPaging="true"
            AllowAutomaticDeletes="true"
        PageSize="100">
        <MasterTableView
            AutoGenerateColumns="False"
            NoMasterRecordsText="&nbsp; No articles were found matching your criteria."
            DataSourceID="knowledgeBaseDataSource"
            AllowSorting="true"
            DataKeyNames="KnowledgeArticleId">
            <Columns>
                <telerik:GridHyperLinkColumn
                    DataTextField="title"
                    HeaderText="Title"
                    SortExpression="title"
                    UniqueName="title"
                    DataNavigateUrlFields="KnowledgeArticleId"
                    DataNavigateUrlFormatString="edit_knowledge_article.aspx?id={0}" />

                <telerik:GridBoundColumn DataField="viewcount" DataType="System.Int32" 
                    HeaderText="Views" SortExpression="viewcount" UniqueName="viewcount">
                </telerik:GridBoundColumn>
                
                <telerik:GridBoundColumn DataField="Name" HeaderText="Category" 
                    SortExpression="Name" UniqueName="Name">
                </telerik:GridBoundColumn>
                
                <telerik:GridButtonColumn
                    ConfirmText="Remove this Article?"
                    ConfirmTitle="Delete"
                    ButtonType="ImageButton"
                    CommandName="Delete"
                    Text="Delete"
                    UniqueName="DeleteColumn" />
            </Columns>
        </MasterTableView>
    </telerik:RadGrid>
    </div>

    <asp:SqlDataSource ID="knowledgeBaseDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        DeleteCommand="Delete FROM KnowledgeArticles WHERE KnowledgeArticleId = @KnowledgeArticleId"
        SelectCommand="
            SELECT KnowledgeArticles.KnowledgeArticleId, title, viewcount, dateAdded, title, Name
            FROM KnowledgeArticles
            LEFT JOIN KnowledgeCategories ON KnowledgeArticles.categoryId = KnowledgeCategories.KnowledgeCategoryId">
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="categoryDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="
            SELECT *
            FROM KnowledgeCategories ORDER BY Name">
    </asp:SqlDataSource>
</asp:Content>

