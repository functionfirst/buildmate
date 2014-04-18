    <%@ Page Title="Settings - Buildmate" Language="VB" MasterPageFile="~/common/Manager.master" AutoEventWireup="false" CodeFile="settings.aspx.vb" Inherits="settings" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {
            $('.tab-nav').find('a').click(function () {
                var target = $(this).attr('href');
                showTab(target);
                return false;
            });

        });

        function showTab(tabId) {
            $(tabId).addClass('tab-container-active').siblings().removeClass('tab-container-active');
            $('a[href="' + tabId + '"]').parent().addClass('active').siblings().removeClass('active');
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">

    <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlId="fvCompanyLogo">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="fvCompanyLogo" />
                     <telerik:AjaxUpdatedControl ControlID="notification" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlId="fvNotifications">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="fvNotifications" />
                     <telerik:AjaxUpdatedControl ControlID="notification" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlId="fvCompanyDetails">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="fvCompanyDetails" />
                     <telerik:AjaxUpdatedControl ControlID="notification" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlId="fvContactDetails">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="fvContactDetails" />
                     <telerik:AjaxUpdatedControl ControlID="notification" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>

    
    <div class="breadcrumb">
        <div class="breadcrumb-container">
            <ul class="breadcrumb-list">
                <li class="active">Settings</li>
            </ul>
        </div>
    </div>

    <div class="main-container">
        <div class="tabs">
            <ul class="tab-nav">
                <li class="active"><a href="#contact">Contact Details</a></li>
                <li><a href="#company">Company Details</a></li>
                <li><a href="#logo">Company Logo</a></li>
                <li><a href="#password">Change Password</a></li>
                <li><a href="#notifications">Notification Settings</a></li>
                <li><a href="#subscription">Subscription</a></li>
            </ul>
            
            <div class="tab-container tab-container-active" id="contact">
                <h3>Contact Details</h3>

                <asp:FormView ID="fvContactDetails" runat="server"
                            DefaultMode="Edit"
                    Width="100%"
                            DataSourceID="userProfileDataSource">
                            <EditItemTemplate>
                                <asp:Panel ID="Panel1" runat="server" DefaultButton="btnUpdate">
                                    <div class="row">
                                        <asp:Label ID="lblName" runat="server"
                                            Text="Name"
                                            CssClass="label"
                                            AssociatedControlID="rtbName" />

                                        <telerik:RadTextBox ID="rtbName" runat="server"
                                            Text='<%#Bind("name") %>'
                                            EmptyMessage="Name" />
                                    </div>
                    
                                    <div class="row">
                                        <asp:Label ID="Label1" runat="server"
                                            Text="Job Title"
                                            CssClass="label"
                                            AssociatedControlID="rtbJobtitle" />
                            
                                        <telerik:RadTextBox ID="rtbJobtitle" runat="server"
                                            Text='<%#Bind("jobtitle") %>' EmptyMessage="Job Title" />
                                    </div>

                                    <div class="row">
                                        <asp:Label ID="lblAddress" runat="server"
                                            Text="Address"
                                            CssClass="label"
                                            AssociatedControlID="rtbAddress" />
           
                                        <telerik:RadTextBox ID="rtbAddress" runat="server"
                                            Width="300px" Rows="4" Columns="80"
                                            Text='<%#Bind("address")%>' TextMode="MultiLine" EmptyMessage="Address" />
                                    </div>

                                    <div class="row">
                                        <asp:Label ID="lblPostcode" runat="server"
                                            Text="Postcode"
                                            CssClass="label"
                                            AssociatedControlID="rtbPostcode" />
                        
                                        <telerik:RadTextBox ID="rtbPostcode" runat="server"
                                            Text='<%#Bind("postcode") %>'
                                            MaxLength="8"
                                            EmptyMessage="Postcode" />
                                    </div>
                    
                                    <div class="row">
                                        <asp:Label ID="lblTel" runat="server"
                                            Text="Telephone"
                                            CssClass="label"
                                            AssociatedControlID="lblTel" />
                        
                                        <telerik:RadTextBox ID="rtbTel" runat="server"
                                            Text='<%#Bind("tel") %>'
                                            EmptyMessage="Telephone" />
                                    </div>
                                    <div class="row">
                                        <asp:Label ID="lblFax" runat="server"
                                            Text="Fax"
                                            CssClass="label"
                                            AssociatedControlID="rtbFax" />
                        
                                        <telerik:RadTextBox ID="rtbFax" runat="server"
                                            Text='<%#Bind("fax") %>'
                                            EmptyMessage="Fax" />
                                    </div>
                    
                                    <div class="row">
                                        <asp:Label ID="lblMobile" runat="server"
                                            Text="Mobile"
                                            CssClass="label"
                                            AssociatedControlID="lblMobile" />
                        
                                        <telerik:RadTextBox ID="rtbMobile" runat="server"
                                            Text='<%#Bind("mobile") %>'
                                            EmptyMessage="Mobile" />
                                    </div>
                                    <div class="row">
                                        <asp:Label ID="lblBusiness" runat="server"
                                            Text="Company Tel."
                                            CssClass="label"
                                            AssociatedControlID="rtbBusiness" />
                        
                                        <telerik:RadTextBox ID="rtbBusiness" runat="server"
                                            Text='<%#Bind("business") %>'
                                            EmptyMessage="Company Telephone" />
                                    </div>
                                    <div class="row">
                                        <asp:Label ID="lblExtension" runat="server"
                                            Text="Extension"
                                            CssClass="label"
                                            AssociatedControlID="rtbExtension" />
                        
                                        <telerik:RadTextBox ID="rtbExtension" runat="server"
                                            Text='<%#Bind("extension") %>'
                                            EmptyMessage="Extension" />
                                    </div>                    
                    
                                <div class="form-actions">
                                    <asp:Button ID="btnUpdate" runat="server"
                                        Text="Save Changes"
                                        CssClass="button button-create"
                                        CommandName="Update"
                                        CausesValidation="true" />
                                </div>
                                </asp:Panel>
                            </EditItemTemplate>
                        </asp:FormView>
            </div>

            <div class="tab-container" id="company">
                <h3>Company Details</h3>
    
                <asp:FormView ID="fvCompanyDetails" runat="server"
                    DefaultMode="Edit"
                    Width="100%"
                    DataSourceID="userProfileCompanyDataSource">
                    <EditItemTemplate>
                        <div class="row">
                            <asp:Label ID="lblCompany" runat="server"
                                Text="Company Name"
                                CssClass="label"
                                AssociatedControlID="rtbCompany" />

                            <telerik:RadTextBox ID="rtbCompany" runat="server"
                                Text='<%#Bind("company") %>'
                                EmptyMessage="Company Name" />
                        </div>
                
                        <div class="row">
                            <asp:Label ID="lblLabelVATNumber" runat="server"
                                Text="VAT Number" CssClass="label" AssociatedControlID="rtbVATNumber" />
                        
                            <telerik:RadTextBox
                                ID="rtbVATNumber"
                                runat="server"
                                Text='<%#Bind("vatNumber") %>'
                                EmptyMessage="VAT Number" />
                        </div>
                
                        <div class="row">
                            <asp:Label ID="lblVAT" runat="server"
                                Text="VAT Rate"
                                CssClass="label"
                                AssociatedControlID="rntbVAT" />
                        
                            <telerik:RadNumericTextBox ID="rntbVAT" runat="server"
                                Value='<%#Bind("vat") %>' Width="55px"
                                NumberFormat-DecimalDigits="2"
                                Type="Percent" />
                        </div>
                
                        <div class="row">
                            <asp:Label ID="Label2" runat="server"
                                Text="Overhead"
                                CssClass="label"
                                AssociatedControlID="rntbOverhead" />
                        
                            <telerik:RadNumericTextBox ID="rntbOverhead" runat="server"
                                Value='<%#Bind("defaultOverhead")%>' Width="55px"
                                NumberFormat-DecimalDigits="2"
                                Type="Percent" />
                        </div>
                
                        <div class="row">
                            <asp:Label ID="Label3" runat="server"
                                Text="Profit"
                                CssClass="label"
                                AssociatedControlID="rntbProfit" />
                        
                            <telerik:RadNumericTextBox ID="rntbProfit" runat="server"
                                Value='<%#Bind("defaultProfit")%>' Width="55px"
                                NumberFormat-DecimalDigits="2"
                                Type="Percent" />
                        </div>
                    
                        <div class="form-actions">
                            <asp:Button ID="btnUpdate" runat="server"
                                Text="Save Changes"
                                CommandName="Update"
                                CssClass="button button-create"
                                CausesValidation="true" />
                        </div>
                    </EditItemTemplate>
                </asp:FormView>

            </div>
            
            <div class="tab-container" id="logo">
                <h3>Company Logo</h3>
        
                <asp:FormView ID="fvCompanyLogo" runat="server"
                    DataSourceID="updateImageDataSource">
                    <ItemTemplate>
                        <div class="row">
                            <label class="label">Current Logo</label>
                            
                            <asp:HyperLink ID="HyperLink1" runat="server"
                                Target="_blank"
                                NavigateUrl='<%# "~/images/logos/" & Eval("logo") %>'>
                                <asp:Image ID="Image1" runat="server"
                                    ImageUrl='<%# "~/showimage.aspx?w=285&img=" & Eval("logo") %>'
                                    ToolTip="Click to view the full-size Logo" />
                            </asp:HyperLink>
                        </div>
                        
                        <asp:HiddenField ID="origImage" runat="server" Value='<%#eval("logo") %>' />
                    </ItemTemplate>
                </asp:FormView>
                
                <div class="row">
                    <label class="label">Upload new logo</label>
                    
                        <telerik:RadUpload ID="RadUpload1" runat="server"
                            MaxFileInputsCount="1"
                            Localization-Select="browse..."
                            ControlObjectsVisibility="None"
                            AllowedFileExtensions=".jpg, .jpeg, .gif"
                            MaxFileSize="1000000"
                            TargetFolder="~/images/logos" />
                </div>
                                     
                <div class="form-actions">
                    <asp:Button ID="btnUpload" runat="server" Text="Upload logo" CssClass="button button-create" />
                </div>
            </div>
            
            <div class="tab-container" id="password">
                <h3>Change Password</h3>

                <asp:ChangePassword ID="ChangePassword1" runat="server">
                    <ChangePasswordTemplate>
                        <asp:ValidationSummary ID="ValidationSummary2" runat="server"
                            ValidationGroup="ChangePassword1" HeaderText="The following fields are required:" />
                        
                        <div class="row">
                            <asp:Label ID="lblCurrentPassword" CssClass="label" runat="server" AssociatedControlID="CurrentPassword">Password</asp:Label>
                            <telerik:RadTextBox ID="CurrentPassword" runat="server" TextMode="Password" />
                            
                            <asp:RequiredFieldValidator ID="CurrentPasswordRequired" runat="server" ControlToValidate="CurrentPassword"
                                Display="None" ErrorMessage="Password" ValidationGroup="ChangePassword1" />
                        </div>
                        
                        <div class="row">
                            <asp:Label ID="lblNewPassword" CssClass="label" runat="server" AssociatedControlID="NewPassword">New Password</asp:Label>
                            <telerik:RadTextBox ID="NewPassword" runat="server" TextMode="Password" />
                            
                            <asp:RequiredFieldValidator ID="NewPasswordRequired" runat="server" ControlToValidate="NewPassword"
                                Display="None" ErrorMessage="New Password" ValidationGroup="ChangePassword1" />
                        </div>
                        
                        <div class="row">
                            <asp:Label ID="lblConfirmNewPassword" CssClass="label" runat="server" AssociatedControlID="ConfirmNewPassword">Confirmation</asp:Label>
                            <telerik:RadTextBox ID="ConfirmNewPassword" runat="server" TextMode="Password" />
                            
                            <asp:RequiredFieldValidator ID="ConfirmNewPasswordRequired" runat="server" ControlToValidate="ConfirmNewPassword"
                                Display="None" ErrorMessage="Confirmation Password" ValidationGroup="ChangePassword1" />
                            </asp:RequiredFieldValidator>
                            
                            <asp:CompareValidator ID="NewPasswordCompare" runat="server" ControlToCompare="NewPassword"
                                ControlToValidate="ConfirmNewPassword" Display="None" ErrorMessage="New Passwords (do not match)"
                                Font-Bold="False" ValidationGroup="ChangePassword1" />
                        </div>
                        
                        <div class="row">
                            <asp:Literal ID="FailureText" runat="server" EnableViewState="False" />
                        </div>
                        
                        <div class="form-actions">
                            <asp:Button ID="ChangePasswordPushButton" runat="server"
                                CommandName="ChangePassword" ValidationGroup="ChangePassword1"
                                CssClass="button button-create"
                                OnClick="Validate_Change" Text="Change Password" />
                        </div>
                    </ChangePasswordTemplate>
                    <SuccessTemplate>
                        <div class="row">Your password has been changed!</div>
                    </SuccessTemplate>
                    <MailDefinition
                        BodyFileName="~/email_templates/PasswordChanged.txt"
                        From="support@buildmateapp.com"
                        IsBodyHtml="true"
                        Subject="[Buildmate] Your password has been changed"
                    />
                </asp:ChangePassword>
            </div>
            
            <div class="tab-container" id="notifications">
                <h3>Notification Settings</h3>
            
                <asp:FormView DefaultMode="Edit"
                    ID="fvNotifications"
                    runat="server"
                    DataSourceID="dsNotifications">
                    <EditItemTemplate>
                        <div class="row">
                            <label for="ctl00_MainContent_fvNotifications_CheckBox1">
                                <asp:CheckBox
                                    ID="CheckBox1"
                                    runat="server"
                                    checked='<%#Bind("notifyByEmail") %>' />
                            Receive email Notifications</label>
                        </div>
                    
                        <div class="form-actions">
                            <asp:Button
                                ID="btnEdit"
                                runat="server"
                                Text="Update"
                                CssClass="button button-create"
                                CommandName="Update" />
                        </div>
                    </EditItemTemplate>
                </asp:FormView>
            </div>
            
            <div class="tab-container" id="subscription">
                <h3>Your Subscription</h3>

                <div class="row">
                    <label class="label">Expires on</label>
                    <asp:Literal ID="lSubscriptionDate" runat="server"></asp:Literal>
                </div>
            </div>       
        </div>

    <asp:SqlDataSource ID="dsNotifications" runat="server" 
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="getUserProfileNotifications"
        SelectCommandType="StoredProcedure"
        UpdateCommand="updateUserProfileNotifications"
        UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter SessionField="UserId" Name="UserId" />
        </SelectParameters>
        <UpdateParameters>
            <asp:SessionParameter SessionField="UserId" Name="UserId" />
        </UpdateParameters>
    </asp:SqlDataSource>   

    <asp:SqlDataSource ID="userProfileDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="getUserProfile" SelectCommandType="StoredProcedure"
        UpdateCommand="updateUserProfile" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="userId" SessionField="userId" />
        </SelectParameters>
        <UpdateParameters>
            <asp:SessionParameter Name="userId" SessionField="userId" />
        </UpdateParameters>
    </asp:SqlDataSource>
    
    <asp:SqlDataSource ID="userProfileCompanyDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="getUserProfileCompany" SelectCommandType="StoredProcedure"
        UpdateCommand="updateUserProfileCompany" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="userId" SessionField="userId" />
        </SelectParameters>
        <UpdateParameters>
            <asp:SessionParameter Name="userId" SessionField="userId" />
        </UpdateParameters>
    </asp:SqlDataSource>
    
    <asp:SqlDataSource
        ID="businessTypeDataSource"
        runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="getUserBusinessTypes"
        SelectCommandType="StoredProcedure" />
        
    <asp:SqlDataSource
        ID="updateImageDataSource"
        runat="server" 
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="getUserProfileLogo"
        SelectCommandType="StoredProcedure"
        UpdateCommand="updateUserProfileLogo"
        UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="userId" SessionField="userId" />
        </SelectParameters>
        <UpdateParameters>
            <asp:SessionParameter Name="userId" SessionField="userId" />
            <asp:Parameter Name="image" DefaultValue="" />
        </UpdateParameters>
    </asp:SqlDataSource>
        
    <asp:SqlDataSource ID="subscriptionTypeDataSource"
        runat="server" 
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>" 
        SelectCommand="getUserSubscriptionTypes"
        SelectCommandType="StoredProcedure">
    </asp:SqlDataSource>
</asp:Content>


<asp:Content ID="SidebarContent" ContentPlaceHolderID="Sidebar" Runat="Server">
    <div class="tour-block">
        <div class="tour-inner">
            <a href="#" class="close" data-tour="close">&times;</a>
            
            <h1>Settings <span>Take a Tour</span></h1>

            <div class="tour-nav" data-tour="menu">
                <ul>
                    <li class="active"><a href="#" data-tab="step1">1. Settings</a>
                </ul>
            </div>
            <div class="tour-content">
                <div data-target="step1">
                    <iframe width="640" height="480" src="//www.youtube.com/embed/_5G47Bx2sPQ" frameborder="0" allowfullscreen></iframe>

                    <div class="tour-control">
                        Step 1
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>