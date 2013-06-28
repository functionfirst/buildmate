<%@ Page Title="Add a Blog" Language="VB" MasterPageFile="~/common/admin.master" AutoEventWireup="false" CodeFile="add_blog.aspx.vb" Inherits="add_blog" %>

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
        <a href="blog.aspx">Blog</a>
        &raquo; Add a Blog
    </p>

    <asp:FormView ID="FormView1" runat="server" 
        DataSourceID="blogDataSource" DefaultMode="Insert">
        <InsertItemTemplate>
            <div class="box">
                <h3 class="box_top_edit">Add a Blog..</h3>

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
                            DataValueField="BlogCategoryId"
                            SelectedValue='<%# Bind("categoryId") %>' />
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
                        CommandName="Insert" Text="Add Blog" />
                    </div>
                </div>
            </div>
        </InsertItemTemplate>
    </asp:FormView>

    <asp:SqlDataSource ID="categoryDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="
            SELECT *
            FROM BlogCategories ORDER BY Name">
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="blogDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        InsertCommand="
            INSERT INTO Blogs(CategoryId, title, article, userId, BlogCategory_BlogCategoryId) VALUES(@categoryId, @title, @article, @userId, @categoryId)">
            <InsertParameters>
                <asp:SessionParameter Name="UserId" SessionField="UserId" />
            </InsertParameters>
    </asp:SqlDataSource>
</asp:Content>

