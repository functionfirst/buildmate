<%@ Page ValidateRequest="false" Title="Edit Blog" Language="VB" MasterPageFile="~/common/admin.master" AutoEventWireup="false" CodeFile="edit_blog.aspx.vb" Inherits="edit_blog" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">

    <p class="breadcrumb">
        <a href="blog.aspx">Blog</a>
        &raquo; Blog Details
    </p>

    <asp:FormView ID="FormView1" runat="server" Width="100%"
        DataSourceID="blogDataSource">
        <EditItemTemplate>
            <div class="box">
                <h3 class="box_top_edit">Editing Blog...</h3>

                <div class="boxcontent">
                    <div class="row">
                        <asp:Label ID="Label1" runat="server" Text="Title" AssociatedControlID="titleTextBox" CssClass="label" />
                        <asp:TextBox ID="titleTextBox" runat="server" Text='<%# Bind("title") %>' Width="500" MaxLength="255" />
                    </div>

                    <div class="row">
                        <asp:Label ID="Label2" runat="server" Text="Abstract" AssociatedControlID="abstractTextBox" CssClass="label" />

                        <asp:TextBox ID="abstractTextBox" runat="server" Text='<%# Bind("Abstract") %>' Width="500" MaxLength="255" Height="90" TextMode="MultiLine" />
                    </div>

                    <div class="row">
                        <asp:Label ID="Label4" runat="server" Text="Keywords" AssociatedControlID="keywordTextbox" CssClass="label" />

                        <asp:TextBox ID="keywordTextbox" runat="server" Text='<%# Bind("Keywords") %>' Width="500" MaxLength="255" Height="90" TextMode="MultiLine" />
                    </div>

                    <div class="row">
                        <asp:Label ID="Label8" runat="server" Text="Category" AssociatedControlID="rcbCategory" CssClass="label" />
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
                        <asp:Button
                            ID="UpdateButton"
                            runat="server"
                            CausesValidation="True"
                            CommandName="Update"
                            Text="Update" />
                
                        <asp:LinkButton
                            ID="UpdateCancelButton"
                            runat="server" 
                            CausesValidation="False"
                            CommandName="Cancel"
                            Text="Cancel" />
                    </div>
                </div>
            </div>
        </EditItemTemplate>
        <ItemTemplate>
            <div class="box">
                <h3>Article Details</h3>

                <div class="boxcontent">
                    <div class="row">
                        <label class="label">Title:</label>
                        <asp:Label ID="titleLabel" runat="server" Text='<%# Bind("title") %>' />
                    </div>
                    <div class="row">
                        <label class="label">Abstract:</label>
                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("Abstract") %>' />
                    </div>
            
                    <div class="row">
                        <label class="label">Category</label>
                        <asp:Label ID="categoryNameLabel" runat="server" 
                            Text='<%# Bind("Name") %>' />
                    </div>

                    <div class="row">
                        <label class="label">Article:</label>
                
                        <div style="margin-left: 110px">
                            <asp:Label ID="articleLabel" runat="server" Text='<%# Bind("article") %>' />
                        </div>
                    </div>

                    <div class="row">
                        <label class="label">Date Created</label>
                        <asp:Label ID="dateAddedLabel" runat="server" Text='<%# Bind("dateCreated") %>' />
                    </div>
            
                    <div class="row">
                        <label class="label">&nbsp;</label>
                        <asp:Button ID="EditButton" runat="server" CausesValidation="False" 
                            CommandName="Edit" Text="Edit" />
                    </div>
                </div>
            </div>
        </ItemTemplate>
    </asp:FormView>



    <asp:SqlDataSource ID="categoryDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="
            SELECT *
            FROM BlogCategories ORDER BY Name">
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="blogDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        UpdateCommand="
            UPDATE Blogs
            SET CategoryId = @categoryId, title = @title, abstract = @abstract, keywords = @keywords, article = @article, BlogCategory_BlogCategoryId = @categoryId
            WHERE BlogId = @id"
        SelectCommand="
            SELECT *
            FROM Blogs
            LEFT JOIN BlogCategories ON Blogs.CategoryId = BlogCategories .BlogCategoryId
            WHERE Blogs.BlogId = @id">
        <SelectParameters>
            <asp:QueryStringParameter Name="id" QueryStringField="id" />
        </SelectParameters>
        <UpdateParameters>
            <asp:QueryStringParameter Name="id" QueryStringField="id" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>

