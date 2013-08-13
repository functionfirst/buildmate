<%@ Page Title="Dashboard - BuildMate" Language="VB" MasterPageFile="~/common/Manager.master" AutoEventWireup="false" CodeFile="default.aspx.vb" Inherits="manager_default" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="head" ContentPlaceHolderID="head" Runat="Server">

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
 
    <div class="div33">
        <asp:Panel ID="pOverdueTenders" runat="server" CssClass="box">
            <h3>Overdue Projects</h3>

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


        <div class="box">
            <h3>Projects Due</h3>

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
            <h3>Project Statistics</h3>

            <div class="boxcontent">
    
                <telerik:RadGrid ID="rgStatistics" runat="server"
                    DataSourceID="statisticsDataSource" GridLines="None">
                    <MasterTableView
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
                            <telerik:GridBoundColumn 
                                DataField="status"
                                HeaderText="Status" 
                                SortExpression="status"
                                UniqueName="status" />

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


    <div class="div33r">
        
        <div class="box">
            <h3>BuildMate News</h3>

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

    <ol id="chooseID" class="hide">
        <li data-button="Start the Tour &raquo;" class="welcome">
            <div class="joyride-container">
                <h3>Welcome to BuildMate</h3>
                <p>Click the button below to take a tour:</p>
            </div>
        </li>
        <li data-id="ctl00_hlHome" class="nav-guide" data-options="tipLocation:right">
            <div class="joyride-container">
                <h6>Dashboard</h6>
                <p>View Project Statistics and track Overdue Projects.</p>
            </div>
        </li>
        <li data-id="ctl00_hlProjects" class="nav-guide" data-options="tipLocation:right">
            <div class="joyride-container">
                <h6>Projects</h6>
                <p>Click here to open your Project list</p>
            </div>
        </li>
    </ol>




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