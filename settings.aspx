    <%@ Page Title="Settings - BuildMate" Language="VB" MasterPageFile="~/common/Manager.master" AutoEventWireup="false" CodeFile="settings.aspx.vb" Inherits="settings" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">

    <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlId="fvCompanyLogo">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="fvCompanyLogo" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlId="fvNotifications">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="fvNotifications" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlId="fvCompanyDetails">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="fvCompanyDetails" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlId="fvContactDetails">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="fvContactDetails" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlId="fvAddressDetails">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="fvAddressDetails" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>

<div class="div50">
    <div class="box">
        <h3>Contact Details</h3>

    <div class="boxcontent">
        <asp:FormView ID="fvContactDetails" runat="server"
            Width="100%"
            DataSourceID="userProfileDataSource">
            <EditItemTemplate>
                <asp:Panel ID="Panel1" runat="server" DefaultButton="btnUpdate">
                    <div class="row">
                        <asp:Label ID="lblLabelTitle" runat="server"
                            Text="Title"
                            CssClass="label"
                            AssociatedControlID="rcbTitle" />
                            
                        <telerik:RadComboBox ID="rcbTitle" runat="server"
                            Width="70px"
                            SelectedValue='<%# Bind("titleId") %>'
                            DataSourceID="titleDataSource"
                            DataTextField="title"
                            DataValueField="id" />
                    </div>
                    
                    <div class="row">
                        <asp:Label ID="lblName" runat="server"
                            Text="First Name"
                            CssClass="label"
                            AssociatedControlID="rtbFirstname" />

                        <telerik:RadTextBox ID="rtbFirstname" runat="server"
                            Text='<%#Bind("firstname") %>'
                            EmptyMessage="First Name" />
                    </div>
                    
                    <div class="row">
                        <asp:Label ID="lblSurname" runat="server"
                            Text="Surname"
                            CssClass="label"
                            AssociatedControlID="rtbSurname" />
                        
                        <telerik:RadTextBox ID="rtbSurname" runat="server"
                            Text='<%#Bind("surname") %>'
                            EmptyMessage="Surname" />
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
                    
                <div class="row">
                    <label class="label">&nbsp;</label>
                    
                    <asp:Button ID="btnUpdate" runat="server"
                        Text="Save Changes"
                        CommandName="Update"
                        CausesValidation="true" />
                    
                    <asp:LinkButton ID="btnCancel" runat="server"
                        Text="Cancel"
                        CommandName="Cancel"
                        CausesValidation="false" />
                </div>
                </asp:Panel>
            </EditItemTemplate>
            <ItemTemplate>
            
                <div class="row">
                    <asp:Label ID="lblLabelTitle" runat="server" Text="Title" CssClass="label" AssociatedControlID="lblTitle" />
                    <asp:Label ID="lblTitle" runat="server" Text='<%# Bind("title") %>' />&nbsp;
                </div>

                <div class="row">
                    <asp:Label ID="lblLabelName" runat="server" Text="First Name" CssClass="label" AssociatedControlID="lblName" />
                    <asp:Label ID="lblName" runat="server" Text='<%# Bind("firstname") %>' />&nbsp;
                </div>
                
                <div class="row">
                    <asp:Label ID="lblLabelSurname" runat="server" Text="Surname" CssClass="label" AssociatedControlID="lblSurname" />
                    <asp:Label ID="lblSurname" runat="server" Text='<%# Bind("surname") %>' />&nbsp;
                </div>
                
                <div class="row">
                        <label title="Job Title" class="label">Job Title</label>
                    <asp:Literal ID="Literal2" runat="server" Text='<%# Bind("jobtitle") %>' />&nbsp;
                </div>
                
                <div class="row">
                    <asp:Label ID="lblLabelTel" runat="server" Text="Telephone" CssClass="label" AssociatedControlID="lblTel" />
                    <asp:Label ID="lblTel" runat="server" Text='<%# Bind("tel") %>' />&nbsp;
                </div>
                <div class="row">
                    <asp:Label ID="lblLabelFax" runat="server" Text="Fax" CssClass="label" AssociatedControlID="lblFax" />
                    <asp:Label ID="lblFax" runat="server" Text='<%# Bind("fax") %>' />&nbsp;
                </div>
                <div class="row">
                    <asp:Label ID="lblLabelMobile" runat="server" Text="Mobile" CssClass="label" AssociatedControlID="lblMobile" />
                    <asp:Label ID="lblMobile" runat="server" Text='<%# Bind("mobile") %>' />&nbsp;
                </div>
                
                <div class="row">
                    <asp:Label ID="lblLabelBusiness" runat="server"
                        Text="Company Tel"
                        CssClass="label"
                        AssociatedControlID="lblBusiness" />
                    
                    <asp:Label ID="lblBusiness" runat="server"
                        Text='<%# Bind("business") %>' />&nbsp;
                </div>
                
                <div class="row">
                    <asp:Label ID="lblLabelExtension" runat="server"
                        Text="Extension"
                        CssClass="label"
                        AssociatedControlID="lblExtension" />
                    
                    <asp:Label ID="lblExtension" runat="server"
                        Text='<%# Bind("extension") %>' />&nbsp;
                </div>

                <div class="row">
                    <label class="label">
                        &nbsp;</label>
                    <asp:Button ID="btnEdit" runat="server" Text="Edit Account" CommandName="Edit" />
                </div>
            </ItemTemplate>
        </asp:FormView>
            </div>
        </div>
    
        <div class="box">
        <h3>Address Details</h3>

    <div class="boxcontent">
        <asp:FormView ID="fvAddressDetails" runat="server"
            Width="100%"
            DataSourceID="userProfileAddressDataSource">
            <EditItemTemplate>
                <asp:Panel ID="Panel1" runat="server" DefaultButton="btnUpdate">
                    <div class="row">
                        <asp:Label ID="lblAddress1" runat="server"
                            Text="Address"
                            CssClass="label"
                            AssociatedControlID="rtbAddress1" />
                        
                        <telerik:RadTextBox ID="rtbAddress1" runat="server"
                            Text='<%#Bind("address1") %>'
                            EmptyMessage="Address" />
                    </div>

                    <div class="row">
                        <label class="label">&nbsp;</label>
                        
                        <telerik:RadTextBox ID="rtbAddress2" runat="server"
                            Text='<%#Bind("address2") %>'
                            EmptyMessage="Address 2" />
                    </div>
                    
                    <div class="row">
                        <label class="label">&nbsp;</label>
                        
                        <telerik:RadTextBox ID="rtbAddress3" runat="server"
                            Text='<%#Bind("address3") %>'
                            EmptyMessage="Address 3" />
                    </div>
                    
                    <div class="row">
                        <asp:Label ID="lblCity" runat="server"
                            Text="Town/City"
                            CssClass="label"
                            AssociatedControlID="rtbCity" />
                        
                        <telerik:RadTextBox ID="rtbCity" runat="server"
                            Text='<%#Bind("city") %>'
                            EmptyMessage="Town/City" />
                    </div>
                    
                    <div class="row">
                        <asp:Label ID="lblCounty" runat="server"
                            Text="County"
                            CssClass="label"
                            AssociatedControlID="rtbCounty" />
                        
                        <telerik:RadTextBox ID="rtbCounty" runat="server"
                            Text='<%#Bind("county") %>'
                            EmptyMessage="County" />
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
                        <asp:Label ID="lblCountry" runat="server"
                            Text="Country"
                            CssClass="label"
                            AssociatedControlID="rcbCountry" />
                        
                        <telerik:RadComboBox ID="rcbCountry" runat="server"
                            Height="140px"
                            SelectedValue='<%# Bind("countryId") %>'
                            DataSourceID="countryDataSource"
                            DataTextField="countryName"
                            DataValueField="id" />
                    </div>

                <div class="row">
                    <label class="label">&nbsp;</label>
                    
                    <asp:Button ID="btnUpdate" runat="server"
                        Text="Save Changes"
                        CommandName="Update"
                        CausesValidation="true" />
                    
                    <asp:LinkButton ID="btnCancel" runat="server"
                        Text="Cancel"
                        CommandName="Cancel"
                        CausesValidation="false" />
                </div>
                </asp:Panel>
            </EditItemTemplate>
            <ItemTemplate>
                <div class="row">
                    <asp:Label ID="lblLabelAddress" runat="server" Text="Address" CssClass="label" AssociatedControlID="lblAddress" />
                    <asp:Label ID="lblAddress" runat="server" Text='<%# Bind("address1") %>' />&nbsp;
                </div>

                <div class="row" runat="server" id="add2">
                    <asp:Label ID="lblLabelAddress2" runat="server" Text="&nbsp;" CssClass="label" AssociatedControlID="lblAddress2" />
                    <asp:Label ID="lblAddress2" runat="server" Text='<%# Bind("address2") %>' />&nbsp;
                </div>

                <div class="row" runat="server" id="add3">
                    <asp:Label ID="lblLabelAddress3" runat="server" Text="&nbsp;" CssClass="label" AssociatedControlID="lblAddress3" />
                    <asp:Label ID="lblAddress3" runat="server" Text='<%# Bind("address3") %>' />&nbsp;
                </div>

                <div class="row">
                    <asp:Label ID="lblLabelCity" runat="server" Text="Town/City" CssClass="label" AssociatedControlID="lblCity" />
                    <asp:Label ID="lblCity" runat="server" Text='<%# Bind("city") %>' />&nbsp;
                </div>

                <div class="row">
                    <asp:Label ID="lblLabelCounty" runat="server" Text="County" CssClass="label" AssociatedControlID="lblCounty" />
                    <asp:Label ID="lblCounty" runat="server" Text='<%# Bind("county") %>' />&nbsp;
                </div>

                <div class="row">
                    <asp:Label ID="lblLabelPostcode" runat="server" Text="Postcode" CssClass="label"
                        AssociatedControlID="lblPostcode" />
                    <asp:Label ID="lblPostcode" runat="server" Text='<%# Bind("postcode") %>' />&nbsp;
                </div>

                <div class="row">
                    <asp:Label ID="lblLabelCountry" runat="server" Text="Country" CssClass="label" AssociatedControlID="lblCountry" />
                    <asp:Label ID="lblCountry" runat="server" Text='<%# Bind("countryName") %>' />&nbsp;
                </div>

                <div class="row">
                    <label class="label">
                        &nbsp;</label>
                    <asp:Button ID="btnEdit" runat="server" Text="Edit Address" CommandName="Edit" />
                </div>
            </ItemTemplate>
        </asp:FormView>
            </div>
        </div>
    </div>

    
    <div class="div50r">
        
    
    
    <div class="box">
        <h3>Company Details</h3>
    
        <div class="boxcontent">
        <asp:FormView ID="fvCompanyDetails" runat="server" 
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
                    <label class="label">&nbsp;</label>
                    
                    <asp:Button ID="btnUpdate" runat="server"
                        Text="Save Changes"
                        CommandName="Update"
                        CausesValidation="true" />
                    
                    <asp:LinkButton ID="btnCancel" runat="server"
                        Text="Cancel"
                        CommandName="Cancel"
                        CausesValidation="false" />
                </div>
            </EditItemTemplate>
            <ItemTemplate>
                    <div class="row">
                        <asp:Label ID="lblLabelCompany" runat="server" Text="Company Name" CssClass="label"
                            AssociatedControlID="lblCompany" />
                        <asp:Label ID="lblCompany" runat="server" Text='<%# Bind("company") %>' />&nbsp;
                    </div>

                    <div class="row">
                        <asp:Label ID="lblLabelVATNumber" runat="server"
                            Text="VAT Number" CssClass="label" AssociatedControlID="lblVATNumber" />
                                
                        <asp:Label ID="lblVATNumber" runat="server" Text='<%# Bind("vatnumber") %>' />&nbsp;
                    </div>
                    
                    <div class="row">
                        <asp:Label ID="lblLabelVAT" runat="server"
                            Text="VAT Rate" CssClass="label" AssociatedControlID="lblVAT" />
                                
                        <asp:Label ID="lblVAT" runat="server" Text='<%# Bind("vat") %>' />%&nbsp;
                    </div>
                    
                <div class="row">
                    <label class="label">
                        &nbsp;</label>
                    <asp:Button ID="btnEdit" runat="server" Text="Edit Company Details" CommandName="Edit" />
                </div>
            </ItemTemplate>
        </asp:FormView>

    
        </div>
    </div>

    <div class="box">
        <h3>Company Logo</h3>
        <div class="boxcontent">
        
                <asp:FormView ID="fvCompanyLogo" runat="server"
                    Width="100%"
                    DataSourceID="updateImageDataSource">
                    <ItemTemplate>
                    <div class="row">
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
                
                <p>Upload new logo</p>
                    
                <div class="row">
                    <telerik:RadUpload ID="RadUpload1" runat="server"
                        MaxFileInputsCount="1"
                        Width="200px"
                        Localization-Select="browse..."
                        ControlObjectsVisibility="None"
                        AllowedFileExtensions=".jpg, .jpeg, .gif"
                        MaxFileSize="1000000"
                        TargetFolder="~/images/logos" />
                </div>
                
                <div class="row" runat="server" id="uploadResponse" visible="false">
                    <asp:Literal ID="Literal1" runat="server"></asp:Literal>
                </div>
                            
                <div class="row">
                    <asp:Button ID="btnUpload" runat="server" Text="Upload logo" />
                </div>
            </div>
        </div>

        <div class="box">
            <h3>Change Password</h3>

            <div class="boxcontent">
                <asp:ChangePassword ID="ChangePassword1" runat="server"
                    Width="100%">
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
                        
                        <div class="row">
                            <asp:Label class="label" ID="lblChangePasswordPushButton" runat="server"
                                AssociatedControlID="ChangePasswordPushButton">&nbsp;</asp:Label>
                            
                            <asp:Button ID="ChangePasswordPushButton" runat="server"
                                CommandName="ChangePassword" ValidationGroup="ChangePassword1"
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
                        Subject="[BuildMate] Your password has been changed"
                    />
                </asp:ChangePassword>
            </div>
        </div>

    <div class="clear"></div>

    <div class="box">
        <h3>Notifications</h3>
            
        <div class="boxcontent">
            <asp:FormView DefaultMode="Edit"
                ID="fvNotifications"
                runat="server"
                DataSourceID="dsNotifications">
                <EditItemTemplate>
                    <div class="row">
                        <label class="label">
                            <asp:CheckBox
                                ID="CheckBox1"
                                runat="server"
                                AutoPostBack="true"
                                checked='<%#Bind("notifyByEmail") %>' />
                        Receive email Notifications</label>
                    </div>
                    
                    <div class="row">
                        <asp:Button
                            ID="btnEdit"
                            runat="server"
                            Text="Update"
                            CommandName="Update" />
                    </div>
                </EditItemTemplate>
            </asp:FormView>
        </div>         
    </div>
    </div>

    <div class="clear"></div>

    

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
    
    
    <asp:SqlDataSource ID="userProfileAddressDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="getUserProfileAddress" SelectCommandType="StoredProcedure"
        UpdateCommand="updateUserProfileAddress" UpdateCommandType="StoredProcedure">
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
        ID="titleDataSource"
        runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="getUserTitle"
        SelectCommandType="StoredProcedure" />

    <asp:SqlDataSource
        ID="countryDataSource"
        runat="server"
        ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>"
        SelectCommand="getCountries"
        SelectCommandType="StoredProcedure" />

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

