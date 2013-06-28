<%@ Page Title="View Ticket - My PyramidEstimator" Language="VB" MasterPageFile="~/common/admin.master" AutoEventWireup="false" CodeFile="view_ticket.aspx.vb" Inherits="view_ticket" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">

    <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlId="fvViewTicket">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="fvViewTicket" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlId="btnAddReply">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="rtbReplyContent" />
                     <telerik:AjaxUpdatedControl ControlID="rReplies" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>

    <p class="breadcrumb">
        <a href="support.aspx">Support</a>
        &raquo;
        Ticket Details
    </p>

    <asp:FormView
        ID="fvViewTicket"
        runat="server"
        DataKeyNames="id" Width="100%"
        DataSourceID="viewTicketDataSource">
        <ItemTemplate>
            <div class="box">
                <h3><%# Eval("subject")%></h2>

                <div class="boxcontent">
                    <asp:HiddenField
                        ID="isLocked"
                        runat="server"
                        Value='<%#eval("isLocked") %>'/>
                    
                    <div class="row">
                        <asp:Button
                            ID="btnClose"
                            OnClick="btnClose_OnClick"
                            runat="server"
                            CausesValidation="false"
                            Text="Close this Ticket"
                            CssClass="floatright"
                            Visible='<%# iif( Eval("isLocked"), false, true) %>' />
                        
                        <asp:Button
                            ID="btnOpen"
                            OnClick="btnOpen_OnClick"
                            runat="server"
                            CausesValidation="false"
                            Text="Re-open this Ticket"
                            CssClass="floatright"
                            Visible='<%# iif(Eval("isLocked"), true, false) %>' />
                        
                        <asp:Image
                            ID="Image1"
                            runat="server"
                            ImageUrl="~/icons/lock.png"
                            ImageAlign="AbsMiddle"
                            CssClass="floatright"
                            Visible='<%#Eval("isLocked") %>' />
                        <label class="label">Customer Name</label>
                        <%#Eval("name")%>
                    </div>
                    <div class="row">
                        <label class="label">Email</label>

                        <asp:Literal ID="litEmail" runat="server" Text='<%#Eval("email")%>' />
                    </div>

                    <div class="row">
                        <label class="label">Company</label>
                        <%#Eval("company")%>
                    </div>

                    <div class="row">
                        <label class="label">Created Date</label>
                        <%#Eval("dateCreated", "{0:f}")%>
                    </div>
                    
                    <hr />
                    
                    <div class="row">
                         <%# Eval("content")%>
                    </div>

                    <asp:Literal
                        ID="litFirstName"
                        runat="server"
                        Visible="false"
                        Text='<%#Eval("firstName")%>' />
                </div>
            </div>
        </ItemTemplate>
    </asp:FormView>

    <div class="box">
        <h3>Add a Note</h3>

        <div class="boxcontent">
            <p>
                <telerik:RadTextBox
                    ID="rtbReplyContent"
                    runat="server"
                    Text='<%#Bind("repContent") %>'
                    TextMode="MultiLine"
                    Height="60px"
                    MaxLength="1000"
                    Width="680px" />

                <asp:Button
                    ID="btnAddReply"
                    runat="server"
                    CausesValidation="True"
                    Text="Add Note" />
            </p>
                    
            <asp:RequiredFieldValidator
                ID="RequiredFieldValidator1"
                runat="server"
                ErrorMessage="*required"
                Display="Dynamic"
                ControlToValidate="rtbReplyContent">
                <div class="row">
                    <label class="label">&nbsp;</label>
                    <span class="req"></span>&nbsp;Content is required.        
                </div>
            </asp:RequiredFieldValidator>
        </div>
    </div>

    <asp:Repeater
        ID="rReplies"
        runat="server"
        DataSourceID="relatedTicketsDataSource">
        <HeaderTemplate>
            <table class="table" border="0" cellspacing="0" cellpadding="0" width="100%">
                <colgroup>
                    <col />
                    <col width="20%" />
                </colgroup>
                <thead>
                    <tr>
                        <th class="leftalign">Note</th>
                        <th class="leftalign">Added by</th>
                    </tr>
                </thead>
                <tbody>
        </HeaderTemplate>
        <ItemTemplate>
            <tr runat="server" id="row" class='<%# iif(eval("userId") = eval("mainUserId"), "ticket_alt", "ticket") %>'>
                <td valign="top"><p><%#Eval("repContent")%></p></td>
                <td valign="top">
                    <p><strong><%#Eval("name")%></strong></p> 
                    <p><%#Eval("repDate", "{0:f}")%></p>
                </td>
            </tr>
        </ItemTemplate>
        <FooterTemplate>
                </tbody>
            </table>
        </FooterTemplate>
    </asp:Repeater>
    
    <asp:SqlDataSource ID="viewTicketDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="
            SELECT SupportTickets.id, isLocked, dateCreated, subject, content, firstName, firstname + ' ' + surname AS name, company, email
            FROM SupportTickets
            LEFT JOIN UserProfile ON SupportTickets.userId = UserProfile.userId
            WHERE SupportTickets.id = @ticketId">
        <SelectParameters>
            <asp:SessionParameter name="UserId" SessionField="UserId" />
            <asp:QueryStringParameter Name="ticketId" QueryStringField="id" />
        </SelectParameters>
    </asp:SqlDataSource>

      
    <asp:SqlDataSource ID="relatedTicketsDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="
            SELECT repContent, repDate, firstName, firstname + ' ' + surname AS name, SupportReplies.userId, SupportTickets.userId AS mainUserId
            FROM SupportReplies
            LEFT JOIN UserProfile ON SupportReplies.userId = UserProfile.userId
            LEFT JOIN SupportTickets ON SupportTickets.id = SupportReplies.ticketId
            WHERE ticketId = @ticketId ORDER BY repDate">
        <SelectParameters>
            <asp:QueryStringParameter Name="ticketId" QueryStringField="id" />
        </SelectParameters>
    </asp:SqlDataSource>
    
</asp:Content>

