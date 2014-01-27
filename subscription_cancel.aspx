<%@ Page Title="Subscription Incomplete - Buildmate" Language="VB" MasterPageFile="~/common/Manager.master" AutoEventWireup="false" CodeFile="subscription_cancel.aspx.vb" Inherits="subscription_cancel" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">  
    <div class="breadcrumb">
        <div class="breadcrumb-container">
            Subscription Incomplete
        </div>
    </div>

    <div class="main-container">
        <div class="div50">
            <div class="box box-primary">
                <div class="boxcontent">
                    <a href="subscription.aspx" class="button button-large">Create a Subscription...</a>

                    <p>
                        If you wish to subscribe to Buildmate and benefit from some of the more advanced features available.
                    </p>
                </div>
            </div>
        </div>

        <div class="div50 last">
            <div class="box box-info">
                <div class="boxcontent">
                    <a href="/" class="button button-large">Continue with limited features...</a>

                    <p>
                        Even if you don't subscribe yet you'll still be able to use some of the great features Buildmate has to offer.
                    </p>
                </div>
            </div>
        </div>
        <div class="clear"></div>
    </div>
</asp:Content>