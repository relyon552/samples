<%@ page title="" language="C#" masterpagefile="~/SaralTDS.master" autoeventwireup="true" inherits="Deductee_NonEmployee, App_Web_nonemployee.aspx.8c7655b4" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ MasterType VirtualPath="~/SaralTDS.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript" language="javascript" src="../JavaScript/Validations.js"></script>
    <script language="javascript" type="text/javascript">

        function RemoveAlert() {
            var lstDetails = document.getElementById("<%=lstDetails.ClientID%>")
            if (lstDetails != null) {
                if (lstDetails.selectedIndex > -1)
                    return confirm("Selected Certificate No. details will be deleted permanently.\nDo you want to continue?");
            }
        }

        function ConfirmRefresh() {
            confirmation = confirm('Loading all details will take time.\n\nDo you want to load ?');
            if (confirmation == true) {
                var btnRefresh = document.getElementById("<%=btnRefresh.ClientID%>");
                btnRefresh.click();
            }
        }

        function ValidateLoadAll(chk) {
            if (chk == 0) { return confirm("Loading all details will take time.\nRecommend to use search filters.\n\nDo you want to continue?"); }
            else {
                var txtSearchName = document.getElementById("<%=txtSearchName.ClientID%>");
                var txtSearchPAN = document.getElementById("<%=txtSearchPAN.ClientID%>");
                var txtSearchReferenceNo = document.getElementById("<%=txtSearchReferenceNo.ClientID%>");
                if (txtSearchName.value.trim() == "" && txtSearchPAN.value.trim() == "" && txtSearchReferenceNo.value.trim() == "") {
                    return confirm("Loading all details will take time.\nRecommend to use search filters.\n\nDo you want to continue?");
                }
            }
        }
        function OnNewRecord() {
            var defaultPAN = document.getElementById("<%=hdnDefaultPan.ClientID%>");
            var additionField = document.getElementById("<%=AdditionalField.ClientID%>");
            var ddlPan = document.getElementById("<%=ddlPan.ClientID%>");
            document.getElementById("<%=hdnDeducteeID.ClientID%>").value = "-1";
            document.getElementById("<%=hdnNonEmployeeID.ClientID%>").value = "-1";
            document.getElementById("<%=txtNonEmployeeID.ClientID%>").value = "";
            document.getElementById("<%=cmbSalutation.ClientID%>").selectedIndex = 0;
            document.getElementById("<%=cmbSalutation.ClientID%>").disabled = false;
            document.getElementById("<%=txtNonEmployeeName.ClientID%>").value = "";
            document.getElementById("<%=txtNonEmployeeName.ClientID%>").disabled = false;
            document.getElementById("<%=txtAddress1.ClientID%>").value = "";
            document.getElementById("<%=txtAddress2.ClientID%>").value = "";
            document.getElementById("<%=txtAddress3.ClientID%>").value = "";
            document.getElementById("<%=txtAddress4.ClientID%>").value = "";
            document.getElementById("<%=txtCity.ClientID%>").value = "";
            document.getElementById("<%=txtPinCode.ClientID%>").value = "";
            document.getElementById("<%=txtPhoneNumber.ClientID%>").value = "";
            document.getElementById("<%=txtEmailAddress.ClientID%>").value = "";
            document.getElementById("<%=txtPanReference.ClientID%>").value = "";
            document.getElementById("<%=txtPanReference.ClientID%>").disabled = false;
            document.getElementById("<%=cmbState.ClientID%>").selectedIndex = 0;
            document.getElementById("<%=chkForm26.ClientID%>").checked = true;
            document.getElementById("<%=chkForm26.ClientID%>").disabled = false;
            document.getElementById("<%=chkForm27.ClientID%>").checked = true;
            document.getElementById("<%=chkForm27.ClientID%>").disabled = false;
            document.getElementById("<%=hdnCertDetailID.ClientID%>").value = "-1";
            if (document.getElementById("<%=ddlSection.ClientID%>") != null)
                document.getElementById("<%=ddlSection.ClientID%>").disabled = false;
            if (document.getElementById("<%=txtMobileNo.ClientID%>") != null) {
                document.getElementById("<%=txtMobileNo.ClientID%>").value = '';
            }
            if (document.getElementById("<%=txtFAX.ClientID%>") != null) {
                document.getElementById("<%=txtFAX.ClientID%>").value = '';
            }
            if (document.getElementById("<%=txtPersonDesgn.ClientID%>") != null) {
                document.getElementById("<%=txtPersonDesgn.ClientID%>").value = '';
            }
            if (document.getElementById("<%=txtContactName.ClientID%>") != null) {
                document.getElementById("<%=txtContactName.ClientID%>").value = '';
            }
            if (document.getElementById("<%=chkForm27E.ClientID%>") != null) {
                document.getElementById("<%=chkForm27E.ClientID%>").checked = true;
                document.getElementById("<%=chkForm27E.ClientID%>").disabled = false;
            }
            if (defaultPAN.value != "" && defaultPAN.value != "PAN") {
                if (defaultPAN.value == "PANNOTAVBL") {
                    document.getElementById("<%=ddlPan.ClientID%>").selectedIndex = 3;
                }
                else if (defaultPAN.value == "PANINVALID") {
                    document.getElementById("<%=ddlPan.ClientID%>").selectedIndex = 2;
                }
                else if (defaultPAN.value == "PANAPPLIED") {
                    document.getElementById("<%=ddlPan.ClientID%>").selectedIndex = 1;
                }
                document.getElementById("<%=txtPanReference.ClientID%>").style.backgroundColor = "white";
                document.getElementById("<%=txtPanReference.ClientID%>").disabled = true;
                if (additionField != null) {
                    document.getElementById("<%=txtSTRegNo.ClientID%>").style.backgroundColor = "white";
                    document.getElementById("<%=txtSTRegNo.ClientID%>").disabled = false;
                }
            }
            else {
                document.getElementById("<%=ddlPan.ClientID%>").selectedIndex = 0;
                document.getElementById("<%=txtPanReference.ClientID%>").disabled = false;
                if (additionField != null && document.getElementById("<%=hdnisSB.ClientID%>") == 0)
                    document.getElementById("<%=txtSTRegNo.ClientID%>").disabled = false;
            }
            if (defaultPAN.value == "PAN") {
                document.getElementById("<%=ddlPan.ClientID%>").selectedIndex = 0;
                document.getElementById("<%=txtPanReference.ClientID%>").disabled = false;
                document.getElementById("<%=txtPanReference.ClientID%>").style.backgroundColor = "#E5E5E5";
            }
            document.getElementById("<%=ddlPan.ClientID%>").disabled = false;
            if (document.getElementById("<%=txtPANStatus.ClientID%>") != null) {
                document.getElementById("<%=txtPANStatus.ClientID%>").defaultValue = "";
                document.getElementById("<%=txtPANStatus.ClientID%>").value = "";
            }
            document.getElementById("<%=cmbNonemployeeCode.ClientID%>").selectedIndex = 0;
            if (document.getElementById("<%=chkIsTransporter.ClientID%>") != null)
                document.getElementById("<%=chkIsTransporter.ClientID%>").checked = false;
            document.getElementById("<%=txtNonEmployeeName.ClientID%>").focus();
            document.getElementById("<%=hdnSearch.ClientID%>").value = "0";
            document.getElementById("<%=hdnIsSearchActive.ClientID%>").value = "0";
            document.getElementById("<%=txtSearchName.ClientID%>").value = "";
            document.getElementById("<%=txtSearchPAN.ClientID%>").value = "";
            if (document.getElementById("<%=txtReferenceNo.ClientID%>") != null)
                document.getElementById("<%=txtReferenceNo.ClientID%>").value = "";
            var additionField = document.getElementById("<%=AdditionalField.ClientID%>");
            var bankDetails = document.getElementById("<%=BankDetails.ClientID%>");
            if (additionField != null) {
                if (document.getElementById("<%=txtBAN.ClientID%>") != null)
                    document.getElementById("<%=txtBAN.ClientID%>").value = '';
                if (document.getElementById("<%=txtIFSCCode.ClientID%>") != null)
                    document.getElementById("<%=txtIFSCCode.ClientID%>").value = '';
                if (document.getElementById("<%=hdnisSB.ClientID%>").value == 0) {
                    if (document.getElementById("<%=chkMakeTDS.ClientID%>") != null)
                        document.getElementById("<%=chkMakeTDS.ClientID%>").checked = false;
                    if (document.getElementById("<%=txtTaxrate.ClientID%>") != null)
                        document.getElementById("<%=txtTaxrate.ClientID%>").value = '';
                    if (document.getElementById("<%=txtTaxrateLimit.ClientID%>") != null)
                        document.getElementById("<%=txtTaxrateLimit.ClientID%>").value = '';
                    if (document.getElementById("<%=drpStatus.ClientID%>") != null)
                        document.getElementById("<%=drpStatus.ClientID%>").selectedIndex = 0;
                    if (document.getElementById("<%=txtBankName.ClientID%>") != null)
                        document.getElementById("<%=txtBankName.ClientID%>").value = '';
                    if (document.getElementById("<%=txtBranchName.ClientID%>") != null)
                        document.getElementById("<%=txtBranchName.ClientID%>").value = '';
                    if (document.getElementById("<%=btnSave.ClientID%>") != null)
                        document.getElementById("<%=btnSave.ClientID%>").disabled = false;
                    if (document.getElementById("<%=hdnBankID.ClientID%>") != null)
                        document.getElementById("<%=hdnBankID.ClientID%>").value = "-1";
                    if (document.getElementById("<%=txtSTRegNo.ClientID%>") != null)
                        document.getElementById("<%=txtSTRegNo.ClientID%>").value = '';
                    if (document.getElementById("<%=lstDetails.ClientID%>") != null)
                        document.getElementById("<%=lstDetails.ClientID%>").options.length = 0;
                    if (document.getElementById("<%=ddlSection.ClientID%>") != null)
                        document.getElementById("<%=ddlSection.ClientID%>").selectedIndex = 0;
                    if (document.getElementById("<%=txtCertNo.ClientID%>") != null)
                        document.getElementById("<%=txtCertNo.ClientID%>").value = "";
                    if (document.getElementById("<%=txtCertLimit.ClientID%>") != null)
                        document.getElementById("<%=txtCertLimit.ClientID%>").value = "";
                    if (document.getElementById("<%=txtValidFrom.ClientID%>") != null)
                        document.getElementById("<%=txtValidFrom.ClientID%>").value = "";
                    if (document.getElementById("<%=txtValidTo.ClientID%>") != null)
                        document.getElementById("<%=txtValidTo.ClientID%>").value = "";
                    if (document.getElementById("<%=txtTDSRate.ClientID%>") != null)
                        document.getElementById("<%=txtTDSRate.ClientID%>").value = "";
                    if (document.getElementById("<%=hdnCertDetailID.ClientID%>") != null)
                        document.getElementById("<%=hdnCertDetailID.ClientID%>").value = "-1";
                }
                if (document.getElementById("<%=trhr.ClientID%>") != null) {
                    if (document.getElementById("<%=lblEntryBranch.ClientID%>") != null)
                        document.getElementById("<%=lblEntryBranch.ClientID%>").innerHTML = '';
                    if (document.getElementById("<%=lblEntryDate.ClientID%>") != null)
                        document.getElementById("<%=lblEntryDate.ClientID%>").innerHTML = '';
                }
            }
        }
        function Validation() {
            if (!ValidateLength(document.getElementById("<%=txtNonEmployeeName.ClientID%>"), "NonEmployee Name", 75, true)) return false;
            if (document.getElementById("<%=hdnIsJK.ClientID%>").value == "1") {
                if (trim(document.getElementById("<%=txtReferenceNo.ClientID%>").value) == "") {
                    alert("Specify ReferenceNo");
                    document.getElementById("<%=txtReferenceNo.ClientID%>").focus();
                    return false;
                }
            }
            if (!ValidateDropDown(document.getElementById("<%=cmbState.ClientID %>"), "State")) return false;
            if (!ValidateLength(document.getElementById("<%=txtPinCode.ClientID %>"), "Pincode", 6, false)) return false;
            if (!document.getElementById('<%=chkForm26.ClientID%>').checked && !document.getElementById('<%=chkForm27.ClientID%>').checked
                && !document.getElementById('<%=chkForm27E.ClientID%>').checked) {
                alert("Specify 'List Deductee in'.");
                document.getElementById('<%=chkForm26.ClientID%>').focus();
                return false;
            }
            if (document.getElementById("<%=hdnIsKB.ClientID%>").value == "1" && document.getElementById("<%=hdnIsAB.ClientID%>").value == "1") {
                if (document.getElementById("<%=txtReferenceNo.ClientID%>").value == "") {
                    alert("Specify Customer ID");
                    return false;
                }
            }
            if (document.getElementById("<%=txtEmailAddress.ClientID%>").value != "") {
                if (!ValidateEmail(document.getElementById("<%=txtEmailAddress.ClientID%>"))) return false;
            }
            if (document.getElementById("<%=txtMobileNo.ClientID%>").value != "") {
                if (document.getElementById("<%=txtMobileNo.ClientID%>").value.length != 10 || document.getElementById("<%=txtMobileNo.ClientID%>").value.substring(0, 1) == "0") {
                    alert("Specify Valid Mobile No");
                    return false;
                }
            }
            if (document.getElementById("<%=ddlPan.ClientID%>").value == "PAN") {
                if (!ValidatePAN(document.getElementById("<%=txtPanReference.ClientID%>"), "PAN", 10, true)) return false;
            }
            if (!ValidateNECode(document.getElementById("<%=ddlPan.ClientID%>"), document.getElementById("<%=txtPanReference.ClientID%>"), document.getElementById("<%=cmbNonemployeeCode.ClientID%>"))) return false;
            var additionField = document.getElementById("<%=AdditionalField.ClientID%>");
            if (additionField != null) {
                if (document.getElementById("<%=drpStatus.ClientID %>") != null) {
                    if (!ValidateDropDown(document.getElementById("<%=drpStatus.ClientID %>"), "Status")) return false;
                }
                if (document.getElementById("<%=txtBranchName.ClientID%>") != null) {
                    if (!ValidateBankName(document.getElementById("<%=hdnBankID.ClientID%>"))) return false;
                }
                if (document.getElementById("<%=txtTaxrate.ClientID%>") != null) {
                    if (document.getElementById("<%=txtTaxrate.ClientID%>").value == "" && document.getElementById("<%=txtTaxrateLimit.ClientID%>").value != "") {
                        alert("Concessional tax rate limit specified, specify concessional tax rate.");
                        document.getElementById("<%=txtTaxrate.ClientID%>").focus();
                        return false;
                    }
                    if (document.getElementById("<%=txtTaxrate.ClientID%>").value != "" && Return(document.getElementById("<%=txtTaxrateLimit.ClientID%>").value) == 0) {
                        alert("Concessional tax rate specified, specify concessional tax rate limit.");
                        document.getElementById("<%=txtTaxrateLimit.ClientID%>").focus();
                        return false;
                    }
                }
                if (document.getElementById("<%=drpStatus.ClientID %>") != null) {
                    if (document.getElementById("<%=drpStatus.ClientID %>").selectedIndex != 1 && document.getElementById("<%=cmbNonemployeeCode.ClientID %>").selectedIndex == 0) {
                        alert("Deductee Code is selected as 'Companies'.\n Status should be 'Company'.");
                        document.getElementById("<%=drpStatus.ClientID %>").focus();
                        return false;
                    }
                    if (document.getElementById("<%=drpStatus.ClientID %>").selectedIndex == 1 && document.getElementById("<%=cmbNonemployeeCode.ClientID %>").selectedIndex != 0) {
                        alert("Deductee Code is selected as 'Other Than Companies'.\n Status should be other than 'Company'.");
                        document.getElementById("<%=drpStatus.ClientID %>").focus();
                        return false;
                    }
                }
                if (document.getElementById("<%=ddlPan.ClientID%>").value == "PAN") {
                    pan = document.getElementById("<%=txtPanReference.ClientID%>").value;
                    stRegNo = document.getElementById("<%=txtSTRegNo.ClientID%>");
                    status1 = document.getElementById("<%=drpStatus.ClientID%>");
                    if (stRegNo != null) {
                        if (stRegNo.value.trim().length > 0) {
                            if (stRegNo.value.trim().length == 15) {
                                isValid = true;
                                if (isNaN(stRegNo.value.substring(10, 11)) == false || isNaN(stRegNo.value.substring(11, 12)) == false) { isValid = false; }
                                if (stRegNo.value.substring(0, 10) != pan) { isValid = false; }
                                if (isNaN(stRegNo.value.substring(12, 13)) == true || isNaN(stRegNo.value.substring(13, 14)) == true || isNaN(stRegNo.value.substring(14, 15)) == true) { isValid = false; }
                                if (!isValid) { alert("Service Tax Reg. No. should contain\n   1. First 10 characters should be Deductee PAN.\n   2. 11th and 12th characters should be alphabet.\n   3. 13 to 15th charcters should be number.\n  For Ex(AAAAA1234BAB123)"); stRegNo.focus(); return false; }
                            }
                            else { alert("Service Tax Reg. No. should be 15 characters length."); stRegNo.focus(); return false; }
                        }
                    }
                    if (status1 != null) {
                        if (pan.substring(3, 4) == "C" && status1.value != "1") {
                            alert("PAN given is of 'Company'.\nSelect Status as 'Company'.");
                            return false;
                        }
                        else if (pan.substring(3, 4) == "F" && status1.value != "2") {
                            alert("PAN given is of 'Firms'.\nSelect Status as 'Firms'.");
                            return false;
                        }
                        else if (pan.substring(3, 4) == "L" && status1.value != "4") {
                            alert("PAN given is of 'Local Authority'.\nSelect Status as 'Local Authority'.");
                            return false;
                        }
                        else if (pan.substring(3, 4) == "P" && status1.value != "5") {
                            alert("PAN given is of 'Individual'.\nSelect Status as 'Individual'.");
                            return false;
                        }
                        else if (pan.substring(3, 4) == "H" && status1.value != "6") {
                            alert("PAN given is of 'HUF'.\nSelect Status as 'HUF'.");
                            return false;
                        }
                        else if (pan.substring(3, 4) == "G" && status1.value != "7") {
                            alert("PAN given is of 'Government'.\nSelect Status as 'Government'.");
                            return false;
                        }
                        else if (pan.substring(3, 4) == "T" && status1.value != "8") {
                            alert("PAN given is of 'Trust'.\nSelect Status as 'Trust'.");
                            return false;
                        }
                        else if (pan.substring(3, 4) == "A" && status1.value != "9") {
                            alert("PAN given is of 'Association of Persons'.\nSelect Status as 'Association of Persons'.");
                            return false;
                        }
                        else if (pan.substring(3, 4) == "B" && status1.value != "10") {
                            alert("PAN given is of 'Body of Individuals'.\nSelect Status as 'Body of Individuals'.");
                            return false;
                        }
                        else if (pan.substring(3, 4) == "J" && status1.value != "11") {
                            alert("PAN given is of 'Artificial Judicial'.\nSelect Status as 'Artificial Judicial'.");
                            return false;
                        }
                    }
                }
                if (document.getElementById("<%=hdnIsIB.ClientID%>").value == "1") {
                    var GSTIN = document.getElementById("<%=txtGSTIN.ClientID%>").value.trim();
                    if (GSTIN.length > 0) {
                        if (Number(GSTIN.substring(0, 2)) > 37 || Number(GSTIN.substring(0, 2)) == 0) {
                            alert("First 2 characters of the GSTIN(State code) should be between 01 and 37");
                            return false;
                        }
                        if (!ValidateAssesseePAN(GSTIN.substring(2, 12), "PAN", 10, true)) {
                            alert("PAN specified in GSTIN is Invalid.");
                            return false;
                        }
                        if (GSTIN.substring(13, 14).toUpperCase() != 'Z') {
                            alert("14th character of GSTIN should be \"Z\"");
                            return false;
                        }
                        var pattern = /^([0-9]){2}([a-zA-Z]){5}([0-9]){4}([a-zA-Z]){1}([1-9A-Za-z]){1}([Z]){1}([a-zA-Z0-9]){1}?$/;
                        var matchArray = GSTIN.match(pattern);
                        if (matchArray == null) {
                            alert("Specify valid GSTIN.\nGSTIN should be in the following format.\n1.Characters 1 and 2 represents a valid state code.\n2.Characters 3 through 12 should represent a valid PAN.\n3.Character 13 represents numeric value of entities having same PAN in the state.\n4.Character 14 should always be the alphabet \"Z\" by default.\n5.Character 15 represents a checksum value which can be alphanumeric.");
                            return false;
                        }
                    }

                    if (document.getElementById("<%=hdnConfirm.ClientID%>").value == "Confirm") {
                        return confirm("Only GSTIN can be updated.\nOther details can be updated/deleted by Zonal Office.\nDo you want to continue?");
                    }
                }
            }
            else if (document.getElementById("<%=txtPinCode.ClientID %>").value != "") {
                if (document.getElementById("<%=txtPinCode.ClientID %>").value < 110001) {
                    alert("Pincode is invalid. Should be 110001 or higher");
                    return false;
                }
            }
            if (isNaN(document.getElementById("<%=txtPhoneNumber.ClientID %>").value)) {
                alert("Phone No. should be Numbers only");
                return false;
            }

            if (isNaN(document.getElementById("<%=txtMobileNo.ClientID %>").value)) {
                alert("Mobile No. should be Numbers only");
                return false;
            }
            if (isNaN(document.getElementById("<%=txtPinCode.ClientID %>").value)) {
                alert("Pincode should be Numbers only");
                return false;
            }
        }
        function CopyPanToReg(object) {
            var additionField = document.getElementById("<%=AdditionalField.ClientID%>");
            if (additionField != null) {
                if (document.getElementById("<%=txtSTRegNo.ClientID%>") != null)
                    document.getElementById("<%=txtSTRegNo.ClientID%>").value = object.value;
            }
        }
        function SetPanStatus() {
            if (document.getElementById("<%=hdnVarifiedPan.ClientID%>").value != "-1") {
                if (document.getElementById("<%=hdnVarifiedPan.ClientID%>").value != document.getElementById("<%=txtPanReference.ClientID%>").value) {
                    document.getElementById("<%=txtPANStatus.ClientID%>").value = "";
                }
            }
        }
        function ChangeControlProperty() {
            var additionField = document.getElementById("<%=AdditionalField.ClientID%>");

            var txtPANStatus = document.getElementById("<%=txtPANStatus.ClientID%>");
            if (txtPANStatus != null)
                ddocument.getElementById("<%=txtPANStatus.ClientID%>").value = "";

            document.getElementById("<%=txtPanReference.ClientID%>").value = "";
            if (document.getElementById("<%=ddlPan.ClientID%>").value == "PAN") {
                document.getElementById("<%=txtPanReference.ClientID%>").style.backgroundColor = "#E5E5E5";
                document.getElementById("<%=txtPanReference.ClientID%>").disabled = false;
                if (additionField != null) {
                    if (document.getElementById("<%=txtSTRegNo.ClientID%>") != null)
                        document.getElementById("<%=txtSTRegNo.ClientID%>").disabled = false;
                }
            }
            else {
                document.getElementById("<%=txtPanReference.ClientID%>").style.backgroundColor = "White";
                document.getElementById("<%=txtPanReference.ClientID%>").disabled = true;
                if (additionField != null) {
                    if (document.getElementById("<%=txtSTRegNo.ClientID%>") != null) {
                        document.getElementById("<%=txtSTRegNo.ClientID%>").style.backgroundColor = "White";
                        document.getElementById("<%=txtSTRegNo.ClientID%>").value = '';
                        document.getElementById("<%=txtSTRegNo.ClientID%>").disabled = true;
                    }
                }
            }
        }
        function ValidateNECode(pan, panReference, code) {
            if (pan.selectedIndex == 0) {
                if ((code.selectedIndex == 1 && panReference.value.charAt(3) == "C") || (code.selectedIndex == 0 && panReference.value.charAt(3) != "C")) {
                    if (confirm("If 4th character of Deductee's PAN is 'C',code should be selected as 'Companies'.\n" +
                                "If 4th character of Deductee's PAN is other than 'C',code should be selected as 'Other than Companies'.\n" +
                                "Do you want to continue?")) {
                        return true;
                    }
                    else { code.focus(); return false; }
                }
                else { return true; }
            }
            else return true;
        }
        function OnDelete(obj) { return confirm(obj); }
        function DisableCheckBoxes() {
            document.getElementById('<%=chkForm26.ClientID%>').disabled = true;
            document.getElementById('<%=chkForm27.ClientID%>').disabled = true;
        }
        function EnableCheckBoxes() {
            document.getElementById('<%=chkForm26.ClientID%>').disabled = false;
            document.getElementById('<%=chkForm27.ClientID%>').disabled = false;
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
        function SetStatus() {
            var hdnSearch = document.getElementById("<%=hdnSearch.ClientID%>");
            if (hdnSearch.value == "0") { hdnSearch.value = "1"; }
            else {
                hdnSearch.value = "0";
            }
            SetSearchPanelVisibility();
        }
        function ConfirmDuplicatePan() {
            if (confirm("Given Pan is already mentioned for some deductee(s). \n Do you want to continue ?"))
                __doPostBack('<%=nonEmployeeUpdatePanel.UniqueID%>', 'SaveNonEmployee');
            else return false;
        }
        function CheckDeducteePAN() {
            var txtPAN = document.getElementById("<%=txtPanReference.ClientID%>");
            var ddlPAN = document.getElementById("<%=ddlPan.ClientID%>");
            if (txtPAN.value == "" && ddlPAN.selectedIndex == 0) { alert("Specify PAN to Validate"); return false; }
            if (ddlPAN.selectedIndex > 0) {
                alert("PAN other than PANAPPLIED, PANINVALID and PANNOTAVBL will be verified.\nSpecify PAN if available.");
                return false;
            }
            return ValidatePAN(txtPAN, "PAN", 10, false)
        }
        function EnableDisableSave() { document.getElementById("<%=btnSave.ClientID%>").disabled = true; }
        function GetBankNameValue(source, eventArgs) {
            var content = eventArgs.get_value();
            var arr = new Array();
            arr = content.split(';');
            document.getElementById("<%=hdnBankID.ClientID%>").value = arr[0];
        }
        function ValidateBankName(bankID) {
            if (document.getElementById("<%=txtBankName.ClientID%>").value != "") {
                if (bankID.value == "-1") { alert("Specify valid Bank Name."); document.getElementById("<%=txtBankName.ClientID%>").focus(); return false; }
            }
            return true;
        }
        function ClearBankName() {
            if (event.keyCode == 13 || event.keyCode == 37 || event.keyCode == 38 || event.keyCode == 39 || event.keyCode == 40) { }
            else { document.getElementById("<%=hdnBankID.ClientID%>").value = "-1"; }
        }
        function CheckDeductee(id) {
            if (document.getElementById("<%=hdnDeducteeID.ClientID%>").value == "-1") { alert("Please select a Deductee."); return false; }
            if (document.getElementById("<%=hdnName.ClientID%>").value.trim() != document.getElementById("<%=txtNonEmployeeName.ClientID%>").value.trim()) {
                alert("Deductee name does not exists. Please select a valid Deductee.");
                document.getElementById("<%=txtNonEmployeeName.ClientID%>").focus();
                return false;
            }
            if (id == 1) {
                var txtPAN = document.getElementById("<%=txtPanReference.ClientID%>");
                var ddlPAN = document.getElementById("<%=ddlPan.ClientID%>");
                if (txtPAN.value == "" && ddlPAN.selectedIndex == 0) { alert("Specify PAN to Validate"); return false; }
                if (ddlPAN.selectedIndex > 0) {
                    alert("PAN other than PANAPPLIED, PANINVALID and PANNOTAVBL will be verified.\nSpecify PAN if available.");
                    return false;
                }

                return ValidatePAN(txtPAN, "PAN", 10, false)
            }
        }
        function Return(tempValue) {
            if (isNaN(tempValue)) { return tempValue = "0"; }
            else if (tempValue == "" || tempValue == "undefined") { return 0; }
            else if (tempValue == "0.00" || tempValue == "0.0000") { return 0; }
            else { return eval(parseFloat(tempValue).toString()); }
        }
        function ValidateSection() {
            var section = document.getElementById("<%=ddlSection.ClientID%>");
            var certNo = document.getElementById("<%=txtCertNo.ClientID%>");
            var certLimit = document.getElementById("<%=txtCertLimit.ClientID%>");
            var validFrom = document.getElementById("<%=txtValidFrom.ClientID%>");
            var validTo = document.getElementById("<%=txtValidTo.ClientID%>");
            var tdsRate = document.getElementById("<%=txtTDSRate.ClientID%>");
            if (Return(section.value) == -1) { alert("Select section."); section.focus(); return false; }
            if (Return(section.value) > -1) {
                if (trim(certNo.value) == "") { alert("Specify Certificate number."); certNo.focus(); return false; }
                else {
                    if (section.value == 15) {
                        if (certNo.value.trim().length != 10) { alert("Certificate number should be of length 10."); certNo.focus(); return false; }
                        var pattern = /^[g-hG-H]{1}[0-9]{9}$/;
                        var matchArray = certNo.value.match(pattern);
                        if (matchArray == null) {
                            pattern = /^[A-Z0-9]{10}$/;
                            matchArray = certNo.value.match(pattern);
                        }
                        if (matchArray == null) {
                            alert("Specify valid certificate number.\n\nFor '197 Certificate No.' format allows alphabets and numbers only.\nFor 15G/15H submitted format is G123456789 or H123456789.");
                            certNo.focus();
                            return false;
                        }
                    }
                    else { if (!ValidateCertificateNumber(certNo, "Certificate number", 10, true)) return false; }
                }
                if (Return(certLimit.value) == 0) { alert("Specify Certificate limit."); certLimit.focus(); return false; }
                if (trim(validFrom.value) == "") { alert("Specify From Date."); validFrom.focus(); return false; }
                if (trim(validTo.value) == "") { alert("Specify To Date."); validTo.focus(); return false; }
                var finYear = document.getElementById("<%=hdnFinYear.ClientID%>").value;
                var from = validFrom.value.split('/', 3);
                var to = validTo.value.split('/', 3);
                var fromDate = new Date(from[2], from[1] - 1, from[0]);
                var toDate = new Date(to[2], to[1] - 1, to[0]);
                var startDate = new Date(finYear, 03, 01);
                var endDate = new Date(Return(finYear) + 1, 02, 31);
                if (fromDate < startDate || fromDate > endDate) { alert("Valid From Date should be within the Financial Year."); validFrom.focus(); return false; }
                if (toDate < startDate || toDate > endDate) { alert("Valid To Date should be within the Financial Year."); validTo.focus(); return false; }
                if (fromDate > toDate) { alert("Valid From Date should be less than Valid To Date."); validTo.focus(); return false; }
                if (Return(certLimit.value) == 0) { alert("Specify Certificate limit."); certLimit.focus(); return false; }
                if (trim(tdsRate.value) == "") { alert("Specify TDS Rate as per Certificate."); tdsRate.focus(); return false; }
            }
            return true;
        }
        function ClearData() {
            document.getElementById("<%=ddlSection.ClientID%>").disabled = false;
            document.getElementById("<%=ddlSection.ClientID%>").selectedIndex = 0;
            document.getElementById("<%=txtCertNo.ClientID%>").value = "";
            document.getElementById("<%=txtCertLimit.ClientID%>").value = "";
            document.getElementById("<%=txtValidFrom.ClientID%>").value = "";
            document.getElementById("<%=txtValidTo.ClientID%>").value = "";
            document.getElementById("<%=txtTDSRate.ClientID%>").value = "";
            document.getElementById("<%=lstDetails.ClientID%>").selectedIndex = -1;
        }
        function SetColor(obj) {
            document.getElementById("<%=txtCertNo.ClientID%>").style.backgroundColor = obj.selectedIndex > 0 ? "#E5E5E5" : "White";
            document.getElementById("<%=txtCertLimit.ClientID%>").style.backgroundColor = obj.selectedIndex > 0 ? "#E5E5E5" : "White";
            document.getElementById("<%=txtValidFrom.ClientID%>").style.backgroundColor = obj.selectedIndex > 0 ? "#E5E5E5" : "White";
            document.getElementById("<%=txtValidTo.ClientID%>").style.backgroundColor = obj.selectedIndex > 0 ? "#E5E5E5" : "White";
            document.getElementById("<%=txtTDSRate.ClientID%>").style.backgroundColor = obj.selectedIndex > 0 ? "#E5E5E5" : "White";
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentPlaceHolderBody" runat="Server">
    <asp:UpdatePanel ID="nonEmployeeUpdatePanel" runat="server" OnLoad="nonEmployeeUpdatePanel_Load">
        <ContentTemplate>
            <asp:HiddenField ID="hdnDeducteeID" runat="server" Value="-1" />
            <asp:HiddenField ID="hdnNonEmployeeID" runat="server" Value="-1" />
            <asp:HiddenField ID="hdnMaxPanReference" runat="server" />
            <asp:HiddenField ID="hdnPanReference" runat="server" />
            <asp:HiddenField ID="selectedPageSize" runat="server" />
            <asp:HiddenField ID="selectedPageIndex" runat="server" />
            <asp:HiddenField ID="hdnSearch" runat="server" Value="1" />
            <asp:HiddenField ID="hdnIsSearchActive" runat="server" Value="0" />
            <asp:HiddenField ID="hdnDefaultPan" runat="server" Value="" />
            <asp:HiddenField ID="hdnBankID" runat="server" Value="-1" />
            <asp:HiddenField ID="hdnConfirm" runat="server" Value="-1" />
            <asp:HiddenField ID="hdnisSB" runat="server" Value="0" />
            <asp:HiddenField ID="hdnIsJK" runat="server" Value="0" />
            <asp:HiddenField ID="hdnName" runat="server" />
            <asp:HiddenField ID="hdnCertDetailID" runat="server" Value="-1" />
            <asp:HiddenField ID="hdnFinYear" runat="server" Value="" />
            <asp:HiddenField ID="hdnDefaultSettingsPAN" runat="server" Value="" />
            <asp:HiddenField ID="hdnEditcert" runat="server" Value="0" />
            <asp:HiddenField ID="hdnIsKB" runat="server" Value="0" />
            <asp:HiddenField ID="hdnIsIB" runat="server" Value="0" />
            <asp:HiddenField ID="hdnIsAB" runat="server" Value="0" />
            <asp:HiddenField ID="hdnVarifiedPan" runat="server" Value="-1" />
            <table class="nTbl" id="grdDeductee">
                <tr>
                    <td>
                        <table cellpadding="0" cellspacing="0">
                            <tr>
                                <td rowspan="0" valign="top">
                                    <table class="eCol">
                                        <tr>
                                            <td class="vHCol">
                                                Serial Number
                                            </td>
                                            <td>
                                                <asp:TextBox runat="server" ID="txtNonEmployeeID" CssClass="txtBPL" ReadOnly="true"
                                                    Style="background-color: #d5dadd; color: Black;"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="vHCol">
                                                Name
                                            </td>
                                            <td class="iCol" style="width: 195px">
                                                <table width="100%" cellpadding="0px" cellspacing="0px">
                                                    <tr>
                                                        <td width="50px" style="padding-top: 1px;">
                                                            <asp:DropDownList ID="cmbSalutation" runat="server" Width="50px" TabIndex="1" CssClass="dropDownList">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtNonEmployeeName" runat="server" CssClass="txtBML" TabIndex="2"
                                                                AutoComplete="Off" Width="145px" MaxLength="75" onkeypress="return ValidateDelimiter(this,event);"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr id="trContactPerson" runat="server">
                                            <td class="vHCol">
                                                Contact Person Name
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtContactName" runat="server" CssClass="txtBPL" MaxLength="75"
                                                    Width="195px" AutoComplete="Off" onkeypress="return ValidateDelimiter(this,event);"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr id="trContactDesignation" runat="server">
                                            <td>
                                                Designation
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtPersonDesgn" runat="server" MaxLength="30" CssClass="txtBPL"
                                                    ToolTip="Contact Person designation" Width="195px" AutoComplete="Off" onkeypress="return ValidateDelimiter(this,event);"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="vHCol">
                                                Flat/Door/Block No.
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtAddress1" runat="server" CssClass="txtBPL" TabIndex="3" MaxLength="25"
                                                    Width="195px" AutoComplete="Off" onkeypress="return ValidateDelimiter(this,event);"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="vHCol">
                                                Name of Building
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtAddress2" runat="server" CssClass="txtBPL" TabIndex="4" MaxLength="25"
                                                    Width="195px" AutoComplete="Off" onkeypress="return ValidateDelimiter(this,event);"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="vHCol">
                                                Street / Road Name
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtAddress3" runat="server" CssClass="txtBPL" TabIndex="5" MaxLength="25"
                                                    Width="195px" AutoComplete="Off" onkeypress="return ValidateDelimiter(this,event);"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="vHCol">
                                                Area
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtAddress4" runat="server" CssClass="txtBPL" TabIndex="6" MaxLength="25"
                                                    Width="195px" AutoComplete="Off" onkeypress="return ValidateDelimiter(this,event);"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="vHCol">
                                                City
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtCity" runat="server" MaxLength="25" TabIndex="7" CssClass="txtBPL"
                                                    Width="195px" AutoComplete="Off" onkeypress="return ValidateDelimiter(this,event);"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="vHCol">
                                                State
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="cmbState" runat="server" Width="200px" TabIndex="8" Font-Size="9"
                                                    CssClass="mCBs">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="vHCol">
                                                Pincode
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtPinCode" runat="server" CssClass="txtBPL" TabIndex="9" MaxLength="6"
                                                    Width="195px" AutoComplete="Off" onkeypress="return ValidateForOnlyNos(event);"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td valign="top">
                                    <table class="eCol">
                                        <tr id="tblEnableReference" runat="server">
                                            <td class="vHCol">
                                                <asp:Label ID="lblReferenceNo" runat="server" Text="Reference No./Emp No."></asp:Label>
                                            </td>
                                            <td class="iCol">
                                                <asp:TextBox ID="txtReferenceNo" runat="server" TabIndex="10" CssClass="txtBPL" MaxLength="20"
                                                    Width="195px"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="vHCol">
                                                List Deductee In
                                            </td>
                                            <td style="padding-left: 1px">
                                                <table>
                                                    <tr>
                                                        <td style="padding-left: 0px">
                                                            <asp:CheckBox ID="chkForm26" runat="server" Text="26Q" Checked="true" TabIndex="10" />
                                                        </td>
                                                        <td style="padding-left: 15px">
                                                            <asp:CheckBox ID="chkForm27" runat="server" Text="27Q" Checked="true" TabIndex="11" />
                                                        </td>
                                                        <td style="padding-left: 15px">
                                                            <asp:CheckBox ID="chkForm27E" runat="server" Text="27EQ" Checked="true" TabIndex="11" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="vHCol">
                                                Phone
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtPhoneNumber" runat="server" CssClass="txtBPL" MaxLength="15"
                                                    Width="195px" AutoComplete="Off" TabIndex="12" onkeypress="return ValidateForOnlyNos(event);"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr id="trMobile" runat="server">
                                            <td class="vHCol">
                                                Mobile No.
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtMobileNo" runat="server" CssClass="txtBPL" MaxLength="10" Width="195px"
                                                    AutoComplete="Off" TabIndex="12" onkeypress="return ValidateForOnlyNos(event);"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr id="trFAX" runat="server">
                                            <td class="vHCol">
                                                FAX
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtFAX" runat="server" CssClass="txtBPL" MaxLength="10" Width="195px"
                                                    AutoComplete="Off" onkeypress="return ValidateForOnlyNos(event);"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="vHCol">
                                                Email Address
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtEmailAddress" CssClass="txtBPL" MaxLength="75" runat="server"
                                                    AutoComplete="Off" TabIndex="13" Width="195px"> </asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="vHCol">
                                                PAN
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlPan" runat="server" Width="200px" BackColor="#E5E5E5" TabIndex="14"
                                                    OnChange="ChangeControlProperty();" Font-Size="9" CssClass="mdropDownList">
                                                    <asp:ListItem Text="PAN" Value="PAN"></asp:ListItem>
                                                    <asp:ListItem Text="PANAPPLIED" Value="PANAPPLIED"></asp:ListItem>
                                                    <asp:ListItem Text="PANINVALID" Value="PANINVALID"></asp:ListItem>
                                                    <asp:ListItem Text="PANNOTAVBL" Value="PANNOTAVBL"></asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="vHCol">
                                                PAN Reference
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtPanReference" CssClass="txtBPL" MaxLength="10" runat="server"
                                                    Width="195px" AutoComplete="Off" TabIndex="15" BackColor="#E5E5E5" onBlur="ConvertToUC(this);CopyPanToReg(this);"
                                                    onkeypress="return ValidateForAlphaNumeric(event);" onkeyup="SetPanStatus();"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Button ID="btnPANStatus" runat="server" Text="Verify PAN" CssClass="cmnBtn"
                                                    OnClientClick="return CheckDeductee(1);" OnClick="btnPANStatus_Click" />
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtPANStatus" runat="server" Enabled="false" CssClass="txtboxRO"
                                                    Width="195"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="vHCol">
                                                Code
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="cmbNonemployeeCode" runat="server" Width="200px" TabIndex="16"
                                                    Font-Size="9" CssClass="mCBs">
                                                    <asp:ListItem Text="Companies" Value="1" />
                                                    <asp:ListItem Text="Other Than Companies" Value="2" />
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                            </td>
                                            <td align="left">
                                                <asp:CheckBox ID="chkIsTransporter" runat="server" Checked="false" Text="Is Transporter"
                                                    TabIndex="17" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <table cellpadding="0" cellspacing="0">
                            <tr>
                                <td id="AdditionalField" runat="server">
                                    <div style="padding-bottom: 3px;">
                                        <div class="dialog" style="width: 730px">
                                            <div class="dHeader">
                                                Additional Details</div>
                                            <div style="padding: 1px; border-top: solid 1px gray">
                                                <table id="BankDetails" runat="server">
                                                    <tr>
                                                        <td style="padding-left: 1px">
                                                            <asp:Label runat="server" ID="lblBAN" Width="138px" Text="Benificiary Acc No." />
                                                        </td>
                                                        <td style="padding-left: 1px">
                                                            <asp:TextBox ID="txtBAN" runat="server" MaxLength="18" CssClass="txtBPL" TabIndex="18"
                                                                Width="195px" onBlur="ConvertToUC(this);"></asp:TextBox>
                                                        </td>
                                                        <td style="padding-left: 10px">
                                                            <asp:Label runat="server" ID="lblIFSC" Width="130px" Text="IFSC Code" />
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtIFSCCode" runat="server" MaxLength="15" CssClass="txtBPL" TabIndex="19"
                                                                Width="195px" onBlur="ConvertToUC(this);"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr id="trBank" runat="server">
                                                        <td>
                                                            Bank Name
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtBankName" runat="server" TabIndex="20" Width="195px" CssClass="txtBPL"
                                                                onkeyup="ClearBankName()" MaxLength="75"></asp:TextBox>
                                                            <cc1:AutoCompleteExtender ID="autoCompleteExtender" runat="server" MinimumPrefixLength="2"
                                                                ServicePath="~/WebServices/AutoCompleteService.asmx" TargetControlID="txtBankName"
                                                                CompletionInterval="700" EnableCaching="false" CompletionSetCount="20" DelimiterCharacters=""
                                                                ShowOnlyCurrentWordInCompletionListItem="true" FirstRowSelected="True" ServiceMethod="GetBankNamesAutoComplete"
                                                                OnClientItemSelected="GetBankNameValue">
                                                            </cc1:AutoCompleteExtender>
                                                        </td>
                                                        <td width="160x" style="padding-left: 10px">
                                                            Branch Name
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtBranchName" runat="server" Width="195px" TabIndex="21" MaxLength="50"
                                                                CssClass="txtBPL"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr id="trCons" runat="server">
                                                        <td width="160x">
                                                            Concessional Tax Rate
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtTaxrate" runat="server" Width="195px" onkeypress="return numeralsOnly(this, event,2,3,0,1);"
                                                                TabIndex="22" MaxLength="5" CssClass="txtBPL"></asp:TextBox>
                                                        </td>
                                                        <td style="padding-left: 10px;" width="200px">
                                                            Concessional Tax Rate Limit
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtTaxrateLimit" runat="server" Width="195px" onkeypress="return numeralsOnly(this, event,11,2,0,1);"
                                                                TabIndex="23" CssClass="txtBPL"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr id="trStatus" runat="server">
                                                        <td class="vHCol">
                                                            Status
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList ID="drpStatus" runat="server" Width="185px" BackColor="#E5E5E5"
                                                                CssClass="mCBs" TabIndex="24" Font-Size="9">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td style="padding-left: 10px;" width="200px">
                                                            Service Tax Reg. No.
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtSTRegNo" runat="server" Width="195px" onBlur="ConvertToUC(this);"
                                                                MaxLength="15" onkeypress="return ValidateForAlphaNumeric(event);" TabIndex="23"
                                                                CssClass="txtBPL"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr id="trMakeTDS" runat="server">
                                                        <td width="200px">
                                                            GSTIN
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtGSTIN" runat="server" Width="195px" onBlur="ConvertToUC(this);"
                                                                MaxLength="15" TabIndex="23" CssClass="txtBPL" ToolTip="GSTIN should be in the following format
1.Characters 1 and 2 represents a valid state code.
2.Characters 3 through 12 should represent a valid PAN.
3.Character 13 represents numeric value of entities having same PAN in the state.
4.Character 14 should always be the alphabet 'Z' by default.
5.Character 15 represents a checksum value which can be alphanumeric."></asp:TextBox>
                                                        </td>
                                                        <td colspan="2" style="padding-left: 15px;" align="right">
                                                            <asp:CheckBox ID="chkMakeTDS" runat="server" Text="Make TDS from first payment" TabIndex="25" />
                                                        </td>
                                                    </tr>
                                                </table>
                                                <table>
                                                    <tr id="trhr" runat="server" visible="false">
                                                        <td colspan="2">
                                                            <hr />
                                                        </td>
                                                    </tr>
                                                    <tr runat="server" id="rowCertDetails">
                                                        <td colspan="2">
                                                            <table>
                                                                <tr>
                                                                    <td>
                                                                        Section
                                                                    </td>
                                                                    <td colspan="3">
                                                                        <asp:DropDownList ID="ddlSection" runat="server" Width="580px" CssClass="dropDownList"
                                                                            onchange="SetColor(this); return false">
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        Certificate number
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtCertNo" runat="server" Width="195px" CssClass="txtBPL" MaxLength="10"
                                                                            onBlur="ConvertToUC(this);">
                                                                        </asp:TextBox>
                                                                    </td>
                                                                    <td style="padding-left: 10px;">
                                                                        Certificate Limit
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtCertLimit" runat="server" Width="195px" CssClass="txtBPR" onkeypress="return numeralsOnly(this, event,11,2,0,1);">
                                                                        </asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        Valid From Date
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtValidFrom" runat="server" Width="195px" CssClass="txtBPR" onBlur="setDateFormat(this);">
                                                                        </asp:TextBox>
                                                                    </td>
                                                                    <td style="padding-left: 10px;">
                                                                        Valid To Date
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtValidTo" runat="server" Width="195px" CssClass="txtBPR" onBlur="setDateFormat(this);">
                                                                        </asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="lbl" runat="server" Text="TDS Rate as per Certificate"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtTDSRate" runat="server" Width="195px" CssClass="txtBPR" onkeypress="return numeralsOnly(this, event,2,3,0,1);">
                                                                        </asp:TextBox>
                                                                    </td>
                                                                    <td style="padding-left: 10px;" colspan="2">
                                                                        <asp:Button ID="btnAdd" runat="server" Text="Add" CssClass="cmnBtn" OnClick="btnAdd_Click"
                                                                            OnClientClick="return ValidateSection();" />&nbsp;
                                                                        <asp:Button ID="btnRemove" runat="server" Text="Remove" CssClass="cmnBtn" OnClientClick="return RemoveAlert();"
                                                                            OnClick="btnRemove_Click" />
                                                                        &nbsp;
                                                                        <asp:Button ID="btnClearData" runat="server" Text="Clear" CssClass="cmnBtn" OnClick="btnClearData_Click"
                                                                            OnClientClick="ClearData()" />
                                                                    </td>
                                                                </tr>
                                                                <tr style="padding-top: 20px">
                                                                    <td colspan="4">
                                                                        <div id='hello' style="overflow: auto; width: 720px; height: auto;">
                                                                            <asp:ListBox ID="lstDetails" runat="server" Font-Names="Verdana" Font-Size="Small"
                                                                                Width="900px" AutoPostBack="true" OnSelectedIndexChanged="lstDetails_SelectedIndexChanged">
                                                                            </asp:ListBox>
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr id="trEntry" runat="server" visible="false">
                                                        <td style="width: 50%">
                                                            Entered By:&nbsp
                                                            <asp:Label ID="lblEntryBranch" runat="server" Text=""></asp:Label>
                                                        </td>
                                                        <td style="width: 50%">
                                                            Entered Date:&nbsp
                                                            <asp:Label ID="lblEntryDate" runat="server" Text=""></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr style="padding-top: 20px">
                    <td>
                        <table cellpadding="0" cellspacing="0">
                            <tr>
                                <td style="padding-right: 5px">
                                    <asp:Button ID="btnNew" runat="server" Text="New" TabIndex="26" OnClientClick="OnNewRecord();SetSearchPanelVisibility();return true;"
                                        CssClass="cmnBtn" OnClick="btnNew_Click"></asp:Button>
                                </td>
                                <td>
                                    <asp:Button ID="btnSave" runat="server" Text="Save" TabIndex="27" CssClass="cmnBtn"
                                        OnClientClick="return Validation();" OnClick="btnSave_Click"></asp:Button>
                                </td>
                                <td style="padding-left: 5px">
                                    <asp:Button ID="btnOpenSearch" runat="server" Text="Search" TabIndex="28" OnClientClick="SetStatus();return false;"
                                        CssClass="cmnBtn" />
                                </td>
                                <td style="padding-left: 10px">
                                    <asp:LinkButton ID="lnkPurchaseOrder" runat="server" Text="Purchase Order" Font-Underline="true"
                                        OnClientClick="return CheckDeductee(2);" Font-Bold="true" OnClick="lnkPurchaseOrder_Click"></asp:LinkButton>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <table>
                <tr>
                    <td>
                        <asp:Panel ID="pnlSearch" runat="server" BorderStyle="Dashed" BorderWidth="1" CssClass="searchPanel">
                            <table>
                                <tr>
                                    <td>
                                        <table>
                                            <tr>
                                                <td style="width: 30px">
                                                    Name
                                                </td>
                                                <td style="width: 200px">
                                                    <asp:TextBox ID="txtSearchName" CssClass="txtBPL" Width="200px" TabIndex="22" runat="server"></asp:TextBox>
                                                </td>
                                                <td style="width: 30px; padding-left: 5px;">
                                                    PAN
                                                </td>
                                                <td style="width: 130px">
                                                    <asp:TextBox ID="txtSearchPAN" CssClass="txtBPL" Width="130px" TabIndex="23" runat="server"></asp:TextBox>
                                                </td>
                                                <td style="width: 80px; padding-left: 5px;" id="tdlblSearchRefereneno" runat="server">
                                                    <asp:Label ID="lblRefNoSearch" runat="server" Text="Reference No."></asp:Label>
                                                </td>
                                                <td style="width: 10px" id="tdtxtSearchRefereneno" runat="server">
                                                    <asp:TextBox ID="txtSearchReferenceNo" CssClass="txtBPL" Width="200px" TabIndex="23"
                                                        runat="server"></asp:TextBox>
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
                                                    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="cmnBtn" TabIndex="24"
                                                        OnClick="btnSearch_Click" />
                                                </td>
                                                <td>
                                                    <asp:Button ID="btnShowAll" runat="server" Text="Show All" CssClass="cmnBtn" TabIndex="25"
                                                        OnClientClick="return ValidateLoadAll(0)" OnClick="btnShowAll_Click" />
                                                </td>
                                                <td>
                                                    <asp:Button ID="btnClose" runat="server" Text="Close" Width="80px" OnClientClick="SetStatus();"
                                                        CssClass="cmnBtn" TabIndex="27" OnClick="btnClose_Click" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Panel ID="navPanel" CssClass="navPanel" runat="server" ScrollBars="Horizontal"
                            Width="730px" Visible="false">
                            <asp:Repeater ID="rptNonEmployee" runat="server" OnItemCommand="rptEmployee_ItemCommand"
                                OnItemDataBound="rptNonEmployee_ItemDataBound">
                                <HeaderTemplate>
                                    <table id="NavTable" border="0" cellspacing="0" cellpadding="0">
                                        <tr bgcolor="#EEEEEE">
                                            <th colspan="2">
                                                Action
                                            </th>
                                            <th>
                                                <asp:Label runat="server" ID="lblSerNo" Width="80px" Text="Serial No." />
                                            </th>
                                            <th>
                                                <asp:Label runat="server" ID="lblName" Width="250px" Text="Name" />
                                            </th>
                                            <th runat="server" id="headerReferenceNo">
                                                <asp:Label runat="server" ID="lblReferenceNo" Width="250px" Text="Reference No" />
                                            </th>
                                            <th>
                                                <asp:Label ID="Label1" Text="Flat/Door/Block No" runat="server" Width="200px"></asp:Label>
                                            </th>
                                            <th>
                                                <asp:Label ID="Label2" Text="Name of Building" runat="server" Width="200px"></asp:Label>
                                            </th>
                                            <th>
                                                <asp:Label ID="Label3" Text="Street/Road Name" runat="server" Width="200px"></asp:Label>
                                            </th>
                                            <th>
                                                <asp:Label ID="Label4" Text="Area" runat="server" Width="200px"></asp:Label>
                                            </th>
                                            <th>
                                                <asp:Label ID="lblCity" Text="City" runat="server" Width="150px"></asp:Label>
                                            </th>
                                            <th>
                                                <asp:Label runat="server" ID="lblState" Width="200px" Text="State" />
                                            </th>
                                            <th>
                                                <asp:Label ID="lblPAN" Text="PAN" runat="server" Width="150px"></asp:Label>
                                            </th>
                                            <th>
                                                <asp:Label ID="Label5" Text="Pan Reference" runat="server" Width="150px"></asp:Label>
                                            </th>
                                            <th style="display: none;">
                                            </th>
                                            <th style="border-right-style: none;">
                                                <asp:Label ID="Label6" Text="Code" runat="server" Width="150px"></asp:Label>
                                            </th>
                                        </tr>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <tr bgcolor="white">
                                        <td id="tdEdit" runat="server">
                                            <asp:LinkButton ID="hlnkEdit" runat="server" TabIndex="34" CommandName="LoadData"
                                                Text="Edit" CommandArgument='<%# Eval("DeducteeID") %>'></asp:LinkButton>
                                        </td>
                                        <td id="tdDelete" runat="server">
                                            <asp:LinkButton ID="hlnkDelete" runat="server" TabIndex="35" CommandName="DeleteData"
                                                Text="Delete" CommandArgument='<%# Eval("DeducteeID") %>'></asp:LinkButton>
                                        </td>
                                        <td>
                                            <%#Eval("SrNo") %>
                                        </td>
                                        <td>
                                            <%#Eval("Name") %>
                                        </td>
                                        <td runat="server" id="colReference">
                                            <%#Eval("ReferenceNo") %>
                                        </td>
                                        <td>
                                            <%#Eval("Address1") %>
                                        </td>
                                        <td>
                                            <%# Eval("Address2") %>
                                        </td>
                                        <td>
                                            <%#Eval("Address3") %>
                                        </td>
                                        <td>
                                            <%# Eval("Address4") %>
                                        </td>
                                        <td>
                                            <%#Eval("Address5") %>
                                        </td>
                                        <td>
                                            <%# Eval("StateName") %>
                                        </td>
                                        <td>
                                            <%#Eval("PAN") %>
                                        </td>
                                        <td>
                                            <%#Eval( "PanReference") %>
                                        </td>
                                        <td style="display: none;">
                                            <asp:Label runat="server" ID="lblIsDedUsedInCorr" Text='<%#Eval("IsDeducteeUsedInCorrection")%>' />
                                        </td>
                                        <td>
                                            <%#Eval("DeducteeCode")%>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                                <FooterTemplate>
                                    </table>
                                </FooterTemplate>
                            </asp:Repeater>
                        </asp:Panel>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <table id="tblPagination" runat="server" style="padding-right: 0px; display: none"
                            align="right">
                            <%--<table style="padding-right: 0px; margin-right: -2px; margin-bottom: -3px">--%>
                            <tr>
                                <td style="padding: 0px 0px 0px 0px">
                                    <asp:Label ID="ASPxLabel4" runat="server" Text="Records per page : " Font-Size="X-Small" />
                                </td>
                                <td>
                                    <td style="width: 50px; padding-top: 2px;">
                                        <asp:DropDownList ID="cmbGoTo" runat="server" Style="width: 50px; height: 15px; float: left;"
                                            OnSelectedIndexChanged="cmbGoTo_SelectedIndexChanged" TabIndex="36" AutoPostBack="true"
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
                                </td>
                                <td>
                                    <asp:Label ID="lblGridStatus" runat="server" Style="float: left;" Text="" Font-Size="X-Small" />
                                </td>
                                <td>
                                    <asp:Button ID="btnFirst" runat="server" Text="&lt;&lt;" Font-Names="Arial" Font-Overline="False"
                                        Font-Size="X-Small" OnClick="btnFirst_Click" CssClass="navButton" Enabled="False"
                                        TabIndex="37"></asp:Button>
                                </td>
                                <td>
                                    <asp:Button ID="btnPrevious" runat="server" Text="&lt;" Font-Names="Arial" Font-Overline="False"
                                        Font-Size="X-Small" OnClick="btnPrevious_Click" CssClass="navButton" Enabled="False"
                                        TabIndex="38"></asp:Button>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtGoToPage" runat="server" Text="1" CssClass="navTextBox" AutoPostBack="True"
                                        OnTextChanged="txtGoToPage_TextChanged" MaxLength="5" TabIndex="39"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:Button ID="btnNext" runat="server" Text="&gt;" Font-Names="Arial" Font-Overline="False"
                                        Font-Size="X-Small" OnClick="btnNext_Click" CssClass="navButton" TabIndex="40">
                                    </asp:Button>
                                </td>
                                <td>
                                    <asp:Button ID="btnLast" runat="server" Text="&gt;&gt;" Font-Names="Arial" Font-Overline="False"
                                        Font-Size="X-Small" OnClick="btnLast_Click" CssClass="navButton" TabIndex="41">
                                    </asp:Button>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <asp:Button ID="btnRefresh" runat="server" Text="" CssClass="cmnBtn" BackColor="Transparent"
                BorderColor="Transparent" Width="0px" Visible="false" OnClick="btnRefresh_Click" />
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
