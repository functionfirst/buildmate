<%@ Page Title="Add an Ad-hoc Item - BuildMate" Language="VB" MasterPageFile="~/common/Manager.master" AutoEventWireup="false" CodeFile="add_adhoc.aspx.vb" Inherits="manager_adhoc" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">

    <p class="breadcrumb">
        <a href="projects.aspx">Projects</a> &raquo;
        <asp:HyperLink ID="hlBack" runat="server"
            NavigateUrl="project_details.aspx?pid={0}"
            Text="Project Details" />
        &raquo;
        
        <asp:HyperLink ID="hlBack2" runat="server"
            NavigateUrl="build_element_details.aspx?pid={0}&rid={1}"
            Text="Build Element Details" />
        &raquo;
        
        <asp:HyperLink ID="hlBack3" runat="server"
            NavigateUrl="task_details.aspx?pid={0}&rid={1}&tid={2}"
            Text="Task Details" />
        &raquo;
        Add an Ad-hoc Item
    </p>

    <div class="box">
        <div class="box_top_edit">Add an Ad-Hoc Item</div>
        <div class="boxcontent">
            <asp:FormView ID="fvAddAdhoc" runat="server"
                DefaultMode="Insert"
                DataSourceID="additionsDataSource"
                Width="100%"
                DataKeyNames="id">
                        <InsertItemTemplate>
                            <div class="row">
                                <label for="rtbDescription" title="Description" class="label">Description</label>
                                <telerik:RadTextBox ID="rtbDescription" runat="server"
                                    TextMode="MultiLine" Columns="40" Height="50px"
                                    Text='<%#Bind("description") %>' MaxLength="255" />
                            </div>

                            <div class="row">
                                <label for="rntbPrice" title="Cost" class="label">Cost</label>
                                <telerik:RadNumericTextBox ID="RadNumericTextBox1" runat="server"
                                    EmptyMessage="£0.00" Width="80px"
                                    Value='<%#Bind("price") %>' Type="Currency" NumberFormat-DecimalDigits="2" />
                            </div>
                            
                            <div class="row">
                                <label for="rntbPercentage" title="Adjustment" class="label">Adjustment</label>
                                <telerik:RadNumericTextBox ID="RadNumericTextBox2" runat="server"
                                    EmptyMessage="0 %" MinValue="0" MaxValue="100" Width="60px"
                                    Value='<%#Bind("percentage") %>' Type="Percent" />
                            </div>
                            
                            <div class="row">
                                <label for="rcbType" title="Cost Modifier" class="label">Cost Modifier</label>
                                <telerik:RadComboBox ID="rcbType" runat="server"
                                    DataSourceID="adhocTypeDataSource" SelectedValue='<%#Bind("adhocTypeId") %>'
                                    DataTextField="type" DataValueField="id"  />
                            </div>
                            
                             <div class="row">
                                <label for="btnInsert" class="label">&nbsp;</label>
                                <asp:Button ID="btnInsert" runat="server" CausesValidation="True" 
                                    CommandName="Insert" Text="Add Ad-hoc Item" />
                            </div>
                        </InsertItemTemplate>
                    </asp:FormView>
        </div>
    </div>

    <asp:SqlDataSource ID="additionsDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        InsertCommand="INSERT INTO tblTaskAdditions(taskId, description, price, percentage, adhocTypeId)
        VALUES(@taskId, @description, @price, @percentage, @adhocTypeId)">
        <InsertParameters>
            <asp:QueryStringParameter Name="taskId" QueryStringField="tid" />
            <asp:Parameter Name="percentage" DefaultValue="0" />
        </InsertParameters>
    </asp:SqlDataSource>
    
    <asp:SqlDataSource ID="adhocTypeDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="SELECT * FROM tblAdhocTypes" />
</asp:Content>

