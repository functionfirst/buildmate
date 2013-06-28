<%@ Page Language="VB" MasterPageFile="~/common/Manager.master" AutoEventWireup="false" CodeFile="customers.aspx.vb" Inherits="manager_Default" title="Customers - BuildMate" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="head" ContentPlaceHolderID="head" Runat="Server"></asp:Content>

<asp:Content ID="Content" ContentPlaceHolderID="MainContent" Runat="Server">

    <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlId="btnApplyFilter">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="rgCustomers" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlId="btnRemoveFilter">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="rgCustomers" />
                     <telerik:AjaxUpdatedControl ControlID="Panel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlId="rgCustomers">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="rgCustomers" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>

    <div class="box">
        <h3>Customers</h3>

        <div class="boxcontent">
    <div class="div50">
        <asp:Panel
            ID="Panel1"
            runat="server"
            DefaultButton="btnApplyFilter">
            <div id="advSearch" class="search">
                <a href="#" class="toggleSearch"><span></span></a>
                <telerik:RadTextBox
                    ID="rtbFilter"
                    runat="server"
                    CssClass="searchInput"
                    EmptyMessage="Search by customer name or address"
                    Width="220px" />
              
                <asp:LinkButton
                    ID="btnRemoveFilter"
                    runat="server"
                    Text="clear" />

                <div class="panel">
                    <div class="row">
                        <asp:CheckBox
                            ID="cbArchived"
                            runat="server"
                            Text="Include archived customers" />
                    </div>

                    <div class="row">
                        <asp:Button
                            ID="btnApplyFilter"
                            runat="server"
                            Text="Apply Filters" />
                    </div>
                </div>
            </div>
        </asp:Panel>
    </div>
    
    <div class="div50r rightalign">
        <a href="add_customer.aspx" class="button create">+ Add a Customer</a>
    </div>
    
    <div class=" clear">
        <telerik:RadGrid
            ID="rgCustomers"
            runat="server"
            EnableLinqExpressions="false"
            DataSourceID="allCustomersDataSource"
            AllowAutomaticDeletes="true"
            AllowPaging="true"
            EnableAJAX="True"
            GridLines="None"
            PageSize="20"
            PagerStyle-Mode="NextPrev"
            AutoGenerateColumns="false"
            ShowStatusBar="true"
            AllowSorting="true">
            <MasterTableView
                DataSourceID="allCustomersDataSource"
                AutoGenerateColumns="False"
                GridLines="None"
                DataKeyNames="id"
                NoMasterRecordsText="&nbsp;No Customers were found.">
                <Columns>
                    <telerik:GridHyperLinkColumn
                        UniqueName="customerName"
                        HeaderText="Name"
                        SortExpression="customerName"
                        DataTextField="customerName"
                        DataNavigateUrlFields="id"
                        DataNavigateUrlFormatString="customer_details.aspx?id={0}" />
                        
                    <telerik:GridBoundColumn
                        Visible="false"
                        UniqueName="firstname"
                        DataField="firstname"
                        HeaderText="firstname"
                        SortExpression="firstname" />
         
                    <telerik:GridBoundColumn
                        UniqueName="address"
                        DataField="customerAddress"
                        HeaderText="Address"
                        SortExpression="customerAddress" />

                    <telerik:GridBoundColumn
                        DataField="city"
                        HeaderText="Town/City" 
                        SortExpression="city"
                        UniqueName="city" />

                    <telerik:GridBoundColumn
                        DataField="county"
                        HeaderText="County" 
                        SortExpression="county"
                        UniqueName="county" />

                    <telerik:GridBoundColumn
                        DataField="postcode"
                        HeaderText="Postcode" 
                        SortExpression="postcode"
                        UniqueName="postcode" />

                    <telerik:GridTemplateColumn
                        UniqueName="archived"
                        SortExpression="archived"
                        HeaderText="Archived"
                        HeaderStyle-HorizontalAlign="Center"
                        ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:CheckBox
                                ID="CheckBox1"
                                runat="server"
                                AutoPostBack="true"
                                Checked='<%#Bind("archived") %>'
                                OnCheckedChanged="OnCheckChanged" />
                            
                            <asp:HiddenField
                                ID="hiddenCustomerId"
                                runat="server"
                                Value='<%#Eval("id") %>' />
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    </div>
    </div>

    <asp:SqlDataSource
        ID="allCustomersDataSource"
        runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        FilterExpression="archived = 0"
        SelectCommand="getUserContactsByUserId"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter
                Name="UserId"
                SessionField="UserId" />
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>