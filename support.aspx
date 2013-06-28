<%@ Page Language="VB" MasterPageFile="~/common/Manager.master" AutoEventWireup="false" CodeFile="support.aspx.vb" Inherits="manager_Default" title="Support - BuildMate" %>

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


    <div class="div75">

    <div class="box">
        <h3>Support</h3>

        <div class="boxcontent">
            <div class="div50">
                <div class="row">
                    <asp:RadioButtonList
                        ID="rbTickets"
                        runat="server"
                        RepeatDirection="Horizontal"
                        AutoPostBack="true">
                        <asp:ListItem Text="Open Tickets" Selected="True" />
                        <asp:ListItem Text="Closed Tickets"  />
                        <asp:ListItem Text="All Tickets" />
                    </asp:RadioButtonList>
                </div>
            </div>

            <div class="div50r rightalign" style="margin-bottom: 10px">
                <a href="add_ticket.aspx" class="button create">Create a Ticket</a>
            </div>

    <div class="clear">
        <telerik:RadGrid
            ID="rgTickets"
            runat="server"
            DataSourceID="ticketsDataSource"
            AllowPaging="true"
            PagerStyle-Mode="NextPrev"
            PageSize="20"
            GridLines="None">
            <MasterTableView
                AutoGenerateColumns="False"
                DataKeyNames="id"
                NoMasterRecordsText="&nbsp;No Support Tickets were found."
                DataSourceID="ticketsDataSource">
                <Columns>
                    <telerik:GridTemplateColumn
                        UniqueName="isLocked"
                        SortExpression="isLocked"
                        ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:Image
                                ID="Image1"
                                runat="server"
                                Height="16px"
                                ImageAlign="AbsMiddle"
                                ImageUrl="~/icons/lock.png"
                                Visible='<%#Eval("isLocked") %>' />
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>

                    <telerik:GridHyperLinkColumn
                        HeaderText="Subject"
                        DataNavigateUrlFormatString="view_ticket.aspx?id={0}"
                        DataNavigateUrlFields="id"
                        SortExpression="subject"
                        UniqueName="subject"
                        DataTextField="subject"
                        HeaderStyle-Width="75%" />
                        
                    <telerik:GridButtonColumn
                        HeaderText="Subject"
                        Visible="false"
                        CommandName="ViewTicket"
                        DataTextField="supSubject"
                        SortExpression="supSubject"
                        UniqueName="supSubject"
                        HeaderStyle-Width="75%" />
                            
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
    </div>
    </div>
    </div>
    </div>


    <div class="div25r">
        <h3>How to get help</h3>

        <p>
            If you can't find a solution to your problem in our <a href="http://getbuildmate.com/knowledgebase/" target="_blank">Knowledge Base</a>,
            you can submit a ticket by selecting the 'Create a Ticket' button to the left.
        </p>
        
        <h3>How it works..</h3>

        <p>Once you submit your Ticket one of our Support team will be in touch with you as soon as possible.</p>
        
        <p>Each time they respond you'll be able to read their reply by selecting the relevant Ticket from the list to the left.</p>
        
        <p><strong>Note:</strong> We'll also send the response as an email to your registered email address.</p>
    </div>

    <div class="clear"></div>


    <asp:SqlDataSource ID="ticketsDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        FilterExpression="isLocked <> 1"
        SelectCommand="SELECT * FROM SupportTickets WHERE userId = @userId ORDER BY dateCreated DESC">
        <SelectParameters>
            <asp:SessionParameter name="UserId" SessionField="UserId" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>