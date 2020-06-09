<%@ page title="" language="C#" masterpagefile="~/SaralTDS.master" autoeventwireup="true" inherits="Reports_InternetScrollDirectTaxes, App_Web_internetscrolldirecttaxes.aspx.dfa151d5" %>

<%@ MasterType VirtualPath="~/SaralTDS.master" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../JavaScript/Validations.js" type="text/javascript" language="javascript"></script>
    <script type="text/javascript">
        function Validate_CU() {
            var objddl = document.getElementById("<%=ddlCU_ReportType.ClientID%>");
            var objtext = document.getElementById("<%=txtCU_BranchCode.ClientID%>");
            if (objddl.options[objddl.selectedIndex].text == "All") {
                objtext.setAttribute("disabled", true);
                document.getElementById("<%=txtCU_BranchCode.ClientID%>").value = "";
            }
            else if (objddl.options[objddl.selectedIndex].text == "RO wise" || objddl.options[objddl.selectedIndex].text == "Branch wise") {
                objtext.removeAttribute("disabled");
            }
        }
        function Check_For_Blank_File() {
            if (document.getElementById("<%=fileUpload.ClientID%>").value != "") {
                document.getElementById("<%=reqFile.ClientID%>").style.display = 'none';
                return true;
            }
            else {
                document.getElementById("<%=reqFile.ClientID%>").style.display = '';
                return false;
            }
        }
        function isNumber(evt) {
            var theEvent = evt || window.event;
            var key = theEvent.keyCode || theEvent.which;
            key = String.fromCharCode(key);
            if (key.length == 0) return;
            var regex = /^[0-9.,\b]+$/;
            if (!regex.test(key)) {
                theEvent.returnValue = false;
                if (theEvent.preventDefault) theEvent.preventDefault();
            }
        }
        function isNumber_withoutcomma(evt) {
            var theEvent = evt || window.event;
            var key = theEvent.keyCode || theEvent.which;
            key = String.fromCharCode(key);
            if (key.length == 0) return;
            var regex = /^[0-9.\b]+$/;
            if (!regex.test(key)) {
                theEvent.returnValue = false;
                if (theEvent.preventDefault) theEvent.preventDefault();
            }
        }
        function Disable_Traces_Report() {
            rowTracesReport.style.display = 'none';
        }
        function Load_Busy() {
            if (document.getElementById("<%=fileUpload.ClientID%>").value != "") {
                document.getElementById("<%=btnImportTraces.ClientID%>").value = "Loading..";
            }
        }
        function ValidateDate() {
            var finYear = document.getElementById("<%=hdnFinYear.ClientID%>").value;
            var fromDate = new Date(finYear, 03, 01);
            var toDate = new Date(eval(finYear) + 1, 02, 31);
            var date = document.getElementById("<%=txtSelectDate.ClientID%>").value;
            var taxDedDateDay = parseInt(date.substring(0, 2), 10);
            var taxDedDateMonth = parseInt(date.substring(3, 5), 10);
            var taxDedDateYear = parseInt(date.substring(6, 10), 10);
            var taxDate = new Date(taxDedDateYear, taxDedDateMonth - 1, taxDedDateDay);
            if (taxDate < fromDate || taxDate > toDate) {
                document.getElementById("<%=btnPreview.ClientID%>").value = "Preview";
                alert("Date should be within the Financial Year.");
                document.getElementById("<%=txtSelectDate.ClientID%>").focus(); return false;
            }
            else return true;
        }
        function ValidateDates(objValue) {
            var finYear = document.getElementById("<%=hdnFinYear.ClientID%>").value; var fromDate = new Date(finYear, 03, 01);
            var toDate = new Date(eval(finYear) + 1, 02, 31); var taxDedDateDay = parseInt(objValue.value.substring(0, 2), 10);
            var taxDedDateMonth = parseInt(objValue.value.substring(3, 5), 10); var taxDedDateYear = parseInt(objValue.value.substring(6, 10), 10);
            var taxDate = new Date(taxDedDateYear, taxDedDateMonth - 1, taxDedDateDay);
            if (taxDate < fromDate || taxDate > toDate) { document.getElementById("<%=btnPreview.ClientID%>").value = "Preview"; alert("Date should be within the Financial Year."); objValue.focus(); return false; }
            else return true;
        }
        function Validate() {
            if (document.getElementById("<%=btnPreview.ClientID%>").value == "Preview") {
                document.getElementById("<%=btnPreview.ClientID%>").value = "Loading..";

                if (document.getElementById("<%=hlinkDownloadFile.ClientID%>") != null)
                    document.getElementById("<%=hlinkDownloadFile.ClientID%>").style.display = 'none';

                var monthFrom = document.getElementById("<%=ddlMonthFrom.ClientID%>");
                var ddMonth = document.getElementById("<%=drpMonth.ClientID%>");
                var monthTo = document.getElementById("<%=ddlMonthTo.ClientID%>");
                var selectedIdex = document.getElementById("<%=lstReportType.ClientID%>").value;
                var date = document.getElementById("<%=txtSelectDate.ClientID%>");
                var month = document.getElementById("<%=ddlMonth.ClientID%>");
                var datewise = document.getElementById("<%=rbtnDateWise.ClientID%>");
                var monthwise = document.getElementById("<%=rbtnMonthWise.ClientID%>");
                var quarter = document.getElementById("<%=ddlQuarter.ClientID%>");
                var dateFrom = document.getElementById("<%=txtFromDate.ClientID%>");
                var dateTo = document.getElementById("<%=txtToDate.ClientID%>");
                var monthFrom = document.getElementById("<%=ddlMonthFrom.ClientID%>");
                var monthTo = document.getElementById("<%=ddlMonthTo.ClientID%>");
                var rowtxtMonth = document.getElementById("rowTxtMonth");
                var txtSelectDate = document.getElementById("<%=txtSelectDate.ClientID%>");
                var ddlDeductorType = document.getElementById("<%=ddlDeductorType.ClientID%>");
                var txtSearchType = document.getElementById("<%=txtSearchText.ClientID%>");
                var txtDedDate = document.getElementById("<%=txtDeductionDate.ClientID%>");
                var txtPaymentDate = document.getElementById("<%=txtPaymentDate.ClientID %>");
                var txtChallanPaidDate = document.getElementById("<%=txtChallanPaidDate.ClientID%>");
                var ddlDataAuditType = document.getElementById("<%=ddlDataAuditType.ClientID%>");
                var months = document.getElementById("<%=ddlCuMonth.ClientID%>");
                var country = document.getElementById("<%=ddlCountries.ClientID%>");
                var Frm27DedQuarter = document.getElementById("<%=ddlFrm27DedQuarter.ClientID%>");
                var CDandDDCust = document.getElementById("<%=txtCDandDDCust.ClientID%>");
                var CDandDDPan = document.getElementById("<%=txtCDandDDPan.ClientID%>");
                var CDandDDForm = document.getElementById("<%=ddlCDandForm.ClientID%>");
                var CDandDDQuarter = document.getElementById("<%=ddlCDandDDQuarter.ClientID%>");
                switch (selectedIdex) {
                    case "0":
                    case "13":
                        if (date.value == "") { alert("Specify the date to preview."); document.getElementById("<%=btnPreview.ClientID%>").value = "Preview"; return false; }
                        if (!ValidateDate()) { return false; }
                        break;
                    case "1":
                        if (datewise.checked) {
                            if (date.value == "") { alert("Specify the date to preview."); document.getElementById("<%=btnPreview.ClientID%>").value = "Preview"; return false; }
                            if (!ValidateDate()) { return false; }
                        }
                        if (monthwise.checked) {
                            if (month.value == "-1") { alert("Select month to preview"); document.getElementById("<%=btnPreview.ClientID%>").value = "Preview"; return false; }
                        } break;
                    case "4":
                        if (monthFrom.value == "-1") { alert("Select from Month."); document.getElementById("<%=btnPreview.ClientID%>").value = "Preview"; return false; }
                        if (monthTo.value == "-1") { alert("Select to Month."); document.getElementById("<%=btnPreview.ClientID%>").value = "Preview"; return false; }
                        break;
                    case "5":
                        if (quarter.value == "-1") { alert("Select quarter"); document.getElementById("<%=btnPreview.ClientID%>").value = "Preview"; return false; }
                        break;
                    case "6":
                        if (dateFrom.value == "") { alert("Specify From Date"); document.getElementById("<%=btnPreview.ClientID%>").value = "Preview"; return false; }
                        if (!ValidateDates(dateFrom)) { return false; }
                        if (dateTo.value == "") { dateTo.value = dateFrom.value; }
                        if (!ValidateDates(dateTo)) { return false; }
                        break;
                    case "27":
                        if (document.getElementById("<%=rbtnDateWise.ClientID%>").checked) {
                            if (dateFrom.value == "") { alert("Specify From Date"); document.getElementById("<%=btnPreview.ClientID%>").value = "Preview"; dateFrom.focus(); return false; }
                            if (!ValidateDates(dateFrom)) { dateFrom.focus(); return false; }
                            if (dateTo.value == "") { dateTo.value = dateFrom.value; }
                            if (!ValidateDates(dateTo)) { dateTo.focus(); return false; }
                        }
                        else {
                            if (document.getElementById("<%=ddlMonth.ClientID%>").value == "-1") {
                                alert("Select month."); document.getElementById("<%=btnPreview.ClientID%>").value = "Preview";
                                document.getElementById("<%=ddlMonth.ClientID%>").focus();
                                return false;
                            }
                        }
                        break;
                    case "7":
                    case "8":
                    case "14":
                        if (monthFrom.value == "-1") { alert("Select from month."); document.getElementById("<%=btnPreview.ClientID%>").value = "Preview"; return false; }
                        if (monthTo.value == "-1") { alert("Select to month."); document.getElementById("<%=btnPreview.ClientID%>").value = "Preview"; return false; }
                        break;
                    case "9":
                    case "10":
                    case "11":
                        if (dateFrom.value == "") { alert("Specify From Date"); document.getElementById("<%=btnPreview.ClientID%>").value = "Preview"; return false; }
                        if (!ValidateDates(dateFrom)) { return false; }
                        if (dateTo.value == "") { dateTo.value = dateFrom.value; }
                        if (!ValidateDates(dateTo)) { return false; }
                        break;
                    case "12":
                        if (ddMonth.value == "-1") { alert("Select month to preview"); document.getElementById("<%=btnPreview.ClientID%>").value = "Preview"; return false; }
                        break;
                    case "15":
                        if (txtSelectDate.value == "") { alert("Specify Date."); document.getElementById("<%=btnPreview.ClientID%>").value = "Preview"; return false; }
                        break;
                    case "16":
                        if (txtSelectDate.value == "") { alert("Specify Date."); document.getElementById("<%=btnPreview.ClientID%>").value = "Preview"; return false; }
                        break;
                    case "22":
                        if (txtSelectDate.value == "") { alert("Specify Date."); document.getElementById("<%=btnPreview.ClientID%>").value = "Preview"; return false; }
                        break;
                    case "18":
                    case "60":
                        if (dateFrom.value == "") { alert("Specify From Date"); document.getElementById("<%=btnPreview.ClientID%>").value = "Preview"; return false; }
                        if (!ValidateDates(dateFrom)) { return false; }
                        if (dateTo.value == "") { dateTo.value = dateFrom.value; }
                        if (!ValidateDates(dateTo)) { return false; }
                        break;
                    case "29":
                        if (ddlDeductorType.value == "-1") { alert("Select Search Type to Preview"); document.getElementById("<%=btnPreview.ClientID%>").value = "Preview"; return false; }
                        if (txtSearchType.value == "") { alert("Specify Text"); document.getElementById("<%=btnPreview.ClientID%>").value = "Preview"; return false; }
                        break;
                    case "30":
                        if (quarter.value == "-1") { alert("Please select quarter."); document.getElementById("<%=btnPreview.ClientID%>").value = "Preview"; return false }
                        break;
                    case "31":
                        if (month.value == "-1") { alert("Please select month."); document.getElementById("<%=btnPreview.ClientID%>").value = "Preview"; return false }
                        break;
                    case "32":
                        if (quarter.value == "-1") { alert("Please select quarter."); document.getElementById("<%=btnPreview.ClientID%>").value = "Preview"; return false }
                        break;
                    case "33":
                        if (quarter.value == "-1") { alert("Please select quarter."); document.getElementById("<%=btnPreview.ClientID%>").value = "Preview"; return false }
                        break;
                    case "34":
                        if (txtDedDate.value == "") { alert("Please Enter Deduction Date."); document.getElementById("<%=btnPreview.ClientID%>").value = "Preview"; return false; }
                        break;
                    case "35":
                        if (txtPaymentDate.value == "") { alert("Please Enter Deduction Date."); document.getElementById("<%=btnPreview.ClientID%>").value = "Preview"; return false; }
                        break;
                    case "37":
                        if (quarter.value == "-1") { alert("Please select quarter."); document.getElementById("<%=btnPreview.ClientID%>").value = "Preview"; return false }
                        break;
                    case "38":
                        if (txtDedDate.value == "") { alert("Please Enter Deduction Date."); document.getElementById("<%=btnPreview.ClientID%>").value = "Preview"; return false }
                        break;
                    case "39":
                        if (month.value == "-1") { alert("Please select month."); document.getElementById("<%=btnPreview.ClientID%>").value = "Preview"; return false }
                        break;
                    case "40":
                        if (ddlDataAuditType.value == "-1") { alert("Please Select Audit Type"); document.getElementById("<%=btnPreview.ClientID%>").value = "Preview"; return false; }
                        if (dateFrom.value == "") { alert("Specify From Date"); document.getElementById("<%=btnPreview.ClientID%>").value = "Preview"; return false; }
                        if (dateTo.value == "") { dateTo.value = dateFrom.value; }
                        break;
                    case "41":
                        document.getElementById("<%=btnPreview.ClientID%>").value = "Preview";
                        break;
                    case "42":
                        if (month.value == "-1") { alert("Please select month."); document.getElementById("<%=btnPreview.ClientID%>").value = "Preview"; return false }
                        if (!ValidateLength(document.getElementById("<%=txtBranchCode.ClientID%>"), "Branch Name", 75, false)) return false;
                        if (document.getElementById("<%=hdnBranchID.ClientID%>").value == -1) {
                            document.getElementById("<%=txtBranchCode.ClientID%>").focus();
                            document.getElementById("<%=txtBranchCode.ClientID%>").select();
                            if (document.getElementById("<%=txtBranchCode.ClientID%>").value.length > 0) {
                                document.getElementById("<%=btnPreview.ClientID%>").value = "Preview";
                                alert("Specified Branch Office does not exist."); return false;
                            }
                        }
                        break;
                    case "43":
                        if (month.value == "-1") { alert("Please select month."); document.getElementById("<%=btnPreview.ClientID%>").value = "Preview"; return false }
                        if (!ValidateLength(document.getElementById("<%=txtBranchCode.ClientID%>"), "Branch Name", 75, false)) return false;
                        if (document.getElementById("<%=hdnBranchID.ClientID%>").value == -1) {
                            document.getElementById("<%=txtBranchCode.ClientID%>").focus();
                            document.getElementById("<%=txtBranchCode.ClientID%>").select();
                            if (document.getElementById("<%=txtBranchCode.ClientID%>").value.length > 0) {
                                document.getElementById("<%=btnPreview.ClientID%>").value = "Preview";
                                alert("Specified Branch Office does not exist."); return false;
                            }
                        }
                        break;
                    case "44":
                        document.getElementById("<%=btnPreview.ClientID%>").value = "Preview";
                        if (month.value == "-1") { alert("Please select month."); document.getElementById("<%=btnPreview.ClientID%>").value = "Preview"; return false }
                        break;
                    case "45":
                        document.getElementById("<%=btnPreview.ClientID%>").value = "Preview";
                        break;
                    case "46":
                        if (document.getElementById("<%=rdbDateWise.ClientID%>").checked) {
                            if (dateFrom.value == "") { alert("Specify From Date"); document.getElementById("<%=btnPreview.ClientID%>").value = "Preview"; return false; }
                            if (dateTo.value == "") { dateTo.value = dateFrom.value; }
                        }
                        else {
                            if (quarter.value == "-1") { alert("Please select quarter."); document.getElementById("<%=btnPreview.ClientID%>").value = "Preview"; return false }
                        }
                        break;
                    case "47":
                    case "48":
                    case "49":
                    case "50":
                    case "51":
                    case "59":
                        if (month.value == "-1") { alert("Please select month."); document.getElementById("<%=btnPreview.ClientID%>").value = "Preview"; return false }
                        break;
                    case "52":
                        if (month.value == "-1") { alert("Please select month."); document.getElementById("<%=btnPreview.ClientID%>").value = "Preview"; return false }
                        if (!ValidateLength(document.getElementById("<%=txtBranchCode.ClientID%>"), "Branch Name", 75, false)) return false;
                        if (document.getElementById("<%=hdnBranchID.ClientID%>").value == -1) {
                            document.getElementById("<%=txtBranchCode.ClientID%>").focus();
                            document.getElementById("<%=txtBranchCode.ClientID%>").select();
                            if (document.getElementById("<%=txtBranchCode.ClientID%>").value.length > 0) {
                                document.getElementById("<%=btnPreview.ClientID%>").value = "Preview";
                                alert("Specified Branch Office does not exist."); return false;
                            }
                        }
                        break;
                    case "53":
                        if (txtChallanPaidDate.value == "") { alert("Please Enter Challan Paid Date."); document.getElementById("<%=btnPreview.ClientID%>").value = "Preview"; return false; }
                        break;
                    case "54":
                        if (txtChallanPaidDate.value == "") { alert("Please Enter Challan Paid Date."); document.getElementById("<%=btnPreview.ClientID%>").value = "Preview"; return false; }
                        break;
                    case "55":
                        if (txtChallanPaidDate.value == "") { alert("Please Enter Challan Paid Date."); document.getElementById("<%=btnPreview.ClientID%>").value = "Preview"; return false; }
                        break;
                    case "56":
                        if (month.value == "-1") { alert("Please select month."); document.getElementById("<%=btnPreview.ClientID%>").value = "Preview"; return false }
                        break;
                    case "57":
                        if (month.value == "-1") { alert("Please select month."); document.getElementById("<%=btnPreview.ClientID%>").value = "Preview"; return false }
                        break;
                    case "58":
                        if (month.value == "-1") { alert("Please select month."); document.getElementById("<%=btnPreview.ClientID%>").value = "Preview"; return false }
                        if (document.getElementById("<%=txtBranchCode.ClientID%>").value == "") {
                            document.getElementById("<%=btnPreview.ClientID%>").value = "Preview";
                            alert("Please Enter Branch Code"); return false;
                        }
                        break;
                    case "64":
                        var objddl = document.getElementById("<%=ddlCU_ReportType.ClientID%>");
                        var objtext = document.getElementById("<%=txtCU_BranchCode.ClientID%>");
                        if (objddl.options[objddl.selectedIndex].text != "All" &&
                            document.getElementById("<%=txtCU_BranchCode.ClientID%>").value == "") {
                            document.getElementById("<%=btnPreview.ClientID%>").value = "Preview";
                            alert("Branch Code cannot be blank..");
                            return false;
                        }
                        break;
                    case "65":
                        if (document.getElementById("<%=txtSFITDSBranchCode.ClientID%>").value == "") { alert("Please Enter 'Branch Code'"); document.getElementById("<%=btnPreview.ClientID%>").value = "Preview"; document.getElementById("<%=txtSFITDSBranchCode.ClientID%>").focus(); return false; }
                        if (document.getElementById("<%=txtSFITDSFromDate.ClientID%>").value == "") { alert("Please Enter 'From Date'"); document.getElementById("<%=btnPreview.ClientID%>").value = "Preview"; document.getElementById("<%=txtSFITDSFromDate.ClientID%>").focus(); return false; }
                        if (document.getElementById("<%=txtSFITDSToDate.ClientID%>").value == "") { alert("Please Enter 'To Date'"); document.getElementById("<%=btnPreview.ClientID%>").value = "Preview"; document.getElementById("<%=txtSFITDSToDate.ClientID%>").focus(); return false; }
                        break;
                    case "66":
                        if (month.value == "-1") { alert("Please select month."); document.getElementById("<%=btnPreview.ClientID%>").value = "Preview"; return false }
                        break;
                    case "67":
                        if (quarter.value == "-1") { alert("Please select quarter."); document.getElementById("<%=btnPreview.ClientID%>").value = "Preview"; return false }
                        break;
                    case "69":
                        if (quarter.value == "-1") { alert("Please select quarter."); document.getElementById("<%=btnPreview.ClientID%>").value = "Preview"; return false }
                        break;
                    case "70":
                        if (months.value == "-1") { alert("Please select month."); document.getElementById("<%=btnPreview.ClientID %>").value = "Preview"; return false }
                        break;
                    case "71":
                        if (quarter.value == "-1") { alert("Please select quarter."); document.getElementById("<%=btnPreview.ClientID%>").value = "Preview"; return false }
                        break;
                    case "72":
                        if (dateFrom.value != "" && dateTo.value == "") { alert("Specify To Date"); document.getElementById("<%=btnPreview.ClientID%>").value = "Preview"; return false; }
                        if (!ValidateDates(dateFrom)) { return false; }
                        if (dateFrom.value == "" && dateTo.value != "") { alert("Specify From Date"); document.getElementById("<%=btnPreview.ClientID%>").value = "Preview"; return false; }
                        if (!ValidateDates(dateTo)) { return false; }
                        break;
                    case "74":
                        if (quarter.value == "-1") { alert("Please select quarter."); document.getElementById("<%=btnPreview.ClientID%>").value = "Preview"; return false }
                        break;
                    case "75":
                        var TDSRecReportQtr = document.getElementById("<%=ddlTDSRecReportQtr.ClientID%>");
                        if (TDSRecReportQtr.value == "-1") { alert("Please select quarter."); document.getElementById("<%=btnPreview.ClientID%>").value = "Preview"; return false }
                        break;
                    case "76":
                        if (Frm27DedQuarter.value == "-1") { alert("Please select quarter."); document.getElementById("<%=btnPreview.ClientID%>").value = "Preview"; return false }
//                        if (country.value == "-1") { alert("Please select Country."); document.getElementById("<%=btnPreview.ClientID%>").value = "Preview"; return false }
                        break;
                    case "77":
                        if (dateFrom.value == "" && dateTo.value == "") { alert("Specify Date"); document.getElementById("<%=btnPreview.ClientID%>").value = "Preview"; return false; }
                        if (dateFrom.value != "" && dateTo.value == "") { alert("Specify To Date"); document.getElementById("<%=btnPreview.ClientID%>").value = "Preview"; return false; }
                        if (!ValidateDates(dateFrom)) { return false; }
                        if (dateFrom.value == "" && dateTo.value != "") { alert("Specify From Date"); document.getElementById("<%=btnPreview.ClientID%>").value = "Preview"; return false; }
                        if (!ValidateDates(dateTo)) { return false; }
                        break;
                    case "79":                        
                        if (CDandDDCust.value == "" && CDandDDPan.value == "") { alert("Specify CustomerID or PAN"); document.getElementById("<%=btnPreview.ClientID%>").value = "Preview"; return false; }
                        if (CDandDDForm.value == "-1") { alert("Please select Form."); document.getElementById("<%=btnPreview.ClientID%>").value = "Preview"; return false; }
                        if (CDandDDQuarter.value == "-1") { alert("Please select Quarter."); document.getElementById("<%=btnPreview.ClientID%>").value = "Preview"; return false; }                        
                        break;
                }
                return true;
            }
            else {
                return false;
            }
        }
        function ClearValues() {
            var txtDate = document.getElementById("<%=txtSelectDate.ClientID%>");
            var monthFrom = document.getElementById("<%=ddlMonthFrom.ClientID%>");
            var monthTo = document.getElementById("<%=ddlMonthTo.ClientID%>");
            var quarter = document.getElementById("<%=ddlQuarter.ClientID%>");
            var dateFrom = document.getElementById("<%=txtFromDate.ClientID%>");
            var dateTo = document.getElementById("<%=txtToDate.ClientID%>");
            var rbtnDateWise = document.getElementById("<%=rbtnDateWise.ClientID%>");
            var rbtnMonthWise = document.getElementById("<%=rbtnMonthWise.ClientID%>");
            var month = document.getElementById("<%=ddlMonth.ClientID%>");
            var dedType = document.getElementById("<%=ddlDeductorType.ClientID%>");
            var searchText = document.getElementById("<%=txtSearchText.ClientID%>");
            var paymentDate = document.getElementById("<%=txtPaymentDate.ClientID %>");
            var branchCode = document.getElementById("<%=txtBranchCode.ClientID %>");
            var months = document.getElementById("<%=ddlCuMonth.ClientID%>");
            var txtRefNo = document.getElementById("<%=txtCU_ReferenceNo.ClientID%>");
            txtDate.value = ""; monthFrom.value = "-1"; monthTo.value = "-1";
            quarter.value = "-1"; dateFrom.value = ""; dateTo.value = "";
            rbtnDateWise.checked = true; rbtnMonthWise.checked = false; month.value = "-1";
            dedType.value = "-1"; searchText.value = ""; paymentDate.value = "";
            branchCode.value = ""; months.value = "-1"; txtRefNo.value = "";
        }
        function ClearControls() {
            var month = document.getElementById("<%=ddlMonth.ClientID%>");
            var dateFrom = document.getElementById("<%=txtFromDate.ClientID%>");
            var dateTo = document.getElementById("<%=txtToDate.ClientID%>");
            month.value = "-1"; dateFrom.value = ""; dateTo.value = "";
        }
        function HideRow(objRow) { objRow.style.display = 'none'; }
        function DisplayRow(objRow) { objRow.style.display = ''; }
        function HideControls() {
            rowShortFallInTDS.style.display = 'none';
        }
        function DisplayControls(objValue) {
            rowPreviewButton.style.display = '';
            var selectedValue = document.getElementById("<%=lstReportType.ClientID%>").value;
            var selectedIdex = document.getElementById("<%=lstReportType.ClientID%>").selectedIndex;
            var IsSuperAdmin = document.getElementById("<%=hdnIsSuperAdmin.ClientID%>").value;
            var IsChildBranch = document.getElementById("<%=hdnIsChildBranch.ClientID%>").value;

            if (document.getElementById("<%=txtLD_BranchCodes.ClientID%>") != null)
                document.getElementById("<%=txtLD_BranchCodes.ClientID%>").value = "";
            if (document.getElementById("<%=txtLD_TanLists.ClientID%>") != null)
                document.getElementById("<%=txtLD_TanLists.ClientID%>").value = "";

            if (document.getElementById("<%=hlinkDownloadFile.ClientID%>") != null)
                var downLoad = document.getElementById("<%=hlinkDownloadFile.ClientID%>");

            if (selectedValue != 65) {
                if (document.getElementById("<%=txtSFITDSBranchCode.ClientID%>") != null)
                    document.getElementById("<%=txtSFITDSBranchCode.ClientID%>").value = "";
                if (document.getElementById("<%=txtSFITDSFromDate.ClientID%>") != null)
                    document.getElementById("<%=txtSFITDSFromDate.ClientID%>").value = "";
                if (document.getElementById("<%=txtSFITDSToDate.ClientID%>") != null)
                    document.getElementById("<%=txtSFITDSToDate.ClientID%>").value = "";
            }
            rowDate.style.display = 'none'; rowMonthWise.style.display = 'none';
            rowMonthRange.style.display = 'none'; rowQuarter.style.display = 'none';
            rowDateRange.style.display = 'none'; rowMonth.style.display = 'none';
            rowBranchWise.style.display = 'none'; rowDeducteeType.style.display = 'none';
            rowZORO.style.display = 'none'; rowButton.style.paddingTop = "192px";
            rowDownLoad.style.paddingTop = "192px"; rowDeductorType.style.display = 'none';
            rowSearchText.style.display = 'none'; rowReportType.style.display = 'none';
            rdbReportType.style.display = 'none'; rowDataAuditWise.style.display = 'none';
            rowForm3CD.style.display = 'none'; rowURNDetails.style.display = 'none';
            rowDeductionDate.style.display = 'none'; rowPaymentDate.style.display = 'none';
            rowBranch.style.display = 'none'; rowSection.style.display = 'none';
            rowTracesPassword.style.display = 'none'; rowChallanUnutilised.style.display = 'none';
            rowTracesReport.style.display = 'none'; rowTDSReconsiliationReport.style.display = 'none';
            reportType.style.display = 'none'; rowVendorPaymentType.style.display = 'none';
            rowChallanNotEntered.style.display = 'none';
            rowShortFallInTDS.style.display = 'none';
            rowCustomerReferenceNo.style.display = 'none';
            rowLowerDeductions.style.display = 'none';
            rowForm27Deductions.style.display = 'none';
            row197CertificateIncomplete.style.display = 'none';
            rowCDandDDInformation.style.display = 'none';
            rowCDandDDCusPan.style.display = 'none';
            rowCDandDDFrmQtr.style.display = 'none';
            if (document.getElementById("<%=hlinkDownloadFile.ClientID%>") != null) {
                if (downLoad != null)
                    downLoad.style.display = 'none';
            }

            rowChallanPaidDate.style.display = 'none';
            switch (selectedValue) {
                case "0":
                case "13":
                case "15":
                case "22":
                    rowButton.style.paddingTop = "166px"; rowDate.style.display = '';
                    if (downLoad != null && selectedValue == "13") {
                        var hrefdownLoad = downLoad.href; var lastindex = hrefdownLoad.lastIndexOf("\\");
                        hrefdownLoad = hrefdownLoad.substring(lastindex + 1);
                        if (hrefdownLoad == "RemittanceMade.txt") { downLoad.style.display = ''; rowDownLoad.style.paddingTop = "166px"; }
                    }
                    break;
                case "1":
                    rowButton.style.paddingTop = "145px"; rowReportType.style.display = ''; rowDate.style.display = '';
                    break;
                case "4":
                case "7":
                case "8":
                case "14":
                    rowButton.style.paddingTop = "166px";
                    rowMonthRange.style.display = '';
                    if (downLoad != null && selectedValue == "14") {
                        var hrefdownLoad = downLoad.href; var lastindex = hrefdownLoad.lastIndexOf("\\");
                        hrefdownLoad = hrefdownLoad.substring(lastindex + 1);
                        if (hrefdownLoad == "ToBeRemitted.txt") {
                            downLoad.style.display = ''; rowDownLoad.style.paddingTop = "166px";
                        }
                    }
                    break;
                case "5": rowButton.style.paddingTop = "166px"; rowQuarter.style.display = ''; break;
                case "6":
                case "9":
                case "10":
                case "11":
                case "18":
                case "60": rowButton.style.paddingTop = "166px"; rowDateRange.style.display = ''; break;
                case "12":
                    rowButton.style.paddingTop = "166px"; rowMonth.style.display = '';
                    if (downLoad != null) {
                        var hrefdownLoad = downLoad.href; var lastindex = hrefdownLoad.lastIndexOf("\\");
                        hrefdownLoad = hrefdownLoad.substring(lastindex + 1);
                        if (hrefdownLoad == "DedFromFinacle.txt") downLoad.style.display = ''; rowDownLoad.style.paddingTop = "166px";
                    }
                    break;
                case "16":
                    rowButton.style.paddingTop = "145px"; rowBranchWise.style.display = ''; rowDate.style.display = '';
                    if (IsSuperAdmin == "0") { rowBranchWise.style.display = 'none'; rowButton.style.paddingTop = "169px"; }
                    break;
                case "17":
                    rowButton.style.paddingTop = "145px"; rowBranchWise.style.display = ''; rowMonthWise.style.display = '';
                    if (IsSuperAdmin == "0") { rowButton.style.paddingTop = "166px"; rowBranchWise.style.display = 'none'; }
                    break;
                case "23": rowButton.style.paddingTop = "168px"; rowDeducteeType.style.display = ''; break;
                case "25": rowButton.style.paddingTop = "143px"; rowMonthWise.style.display = ''; rowZORO.style.display = ''; break;
                case "27": rowButton.style.paddingTop = "145px"; rowReportType.style.display = ''; rowDateRange.style.display = ''; break;
                case "28": rowButton.style.paddingTop = "192px"; break;
                case "29": rowButton.style.paddingTop = "140px"; rowDeductorType.style.display = ''; rowSearchText.style.display = ''; break;
                case "30": rowButton.style.paddingTop = "75px"; rowQuarter.style.display = ''; rdbReportType.style.display = ''; break;
                case "31": rowMonthWise.style.display = ''; rowButton.style.paddingTop = "166px"; break;
                case "32": rowQuarter.style.display = ''; rowButton.style.paddingTop = "166px"; break;
                case "33": rowQuarter.style.display = ''; rowButton.style.paddingTop = "166px"; break;
                case "34":
                    rowDeductionDate.style.display = ''; rowURNDetails.style.display = '';
                    rowPaymentDate.style.display = 'none'; rowButton.style.paddingTop = "140px";
                    rowDownLoad.style.paddingTop = "140px"; document.getElementById("<%=lstReportType.ClientID%>").style.height = "225px";
                    if (downLoad != null) downLoad.style.display = '';
                    break;
                case "35":
                    rowDeductionDate.style.display = 'none'; rowURNDetails.style.display = 'none';
                    rowPaymentDate.style.display = ''; rowButton.style.paddingTop = "170px";
                    break;
                case "36":
                    rowDeductionDate.style.display = 'none'; rowURNDetails.style.display = 'none';
                    rowPaymentDate.style.display = 'none'; rowButton.style.paddingTop = "196px";
                    break;
                case "37":
                    rowDeductionDate.style.display = 'none'; rowURNDetails.style.display = 'none';
                    rowPaymentDate.style.display = 'none'; rowQuarter.style.display = '';
                    rowButton.style.paddingTop = "170px";
                    break;
                case "38":
                    rowDeductionDate.style.display = ''; rowURNDetails.style.display = 'none';
                    rowPaymentDate.style.display = 'none'; rowQuarter.style.display = 'none';
                    rowButton.style.paddingTop = "170px";
                    break;
                case "39":
                    rowMonthWise.style.display = ''; rowButton.style.paddingTop = "166px";
                    if (downLoad != null) downLoad.style.display = '';
                    rowDownLoad.style.paddingTop = "166px";
                    break;
                case "40": rowDataAuditWise.style.display = ''; rowButton.style.paddingTop = "166px"; rowDateRange.style.display = ''; break;
                case "41": rowForm3CD.style.display = ''; break;
                case "42": rowMonthWise.style.display = ''; rowBranch.style.display = ''; rowSection.style.display = ''; break;
                case "43": rowMonthWise.style.display = ''; rowBranch.style.display = ''; break;
                case "44": rowMonthWise.style.display = ''; break;
                case "45": rowButton.style.paddingTop = "192px"; break;
                case "46": reportType.style.display = ''; rowSection.style.display = ''; ShowHideQuarter(); break;
                case "47": rowChallanNotEntered.style.display = ''; rowMonthWise.style.display = ''; break;
                case "48": rowVendorPaymentType.style.display = ''; rowMonthWise.style.display = ''; break;
                case "49":
                case "50":
                case "51":
                case "59":
                    rowMonthWise.style.display = '';
                    if (downLoad != null) downLoad.style.display = '';
                    break;
                case "52": rowMonthWise.style.display = ''; rowBranch.style.display = ''; rowSection.style.display = 'none'; break;
                case "53":
                    rowChallanPaidDate.style.display = ''; break;
                case "54":
                    rowChallanPaidDate.style.display = ''; break;
                case "55":
                    rowChallanPaidDate.style.display = ''; break;
                case "56":
                case "57":
                case "58":
                    rowMonthWise.style.display = '';

                    if (selectedValue == "57")
                        document.getElementById("<%=lblMonth.ClientID%>").innerHTML = " Select Deducted Month:"
                    else
                        document.getElementById("<%=lblMonth.ClientID%>").innerHTML = " Select Month:"
                    if (downLoad != null) downLoad.style.display = '';
                    if (selectedValue == "58") {
                        rowBranch.style.display = '';
                        //                        if (IsSuperAdmin == "1")
                        //                            rowBranch.style.display = 'none';
                        //                        else {
                        //                            rowBranch.style.display = '';
                        //                            document.getElementById("<%=txtBranchCode.ClientID%>").style.background = "White";
                        //                        }
                    }
                    break;
                case "61":
                    rowTracesReport.style.display = '';
                    var Traces_BranchCode = document.getElementById("<%=txtTraces_BranchCode.ClientID%>");
                    var Traces_Form = document.getElementById("<%=ddlTraces_Form.ClientID%>");
                    var Traces_Quarter = document.getElementById("<%=ddlTraces_Quarter.ClientID%>");
                    Traces_BranchCode.value = "";
                    Traces_Form.value = 0;
                    Traces_Quarter.value = 0;
                    if (document.getElementById("<%=hlinkErrorFile.ClientID%>") != null)
                        document.getElementById("<%=hlinkErrorFile.ClientID%>").style.display = 'none';
                    break;
                case "62":
                    var var_reqFile = document.getElementById("<%=reqFile.ClientID%>");
                    var_reqFile.style.display = 'none';
                    rowTracesPassword.style.display = '';
                    rowPreviewButton.style.display = 'none';
                    break;
                case "64":
                    rowChallanUnutilised.style.display = '';
                    var objddl = document.getElementById("<%=ddlCU_ReportType.ClientID%>");
                    var objtext = document.getElementById("<%=txtCU_BranchCode.ClientID%>");
                    objddl.selectedIndex = 0;
                    objtext.setAttribute("disabled", true);
                    document.getElementById("<%=txtCU_BranchCode.ClientID%>").value = "";
                    break;
                case "65":
                    rowShortFallInTDS.style.display = '';
                    break;
                case "66":
                    rowMonthWise.style.display = '';
                    if (downLoad != null) downLoad.style.display = '';
                    break;
                case "67": rowQuarter.style.display = ''; rowButton.style.paddingTop = "166px";
                    break;
                case "69": rowQuarter.style.display = ''; rowButton.style.paddingTop = "166px";
                    break;
                case "70": rowCustomerReferenceNo.style.display = '';
                    break;
                case "71": ShowHideQuarter();
                    //if (downLoad != null) downLoad.style.display = '';
                    break;
                case "72": rowButton.style.paddingTop = "166px"; rowDateRange.style.display = '';
                    rowLowerDeductions.style.display = '';
                    rowLowerDeductionsLowerDeductions.style.display = '';
                    break;
                case "73": rowLowerDeductions.style.display = '';
                    rowLowerDeductionsLowerDeductions.style.display = 'none';
                    break;
                case "74":
                    rowQuarter.style.display = ''; rowButton.style.paddingTop = "166px";
                    break;
                case "75":
                    rowTDSReconsiliationReport.style.display = '';
                    var TDSRecReportQtr = document.getElementById("<%=ddlTDSRecReportQtr.ClientID%>");
                    TDSRecReportQtr.value = -1;
                    break;
                case "76":
                    rowForm27Deductions.style.display = '';
                    break;
                case "77":
                    rowButton.style.paddingTop = "166px"; rowDateRange.style.display = '';
                    break;
                case "78":
                    row197CertificateIncomplete.style.display = '';
                    document.getElementById("<%=txt197CertificateBranchCode.ClientID%>").value = "";
                    document.getElementById("<%=txt197CertificateCertificateNo.ClientID%>").value = "";
                    break;
                case "79":
                    rowButton.style.paddingTop = "166px"; rowCDandDDInformation.style.display = '';
                    rowCDandDDCusPan.style.display = '';
                    rowCDandDDFrmQtr.style.display = '';                    
                    document.getElementById("<%=txtCDandDDCust.ClientID%>").value = "";
                    document.getElementById("<%=txtCDandDDPan.ClientID%>").value = "";
                    document.getElementById("<%=ddlCDandForm.ClientID%>").value = "-1";
                    document.getElementById("<%=ddlCDandDDQuarter.ClientID%>").value = "-1";
                    break;

            }
            if (selectedValue != "")
                document.getElementById("<%=lblSelectedRpt.ClientID%>").innerHTML = "Selected Report : " + " " + "<b>" + document.getElementById("<%=lstReportType.ClientID%>")[selectedIdex].text + "</b>";
        }
        function ShowAlert() { alert("No data to print."); document.getElementById("<%=btnPreview.ClientID%>").value = "Preview"; return false; }
        function ShowControls(objValue) {
            var selectedValue = document.getElementById("<%=lstReportType.ClientID%>").value;
            if (selectedValue == 1 || selectedValue == 27) {
                var selectedValue = document.getElementById("<%=lstReportType.ClientID%>").value;
                rowDate.style.display = 'none'; rowMonthWise.style.display = 'none'; rowDateRange.style.display = 'none';
                if (selectedValue == 1) {
                    if (objValue == 1) { rowDate.style.display = ''; }
                    else { rowMonthWise.style.display = ''; }
                }
                else if (selectedValue == 27) {
                    if (objValue == 1) { rowDateRange.style.display = ''; }
                    else { rowMonthWise.style.display = ''; }
                }
            }
        }
        function EnableDisable(objValue) {
            var ddlMonth = document.getElementById("<%=ddlMonth.ClientID%>");
            var txtDate = document.getElementById("<%=txtSelectDate.ClientID%>");
            var lblDate = document.getElementById("<%=lblDate.ClientID%>");
            var lblMonth = document.getElementById("<%=lblMonth.ClientID%>");
            var datewise = document.getElementById("<%=rbtnDateWise.ClientID%>");
            var monthwise = document.getElementById("<%=rbtnMonthWise.ClientID%>");
            var rowDate = document.getElementById("rowDate");
            var rowMonth = document.getElementById("rowMonthWise");
            if (objValue == 1) {
                datewise.checked = true;
                monthwise.checked = false;
                rowDate.disabled = false;
                rowMonth.disabled = true;
                txtDate.disabled = false;
                ddlMonth.value = "-1";
            }
            else if (objValue == 2) {
                datewise.checked = false;
                monthwise.checked = true;
                rowDate.disabled = true;
                rowMonth.disabled = false;
                txtDate.disabled = true;
                txtDate.value = "";
            }
        }
        function ClearQuarterSelection() { var quarter = document.getElementById("<%=ddlQuarter.ClientID%>"); quarter.value = "-1"; }
        function ClearDownloadLink() {
            if (document.getElementById("<%=hlinkDownloadFile.ClientID%>") != null)
                document.getElementById("<%=hlinkDownloadFile.ClientID%>").style.display = 'none';
        }
        function GetBranchValue(source, eventArgs) {
            BranchId = document.getElementById("<%=hdnBranchID.ClientID%>"); BranchId.value = eventArgs.get_value();
            document.getElementById("<%=txtBranchCode.ClientID%>").value = eventArgs.get_text();
        }
        function ClearBranch() {
            if (event.keyCode == 13 || event.keyCode == 37 || event.keyCode == 38 || event.keyCode == 39 || event.keyCode == 40) {
            }
            else {
                BranchId = document.getElementById("<%=hdnBranchID.ClientID%>"); BranchId.value = "-1";
            }
        }
        function SetSection() {
            var cbl = document.getElementById('<%=cmbTaxSection.ClientID%>');
            var values = ""; var tbody = cbl.childNodes[0];
            var length = (tbody.childNodes.length);
            for (i = 0; i < length; i++) {
                var td = tbody.childNodes[i].childNodes[0];
                var chk = td.childNodes[0];
                if (chk.checked) { values = td.innerText.trim() + "," + values; }
            }
            if (values.indexOf("All") > -1) {
                for (i = 0; i < length; i++) {
                    var td = tbody.childNodes[i].childNodes[0];
                    var chk = td.childNodes[0];
                    if (chk.checked && td.innerText.trim() != 'All') { chk.checked = false; }
                    values = 'All';
                }
            }
            document.getElementById("<%=txtSection.ClientID%>").value = values;
        }
        function ShowHideQuarter() {
            var selectedValue = document.getElementById("<%=lstReportType.ClientID%>").value;
            rowDateRange.style.display = 'none';
            rowQuarter.style.display = 'none';
            if (selectedValue = "46") {
                if (document.getElementById("<%=rdbDateWise.ClientID%>").checked) {
                    rowDateRange.style.display = '';
                    document.getElementById("<%=ddlQuarter.ClientID%>").selectedIndex = 0;
                    document.getElementById("<%=lblQuarter.ClientID%>").style.display = 'none';
                    document.getElementById("<%=ddlQuarter.ClientID%>").style.display = 'none';
                    document.getElementById("<%=txtFromDate.ClientID%>").style.display = '';
                    document.getElementById("<%=txtToDate.ClientID%>").style.display = '';
                }
                else {
                    rowQuarter.style.display = '';
                    document.getElementById("<%=txtFromDate.ClientID%>").value = '';
                    document.getElementById("<%=txtToDate.ClientID%>").value = '';
                    document.getElementById("<%=lblQuarter.ClientID%>").style.display = '';
                    document.getElementById("<%=ddlQuarter.ClientID%>").style.display = '';
                    //                    document.getElementById("<%=txtFromDate.ClientID%>").style.display = 'none';
                    //                    document.getElementById("<%=txtToDate.ClientID%>").style.display = 'none';

                }
            }
        }
        function resetMonth() {
            if (document.getElementById("<%=rbtnEntered.ClientID%>").checked || document.getElementById("<%=rdbDeductionWise.ClientID%>").checked) {
                document.getElementById("<%=ddlMonth.ClientID%>").selectedIndex = 0;
            }
            else {
                document.getElementById("<%=ddlMonth.ClientID%>").selectedIndex = 0;
            }
        }
    </script>
    <style type="text/css">
        .style1
        {
            width: 752px;
        }
         .style2
        {
            width: 336px;
        }
        .mdropDownList
        {
        }
        .txtBPL
        {
        }
        .style7
        {
            width: 510px;
        }        
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentPlaceHolderBody" runat="Server">
    <asp:HiddenField ID="hdnFinYear" runat="server" Value="" />
    <asp:HiddenField ID="hdnIsSuperAdmin" runat="server" Value="0" />
    <asp:HiddenField ID="hdnIsChildBranch" runat="server" Value="0" />
    <asp:UpdatePanel ID="updatepanelReport" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <cc1:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" MinimumPrefixLength="2"
                ServiceMethod="GetCompanyBranches" ServicePath="~/WebServices/AutoCompleteService.asmx"
                TargetControlID="txtBranchCode" CompletionInterval="700" EnableCaching="false"
                CompletionSetCount="20" DelimiterCharacters="" ShowOnlyCurrentWordInCompletionListItem="true"
                FirstRowSelected="True" OnClientItemSelected="GetBranchValue">
            </cc1:AutoCompleteExtender>
            <asp:HiddenField ID="hdnBranchID" Value="-1" runat="server" />
            <asp:Label ID="lblSelectedRpt" runat="server" Text="Selected Report : " Font-Bold="True"></asp:Label>
            <table>
                <tr>
                    <td valign="top">
                        <table>
                            <tr>
                                <td>
                                    <asp:ListBox ID="lstReportType" runat="server" Width="190px" Height="225px" onchange="ClearValues();DisplayControls(1);">
                                        <asp:ListItem Text="Internet Scroll Direct Taxes" Value="0" title="Internet Scroll Direct Taxes"></asp:ListItem>
                                        <asp:ListItem Text="Direct Taxes" Value="1" title="Direct Taxes"></asp:ListItem>
                                        <asp:ListItem Text="Branches having TANAPPLIED / TANNOTAVBL" Value="2" title="Branches having TANAPPLIED / TANNOTAVBL"></asp:ListItem>
                                        <asp:ListItem Text="Branches not having Deductor Details" Value="3" title="Branches not having Deductor Details"></asp:ListItem>
                                        <asp:ListItem Text="Finacle Imported Not Having Deductor Details" Value="4" title="Finacle Imported Not Having Deductor Details"></asp:ListItem>
                                        <asp:ListItem Text="TDS greater than Paid Amount" Value="5" title="TDS greater than Paid Amount"></asp:ListItem>
                                        <asp:ListItem Text="DateWise Remittance" Value="6" title="DateWise Remittance"></asp:ListItem>
                                        <asp:ListItem Text="Pending Payments" Value="7" title="Pending Payments"></asp:ListItem>
                                        <asp:ListItem Text="Payment Made" Value="8" title="Payment Made"></asp:ListItem>
                                        <asp:ListItem Text="TDS less than Rate Specified" Value="9" title="TDS less than Rate Specified"></asp:ListItem>
                                        <asp:ListItem Text="TDS greater than Rate Specified" Value="10" title="TDS greater than Rate Specified"></asp:ListItem>
                                        <asp:ListItem Text="TDS rate is blank" Value="11" title="TDS rate is blank"></asp:ListItem>
                                        <asp:ListItem Text="Branchwise Total Number of Deductions From Finacle" Value="12"
                                            title="Branchwise Total Number of Deductions From Finacle"></asp:ListItem>
                                        <asp:ListItem Text="Branchwise Remittance Made" Value="13" title="Branchwise Remittance Made"></asp:ListItem>
                                        <asp:ListItem Text="Branchwise/Monthwise Deductions to be Remitted" Value="14" title="Branchwise/Monthwise Deductions to be Remitted"></asp:ListItem>
                                        <asp:ListItem Text="TDS Amount – Month" Value="15" title="TDS Amount – Month"></asp:ListItem>
                                        <asp:ListItem Text="TDS Deducted on Specified Date" Value="16" title="TDS Deducted on Specified Date"></asp:ListItem>
                                        <asp:ListItem Text="Monthly Report – Tax Deducted/Remitted" Value="17" title="Monthly Report – Tax Deducted/Remitted"></asp:ListItem>
                                        <asp:ListItem Text="Remittance Detail" Value="18" title="Remittance Detail"></asp:ListItem>
                                        <asp:ListItem Text="TAN List" Value="19" title="TAN List"></asp:ListItem>
                                        <asp:ListItem Text="Pending Report Payment" Value="20" title="Pending Report Payment"></asp:ListItem>
                                        <asp:ListItem Text="Multiple PAN" Value="21" title="Multiple PAN"></asp:ListItem>
                                        <asp:ListItem Text="Challan Transaction Report" Value="22" title="Challan Transaction Report"></asp:ListItem>
                                        <asp:ListItem Text="Deductees having Invalid PAN" Value="23" title="Deductees having Invalid PAN"></asp:ListItem>
                                        <asp:ListItem Text="Branch Details" Value="24" title="Branch Details"></asp:ListItem>
                                        <asp:ListItem Text="Service Tax Input Credit" Value="25" title="Service Tax Input Credit"></asp:ListItem>
                                        <asp:ListItem Text="Employee Earning/Deduction" Value="26" title="Employee Earning/Deduction"></asp:ListItem>
                                        <asp:ListItem Text="BGL Register" Value="27" title="BGL Register"></asp:ListItem>
                                        <asp:ListItem Text="Branches Not Logged in" Value="28" title="Branches not logged in"></asp:ListItem>
                                        <asp:ListItem Text="Deductor Information" Value="29" title="Deductor Information"></asp:ListItem>
                                        <asp:ListItem Text="Data Audit" Value="40" title="Data Audit"></asp:ListItem>
                                        <asp:ListItem Text="Form 3CD" Value="41"></asp:ListItem>
                                        <asp:ListItem Text="Deduction Register(Form26Q)" Value="42"></asp:ListItem>
                                        <asp:ListItem Text="Challan Register" Value="43"></asp:ListItem>
                                        <asp:ListItem Text="TAN List for CSI" Value="45"></asp:ListItem>
                                        <asp:ListItem Text="BA_799 Report" Value="53"></asp:ListItem>
                                        <asp:ListItem Text="BA_798 Report" Value="54"></asp:ListItem>
                                        <asp:ListItem Text="BA_797 Report" Value="55"></asp:ListItem>
                                        <asp:ListItem Text="TAN list for TDS Certificate Extraction" Value="63"></asp:ListItem>
                                        <asp:ListItem Text="PAN list for Form16A Generation" Value="71"></asp:ListItem>
                                    </asp:ListBox>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td style="padding-left: 15px" valign="top">
                        <table>
                            <tr id="reportType" style="display: none">
                                <td>
                                    <asp:RadioButton GroupName="ReportType" Text="Quarter Wise" runat="server" ID="rdbQuarterWise"
                                        Checked="true" onclick="ShowHideQuarter();" />
                                    <asp:RadioButton ID="rdbDateWise" GroupName="ReportType" Text="Date Wise" runat="server"
                                        onclick="ShowHideQuarter();" />
                                </td>
                            </tr>
                            <tr id="rowVendorPaymentType" style="display: none">
                                <td>
                                    <asp:RadioButton GroupName="VendorPayment" Text="Entered" runat="server" ID="rbtnEntered"
                                        Checked="true" onclick="resetMonth();" />
                                    <asp:RadioButton GroupName="VendorPayment" Text="Not Entered" runat="server" ID="rbtnNotEntered"
                                        onclick="resetMonth();" />
                                </td>
                            </tr>
                            <tr id="rowChallanNotEntered" style="display: none">
                                <td>
                                    <asp:RadioButton GroupName="ChallanNotEntered" Text="Deduction Wise" runat="server"
                                        ID="rdbDeductionWise" Checked="true" onclick="resetMonth();" />
                                    <asp:RadioButton GroupName="ChallanNotEntered" Text="Branch Wise" runat="server"
                                        ID="rdbBranchWise" onclick="resetMonth();" />
                                </td>
                            </tr>
                            <tr id="rowBranchWise" style="display: none">
                                <td>
                                    <asp:RadioButton ID="rbtnSummary" runat="server" Text="Zone Details" Checked="true"
                                        GroupName="report" />
                                </td>
                                <td>
                                    <asp:RadioButton ID="rbtnDetailed" runat="server" Text="Branch Details" GroupName="report" />
                                </td>
                                <td colspan="2">
                                </td>
                            </tr>
                            <tr id="rowDataAuditWise" style="display: none">
                                <td>
                                    <table width="400px">
                                        <tr>
                                            <td>
                                                <asp:Label ID="lbldataaudit" runat="server" Text="Data Audit Type:"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlDataAuditType" runat="server" CssClass="mdropDownList" DataTextField="token1"
                                                    DataValueField="token2" Width="300px">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr id="rowReportType" style="display: none">
                                <td>
                                    <asp:RadioButton ID="rbtnDateWise" runat="server" Text="Date Wise" GroupName="a"
                                        onclick="ClearControls();ShowControls(1);" Checked="true" />
                                </td>
                                <td>
                                    <asp:RadioButton ID="rbtnMonthWise" runat="server" Text="Month Wise" GroupName="a"
                                        onclick="ClearControls();ShowControls(2);" />
                                </td>
                                <td colspan="2">
                                </td>
                            </tr>
                            <tr id="rowDate" style="display: none">
                                <td>
                                    <asp:Label ID="lblDate" runat="server" Text="Enter Date :"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtSelectDate" runat="server" CssClass="txtBMR" onBlur="setDateFormat(this);"
                                        Width="158px"></asp:TextBox>
                                </td>
                                <td colspan="2">
                                </td>
                            </tr>
                            <tr id="rowMonthWise" style="display: none">
                                <td>
                                    <asp:Label ID="lblMonth" runat="server" Text=" Select Month :"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlMonth" runat="server" CssClass="mdropDownList" Width="158px">
                                        <asp:ListItem Text="Select" Value="-1"></asp:ListItem>
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
                                <td colspan="2">
                                </td>
                            </tr>
                            <tr id="rowMonthRange" style="display: none">
                                <td>
                                    From Month:
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlMonthFrom" runat="server" CssClass="mdropDownList" Width="120px">
                                        <asp:ListItem Text="Select" Value="-1"></asp:ListItem>
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
                                    To Month:
                                </td>
                                <td>
                                    &nbsp;
                                    <asp:DropDownList ID="ddlMonthTo" runat="server" CssClass="mdropDownList" Width="120px">
                                        <asp:ListItem Text="Select" Value="-1"></asp:ListItem>
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
                            </tr>
                            <tr id="rdbReportType" style="display: none;">
                                <td colspan="3">
                                    <label style="font-weight: bold;">
                                        eReturn Type</label>
                                    <asp:RadioButtonList ID="rdbeReturnInfo" runat="server" onclick="ClearQuarterSelection();">
                                        <asp:ListItem Text="Not Generated or Invalid" Value="1" Selected="True"></asp:ListItem>
                                        <asp:ListItem Text="Generated and Filed" Value="2"></asp:ListItem>
                                        <asp:ListItem Text="Generated but Not Filed" Value="3"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </td>
                            </tr>
                            <tr id="rowQuarter" style="display: none">
                                <td>
                                    <table width="300px">
                                        <tr>
                                            <td width="100px">
                                                <asp:Label ID="lblQuarter" runat="server" Text=" Select Quarter "></asp:Label>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlQuarter" runat="server" CssClass="mdropDownList" Width="163px">
                                                    <asp:ListItem Text="Select" Value="-1"></asp:ListItem>
                                                    <asp:ListItem Text="Quarter1" Value="1"></asp:ListItem>
                                                    <asp:ListItem Text="Quarter2" Value="2"></asp:ListItem>
                                                    <asp:ListItem Text="Quarter3" Value="3"></asp:ListItem>
                                                    <asp:ListItem Text="Quarter4" Value="4"></asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                            <td>
                                                &nbsp;
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr id="rowDateRange" style="display: none">
                                <td>
                                    <table width="300px">
                                        <tr>
                                            <td width="150px">
                                                From Date
                                            </td>
                                            <td width="50px">
                                                <asp:TextBox ID="txtFromDate" runat="server" CssClass="txtBMR" onBlur="setDateFormat(this);"
                                                    Width="80px"></asp:TextBox>
                                            </td>
                                            <td width="100px">
                                                To Date
                                            </td>
                                            <td width="50px">
                                                <asp:TextBox ID="txtToDate" runat="server" CssClass="txtBML" onBlur="setDateFormat(this);"
                                                    Width="80px"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr id="rowMonth" style="display: none">
                                <td>
                                    Month:
                                </td>
                                <td>
                                    <asp:DropDownList ID="drpMonth" runat="server" CssClass="mdropDownList" Width="120px">
                                        <asp:ListItem Text="Select" Value="-1"></asp:ListItem>
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
                                <td colspan="2">
                                </td>
                            </tr>
                            <tr id="rowDeducteeType" style="display: none">
                                <td>
                                    <asp:RadioButton ID="rbtnEmployee" runat="server" Text="Employee" GroupName="deducteeType"
                                        Checked="true" />
                                </td>
                                <td>
                                    <asp:RadioButton ID="rbtnNonEmployee" runat="server" Text="Non-employee" GroupName="deducteeType" />
                                </td>
                                <td colspan="2">
                                </td>
                            </tr>
                            <tr id="rowZORO" style="display: none">
                                <td>
                                    <asp:Label ID="lblZORO" runat="server" Text=" Select ZO/RO :"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlZOROBranches" runat="server" CssClass="mdropDownList" Width="250px">
                                    </asp:DropDownList>
                                </td>
                                <td colspan="2">
                                </td>
                            </tr>
                            <tr id="rowDeductorType" style="display: none">
                                <td>
                                    Search Type :
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlDeductorType" runat="server" CssClass="mdropDownList" Width="184px">
                                        <asp:ListItem Text="Select" Value="-1"></asp:ListItem>
                                        <asp:ListItem Text="Deductor Name" Value="D.DEDUCTORNAME"></asp:ListItem>
                                        <asp:ListItem Text="TAN" Value="D.TAN"></asp:ListItem>
                                        <asp:ListItem Text="Responsible Person Name" Value="R.PERSONNAME"></asp:ListItem>
                                        <asp:ListItem Text="Mobile No" Value="R.MOBILENO"></asp:ListItem>
                                        <asp:ListItem Text="Deductor Email" Value="D.EMAILADDRESS"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td colspan="2">
                                </td>
                            </tr>
                            <tr id="rowSearchText" style="display: none">
                                <td>
                                    Search Text :
                                </td>
                                <td>
                                    <asp:TextBox ID="txtSearchText" runat="server" CssClass="txtBML" Width="180px" MaxLength="75"></asp:TextBox>
                                </td>
                                <td colspan="2">
                                </td>
                            </tr>
                            <tr id="rowURNDetails" style="display: none">
                                <td colspan="2">
                                    <asp:RadioButtonList ID="rdbURNDetails" runat="server" RepeatDirection="Horizontal"
                                        onclick="ClearDownloadLink();">
                                        <asp:ListItem Text="Details" Value="1" Selected="True"></asp:ListItem>
                                        <asp:ListItem Text="Summary" Value="2"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </td>
                                <td colspan="2">
                                </td>
                            </tr>
                            <tr id="rowDeductionDate" style="display: none">
                                <td>
                                    Deduction Date:
                                </td>
                                <td>
                                    <asp:TextBox ID="txtDeductionDate" runat="server" CssClass="txtBML" Width="158px"
                                        onBlur="setDateFormat(this);"></asp:TextBox>
                                </td>
                                <td colspan="2">
                                </td>
                            </tr>
                            <tr id="rowChallanPaidDate" style="display: none">
                                <td>
                                    Challan Paid Date:
                                </td>
                                <td>
                                    <asp:TextBox ID="txtChallanPaidDate" runat="server" CssClass="txtBML" Width="158px"
                                        onBlur="setDateFormat(this);"></asp:TextBox>
                                </td>
                                <td colspan="2">
                                </td>
                            </tr>
                            <tr id="rowPaymentDate" style="display: none">
                                <td>
                                    Payment Date:
                                </td>
                                <td>
                                    <asp:TextBox ID="txtPaymentDate" runat="server" CssClass="txtBML" Width="158px" onBlur="setDateFormat(this);"></asp:TextBox>
                                </td>
                                <td colspan="2">
                                </td>
                            </tr>
                            <tr>
                                <td id="rowForm3CD" style="display: none">
                                    <asp:RadioButton ID="rbtnForm3CD34a" runat="server" Text="Form 3CD 34(a)" Checked="true"
                                        GroupName="Form3CD" />
                                    <asp:RadioButton ID="rbtnForm3CD34b" runat="server" Text="Form 3CD 34(b)" GroupName="Form3CD" />
                                </td>
                            </tr>
                            <tr id="rowBranch" style="display: none">
                                <td style="width: 80px">
                                    Branch
                                </td>
                                <td>
                                    <asp:TextBox ID="txtBranchCode" runat="server" Width="170px" CssClass="txtBMR" onkeyup="ClearBranch()"></asp:TextBox>
                                </td>
                            </tr>
                            <tr id="rowSection" style="display: none">
                                <td>
                                    <table width="200">
                                        <tr>
                                            <td>
                                                <asp:Label ID="ASPxLabel3" runat="server" Text="Section" />
                                            </td>
                                            <td>
                                                <asp:Panel ID="Panel1" runat="server" ScrollBars="Auto" Style="background-color: white;
                                                    width: 191px; border-right: 1px solid #9f9f9f; border-left: 1px solid #9f9f9f;
                                                    border-bottom: 1px solid #9f9f9f">
                                                    <asp:CheckBoxList ID="cmbTaxSection" runat="server">
                                                    </asp:CheckBoxList>
                                                </asp:Panel>
                                                <asp:TextBox ID="txtSection" runat="server" CssClass="txtBPL" Width="190px"></asp:TextBox>
                                                <cc1:PopupControlExtender ID="PopEx" runat="server" PopupControlID="Panel1" Position="Bottom"
                                                    TargetControlID="txtSection" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr id="rowShortFallInTDS">
                                <td>
                                    <table width="600" style="width: 600px">
                                        <tr>
                                            <td width="100">
                                                <asp:Label ID="lblSFITDSBranchCode" runat="server" Text=" Branch Code : "></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtSFITDSBranchCode" runat="server" onkeypress="return isNumber_withoutcomma(event);"
                                                    Width="341px" CssClass="txtBML"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="100">
                                                From Date :
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtSFITDSFromDate" runat="server" CssClass="txtBML" Width="120px"
                                                    onBlur="setDateFormat(this);"></asp:TextBox>
                                                &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp To Date :
                                                <asp:TextBox ID="txtSFITDSToDate" runat="server" CssClass="txtBML" Width="120px"
                                                    onBlur="setDateFormat(this);"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr id="rowTracesReport">
                                <td>
                                    <table width="500" style="width: 499px">
                                        <tr>
                                            <td class="style7">
                                                <asp:Label ID="lblTraces_BranchCode" runat="server" Text=" Branch Code : "></asp:Label>
                                            </td>
                                            <td class="style1">
                                                <asp:TextBox ID="txtTraces_BranchCode" runat="server" onkeypress="return isNumber(event);"
                                                    Height="40px" Width="330px" CssClass="txtBPL" TextMode="MultiLine"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style7">
                                                <asp:Label ID="lblTraces_Form" runat="server" Text=" Select Form : "></asp:Label>
                                            </td>
                                            <td class="style1">
                                                <asp:DropDownList ID="ddlTraces_Form" runat="server" CssClass="mdropDownList" Width="100px">
                                                    <asp:ListItem Text="All" Value="0"></asp:ListItem>
                                                    <asp:ListItem Text="Form24" Value="1"></asp:ListItem>
                                                    <asp:ListItem Text="Form26" Value="2"></asp:ListItem>
                                                    <asp:ListItem Text="Form27" Value="3"></asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style7">
                                                <asp:Label ID="lblTraces_Quarter" runat="server" Text=" Select Quarter : "></asp:Label>
                                            </td>
                                            <td class="style1">
                                                <asp:DropDownList ID="ddlTraces_Quarter" runat="server" CssClass="mdropDownList"
                                                    Width="100px">
                                                    <asp:ListItem Text="All" Value="0"></asp:ListItem>
                                                    <asp:ListItem Text="Quarter 1" Value="1"></asp:ListItem>
                                                    <asp:ListItem Text="Quarter 2" Value="2"></asp:ListItem>
                                                    <asp:ListItem Text="Quarter 3" Value="3"></asp:ListItem>
                                                    <asp:ListItem Text="Quarter 4" Value="4"></asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style7">
                                                <asp:Label ID="Label2" runat="server" Text="Generate : "></asp:Label>
                                            </td>
                                            <td class="style1">
                                                <asp:RadioButton GroupName="GenerationType" Text="Text File" runat="server" ID="rdbTxt"
                                                    Checked="true" />
                                                <asp:RadioButton ID="rdbExcel" GroupName="GenerationType" Text="Excel File" runat="server" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr id="rowChallanUnutilised" style="display: none">
                                <td>
                                    <table width="500" style="width: 499px">
                                        <tr>
                                            <td class="style7">
                                                <asp:Label ID="lblCU_ReportType" runat="server" Text="Report Type : "></asp:Label>
                                            </td>
                                            <td class="style1">
                                                <asp:DropDownList ID="ddlCU_ReportType" runat="server" onchange="Validate_CU();"
                                                    CssClass="mdropDownList" Width="100px">
                                                    <asp:ListItem Text="All" Value="0"></asp:ListItem>
                                                    <asp:ListItem Text="RO wise" Value="1"></asp:ListItem>
                                                    <asp:ListItem Text="Branch wise" Value="2"></asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style7">
                                                <asp:Label ID="lblCU_BranchCode" runat="server" Text="Branch Code(s) : "></asp:Label>
                                            </td>
                                            <td class="style1">
                                                <asp:TextBox ID="txtCU_BranchCode" runat="server" onkeypress="return isNumber(event);"
                                                    Height="40px" Width="330px" CssClass="txtBPL" TextMode="MultiLine"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr id="rowCustomerReferenceNo" style="display: none">
                                <td>
                                    <table width="500" style="width: 499px">
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblCuMonth" runat="server" Text=" Select Month    :"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlCuMonth" runat="server" CssClass="mdropDownList" Width="158px">
                                                    <asp:ListItem Text="Select" Value="-1"></asp:ListItem>
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
                                        </tr>
                                        <tr>
                                            <td class="style7">
                                                <asp:Label ID="lblCU_ReferenceNo" runat="server" Text="Reference No(s) :"></asp:Label>
                                            </td>
                                            <td class="style1">
                                                <asp:TextBox ID="txtCU_ReferenceNo" runat="server" Height="40px" Width="330px" CssClass="txtBPL"
                                                    TextMode="MultiLine"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr id="rowLowerDeductions" style="display: none">
                                <td>
                                    <table width="500" style="width: 499px">
                                        <tr id="rowLowerDeductionsLowerDeductions">
                                            <td colspan="2">
                                                <asp:Label ID="lblLDHead" runat="server" Text="Please enter valid Branch Code(s) or TAN(s)"
                                                    ForeColor="Red">
                                                </asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style7">
                                                <asp:Label ID="lblLD_BranchCodes" runat="server" Text="Branch Code(s) :"></asp:Label>
                                            </td>
                                            <td class="stlyle1">
                                                <asp:TextBox ID="txtLD_BranchCodes" runat="server" Height="40px" Width="330px" CssClass="txtBPL"
                                                    onkeypress="return isNumber(event);" TextMode="MultiLine"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style7">
                                                <asp:Label ID="lblLD_TanLists" runat="server" Text="TAN(s) :"></asp:Label>
                                            </td>
                                            <td class="style1">
                                                <asp:TextBox ID="txtLD_TanLists" runat="server" Height="40px" Width="330px" CssClass="txtBPL"
                                                    TextMode="MultiLine"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr id="rowTracesPassword" style="display: none">
                                <td>
                                    <table width="500">
                                        <tr>
                                            <td style="width: 220px">
                                            </td>
                                            <td class="style1">
                                                <asp:Label ID="reqFile" runat="server" Text="Please select file to import" ForeColor="Red"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 220px">
                                                Select File :
                                            </td>
                                            <td class="style1">
                                                <asp:FileUpload ID="fileUpload" runat="server" Width="300px" />
                                                <br />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                            </td>
                                            <td class="style1">
                                                <asp:Button ID="btnImportTraces" runat="server" Text="Import File" CssClass="cmnBtn"
                                                    OnClientClick="Load_Busy(); return Check_For_Blank_File();" OnClick="btnImportTraces_Click" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                            </td>
                                            <td>
                                                <br />
                                                <asp:HyperLink ID="hlinkErrorFile" runat="server" Font-Bold="True" ForeColor="Red"
                                                    Target="_blank" Visible="False">Some Error(s) Found. Click here to view error(s) list</asp:HyperLink>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr id="rowTDSReconsiliationReport" style="display: none">
                                <td>
                                    <table style="width: 300px">
                                        <tr>
                                            <td width="100px">
                                                <asp:Label ID="lblTDSRecReportQtr" runat="server" Text=" Select Quarter : "></asp:Label>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlTDSRecReportQtr" runat="server" CssClass="mdropDownList"
                                                    Width="163px">
                                                    <asp:ListItem Text="Select" Value="-1"></asp:ListItem>
                                                    <asp:ListItem Text="Quarter 1" Value="1"></asp:ListItem>
                                                    <asp:ListItem Text="Quarter 2" Value="2"></asp:ListItem>
                                                    <asp:ListItem Text="Quarter 3" Value="3"></asp:ListItem>
                                                    <asp:ListItem Text="Quarter 4" Value="4"></asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr id="rowForm27Deductions" style="display: none">
                                <td>
                                    <table style="width: 300px">
                                        <tr>
                                            <td width="100px">
                                                <asp:Label ID="lblFrm27dedQuarter" runat="server" Text="Select Quarter"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlFrm27DedQuarter" runat="server" CssClass="mdropDownList"
                                                    Width="200px">
                                                    <asp:ListItem Text="Select" Value="-1"></asp:ListItem>
                                                    <asp:ListItem Text="Quarter1" Value="1"></asp:ListItem>
                                                    <asp:ListItem Text="Quarter2" Value="2"></asp:ListItem>
                                                    <asp:ListItem Text="Quarter3" Value="3"></asp:ListItem>
                                                    <asp:ListItem Text="Quarter4" Value="4"></asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="100px">
                                                <asp:Label ID="lblCountryofResidence" runat="server" Text="Country of Residence"></asp:Label>
                                            </td>
                                            <td class="iCol">
                                                <asp:DropDownList ID="ddlCountries" runat="server" TabIndex="16" CssClass="mdropDownList"
                                                    Width="200px">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="100px">
                                                <asp:Label ID="lblTaxRateotherthan" runat="server" Text="Tax Rate other than"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtTaxRate" runat="server" Height="20px" Width="195px" CssClass="txtBPL"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr id="row197CertificateIncomplete" style="display: none">
                                <td>
                                    <table width="500" style="width: 499px">
                                        <tr>
                                            <td class="style7">
                                                <asp:Label ID="lbl197CertificateBranchCode" runat="server" Text="Branch Code(s) :"></asp:Label>
                                            </td>
                                            <td class="stlyle1">
                                                <asp:TextBox ID="txt197CertificateBranchCode" runat="server" Height="40px" Width="330px"
                                                    CssClass="txtBPL" onkeypress="return isNumber(event);" TextMode="MultiLine"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style7">
                                                <asp:Label ID="lbl197CertificateCertificateNo" runat="server" Text="Certificate No(s) :"></asp:Label>
                                            </td>
                                            <td class="style1">
                                                <asp:TextBox ID="txt197CertificateCertificateNo" runat="server" Height="40px" Width="330px"
                                                    CssClass="txtBPL" TextMode="MultiLine"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr id="rowCDandDDInformation">
                                <td>
                                    <table width="500" style="width: 499px">
                                        <tr id="rowCDandDDCusPan">
                                            <td>
                                                <asp:Label ID="lblCDandDDCustID" runat="server" Text="CustomerID :"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtCDandDDCust" runat="server" Width="150px" CssClass="txtBPL" MaxLength="20"></asp:TextBox>
                                            </td>
                                            <td class="style7">
                                                <asp:Label ID="lblCDandDDPan" runat="server" Text="PAN :"></asp:Label>
                                            </td>
                                            <td class="style1">
                                                <asp:TextBox ID="txtCDandDDPan" runat="server" Width="150px" CssClass="txtBPL" onBlur="ConvertToUC(this);"
                                                    onkeypress="return ValidateForAlphaNumeric(event);" MaxLength="10"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr id="rowCDandDDFrmQtr">
                                            <td>
                                                <asp:Label ID="lblCDandDDForm" runat="server" Text=" Form   : "></asp:Label>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlCDandForm" runat="server" CssClass="mdropDownList" Width="100px">
                                                    <asp:ListItem Text="Select" Value="-1"></asp:ListItem>
                                                    <asp:ListItem Text="Form24" Value="1"></asp:ListItem>
                                                    <asp:ListItem Text="Form26" Value="2"></asp:ListItem>
                                                    <asp:ListItem Text="Form27" Value="3"></asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblCDandDDQuarter" runat="server" Text=" Quarter : "></asp:Label>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlCDandDDQuarter" runat="server" CssClass="mdropDownList"
                                                    Width="100px">
                                                    <asp:ListItem Text="Select" Value="-1"></asp:ListItem>
                                                    <asp:ListItem Text="Quarter 1" Value="1"></asp:ListItem>
                                                    <asp:ListItem Text="Quarter 2" Value="2"></asp:ListItem>
                                                    <asp:ListItem Text="Quarter 3" Value="3"></asp:ListItem>
                                                    <asp:ListItem Text="Quarter 4" Value="4"></asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr id="rowPreviewButton">
                                <td style="padding-top: 195px" id="rowButton" valign="middle">
                                    <asp:Button ID="btnPreview" runat="server" Text="Preview" CssClass="cmnBtn" OnClick="btnPreview_Click"
                                        OnClientClick="return Validate();" />
                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
                                    <asp:HyperLink ID="hlinkDownloadFile" runat="server" Font-Bold="True" ForeColor="Green"
                                        Target="_blank" Visible="false">Download File</asp:HyperLink>
                                </td>
                                <td style="padding-top: 195px" id="rowDownLoad">
                                    &nbsp;
                                </td>
                                <td colspan="2">
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnPreview" />
            <asp:PostBackTrigger ControlID="btnImportTraces" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
