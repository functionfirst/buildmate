<%@ Page ValidateRequest="false" Title="Edit Notification" Language="VB" MasterPageFile="~/common/admin.master" AutoEventWireup="false" CodeFile="edit_notification.aspx.vb" Inherits="edit_notification" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">

    <p class="breadcrumb">
        <a href="notification.aspx">Notification</a>
        &raquo; Notification Details
    </p>

    <asp:FormView ID="FormView1" runat="server" Width="100%"
        DataSourceID="notificationDataSource">
        <EditItemTemplate>
            <div class="box">
                <h3 class="box_top_edit">Editing Notification...</h3>

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
                        <label class="label">Title</label>
                        <asp:Label ID="titleLabel" runat="server" Text='<%# Bind("Title") %>' />
                    </div>
            
                    <div class="row">
                        <label class="label">Abstract</label>
                        <div style="margin-left: 110px">
                            <asp:Label ID="categoryNameLabel" runat="server" 
                                Text='<%# Bind("Abstract") %>' />
                        </div>
                    </div>
                    <div class="row">
                        <label class="label">URL</label>


                        <a href="<%# Eval("URL") %>"><%# Eval("URL") %></a></a>
                        <asp:Label ID="Label5" runat="server" Text='<%# Bind("URL") %>' />
                    </div>

                    <div class="row">
                        <label class="label">Start Date</label>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("DateStart", "{0:D}") %>' />
                    </div>

                    <div class="row">
                        <label class="label">Date Created</label>
                        <asp:Label ID="dateAddedLabel" runat="server" Text='<%#Bind("DateCreated", "{0:D}") %>' />
                    </div>

                    <div class="row">
                        <label class="label">Visible</label>

                         <asp:Image ID="Image1" runat="server"
                                Visible='<%# IIf(eval("Hidden")=0, "True", "False")%>'
                                ToolTip="Hidden"
                                Src="/icons/success.png" />
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


    <asp:SqlDataSource ID="notificationDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        UpdateCommand="
            UPDATE SystemNotification
            SET Title = @Title, Abstract = @Abstract, URL = @URL, DateStart = @DateStart, Hidden = @Hidden
            WHERE Id = @id"
        SelectCommand="
            SELECT *
            FROM SystemNotification
            WHERE Id = @id">
        <SelectParameters>
            <asp:QueryStringParameter Name="id" QueryStringField="id" />
        </SelectParameters>
        <UpdateParameters>
            <asp:QueryStringParameter Name="id" QueryStringField="id" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>

