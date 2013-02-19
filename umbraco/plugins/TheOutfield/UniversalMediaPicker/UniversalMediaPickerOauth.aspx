<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UniversalMediaPickerOauth.aspx.cs" Inherits="TheOutfield.UmbExt.UniversalMediaPicker.Dialogs.UniversalMediaPickerOauth"  MasterPageFile="../../../masterpages/umbracoDialog.Master" %>

<%@ Register TagPrefix="ui" Namespace="umbraco.uicontrols" Assembly="controls" %>
<%@ Register TagPrefix="umb" Namespace="ClientDependency.Core.Controls" Assembly="ClientDependency.Core" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<script type="text/javascript">
    function sendAndClose(selObj, restore) {
        self.opener.document.getElementById('<%= ClientIdCallBack %>').value = '<%= AccessToken %>';
        window.close();
    } 
</script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
<div style="padding:10px 10px 0;">
<img src="/umbraco/plugins/theoutfield/universalmediapicker/ump.png" />
<h1 style="margin-top:25px;">You have approved the application for use with Umbraco and your access token should be shown here:</h1><br/> 
<center><h2 style="margin-top:10px;"><%= AccessToken %></h2></center>
<center><h3 style="margin-top:20px;"><a href="#" onclick="sendAndClose(this,0)">Click to save</a></h3></center>
</div>

</asp:Content>