<%@ page title="" language="C#" masterpagefile="~/SaralTDS.master" autoeventwireup="true" inherits="ChallanDetails, App_Web_challandetails.aspx.66e8bc22" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../JavaScript/Validations.js" type="text/javascript" language="javascript"></script>
    <script language="javascript" type="text/javascript">
        function SetSectionID() { document.getElementById("<%=hdnSectionID.ClientID%>").value = document.getElementById("<%=cmbNatureOfPayment.ClientID%>").value; }
        function OnDelete() { return confirm("Are you sure you want to delete ?"); }
        function UpdateCheckBoxStatus() {
            var hdnIsChecked = document.getElementById("<%=hdnIsChecked.ClientID %>");
            var hdnIsCalculate = document.getElementById("<%=hdnIsCalculate.ClientID %>");
            hdnIsChecked.value = "False";
            hdnIsCalculate.value = "False";
        }
        function SelectAllCheckBox() {
            for (i = 0; i < document.getElementById("<%=rptrTD.ClientID%>").all.length; i++) {
                if (document.getElementById("<%=rptrTD.ClientID%>").all[i].type == 'checkbox') {
                    document.getElementById("<%=rptrTD.ClientID%>").all[i].checked = true;
                    UpdateCheckBoxStatus();
                }
            }
            return false;
        }
        function UnSelectAllCheckBox() {
            for (i = 0; i < document.getElementById("<%=rptrTD.ClientID%>").all.length; i++) {
                if (document.getElementById("<%=rptrTD.ClientID%>").all[i].type == 'checkbox') {
                    document.getElementById("<%=rptrTD.ClientID%>").all[i].checked = false;
                    UpdateCheckBoxStatus();
                }
            }
            return false;
        }
        function OnNewRecord() {
            document.getElementById("<%=hdnTotalDeducted.ClientID%>").value = "0";
            document.getElementById("<%=lblAvalAmount.ClientID%>").innerText = "";
            document.getElementById("<%=lblAvalAmount.ClientID%>").innerHTML = "";
            document.getElementById("<%=hdnBankCode.ClientID%>").value = "";
            document.getElementById("<%=hdnBankID.ClientID%>").value = "-1";
            document.getElementById("<%=hdnChallanID.ClientID %>").value = "-1";
            document.getElementById("<%=txtChallanSerialNo.ClientID %>").readOnly = false;
            document.getElementById("<%=txtChallanSerialNo.ClientID %>").value = "";
            document.getElementById("<%=txtChallanSerialNo.ClientID %>").readOnly = true;
            document.getElementById("<%=txtIncomeTax.ClientID %>").value = "";
            document.getElementById("<%=txtSurchargePaid.ClientID %>").value = "";
            document.getElementById("<%=txtEducationCess.ClientID %>").value = "";
            document.getElementById("<%=txtInterestPaid.ClientID %>").value = "";
            document.getElementById("<%=txtPenaltyPaid.ClientID %>").value = "";
            document.getElementById("<%=txtOtherAmount.ClientID %>").value = "";
            document.getElementById("<%=txtTotalAmount.ClientID %>").value = "";
            document.getElementById("<%=cmbNatureOfPayment.ClientID%>").selectedIndex = 0;
            document.getElementById("<%=cmbNatureOfPayment.ClientID%>").disabled = false;
            document.getElementById("<%=cmbModeOfPayment.ClientID%>").selectedIndex = 0;
            document.getElementById("<%=txtBankChallanNo.ClientID %>").value = "";
            document.getElementById("<%=dateeditPaidDate.ClientID %>").value = "";
            document.getElementById("<%=txtChequeNumber.ClientID %>").value = "";
            document.getElementById("<%=dateeditChequeDate.ClientID %>").value = "";
            document.getElementById("<%=txtDrawnOn.ClientID %>").value = "";
            document.getElementById("<%=txtBankCode.ClientID %>").value = "";
            document.getElementById("<%=hdnIsChallanLinked.ClientID%>").value = "False";
            document.getElementById("<%=txtTVReceiptNo.ClientID%>").value = "";
            if (document.getElementById("<%=ddlMinorHead.ClientID%>") != null) {
                document.getElementById("<%=ddlMinorHead.ClientID%>").style.backgroundColor = "White";
            }
            var defaultModeOfpayment = document.getElementById("<%=hdnDefaultModeOfPayment.ClientID %>");
            if (defaultModeOfpayment.value != "-1") {
                document.getElementById("<%=cmbModeOfPayment.ClientID%>").value = defaultModeOfpayment.value;
            }
            document.getElementById("<%=rdlNonCompanies.ClientID%>").disabled = document.getElementById("<%=hdnFormType.ClientID %>").value == "Form24";
            document.getElementById("<%=rdlCompanies.ClientID%>").disabled = document.getElementById("<%=hdnFormType.ClientID %>").value == "Form24";

            EnableControls();
            document.getElementById("<%=hdnClearSession.ClientID%>").value = "0";
            if (document.getElementById("<%=txtFee.ClientID%>") != null)
                document.getElementById("<%=txtFee.ClientID%>").value = "";
            if (document.getElementById("<%=ddlMinorHead.ClientID%>") != null)
                document.getElementById("<%=ddlMinorHead.ClientID%>").value = "-1";
        }
        function CheckEnableMakepayment() {
            if (confirm("Are you Sure you want to Save Challan?")) {
                __doPostBack("updatepanelChallan", "MakePayment");
            }
        }
        function ValidateChequeDetails() {
            var finYear = document.getElementById("<%=hdnFinYear.ClientID%>").value;
            var now = new Date();
            var finYearStartDate = new Date(eval(finYear) - 1, 3, 1);
            var finYearEndDate = new Date(eval(finYear) + 1, 5, 1);
            var bankChallanNo = document.getElementById("<%=txtBankChallanNo.ClientID %>");
            var chequeNo = document.getElementById("<%=txtChequeNumber.ClientID%>");
            var challanpaidDate = document.getElementById("<%=dateeditPaidDate.ClientID %>");
            var chequepaidDate = document.getElementById("<%=dateeditChequeDate.ClientID %>");
            var challanDate = new Date(parseInt(challanpaidDate.value.substring(6, 10), 10), parseInt(challanpaidDate.value.substring(3, 5), 10) - 1, parseInt(challanpaidDate.value.substring(0, 2), 10));
            var chequeDate = new Date(parseInt(chequepaidDate.value.substring(6, 10), 10), parseInt(chequepaidDate.value.substring(3, 5), 10) - 1, parseInt(chequepaidDate.value.substring(0, 2), 10));
            if (bankChallanNo.value == "") {
                if (!confirm("Do you want to save Challan Details without\nBank Challan Number? eReturn will be Invalid.")) {
                    bankChallanNo.focus();
                    return false;
                }
            }
            else if (bankChallanNo.value.length > 5) {
                alert("Bank challan number should be less than or equal to 5 characters");
                bankChallanNo.focus();
                return false;
            }
            if (challanpaidDate.value == "") {
                if (!confirm("Do you want to save Challan Details without\nBank Challan Date? eReturn will be Invalid.")) {
                    challanpaidDate.focus();
                    return false;
                }
            }
            else if (challanDate < finYearStartDate) {
                alert("Bank Challan Date cannot be prior to 01/04/" + (eval(finYear) - 1) + ".");
                challanpaidDate.focus();
                return false;
            }
            else if (challanDate > now) {
                alert("Challan Date cannot be future date.");
                challanpaidDate.focus();
                return false;
            }
            if (ValidateLength(chequeNo, "Cheque Number", 14, true) == false) return false;
            if (chequepaidDate.value == "") {
                alert("Specify Cheque Date.");
                chequepaidDate.focus();
                return false;
            }
            else if (chequeDate > challanDate) {
                alert("Cheque Date should not exceed Challan Paid Date.");
                chequepaidDate.focus();
                return false;
            }
            if (ValidateLength(document.getElementById("<%=txtDrawnOn.ClientID %>"), "Cheque Drawn On", 50, true) == false) return false;
            if (document.getElementById("<%=hdnBankID.ClientID%>").value == "-1") {
                alert("Specify valid BSR Code.");
                document.getElementById("<%=txtBankCode.ClientID%>").focus();
                return false;
            }
            return true;
        }
        function ValidateCashDetails() {
            var finYear = document.getElementById("<%=hdnFinYear.ClientID%>").value;
            var now = new Date();
            var finYearStartDate = new Date(eval(finYear) - 1, 3, 1);
            var bankChallanNo = document.getElementById("<%=txtBankChallanNo.ClientID %>");
            var challanpaidDate = document.getElementById("<%=dateeditPaidDate.ClientID %>");
            var challanDate = new Date(parseInt(challanpaidDate.value.substring(6, 10), 10), parseInt(challanpaidDate.value.substring(3, 5), 10) - 1, parseInt(challanpaidDate.value.substring(0, 2), 10));
            if (bankChallanNo.value == "") {
                if (!confirm("Do you want to save Challan Details without\nBank Challan Number? eReturn will be Invalid.")) {
                    bankChallanNo.focus();
                    return false;
                }
            }
            else if (bankChallanNo.value.length > 5) {
                alert("Bank challan number should be less than or equal to 5 characters");
                bankChallanNo.focus();
                return false;
            }
            if (challanpaidDate.value == "") {
                if (!confirm("Do you want to save Challan Details without\nBank Challan Date? eReturn will be Invalid.")) {
                    challanpaidDate.focus();
                    return false;
                }
            }
            else if (challanDate < finYearStartDate) {
                alert("Bank Challan Date cannot be prior to 01/04/" + (eval(finYear) - 1) + ".");
                challanpaidDate.focus();
                return false;
            }
            else if (challanDate > now) {
                alert("Challan Date cannot be future date.");
                challanpaidDate.focus();
                return false;
            }
            if (document.getElementById("<%=hdnBankID.ClientID%>").value == "-1") {
                alert("Specify valid BSR Code.");
                document.getElementById("<%=txtBankCode.ClientID%>").focus();
                return false;
            }
            return true;
        }
        function ValidateTransferVoucherDetails() {
            var finYear = document.getElementById("<%=hdnFinYear.ClientID%>").value;
            var now = new Date();
            var finYearStartDate = new Date(eval(finYear), 3, 1);
            var finYearEndDate = new Date(eval(finYear) + 1, 5, 1);
            var bankChallanNo = document.getElementById("<%=txtBankChallanNo.ClientID %>");
            var challanpaidDate = document.getElementById("<%=dateeditPaidDate.ClientID %>");
            var challanDate = new Date(parseInt(challanpaidDate.value.substring(6, 10), 10), parseInt(challanpaidDate.value.substring(3, 5), 10) - 1, parseInt(challanpaidDate.value.substring(0, 2), 10));
            if (bankChallanNo.value.length == 0) {
                alert("Specify 5 digit Voucher No.");
                bankChallanNo.focus();
                return false;
            }
            if (bankChallanNo.value.length != 5) {
                alert("Voucher No should be of 5 digits.");
                bankChallanNo.focus();
                return false;
            }

            if (challanpaidDate.value == "") {
                alert("Specify Voucher Date");
                challanpaidDate.focus();
                return false;
            }
            else if (challanDate < finYearStartDate) {
                alert("Bank Challan Date cannot be prior to 01/04/" + (eval(finYear)) + ".");
                challanpaidDate.focus();
                return false;
            }
            else if (challanDate > now) {
                alert("Voucher Date cannot be future date.");
                challanpaidDate.focus();
                return false;
            }
            else {
                var month = challanDate.getMonth();
                var quarter = document.getElementById("<%=hdnQuarter.ClientID%>").value;
                var lastDateofMonth = new Date(parseInt(Return(quarter) == 4 ? Return(finYear) + 1 : finYear, 10), month + 1, 0);
                if (challanDate > lastDateofMonth || challanDate < lastDateofMonth) {
                    alert("Transfer Voucher Date must be last date of month.");
                    return false;
                }
            }
            if (ValidateLength(document.getElementById("<%=txtTVReceiptNo.ClientID %>"), "Form 24G Receipt No.", 7, true) == false) return false;
            var receiptNo = document.getElementById("<%=txtTVReceiptNo.ClientID %>").value;
            var str = receiptNo.substring(0, 1);
            receiptNo = receiptNo.substring(1, receiptNo.length);
            var num = 0;
            for (var i = 0; i < receiptNo.length; i++) { num = Return(num) + Return(receiptNo.substring(i, i + 1)); }
            num = num % 7;
            if (Return(num) != Return(str)) { return confirm("'Form 24G Receipt No.' is Invalid.\neReturn will not be valid.\n\nDo you want to continue?"); }
            return true;
        }
        function Validation() {
            var finYear = document.getElementById("<%=hdnFinYear.ClientID%>").value;
            var isChallanLinked = document.getElementById("<%=hdnIsChallanLinked.ClientID%>");
            var cmbNatureOfPayment = document.getElementById("<%=cmbNatureOfPayment.ClientID%>");
            var txtTotalAmount = document.getElementById("<%=txtTotalAmount.ClientID %>");
            var sectionID = document.getElementById("<%=hdnSectionID.ClientID%>").value;
            var hdnIsIB = document.getElementById("<%=hdnIsIB.ClientID%>").value;
            var cmbModeOfPayment = document.getElementById("<%=cmbModeOfPayment.ClientID%>");
            var bankChallanNo = document.getElementById("<%=txtBankChallanNo.ClientID %>");
            if (document.getElementById("<%=hdnIsQuarterLocked.ClientID%>").value == "1") {
                alert("Quarter is locked, so can't modify.");
                return false;
            }
            if (isChallanLinked.value == 'True' && sectionID.value != cmbNatureOfPayment.value) {
                alert('Challan Is Linked To Deductions');
                cmbNatureOfPayment.value = sectionID.value;
                return false;
            }
            if (bankChallanNo.value == "281") {
                alert("Check the Challan No. entered \n It Should be a 5-digit number \n as indicated in Taxpayer Counterfoil. \n\n Note: \n 1. It is the last 5 digits of CIN. \n 2. It is also identified as 'Challan Sequence No'.");
                bankChallanNo.focus();
                return false;
            }
            if (Number(txtTotalAmount.value) == 0) {
                alert("Total Amount Paid can't be Nil.");
                document.getElementById("<%=txtIncomeTax.ClientID %>").focus();
                return false;
            }
            else if (Number(txtTotalAmount.value) > 999999999999) {
                alert("Total Amount Paid can't exceed 999999999999.");
                return false;
            }
            var section = document.getElementById("<%=cmbNatureOfPayment.ClientID%>")[document.getElementById("<%=cmbNatureOfPayment.ClientID%>").selectedIndex].text;
            if (section.indexOf("4LD") != -1) {
                if (!Validate4LDSectionBasedOnDate()) return false;
            }
            if (section.indexOf("4LC") != -1) {
                if (!Validate4LCSectionBasedOnDate()) return false;
            }
            if (Return(document.getElementById("<%=txtFee.ClientID%>").value) > 0) {
                var challanPaidDate = document.getElementById("<%=dateeditPaidDate.ClientID %>");
                var challanDate = new Date(parseInt(challanPaidDate.value.substring(6, 10), 10), parseInt(challanPaidDate.value.substring(3, 5), 10) - 1, parseInt(challanPaidDate.value.substring(0, 2), 10));
                var feeDate = new Date(2012, 06, 01);
                if (challanDate < feeDate) {
                    alert("Fee u/s 234E applicable only from 1st July 2012.");
                    return false;
                }
            }
            if (ValidateDropDown(document.getElementById("<%=cmbNatureOfPayment.ClientID%>"), "Nature Of Payment") == false) return false;
            if (Return(document.getElementById("<%=cmbModeOfPayment.ClientID%>").value) == 2) {
                var ddlMinorHead = document.getElementById("<%=ddlMinorHead.ClientID%>");
                if (ddlMinorHead != null && Return(ddlMinorHead.value) == -1 && Return(document.getElementById("<%=hdnFinYear.ClientID%>").value) > 2012) {
                    alert("Type of Payment is mandatory if payment is through 'Cash/ePayment' option.");
                    ddlMinorHead.focus();
                    return false;
                }
            }
            if (hdnIsIB == "1") {
                if (document.getElementById("<%=hdnFormType.ClientID%>").value == "Form26") {
                    if (!(sectionID == "5" || sectionID == "3")) {
                        alert("Section should be only 193 or 194A.");
                        return false;
                    }
                }
                else if (document.getElementById("<%=hdnFormType.ClientID %>").value == "Form27" && sectionID != 17) {
                    alert("Section should be only 195.");
                    return false;
                }
            }
            if (ValidateDropDown(cmbModeOfPayment, "Mode Of Payment") == false) return false;
            switch (cmbModeOfPayment.value) {
                case "1":
                    if (!ValidateChequeDetails()) return false;
                    break;
                case "2":
                    if (!ValidateCashDetails()) return false;
                    break;
                case "3":
                    if (!ValidateTransferVoucherDetails()) return false;
                    break;
            }
            if (Return(finYear) > 2012 && document.getElementById("<%=cmbModeOfPayment.ClientID%>").value == "1") {
                if (!confirm("Cheque as Mode of Payment is not applicable in FY 2013-14.\neReturn will be invalid.\n\nDo you want to continue?")) return false;
            }

            if (document.getElementById("<%=hdnFormType.ClientID%>").value == "Form24") {
                var sectionID = document.getElementById("<%=hdnSectionID.ClientID%>").value;
                if ((document.getElementById("<%=hdnDeductorStatus.ClientID%>").value == 2) && (Return(sectionID) == 1 || Return(sectionID) == 25)) {
                    return confirm("If you are making entry for payment relating to " + (Return(sectionID) == 1 ? "State" : "Central") + " Govt Employee pension\n Click OK else Cancel");
                }
                else if (document.getElementById("<%=hdnDeductorStatus.ClientID%>").value == 1 && Return(sectionID) == 2) {
                    return confirm("Given Section is not valid for selected Deductor Type.\nAre you sure you want to continue?");
                }
            }

            if (Return(document.getElementById("<%=hdnTotalDeducted.ClientID%>").value) > Return(document.getElementById("<%=txtTotalAmount.ClientID%>").value)) {
                if (document.getElementById("<%=hdnIsSIB.ClientID%>").value == "1") {
                    alert("Challan amount is less than the Total deducted amount of linked deduction(s).\nSo cannot save challan.");
                    return false;
                }
                else {
                    alert("Challan amount is less than the Total deducted amount of linked deduction(s).\nSo cannot save challan.");
                    return false;
                }
            }
            return true;
        }
        function Validate4LDSectionBasedOnDate() {
            var date = new Date(2013, 06, 01);
            var paymentDate = document.getElementById("<%=dateeditPaidDate.ClientID%>");
            var date1 = paymentDate.value.split('/', 3);
            var creditedDate = new Date(date1[2], date1[1], date1[0]);
            if (creditedDate < date) {
                alert("Section '194LD' is Applicable from '01/06/2013' to '31/05/2015'.\nSpecify the correct date in Challan Date.");
                return false;
            }
            return true;
        }
        function Validate4LCSectionBasedOnDate() {
            var date = new Date(2012, 07, 01);
            var paymentDate = document.getElementById("<%=dateeditPaidDate.ClientID%>");
            var date1 = paymentDate.value.split('/', 3);
            var creditedDate = new Date(date1[2], date1[1], date1[0]);
            if (creditedDate < date) {
                alert("Section '194LC' is Applicable from '01/07/2012' to '31/05/2015'.\nSpecify the correct date in Challan Date.");
                return false;
            }
            return true;
        }
        function ClearBSRCode() {
            if (event.keyCode == 13 || event.keyCode == 37 || event.keyCode == 38 || event.keyCode == 39 || event.keyCode == 40) {
            }
            else {
                document.getElementById("<%=hdnBankID.ClientID%>").value = "-1";
            }
        }
        function CalculateTotalAmount() {
            var txtTotalAmount = document.getElementById("<%=txtTotalAmount.ClientID %>");
            var txtIncomeTax = document.getElementById("<%=txtIncomeTax.ClientID %>");
            var txtSurchargePaid = document.getElementById("<%=txtSurchargePaid.ClientID %>");
            var txtEducationCess = document.getElementById("<%=txtEducationCess.ClientID %>");
            var txtInterestPaid = document.getElementById("<%=txtInterestPaid.ClientID %>");
            var txtPenaltyPaid = document.getElementById("<%=txtPenaltyPaid.ClientID%>");
            var txtOtherAmount = document.getElementById("<%=txtOtherAmount.ClientID %>");
            var fee = document.getElementById("<%=txtFee.ClientID%>") != null ? Return(document.getElementById("<%=txtFee.ClientID%>").value) : 0;
            var totalamount = Number(txtIncomeTax.value) + Number(txtSurchargePaid.value) + Number(txtEducationCess.value) + Number(txtInterestPaid.value) + Number(txtPenaltyPaid.value) + Number(txtOtherAmount.value) + Number(fee);
            txtTotalAmount.value = totalamount;
            if (totalamount == 0) {
                txtTotalAmount.value = '';
            }
        }
        function EnableControls() {
            var rowMinorHead = document.getElementById("<%=rowMinorHead.ClientID%>");
            var ddlMinorHead = document.getElementById("<%=ddlMinorHead.ClientID%>");
            var cmbModeOfPayment = document.getElementById("<%=cmbModeOfPayment.ClientID %>");
            var lblChallanNo = document.getElementById("<%=lblChallan.ClientID %>");
            var txtBankChallanNo = document.getElementById("<%=txtBankChallanNo.ClientID %>");
            var challanDate = document.getElementById("<%=dateeditPaidDate.ClientID %>");
            var lblChallanDate = document.getElementById("<%=lblChallanDate.ClientID %>");
            var chequeNumber = document.getElementById("<%=txtChequeNumber.ClientID %>");
            var chequeDate = document.getElementById("<%=dateeditChequeDate.ClientID %>");
            var DrawnOn = document.getElementById("<%=txtDrawnOn.ClientID %>");
            var rowbsr = document.getElementById("<%=rowbsr.ClientID%>");
            var txtBankCode = document.getElementById("<%=txtBankCode.ClientID%>");
            var rowReceiptNo = document.getElementById("<%=rowReceiptNo.ClientID%>");
            var rowChequeDate = document.getElementById("<%=rowChequeDate.ClientID%>");
            var rowChequeNumber = document.getElementById("<%=rowChequeNumber.ClientID%>");
            var rowDrawnOn = document.getElementById("<%=rowDrawnOn.ClientID%>");
            var txtTVReceiptNo = document.getElementById("<%=txtTVReceiptNo.ClientID%>");
            var finYear = document.getElementById("<%=hdnFinYear.ClientID%>").value;
            var hdnBankID = document.getElementById("<%=hdnBankID.ClientID%>");
            if (cmbModeOfPayment != null) {
                switch (cmbModeOfPayment.value) {
                    case "1":
                        ddlMinorHead.style.backgroundColor = "White";
                        lblChallanNo.innerHTML = "Challan No.";
                        lblChallanDate.innerHTML = "Challan Date";
                        txtBankChallanNo.readOnly = false;
                        txtBankChallanNo.style.backgroundColor = "#E5E5E5";
                        challanDate.style.backgroundColor = "#E5E5E5";
                        chequeNumber.style.backgroundColor = "#E5E5E5";
                        chequeDate.style.backgroundColor = "#E5E5E5";
                        DrawnOn.style.backgroundColor = "#E5E5E5";
                        txtBankCode.style.backgroundColor = "#E5E5E5";
                        txtTVReceiptNo.style.backgroundColor = "White";
                        rowReceiptNo.style.display = 'none';
                        rowbsr.style.display = '';
                        break;
                    case "2":
                        ddlMinorHead.style.backgroundColor = "#E5E5E5";
                        lblChallanNo.innerHTML = "Challan No.";
                        lblChallanDate.innerHTML = "Challan Date";
                        txtBankChallanNo.style.backgroundColor = "#E5E5E5";
                        challanDate.style.backgroundColor = "#E5E5E5";
                        chequeNumber.style.backgroundColor = "White";
                        chequeDate.style.backgroundColor = "White";
                        DrawnOn.style.backgroundColor = "White";
                        txtTVReceiptNo.style.backgroundColor = "White";
                        rowReceiptNo.style.display = 'none';
                        rowbsr.style.display = '';
                        rowChequeDate.style.display = 'none';
                        rowChequeNumber.style.display = 'none';
                        rowDrawnOn.style.display = 'none';
                        break;
                    case "3":
                        ddlMinorHead.style.backgroundColor = "White";
                        lblChallanNo.innerHTML = "Voucher No.";
                        lblChallanDate.innerHTML = "Voucher Date";
                        txtBankChallanNo.style.backgroundColor = "#E5E5E5";
                        challanDate.style.backgroundColor = "#E5E5E5";
                        chequeNumber.style.backgroundColor = "White";
                        chequeDate.style.backgroundColor = "White";
                        DrawnOn.style.backgroundColor = "White";
                        txtTVReceiptNo.style.backgroundColor = "#E5E5E5";
                        rowbsr.style.display = 'none';
                        rowReceiptNo.style.display = '';
                        txtBankCode.value = "";
                        hdnBankID.value = "-1";
                        break;
                    default:
                        ddlMinorHead.style.backgroundColor = "White";
                        lblChallanNo.innerHTML = "Challan No.";
                        lblChallanDate.innerHTML = "Challan Date";
                        challanDate.style.backgroundColor = "White";
                        txtBankChallanNo.style.backgroundColor = "White";
                        chequeNumber.style.backgroundColor = "White";
                        chequeDate.style.backgroundColor = "White";
                        DrawnOn.style.backgroundColor = "White";
                        txtBankCode.style.backgroundColor = "White";
                        txtTVReceiptNo.style.backgroundColor = "White";
                        rowReceiptNo.style.display = '';
                        rowbsr.style.display = '';
                        txtBankCode.value = "";
                        break;
                }
            }
        }
        function EnableControls11() {
            var lblChallan = document.getElementById("<%=lblChallan.ClientID %>");
            var lblChallanDate = document.getElementById("<%=lblChallanDate.ClientID %>");
            var txtBankChallanNo = document.getElementById("<%=txtBankChallanNo.ClientID %>");
            var dateeditPaidDate = document.getElementById("<%=dateeditPaidDate.ClientID %>");
            var txtChequeNumber = document.getElementById("<%=txtChequeNumber.ClientID %>");
            var dateeditChequeDate = document.getElementById("<%=dateeditChequeDate.ClientID %>");
            var txtDrawnOn = document.getElementById("<%=txtDrawnOn.ClientID %>");
            var cmbModeOfPayment = document.getElementById("<%=cmbModeOfPayment.ClientID %>");
            var cmbBankCode = document.getElementById("<%=txtBankCode.ClientID %>");
            var finYear = document.getElementById("<%=hdnFinYear.ClientID%>").value;
            var txtTVReceiptNo = document.getElementById("<%=txtTVReceiptNo.ClientID %>");
            var lblTVReceiptNo = document.getElementById("<%=lblTVReceiptNo.ClientID %>");
            var ddlMinorHead = document.getElementById("<%=ddlMinorHead.ClientID%>");
            var bsrCode = document.getElementById("<%=rowbsr.ClientID%>");
            var rowMinorHead = document.getElementById("<%=rowMinorHead.ClientID%>");
            if (cmbModeOfPayment.value == "2") {
                lblChallanDate.innerHTML = "Challan Date";
                lblChallan.innerHTML = "Challan No";
                txtBankChallanNo.readOnly = false;
                txtBankChallanNo.style.backgroundColor = "#E5E5E5";
                dateeditPaidDate.readOnly = false;
                dateeditPaidDate.style.backgroundColor = "#E5E5E5";
                txtChequeNumber.value = "";
                txtChequeNumber.disabled = true;
                txtChequeNumber.style.backgroundColor = "White"
                dateeditChequeDate.value = "";
                dateeditChequeDate.disabled = true;
                dateeditChequeDate.style.backgroundColor = "White"
                if (ddlMinorHead != null)
                    ddlMinorHead.style.backgroundColor = "#E5E5E5";
                txtDrawnOn.value = "";
                txtDrawnOn.disabled = true;
                txtDrawnOn.style.backgroundColor = "White"
                cmbBankCode.value = "";
                cmbBankCode.disabled = false;
                cmbBankCode.style.backgroundColor = "#E5E5E5"
                txtTVReceiptNo.value = "";
                txtTVReceiptNo.disabled = true;
                txtTVReceiptNo.style.backgroundColor = "White"
                lblTVReceiptNo.disabled = true;
                bsrCode.style.display = '';
            }
            else if (cmbModeOfPayment.value == "1") {
                lblChallanDate.innerHTML = "Challan Date";
                lblChallan.innerHTML = "Challan No";
                txtBankChallanNo.readOnly = false;
                txtBankChallanNo.style.backgroundColor = "#E5E5E5";
                dateeditPaidDate.readOnly = false;
                dateeditPaidDate.style.backgroundColor = "#E5E5E5";
                if (ddlMinorHead != null)
                    ddlMinorHead.style.backgroundColor = "White";
                txtChequeNumber.disabled = false;
                txtChequeNumber.style.backgroundColor = "#E5E5E5";
                dateeditChequeDate.disabled = false;
                dateeditChequeDate.style.backgroundColor = "#E5E5E5";
                txtDrawnOn.disabled = false;
                txtDrawnOn.style.backgroundColor = "#E5E5E5";
                cmbBankCode.value = "";
                cmbBankCode.disabled = false;
                cmbBankCode.style.backgroundColor = "#E5E5E5"
                txtTVReceiptNo.disabled = true;
                txtTVReceiptNo.style.backgroundColor = "White"
                lblTVReceiptNo.disabled = true;
                bsrCode.style.display = '';
            }
            else if (cmbModeOfPayment.value == "3") {
                lblChallanDate.innerHTML = "Voucher Date";
                lblChallan.innerHTML = "Voucher No";
                txtBankChallanNo.readOnly = false;
                txtBankChallanNo.style.backgroundColor = "#E5E5E5";
                dateeditPaidDate.readOnly = false;
                dateeditPaidDate.style.backgroundColor = "#E5E5E5";
                if (ddlMinorHead != null)
                    ddlMinorHead.style.backgroundColor = "White";
                txtChequeNumber.disabled = true;
                txtChequeNumber.style.backgroundColor = "White"
                dateeditChequeDate.disabled = true;
                dateeditChequeDate.style.backgroundColor = "White"
                txtDrawnOn.disabled = true;
                txtDrawnOn.style.backgroundColor = "White";
                cmbBankCode.value = "";
                cmbBankCode.disabled = true;
                cmbBankCode.style.backgroundColor = "White"
                bsrCode.style.display = 'none';
                if (finYear > "2012") {
                    rowMinorHead.style.display = 'none'
                }
                if (finYear != "2009") {
                    txtBankChallanNo.style.backgroundColor = "#E5E5E5";
                    txtTVReceiptNo.disabled = false;
                    txtTVReceiptNo.style.backgroundColor = "White"
                    lblTVReceiptNo.disabled = false;
                }
                else {
                    txtTVReceiptNo.disabled = true;
                    txtTVReceiptNo.style.backgroundColor = "#E5E5E5";
                    lblTVReceiptNo.disabled = true;
                }
            }
            else {
                lblChallanDate.innerHTML = "Challan Date";
                lblChallan.innerHTML = "Challan No";
                txtBankChallanNo.readOnly = false;
                txtBankChallanNo.value = "";
                txtBankChallanNo.style.backgroundColor = "White";
                dateeditPaidDate.readOnly = false;
                dateeditPaidDate.value = "";
                dateeditPaidDate.style.backgroundColor = "White";
                txtChequeNumber.value = "";
                txtChequeNumber.disabled = false;
                txtChequeNumber.style.backgroundColor = "White";
                dateeditChequeDate.disabled = false;
                dateeditChequeDate.value = "";
                dateeditChequeDate.style.backgroundColor = "White";
                txtDrawnOn.value = "";
                txtDrawnOn.disabled = false;
                txtDrawnOn.style.backgroundColor = "White";
                cmbBankCode.text = "";
                cmbBankCode.disabled = false;
                cmbBankCode.style.backgroundColor = "White"
                txtTVReceiptNo.value = "";
                txtTVReceiptNo.disabled = true;
                txtTVReceiptNo.style.backgroundColor = "White"
                lblTVReceiptNo.disabled = true;
                bsrCode.style.display = '';
                rowMinorHead.style.display = '';
            }
        }
        function ValidateView(input) {
            if (input == "From Ded") {
                document.getElementById("<%=hdnChallanID.ClientID %>").value = "-1";
            }
            else if (input == "Link Ded") {
                if (document.getElementById("<%=hdnChallanID.ClientID%>").value == "-1") {
                    alert("Select Challan.");
                    return false;
                }
            }
            return true;
        }
        function LoadPopUpAmount() {
            text = document.getElementById("<%=hdnFormType.ClientID %>").value == "Form27E" ? "Collection(s)" : "Deduction(s)";
            var btnText = document.getElementById("<%=btnDeductionLink.ClientID %>");
            var isSectionSame = document.getElementById("<%=hdnIsSectionSame.ClientID %>");
            var hdnIsChecked = document.getElementById("<%=hdnIsChecked.ClientID %>");
            var hdnIsCalculate = document.getElementById("<%=hdnIsCalculate.ClientID %>");
            var isSB = document.getElementById("<%=hdnisSB.ClientID %>");
            var hdnISDeducteeCodeSame = document.getElementById("<%=hdnISDeducteeCodeSame.ClientID %>");
            var deductionAmount = document.getElementById("<%=txtFromDedTaxDeduction.ClientID%>");
            if (btnText.value == "Create") {
                if (hdnIsChecked.value == "True") {
                    if (hdnIsCalculate.value == "True") {
                        if (isSectionSame.value != "-1" && isSectionSame.value != "0") {
                            if (isSB.value == "True" && hdnISDeducteeCodeSame.value == "-1") {
                                alert("Select same Deductee Code to Link.");
                                return false;
                            }
                            else if (Return(deductionAmount.value) == 0) {
                                alert("Total amount should be greater than zero.");
                                return false;
                            }
                        }
                        else if (isSectionSame.value == "0") {
                            alert("Select " + text + " to Link.");
                            return false;
                        }
                        else {
                            alert("Select " + text + " of same Section to Link.");
                            return false;
                            if (isSB.value == "True" && hdnISDeducteeCodeSame.value == "-1") {
                                alert("Deduction(s) of both Companies & Non-Companies are selected.\n Select either Companies  or Non-Companies deduction(s) to proceed to further. ");
                                return false;
                            }
                        }
                    }
                    else {
                        alert("Calculate the Link Total before Create the challan");
                        return false;
                    }
                }
                else {
                    alert("Calculate the Link Total before Create the challan");
                    return false;
                }
            }
            else if (btnText.value == "Link") {
                var txtLinkDedTaxDeduction = document.getElementById("<%=txtLinkDedTaxDeduction.ClientID %>");
                var txtFromDedTaxDeduction = document.getElementById("<%=txtFromDedTaxDeduction.ClientID %>");
                if (hdnIsChecked.value == "True") {
                    if (hdnIsCalculate.value == "True") {
                        if (isSectionSame.value != "-1" && isSectionSame.value != "0") {
                            if (Number(txtLinkDedTaxDeduction.value) < Number(txtFromDedTaxDeduction.value)) {
                                text = document.getElementById("<%=hdnFormType.ClientID %>").value == "Form27E" ? "Collection(s)" : "Deduction(s)";
                                if (document.getElementById("<%=hdnIsSIB.ClientID%>").value == "1") {
                                    alert("Total deducted amount of selected " + text + " is more than the Challan amount.\nSo cannot Link deductions.");
                                    return false;
                                }
                                else {
                                    alert("Total of selected " + text + " is more than the\nChallan amount for Linking. So cannot Link deductions.")
                                    return false;
                                }
                            }
                            return true;
                        }
                        else if (isSectionSame.value == "0") {
                            alert("Select " + text + " to Link.");
                            return false;
                        }
                        else {
                            alert("Select Same Sections to link " + text);
                            return false;
                        }
                    }
                    else {
                        alert("Calculate the Link Total before Create the challan");
                        return false;
                    }
                }
                else {
                    alert("Calculate the Link Total before Create the challan");
                    return false;
                }
            }
        }
        function ValidateSerialNumber() {
            if (ValidateDropDown(document.getElementById("<%=cmbSerialNumber.ClientID%>"), "Serial Number") == false) return false;
            else {
                return true;
            }
        }
        function SetSearchPanelVisibility() {
            var btnSearch = document.getElementById("<%=btnOpenSearch.ClientID%>");
            var pnlSearch = document.getElementById("<%=pnlSearch.ClientID%>");
            if (btnSearch == null) {
                document.getElementById("<%=hdnSearch.ClientID%>").value = "0";
                return;
            }
            else {
                if (document.getElementById("<%=hdnSearch.ClientID%>").value == "0") {
                    btnSearch.style.display = '';
                    pnlSearch.style.display = 'none';
                }
                else {
                    btnSearch.style.display = 'none';
                    pnlSearch.style.display = '';
                    document.getElementById("<%=txtSrchITAmtFrm.ClientID%>").focus();
                }
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
        function FormatSearch() {
            var txtSrchITAmtFrm = document.getElementById("<%=txtSrchITAmtFrm.ClientID %>");
            var txtSrchITAmtTo = document.getElementById("<%=txtSrchITAmtTo.ClientID %>");
            var txtSrchSurchargeFrm = document.getElementById("<%=txtSrchSurchargeFrm.ClientID %>");
            var txtSrchSurchargeTo = document.getElementById("<%=txtSrchSurchargeTo.ClientID %>");
            var txtSrchEduCessFrm = document.getElementById("<%=txtSrchEduCessFrm.ClientID %>");
            var txtSrchEduCessTo = document.getElementById("<%=txtSrchEduCessTo.ClientID %>");
            var txtSrchChallandateFrm = document.getElementById("<%=txtSrchChallandateFrm.ClientID %>");
            var txtSrchChallandateTo = document.getElementById("<%=txtSrchChallandateTo.ClientID %>");
            if ((txtSrchITAmtFrm.value != "") && (txtSrchITAmtTo.value == "")) {
                txtSrchITAmtTo.value = txtSrchITAmtFrm.value;
            }
            else if ((txtSrchITAmtFrm.value == "") && (txtSrchITAmtTo.value != "")) {
                txtSrchITAmtFrm.value = txtSrchITAmtTo.value;
            }
            else if ((txtSrchITAmtFrm.value != "") && (txtSrchITAmtTo.value != "")) {
                if (eval(txtSrchITAmtTo.value) < eval(txtSrchITAmtFrm.value)) {
                    var temp = txtSrchITAmtFrm.value;
                    txtSrchITAmtFrm.value = txtSrchITAmtTo.value;
                    txtSrchITAmtTo.value = temp;
                }
            }
            if ((txtSrchSurchargeFrm.value != "") && (txtSrchSurchargeTo.value == "")) {
                txtSrchSurchargeTo.value = txtSrchSurchargeFrm.value;
            }
            else if ((txtSrchSurchargeFrm.value == "") && (txtSrchSurchargeTo.value != "")) {
                txtSrchSurchargeFrm.value = txtSrchSurchargeTo.value;
            }
            else if ((txtSrchSurchargeFrm.value != "") && (txtSrchSurchargeTo.value != "")) {
                if (eval(txtSrchSurchargeTo.value) < eval(txtSrchSurchargeFrm.value)) {
                    var temp = txtSrchSurchargeFrm.value;
                    txtSrchSurchargeFrm.value = txtSrchSurchargeTo.value;
                    txtSrchSurchargeTo.value = temp;
                }
            }
            if ((txtSrchEduCessFrm.value != "") && (txtSrchEduCessTo.value == "")) {
                txtSrchEduCessTo.value = txtSrchEduCessFrm.value;
            }
            else if ((txtSrchEduCessFrm.value == "") && (txtSrchEduCessTo.value != "")) {
                txtSrchEduCessFrm.value = txtSrchEduCessTo.value;
            }
            else if ((txtSrchEduCessFrm.value != "") && (txtSrchEduCessTo.value != "")) {
                if (eval(txtSrchEduCessTo.value) < eval(txtSrchEduCessFrm.value)) {
                    var temp = txtSrchEduCessFrm.value;
                    txtSrchEduCessFrm.value = txtSrchEduCessTo.value;
                    txtSrchEduCessTo.value = temp;
                }
            }
            if ((txtSrchChallandateFrm.value != "") && (txtSrchChallandateTo.value == "")) {
                txtSrchChallandateTo.value = txtSrchChallandateFrm.value;
            }
            else if ((txtSrchChallandateFrm.value == "") && (txtSrchChallandateTo.value != "")) {
                txtSrchChallandateFrm.value = txtSrchChallandateTo.value;
            }
            if (!CheckDate(txtSrchChallandateFrm.value, txtSrchChallandateTo.value)) {
                var temp = txtSrchChallandateTo.value;
                txtSrchChallandateTo.value = txtSrchChallandateFrm.value;
                txtSrchChallandateFrm.value = temp;
            }
        }
        function CheckDate(fromDate, toDate) {
            var fromDateDay = parseInt(fromDate.substring(0, 2), 10);
            var fromDateMonth = parseInt(fromDate.substring(3, 5), 10);
            var fromDateYear = parseInt(fromDate.substring(6, 10), 10);
            var toDatedDay = parseInt(toDate.substring(0, 2), 10);
            var toDatedMonth = parseInt(toDate.substring(3, 5), 10);
            var toDatedYear = parseInt(toDate.substring(6, 10), 10);
            var fromDateTocheck = new Date(fromDateYear, fromDateMonth - 1, fromDateDay);
            var toDateCheck = new Date(toDatedYear, toDatedMonth - 1, toDatedDay);
            if (toDateCheck < fromDateTocheck) {
                return false;
            }
            return true;
        }
        function ParameterChanged() {
            document.getElementById("<%=hdnIsSearchParameterChanged.ClientID %>").value = "1";
        }
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
        function ConfirmDelete() {
            if (confirm("This is Auto-Generated Challan.\nDeletion will result in mismatch of earlier linked deductions.\nDelete only if necessary.\n\n Do you want to Delete?")) {
                __doPostBack("updatepanelChallan", "Delete");
            }
            else {
                return false;
            }
        }
        function ConfirmLinkDed() {
            if (confirm("Deduction(s) of both Companies & Non-Companies are selected.\nIt is recommended to make challan payment based on Companies/Non-Companies.\n\nIf payment is already made .Click 'Ok' else click 'Cancel' to cancel process. ")) {
                __doPostBack("updatepanelChallan", "Link Ded");
            }
            else {
                return false;
            }
        }
        function SetExceptionReportPanelVisibility() {
            var btnSearch = document.getElementById("<%=btnException.ClientID%>");
            if (btnSearch == null) {
                document.getElementById("<%=hdnExpMonth.ClientID%>").value = "0";
                return;
            }
            else {
                if (document.getElementById("<%=hdnExpMonth.ClientID%>").value == "0") {
                    btnSearch.style.display = '';
                    pnlSearch.style.display = 'none';
                }
                else {
                    btnSearch.style.display = 'none';
                    pnlSearch.style.display = '';

                }
            }
        }
        function SetExceptionReportStatus() {
            var hdnExpMonth = document.getElementById("<%=hdnExpMonth.ClientID%>");
            if (hdnExpMonth.value == "0") {
                hdnExpMonth.value = "1";
            }
            else {
                hdnExpMonth.value = "0";
            }
            SetExceptionReportPanelVisibility();
        }
        function CheckAcoountNoLength() {
            if (document.getElementById("<%=txtAccountNo.ClientID%>").value.length != 15) {
                alert("Specify Account No of length 15");
                document.getElementById("<%=txtAccountNo.ClientID%>").focus();
                return false;
            }
            return true;
        }
        function IsChallanExists() {
            var chalSerNo = document.getElementById("<%=txtChallanSerialNo.ClientID%>");
            var chalDate = document.getElementById("<%=dateeditPaidDate.ClientID%>");
            var chalNo = document.getElementById("<%=txtBankChallanNo.ClientID%>");
            var bankCode = document.getElementById("<%=txtBankCode.ClientID%>");
            var totalAmt = document.getElementById("<%=txtTotalAmount.ClientID %>");
            if (chalSerNo.value == "") {
                alert("Select a saved challan.");
                chalSerNo.focus();
                return false;
            }
            if (totalAmt.value == "") {
                alert("Please specify Amount.");
                document.getElementById("<%=txtIncomeTax.ClientID %>").focus();
                return false;
            }
            if (chalNo.value == "") {
                alert("Bank Challn No. is required");
                chalNo.focus();
                return false;
            }
            if (chalDate.value == "") {
                alert("Challan Date is required");
                chalDate.focus();
                return false;
            }
            if (bankCode.value == "") {
                alert("BSR Code is required.");
                return false;
            }
        }
        function ShowQSSData() {
            if (document.getElementById("<%=QSSdiv.ClientID%>").style.display == 'none') {
                document.getElementById("<%=QSSdiv.ClientID%>").style.display = '';
            }
            else
                document.getElementById("<%=QSSdiv.ClientID%>").style.display = 'none';
        }
        function ValidateChallan() {
            if (document.getElementById("<%=hdnChallanID.ClientID%>").value == "-1") {
                alert("Select a saved challan");
                return false;
            }
            else {
                return true;
            }
        }
        function GetBSRCodeValue(source, eventArgs) {
            var content = eventArgs.get_value();
            var text = eventArgs.get_text();
            document.getElementById("<%=hdnBankCode.ClientID%>").value = text;
            document.getElementById("<%=hdnBankID.ClientID%>").value = content;
        }
        function SetBSRCode(sender, e) {
            var bsrCodes = sender.get_completionList().childNodes;
            if (bsrCodes.length == 1) {
                document.getElementById("<%=hdnBankCode.ClientID%>").value = bsrCodes[0].firstChild.nodeValue;
                document.getElementById("<%=hdnBankID.ClientID%>").value = bsrCodes[0]._value;
            }
        }
        function DisplayControls() {
            var finYear = document.getElementById("<%=hdnFinYear.ClientID%>").value;
            var rowMinorHead = document.getElementById("<%=rowMinorHead.ClientID%>");
            var modeofPayment = document.getElementById("<%=cmbModeOfPayment.ClientID%>");
            var rowbsr = document.getElementById("<%=rowbsr.ClientID%>");
            if (Return(finYear) > 2012) {
                if (rowMinorHead != null) {
                    rowMinorHead.style.display = '';
                    if (modeofPayment.value == "3")
                        rowbsr.style.display = 'none';
                }
                else {
                    if (rowMinorHead != null)
                        rowMinorHead.style.display = 'none';
                    if (rowbsr != null)
                        rowbsr.style.display = 'none';
                }
            }
            else {
                if (rowMinorHead != null && modeofPayment.value == "3") {
                    if (rowbsr != null)
                        rowbsr.style.display = 'none';
                    rowMinorHead.style.display = 'none';
                }
                else {
                    if (rowbsr != null)
                        rowbsr.style.display = '';
                    if (rowMinorHead != null)
                        rowMinorHead.style.display = 'none';
                }
            }
        }

        function btnPopUpSearchchanged() {
            if (!(document.getElementById("<%=txtSrchTaxDeductedFrom.ClientID %>").value == ""
                            && document.getElementById("<%=txtSrchTaxDeductedTo.ClientID %>").value == "")) {
                if (document.getElementById("<%=txtSrchTaxDeductedFrom.ClientID %>").value == "") {
                    alert("Specify TaxDeducted From Amount.");
                    return false;
                }
                if (document.getElementById("<%=txtSrchTaxDeductedTo.ClientID %>").value == "") {
                    alert("Specify TaxDeducted To Amount.");
                    return false;
                }
            }
        }
           
    </script>
    <script language="javascript" type="text/javascript">
        function callReportForm(repName, formNo, printDate, quarterId, ChallanID, intLeft, intTop, strMenuBar) {
            window.open('../ReportViewer/ReportViewer.aspx?rpt=' + repName + '&FormNo=' + formNo + '&printDate=' + printDate + '&quarterID=' + quarterId + '&challanID=' + ChallanID, '_blank', "fullscreen=no,height=500,left=" + intLeft + ",width=700,top=" + intTop + ",scrollbars=yes,titlebar=yes,resizable=yes,location=no,menubar=" + strMenuBar);
        }		
    </script>
    <style type="text/css">
        .qssDiv
        {
            position: absolute;
            width: 387px;
            height: 96px;
            background-color: #d5dadd;
            border-style: outset;
            margin-left: 340px;
            margin-top: 265px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentPlaceHolderBody" runat="Server">
    <script type="text/javascript">
        function Show() {
            if (document.getElementById("<%=verDiv.ClientID%>").style.display == '') {
                document.getElementById("<%=verDiv.ClientID%>").style.display = 'none';
                document.getElementById("<%=MaskedDiv1.ClientID%>").style.display = 'none';
                EnableControls();
            }
            else {
                document.getElementById("<%=verDiv.ClientID%>").style.display = '';
                document.getElementById('<%=MaskedDiv1.ClientID%>').style.visibility = 'visible';
                document.getElementById('<%=MaskedDiv1.ClientID%>').style.top = '0px';
                document.getElementById('<%=MaskedDiv1.ClientID%>').style.left = '0px';
                document.getElementById('<%=MaskedDiv1.ClientID%>').style.width = document.documentElement.offsetWidth + 'px';
                document.getElementById('<%=MaskedDiv1.ClientID%>').style.height = (typeof window.innerHeight != 'undefined' ? window.innerHeight : document.body.offsetHeight) + 'px';
            }
        }    
    </script>
    <asp:UpdatePanel ID="updatepanelChallan" runat="server" OnLoad="updatepanelChallan_Load">
        <ContentTemplate>
            <asp:HiddenField ID="hdnIsIB" runat="server" Value="0" />
            <asp:HiddenField ID="hdnIsSIB" runat="server" Value="0" />
            <asp:HiddenField ID="hdnDefaultModeOfPayment" runat="server" />
            <asp:HiddenField ID="hdnClearSession" runat="server" Value="1" />
            <asp:HiddenField ID="hdnIsSectionSame" runat="server" Value="False" />
            <asp:HiddenField ID="hdnISDeducteeCodeSame" runat="server" Value="False" />
            <asp:HiddenField ID="hdnIsChecked" runat="server" Value="True" />
            <asp:HiddenField ID="hdnIsCalculate" runat="server" Value="True" />
            <asp:HiddenField ID="hdnIsEReturnGenerated" runat="server" Value="N" />
            <asp:HiddenField ID="hdnSearch" runat="server" Value="1" />
            <asp:HiddenField ID="hdnExpMonth" runat="server" Value="1" />
            <asp:HiddenField ID="hdnIsSearchActive" runat="server" Value="0" />
            <asp:HiddenField ID="hdnIsSearchParameterChanged" runat="server" Value="0" />
            <asp:HiddenField ID="hdnDeductorStatus" runat="server" />
            <asp:HiddenField ID="hdnFormType" runat="server" />
            <asp:HiddenField ID="hdnIsQuarterLocked" runat="server" Value="0" />
            <asp:HiddenField ID="hdnChallanID" runat="server" />
            <asp:HiddenField ID="hdnIsChallanLinked" runat="server" />
            <asp:HiddenField ID="hdnQuarter" runat="server" Value="" />
            <asp:HiddenField ID="hdnSectionID" runat="server" Value="-1" />
            <asp:HiddenField ID="hdnChallanSectionID" runat="server" Value="-1" />
            <asp:HiddenField ID="selectedPageIndex" runat="server" Value="1" />
            <asp:HiddenField ID="selectedPageSize" runat="server" Value="10" />
            <asp:HiddenField ID="selectedPopupPageIndex" runat="server" Value="1" />
            <asp:HiddenField ID="selectedPopupPageSize" runat="server" Value="10" />
            <asp:HiddenField ID="hdnFinYear" runat="server" Value="-1" />
            <asp:HiddenField ID="hdnVerificationStatus" runat="server" Value="" />
            <asp:HiddenField ID="hdnVerificationDate" runat="server" Value="" />
            <asp:HiddenField ID="hdnIsDataFound" runat="server" Value="0" />
            <asp:HiddenField ID="hdnBankID" runat="server" Value="-1" />
            <asp:HiddenField ID="hdnBankCode" runat="server" />
            <asp:HiddenField ID="hdnisSB" runat="server" Value="False" />
            <asp:HiddenField ID="hdnLinkChallanType" runat="server" />
            <asp:HiddenField ID="hdnChallanCode" runat="server" />
            <asp:HiddenField ID="hdnTotalDeducted" runat="server" Value="0" />
            <asp:HiddenField ID="hdnIsUCO" runat="server" Value="0" />
            <asp:HiddenField ID="hdnlastPageIndexPopUp" runat="server" Value="0" />
            <asp:HiddenField ID="hdnIsJK" runat="server" Value="0" />
            <asp:HiddenField ID="hdnIsChecker" runat="server" Value="0" />
            <asp:HiddenField ID="hdnTransStatus" runat="server" Value="" />
            <asp:MultiView ID="mvChallan" runat="server" ActiveViewIndex="0">
                <asp:View ID="vwChallan" runat="server">
                    <div id="MaskedDiv1" class="MaskedDiv" runat="server">
                    </div>
                    <div class="center" id="verDiv" style="display: none" runat="server">
                        <table width="100%" style="border-style: solid; border-width: 2px; border-color: #7f858b;
                            height: auto" cellpadding="0" cellspacing="0">
                            <tr style="height: 20px; background-color: #7f858b; color: White; font-size: small">
                                <th style="text-align: left; border: 0px">
                                    Challan Verification
                                </th>
                                <th style="text-align: right;">
                                    <asp:Button ID="btnCloseDiv" runat="server" Text="X" OnClientClick="Show();return false"
                                        Width="20px" />
                                </th>
                            </tr>
                            <tr valign="top" style="height: 30px">
                                <td style="color: Green; font-weight: bold; text-align: center;" colspan="2">
                                    <asp:Label ID="lblVerStatus" runat="server" Text=""></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" valign="top">
                                    <asp:Panel ID="pnlVer" runat="server" CssClass="navPanel" Width="100%">
                                        <table id="NavTable" bgcolor="white" width="100%;">
                                            <tr>
                                                <th style="text-align: left; height: 10px" valign="top">
                                                    Serial No.
                                                </th>
                                                <th style="font-weight: normal; height: 10px; text-align: left;">
                                                    <asp:Label ID="lblVerSerNo" runat="server" Text=""></asp:Label>
                                                </th>
                                                <th style="height: 10px; text-align: left; border-right-width: 0px">
                                                    <asp:Label ID="Label10" runat="server" Text=""></asp:Label>
                                                </th>
                                            </tr>
                                            <tr>
                                                <th style="text-align: left; width: 100px">
                                                    Challan Date
                                                </th>
                                                <th style="font-weight: normal; text-align: left;">
                                                    <asp:Label ID="lblVerChallanDate" runat="server" Text=""></asp:Label>
                                                </th>
                                                <th style="border-right-width: 0px">
                                                </th>
                                            </tr>
                                            <tr>
                                                <th style="font-weight: bold; text-align: left;">
                                                    Section
                                                </th>
                                                <th width="100px" style="font-weight: normal; text-align: left;">
                                                    <asp:Label ID="lblVerSection" runat="server" Text=""></asp:Label>
                                                </th>
                                                <th style="font-weight: normal; text-align: left; border-right-width: 0px">
                                                    <asp:Label ID="lblVerSectionName" runat="server" Text=""></asp:Label>
                                                </th>
                                            </tr>
                                            <tr>
                                                <th style="text-align: left;">
                                                    BSR Code
                                                </th>
                                                <th style="font-weight: normal; text-align: left;">
                                                    <asp:Label ID="lblVerBSRCode" runat="server" Text=""></asp:Label>
                                                </th>
                                                <th style="border-right-width: 0px">
                                                </th>
                                            </tr>
                                            <tr>
                                                <th style="text-align: left;">
                                                    OLTAS Date
                                                </th>
                                                <th style="font-weight: normal; text-align: left;">
                                                    <asp:Label ID="lblVerOltasDate" runat="server" Text=""></asp:Label>
                                                </th>
                                                <th style="border-right-width: 0px">
                                                </th>
                                            </tr>
                                            <tr>
                                                <th style="text-align: left;">
                                                    Major Code
                                                </th>
                                                <th style="font-weight: normal; text-align: left;">
                                                    <asp:Label ID="lblVerMajorCode" runat="server" Text=""></asp:Label>
                                                </th>
                                                <th style="font-weight: normal; text-align: left; border-right-width: 0px">
                                                    <asp:Label ID="lblVerMajorCodeDesc" runat="server" Text=""></asp:Label>
                                                </th>
                                            </tr>
                                            <tr>
                                                <th style="text-align: left; border-bottom-width: 0px">
                                                    Minor Code
                                                </th>
                                                <th style="font-weight: normal; text-align: left; border-bottom-width: 0px">
                                                    <asp:Label ID="lblVerMinorCode" runat="server" Text=""></asp:Label>
                                                </th>
                                                <th style="font-weight: normal; text-align: left; border-right-width: 0px; border-bottom-width: 0px">
                                                    <asp:Label ID="lblVerMinorCodeDesc" runat="server" Text=""></asp:Label>
                                                </th>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td style="font-weight: bold; color: #000080" colspan="2">
                                    Note:
                                </td>
                            </tr>
                            <tr>
                                <td style="font-weight: bold; color: #000080" colspan="2">
                                    <span style="padding-right: 1px; padding-left: 1px">i. This facility verifies the Bank
                                        Code,Date and Challan Serial No. to be present in OLTAS challan List of NSDL Website.</span>
                                </td>
                            </tr>
                            <tr style="height: 5px">
                                <td colspan="2">
                                </td>
                            </tr>
                            <tr>
                                <td style="font-weight: bold; color: #000080" colspan="2">
                                    <span style="padding-right: 1px; padding-left: 1px">ii. Comparison is Done against CIN
                                        and amount for given TAN with challan paid 24 months from the start of the financial
                                        year.</span>
                                </td>
                            </tr>
                            <tr style="height: 5px">
                                <td colspan="2">
                                </td>
                            </tr>
                            <tr>
                                <td style="font-weight: bold; color: #000080" colspan="2">
                                    <span style="padding-right: 1px; padding-left: 1px">iii. OLTAS Challan data used is
                                        referred through www.tin-nsdl.com,just for verification purpose and Relyon does
                                        not own or have authority over OLTAS data. Please check with NSDL website in case
                                        of any doubts.</span>
                                </td>
                            </tr>
                            <tr style="height: 5px">
                                <td colspan="2">
                                </td>
                            </tr>
                            <tr>
                                <td align="center" style="font-weight: bold; color: #000080" colspan="2">
                                    <asp:Button ID="btnVerClose" runat="server" Text="Close" CssClass="cmnBtn" OnClientClick="Show();return false;" />
                                </td>
                            </tr>
                            <tr style="height: 5px">
                                <td colspan="2">
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div id="QSSdiv" class="qssDiv" runat="server" style="display: none">
                        <table style="width: 391px; height: 95px;">
                            <tr>
                                <td style="width: 381px">
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 381px; text-align: center">
                                    <span style="color: #000080; font-family: Calibri; font-weight: bold; font-size: 15px">
                                        Verification Status :</span>
                                    <asp:Label ID="lblChallanStatus" runat="server" Text="Not Verified" Font-Names="Calibri"
                                        ForeColor="#000080" Font-Bold="true" Font-Size="15px"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 381px; text-align: center">
                                    <span style="font-family: Calibri; font-weight: bold; font-size: 15px">Status of Challan
                                        :</span>
                                    <asp:Label ID="lblQSSStatus" runat="server" Text="< Click QSS to get status >" Font-Names="Calibri"
                                        Font-Bold="true" Font-Size="15px"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 381px">
                                    <asp:Button ID="btnGetQSS" runat="server" Text="Quarterly Statement Status(QSS)"
                                        Style="border: groove 2px #d5dadd; margin-left: 5px;" Width="221px" OnClick="btnGetQSS_Click"
                                        Font-Bold="true" Font-Names="calibri" />
                                    <asp:Button ID="btnCloseQSS" runat="server" Text="Close" Style="margin-left: 100px;
                                        border: groove 2px #d5dadd" OnClientClick="ShowQSSData();return false" Font-Bold="true"
                                        Font-Names="calibri" />
                                </td>
                            </tr>
                        </table>
                    </div>
                    <table class="nTbl" id="navtbl">
                        <tr id="trnavtbl1" runat="server">
                            <td>
                                <table>
                                    <tr>
                                        <td valign="top" class="eCol">
                                            <table>
                                                <tr>
                                                    <td class="vHCol">
                                                        Serial No.
                                                    </td>
                                                    <td class="iCol">
                                                        <asp:TextBox ID="txtChallanSerialNo" runat="server" ReadOnly="true" Style="background-color: #d5dadd;
                                                            color: Black;" CssClass="txtBPL"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="vHCol">
                                                        Income Tax
                                                    </td>
                                                    <td class="iCol">
                                                        <asp:TextBox ID="txtIncomeTax" runat="server" MaxLength="12" CssClass="txtBPR" onkeypress="return ValidateForOnlyNos(event);"
                                                            onkeyUp="CalculateTotalAmount();" AutoComplete="Off" TabIndex="1" onpaste="return CheckForNos();"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="vHCol">
                                                        Fee u/s 234E Paid
                                                    </td>
                                                    <td class="iCol">
                                                        <asp:TextBox ID="txtFee" runat="server" MaxLength="13" TabIndex="8" CssClass="txtBPR"
                                                            onkeypress="return ValidateForOnlyNos(event);" onkeyUp="CalculateTotalAmount();"
                                                            onpaste="return CheckForNos();"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="vHCol">
                                                        Surcharge Paid
                                                    </td>
                                                    <td class="iCol">
                                                        <asp:TextBox ID="txtSurchargePaid" runat="server" MaxLength="12" AutoComplete="Off"
                                                            CssClass="txtBPR" onkeypress="return ValidateForOnlyNos(event);" TabIndex="2"
                                                            onpaste="return CheckForNos();" onkeyUp="CalculateTotalAmount();"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="vHCol">
                                                        Education Cess
                                                    </td>
                                                    <td class="iCol">
                                                        <asp:TextBox ID="txtEducationCess" runat="server" MaxLength="12" CssClass="txtBPR"
                                                            TabIndex="3" AutoComplete="Off" onkeypress="return ValidateForOnlyNos(event);"
                                                            onpaste="return CheckForNos();" onkeyUp="CalculateTotalAmount();"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="vHCol">
                                                        Interest Paid
                                                    </td>
                                                    <td width="170px" class="iCol">
                                                        <asp:TextBox ID="txtInterestPaid" runat="server" MaxLength="12" CssClass="txtBPR"
                                                            TabIndex="4" AutoComplete="Off" onkeypress="return ValidateForOnlyNos(event);"
                                                            onpaste="return CheckForNos();" onkeyUp="CalculateTotalAmount();"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="vHCol">
                                                        Penalty Paid
                                                    </td>
                                                    <td class="iCol">
                                                        <asp:TextBox ID="txtPenaltyPaid" runat="server" MaxLength="12" CssClass="txtBPR"
                                                            TabIndex="5" AutoComplete="Off" onkeypress="return ValidateForOnlyNos(event);"
                                                            onpaste="return CheckForNos();" onkeyUp="CalculateTotalAmount();"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="vHCol">
                                                        Other Amount Paid
                                                    </td>
                                                    <td class="iCol">
                                                        <asp:TextBox ID="txtOtherAmount" runat="server" MaxLength="12" CssClass="txtBPR"
                                                            TabIndex="6" AutoComplete="Off" onkeypress="return ValidateForOnlyNos(event);"
                                                            onpaste="return CheckForNos();" onkeyUp="CalculateTotalAmount();"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="vHCol">
                                                        Total Amount Paid
                                                    </td>
                                                    <td class="iCol">
                                                        <asp:TextBox ID="txtTotalAmount" runat="server" MaxLength="13" Enabled="false" TabIndex="7"
                                                            CssClass="roTxtBR"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="vHCol">
                                                        <asp:Label ID="lblTaxDed" runat="server" Text="Tax Deducted from"></asp:Label>
                                                    </td>
                                                    <td class="iCol">
                                                        <table>
                                                            <tr>
                                                                <td>
                                                                    <asp:RadioButton ID="rdlCompanies" runat="server" Text="Companies" GroupName="TaxDeductedFrom"
                                                                        TabIndex="9" />
                                                                </td>
                                                                <td>
                                                                    <asp:RadioButton ID="rdlNonCompanies" runat="server" Text="Non Companies" Checked="True"
                                                                        GroupName="TaxDeductedFrom" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td valign="top">
                                            <table>
                                                <tr>
                                                    <td class="vHCol">
                                                        <asp:Label ID="lblNatureOfPayment" runat="server" Text="Nature of Payment"></asp:Label>
                                                    </td>
                                                    <td class="iCol">
                                                        <asp:DropDownList ID="cmbNatureOfPayment" runat="server" BackColor="#E5E5E5" Width="100%"
                                                            CssClass="dropDownList" Font-Size="9" TabIndex="10" onchange="SetSectionID();">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr runat="server" id="rowMinorHead">
                                                    <td class="vHCol">
                                                        Type of Payment
                                                    </td>
                                                    <td class="iCol">
                                                        <asp:DropDownList ID="ddlMinorHead" runat="server" Width="100%" Font-Size="9" TabIndex="10"
                                                            CssClass="dropDownList">
                                                            <asp:ListItem Text="Select" Value="-1"></asp:ListItem>
                                                            <asp:ListItem Text="200-Payable by Taxpayer" Value="200"></asp:ListItem>
                                                            <asp:ListItem Text="400-Regular Assessment (Raised by I. T, Dept.)" Value="400"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="vHCol">
                                                        Mode of Payment
                                                    </td>
                                                    <td class="iCol">
                                                        <asp:DropDownList ID="cmbModeOfPayment" runat="server" CssClass="dropDownList" onchange="EnableControls();"
                                                            Font-Size="9" TabIndex="11" Width="100%" BackColor="#E5E5E5">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="vHCol">
                                                        <asp:Label ID="lblChallan" runat="server" Text="Challan No."></asp:Label>
                                                    </td>
                                                    <td class="iCol">
                                                        <asp:TextBox ID="txtBankChallanNo" runat="server" onkeypress="return ValidateForOnlyNos(event);"
                                                            onpaste="return CheckForNos();" MaxLength="5" AutoComplete="Off" CssClass="txtBML"
                                                            TabIndex="12"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="vHCol">
                                                        <asp:Label ID="lblChallanDate" runat="server" Text="Challan Date"></asp:Label>
                                                    </td>
                                                    <td class="iCol">
                                                        <asp:TextBox ID="dateeditPaidDate" ToolTip="Enter Date (Format: DD/MM/YYYY or DD MM YYYY)"
                                                            runat="server" onBlur="setDateFormat(this);" CssClass="txtBPR" AutoComplete="Off"
                                                            BackColor="#E5E5E5" TabIndex="13"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr id="rowChequeNumber" runat="server">
                                                    <td class="vHCol">
                                                        Cheque No.
                                                    </td>
                                                    <td class="iCol">
                                                        <asp:TextBox ID="txtChequeNumber" runat="server" MaxLength="14" onkeypress="return ValidateForOnlyNos(event);"
                                                            onpaste="return CheckForNos();" CssClass="txtBML" AutoComplete="Off" TabIndex="14"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr id="rowChequeDate" runat="server">
                                                    <td class="vHCol">
                                                        Cheque Date
                                                    </td>
                                                    <td class="iCol" width="170px">
                                                        <asp:TextBox ID="dateeditChequeDate" ToolTip="Enter Date (Format: DD/MM/YYYY or DD MM YYYY)"
                                                            runat="server" CssClass="txtBPR" onBlur="setDateFormat(this);" AutoComplete="Off"
                                                            BackColor="#E5E5E5" TabIndex="15"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr id="rowDrawnOn" runat="server">
                                                    <td class="vHCol">
                                                        Drawn On
                                                    </td>
                                                    <td class="iCol">
                                                        <asp:TextBox ID="txtDrawnOn" runat="server" MaxLength="50" CssClass="txtBML" onkeypress="return ValidateForAlphaNumeric(event);"
                                                            TabIndex="16" AutoComplete="Off"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr id="rowbsr" runat="server">
                                                    <td class="vHCol">
                                                        BSR Code
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtBankCode" runat="server" Enabled="true" CssClass="txtBML" AutoComplete="off"
                                                            BackColor="#E5E5E5" TabIndex="17" onkeyup="ClearBSRCode();"> </asp:TextBox>
                                                        <cc1:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" MinimumPrefixLength="2"
                                                            ServiceMethod="GetBSRCodeByAutocomplete" ServicePath="~/WebServices/AutoCompleteService.asmx"
                                                            TargetControlID="txtBankCode" CompletionInterval="700" EnableCaching="false"
                                                            CompletionSetCount="20" DelimiterCharacters="" ShowOnlyCurrentWordInCompletionListItem="true"
                                                            FirstRowSelected="True" OnClientItemSelected="GetBSRCodeValue" OnClientPopulated="SetBSRCode">
                                                        </cc1:AutoCompleteExtender>
                                                    </td>
                                                </tr>
                                                <tr runat="server" id="rowReceiptNo">
                                                    <td>
                                                        <asp:Label ID="lblTVReceiptNo" runat="server" Text="Form 24G Receipt No."></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtTVReceiptNo" runat="server" CssClass="txtBML" MaxLength="7" onkeypress="return ValidateForOnlyNos(event);"
                                                            AutoComplete="Off" TabIndex="18"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">
                                                        <asp:Button ID="btnPANStatus" runat="server" Text="Verify Challan" CssClass="cmnBtn"
                                                            OnClientClick="return IsChallanExists();" OnClick="btnPANStatus_Click" Visible="false" />
                                                        <asp:LinkButton ID="lnkChallanStatus" runat="server" Text="Challan Status" Font-Underline="True"
                                                            ForeColor="#000080" OnClientClick="return ValidateChallan();" OnClick="lnkChallanStatus_Click"
                                                            Font-Bold="True" Style="margin-left: 55px" Visible="false"></asp:LinkButton>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2" valign="middle">
                                                        <asp:Button ID="btnCheckAmountAvailable" runat="server" Text="Check Amount Available" Width="160px" CssClass="cmnBtn"
                                                            OnClick="btnCheckAmountAvailable_Click"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2" valign="middle">
                                                        <asp:Label ID="lblAvalAmount" Text="" runat="server" ForeColor="Blue" Font-Bold="true"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr id="trnavtbl2" runat="server">
                            <td>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Button ID="btnNew" runat="server" Text="New" CssClass="cmnBtn" OnClientClick="OnNewRecord();return true"
                                                TabIndex="19" OnClick="btnNew_Click" />
                                        </td>
                                        <td>
                                            <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="cmnBtn" OnClientClick="return Validation()"
                                                OnClick="btnSave_Click" TabIndex="20" />
                                        </td>
                                        <td>
                                            <asp:Button ID="btnFromDeduction" runat="server" CssClass="cmnBtn" Text="From Ded"
                                                OnClientClick="return ValidateView('From Ded');" OnClick="btnFromDeduction_Click"
                                                TabIndex="21" />
                                        </td>
                                        <td>
                                            <asp:Button ID="btnLinkDeduction" runat="server" Text="Link Ded" CssClass="cmnBtn"
                                                OnClientClick="return ValidateView('Link Ded');" OnClick="btnLinkDeduction_Click"
                                                TabIndex="22" />
                                        </td>
                                        <td>
                                            <asp:Button ID="btnReport" runat="server" Text="Report" CssClass="cmnBtn" OnClick="btnReport_Click"
                                                TabIndex="23" />
                                        </td>
                                        <td style="padding-left: 5px">
                                            <asp:Button ID="btnOpenSearch" runat="server" Text="Search" OnClientClick="SetStatus();return false;"
                                                CssClass="cmnBtn" TabIndex="24" />
                                        </td>
                                        <td id="tblException" runat="server">
                                            <asp:Button ID="btnException" runat="server" Text="Auto Challan" CssClass="cmnBtn"
                                                TabIndex="25" OnClick="btnException_Click" />
                                        </td>
                                        <td id="tdePayment" runat="server" style="padding-left: 5px; font-weight: bold; height: 20px">
                                            <a href="https://onlineservices.tin.egov-nsdl.com/etaxnew/tdsnontds.jsp" target="_blank">
                                                ePayment</a>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr id="trApproveReject" runat="server" visible="false">
                            <td>
                                <table>
                                    <tr>
                                        <td style="padding-left: 5px">
                                            <asp:Button ID="btnApprove" runat="server" Text="Approve" TabIndex="20" CssClass="cmnBtn"
                                                Width="80px" OnClick="btnApprove_Click" />
                                        </td>
                                        <td style="padding-left: 5px">
                                            <asp:Button ID="btnReject" runat="server" Text="Reject" TabIndex="20" CssClass="cmnBtn"
                                                Width="80px" OnClick="btnReject_Click" />
                                        </td>
                                        <td style="padding-left: 5px">
                                            <asp:Button ID="btnBack" runat="server" Text="Back" TabIndex="20" CssClass="cmnBtn"
                                                Width="80px" OnClick="btnBack_Click" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td align="center">
                                <asp:Label ID="lblNote" runat="server" ForeColor="#0000CC" Visible="false" Text=""></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td align="center">
                                <asp:Label ID="lblBulk" runat="server" ForeColor="#0000CC" Visible="false" Text=""></asp:Label>
                            </td>
                        </tr>
                        <tr id="trnavtbl3" runat="server">
                            <td>
                                <asp:Panel ID="pnlSearch" runat="server" BorderStyle="Dashed" BorderWidth="1" CssClass="searchPanel">
                                    <table width="100%" cellpadding="0" cellspacing="5">
                                        <tr>
                                            <td>
                                                Income Tax
                                            </td>
                                            <td style="padding-left: 2px; font-size: 9px" align="right">
                                                From
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtSrchITAmtFrm" runat="server" Width="80px" CssClass="txtBPL" onkeypress="return numeralsOnly(this, event,11,2,0,1);"
                                                    Style="border: 1px solid #9f9f9f; text-align: right" MaxLength="14" TabIndex="24"
                                                    onchange="ParameterChanged();"></asp:TextBox>
                                            </td>
                                            <td style="padding-left: 2px; font-size: 9px" align="right">
                                                To
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtSrchITAmtTo" runat="server" Width="80px" CssClass="txtBPL" onkeypress="return numeralsOnly(this, event,11,2,0,1);"
                                                    Style="border: 1px solid #9f9f9f; text-align: right" MaxLength="14" TabIndex="25"
                                                    onchange="ParameterChanged();"></asp:TextBox>
                                            </td>
                                            <td style="width: 25px">
                                            </td>
                                            <td colspan="2">
                                                <asp:Label ID="lblSearchSection" Text="Nature of Payment " runat="server"></asp:Label>
                                            </td>
                                            <td colspan="3">
                                                <asp:DropDownList ID="ddlSrchNatureofPayment" runat="server" Width="214px" TabIndex="26"
                                                    CssClass="dropDownList" onchange="ParameterChanged();">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                Surcharge
                                            </td>
                                            <td style="padding-left: 2px; font-size: 9px" align="right">
                                                From
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtSrchSurchargeFrm" runat="server" Width="80px" CssClass="txtBPL"
                                                    onkeypress="return numeralsOnly(this, event,11,2,0,1);" Style="border: 1px solid #9f9f9f;
                                                    text-align: right" MaxLength="14" TabIndex="27" onchange="ParameterChanged();"></asp:TextBox>
                                            </td>
                                            <td style="padding-left: 2px; font-size: 9px" align="right">
                                                To
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtSrchSurchargeTo" runat="server" Width="80px" CssClass="txtBPL"
                                                    onkeypress="return numeralsOnly(this, event,11,2,0,1);" Style="border: 1px solid #9f9f9f;
                                                    text-align: right" MaxLength="14" TabIndex="28" onchange="ParameterChanged();"></asp:TextBox>
                                            </td>
                                            <td style="width: 25px">
                                            </td>
                                            <td colspan="2">
                                                <asp:Label ID="lblmode" Text="Mode of Payment " runat="server"></asp:Label>
                                            </td>
                                            <td colspan="3">
                                                <asp:DropDownList ID="ddlSrchModeofPayment" runat="server" Width="214px" TabIndex="29"
                                                    CssClass="dropDownList" onchange="ParameterChanged();">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                Education Cess
                                            </td>
                                            <td style="padding-left: 2px; font-size: 9px" align="right">
                                                From
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtSrchEduCessFrm" runat="server" Width="80px" CssClass="txtBPL"
                                                    onkeypress="return numeralsOnly(this, event,11,2,0,1);" onchange="ParameterChanged();"
                                                    Style="border: 1px solid #9f9f9f; text-align: right" MaxLength="14" TabIndex="30"></asp:TextBox>
                                            </td>
                                            <td style="padding-left: 2px; font-size: 9px" align="right">
                                                To
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtSrchEduCessTo" runat="server" Width="80px" CssClass="txtBPL"
                                                    onkeypress="return numeralsOnly(this, event,11,2,0,1);" onchange="ParameterChanged();"
                                                    Style="border: 1px solid #9f9f9f; text-align: right" MaxLength="14" TabIndex="31"></asp:TextBox>
                                            </td>
                                            <td style="width: 25px">
                                            </td>
                                            <td>
                                                Challan Date
                                            </td>
                                            <td style="padding-left: 2px; font-size: 9px" align="right">
                                                From
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtSrchChallandateFrm" runat="server" CssClass="txtBPR" Width="80px"
                                                    TabIndex="32" onBlur="setDateFormat(this);" onchange="ParameterChanged();"></asp:TextBox>
                                            </td>
                                            <td style="padding-left: 2px; font-size: 9px" align="right">
                                                To
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtSrchChallandateTo" runat="server" Width="80px" CssClass="txtBPR"
                                                    TabIndex="33" onBlur="setDateFormat(this);" onchange="ParameterChanged();"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="11" align="right" style="padding-right: 15px">
                                                <table>
                                                    <tr>
                                                        <td align="right">
                                                            <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="cmnBtn" TabIndex="34"
                                                                OnClientClick="FormatSearch();" OnClick="btnSearch_Click" />
                                                        </td>
                                                        <td>
                                                            <asp:Button ID="btnClear" runat="server" Text="Clear Search" CssClass="cmnBtn" TabIndex="35"
                                                                OnClick="btnClear_Click" />
                                                        </td>
                                                        <td>
                                                            <asp:Button ID="btnClose" runat="server" Text="Close" Width="80px" OnClientClick="SetStatus();"
                                                                CssClass="cmnBtn" TabIndex="36" OnClick="btnClose_Click" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </td>
                        </tr>
                    </table>
                    <table class="nTbl" id="tblrpt" runat="server">
                        <tr>
                            <td>
                                <asp:Panel ID="navPanel" CssClass="navPanel" runat="server" ScrollBars="Horizontal">
                                    <asp:Repeater ID="rptrChallan" runat="server" OnItemCommand="rptrChallan_ItemCommand"
                                        OnItemDataBound="rptrChallan_ItemDataBound">
                                        <HeaderTemplate>
                                            <table id="NavTable" cellspacing="0" cellpadding="0">
                                                <tr bgcolor="#EEEEEE">
                                                    <th colspan="2">
                                                        Action
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="lblChalSerNo" Text="Serial No." runat="server" Width="60px"></asp:Label>
                                                    </th>
                                                    <th id="thTransStatus" runat="server">
                                                        <asp:Label ID="lblTransStatus" Text="Status" runat="server" Width="100px"></asp:Label>
                                                    </th>
                                                    <th>
                                                        <asp:Label Text="Income Tax" runat="server" Width="100px"></asp:Label>
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="Label8" Text="Fee u/s 234E Paid" runat="server" Width="120px"></asp:Label>
                                                    </th>
                                                    <th>
                                                        <asp:Label Text="Surcharge" runat="server" Width="100px"></asp:Label>
                                                    </th>
                                                    <th>
                                                        <asp:Label Text="Education Cess" runat="server" Width="100px"></asp:Label>
                                                    </th>
                                                    <th>
                                                        <asp:Label Text="Interest Paid" runat="server" Width="100px"></asp:Label>
                                                    </th>
                                                    <th>
                                                        <asp:Label Text="Penalty" runat="server" Width="100px"></asp:Label>
                                                    </th>
                                                    <th>
                                                        <asp:Label Text="Others" runat="server" Width="100px"></asp:Label>
                                                    </th>
                                                    <th>
                                                        <asp:Label Text="Total Amount" runat="server" Width="100px"></asp:Label>
                                                    </th>
                                                    <th>
                                                        <asp:Label Text="Nature Of Payment" runat="server" Width="140px" ID="lblPaymentNature"></asp:Label>
                                                    </th>
                                                    <th runat="server" id="thMinorHead">
                                                        <asp:Label Text="Type of Payment" runat="server" Width="280px" ID="Label9"></asp:Label>
                                                    </th>
                                                    <th>
                                                        <asp:Label Text="Mode Of Payment" runat="server" Width="140px"></asp:Label>
                                                    </th>
                                                    <th>
                                                        <asp:Label Text="Challan/Voucher Number" runat="server" Width="170px"></asp:Label>
                                                    </th>
                                                    <th>
                                                        <asp:Label Text="Challan/Voucher Date" runat="server" Width="150px"></asp:Label>
                                                    </th>
                                                    <th>
                                                        <asp:Label Text="Cheque Number" runat="server" Width="150px"></asp:Label>
                                                    </th>
                                                    <th>
                                                        <asp:Label Text="Cheque Date" runat="server" Width="100px"></asp:Label>
                                                    </th>
                                                    <th>
                                                        <asp:Label Text="Cheque Drawn On" runat="server" Width="150px"></asp:Label>
                                                    </th>
                                                    <th>
                                                        <asp:Label Text="BSR Code" runat="server" Width="100px"></asp:Label>
                                                    </th>
                                                    <th>
                                                        <asp:Label Text="Deducted From" runat="server" Width="100px" ID="lblDedFrom"></asp:Label>
                                                    </th>
                                                    <th>
                                                        <asp:Label Text="IsLinked" runat="server" Width="80px"></asp:Label>
                                                    </th>
                                                    <th style="border-right-style: none; display: none">
                                                        <asp:Label ID="lblVerifacation" Text="Verification Status" runat="server" Width="220px"></asp:Label>
                                                    </th>
                                                </tr>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <tr bgcolor="white">
                                                <td id="colEdit" runat="server">
                                                    <asp:LinkButton ID="btnEdit" runat="server" Text="Edit" CommandName="Edit" CommandArgument='<%#Eval("ChallanID") %>'
                                                        TabIndex="37"></asp:LinkButton>
                                                </td>
                                                <td id="colDelete" runat="server">
                                                    <asp:LinkButton ID="btnDelete" runat="server" Text="Delete" CommandName="Delete"
                                                        CommandArgument='<%#Eval("ChallanID") %>' TabIndex="38"></asp:LinkButton>
                                                </td>
                                                <td style="text-align: right">
                                                    <%# Eval("SlNo")%>
                                                </td>
                                                <td style="text-align: right" id="tdTransStatus" runat="server">
                                                    <%# Eval("TransStatus")%>
                                                </td>
                                                <td style="text-align: right">
                                                    <%# Eval("IncomeTax")%>
                                                </td>
                                                <td style="text-align: right">
                                                    <%# Eval("Fee")%>
                                                </td>
                                                <td style="text-align: right">
                                                    <%# Eval("Surcharge")%>
                                                </td>
                                                <td style="text-align: right">
                                                    <%#Eval("EducationCess")%>
                                                </td>
                                                <td style="text-align: right">
                                                    <%# Eval("Interest") %>
                                                </td>
                                                <td style="text-align: right">
                                                    <%# Eval("Penalty")%>
                                                </td>
                                                <td style="text-align: right">
                                                    <%# Eval("Others") %>
                                                </td>
                                                <td style="text-align: right">
                                                    <%# Eval("TotalAmount")%>
                                                </td>
                                                <td>
                                                    <%# Eval("NatureOfPayment")%>
                                                </td>
                                                <td runat="server" id="tdMinorHead">
                                                    <%# Eval("MinorHead")%>
                                                </td>
                                                <td>
                                                    <%# Eval("ModeOfPayment")%>
                                                </td>
                                                <td>
                                                    <%# Eval("BankTransferVoucherNumber")%>
                                                </td>
                                                <td style="text-align: right">
                                                    <%# Eval("BankTrasferVoucherDate")%>
                                                </td>
                                                <td>
                                                    <%# Eval("ChequeNumber")%>
                                                </td>
                                                <td style="text-align: right">
                                                    <%# Eval("ChequeDate")%>
                                                </td>
                                                <td>
                                                    <asp:Label Text='<%# Eval("ChequeDrawnOn")%>' runat="server" Width="200px"></asp:Label>
                                                </td>
                                                <td>
                                                    <%# Eval("BankCode")%>
                                                </td>
                                                <td>
                                                    <%# Eval("DeductedFrom")%>
                                                </td>
                                                <td>
                                                    <%# Eval("IsLinked")%>
                                                </td>
                                                <td style="display: none">
                                                    <%# Eval("VerificationStatus")%>
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            </table>
                                        </FooterTemplate>
                                    </asp:Repeater>
                                </asp:Panel>
                                <table style="padding-right: 0px; margin-right: -2px; margin-bottom: -3px" align="right">
                                    <tr>
                                        <td width="230px" align="left">
                                            <asp:Label ID="lblChallanTotal" runat="server" Text="ChallanTotal : Nil" Font-Size="Small" />
                                        </td>
                                        <td style="padding: 0px 0px 0px 0px">
                                            <asp:Label ID="Label1" runat="server" Text="Records per page : " Font-Size="X-Small" />
                                        </td>
                                        <td style="width: 50px; padding-top: 2px;">
                                            <asp:DropDownList ID="cmbGoTo" runat="server" Style="width: 50px; height: 15px; float: left;"
                                                CssClass="dropDownList" onchange="if(!OnParameterChanged()) return false" OnSelectedIndexChanged="cmbGoTo_SelectedIndexChanged"
                                                AutoPostBack="true" Font-Size="X-Small" TabIndex="39">
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
                                            <asp:Button ID="btnFirst" runat="server" Text="&lt;&lt;" Font-Names="Arial" Font-Overline="False"
                                                Font-Size="X-Small" OnClick="btnFirst_Click" CssClass="navButton" Enabled="False"
                                                TabIndex="40" OnClientClick="return OnParameterChanged();"></asp:Button>
                                        </td>
                                        <td>
                                            <asp:Button ID="btnPrevious" runat="server" Text="&lt;" Font-Names="Arial" Font-Overline="False"
                                                Font-Size="X-Small" OnClick="btnPrevious_Click" CssClass="navButton" Enabled="False"
                                                TabIndex="41" OnClientClick="return OnParameterChanged();"></asp:Button>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtGoToPage" runat="server" Text="1" CssClass="navTextBox" AutoPostBack="True"
                                                OnTextChanged="txtGoToPage_TextChanged" MaxLength="5" TabIndex="42" onchange="if(!OnParameterChanged()) return false"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:Button ID="btnNext" runat="server" Text="&gt;" Font-Names="Arial" Font-Overline="False"
                                                Font-Size="X-Small" OnClick="btnNext_Click" CssClass="navButton" TabIndex="43"
                                                OnClientClick="return OnParameterChanged();"></asp:Button>
                                        </td>
                                        <td>
                                            <asp:Button ID="btnLast" runat="server" Text="&gt;&gt;" Font-Names="Arial" Font-Overline="False"
                                                Font-Size="X-Small" OnClick="btnLast_Click" CssClass="navButton" TabIndex="44"
                                                OnClientClick="return OnParameterChanged();"></asp:Button>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </asp:View>
                <asp:View ID="vwFromLinkDeduction" runat="server">
                    <table class="nTbl">
                        <tr>
                            <td>
                                <table cellpadding="0" cellspacing="6" width="100%">
                                    <tr>
                                        <td width="50px">
                                            Name
                                        </td>
                                        <td width="100px">
                                            <asp:TextBox ID="txtUnLinkDeductionName" runat="server" CssClass="txtBPL" Width="134px"></asp:TextBox>
                                        </td>
                                        <td>
                                            Section
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="cmbUnLinkDeductionSection" runat="server" Width="250px" CssClass="dropDownList">
                                            </asp:DropDownList>
                                        </td>
                                        <td align="right">
                                            Code
                                        </td>
                                        <td width="50px" align="center">
                                            <asp:DropDownList ID="cmbUnLinkDeductionCode" runat="server" Width="190px" CssClass="dropDownList">
                                                <asp:ListItem Value="-1" Text=""></asp:ListItem>
                                                <asp:ListItem Value="1" Text="Companies"></asp:ListItem>
                                                <asp:ListItem Value="2" Text="NonCompanies"></asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Quarter
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="cmbUnLinkDeductionQuarter" runat="server" Width="140px" CssClass="dropDownList">
                                                <asp:ListItem Text="All" Value="-1"></asp:ListItem>
                                                <asp:ListItem Text="Quarter 1" Value="1"></asp:ListItem>
                                                <asp:ListItem Text="Quarter 2" Value="2"></asp:ListItem>
                                                <asp:ListItem Text="Quarter 3" Value="3"></asp:ListItem>
                                                <asp:ListItem Text="Quarter 4" Value="4"></asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td>
                                            From
                                        </td>
                                        <td colspan="3">
                                            <table cellpadding="0" cellspacing="2" width="100%">
                                                <tr>
                                                    <td>
                                                        <asp:TextBox ID="dateeditUnLinkDeductionFrom" runat="server" Width="100px" onBlur="setDateFormat(this);"
                                                            CssClass="txtBPR"></asp:TextBox>
                                                    </td>
                                                    <td align="left">
                                                        To
                                                    </td>
                                                    <td style="padding-left: 5px;">
                                                        <asp:TextBox ID="dateeditUnLinkDeductionTo" runat="server" Width="100px" onBlur="setDateFormat(this);"
                                                            CssClass="txtBPR"></asp:TextBox>
                                                    </td>
                                                    <td align="left">
                                                        Tax Deducted Amount:
                                                    </td>
                                                    <td align="left">
                                                        <asp:RadioButton ID="rbtnHigh" runat="server" Text="Higher to Lower" Checked="true"
                                                            GroupName="Form16" />
                                                    </td>
                                                    <td>
                                                        <asp:RadioButton ID="rbtnLow" runat="server" Text="Lower to Higher" GroupName="Form16"
                                                            Visible="true" />
                                                    </td>
                                                    <%--                <td style="padding-left: 9px;">
                                                        <asp:CheckBox ID="chkDefaultSelect" Text="Default Select" runat="server" Width="110px" />
                                                    </td>
                                                    <td>
                                                        <asp:Button ID="btnPopUpSearch" runat="server" CssClass="cmnBtn" Text="Search" Width="110px"
                                                            OnClick="btnPopUpSearch_Click" />
                                                    </td>--%>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6">
                                            <table cellpadding="0" cellspacing="2" width="100%">
                                                <tr>
                                                    <td>
                                                        Tax Deducted Amount
                                                    </td>
                                                    <td>
                                                        From
                                                    </td>
                                                    <td colspan="3">
                                                        <table cellpadding="0" cellspacing="2" width="100%">
                                                            <tr>
                                                                <td>
                                                                    <asp:TextBox ID="txtSrchTaxDeductedFrom" runat="server" Width="100px" onkeypress="return numeralsOnly(this, event,11,2,0,1);"
                                                                        Style="border: 1px solid #9f9f9f; text-align: right" MaxLength="14" onchange="ParameterChanged();"
                                                                        CssClass="txtBPL"></asp:TextBox>
                                                                </td>
                                                                <td align="left" style="padding-left: 15px;">
                                                                    To
                                                                </td>
                                                                <td style="padding-left: 5px;">
                                                                    <asp:TextBox ID="txtSrchTaxDeductedTo" runat="server" Width="100px" onkeypress="return numeralsOnly(this, event,11,2,0,1);"
                                                                        Style="border: 1px solid #9f9f9f; text-align: right" MaxLength="14" onchange="ParameterChanged();"
                                                                        CssClass="txtBPL"></asp:TextBox>
                                                                </td>
                                                                <td style="padding-left: 9px;">
                                                                    <asp:CheckBox ID="chkDefaultSelect" Text="Default Select" runat="server" Width="110px" />
                                                                </td>
                                                                <td>
                                                                    <asp:Button ID="btnPopUpSearch" runat="server" CssClass="cmnBtn" Text="Search" Width="110px"
                                                                        OnClick="btnPopUpSearch_Click" OnClientClick="return btnPopUpSearchchanged();">
                                                                    </asp:Button>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td id="rptrTD" runat="server">
                                <asp:Panel ID="pnFromLink" CssClass="navPanel" runat="server" ScrollBars="Horizontal"
                                    Width="730px" BorderStyle="Solid" BorderWidth="1px" BorderColor="Gray">
                                    <asp:Repeater ID="rptrUnlinkedDeduction" runat="server" OnItemDataBound="rptrUnlinkedDeduction_ItemDataBound">
                                        <HeaderTemplate>
                                            <table id="NavTable" border="1">
                                                <tr bgcolor="#EEEEEE">
                                                    <th>
                                                    </th>
                                                    <th style="display: none">
                                                        DeductionID
                                                    </th>
                                                    <th style="display: none">
                                                        PartpaymentID
                                                    </th>
                                                    <th>
                                                        <asp:Label runat="server" Text="SerialNo" Width="100px"></asp:Label>
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="Label2" runat="server" Text="Name" Width="100px"></asp:Label>
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="Label3" runat="server" Text="Quarter" Width="100px"></asp:Label>
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="Label4" runat="server" Text="Section" Width="100px"></asp:Label>
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="Label5" runat="server" Text="IncomeTax" Width="100px"></asp:Label>
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="Label6" runat="server" Text="Surcharge" Width="100px"></asp:Label>
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="Label7" runat="server" Text="Cess" Width="100px"></asp:Label>
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="lblTaxDeducted" runat="server" Text="TaxDeduction" Width="100px"></asp:Label>
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="lblTaxDeductedDate" runat="server" Text="DeductedDate" Width="100px"></asp:Label>
                                                    </th>
                                                    <th style="display: none">
                                                        SectionID
                                                    </th>
                                                </tr>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <tr bgcolor="white">
                                                <td>
                                                    <asp:CheckBox ID="chkSelect" runat="server" />
                                                </td>
                                                <td style="display: none">
                                                    <asp:Label ID="lblDeductionID" runat="server" Text='<%# Eval("DeductionID")%>'></asp:Label>
                                                </td>
                                                <td style="display: none">
                                                    <asp:Label ID="lblPartPaymentID" runat="server" Text='<%# Eval("PartPaymentID")%>'></asp:Label>
                                                </td>
                                                <td>
                                                    <%# Eval("SerialNumber")%>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" Text='<%# Eval("DeducteeName")%>' Width="200px"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblQuarter" runat="server" Text='<%# Eval("Quarter")%>'></asp:Label>
                                                </td>
                                                <td style="text-align: center">
                                                    <%#Eval("SectionName")%>
                                                </td>
                                                <td style="text-align: right">
                                                    <%# Eval("IncomeTax")%>
                                                </td>
                                                <td style="text-align: right">
                                                    <%# Eval("Surcharge")%>
                                                </td>
                                                <td style="text-align: right">
                                                    <%# Eval("EducationCess")%>
                                                </td>
                                                <td style="text-align: right">
                                                    <%# Eval("TaxDeducted")%>
                                                </td>
                                                <td style="text-align: right">
                                                    <%# Eval("DeductedDate")%>
                                                </td>
                                                <td style="display: none">
                                                    <asp:Label ID="lblSectionID" runat="server" Text='<%# Eval("SectionID")%>'></asp:Label>
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            </table>
                                        </FooterTemplate>
                                    </asp:Repeater>
                                </asp:Panel>
                                <table style="padding-right: 0px; margin-right: -2px; margin-bottom: -3px">
                                    <tr>
                                        <td>
                                            Select :
                                        </td>
                                        <td>
                                            <asp:LinkButton ID="lnkbtnCheckAll" runat="server" Text="All" OnClientClick="return SelectAllCheckBox();"></asp:LinkButton>
                                        </td>
                                        <td>
                                            |
                                        </td>
                                        <td>
                                            <asp:LinkButton ID="lnkbtnUnCheckAll" runat="server" Text="None" OnClientClick="return UnSelectAllCheckBox();"
                                                CausesValidation="true"></asp:LinkButton>
                                        </td>
                                        <td style="width: 120px">
                                        </td>
                                        <td style="padding: 0px 0px 0px 0px">
                                            <asp:Label ID="ASPxLabel4" runat="server" Text="Records per page : " Font-Size="X-Small" />
                                        </td>
                                        <td style="width: 50px; padding-top: 2px;">
                                            <asp:DropDownList ID="cmbPopUpGoTo" runat="server" Style="width: 50px; height: 15px;
                                                float: left;" OnSelectedIndexChanged="cmbPopUpGoTo_SelectedIndexChanged" AutoPostBack="true"
                                                CssClass="dropDownList" Font-Size="X-Small">
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
                                            <asp:Label ID="lblPopUpGridStatus" runat="server" Style="float: left;" Text="Showing 0-0 of 0 [Page 0 of 0]"
                                                Font-Size="X-Small" />
                                        </td>
                                        <td>
                                            <asp:Button ID="btnPopUpFirst" runat="server" Text="&lt;&lt;" Font-Names="Arial"
                                                Font-Overline="False" Font-Size="X-Small" OnClick="btnPopUpFirst_Click" CssClass="navButton"
                                                Enabled="False"></asp:Button>
                                        </td>
                                        <td>
                                            <asp:Button ID="btnPopUpPrevious" runat="server" Text="&lt;" Font-Names="Arial" Font-Overline="False"
                                                Font-Size="X-Small" OnClick="btnPopUpPrevious_Click" CssClass="navButton" Enabled="False">
                                            </asp:Button>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtPopUpGoToPage" runat="server" Text="1" CssClass="navTextBox"
                                                AutoPostBack="True" OnTextChanged="txtPopUpGoToPage_TextChanged" MaxLength="5"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:Button ID="btnPopUpNext" runat="server" Text="&gt;" Font-Names="Arial" Font-Overline="False"
                                                Font-Size="X-Small" OnClick="btnPopUpNext_Click" CssClass="navButton"></asp:Button>
                                        </td>
                                        <td>
                                            <asp:Button ID="btnPopUpLast" runat="server" Text="&gt;&gt;" Font-Names="Arial" Font-Overline="False"
                                                Font-Size="X-Small" OnClick="btnPopUpLast_Click" CssClass="navButton"></asp:Button>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td align="left">
                                <table class="nTbl">
                                    <tr align="left">
                                        <td width="150px">
                                            <asp:Label ID="lblAmountToLink" runat="server" Text="Challan Amount to link"> </asp:Label>
                                        </td>
                                        <td align="left" width="160px">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <asp:TextBox ID="txtLinkDedIncomeTax" runat="server" ReadOnly="true" CssClass="rotxtBH"> </asp:TextBox>
                                                    </td>
                                                    <td width="100px">
                                                        <asp:TextBox ID="txtLinkDedSurcharge" runat="server" ReadOnly="true" CssClass="rotxtBH"> </asp:TextBox>
                                                    </td>
                                                    <td width="100px">
                                                        <asp:TextBox ID="txtLinkDedCess" runat="server" CssClass="rotxtBH" ReadOnly="true"> </asp:TextBox>
                                                    </td>
                                                    <td width="100px">
                                                        <asp:TextBox ID="txtLinkDedTaxDeduction" runat="server" ReadOnly="true" CssClass="rotxtBH"> </asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table class="nTbl" cellpadding="0" cellspacing="0">
                                    <tr align="left">
                                        <td align="left" width="150px">
                                            Link Total
                                        </td>
                                        <td width="150px">
                                            <table>
                                                <tr>
                                                    <td width="100px">
                                                        <asp:TextBox ID="txtFromDedIncomeTax" runat="server" ReadOnly="true" CssClass="rotxtBH"></asp:TextBox>
                                                    </td>
                                                    <td width="100px">
                                                        <asp:TextBox ID="txtFromDedSurcharge" runat="server" CssClass="rotxtBH" ReadOnly="true"></asp:TextBox>
                                                    </td>
                                                    <td width="100px">
                                                        <asp:TextBox ID="txtFromDedCess" CssClass="rotxtBH" runat="server" ReadOnly="true"></asp:TextBox>
                                                    </td>
                                                    <td width="100px">
                                                        <asp:TextBox ID="txtFromDedTaxDeduction" runat="server" ReadOnly="true" CssClass="rotxtBH"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td align="right" width="120px">
                                            <asp:Button ID="btnDeductionAmount" runat="server" Text="Calculate" OnClick="btnDeductionAmount_Click"
                                                CssClass="cmnBtn" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table>
                                    <tr>
                                        <td>
                                        </td>
                                        <td align="right" width="100%">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <asp:Button ID="btnDeductionLink" runat="server" Text="" CssClass="cmnBtn" OnClientClick="return LoadPopUpAmount();"
                                                            OnClick="btnDeductionLink_Click" />
                                                    </td>
                                                    <td>
                                                        <asp:Button ID="btnDeductionClose" runat="server" Text="Close" CssClass="cmnBtn"
                                                            OnClick="btnDeductionClose_Click" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </asp:View>
                <asp:View ID="vwChallanReport" runat="server">
                    <table cellpadding="5px">
                        <tr>
                            <td>
                                Serial Number
                            </td>
                            <td colspan="2">
                                <asp:DropDownList ID="cmbSerialNumber" runat="server" BackColor="#E5E5E5" Width="100%"
                                    CssClass="dropDownList">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <asp:CheckBox ID="chkPrintCheck" runat="server" Text="Print Cheque Date" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Button ID="btnPreview" runat="server" Text="Preview" OnClientClick="return ValidateSerialNumber();"
                                    OnClick="btnPreview_Click" CssClass="cmnBtn" />
                            </td>
                            <td align="right">
                                <asp:Button ID="btnReportClose" runat="server" CssClass="cmnBtn" Text="Close" OnClick="btnReportClose_Click" />
                            </td>
                            <td align="right">
                                &nbsp;
                            </td>
                        </tr>
                    </table>
                </asp:View>
                <asp:View ID="vwMakePayment" runat="server">
                    <table cellpadding="0" cellspacing="0">
                        <tr>
                            <td>
                                <table cellpadding="0" cellspacing="5" style="width: 100%">
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblSelectMonth" Text="Select Month :" runat="server"></asp:Label>
                                        </td>
                                        <td align="left">
                                            <asp:DropDownList ID="ddlMonth" runat="server" Width="100px" Height="23px" CssClass="dropDownList">
                                                <asp:ListItem Text="April" Value="4"></asp:ListItem>
                                                <asp:ListItem Text="May" Value="5"></asp:ListItem>
                                                <asp:ListItem Text="June" Value="6"></asp:ListItem>
                                                <asp:ListItem Text="July" Value="7"></asp:ListItem>
                                                <asp:ListItem Text="August" Value="8"></asp:ListItem>
                                                <asp:ListItem Text="September" Value="9"></asp:ListItem>
                                                <asp:ListItem Text="October" Value="10"></asp:ListItem>
                                                <asp:ListItem Text="November" Value="11"></asp:ListItem>
                                                <asp:ListItem Text="December" Value="12"></asp:ListItem>
                                                <asp:ListItem Text="January" Value="1"></asp:ListItem>
                                                <asp:ListItem Text="February" Value="2"></asp:ListItem>
                                                <asp:ListItem Text="March" Value="3"></asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblForm" Text="Form Type:" runat="server"></asp:Label>
                                            <asp:Label ID="lblFormType" Text="27Q" runat="server"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlFormType" runat="server" Width="100px" Height="23px" CssClass="dropDownList">
                                                <asp:ListItem Text="26QI" Value="1"></asp:ListItem>
                                                <asp:ListItem Text="26QV" Value="2"></asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Parked Amount:
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtParkedAmountOld" runat="server" CssClass="txtBPR"></asp:TextBox>
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            TDS Amount:
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtTDSAmount" runat="server" ReadOnly="true" CssClass="rotxtBH"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="display: none">
                                            Account No.:
                                        </td>
                                        <td style="display: none">
                                            <asp:TextBox ID="txtAccountNo" runat="server" CssClass="txtBPR"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <td>
                                        <asp:Button ID="btnGetParked" runat="server" Text="Get" TabIndex="9" CssClass="cmnBtn"
                                            OnClick="btnGetParked_Click" />
                                    </td>
                                    <td>
                                        <asp:Button ID="btnUpdateParked" runat="server" Text="Save" TabIndex="5" CssClass="cmnBtn"
                                            OnClick="btnUpdateParked_Click" />
                                    </td>
                                    <td>
                                        <asp:Button ID="btnExpMonthShow" runat="server" CssClass="cmnBtn" OnClick="btnExpMonthShow_Click"
                                            TabIndex="36" Text="Show Exception" Width="100px" />
                                    </td>
                                    &nbsp;
                                    <td style="display: none">
                                        <asp:Button ID="btnMakePayment" runat="server" Text="Make Payment" CssClass="cmnBtn" />
                                    </td>
                                    <td align="right">
                                        <asp:Button ID="btnExpClose" runat="server" CssClass="cmnBtn" OnClientClick="SetStatus();"
                                            TabIndex="36" Text="Close" Width="80px" OnClick="btnExpClose_Click" />
                                    </td>
                                </table>
                            </td>
                        </tr>
                    </table>
                </asp:View>
            </asp:MultiView>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnExpMonthShow" />
            <asp:PostBackTrigger ControlID="btnNew" />
            <asp:PostBackTrigger ControlID="btnFromDeduction" />
            <asp:PostBackTrigger ControlID="btnLinkDeduction" />
            <asp:PostBackTrigger ControlID="btnReport" />
            <asp:PostBackTrigger ControlID="btnOpenSearch" />
            <asp:PostBackTrigger ControlID="btnException" />
            <asp:PostBackTrigger ControlID="btnLinkDeduction" />
            <asp:PostBackTrigger ControlID="btnSearch" />
            <asp:PostBackTrigger ControlID="btnClear" />
            <asp:PostBackTrigger ControlID="btnClose" />
            <asp:PostBackTrigger ControlID="btnDeductionAmount" />
            <asp:PostBackTrigger ControlID="btnPreview" />
            <asp:PostBackTrigger ControlID="btnReportClose" />
            <asp:PostBackTrigger ControlID="btnGetParked" />
            <asp:PostBackTrigger ControlID="btnUpdateParked" />
            <asp:PostBackTrigger ControlID="btnMakePayment" />
            <asp:PostBackTrigger ControlID="btnExpClose" />
            <asp:PostBackTrigger ControlID="btnDeductionClose" />
            <asp:PostBackTrigger ControlID="btnDeductionLink" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
