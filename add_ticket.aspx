<%@ Page Title="Submit a Support Ticket - BuildMate" Language="VB" MasterPageFile="~/common/Manager.master" AutoEventWireup="false" CodeFile="add_ticket.aspx.vb" Inherits="manager_adhoc" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="breadcrumb">
        <ul class="breadcrumb-list">
            <li>
                <a href="support.aspx">Support</a>
                <span class="divider">/</span>
            </li>
            <li class="active">
                Submit a Support Ticket
            </li>
        </ul>
    </div>

    <div class="main-container">
        <h1>Submit a Support Ticket</h1>

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
            <asp:Label ID="lblContent" runat="server" Text="Content*"
                AssociatedControlID="rtbContent" CssClass="label" />
                
            <telerik:RadTextBox ID="rtbContent" runat="server"
                EmptyMessage="Enter your support request..."
                Text='<%#Bind("supContent") %>' TextMode="MultiLine"
                Height="240px" Width="560px" />

            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                ErrorMessage="Content" Display="Dynamic" ControlToValidate="rtbContent">
                <span class="req"></span>
            </asp:RequiredFieldValidator>
        </div>

        <div class="form-actions">
            <asp:Button ID="btnSend" runat="server" CssClass="button button-create" Text="Submit Ticket"
                CausesValidation="true" CommandName="Insert" />
        </div>

    </div>
</asp:Content>