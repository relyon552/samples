<%@ page title="" language="C#" masterpagefile="~/SaralTDS.master" autoeventwireup="true" inherits="GrievanceAddressal_GrievanceAddressal, App_Web_grievanceaddressal.aspx.3953adb4" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ MasterType VirtualPath="~/SaralTDS.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript" language="javascript" src="../JavaScript/Validations.js"></script>
    <script type="text/javascript" language="javascript">


        function EnableDisableControls() {
            var Tdisp = document.getElementById("<%=tableGrievanceAddressal.ClientID%>");
            Tdisp.style.display = 'none';
        }
        function EnableDisableSubGrid() {
            var SubTableDisp = document.getElementById("<%=NavSubTable.ClientID%>");
            if (SubTableDisp != null) {
                SubTableDisp.style.display = 'none';
            }
        }
        function EnableDisableObjects() {
            var Tdisp = document.getElementById("<%=tableGrievanceAddressal.ClientID%>");
            var pnlSearch = document.getElementById("<%=pnlSearch .ClientID%>");
            var SubTableDisp = document.getElementById("<%=NavSubTable.ClientID%>");
            var GAID = document.getElementById("<%=ddlSelectionType.ClientID%>").value;
            var GAForm = document.getElementById("<%=ddlGrievanceForm.ClientID%>").value;


            if (GAID != "-1" && GAForm != "-1") {
                if (Tdisp != null && SubTableDisp != null) {
                    Tdisp.style.display = '';
                    pnlSearch.style.display = '';
                    SubTableDisp.style.display = '';
                }
            }
            else {
                Tdisp.style.display = 'none';
                pnlSearch.style.display = 'none';
                if (SubTableDisp != null) {
                    SubTableDisp.style.display = 'none';
                }
            }
            var lblQuarter = document.getElementById("<%=lblQuarter.ClientID%>");
            var ddlQuarter = document.getElementById("<%=ddlQuarter.ClientID%>");

            if (lblQuarter != null) {
                lblQuarter.style.display = '';
            }

            if (ddlQuarter != null)
                ddlQuarter.style.display = '';

            switch (GAID) {
                case "1":
                    document.getElementById("<%=lblCustomerID.ClientID%>").style.display = '';
                    document.getElementById("<%=txtCustomerID.ClientID%>").style.display = '';
                    document.getElementById("<%=txtCustomerName.ClientID%>").style.display = '';
                    document.getElementById("<%=lblCustomerName.ClientID%>").style.display = '';
                    document.getElementById("<%=lblPan.ClientID%>").style.display = '';
                    document.getElementById("<%=txtPANtoUpdate.ClientID%>").style.display = '';
                    document.getElementById("<%=lblCustomerID.ClientID%>").innerText = 'Reference No./Cust ID';
                    document.getElementById("<%=lblCustomerName.ClientID%>").innerText = 'Customer Name';
                    document.getElementById("<%=lblPan.ClientID%>").innerText = 'PAN to update';
                    document.getElementById("<%=lblDeductionSlNo.ClientID%>").style.display = 'none';
                    document.getElementById("<%=txtDeductionSlNo.ClientID%>").style.display = 'none';
                    if (lblQuarter != null) {
                        lblQuarter.style.display = 'none';
                    }
                    if (ddlQuarter != null) {
                        ddlQuarter.style.display = 'none';
                    }
                    break;
                case "2":
                    document.getElementById("<%=lblCustomerID.ClientID%>").style.display = '';
                    document.getElementById("<%=txtCustomerID.ClientID%>").style.display = '';
                    document.getElementById("<%=txtCustomerName.ClientID%>").style.display = '';
                    document.getElementById("<%=lblCustomerName.ClientID%>").style.display = '';
                    document.getElementById("<%=lblPan.ClientID%>").style.display = '';
                    document.getElementById("<%=txtPANtoUpdate.ClientID%>").style.display = '';
                    document.getElementById("<%=lblCustomerID.ClientID%>").innerText = 'Reference No./Cust ID';
                    document.getElementById("<%=lblCustomerName.ClientID%>").innerText = 'Customer Name';
                    document.getElementById("<%=lblPan.ClientID%>").innerText = 'PAN';
                    document.getElementById("<%=lblDeductionSlNo.ClientID%>").style.display = '';
                    document.getElementById("<%=txtDeductionSlNo.ClientID%>").style.display = '';
                    document.getElementById("<%=lblDeductionSlNo.ClientID%>").innerText = "Deduction Sl.No";
                    break;
                case "3":
                    document.getElementById("<%=lblCustomerID.ClientID%>").style.display = '';
                    document.getElementById("<%=txtCustomerID.ClientID%>").style.display = '';
                    document.getElementById("<%=txtCustomerName.ClientID%>").style.display = '';
                    document.getElementById("<%=lblCustomerName.ClientID%>").style.display = '';
                    document.getElementById("<%=lblPan.ClientID%>").style.display = '';
                    document.getElementById("<%=txtPANtoUpdate.ClientID%>").style.display = '';
                    document.getElementById("<%=lblCustomerID.ClientID%>").innerText = 'Reference No./Cust ID';
                    document.getElementById("<%=lblCustomerName.ClientID%>").innerText = 'Name';
                    document.getElementById("<%=lblPan.ClientID%>").innerText = 'PAN';
                    document.getElementById("<%=lblDeductionSlNo.ClientID%>").innerText = "Trans Ref No.";
                    break;
                case "4":
                    document.getElementById("<%=lblCustomerID.ClientID%>").style.display = '';
                    document.getElementById("<%=txtCustomerID.ClientID%>").style.display = '';
                    document.getElementById("<%=txtCustomerName.ClientID%>").style.display = '';
                    document.getElementById("<%=lblCustomerName.ClientID%>").style.display = '';
                    document.getElementById("<%=lblPan.ClientID%>").style.display = '';
                    document.getElementById("<%=txtPANtoUpdate.ClientID%>").style.display = '';
                    document.getElementById("<%=lblCustomerID.ClientID%>").innerText = 'Reference No./Cust ID';
                    document.getElementById("<%=lblCustomerName.ClientID%>").innerText = 'Customer Name';
                    document.getElementById("<%=lblPan.ClientID%>").innerText = 'PAN';
                    document.getElementById("<%=lblDeductionSlNo.ClientID%>").style.display = '';
                    document.getElementById("<%=txtDeductionSlNo.ClientID%>").style.display = '';
                    document.getElementById("<%=lblDeductionSlNo.ClientID%>").innerText = "Deduction Sl.No";
                    break;
                case "5":
                case "6":
                case "7":
                    document.getElementById("<%=txtCustomerName.ClientID%>").style.display = '';
                    document.getElementById("<%=lblCustomerName.ClientID%>").style.display = '';
                    document.getElementById("<%=lblCustomerID.ClientID%>").style.display = '';
                    document.getElementById("<%=txtCustomerID.ClientID%>").style.display = '';
                    document.getElementById("<%=lblPan.ClientID%>").style.display = '';
                    document.getElementById("<%=txtPANtoUpdate.ClientID%>").style.display = '';
                    document.getElementById("<%=lblCustomerID.ClientID%>").innerText = 'Reference No./Cust ID';
                    document.getElementById("<%=lblCustomerName.ClientID%>").innerText = 'Name';
                    document.getElementById("<%=lblPan.ClientID%>").innerText = 'PAN';
                    document.getElementById("<%=lblDeductionSlNo.ClientID%>").style.display = 'none';
                    document.getElementById("<%=txtDeductionSlNo.ClientID%>").style.display = 'none';
                    if (lblQuarter != null) {
                        lblQuarter.style.display = 'none';
                    }
                    if (ddlQuarter != null) {
                        ddlQuarter.style.display = 'none';
                    }
                    break;
                case "8":
                    document.getElementById("<%=lblCustomerID.ClientID%>").style.display = 'none';
                    document.getElementById("<%=lblCustomerName.ClientID%>").style.display = 'none';
                    document.getElementById("<%=lblPan.ClientID%>").style.display = 'none';
                    document.getElementById("<%=txtPANtoUpdate.ClientID%>").style.display = 'none';
                    document.getElementById("<%=lblDeductionSlNo.ClientID%>").style.display = 'none';
                    document.getElementById("<%=txtDeductionSlNo.ClientID%>").style.display = 'none';
                    document.getElementById("<%=txtCustomerID.ClientID%>").style.display = 'none';
                    document.getElementById("<%=txtCustomerName.ClientID%>").style.display = 'none';
                    break;
            }
        }
        function ClearDeducteeName() {
            if (event.keyCode == 13 || event.keyCode == 37 || event.keyCode == 38 || event.keyCode == 39 || event.keyCode == 40) {
            }
        }
        function ClearAllControls() {
            document.getElementById("<%=txtPANtoUpdate.ClientID%>").value = '';
            document.getElementById("<%=txtDeductionSlNo.ClientID%>").value = '';
            document.getElementById("<%=txtDescription.ClientID%>").value = '';
            document.getElementById("<%=txtCustomerName.ClientID%>").value = '';
            document.getElementById("<%=ddlStatus.ClientID%>").selectedIndex = 0;
            document.getElementById("<%=ddlQuarter.ClientID%>").selectedIndex = 0;
            document.getElementById("<%=txtSearchName.ClientID%>").value = '';
            document.getElementById("<%=txtSearchPAN.ClientID%>").value = '';
            document.getElementById("<%=txtSearchReferenceNo.ClientID%>").value = '';
            document.getElementById("<%=ddlSearchDropDownList.ClientID%>").selectedIndex = 0;
            document.getElementById("<%=txtSearchBranchCode.ClientID%>").value = '';
            document.getElementById("<%=hdnGrievanceID.ClientID%>").value = -1;
            document.getElementById("<%=txtCustomerID.ClientID%>").value = '';
            document.getElementById("<%=hdnEditStatus.ClientID%>").value = '';
        }
        function Validation() {
            var GAID = document.getElementById("<%=ddlSelectionType.ClientID%>").value;
            var GAForm = document.getElementById("<%=ddlGrievanceForm.ClientID%>").value;
            var CustID = document.getElementById("<%=txtCustomerID.ClientID%>").value;
            var PAN = document.getElementById("<%=txtPANtoUpdate.ClientID%>").value.toUpperCase();
            var DedSlno = document.getElementById("<%=txtDeductionSlNo.ClientID%>").value;
            var Description = document.getElementById("<%=txtDescription.ClientID%>").value;
            var CustName = document.getElementById("<%=txtCustomerName.ClientID%>").value;
//            var ddlCBSUpdate = document.getElementById("<%=ddlCBSUpdate.ClientID%>").value;
//            var txtTranID = document.getElementById("<%=txtCBSTranID.ClientID%>").value;            
            switch (GAID) {
                case "1":
                    //                    if (CustID != null) {
                    //                        if (CustID == "") {
                    //                            alert("Specify 'Reference No.'.");
                    //                            document.getElementById("<%=txtCustomerID.ClientID%>").focus();
                    //                            return false;
                    //                        }
                    //                    }
                    if (!ValidateDropDown(document.getElementById("<%=ddlFinYear.ClientID %>"), "Financial Year")) return false;

                    if (CustName != null) {
                        if (CustName == "") {
                            alert("Specify 'Customer Name'.");
                            document.getElementById("<%=txtCustomerName.ClientID%>").focus();
                            return false;
                        }
                    }
                    if (PAN != null) {
                        if (!ValidatePAN(document.getElementById("<%=txtPANtoUpdate.ClientID%>"), "PAN to Update", 10, true)) return false;
                        if (PAN == "") {
                            alert("Specify 'PAN to update'.");
                            document.getElementById("<%=txtPANtoUpdate.ClientID%>").focus();
                            return false;
                        }
                    }
                    if (!ValidateDropDown(document.getElementById("<%=ddlStatus.ClientID %>"), "Status")) return false;
                    if (Description != null) {
                        if (Description == "") {
                            alert("Specify 'Description'.");
                            document.getElementById("<%=txtDescription.ClientID%>").focus();
                            return false;
                        }
                    }
                    break;
                case "2":
                    if (!ValidateDropDown(document.getElementById("<%=ddlFinYear.ClientID %>"), "Financial Year")) return false;

                    if (CustName != null) {
                        if (CustName == "") {
                            alert("Specify 'Customer Name'.");
                            document.getElementById("<%=txtCustomerName.ClientID%>").focus();
                            return false;
                        }
                    }
                    if (PAN != null) {
                        if (!ValidatePAN(document.getElementById("<%=txtPANtoUpdate.ClientID%>"), "PAN", 10, true)) return false;
                        if (PAN == "") {
                            alert("Specify 'PAN'.");
                            document.getElementById("<%=txtPANtoUpdate.ClientID%>").focus();
                            return false;
                        }
                    }
                    if (DedSlno != null) {
                        if (DedSlno == "") {
                            alert("Specify 'Deduction Sl.No.'.");
                            document.getElementById("<%=txtDeductionSlNo.ClientID%>").focus();
                            return false;
                        }
                        if (isNaN(DedSlno)) {
                            alert("Specify only Numbers.\n In 'Deduction Sl.No.'.");
                            document.getElementById("<%=txtDeductionSlNo.ClientID%>").focus();
                            return false;
                        }
                    }
                    if (!ValidateDropDown(document.getElementById("<%=ddlQuarter.ClientID %>"), "Quarter")) return false;
                    if (!ValidateDropDown(document.getElementById("<%=ddlStatus.ClientID %>"), "Status")) return false;
                    if (Description != null) {
                        if (Description == "") {
                            alert("Specify 'Description'.");
                            document.getElementById("<%=txtDescription.ClientID%>").focus();
                            return false;
                        }
                    }
                    break;
                case "3":
                    if (!ValidateDropDown(document.getElementById("<%=ddlFinYear.ClientID %>"), "Financial Year")) return false;

                    if (CustName != null) {
                        if (CustName == "") {
                            alert("Specify 'Name'.");
                            document.getElementById("<%=txtCustomerName.ClientID%>").focus();
                            return false;
                        }
                    }
                    if (PAN != null) {
                        if (!ValidatePAN(document.getElementById("<%=txtPANtoUpdate.ClientID%>"), "PAN", 10, true)) return false;
                        if (PAN == "") {
                            alert("Specify 'PAN'.");
                            document.getElementById("<%=txtPANtoUpdate.ClientID%>").focus();
                            return false;
                        }
                    }
                    if (DedSlno != null) {
                        if (DedSlno == "") {
                            alert("Specify 'Trans Ref No.'.");
                            document.getElementById("<%=txtDeductionSlNo.ClientID%>").focus();
                            return false;
                        }
                    }
                    if (!ValidateDropDown(document.getElementById("<%=ddlQuarter.ClientID %>"), "Quarter")) return false;
                    if (!ValidateDropDown(document.getElementById("<%=ddlStatus.ClientID %>"), "Status")) return false;
                    if (Description != null) {
                        if (Description == "") {
                            alert("Specify 'Description'.");
                            document.getElementById("<%=txtDescription.ClientID%>").focus();
                            return false;
                        }
                    }
                    break;
                case "4":
                    if (!ValidateDropDown(document.getElementById("<%=ddlFinYear.ClientID %>"), "Financial Year")) return false;

                    if (CustName != null) {
                        if (CustName == "") {
                            alert("Specify 'Customer Name'.");
                            document.getElementById("<%=txtCustomerName.ClientID%>").focus();
                            return false;
                        }
                    }
                    if (PAN != null) {
                        if (!ValidatePAN(document.getElementById("<%=txtPANtoUpdate.ClientID%>"), "PAN", 10, true)) return false;
                        if (PAN == "") {
                            alert("Specify 'PAN'.");
                            document.getElementById("<%=txtCustomerName.ClientID%>").focus();
                            return false;
                        }
                    }
                    if (DedSlno != null) {
                        if (DedSlno == "") {
                            alert("Specify 'Deduction Sl.No.'.");
                            document.getElementById("<%=txtDeductionSlNo.ClientID%>").focus();
                            return false;
                        }
                        if (isNaN(DedSlno)) {
                            alert("Specify only Numbers.\n In 'Deduction Sl.No.'.");
                            document.getElementById("<%=txtDeductionSlNo.ClientID%>").focus();
                            return false;
                        }
                    }
                    if (!ValidateDropDown(document.getElementById("<%=ddlQuarter.ClientID %>"), "Quarter")) return false;
                    if (!ValidateDropDown(document.getElementById("<%=ddlStatus.ClientID %>"), "Status")) return false;
                    if (Description != null) {
                        if (Description == "") {
                            alert("Specify 'Description'.");
                            document.getElementById("<%=txtDescription.ClientID%>").focus();
                            return false;
                        }
                    }
                    break;
                case "5":
                case "6":
                case "7":
                    //                    if (CustID != null) {
                    //                        if (CustID == "") {
                    //                            alert("Specify 'Reference No'.");
                    //                            document.getElementById("<%=txtCustomerID.ClientID%>").focus();
                    //                            return false;
                    //                        }
                    //                    }
                    if (!ValidateDropDown(document.getElementById("<%=ddlFinYear.ClientID %>"), "Financial Year")) return false;
                    if (CustName != null) {
                        if (CustName == "") {
                            alert("Specify 'Name'.");
                            document.getElementById("<%=txtCustomerName.ClientID%>").focus();
                            return false;
                        }
                    }
                    if (PAN != null) {
                        if (!ValidatePAN(document.getElementById("<%=txtPANtoUpdate.ClientID%>"), "PAN", 10, true)) return false;
                        if (PAN == "") {
                            alert("Specify 'PAN'.");
                            document.getElementById("<%=txtPANtoUpdate.ClientID%>").focus();
                            return false;
                        }
                    }
                    if (Description != null) {
                        if (Description == "") {
                            alert("Specify 'Description'.");
                            document.getElementById("<%=txtDescription.ClientID%>").focus();
                            return false;
                        }
                    }
                    if (!ValidateDropDown(document.getElementById("<%=ddlStatus.ClientID %>"), "Status")) return false;
                    break;
                case "8":
                    if (!ValidateDropDown(document.getElementById("<%=ddlFinYear.ClientID %>"), "Financial Year")) return false;
                    if (!ValidateDropDown(document.getElementById("<%=ddlQuarter.ClientID %>"), "Quarter")) return false;
                    if (!ValidateDropDown(document.getElementById("<%=ddlStatus.ClientID %>"), "Status")) return false;
                    if (Description != null) {
                        if (Description == "") {
                            alert("Specify 'Description'.");
                            document.getElementById("<%=txtDescription.ClientID%>").focus();
                            return false;
                        }
                    }
                    break;
            }

//            if (ddlCBSUpdate != null) {
//                if (ddlCBSUpdate == "1" && txtTranID == "") {
//                    alert("Specify 'Transaction ID'.");
//                    document.getElementById("<%=txtCBSTranID.ClientID%>").focus();
//                    return false;
//                }
//            }

            if (!FileValidation())
                return false;
            else
                return true;
        }
        function SetStatus() {
            var hdnSearch = document.getElementById("<%=hdnSearch.ClientID%>");
            if (hdnSearch.value == "0") { hdnSearch.value = "1"; }
            else {
                hdnSearch.value = "0";
            }
            SetSearchPanelVisibility();
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
                document.getElementById("<%=txtSearchName.ClientID%>").focus();
            }
        }
        function ValidateLoadAll(chk) {
            if (chk == 0) {
                //                return confirm("Loading all details will take time.\nRecommend to use search filters.\n\nDo you want to continue?"); 
            }
            else {
                var txtSearchName = document.getElementById("<%=txtSearchName.ClientID%>");
                var txtSearchPAN = document.getElementById("<%=txtSearchPAN.ClientID%>");
                var txtSearchReferenceNo = document.getElementById("<%=txtSearchReferenceNo.ClientID%>");
                var txtSearchCorrType = document.getElementById("<%=ddlSearchDropDownList.ClientID%>");
                var txtSearchBranchCode = document.getElementById("<%=txtSearchBranchCode.ClientID%>");
                if (txtSearchName.value.trim() == "" && txtSearchPAN.value.trim() == "" && txtSearchReferenceNo.value.trim() == "" && txtSearchCorrType.value.trim() == ""
                    && txtSearchBranchCode.value.trim() == "") {
                    //                    return confirm("Loading all details will take time.\nRecommend to use search filters.\n\nDo you want to continue?");
                    return true;
                }
            }
        }
        function OnDelete(obj) { return confirm(obj); }
        function ConfirmRefresh() {
            confirmation = true;  //confirm('Loading all details will take time.\n\nDo you want to load ?');
            if (confirmation == true) {
                var btnRefresh = document.getElementById("<%=btnRefresh.ClientID%>");
                btnRefresh.click();
            }
            else {
                SetDropDown();
                EnableDisableControls();
            }
        }
        function SetDropDown() {
            document.getElementById("<%=ddlGrievanceForm.ClientID%>").selectedIndex = 0;
            document.getElementById("<%=ddlSelectionType.ClientID%>").selectedIndex = 0;
            document.getElementById("<%=ddlGrievanceForm.ClientID%>").disabled = false;
            document.getElementById("<%=ddlSelectionType.ClientID%>").disabled = false;
        }
        function FileValidation() {
            var Description = document.getElementById("<%=txtDescription.ClientID%>").value;
            var uploadFile = document.getElementById("<%=fupZipFile.ClientID%>");
            var file = uploadFile.value.trim();
            var fileType = "";
            var allowSubmit = false;

            if (Description != '') {
                fileType = "Zip";
                var validExtensions = new Array(".zip");
                if (file.indexOf("\\") == -1) {
                    //                    alert("Select a file to Upload."); 
                    return true;
                }
                else {
                    var ext = file.slice(file.lastIndexOf(".")).toLowerCase();
                    for (var i = 0; i < validExtensions.length; i++) { if (validExtensions[i] == ext) { allowSubmit = true; } }
                }
            }
            if (!allowSubmit) { alert("Select a Valid " + fileType + " File"); return false; } else return true;
        }
        function checkTextAreaMaxLength(textBox, e, length) {

            var mLen = textBox["MaxLength"];
            if (null == mLen)
                mLen = length;

            var maxLength = parseInt(mLen);
            if (!checkSpecialKeys(e)) {
                if (textBox.value.length > maxLength - 1) {
                    if (window.event)//IE
                        e.returnValue = false;
                    else//Firefox
                        e.preventDefault();
                }
            }
        }
        function checkSpecialKeys(e) {
            if (e.keyCode != 8 && e.keyCode != 4 && e.keyCode != 13 && e.keyCode != 37 && e.keyCode != 38 && e.keyCode != 39 && e.keyCode != 40)
                return false;
            else
                return true;
        }
    </script>
    <style type="text/css">
        .cmnBtn
        {
        }
        .style1
        {
            width: 197px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentPlaceHolderBody" runat="Server">
    <table class="nTbl">
        <tr>
            <td style="width: 120px">
                Select Form
            </td>
            <td>
                <asp:DropDownList ID="ddlGrievanceForm" runat="server" AutoPostBack="True" CssClass="dropDownList"
                    Width="100px" OnSelectedIndexChanged="ddlGrievanceForm_SelectedIndexChanged">
                    <asp:ListItem Text="Select" Value="-1"></asp:ListItem>
                    <asp:ListItem Text="Form24Q" Value="1"></asp:ListItem>
                    <asp:ListItem Text="Form26Q" Value="2"></asp:ListItem>
                    <asp:ListItem Text="Form27Q" Value="3"></asp:ListItem>
                </asp:DropDownList>
            </td>
            <td colspan="2" align="left">
                <table>
                    <tr align="left">
                        <td align="left" width="80px">
                            Financial Year
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlFinYear" runat="server" CssClass="dropDownList" Width="100px">
                                <asp:ListItem Text="Select" Value="-1"></asp:ListItem>
                                <asp:ListItem Text="2019-20" Value="2019"></asp:ListItem>
                                <asp:ListItem Text="2018-19" Value="2018"></asp:ListItem>
                                <asp:ListItem Text="2017-18" Value="2017"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td style="width: 120px">
                Correction Type&nbsp;&nbsp;
            </td>
            <td>
                <asp:DropDownList ID="ddlSelectionType" runat="server" onchange="javascript:EnableDisableObjects();ClearAllControls();"
                    BackColor="#E5E5E5" CssClass="dropDownList" Width="200px">
                </asp:DropDownList>
            </td>
        </tr>
    </table>
    <table id="tableGrievanceAddressal" runat="server">
        <tr>
            <td style="width: 150px">
                <asp:Label ID="lblSerialNo" runat="server" Text="Ticket No."></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="txtSerialNo" runat="server" ReadOnly="true" Style="background-color: #d5dadd;
                    color: Black;" CssClass="txtBPL" Width="160px"> </asp:TextBox>
            </td>
        </tr>
        <tr>
            <td style="width: 150px">
                <asp:Label ID="lblCustomerID" runat="server" Text="Reference No./Cust ID."></asp:Label>
            </td>
            <td class="iCol">
                <asp:TextBox ID="txtCustomerID" runat="server" CssClass="txtBPL" TabIndex="1" MaxLength="20"
                    onkeypress="return ValidateForAlphaNumeric(event);" Width="160px"></asp:TextBox>
            </td>
            <td style="width: 120px">
                <asp:Label ID="lblCustomerName" runat="server" Text="Customer Name"></asp:Label>
            </td>
            <td class="iCol">
                <asp:TextBox ID="txtCustomerName" runat="server" CssClass="txtBPL" BackColor="LightGray"
                    onkeypress="return ValidateDelimiter(this,event);" onkeyup="ClearDeducteeName()"
                    TabIndex="2" MaxLength="75" Width="150px"></asp:TextBox>
                <cc1:AutoCompleteExtender ID="autoCompleteExtender" runat="server" MinimumPrefixLength="2"
                    ServicePath="~/WebServices/AutoCompleteService.asmx" TargetControlID="txtCustomerName"
                    CompletionInterval="700" EnableCaching="false" CompletionSetCount="20" DelimiterCharacters=""
                    ShowOnlyCurrentWordInCompletionListItem="true" FirstRowSelected="True" ServiceMethod="GetAllEmployeeBranch;">
                </cc1:AutoCompleteExtender>
            </td>
        </tr>
        <tr>
            <td style="width: 150px">
                <asp:Label ID="lblPan" runat="server" Text="PAN to Update"></asp:Label>
            </td>
            <td class="iCol">
                <asp:TextBox ID="txtPANtoUpdate" runat="server" Width="160px" CssClass="txtBML" TabIndex="3"
                    onBlur="ConvertToUC(this);" BackColor="LightGray" onkeypress="return ValidateForAlphaNumeric(event);"
                    MaxLength="10"></asp:TextBox>
            </td>
            <td style="width: 120px">
                <asp:Label ID="lblDeductionSlNo" runat="server" Text="Deduction Sl.No."></asp:Label>
            </td>
            <td class="iCol">
                <asp:TextBox ID="txtDeductionSlNo" runat="server" Width="150px" CssClass="txtBPL"
                    BackColor="LightGray" TabIndex="4" onKeypress="return ValidateForAlphaNumeric(event);"
                    MaxLength="20"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td style="width: 150px">
                <asp:Label ID="lblQuarter" runat="server" Text=" Quarter "></asp:Label>
            </td>
            <td class="style1" style="width: 165px">
                <asp:DropDownList ID="ddlQuarter" runat="server" CssClass="mdropDownList" Width="165px"
                    TabIndex="5">
                    <asp:ListItem Text="Select" Value="-1"></asp:ListItem>
                    <asp:ListItem Text="Quarter1" Value="1"></asp:ListItem>
                    <asp:ListItem Text="Quarter2" Value="2"></asp:ListItem>
                    <asp:ListItem Text="Quarter3" Value="3"></asp:ListItem>
                    <asp:ListItem Text="Quarter4" Value="4"></asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblCBSUpdate" runat="server" Text=" Whether Change made in CBS ? ">
                </asp:Label>
            </td>
            <td>
                <asp:DropDownList ID="ddlCBSUpdate" runat="server" CssClass="mdropDownList" Width="165px">
                    <asp:ListItem Text="Select" Value="-1"></asp:ListItem>
                    <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                    <asp:ListItem Text="No" Value="False"></asp:ListItem>
                </asp:DropDownList>
            </td>
            <td>
                <asp:Label ID="lblCBSTranID" runat="server" Text=" Transaction ID ">
                </asp:Label>
            </td>
            <td>
                <asp:TextBox ID="txtCBSTranID" runat="server" MaxLength="20" CssClass="txtBPL" Width="150px"
                    onkeypress="return ValidateForAlphaNumeric(event);">                               
                </asp:TextBox>
            </td>
        </tr>
        <tr>
            <td style="width: 150px">
                <asp:Label ID="lblStatus" runat="server" Text=" Status "></asp:Label>
            </td>
            <td class="style1" style="width: 165px">
                <asp:DropDownList ID="ddlStatus" runat="server" CssClass="mdropDownList" Width="165px"
                    TabIndex="6">
                    <asp:ListItem Text="Select" Value="-1"></asp:ListItem>
                    <asp:ListItem Text="New" Value="1"></asp:ListItem>
                    <asp:ListItem Text="InProgress" Value="2"></asp:ListItem>
                    <asp:ListItem Text="MoreDetailsNeeded" Value="3"></asp:ListItem>
                    <asp:ListItem Text="AdditionalDetailsGiven" Value="4"></asp:ListItem>
                    <asp:ListItem Text="Resolved" Value="5"></asp:ListItem>
                    <asp:ListItem Text="Reopen" Value="6"></asp:ListItem>
                    <asp:ListItem Text="Closed" Value="7"></asp:ListItem>
                    <asp:ListItem Text="ApprovedbyRO" Value="8"></asp:ListItem>
                    <asp:ListItem Text="RejectedbyRO" Value="9"></asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td style="width: 120px">
            </td>
            <td id="NavSubTable" class="nTbl" colspan="4">
                <asp:Panel ID="NavSubPanel" CssClass="navPanel" runat="server" Visible="false" BorderColor="LightGray">
                    <table cellspacing="0" cellpadding="0" style="width: 500px">
                        <asp:Repeater ID="rptrDetails" runat="server" OnItemCommand="rptrDetails_ItemCommand"
                            OnItemDataBound="rptrDetails_ItemDataBound">
                            <HeaderTemplate>
                                <tr bgcolor="#EEEEEE">
                                    <th>
                                        <asp:Label runat="Server" ID="lblDescription" Width="205px" Text="Description" />
                                    </th>
                                    <th>
                                        <asp:Label runat="Server" ID="lblCorrRefFile" Width="77px" Text="Corr.Ref.File" />
                                    </th>
                                    <th>
                                        <asp:Label runat="Server" ID="lblStatus" Width="120px" Text="Status" />
                                    </th>
                                    <th>
                                        <asp:Label runat="Server" ID="lblDateTime" Width="80px" Text="Updated On" />
                                    </th>
                                    <th>
                                        <asp:Label runat="Server" ID="lblUser" Width="75px" Text="Updated By" />
                                    </th>
                                </tr>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr bgcolor="white">
                                    <td style="width: 205px">
                                        <%#Eval("Description")%>
                                    </td>
                                    <td style="width: 77px">
                                        <asp:LinkButton ID="lnkDownloadZipFile" runat="server" Text="Download" CommandName="Download"
                                            CommandArgument='<%# Eval("ZipPath")%>' />
                                    </td>
                                    <td style="width: 120px">
                                        <%#Eval("Status")%>
                                    </td>
                                    <td style="width: 80px">
                                        <%#Eval("DesDateTime")%>
                                    </td>
                                    <td style="width: 75px">
                                        <%#Eval("UserName")%>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </table>
                </asp:Panel>
            </td>
        </tr>
        <tr>
            <td style="width: 120px">
            </td>
            <td colspan="4">
                <asp:Label ID="lblDescriptionNote" runat="server" Font-Bold="true" Font-Size="Smaller"
                    ForeColor="Red" Text="NOTE : Maximum 500 Characters allowed" />
            </td>
        </tr>
        <tr>
            <td style="width: 120px">
                <asp:Label ID="lblDescription" runat="server" Text=" Description "></asp:Label>
            </td>
            <td class="iCol" colspan="4">
                <asp:TextBox ID="txtDescription" runat="server" CssClass="txtBPL" MaxLength="502"
                    onkeyDown="checkTextAreaMaxLength(this,event,'502');" TabIndex="7" Width="638px"
                    Height="80px" TextMode="MultiLine"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td style="width: 120px">
                <asp:Label ID="lblUploadFile" runat="server" Text="Upload File"></asp:Label>
            </td>
            <td class="iCol" colspan="3">
                <asp:FileUpload ID="fupZipFile" runat="server" Width="400px" CssClass="browsBtn" />
            </td>
            <td class="iCol">
                <asp:Label ID="lblZipFile" runat="server" Font-Bold="true" Font-Size="Smaller" ForeColor="Red"
                    Text="(Maximum .zip size: 1 MB)" />
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td class="iCol" colspan="3" style="width: 478px">
                <asp:Button ID="btnNew" runat="server" Text="New" TabIndex="8" CssClass="cmnBtn"
                    OnClick="btnNew_Click"></asp:Button>
                <asp:Button ID="btnSave" runat="server" Text="Submit" TabIndex="9" CssClass="cmnBtn"
                    OnClientClick="return Validation();" OnClick="btnSave_Click"></asp:Button>
                <asp:Button ID="btnOpenSearch" runat="server" TabIndex="10" Text="Search" OnClientClick="SetStatus();return false;"
                    CssClass="cmnBtn"></asp:Button>
            </td>
        </tr>
    </table>
    <asp:Panel ID="pnlSearch" runat="server" BorderStyle="Dashed" BorderWidth="1" CssClass="searchPanel">
        <table>
            <tr>
                <td>
                    <table>
                        <tr>
                            <td style="width: 40px">
                                Name
                            </td>
                            <td style="width: 200px">
                                <asp:TextBox ID="txtSearchName" CssClass="txtBPL" Width="200px" TabIndex="11" MaxLength="75"
                                    runat="server"></asp:TextBox>
                            </td>
                            <td style="width: 30px; padding-left: 5px;">
                                PAN
                            </td>
                            <td style="width: 130px">
                                <asp:TextBox ID="txtSearchPAN" CssClass="txtBPL" Width="130px" TabIndex="12" MaxLength="10"
                                    runat="server"></asp:TextBox>
                            </td>
                            <td style="width: 80px; padding-left: 5px;" id="tdlblSearchRefereneno" runat="server">
                                <asp:Label ID="lblRefNoSearch" runat="server" Text="Reference No./Cust ID."></asp:Label>
                            </td>
                            <td style="width: 10px" id="tdtxtSearchRefereneno" runat="server">
                                <asp:TextBox ID="txtSearchReferenceNo" CssClass="txtBPL" Width="180px" TabIndex="13"
                                    MaxLength="20" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 100px">
                                Correction Type
                            </td>
                            <td style="width: 100px">
                                <asp:DropDownList ID="ddlSearchDropDownList" runat="server" BackColor="#E5E5E5" CssClass="dropDownList"
                                    Width="205px">
                                </asp:DropDownList>
                            </td>
                            <td style="width: 30px; padding-left: 5px;">
                                Branch Code
                            </td>
                            <td style="width: 130px">
                                <asp:TextBox ID="txtSearchBranchCode" CssClass="txtBPL" Width="130px" TabIndex="15"
                                    MaxLength="10" runat="server"></asp:TextBox>
                            </td>
                            <td style="width: 20px">
                                Status
                            </td>
                            <td style="width: 180px">
                                <asp:DropDownList ID="ddlSearchStatusList" runat="server" BackColor="#E5E5E5" CssClass="dropDownList"
                                    Width="185px">
                                    <asp:ListItem Text="Select" Value="-1"></asp:ListItem>
                                    <asp:ListItem Text="New" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="InProgress" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="MoreDetailsNeeded" Value="3"></asp:ListItem>
                                    <asp:ListItem Text="AdditionalDetailsGiven" Value="4"></asp:ListItem>
                                    <asp:ListItem Text="Resolved" Value="5"></asp:ListItem>
                                    <asp:ListItem Text="Reopen" Value="6"></asp:ListItem>
                                    <asp:ListItem Text="Closed" Value="7"></asp:ListItem>
                                    <asp:ListItem Text="ApprovedbyRO" Value="8"></asp:ListItem>
                                    <asp:ListItem Text="RejectedbyRO" Value="9"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 100px">
                                Form Type
                            </td>
                            <td style="width: 100px">
                                <asp:DropDownList ID="ddlSearchForm" runat="server" BackColor="#E5E5E5" CssClass="dropDownList"
                                    Width="205px">
                                    <asp:ListItem Text="Select" Value="-1"></asp:ListItem>
                                    <asp:ListItem Text="Form24Q" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="Form26Q" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="Form27Q" Value="3"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td style="width: 100px">
                                Financial Year
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlSearchFinYear" runat="server" BackColor="#E5E5E5" CssClass="dropDownList"
                                    Width="135px">
                                    <asp:ListItem Text="Select" Value="-1"></asp:ListItem>
                                    <asp:ListItem Text="2019-20" Value="2019"></asp:ListItem>
                                    <asp:ListItem Text="2018-19" Value="2018"></asp:ListItem>
                                    <asp:ListItem Text="2017-18" Value="2017"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <table>
                        <tr>
                            <td align="right">
                                <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="cmnBtn" TabIndex="14"
                                    OnClick="btnSearch_Click" OnClientClick="return ValidateLoadAll(1)" />
                            </td>
                            <td>
                                <asp:Button ID="btnShowAll" runat="server" Text="Show All" CssClass="cmnBtn" TabIndex="15"
                                    OnClick="btnShowAll_Click" OnClientClick="return ValidateLoadAll(0)" />
                            </td>
                            <td>
                                <asp:Button ID="btnShowNotClosed" runat="server" Text="Show Not Closed" Width="120px"
                                    CssClass="cmnBtn" TabIndex="16" OnClick="btnShowNotClosed_Click" OnClientClick="return ValidateLoadAll(0)" />
                            </td>
                            <td>
                                <asp:Button ID="btnGenerateReport" runat="server" Text="Generate Report" Width="120px"
                                    Visible="true" CssClass="cmnBtn" OnClick="btnGenerateReport_Click" />
                            </td>
                            <td>
                                <asp:Button ID="btnClose" runat="server" Text="Close" Visible="false" Width="80px"
                                    OnClientClick="EnableDisableObjects();ClearAllControls();SetStatus();return false;"
                                    CssClass="cmnBtn" TabIndex="16" OnClick="btnClose_Click" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </asp:Panel>
    <table>
        <tr>
            <td class="nTbl">
                <asp:Panel ID="navPanel" CssClass="navPanel" runat="server" ScrollBars="Horizontal"
                    Visible="false">
                    <asp:Repeater ID="rptGrievance" runat="server" OnItemCommand="rptGrievance_ItemCommand"
                        OnItemDataBound="rptGrievance_ItemDataBound">
                        <HeaderTemplate>
                            <table id="NavTable" cellspacing="0" cellpadding="0">
                                <tr bgcolor="#EEEEEE">
                                    <th colspan="2">
                                        Action
                                    </th>
                                    <th>
                                        <asp:Label runat="server" ID="lblRowNo" Width="80px" Text="Ticket No." />
                                    </th>
                                    <th>
                                        <asp:Label runat="server" ID="lblFinYear" Width="80px" Text="Financial Year" />
                                    </th>
                                    <th>
                                        <asp:Label runat="server" ID="lblBranchCode" Width="80px" Text="Branch Code" />
                                    </th>
                                    <th>
                                        <asp:Label runat="server" ID="lblStatus" Width="120px" Text="Status" />
                                    </th>
                                    <th>
                                        <asp:Label runat="server" ID="lblName" Width="230px" Text="Name" />
                                    </th>
                                    <th>
                                        <asp:Label runat="server" ID="Label0" Width="100px" Text="PAN" />
                                    </th>
                                    <th runat="server" id="headerReferenceNo">
                                        <asp:Label runat="server" ID="lblRef" Width="90px" Text="Reference No./Cust ID." />
                                    </th>
                                    <th>
                                        <asp:Label ID="Label1" runat="server" Width="80px" Text="FormType" />
                                    </th>
                                    <th>
                                        <asp:Label runat="Server" ID="Label5" Width="200px" Text="Correction Type" />
                                    </th>
                                </tr>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr bgcolor="white">
                                <td>
                                    <asp:LinkButton ID="hlnkEdit" runat="server" CommandName="LoadData" Text='Edit' TabIndex="27"
                                        CommandArgument='<%#Eval("GRIEVANCEID") %>'></asp:LinkButton>
                                </td>
                                <td>
                                    <asp:LinkButton ID="hlnkDelete" runat="server" CommandName="DeleteData" Text='Delete'
                                        TabIndex="28" CommandArgument='<%#Eval("GRIEVANCEID") %>'></asp:LinkButton>
                                </td>
                                <td align="center">
                                    <%#Eval("RowNum")%>
                                    <asp:HiddenField ID="hdnRowNum" runat="server" Value='<%#Eval("RowNum")%>' />
                                </td>
                                <td>
                                    <%#Eval("FinYear")%>
                                </td>
                                <td>
                                    <%#Eval("BranchCode")%>
                                </td>
                                <td>
                                    <%#Eval("Status")%>
                                </td>
                                <td>
                                    <%#Eval("CUSTNAME")%>
                                </td>
                                <td>
                                    <%#Eval("PAN")%>
                                </td>
                                <td id="colReference" runat="server">
                                    <%#Eval("CUSTID")%>
                                </td>
                                <td>
                                    <%#Eval("FormID")%>
                                </td>
                                <td>
                                    <%#Eval("GrievanceName")%>
                                </td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                            </table>
                        </FooterTemplate>
                    </asp:Repeater>
                </asp:Panel>
                <table id="tblPagination" runat="server" style="padding-right: 0px; display: none"
                    align="right">
                    <tr>
                        <td style="padding: 0px 0px 0px 0px">
                            <asp:Label ID="ASPxLabel4" runat="server" Text="Records per page : " Font-Size="X-Small" />
                        </td>
                        <td style="width: 50px; padding-top: 2px;">
                            <asp:DropDownList ID="cmbGoTo" runat="server" Style="width: 50px; height: 15px; float: left;"
                                OnSelectedIndexChanged="cmbGoTo_SelectedIndexChanged" AutoPostBack="true" TabIndex="29"
                                Font-Size="X-Small">
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
                                CssClass="navButton" Enabled="False" TabIndex="30"></asp:Button>
                        </td>
                        <td>
                            <asp:Button ID="btnPrevious" runat="server" Text="&lt;" OnClick="btnPrevious_Click"
                                CssClass="navButton" Enabled="False" TabIndex="31"></asp:Button>
                        </td>
                        <td>
                            <asp:TextBox ID="txtGoToPage" runat="server" Text="1" CssClass="navTextBox" AutoPostBack="True"
                                OnTextChanged="txtGoToPage_TextChanged" MaxLength="5" TabIndex="32"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Button ID="btnNext" runat="server" Text="&gt;" OnClick="btnNext_Click" CssClass="navButton"
                                TabIndex="33"></asp:Button>
                        </td>
                        <td>
                            <asp:Button ID="btnLast" runat="server" Text="&gt;&gt;" OnClick="btnLast_Click" CssClass="navButton"
                                TabIndex="34"></asp:Button>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <asp:Button ID="btnRefresh" runat="server" Text="" CssClass="cmnBtn" BackColor="Transparent"
        BorderColor="Transparent" Width="0px" Visible="false" OnClick="btnRefresh_Click" />
    <asp:HiddenField ID="hdnGrievanceID" runat="server" Value="-1" />
    <asp:HiddenField ID="hdnSearch" runat="server" Value="0" />
    <asp:HiddenField ID="hdnIsSearchActive" runat="server" Value="0" />
    <asp:HiddenField ID="selectedPageIndex" runat="server" Value="1" />
    <asp:HiddenField ID="selectedPageSize" runat="server" Value="10" />
    <asp:HiddenField ID="hdnLoginBranch" runat="server" Value="" />
    <asp:HiddenField ID="hdnEditStatus" runat="server" Value="" />
    <asp:HiddenField ID="hdnUserName" runat="server" Value="" />
    <asp:HiddenField ID="hdnUploadFilePath" runat="server" Value="" />
    <asp:HiddenField ID="hdnFileGreaterThan1MB" runat="server" Value="0" />
    <asp:HiddenField ID="hdnRecordCount" runat="server" Value="0" />
    <asp:HiddenField ID="hdnCorrtype" runat="server" Value="" />
    <asp:HiddenField ID="hdnFinyear" runat="server" Value="" />
</asp:Content>
