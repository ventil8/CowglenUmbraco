<%@ Control Language="C#" AutoEventWireup="true" Inherits="InfoCaster.Umbraco.DataTypes.TrueColorPicker" %>

<link rel="Stylesheet" type="text/css" href="/umbraco/css/colorpicker.css" />

<script type="text/javascript" src="/umbraco/js/colorpicker.js"></script>

<asp:UpdatePanel runat="server" ID="upColorPicker" ChildrenAsTriggers="false" UpdateMode="Conditional">
	<Triggers>
		<asp:AsyncPostBackTrigger ControlID="btnReset" />
	</Triggers>
	<ContentTemplate>
		<asp:Panel runat="server" ID="pblColorPicker" CssClass="color-selector"><asp:panel runat="server" ID="pnlColor" style="background-color: #ffffff" /></asp:Panel>
		<asp:Button runat="server" ID="btnReset" OnClick="btnReset_Click" Text="Reset color" CssClass="color-reset-button" />
		<asp:HiddenField runat="server" ID="hfColor" />
	</ContentTemplate>
</asp:UpdatePanel>

<script type="text/javascript">
	var textboxId<%= this.UniqueID %> = "<%= hfColor.ClientID %>";
	var panelId<%= this.UniqueID %> = "<%= pblColorPicker.ClientID %>";
	$(document).ready(function() {
		$("#" + panelId<%= this.UniqueID %>).ColorPicker({
			color: $("#" + textboxId<%= this.UniqueID %>).val() != "" ? $('#' + textboxId<%= this.UniqueID %>).val() : "ffffff",
			onShow: function(colpkr) {
				$(colpkr).fadeIn(500);
				return false;
			},
			onHide: function(colpkr) {
				$(colpkr).fadeOut(500);
				return false;
			},
			onChange: function(hsb, hex, rgb) {
				$("#" + panelId<%= this.UniqueID %> + " div").css("background-color", "#" + hex);
				$("#" + textboxId<%= this.UniqueID %>).val(hex);
			}
		});
	});
</script>