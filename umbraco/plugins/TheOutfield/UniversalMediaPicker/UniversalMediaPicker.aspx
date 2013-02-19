<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UniversalMediaPicker.aspx.cs" Inherits="TheOutfield.UmbExt.UniversalMediaPicker.Dialogs.UniversalMediaPicker" MasterPageFile="../../../masterpages/umbracoDialog.Master" %>

<%@ Register TagPrefix="ui" Namespace="umbraco.uicontrols" Assembly="controls" %>
<%@ Register TagPrefix="umb" Namespace="ClientDependency.Core.Controls" Assembly="ClientDependency.Core" %>
<%@ Register TagPrefix="umb2" TagName="Tree" Src="../../../controls/Tree/TreeControl.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script type="text/javascript">

        var metaRow = "<div class='propertyItem'><div class='propertyItemheader'>{0}</div><div class='propertyItemContent'>{1}</div></div>";

        //need to wire up the submit button click
        jQuery(document).ready(function () {
            jQuery("#submitbutton").click(function (e) {
                e.preventDefault();
                updatePicker();
                return false;
            });
        });

        // called when the user interacts with a node
        function dialogHandler(obj) {
            if (obj) {
                var jsonObj = JSON.stringify(obj);

                // update the hidden field with the selected id
                jQuery("#selectedMediaId").val(jsonObj);

                // Enabled submit button
                jQuery("#submitbutton").removeAttr("disabled").css("color", "#000");

                // Display preview image
                if (obj.PreviewImageUrl != "") {
                    $(".previewImage .img span").empty().append("<img src='" + obj.PreviewImageUrl + "' />");
                }

                // Display meta data
                clearMetaData();

                appendMetaDataRow("Name", obj.Title);

                if (obj.MetaData) {
                    for (var key in obj.MetaData) {
                        appendMetaDataRow(key, obj.MetaData[key]);
                    }
                }
            }
            else 
            {
                clearMetaData();

                jQuery("#submitbutton").attr("disabled", "disabled").css("color", "gray");
            }
        }

        function uploadHandler(obj) {
            dialogHandler(obj);

            //get the tree object for the chooser and refresh
            var tree = jQuery("#<%= DialogTree.ClientID %>").UmbracoTreeAPI();
            tree.refreshTree();
        }

        function updatePicker() {
            var val = jQuery("#selectedMediaId").val();
            if (val != "") {
                UmbClientMgr.closeModalWindow(val);
            }
        }

        function cancel() {
            //update the hidden field with the selected id = none
            jQuery("#selectedMediaId").val("");
            UmbClientMgr.closeModalWindow();
        }

        function clearMetaData() {
            jQuery(".metaData").empty().scrollTop(0);
        }

        function appendMetaDataRow(key, value) {
            jQuery(".metaData").append(metaRow.replace("{0}", key).replace("{1}", value));
        }

    </script>

    <style type="text/css">
		.info { width: 498px; }
		.metaData { float: left; overflow: auto; height: 105px; width: 385px; }
		.metaData .propertyItemheader { width: 120px !important; }
		.metaData .propertyItemContent { margin-left: 120px !important; float: none !important; }
        .previewImage { float: right; background: #fff; border: 1px solid #ccc; }
        .previewImage td { width: 105px; height: 105px; }
        .previewImage td span { display: inline-block; width: 105px; overflow: hidden; }
        .previewImage td img { max-height: 101px; max-width: 101px; }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">

    <%--when a node is selected, the id will be stored in this field--%>
    <input type="hidden" id="selectedMediaId" />
    <ui:Pane ID="pane_src" runat="server">
        <div class="info">
            <div class="metaData">&nbsp;</div>
            <table class="previewImage" cellpadding="0" cellspacing="0">
                <tr>
                    <td class="img" align="center" valign="middle"><span>&nbsp;</span></td>
                </tr>
            </table>
        </div>
    </ui:Pane>
    <br />
    <ui:TabView AutoResize="false" Width="510px" Height="310px" runat="server" ID="tv_options" />
    <ui:Pane ID="pane_select" runat="server">
        <!-- Tree control added dynamically -->
        <umb2:Tree runat="server" ID="DialogTree" App="media" TreeType="UniversalMediaPicker" IsDialog="true"
            ShowContextMenu="false" DialogMode="id" FunctionToCall="dialogHandler" NodeKey='<%# DataTypeDefinitionID + "$-1" %>'
            Height="255"/>
    </ui:Pane>
    <ui:Pane ID="pane_upload" runat="server" Visible="false">
        <!-- Tree control added dynamically -->
        <ui:feedback id="feedback" runat="server" />
        <asp:PlaceHolder ID="phCreateForm" runat="server"></asp:PlaceHolder>
        <ui:PropertyPanel ID="ppSubmit" runat="server" Text=" ">
            <asp:Button id="btnSubmit" runat="server" Text='<%#umbraco.ui.Text("save")%>' OnClick="btnSubmit_Click" onclientclick="jQuery(this).hide(); jQuery('#installingMessage').show(); return true;"></asp:Button>
            <div style="display: none;" id="installingMessage">
                <ui:ProgressBar runat="server" />
                <br />
                <em>&nbsp; &nbsp;Saving media, please wait...</em><br />
            </div>
        </ui:PropertyPanel>
    </ui:Pane>
    <br />
    <p>
        <input type="submit" value="<%# umbraco.ui.Text("treepicker")%>" style="width: 70px;
            color: gray" disabled="disabled" id="submitbutton" />
        <em id="orcopy">
            <%# umbraco.ui.Text("or") %></em> <a href="javascript:cancel();" style="color: blue"
                id="cancelbutton">
                <%#umbraco.ui.Text("cancel") %></a>
    </p>
</asp:Content>
