<%@ page title="" language="C#" masterpagefile="~/SaralTDS.master" autoeventwireup="true" inherits="Authentication_Users, App_Web_users.aspx.e7d8667b" %>

<%@ MasterType VirtualPath="~/SaralTDS.master" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script language="javascript" type="text/javascript" src="../JavaScript/Validations.js"></script>
    <script language="javascript" type="text/javascript">

        function GetResult(returnValue, context) {
            document.getElementById("<%=txtPassword.ClientID%>").value = returnValue;
            document.getElementById("<%=txtConfirmPassword.ClientID%>").value = returnValue;
            __doPostBack('Sender', 'Users')
        }
        function SendRequest(obj) {
            CallServer(obj);
        }
        function GetDetails(obj) {
            if (obj != null)
                SendRequest(obj.value);
        }
        function OnNewRecord() {
            document.getElementById("<%=hdnUserID.ClientID%>").value = "-1";
            if (document.getElementById("<%=txtUserName.ClientID%>").isDisabled)
                document.getElementById("<%=txtUserName.ClientID%>").disabled = false;
            document.getElementById("<%=txtUserName.ClientID%>").value = "";
            document.getElementById("<%=txtPassword.ClientID%>").value = "";
            document.getElementById("<%=txtConfirmPassword.ClientID %>").value = "";
            document.getElementById("<%=chkIsSuperAdmin.ClientID %>").checked = false;
            document.getElementById("<%=chkIsBranchAdmin.ClientID %>").checked = false;
            document.getElementById("<%=chkIsActive.ClientID %>").checked = true;
            if (document.getElementById("<%=chkChecker.ClientID%>") != null)
                document.getElementById("<%=chkChecker.ClientID%>").checked = false;
            if (document.getElementById("<%=chkAuditor.ClientID%>") != null)
                document.getElementById("<%=chkAuditor.ClientID%>").checked = false;
            document.getElementById("<%=txtUserBranch.ClientID %>").disabled = false;
            document.getElementById("<%=txtUserBranch.ClientID %>").value = "";
            document.getElementById("<%=hdnUserBranch.ClientID %>").value = "-1";
            document.getElementById("<%=txtUserName.ClientID%>").focus();
            document.getElementById("<%=hdnSearch.ClientID%>").value = "0";
            document.getElementById("<%=hdnIsSearchActive.ClientID%>").value = "0";
            document.getElementById("<%=txtSearchBranchName.ClientID%>").value = "";
            document.getElementById("<%=txtSearchUserName.ClientID%>").value = "";
            document.getElementById("<%=hdnPassword.ClientID%>").value = "";
            if (document.getElementById("<%=hdnIsSB.ClientID%>").value == "1") {
                document.getElementById("<%=txtPassword.ClientID%>").value = "Etds#9999";
                document.getElementById("<%=txtConfirmPassword.ClientID %>").value = "Etds#9999";
            }
            if (document.getElementById("<%=btnResetPassword.ClientID%>") != null) {
                document.getElementById("<%=btnResetPassword.ClientID%>").style.visibility = "hidden";
            }
            document.getElementById("<%=hdnDefaultPasswordSet.ClientID%>").value = "1";
        }
        function ValidateSuperAdmin() {
            if (document.getElementById("<%=hdnUserID.ClientID %>").value == "1") {
                alert("Current user can't update Super Admin details.");
                return false;
            }
            else { return true; }
        }
        function trim(text) { return text.replace(/^\s+|\s+$/g, ""); }
        function Validation() {
            if (!ValidateSuperAdmin()) return false;
            if (!ValidateLength(document.getElementById("<%=txtUserName.ClientID%>"), "Username", 75, true)) return false;
            if (document.getElementById("<%=hdnIsSB.ClientID%>").value == "1") {
                if (trim(document.getElementById("<%=txtUserName.ClientID%>").value).length != 6) {
                    alert("Username should be of 6 characters long.");
                    return false;
                }
            }
            if (document.getElementById("<%=hdnIsSIB.ClientID%>").value != "1") {
                if (document.getElementById("<%=hdnIsCBI.ClientID%>").value == "1") {
                    if (!ValidatePasswordCBI(document.getElementById("<%=txtPassword.ClientID%>"), "Password")) return false;
                }
                else {
                    if (!ValidatePassword(document.getElementById("<%=txtPassword.ClientID%>"), "Password")) return false;
                }
            }
            var UserBranch = document.getElementById("<%=hdnUserBranch.ClientID%>");
            if (UserBranch.value == "-1") {
                var txtUserBranch = document.getElementById("<%=txtUserBranch.ClientID%>");
                txtUserBranch.focus();
                txtUserBranch.select();
                if (txtUserBranch.value.length > 0)
                    alert("Specified Branch does not exist.");
                else
                    alert("Specify Branch.");
                return false;
            }
            else {
                if (document.getElementById("<%=txtPassword.ClientID%>").value == document.getElementById("<%=txtUserName.ClientID%>").value) {
                    alert("Password should not be User Name.");
                    document.getElementById("<%=txtPassword.ClientID%>").focus();
                    return false;
                }
                if ((document.getElementById("<%=txtPassword.ClientID%>").value.length < 8 || document.getElementById("<%=txtPassword.ClientID%>").value.length > 15) && document.getElementById("<%=hdnIsUB.ClientID%>").value == "1") {
                    alert("New Password should between 8 and 15 characters long."); document.getElementById("<%=txtPassword.ClientID%>").focus();
                    document.getElementById("<%=txtPassword.ClientID%>").select(); return false;
                }
                if ((document.getElementById("<%=txtPassword.ClientID%>").value.length < 8 || document.getElementById("<%=txtPassword.ClientID%>").value.length > 10) && document.getElementById("<%=hdnIsCBI.ClientID%>").value == "1") {
                    alert("New Password should between 8 and 10 characters long."); document.getElementById("<%=txtPassword.ClientID%>").focus();
                    document.getElementById("<%=txtPassword.ClientID%>").select(); return false;
                }
                if ((document.getElementById("<%=txtPassword.ClientID%>").value.length < 8 || document.getElementById("<%=txtPassword.ClientID%>").value.length > 15) && document.getElementById("<%=hdnIsSIB.ClientID%>").value == "1") {
                    alert("New Password should between 8 and 15 characters long."); document.getElementById("<%=txtPassword.ClientID%>").focus();
                    document.getElementById("<%=txtPassword.ClientID%>").select(); return false;
                }
                if ((document.getElementById("<%=hdnIsSB.ClientID%>").value == "1" || document.getElementById("<%=hdnIsUB.ClientID%>").value == "1") && document.getElementById("<%=hdnDefaultPasswordSet.ClientID%>").value != "1")
                    if (!PassWordValidation(document.getElementById("<%=txtPassword.ClientID%>"))) {
                        alert('Password should contain\n1) One Alphabet \n2) One Number \n3) One Special Character like ! @ # $ % & [] _ () \n4) One Uppercase Alphabet');
                        document.getElementById("<%=txtPassword.ClientID%>").focus();
                        return false;
                    }
                if (document.getElementById("<%=hdnIsSIB.ClientID%>").value == "1")
                    if (!PassWordValidationSIB(document.getElementById("<%=txtPassword.ClientID%>"))) {
                        alert('Password Sholud contain\n1) One Alphabet \n2) One Number \n3) One Special Charecter like ! @ # $ % \n4) One Uppercase Alphabet');
                        document.getElementById("<%=txtPassword.ClientID%>").focus();
                        return false;
                    }
                if (document.getElementById("<%=hdnIsCBI.ClientID%>").value == "1") {
                    if (document.getElementById("<%=txtPassword.ClientID%>").value == document.getElementById("<%=txtUserName.ClientID%>").value) {
                        alert("Password should not be same as User Name.");
                        document.getElementById("<%=txtPassword.ClientID%>").focus(); return false;
                    }
                    else if (document.getElementById("<%=txtPassword.ClientID%>").value == document.getElementById("<%=hdnUserIDCBI.ClientID%>").value) {
                        alert("Password should not be same as UserID.");
                        document.getElementById("<%=txtPassword.ClientID%>").focus(); return false;
                    }
                    else if (!PassWordValidationCBI(document.getElementById("<%=txtPassword.ClientID%>"))) {
                        alert('Password should contain\n1) One Alphabet \n2) One Number \n3) one Special Character like @ # $ % ^ & * +    _ - / = [ ] _ ( ) \n4) One Uppercase Alphabet');
                        document.getElementById("<%=txtPassword.ClientID%>").focus();
                        return false;
                    }
                }
            }
            if (!ValidateConfirmPassword(document.getElementById("<%=txtPassword.ClientID%>"), document.getElementById("<%=txtConfirmPassword.ClientID%>"), "Password", "Confirm Password")) return false;
            document.getElementById("<%=hdnDefaultPasswordSet.ClientID%>").value = "0";
            GetDetails(document.getElementById("<%=txtPassword.ClientID%>"));
            return false;
        }
        function PassWordValidationCBI(obj) {
            var passw = /^(?=.*[0-9])(?=.*[A-Z])(?=.*[!@#$%&([\/\])_*^+-=]){1}([a-zA-Z0-9!@#$%&([\/\])_*^+-=]+)$/;
            if (!obj.value.match(passw)) {
                return false;
            }
            return true;
        }
        function PassWordValidation(obj) {
            var passw = /[^a-zA-Z]/;
            if (!obj.value.match(passw)) {
                return false;
            }
            passw = /[0-9]/;
            if (!obj.value.match(passw)) {
                return false;
            }
            passw = /[A-Z]/;
            if (!obj.value.match(passw)) {
                return false;
            }
            passw = /[!@#$%&([)_]/;
            if (!obj.value.match(passw)) {
                return false;
            }
            return true;
        }
        function PassWordValidationSIB(obj) {
            var passw = /[0-9]/;
            if (!obj.value.match(passw)) {
                return false;
            }
            passw = /[A-Z]/;
            if (!obj.value.match(passw)) {
                return false;
            }
            passw = /[!@#$%]/;
            if (!obj.value.match(passw)) {
                return false;
            }
            return true;
        }
        function OnDelete() { return confirm("Are you sure you want to delete ?"); }
        function CheckUserUpdation(object) {
            var userID = document.getElementById("<%=hdnUserID.ClientID%>");
            var loggedinID = document.getElementById("<%=hdnloggedInID.ClientID%>");
            var adminBranchID = document.getElementById("<%=hdnAdminBranchID.ClientID%>");
            var adminBranchName = document.getElementById("<%=hdnAdminBranchName.ClientID%>");
            if (userID.value == loggedinID.value) {
                alert("User can not update his own access rights");
                object.checked = (!object.checked);
                return false;
            }
            else {
                var txtUserBranch = document.getElementById("<%=txtUserBranch.ClientID%>");
                var chkIsSuperAdmin = document.getElementById("<%=chkIsSuperAdmin.ClientID%>");
                if (chkIsSuperAdmin.checked) {
                    txtUserBranch.disabled = true;
                    document.getElementById("<%=hdnUserBranch.ClientID%>").value = adminBranchID.value;
                    document.getElementById("<%=txtUserBranch.ClientID%>").value = adminBranchName.value;
                    return true;
                }
                else {
                    txtUserBranch.disabled = false;
                    return true;
                }
            }
        }
        function GetUserBranchValue(source, eventArgs) {
            UserBranch = document.getElementById("<%=hdnUserBranch.ClientID%>");
            UserBranch.value = eventArgs.get_value();
        }
        function ClearUserBranch() {
            if (event.keyCode == 13 || event.keyCode == 37 || event.keyCode == 38 || event.keyCode == 39 || event.keyCode == 40) {
            }
            else {
                UserBranch = document.getElementById("<%=hdnUserBranch.ClientID%>");
                UserBranch.value = "-1";
            }
        }
        function SetSearchPanelVisibility() {
            var btnSearch = document.getElementById("<%=btnOpenSearch.ClientID%>");
            var pnlSearch = document.getElementById("<%=pnlSearch .ClientID%>");
            if (document.getElementById("<%=hdnSearch.ClientID%>").value == "0") {
                btnSearch.style.display = '';
                pnlSearch.style.display = 'none';
            }
            else {
                btnSearch.style.display = 'none';
                pnlSearch.style.display = '';
                document.getElementById("<%=txtSearchUserName.ClientID%>").focus();
            }
        }
        function SetStatus() {
            var hdnSearch = document.getElementById("<%=hdnSearch.ClientID%>");
            if (hdnSearch.value == "0") {
                hdnSearch.value = "1";
            }
            else {
                hdnSearch.value = "0";
            }
            SetSearchPanelVisibility();
        }
        function ParameterChanged() { document.getElementById("<%=hdnIsSearchParameterChanged.ClientID %>").value = "1"; }
        function OnParameterChanged() {
            if (document.getElementById("<%=hdnIsSearchParameterChanged.ClientID %>").value == "1") {
                document.getElementById("<%=cmbGoTo.ClientID %>").value = document.getElementById("<%=selectedPageSize.ClientID %>").value;
                document.getElementById("<%=txtGoToPage.ClientID %>").value = document.getElementById("<%=selectedPageIndex.ClientID %>").value;
                alert("Search parameters are changed; So,Click on search and continue");
                return false;
            }
            else {
                return true;
            }
        }
        function SetDefaultPassword() {
            document.getElementById("<%=txtPassword.ClientID %>").maxLength = 100;
            document.getElementById("<%=txtConfirmPassword.ClientID %>").maxLength = 100;
            //document.getElementById("<%=txtPassword.ClientID %>").value = "nnsGtbABKltXhulWnVvGvw==";
            document.getElementById("<%=txtPassword.ClientID %>").value = "CBjEsF9EgM7sqe85axoHsMB8CvH3/URd5it8jK/Wwoe/Wh5l5Jsesbq5gUPOjd52";
            //document.getElementById("<%=txtConfirmPassword.ClientID %>").value = "nnsGtbABKltXhulWnVvGvw==";
            document.getElementById("<%=txtConfirmPassword.ClientID %>").value = "CBjEsF9EgM7sqe85axoHsMB8CvH3/URd5it8jK/Wwoe/Wh5l5Jsesbq5gUPOjd52";
            document.getElementById("<%=hdnDefaultPasswordSet.ClientID%>").value = "1";
        }         
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentPlaceHolderBody" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel" runat="server" OnLoad="UpdatePanel_Load">
        <ContentTemplate>
            <asp:HiddenField ID="hdnFinYear" runat="server" />
            <asp:HiddenField ID="hdnSearch" runat="server" Value="1" />
            <asp:HiddenField ID="hdnUserID" runat="server" Value="-1" />
            <asp:HiddenField ID="hdnloggedInID" runat="server" />
            <asp:HiddenField ID="hdnAdminBranchID" runat="server" />
            <asp:HiddenField ID="hdnAdminBranchName" runat="server" />
            <asp:HiddenField ID="hdnUserBranch" Value="-1" runat="server" />
            <asp:HiddenField ID="selectedPageIndex" runat="server" Value="1" />
            <asp:HiddenField ID="selectedPageSize" runat="server" Value="10" />
            <asp:HiddenField ID="hdnIsSearchActive" runat="server" Value="0" />
            <asp:HiddenField ID="hdnIsSearchParameterChanged" runat="server" Value="0" />
            <asp:HiddenField ID="hdnPassword" runat="server" Value="" />
            <asp:HiddenField ID="hdnIsSB" runat="server" Value="0" />
            <asp:HiddenField ID="hdnIsUB" runat="server" Value="0" />
            <asp:HiddenField ID="hdnIsCBI" runat="server" Value="0" />
            <asp:HiddenField ID="hdnIsSIB" runat="server" Value="0" />
            <asp:HiddenField ID="hdnDefaultPasswordSet" runat="server" Value="0" />
            <asp:HiddenField ID="hdnUserIDCBI" runat="server" Value="-1" />
            <cc1:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" MinimumPrefixLength="2"
                ServiceMethod="GetUserBranch" ServicePath="~/WebServices/AutoCompleteService.asmx"
                TargetControlID="txtUserBranch" CompletionInterval="700" EnableCaching="false"
                CompletionSetCount="20" DelimiterCharacters="" ShowOnlyCurrentWordInCompletionListItem="true"
                FirstRowSelected="True" OnClientItemSelected="GetUserBranchValue">
            </cc1:AutoCompleteExtender>
            <asp:Panel ID="autocompleteDropDownPanel" Height="300px" runat="server" ScrollBars="Vertical"
                Visible="false" />
            <table class="nTbl">
                <tr>
                    <td>
                        <table cellpadding="0">
                            <tr valign="top">
                                <td width="312px">
                                    <table class="eCol" cellpadding="0">
                                        <tr valign="top">
                                            <td class="vHCol">
                                                Username
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtUserName" runat="server" CssClass="txtBML" TabIndex="1" AutoComplete="Off"
                                                    Width="180px">
                                                </asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="vHCol">
                                                Password
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtPassword" runat="server" CssClass="txtBML" TabIndex="2" MaxLength="15"
                                                    autocomplete="Off" Width="180px" TextMode="Password">
                                                </asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="vHCol">
                                                Confirm Password
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="txtBML" MaxLength="15"
                                                    autocomplete="Off" Width="180px" TextMode="Password" TabIndex="3">
                                                </asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="vHCol">
                                                Branch
                                            </td>
                                            <td class="iCol">
                                                <asp:TextBox ID="txtUserBranch" runat="server" TabIndex="4" CssClass="txtBML" Width="180px"
                                                    onkeyup="ClearUserBranch()">
                                                </asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="vHCol">
                                            </td>
                                            <td class="iCol">
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td valign="top" width="100%" class="eCol">
                                    <table class="nTbl" align="center" cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td class="iCol" width="100%">
                                                <asp:CheckBox ID="chkShowPass" runat="server" TabIndex="5" Text="Show Password" Width="100%"
                                                    AutoPostBack="true" OnCheckedChanged="chkShowPass_CheckedChanged" />
                                            </td>
                                            <tr>
                                                <td class="iCol" width="100%">
                                                    <asp:CheckBox ID="chkIsSuperAdmin" runat="server" Text="User is Super Admin" Width="100%"
                                                        TabIndex="5" OnClick="CheckUserUpdation(this)" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="iCol">
                                                    <asp:CheckBox ID="chkIsBranchAdmin" runat="server" OnClick="CheckUserUpdation(this)"
                                                        TabIndex="6" Text="User is Branch Admin" Width="100%" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="iCol" width="100%">
                                                    <asp:CheckBox ID="chkIsActive" runat="server" Checked="true" OnClick="CheckUserUpdation(this)"
                                                        TabIndex="7" Text="User is active" Width="100%" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="iCol" width="100%">
                                                    <table cellpadding="0" cellspacing="0">
                                                        <tr>
                                                            <td>
                                                                <cc1:MutuallyExclusiveCheckBoxExtender ID="MutuallyExclusiveCheckBoxExtender2" runat="server"
                                                                    TargetControlID="chkChecker" Key="chkMaster">
                                                                </cc1:MutuallyExclusiveCheckBoxExtender>
                                                                <asp:CheckBox ID="chkChecker" runat="server" Checked="false" TabIndex="7" Text="Checker"
                                                                    OnClick="CheckUserUpdation(this);" Width="100%" />
                                                            </td>
                                                            <td style="padding-left: 10px">
                                                                <cc1:MutuallyExclusiveCheckBoxExtender ID="MutuallyExclusiveCheckBoxExtender1" runat="server"
                                                                    TargetControlID="chkAuditor" Key="chkMaster">
                                                                </cc1:MutuallyExclusiveCheckBoxExtender>
                                                                <asp:CheckBox ID="chkAuditor" runat="server" Checked="false" TabIndex="7" Text="Auditor"
                                                                    Width="100%" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="iCol" width="100%">
                                                </td>
                                            </tr>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <table cellpadding="0">
                <tr>
                    <td>
                        <asp:Button ID="btnNew" Text="New" runat="server" CssClass="cmnBtn" TabIndex="9"
                            OnClientClick="OnNewRecord();SetSearchPanelVisibility();return false;" UseSubmitBehavior="False" />
                    </td>
                    <td style="padding-left: 5px">
                        <asp:Button ID="btnSave" Text="Save" OnClientClick="javascript:return Validation();"
                            TabIndex="8" OnClick="btnSave_Click" runat="server" CssClass="cmnBtn" />
                    </td>
                    <td>
                        <asp:Button ID="btnOpenSearch" runat="server" Text="Search" OnClientClick="SetStatus();return false;"
                            TabIndex="9" CssClass="cmnBtn" />
                    </td>
                    <td>
                        <asp:Button ID="btnResetPassword" runat="server" Text="Reset Password" OnClientClick="SetDefaultPassword();"
                            TabIndex="9" CssClass="cmnBtn" Width="120px" Visible="false" OnClick="btnResetPassword_Click"
                            UseSubmitBehavior="true" />
                    </td>
                </tr>
            </table>
            <asp:Panel ID="pnlSearch" runat="server" BorderStyle="Dashed" BorderWidth="1" CssClass="searchPanel">
                <table>
                    <tr>
                        <td style="width: 130px">
                            User Name
                        </td>
                        <td style="width: 130px">
                            <asp:TextBox ID="txtSearchUserName" CssClass="txtBPL" Width="130px" runat="server"
                                onchange="ParameterChanged();" TabIndex="10"></asp:TextBox>
                        </td>
                        <td style="width: 80px; padding-left: 10px;">
                            Branch / CBS Code
                        </td>
                        <td style="width: 130px">
                            <asp:TextBox ID="txtSearchBranchName" CssClass="txtBPL" Width="130px" runat="server"
                                onchange="ParameterChanged();" TabIndex="11"></asp:TextBox>
                        </td>
                        <td align="right">
                            <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="cmnBtn" Width="80px"
                                OnClick="btnSearch_Click" TabIndex="12" />
                        </td>
                        <td>
                            <asp:Button ID="btnClear" runat="server" Text="Clear" Width="80px" CssClass="cmnBtn"
                                OnClick="btnClear_Click" TabIndex="13" />
                        </td>
                        <td>
                            <asp:Button ID="btnClose" runat="server" Text="Close" Width="80px" OnClientClick="SetStatus();"
                                CssClass="cmnBtn" OnClick="btnClose_Click" TabIndex="14" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <table class="nTbl">
                <tr>
                    <td class="nTbl" align="right">
                        <asp:Panel ID="navPanel" CssClass="navPanel" runat="server" ScrollBars="Horizontal">
                            <asp:Repeater ID="rptrUser" runat="server" OnItemCommand="rptrUser_ItemCommand" OnItemDataBound="rptrUser_ItemDataBound">
                                <HeaderTemplate>
                                    <table id="NavTable">
                                        <tr bgcolor="#EEEEEE">
                                            <th colspan="2">
                                                Action
                                            </th>
                                            <th>
                                                <asp:Label runat="server" ID="lblUserName" Width="175px" Text="User Name" Font-Bold="true" />
                                            </th>
                                            <th>
                                                <asp:Label runat="server" ID="lblIsSuperAdmin" Width="90px" Text="Super Admin" Font-Bold="true" />
                                            </th>
                                            <th>
                                                <asp:Label runat="server" ID="lblIsBranchAdmin" Width="90px" Text="Branch Admin"
                                                    Font-Bold="true" />
                                            </th>
                                            <th>
                                                <asp:Label runat="server" ID="lblActive" Width="60px" Text="Active" Font-Bold="true" />
                                            </th>
                                            <th id="headerIsChecker" runat="server">
                                                <asp:Label runat="server" ID="lblIsChecker" Width="60px" Text="Checker" Font-Bold="true" />
                                            </th>
                                            <th id="headerIsAuditor" runat="server">
                                                <asp:Label runat="server" ID="lblIsAuditor" Width="60px" Text="Auditor" Font-Bold="true" />
                                            </th>
                                            <th>
                                                <asp:Label runat="server" ID="lblBranchName" Width="175px" Text="Branch Name" Font-Bold="true" />
                                            </th>
                                        </tr>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <tr bgcolor="white">
                                        <td>
                                            <asp:LinkButton ID="lnkEdit" runat="server" TabIndex="15" CommandName="LoadBranch"
                                                CommandArgument='<%# Eval("UserID") %>' Text="Edit"></asp:LinkButton>
                                        </td>
                                        <td>
                                            <asp:LinkButton ID="lnkDelete" runat="server" TabIndex="16" CommandName="DeleteBranch"
                                                CommandArgument='<%# Eval("UserID") %>' Text="Delete"></asp:LinkButton>
                                        </td>
                                        <td>
                                            <%# Eval("UserName")%>
                                        </td>
                                        <td style="text-align: center">
                                            <%# Eval("IsSuperAdmin")%>
                                        </td>
                                        <td style="text-align: center">
                                            <%# Eval("IsBranchAdmin")%>
                                        </td>
                                        <td style="text-align: center">
                                            <%# Eval("IsActive")%>
                                        </td>
                                        <td style="text-align: center" id="rowIsChecker" runat="server">
                                            <%# Eval("IsChecker")%>
                                        </td>
                                        <td style="text-align: center" id="rowIsAuditor" runat="server">
                                            <%# Eval("IsAuditor")%>
                                        </td>
                                        <td>
                                            <%# Eval("UserBranch")%>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                                <FooterTemplate>
                                    </table>
                                </FooterTemplate>
                            </asp:Repeater>
                        </asp:Panel>
                        <table style="padding-right: 0px; margin-right: -2px; margin-bottom: -1px">
                            <tr>
                                <td style="padding: 0px 0px 0px 0px">
                                    <asp:Label ID="ASPxLabel4" runat="server" Text="Records per page : " Font-Size="X-Small" />
                                </td>
                                <td style="width: 50px; padding-top: 2px;">
                                    <asp:DropDownList ID="cmbGoTo" runat="server" Style="width: 50px; height: 15px; float: left;"
                                        onchange="if(!OnParameterChanged()) return false" OnSelectedIndexChanged="cmbGoTo_SelectedIndexChanged"
                                        AutoPostBack="true" Font-Size="X-Small" TabIndex="17" CssClass="dropDownList">
                                        <asp:ListItem Text="5" Value="5" />
                                        <asp:ListItem Text="10" Value="10" />
                                        <asp:ListItem Text="15" Value="15" />
                                        <asp:ListItem Text="20" Value="20" />
                                        <asp:ListItem Text="25" Value="25" />
                                        <asp:ListItem Text="50" Value="50" />
                                        <asp:ListItem Text="75" Value="75" />
                                        <asp:ListItem Text="100" Value="100" />
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <asp:Label ID="lblGridStatus" runat="server" Style="float: left;" Text="" Font-Size="X-Small" />
                                </td>
                                <td>
                                    <asp:Button ID="btnFirst" runat="server" Text="&lt;&lt;" OnClick="btnFirst_Click"
                                        OnClientClick="return OnParameterChanged();" TabIndex="18" CssClass="navButton"
                                        Enabled="False"></asp:Button>
                                </td>
                                <td>
                                    <asp:Button ID="btnPrevious" runat="server" Text="&lt;" OnClick="btnPrevious_Click"
                                        OnClientClick="return OnParameterChanged();" TabIndex="19" CssClass="navButton"
                                        Enabled="False"></asp:Button>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtGoToPage" runat="server" Text="1" CssClass="navTextBox" AutoPostBack="True"
                                        TabIndex="20" onchange="if(!OnParameterChanged()) return false" OnTextChanged="txtGoToPage_TextChanged"
                                        MaxLength="5"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:Button ID="btnNext" runat="server" Text="&gt;" OnClick="btnNext_Click" CssClass="navButton"
                                        OnClientClick="return OnParameterChanged();" TabIndex="21"></asp:Button>
                                </td>
                                <td>
                                    <asp:Button ID="btnLast" runat="server" Text="&gt;&gt;" OnClick="btnLast_Click" CssClass="navButton"
                                        OnClientClick="return OnParameterChanged();" TabIndex="22"></asp:Button>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
