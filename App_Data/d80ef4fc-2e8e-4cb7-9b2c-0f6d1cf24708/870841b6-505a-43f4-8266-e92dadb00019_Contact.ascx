<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Contact.ascx.cs" Inherits="uBlogsy.Web.usercontrols.uBlogsy.Contact" %>
<script type="text/C#" runat="server">
    protected override void OnInit(EventArgs e)
    {
        base.OnInit(e);
        ((umbraco.UmbracoDefault)this.Page).ValidateRequest = false;
    }
</script>
<div class="uBlogsy_comment_form">
    <asp:MultiView ID="mv" runat="server" ActiveViewIndex="0">
        <asp:View ID="vwForm" runat="server">
            <div class="uBlogsy_row">
                <label for="txtName">
                    Name<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtName"
                        Display="Dynamic">*</asp:RequiredFieldValidator>
                </label>
                <asp:TextBox ID="txtName" runat="server"></asp:TextBox>
            </div>
            <div class="uBlogsy_row">
                <label for="txtEmail">
                    Email<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtEmail"
                        Display="Dynamic">*</asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtEmail"
                        Display="Dynamic" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">*</asp:RegularExpressionValidator>
                </label>
                <asp:TextBox ID="txtEmail" runat="server"></asp:TextBox>
            </div>
            <div class="uBlogsy_row">
                <label for="txtWebsite">
                    Website
                </label>
                <asp:TextBox ID="txtWebsite" runat="server">http://</asp:TextBox>
            </div>
            <div class="uBlogsy_row tall">
                <label for="txtMessage">
                    Message<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtEmail"
                        Display="Dynamic">*</asp:RequiredFieldValidator>
                </label>
                <asp:TextBox ID="txtMessage" runat="server" TextMode="MultiLine"></asp:TextBox>
            </div>
            <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" />
        </asp:View>
        <asp:View ID="vwSuccess" runat="server">
            Thank you for your comment.
        </asp:View>
        <asp:View ID="vwCommentsClosed" runat="server">
            <p>
                Comments have been closed for this post.</p>
        </asp:View>
    </asp:MultiView>
</div>
