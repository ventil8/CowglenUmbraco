<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Installer.ascx.cs" Inherits="DAMP.Samples.Installer" %>
<%@ Register TagPrefix="umb" Namespace="ClientDependency.Core.Controls" Assembly="ClientDependency.Core" %>
<%@ Register TagPrefix="UmbracoControls" Namespace="umbraco.uicontrols" Assembly="controls" %>
<%@ Register TagPrefix="UmbracoControls" Namespace="umbraco.controls" Assembly="umbraco" %>
<%@ Import Namespace="umbraco.IO" %>

<umb:JsInclude ID="JsIncludeDamp" runat="server" FilePath="plugins/DigibizAdvancedMediaPicker/DAMPScript.js" PathNameAlias="UmbracoRoot" />

<div style="padding: 10px 10px 0;">

	<p><img src="<%=IOHelper.ResolveUrl(SystemDirectories.Umbraco)%>/plugins/DigibizAdvancedMediaPicker/Logo.png" /></p>

    <UmbracoControls:Feedback runat="server" ID="Success" type="success" Text="DAMP 2.0 Samples successfully installed!" />

    <p>The following has been added.</p>
    <ul>
        <li>6 Data Types</li>
        <li>2 Macros</li>
        <li>2 Media Types</li>
        <li>1 Document Type</li>
        <li>1 Template</li>
        <li>10 Media items</li>
        <li>1 Node</li>
    </ul>

    <p>Click <a href="javascript:UmbClientMgr.mainWindow().delayedNavigate('/umbraco/editContent.aspx?id=<%=RedirectId%>', 'content')">here</a> to start playing.</p>
    

</div>