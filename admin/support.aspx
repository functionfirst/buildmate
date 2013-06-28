<%@ Page Language="VB" MasterPageFile="~/common/admin.master" AutoEventWireup="false" CodeFile="support.aspx.vb" Inherits="support" title="Support - My PyramidEstimator" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="head" ContentPlaceHolderID="head" Runat="Server"></asp:Content>

<asp:Content ID="Content" ContentPlaceHolderID="MainContent" Runat="Server">
    <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlId="rbTickets">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="rgTickets" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>

    <p class="breadcrumb">
        Support
    </p>



        <telerik:RadGrid ID="rgTickets" runat="server" DataSourceID="ticketsDataSource" AllowPaging="true"
                    PagerStyle-Mode="NextPrev" PageSize="10"
                    AllowSorting="true"
                    GridLines="None" Width="100%">
                    <MasterTableView AutoGenerateColumns="False" DataKeyNames="id"
                        NoMasterRecordsText="No Support Tickets were found." DataSourceID="ticketsDataSource">
                        <Columns>
                        <telerik:GridTemplateColumn UniqueName="isLocked" SortExpression="locked"
                                ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Image ID="Image1" runat="server" Height="16px" ImageAlign="AbsMiddle"
                                        ImageUrl="~/icons/lock.png" Visible='<%#Eval("isLocked") %>' />
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                            <telerik:GridHyperLinkColumn
                                HeaderText="Subject"
                                DataNavigateUrlFormatString="view_ticket.aspx?id={0}"
                                DataNavigateUrlFields="id"
                                SortExpression="subject"
                                UniqueName="subject"
                                DataTextField="subject"
                                HeaderStyle-Width="60%" />

                            <telerik:GridTemplateColumn
                                UniqueName="surname"
                                Headertext="Customer Name"
                                SortExpression="surname">
                                <ItemTemplate>
                                    <%#Eval("firstname")%>
                                    <%#Eval("surname")%>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                            <telerik:GridButtonColumn HeaderText="Company"
                                CommandName="Company"
                                DataTextField="Company"
                                SortExpression="Company"
                                UniqueName="Company" />
                            
                            <telerik:GridBoundColumn
                                DataField="dateCreated"
                                HeaderText="Date"
                                DataFormatString="{0:d}"
                                SortExpression="dateCreated"
                                UniqueName="dateCreated"
                                HeaderStyle-HorizontalAlign="Center"
                                ItemStyle-HorizontalAlign="Center" />
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>

        <asp:Panel ID="pContainer" runat="server" />

    <asp:SqlDataSource ID="ticketsDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="SELECT * FROM SupportTickets LEFT JOIN UserProfile ON UserProfile.userId = SupportTickets.userId ORDER BY dateCreated DESC">
        <SelectParameters>
            <asp:SessionParameter name="UserId" SessionField="UserId" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>