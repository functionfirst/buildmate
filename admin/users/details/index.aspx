<%@ Page Title="User Details" Language="VB" MasterPageFile="~/common/admin.master" AutoEventWireup="false" CodeFile="index.aspx.vb" Inherits="admin_users_details" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
     
    <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlId="FormView1">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="FormView1" />
                     <telerik:AjaxUpdatedControl ControlID="notification" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
       

    <p class="breadcrumb">
        Users
    </p>

    <asp:FormView ID="FormView1" runat="server" DefaultMode="Edit"
        width="100%"
        DataKeyNames="userid"
        DataSourceID="SqlDataSource1">
        <ItemTemplate>
            ....This
            <%# Eval("subscription") %>
        </ItemTemplate>
        <EditItemTemplate>
            <asp:Panel runat="server" DefaultButton="updateButton">
            <div class="row">
                <asp:Label ID="Label1" runat="server"
                    CssClass="label"
                    Text="Name" />
                <%# Eval("Name") %>
            </div>

            <telerik:RadCalendar ID="RadCalendar1" runat="server" Font-Names="Arial, Verdana, Tahoma"
                EnableViewSelector="true" DayNameFormat="Short" FirstDayOfWeek="Monday" ForeColor="Black"
                Style="border-color: #ececec">
                <DayOverStyle BackColor="#bfdbff" />
            </telerik:RadCalendar>
            <div class="row">
                <asp:Label ID="Label3" runat="server"
                    CssClass="label"
                    AssociatedControlID="subscription"
                    Text="Subscription" />
            <telerik:RadDatePicker ID="subscription" runat="server"
                DbSelectedDate='<%# Bind("subscription") %>'
                SharedCalendarID="RadCalendar1" />
            </div>

            <div class="row">
                <asp:Label ID="lblTourPhase" runat="server"
                    AssociatedControlID="rcbTourPhase"
                    CssClass="label"
                    Text="Tour Phase*" />

                <telerik:RadComboBox runat="server" ID="rcbTourPhase"
                    SelectedValue='<%# Bind("tourPhase") %>'>
                    <Items>
                        <telerik:RadComboBoxItem Value="0" Text="Phase 0" />
                        <telerik:RadComboBoxItem Value="1" Text="Phase 1" />
                        <telerik:RadComboBoxItem Value="2" Text="Phase 2" />
                        <telerik:RadComboBoxItem Value="3" Text="Phase 3" />
                        <telerik:RadComboBoxItem Value="4" Text="Phase 4" />
                        <telerik:RadComboBoxItem Value="5" Text="Phase 5" />
                        <telerik:RadComboBoxItem Value="6" Text="Phase 6" />
                        <telerik:RadComboBoxItem Value="7" Text="Phase 7" />
                        <telerik:RadComboBoxItem Value="8" Text="Phase 8" />
                        <telerik:RadComboBoxItem Value="9" Text="Phase 9" />
                        <telerik:RadComboBoxItem Value="10" Text="Phase 10" />
                    </Items>
                </telerik:RadComboBox>
            </div>

            <div class="row">
                <label class="label">&nbsp;</label>
                <asp:Button ID="updateButton" runat="server" text="Update" CssClass="button button-create"
                    CommandName="Update" CausesValidation="True" />
                        
                <asp:Button ID="btnCancel" runat="server" CssClass="button"
                    CommandName="Cancel" Text="Cancel" />
            </div>
            </asp:Panel>
        </EditItemTemplate>
    </asp:FormView>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        UpdateCommand="UPDATE UserProfile SET subscription=@subscription, tourPhase=@tourPhase WHERE userid = @userid"
        SelectCommand="
            SELECT *
            FROM [UserProfile] WHERE userid = @userid" SelectCommandType="Text">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="userid" Name="userid" />
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>