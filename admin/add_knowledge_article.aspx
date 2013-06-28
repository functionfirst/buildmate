<%@ Page Title="Add an Article" Language="VB" MasterPageFile="~/common/admin.master" AutoEventWireup="false" CodeFile="add_knowledge_article.aspx.vb" Inherits="edit_knowledge_article" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">

    <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="FormView1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="FormView1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>

   <p class="breadcrumb">
        <a href="knowledge_base.aspx">Knowledge Base</a>
        &raquo; Add an Article
    </p>

    <asp:FormView ID="FormView1" runat="server" 
        DataSourceID="knowledgeBaseDataSource" DefaultMode="Insert">
        <InsertItemTemplate>
            <div class="box">
                <h3 class="box_top_edit">Add an Article..</h3>

                <div class="boxcontent">
                    <div class="row">
                        <asp:Label ID="Label1" runat="server" Text="Title" AssociatedControlID="titleTextBox" CssClass="label" />
                        <asp:TextBox ID="titleTextBox" runat="server" Text='<%# Bind("title") %>' Width="400px" MaxLength="120" />
                    </div>

                    <div class="row">
                        <asp:Label
                            ID="Label8"
                            runat="server"
                            Text="Category"
                            AssociatedControlID="rcbCategory"
                            CssClass="label" />

                        <telerik:RadComboBox
                            ID="rcbCategory"
                            runat="server"
                            DataSourceID="categoryDataSource"
                            DataTextField="Name"
                            DataValueField="KnowledgeCategoryId"
                            SelectedValue='<%# Bind("categoryId") %>' />
                    </div>

                    <div class="row">
                        <asp:Label ID="Label3" runat="server" Text="Keywords" AssociatedControlID="keywordsTextBox" CssClass="label" />
                        <asp:TextBox ID="keywordsTextBox" runat="server" Text='<%# Bind("keywords") %>' MaxLength="120" />
                    </div>

                    <div class="row">
                        <asp:Label ID="Label5" runat="server" Text="Article" AssociatedControlID="RadEditor1" CssClass="label" />
  
                        <div style="margin-left: 110px">
                            <telerik:RadEditor
                                ID="RadEditor1"
                                runat="server"
                                Content='<%#Bind("article")%>'>
                                <CssFiles>
                                    <telerik:EditorCssFile Value="/css/bootstrap.min.css" />
                                    <telerik:EditorCssFile Value="/css/radeditor.css" />
                                </CssFiles>
                            </telerik:RadEditor>
                        </div>
                    </div>
            
                    <div class="row">
                        <label class="label">&nbsp;</label>
                        <asp:Button ID="InsertButton" runat="server" CausesValidation="True" 
                        CommandName="Insert" Text="Add Article" />
                    </div>
                </div>
            </div>
        </InsertItemTemplate>
    </asp:FormView>

    <asp:SqlDataSource ID="categoryDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="
            SELECT *
            FROM KnowledgeCategories ORDER BY Name">
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="knowledgeBaseDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        InsertCommand="
            INSERT INTO KnowledgeArticles (categoryId, title, keywords, article) VALUES(@categoryId, @title, @keywords, @article)">
    </asp:SqlDataSource>
</asp:Content>

