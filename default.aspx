<%@ Page Title="Dashboard - Buildmate" Language="VB" MasterPageFile="~/common/Manager.master" AutoEventWireup="false" CodeFile="default.aspx.vb" Inherits="manager_default" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="head" ContentPlaceHolderID="head" Runat="Server">
    <script>
        setTimeout(function () {
            $('body').addClass('show-toggle-help');

            $('.toggle-help').hover(function () {
                $('body').removeClass('show-toggle-help');
            })
        }, 4000);
    </script>
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
    
    <asp:SqlDataSource ID="overdueDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="getOverdueProjects" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="userId" SessionField="userId" />
        </SelectParameters>
    </asp:SqlDataSource>

    
    <asp:SqlDataSource ID="NotificationDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="getSystemNotifications" SelectCommandType="StoredProcedure">
    </asp:SqlDataSource>
</asp:Content>

<asp:Content ID="SidebarContent" ContentPlaceHolderID="Sidebar" Runat="Server">

    <h1>Dashboard <span>Take a Tour</span></h1>

    <div class="tour-nav" data-tour="menu">
        <ul>
            <li class="active"><a href="#" data-tab="step1">1. Tour</a></li>
            <li><a href="#" data-tab="step2">2. Dashboard</a></li>
            <li><a href="#" data-tab="step3">3. Navigation</a></li>
            <li><a href="#" data-tab="step4">4. Help</a></li>
        </ul>
    </div>

    <div class="tour-content">
        <div data-target="step1">
            <iframe width="640" height="480" src="//www.youtube.com/embed/As_8TH8wwHM" frameborder="0" allowfullscreen></iframe>
        </div>
                
        <div data-target="step2" class="hide">
            <iframe width="640" height="480" src="//www.youtube.com/embed/WS9IRaYryg8" frameborder="0" allowfullscreen></iframe>
        </div>

        <div data-target="step3" class="hide">
            <iframe width="640" height="480" src="//www.youtube.com/embed/SH5ik7orZZw" frameborder="0" allowfullscreen></iframe>
        </div>

        <div data-target="step4" class="hide">
            <iframe width="640" height="480" src="//www.youtube.com/embed/5VdfodBie2o" frameborder="0" allowfullscreen></iframe>
        </div>
    </div>
</asp:Content>
