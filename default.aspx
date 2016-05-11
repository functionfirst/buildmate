<%@ Page Title="Dashboard - Buildmate" Language="VB" MasterPageFile="~/common/Manager.master" AutoEventWireup="false" CodeFile="default.aspx.vb" Inherits="manager_default" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="head" ContentPlaceHolderID="head" Runat="Server">
    <telerik:RadScriptBlock ID="rsbPhase0" runat="server" Visible="false">
    <script type="text/javascript">
        var data = {
            target: "#ctl00_hlCustomers",
            progress: 0,
            tooltip: {
                title: "Welcome to Buildmate",
                content: "Add your first Customer. Click the Customers link above to begin.",
                videoId: "QxhB-S1UoG4"
            }
        };
        manualTourStep(data);
    </script>
    </telerik:RadScriptBlock>

    <telerik:RadScriptBlock ID="rsbPhase1" runat="server" Visible="false">
    <script type="text/javascript">
        var data = {
            target: "#ctl00_hlProjects",
            progress: 1,
            tooltip: {
                title: "Managing Projects",
                content: "Now you've created your first Customer, the next step is to create a Project for them.<br /><br />Click Projects in the top menu to get started."
            }
        };

        $(document).ready(function () {
            manualTourStep(data);
        });
    </script>
    </telerik:RadScriptBlock>
    <telerik:RadScriptBlock ID="rsbPhase6" runat="server" Visible="false">
    <script type="text/javascript">
        var data = {
            target: "#ctl00_hlSuppliers",
            progress: 2,
            tooltip: {
                title: "Managing your Suppliers",
                content: "Now that you've added your first Resource, it's important you understand how Suppliers work.<br /><br />Click the Suppliers link above to begin."
            }
        };

        $(document).ready(function () {
            manualTourStep(data);
        });
    </script>
    </telerik:RadScriptBlock>

    <telerik:RadScriptBlock ID="rsbPhase8" runat="server" Visible="false">
    <script type="text/javascript">
        var data = {
            target: "#ctl00_hlResources",
            progress: 2,
            tooltip: {
                title: "Managing Resources",
                content: "Now that you've setup some Suppliers lets link your Resources to your Suppliers.<br /><br />Click the Resources link above to begin."
            }
        };

        $(document).ready(function () {
            manualTourStep(data);
        });
    </script>
    </telerik:RadScriptBlock>
    <telerik:RadScriptBlock ID="rsbPhase9" runat="server" Visible="false">
    <script type="text/javascript">
        var data = {
            target: "#ctl00_hlHome",
            progress: 4,
            tooltip: {
                title: "Congratulations!",
                content: "You have now successfully completed all areas of the Buildmate Tutorial and should now have everything you need to get started.<br /><br />For further help or assistance please visit our <a target='_blank' href='http://getbuildmate.com/knowledgebase' class='lnk'>Knowledge Base</a> or you can request help using our <a href='support/' class='lnk'>Support</a> page.<br /><br /><a href='end_tutorial.aspx' class='button button-create'>Start Estimating..</a>"
            }
        };

        $(document).ready(function () {
            manualTourStep(data);
        });
    </script>
    </telerik:RadScriptBlock>
</asp:Content>

<asp:Content ID="Content" ContentPlaceHolderID="MainContent" Runat="Server">
    
    <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlId="pQuickReports">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="pQuickReports" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlId="pOverdueTenders">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="pOverdueTenders" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlId="pPendingTenders">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="pPendingTenders" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlId="rcbDays">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="rgPendingProjects" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>

    <div class="breadcrumb">
        <div class="breadcrumb-container">
            <ul class="breadcrumb-list">
                <li class="active">Dashboard</li>
            </ul>
        </div>
    </div>

    <div class="main-container">

    <asp:Panel ID="pMainPanel" runat="server">
        <div class="div33">
            <div class="box">

                <asp:Panel ID="pOverdueTenders" runat="server">
                    <h3>Reminders</h3>
                    <h4>Overdue Projects</h4>

                    <div class="boxcontent">
                        <telerik:radgrid
                            id="rgOverdueProjects"
                            runat="server"
                            EnableViewState="false"
                            AllowPaging="true"
                            PageSize="10"
                            DatasourceId="overdueDataSource"
                            Gridlines="None">
                            <MasterTableView
                                AutoGenerateColumns="False"
                                DataKeyNames="id"
                                DataSourceID="overdueDataSource"
                                NoMasterRecordsText="&nbsp;You have no overdue projects"
                                AllowSorting="true">
                                <Columns>
                                    <telerik:GridTemplateColumn
                                        HeaderText="Project Name"
                                        SortExpression="projectName"
                                        UniqueName="projectName"
                                        HeaderStyle-Width="60%">
                                        <ItemTemplate>
                                            <asp:HyperLink ID="HyperLink1" runat="server"
                                            NavigateUrl='<%# "~/project_details.aspx?pid=" & Eval("id") %>'
                                            Text='<%#Bind("projectName") %>' />
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                            
                                    <telerik:GridBoundColumn
                                        DataField="returndate"
                                        DataType="System.DateTime"
                                        HeaderStyle-Width="40%" 
                                        HeaderText="Return Date"
                                        SortExpression="returndate"
                                        DataFormatString="{0:D}" 
                                        ItemStyle-HorizontalAlign="Center"
                                        HeaderStyle-HorizontalAlign="Center"
                                        UniqueName="returndate" />
                                </Columns>
                            </MasterTableView>
                        </telerik:radgrid>
                    </div>
                </asp:Panel>

                    <h4>Projects Due</h4>

                    <div class="boxcontent">
                        <div class="row">
                            <asp:Label
                                ID="Label1"
                                runat="server"
                                CssClass="label"
                                AssociatedControlID="rcbDays"
                                Text="Return Date:" />
            
                            <telerik:RadComboBox
                                ID="rcbDays"
                                runat="server"
                                AutoPostBack="true">
                                <Items>
                                    <telerik:RadComboBoxItem Text="Imminent" Value="2" />
                                    <telerik:RadComboBoxItem Text="within One Week" Value="7" />
                                    <telerik:RadComboBoxItem Text="within Two Weeks" Value="14" />
                                    <telerik:RadComboBoxItem Text="within One Month" Value="30" />
                                    <telerik:RadComboBoxItem Text="within Three Months" Value="90" />
                                </Items>
                            </telerik:RadComboBox>
                        </div>
 
                        <telerik:radgrid
                            id="rgPendingProjects"
                            runat="server"
                            AllowPaging="true"
                            PageSize="10"
                            datasourceid="pendingDataSource"
                            gridlines="None">
                            <MasterTableView
                                AutoGenerateColumns="False"
                                DataKeyNames="id"
                                DataSourceID="pendingDataSource"
                                NoMasterRecordsText="&nbsp;No projects pending"
                                AllowSorting="true">
                                <Columns>
                                    <telerik:GridTemplateColumn HeaderText="Project Name" SortExpression="projectName" UniqueName="projectName" HeaderStyle-Width="40%">
                                        <ItemTemplate>
                                            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# "~/project_details.aspx?pid=" & Eval("id") %>' Text='<%#Bind("projectName") %>' />
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                            
                                    <telerik:GridBoundColumn DataField="returndate" DataType="System.DateTime" HeaderStyle-Width="35%" 
                                        HeaderText="Return Date" SortExpression="returndate" DataFormatString="{0:D}" 
                                        ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"
                                        UniqueName="returndate" />
                                            
                                    <telerik:GridBoundColumn DataField="daystogo" DataType="System.Int32"  HeaderStyle-Width="25%"
                                        HeaderText="Remaining" ReadOnly="True" SortExpression="daystogo"
                                        ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"
                                        UniqueName="daystogo" />
                                </Columns>
                            </MasterTableView>
                        </telerik:radgrid>
     
                    </div>
            </div>
        </div>

        <div class="div33">
            <div class="box">
                <h3>Statistics</h3>

                <div class="boxcontent">
                    <telerik:RadGrid ID="rgStatistics" runat="server"
                        DataSourceID="statisticsDataSource" GridLines="None">
                        <MasterTableView
                            NoMasterRecordsText="&nbsp;No projects available"
                            DataSourceID="statisticsDataSource"
                            AutoGenerateColumns="False"
                            ShowFooter="true">
                        <RowIndicatorColumn>
                        <HeaderStyle Width="20px"></HeaderStyle>
                        </RowIndicatorColumn>
                        <ExpandCollapseColumn>
                        <HeaderStyle Width="20px"></HeaderStyle>
                        </ExpandCollapseColumn>
                            <Columns>
                                <telerik:GridTemplateColumn HeaderText="Status" SortExpression="status" UniqueName="status">
                                    <ItemTemplate>
                                    <asp:HyperLink ID="HyperLink1" runat="server"
                                        NavigateUrl='<%# "~/projects.aspx?status=" & Eval("projectStatusId") %>'
                                        Text='<%#Bind("status") %>' />
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridBoundColumn
                                    DataField="totalCount"
                                    DataType="System.Int32" 
                                    HeaderText="Total"
                                    ReadOnly="True"
                                    SortExpression="totalCount" 
                                    HeaderStyle-HorizontalAlign="Center" 
                                    ItemStyle-HorizontalAlign="Center"
                                    UniqueName="totalCount" />

                                <telerik:GridBoundColumn
                                    DataField="totalValue"
                                    DataType="System.Decimal" 
                                    HeaderText="Value"
                                    ReadOnly="True"
                                    HeaderStyle-HorizontalAlign="Right"
                                    ItemStyle-HorizontalAlign="Right"
                                    DataFormatString="{0:C2}"
                                    SortExpression="totalValue" 
                                    UniqueName="totalValue" />
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
    
                    <br />

                    <asp:Repeater ID="Repeater3" runat="server" DataSourceID="archivedProjects">
                        <ItemTemplate>
                            <table class="table" width="100%" cellspacing="0" cellpadding="0">
                                <thead>
                                    <tr>
                                        <th class="leftalign">Archived</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td><a href="projects.aspx#archived"><%#Eval("totalCount")%> projects</a></td>
                                    </tr>
                                </tbody>
                            </table>
                        </ItemTemplate>
                    </asp:Repeater>

                    <br />
        
                    <asp:FormView ID="fvStatistics" runat="server" DataSourceID="analysisDataSource" Width="100%">
                        <ItemTemplate>
                            <div class="RadGrid RadGrid_Default">
                            <table border="0" cellspacing="0" cellpadding="0" width="100%" class="rgMasterTable">
                                <colgroup>
                                    <col width="40%" />
                                    <col width="30%" />
                                    <col width="30%" />
                                </colgroup>
                                <thead>
                                    <tr>
                                        <th class="rgHeader" align="left">Analysis</th>
                                        <th class="rgHeader">This Week</th>
                                        <th class="rgHeader" align="right">This Month</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr class="rgRow">
                                        <td>Total value Won</td>
                                        <td align="center"><%#Eval("thisWeekValue", "{0:C2}")%></td>
                                        <td align="right"><%#Eval("thisMonthValue", "{0:C2}")%></td>
                                    </tr>
                                    <tr class="rgAltRow">
                                        <td>Total Value Lost</td>
                                        <td align="center"><%#Eval("thisWeekLoss", "{0:C2}")%></td>
                                        <td align="right"><%#Eval("thisMonthLoss", "{0:C2}")%></td>
                                    </tr>
                                    <tr class="rgRow">
                                        <td>Success Rate</td>
                                        <td align="center"><%#Eval("successRate", "{0:N}%")%></td>
                                        <td align="right"><%#Eval("successRateMonthly", "{0:N}%")%></td>
                                    </tr>
                                    <tr class="rgAltRow">
                                        <td>Loss Rate</td>
                                        <td align="center"><%#Eval("lossRate", "{0:N}%")%></td>
                                        <td align="right"><%#Eval("lossRateMonthly", "{0:N}%")%></td>
                                    </tr>
                                    <!--tr>
                                        <td colspan="2">Cumulative Avg. Lost</td>
                                        <td class="rightalign"></td>
                                    </tr-->
                                    <!--tr>
                                        <td colspan="2">Cumulative % over mean bid</td>
                                        <td class="rightalign"></td>
                                    </tr-->
                                </tbody>
                            </table>
                            </div>
                        </ItemTemplate>
                    </asp:FormView>
                </div>
            </div>
        </div>


        <div class="div33 div-last">
        
                    <div class="box">
                        <h3>News</h3>

                        <div class="boxcontent">
                            <asp:Repeater ID="Repeater1" runat="server" DataSourceID="NotificationDataSource">
                                <ItemTemplate>
                                    <p>
                                        <a href="<%#Eval("URL")%>" target="_blank"><%#Eval("Title")%></a><br />
                                        <!--
                                        <small>
                                            Posted on <%# DataBinder.Eval(Container.DataItem, "DateStart", "{0:MMMM d, yyyy}")%>
                                        </small><br />
                                        -->

                                        <%#Eval("Abstract")%>
                                    </p>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                    </div>
        </div>
            <div class="clear"></div>
        </asp:Panel>
    </div>

    <asp:SqlDataSource ID="statisticsDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>" 
        SelectCommand="getProjectStatistics" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="userId" SessionField="userId" />
        </SelectParameters>
    </asp:SqlDataSource>
    
    <asp:SqlDataSource ID="analysisDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>" 
        SelectCommand="getProjectAnalysis" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="userId" SessionField="userId" />
        </SelectParameters>
    </asp:SqlDataSource>
    
    <asp:SqlDataSource ID="pendingDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>" 
        SelectCommand="getPendingProjects" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="userId" SessionField="userId" />
            <asp:ControlParameter Name="days" ControlID="rcbDays" PropertyName="SelectedValue"  />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="archivedProjects" runat="server" 
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>" 
        SelectCommand="SELECT count(id) as totalCount FROM Project WHERE userid = @userId and archived = 1">
        <SelectParameters>
            <asp:SessionParameter Name="userId" SessionField="userId" />
        </SelectParameters>
    </asp:SqlDataSource>
    
    <asp:SqlDataSource ID="overdueDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="getOverdueProjects" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="userId" SessionField="userId" />
        </SelectParameters>
    </asp:SqlDataSource>

    
    <asp:SqlDataSource
        ID="projectsDataSource"
        runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="SELECT id FROM Project WHERE userid = @userid">
        <SelectParameters>
            <asp:SessionParameter Name="UserId" SessionField="UserId" />
        </SelectParameters>
    </asp:SqlDataSource>
    

    <asp:SqlDataSource ID="NotificationDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="getSystemNotifications" SelectCommandType="StoredProcedure">
    </asp:SqlDataSource>
</asp:Content>