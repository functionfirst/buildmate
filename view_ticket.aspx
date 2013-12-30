<%@ Page Title="View Ticket - Buildmate" Language="VB" MasterPageFile="~/common/Manager.master" AutoEventWireup="false" CodeFile="view_ticket.aspx.vb" Inherits="view_ticket" %>

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
            <telerik:AjaxSetting AjaxControlId="fvReply">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="fvReply" />
                     <telerik:AjaxUpdatedControl ControlID="rReplies" />
                     <telerik:AjaxUpdatedControl ControlID="notification" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>

    <div class="breadcrumb">
        <div class="breadcrumb-container">
            <ul class="breadcrumb-list">
                <li>
                    <a href="support.aspx">Support</a>
                    <span class="divider">/</span>
                </li>
                <li class="active">
                    Ticket Details
                </li>
            </ul>
        </div>
    </div>

    <div class="main-container">
        <asp:FormView
            ID="fvViewTicket"
            runat="server"
            RenderOuterTable="false"
            DataKeyNames="id"
            DataSourceID="viewTicketDataSource">
            <ItemTemplate>
                <h3><%# Eval("subject")%></h2>

                <asp:HiddenField
                    ID="isLocked"
                    runat="server"
                    Value='<%#eval("isLocked") %>'/>

                <asp:Image
                    ID="Image1"
                    runat="server"
                    ImageUrl="~/icons/lock.png"
                    ImageAlign="AbsMiddle"
                    CssClass="floatright"
                    Visible='<%#Eval("isLocked") %>' />
                    
                <%# Eval("content")%>

                <p>
                    <small>
                        Created by <%#Eval("name")%> on 
                        <%#Eval("dateCreated", "{0:f}")%>
                    </small>
                </p>
            </ItemTemplate>
        </asp:FormView>

            <asp:Repeater
                ID="rReplies"
                runat="server"
                DataSourceID="relatedTicketsDataSource">

                <ItemTemplate>
                    <hr />
                    <div class='<%# iif(eval("userId") = eval("mainUserId"), "", " admin_reply") %>'>
                        <%#Eval("repContent")%><br />
                        <small>
                            By <strong><%#Eval("name")%></strong> on
                            <%#Eval("repDate", "{0:f}")%>
                        </small>
                    </div>
                    <hr />
                </ItemTemplate>
            </asp:Repeater>

            <asp:FormView
                ID="fvReply"
                runat="server"
                DataKeyNames="id"
                Width="100%"
                DataSourceID="viewTicketDataSource"
                DefaultMode="Insert">
                <InsertItemTemplate>
                            <div class="row">
                                <telerik:RadTextBox
                                    ID="rtbReplyContent"
                                    runat="server"
                                    Text='<%#Bind("repContent") %>'
                                    TextMode="MultiLine"
                                    Height="60px"
                                    EmptyMessage="Add a Note..."
                                    MaxLength="1000"
                                    Width="100%" />
                            </div>

                            <div class="form-actions">
                                <asp:Button ID="btnUpdate" runat="server"
                                    Enabled='<%# Iif(eval("isLocked"), false, true) %>'
                                    CausesValidation="True"
                                    CommandName="Insert"
                                    CssClass="button button-create"
                                    Text="Add Note" />
                            </div>
                    
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
                </InsertItemTemplate>
            </asp:FormView>
    </div>
          
    <asp:SqlDataSource
        ID="viewTicketDataSource"
        runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        InsertCommand="insertSupportReply"
        InsertCommandType="StoredProcedure"
        SelectCommand="getSupportTicketDetails"
        SelectCommandType="StoredProcedure">
        <InsertParameters>
            <asp:SessionParameter name="UserId" SessionField="UserId" />
            <asp:QueryStringParameter Name="ticketId" QueryStringField="id" />
        </InsertParameters>
        <SelectParameters>
            <asp:SessionParameter name="UserId" SessionField="UserId" />
            <asp:QueryStringParameter Name="ticketId" QueryStringField="id" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource
        ID="relatedTicketsDataSource"
        runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="getSupportTicketReplies"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter name="UserId" SessionField="UserId" />
            <asp:QueryStringParameter Name="ticketId" QueryStringField="id" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>