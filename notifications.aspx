<%@ Page Title="Notifications - Buildmate" Language="VB" MasterPageFile="~/common/Manager.master" AutoEventWireup="false" CodeFile="notifications.aspx.vb" Inherits="notifications" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlId="fvNotifications">
                <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="fvNotifications" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>

    <div class="div66">
        
    <div class="box">
        <h3>Notifications</h3>
            
        <div class="boxcontent">
        
            <telerik:RadGrid ID="rgNotifications" runat="server" CellSpacing="0"
                DataSourceID="userNotificationDataSource" GridLines="None">
                <MasterTableView AutoGenerateColumns="False" DataKeyNames="id" 
                                    DataSourceID="userNotificationDataSource">
                <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>

                <RowIndicatorColumn Visible="True">
                <HeaderStyle Width="20px"></HeaderStyle>
                </RowIndicatorColumn>

                <ExpandCollapseColumn Visible="True">
                <HeaderStyle Width="20px"></HeaderStyle>
                </ExpandCollapseColumn>

                    <Columns>
                        <telerik:GridBoundColumn DataField="title" Visible="false"
                            HeaderText="Title" 
                            SortExpression="title" UniqueName="title">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="description" 
                            HeaderText="Notification" 
                            SortExpression="description" UniqueName="description">
                        </telerik:GridBoundColumn>
                    </Columns>

                </MasterTableView>
                            </telerik:RadGrid>


            
                            <asp:Repeater ID="Repeater1" runat="server" DataSourceID="userNotificationDataSource">
                                <ItemTemplate>
                                    <%--<a href="dismiss_notice.aspx?id=<%#Eval("id")%>" class="dismiss" rel="<%#Eval("id")%>" title="Mark as Read">&times;</a>--%>
                                    <p>
                                        <strong><%#Eval("title")%></strong><br />
                                        <%#Eval("description")%>
                                        <a href="#">Mark as read</a>
                                    </p>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>         
                    </div>
    </div>

    <div class="div33r">
        <div class="box">
            <h3>Options</h3>

            <div class="boxcontent">
                <p>Select notifications you wish to receive:</p>
                
                <div class="row">
                    <asp:Label ID="Label1" runat="server">
                        <asp:CheckBox ID="CheckBox1" runat="server" />
                        Daily deals
                    </asp:Label>
                </div>
                
                <div class="row">
                    <asp:Label ID="Label2" runat="server">
                        <asp:CheckBox ID="CheckBox2" runat="server" />
                        Overdue Projects
                    </asp:Label>
                </div>

                <div class="row">
                    <asp:Label ID="Label3" runat="server">
                        <asp:CheckBox ID="CheckBox3" runat="server" />
                        Deadline Projects
                    </asp:Label>
                </div>

                <div class="row">
                    <asp:Label ID="Label4" runat="server">
                        <asp:CheckBox ID="CheckBox4" runat="server" />
                        Hints/Tips
                    </asp:Label>
                </div>
                
                <div class="row">
                    <asp:Label ID="Label5" runat="server">
                        <asp:CheckBox ID="CheckBox5" runat="server" />
                        New Features
                    </asp:Label>
                </div>            
                
                
                <div class="row">
                    <asp:Label ID="Label6" runat="server">
                        <asp:CheckBox ID="CheckBox6" runat="server" />
                        Blog Articles
                    </asp:Label>
                </div>

                
                <div class="row">
                    <asp:Label ID="Label7" runat="server">
                        <asp:CheckBox ID="CheckBox7" runat="server" />
                        By Suppliers
                    </asp:Label>
                </div>
            </div>
        </div>
    </div>



        <asp:SqlDataSource ID="userNotificationDataSource" runat="server" 
            ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
            SelectCommand="getUserNotificationsByUser" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:SessionParameter Name="userId" SessionField="userId" />
            </SelectParameters>
        </asp:SqlDataSource>

</asp:Content>

