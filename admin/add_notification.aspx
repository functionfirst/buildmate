<%@ Page Title="Add a Blog" Language="VB" MasterPageFile="~/common/admin.master" AutoEventWireup="false" CodeFile="add_notification.aspx.vb" Inherits="add_notification" %>

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
        DataSourceID="notificationDataSource" DefaultMode="Insert">
        <InsertItemTemplate>
            <div class="box">
                <h3 class="box_top_edit">Add a Blog..</h3>

                <div class="boxcontent">
                    <div class="row">
                        <asp:Label ID="Label1" runat="server" Text="Title" AssociatedControlID="titleTextBox" CssClass="label" />
                        <asp:TextBox ID="titleTextBox" runat="server" Text='<%# Bind("title") %>' Width="500" MaxLength="120" />
                        
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                            ControlToValidate="titleTextBox"
                            Display="Dynamic" ErrorMessage="*required">
                        </asp:RequiredFieldValidator>
                    </div>

                    <div class="row">
                        <asp:Label ID="Label3" runat="server" Text="Abstract" AssociatedControlID="abstractTextBox" CssClass="label" />

                        <asp:TextBox ID="abstractTextBox" runat="server" TextMode="MultiLine" Text='<%# Bind("Abstract") %>' Width="500" MaxLength="255" />
                    </div>
                    
                    <div class="row">
                        <asp:Label ID="Label4" runat="server" Text="URL" AssociatedControlID="urlTextBox" CssClass="label" />
                        <asp:TextBox ID="urlTextBox" runat="server" Text='<%# Bind("URL") %>' Width="500" MaxLength="120" />
                    </div>

                    <div class="row">
                        <label class="label">Start Date</label>
                        
                        <telerik:RadCalendar ID="RadCalendar1" runat="server" Font-Names="Arial, Verdana, Tahoma"
                            EnableViewSelector="true" DayNameFormat="Short" FirstDayOfWeek="Monday" ForeColor="Black"
                            Style="border-color: #ececec">
                            <DayOverStyle BackColor="#bfdbff" />
                        </telerik:RadCalendar>
                            
                        <div style="margin-left: 110px">
                            <telerik:RadDatePicker ID="rdpStartDate" runat="server"
                                DbSelectedDate='<%# Bind("DateStart") %>'
                                DateInput-EmptyMessage="Start Date" SharedCalendarID="RadCalendar1" />

                                
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                                ControlToValidate="rdpStartDate"
                                Display="Dynamic" ErrorMessage="*required">
                            </asp:RequiredFieldValidator>
                        </div>
                    </div>

                    <div class="row">
                        <div style="margin-left: 110px">
                            <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%#Bind("Hidden") %>' Text="Hide this Notification" />
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

    <asp:SqlDataSource ID="notificationDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        InsertCommand="
            INSERT INTO SystemNotification(Title, Abstract, URL, DateStart) VALUES(@Title, @Abstract, @URL, @DateStart)">
            <InsertParameters>
                <asp:SessionParameter Name="UserId" SessionField="UserId" />
            </InsertParameters>
    </asp:SqlDataSource>
</asp:Content>

