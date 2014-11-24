<%@ Page Language="VB" MasterPageFile="~/common/Manager.master" AutoEventWireup="false" CodeFile="support.aspx.vb" Inherits="manager_Default" title="Support - Buildmate" %>

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
            <telerik:AjaxSetting AjaxControlId="Panel1">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="Panel1" />
                     <telerik:AjaxUpdatedControl ControlID="notification" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>

     <!-- begin add ticket -->
    <div id="addTicket" class="md-window">
        <div class="md-content">
            <h3>Submit a New Support Issue..</h3>

            <asp:Panel ID="Panel1" runat="server" DefaultButton="btnSend">
                <div class="md-details">
                    <div class="row">
                        <asp:Label ID="Label1" runat="server" Text="Subject*"
                            AssociatedControlID="rtbSubject" CssClass="label" />
                
                        <telerik:RadTextBox
                            ID="rtbSubject"
                            runat="server"
                            EmptyMessage="Enter your subject..."
                            Text='<%#Bind("subject") %>'
                            MaxLength="50"
                            Width="300px" />

                        <asp:RequiredFieldValidator
                            ID="RequiredFieldValidator2"
                            runat="server"
                            ErrorMessage="Content"
                            Display="Dynamic"
                            ControlToValidate="rtbSubject">
                            <span class="req"></span>
                        </asp:RequiredFieldValidator>
                    </div>

                    <div class="row">
                        <asp:Label ID="lblContent" runat="server" Text="Description*"
                            AssociatedControlID="rtbContent" CssClass="label" />
                
                        <telerik:RadTextBox ID="rtbContent" runat="server"
                            EmptyMessage="Enter your support request..."
                            Text='<%#Bind("supContent") %>' TextMode="MultiLine"
                            Height="240px" Width="460px" />

                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                            ErrorMessage="Content" Display="Dynamic" ControlToValidate="rtbContent">
                            <span class="req"></span>
                        </asp:RequiredFieldValidator>
                    </div>
                </div>

                <div class="md-footer">
                    <asp:Button ID="btnSend" runat="server" CssClass="button button-create" Text="Submit Issue"
                        OnClientClick="validateModal()" 
                        CausesValidation="true" CommandName="Insert" />
                            
                    <a href="#" class="button md-close">Close</a>
                </div>
            </asp:Panel>
        </div>
    </div>

    <div class="breadcrumb">
        <div class="breadcrumb-container">
            <ul class="breadcrumb-options">
                <li><a href="#" data-target="addTicket" class="js-open-modal button button-create">Submit a Support Issue</a></li>
            </ul>
            <ul class="breadcrumb-list">
                <li class="active">Support</li>
            </ul>
        </div>
    </div>

    <div class="main-container">
        <div class="row">
            <asp:RadioButtonList
                ID="rbTickets"
                runat="server"
                RepeatDirection="Horizontal"
                AutoPostBack="true">
                <asp:ListItem Text="Open Issues" Selected="True" />
                <asp:ListItem Text="Closed Issues"  />
                <asp:ListItem Text="All Issues" />
            </asp:RadioButtonList>
        </div>

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
                NoMasterRecordsText="&nbsp;No Support Issues were found."
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

    <asp:SqlDataSource ID="ticketsDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        FilterExpression="isLocked <> 1"
        SelectCommand="SELECT * FROM SupportTickets WHERE userId = @userId ORDER BY dateCreated DESC">
        <SelectParameters>
            <asp:SessionParameter name="UserId" SessionField="UserId" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>