<%@ page title="" language="C#" masterpagefile="~/SaralTDS.master" autoeventwireup="true" inherits="Correction_SalaryDetail, App_Web_salarydetail.aspx.4fd6750c" %>

<%@ MasterType VirtualPath="~/SaralTDS.master" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript" language="javascript" src="../JavaScript/Validations.js"></script>
    <script type="text/javascript" language="javascript">
        function OnNewRecord() {
            document.getElementById("<%=txtName.ClientID%>").value = "";
            document.getElementById("<%=txtPan.ClientID%>").value = "";
            document.getElementById("<%=txtGrossSalary.ClientID%>").value = "";
            document.getElementById("<%=txtET.ClientID %>").value = "";
            document.getElementById("<%=txtPT.ClientID%>").value = "";
            document.getElementById("<%=ddlGender.ClientID%>").value = "-1";
            document.getElementById("<%=ddlSeniorCitizen.ClientID%>").value = "-1";
            document.getElementById("<%=txtOtherIncome.ClientID%>").value = "";
            document.getElementById("<%=txtGrossTotalIncome.ClientID%>").value = "";
            if (document.getElementById("<%=txtChapterVIA80CCE.ClientID%>") != null) document.getElementById("<%=txtChapterVIA80CCE.ClientID%>").value = "";
            if (document.getElementById("<%=txtChapterVIA80CCF.ClientID%>") != null) document.getElementById("<%=txtChapterVIA80CCF.ClientID%>").value = "";
            if (document.getElementById("<%=txtChapterVIA80CCG.ClientID%>") != null) document.getElementById("<%=txtChapterVIA80CCG.ClientID%>").value = "";
            document.getElementById("<%=txtChapterVIAOthers.ClientID%>").value = "";
            document.getElementById("<%=txtTotalTaxableIncome.ClientID%>").value = "";
            document.getElementById("<%=txtTaxOnTotalIncome.ClientID%>").value = "";
            document.getElementById("<%=txtSurcharge.ClientID%>").value = "";
            document.getElementById("<%=txtEducationCess.ClientID%>").value = "";
            document.getElementById("<%=txtReliefUS89.ClientID%>").value = "";
            document.getElementById("<%=txtNetTaxPayable.ClientID%>").value = "";
            document.getElementById("<%=txtTotalTDS.ClientID%>").value = "";
            document.getElementById("<%=txtTaxPayableRefundable.ClientID%>").value = "";
            document.getElementById("<%=hdnEmployeeSerialNo.ClientID%>").value = "-1";
            document.getElementById("<%=hdnCurrentCorrStatus.ClientID%>").value = "-1";
            if (document.getElementById("<%=txtCurrentTaxableIncome.ClientID%>") != null) document.getElementById("<%=txtCurrentTaxableIncome.ClientID%>").value = "";
            if (document.getElementById("<%=txtPrevTaxableIncome.ClientID%>") != null) document.getElementById("<%=txtPrevTaxableIncome.ClientID%>").value = "";
            if (document.getElementById("<%=txtCurrentTDS.ClientID%>") != null) document.getElementById("<%=txtCurrentTDS.ClientID%>").value = "";
            if (document.getElementById("<%=txtPreviousTDS.ClientID%>") != null) document.getElementById("<%=txtPreviousTDS.ClientID%>").value = "";
            if (document.getElementById("<%=ddlTDSHigherRate.ClientID%>") != null) document.getElementById("<%=ddlTDSHigherRate.ClientID%>").selectedIndex = 0;
            document.getElementById("<%=txtGrossSalarySec17.ClientID %>").value = "";
            document.getElementById("<%=txtValueOfPerq.ClientID %>").value = "";
            document.getElementById("<%=txtProfitSalary.ClientID %>").value = "";
            document.getElementById("<%=txtS10LTA.ClientID %>").value = "";
            document.getElementById("<%=txtS10Gratuity.ClientID %>").value = "";
            document.getElementById("<%=txtS10Pension.ClientID %>").value = "";
            document.getElementById("<%=txtS10LSE.ClientID %>").value = "";
            document.getElementById("<%=txtS10HRA.ClientID %>").value = "";
            document.getElementById("<%=txtS10OTH.ClientID %>").value = "";
            document.getElementById("<%=txtOthincsrc.ClientID %>").value = "";

            var txtCredit87A = document.getElementById("<%=txtCredit87A.ClientID %>");
            if (txtCredit87A != null)
                document.getElementById("<%=txtCredit87A.ClientID %>").value = "";

            document.getElementById("<%=txtSD.ClientID %>").value = "";
            document.getElementById("<%=txtChapterVIA80C.ClientID %>").value = "";
            document.getElementById("<%=txtChapterVIA80CCC.ClientID %>").value = "";
            document.getElementById("<%=txtChapterVIA80CCD_1.ClientID %>").value = "";
            document.getElementById("<%=txtChapterVIA80CCD_1B.ClientID %>").value = "";
            document.getElementById("<%=txtChapterVIA80CCD_2.ClientID %>").value = "";
            document.getElementById("<%=txtChapterVIA80D.ClientID %>").value = "";
            document.getElementById("<%=txtChapterVIA80E.ClientID %>").value = "";
            document.getElementById("<%=txtChapterVIA80G.ClientID %>").value = "";
            document.getElementById("<%=txtChapterVIA80TTA.ClientID %>").value = "";
            return true;
        }
        function ValidateCorrectionType() {
            if (document.getElementById("<%=ddlCorrectionType.ClientID%>").value == -1) {
                alert("Select Correction Type");
                return false;
            }
            else return true;
        }
        function ValidateSerialNo() {
            if (document.getElementById("<%=hdnEmployeeSerialNo.ClientID%>").value != "-1") return true;
            else {
                alert("Select valid employee");
                return false;
            }
        }
        function ShowAllclick() {
            if (confirm("Loading all details will take time.\n\nDo you want to continue?") == true) {
                return true;
            } else return false;
        }
        function Validation() {
            hdnFinYear = document.getElementById("<%=hdnFinYear.ClientID %>");
            var taxinccurrent = document.getElementById("<%=txtCurrentTaxableIncome.ClientID%>");
            var GrossSalary = document.getElementById("<%=txtGrossSalary.ClientID %>");
            var ToatalTaxableIncome = document.getElementById("<%=txtTotalTaxableIncome.ClientID %>");
            var sec17_1 = document.getElementById("<%=txtGrossSalarySec17.ClientID %>");
            var sec17_2 = document.getElementById("<%=txtValueOfPerq.ClientID %>");
            var sec17_3 = document.getElementById("<%=txtProfitSalary.ClientID %>");
            var SD = document.getElementById("<%=txtSD.ClientID %>");
            var OtherIncSource = document.getElementById("<%=txtOthincsrc.ClientID %>");
            var txtCredit87A = document.getElementById("<%=txtCredit87A.ClientID %>");
            var ChapterVIA80C = document.getElementById("<%=txtChapterVIA80C.ClientID %>");
            var ChapterVIA80CCC = document.getElementById("<%=txtChapterVIA80CCC.ClientID %>");
            var ChapterVIA80CCD_1 = document.getElementById("<%=txtChapterVIA80CCD_1.ClientID %>");
            var ChapterVIA80CCD_1B = document.getElementById("<%=txtChapterVIA80CCD_1B.ClientID %>");
            var ChapterVIA80D = document.getElementById("<%=txtChapterVIA80D.ClientID %>");
            var ChapterVIA80TTA = document.getElementById("<%=txtChapterVIA80TTA.ClientID %>");
            var txtTaxOnTotalIncome = document.getElementById("<%=txtTaxOnTotalIncome.ClientID %>");
            if (hdnFinYear.value >= 2018) {
                var totalChapterVIA80C_80CCC_80CCD_1 = (Return(ChapterVIA80C.value) + Return(ChapterVIA80CCC.value) + Return(ChapterVIA80CCD_1.value));
                var totalsec17_1_2_3 = (Return(sec17_1.value) + Return(sec17_2.value) + Return(sec17_3.value));
                if (totalsec17_1_2_3 != taxinccurrent.value) {
                    alert("Sum of Gross Salary Sec.17(1), Value Of Perquisites and Profit In Lieu Salary \nShould be equal to Taxable Income Current.");
                    sec17_1.focus();
                    return false;
                }
                if (SD.value > Return(GrossSalary.value)) {
                    alert("Standard Deduction value Should Not be greater than Gross Salary Amount.");
                    SD.focus();
                    return false;
                }
                if (hdnFinYear.value <= 2018) {
                    if (SD.value > 40000) {
                        alert("Standard Deduction value Should Not be greater than Rs.40,000.");
                        SD.focus();
                        return false;
                    }
                    if (txtCredit87A.value > 2500) {
                        alert("Amount of Credit Under Section 87A Should Not be greater than Rs.2,500.");
                        txtCredit87A.focus();
                        return false;
                    }
                    if (txtCredit87A != null) {
                        if (ToatalTaxableIncome.value > 350000 && txtCredit87A.value > 0) {
                            alert("Total Taxable Income Should Not be greater than Rs.3,50,000 and \nCredit Under Section 87 Should Not be greater than Zero.");
                            txtCredit87A.focus();
                            return false;
                        }
                    }
                }
                else {
                    if (SD.value > 50000) {
                        alert("Standard Deduction value Should Not be greater than Rs.50,000.");
                        SD.focus();
                        return false;
                    }
                    if (txtCredit87A.value > 12500) {
                        alert("Amount of Credit Under Section 87A Should Not be greater than Rs.12,500.");
                        txtCredit87A.focus();
                        return false;
                    }
                    if (txtCredit87A != null) {
                        if (ToatalTaxableIncome.value > 500000 && txtCredit87A.value > 0) {
                            alert("Total Taxable Income Should Not be greater than Rs.5,00,000 and \nCredit Under Section 87 Should Not be greater than Zero.");
                            txtCredit87A.focus();
                            return false;
                        }
                    }
                }
                if (OtherIncSource.value < 0) {
                    alert("Amount Of Other Income Source Should not be less than Zero.");
                    OtherIncSource.focus();
                    return false;
                }

                if (txtCredit87A != null) {
                    if (txtTaxOnTotalIncome.value < txtCredit87A.value) {
                        alert("Credit Under Section 87A Should not be greater than Tax On Total Income Amount.")
                        txtCredit87A.focus();
                        return false;
                    }                   
                }                

                if (totalChapterVIA80C_80CCC_80CCD_1 > 150000) {
                    alert("Sum Of ChapterVIA80C, ChapterVIA80CCC And ChapterVIA80CCD_(1) Should Not be greater than Rs.1,50,000.");
                    ChapterVIA80C.focus();
                    return false;
                }
                if (ChapterVIA80CCD_1B.value > 50000) {
                    alert("ChapterVIA80CCD_(1B) Amount Should Not be greater than Rs.50,000.");
                    ChapterVIA80CCD_1B.focus();
                    return false;
                }
                if (ChapterVIA80D.value > 100000) {
                    alert("ChapterVIA80D Amount Should Not be greater than Rs.1,00000.");
                    ChapterVIA80D.focus();
                    return false;
                }
                if (ChapterVIA80TTA.value > 10000) {
                    alert("ChapterVIA80TTA Amount Should Not be greater than Rs.10,000.");
                    ChapterVIA80TTA.focus();
                    return false;
                }
            }
            if (!ValidateSerialNo()) return false;
            if (!ValidateLength(document.getElementById("<%=txtName.ClientID%>"), "Employee Name", 75, true)) return false;
            if (document.getElementById("<%=ddlGender.ClientID%>").value == "-1") {
                alert("Specify Gender");
                document.getElementById("<%=ddlGender.ClientID%>").focus();
                return false;
            }
            if (eval(document.getElementById("<%=txtTotalTaxableIncome.ClientID%>").value) < 0) {
                alert("Total taxable income cannot be negative");
                return false;
            }
            var totaltaxableincome = document.getElementById("<%=txtTotalTaxableIncome.ClientID%>").value;
            if (totaltaxableincome > 9999999999) {
                alert("Total Taxable Income should be less than 1000 Crores.")
                return false;
            }
            else return true;
        }
        function CalculateAmount() {
            hdnFinYear = document.getElementById("<%=hdnFinYear.ClientID %>");
            var sec17_1 = document.getElementById("<%=txtGrossSalarySec17.ClientID %>");
            var sec17_2 = document.getElementById("<%=txtValueOfPerq.ClientID %>");
            var sec17_3 = document.getElementById("<%=txtProfitSalary.ClientID %>");
            var txtSD = document.getElementById("<%=txtSD.ClientID %>");
            var txtOtherIncome = document.getElementById("<%=txtOtherIncome.ClientID %>");
            var txtOtherIncSrc = document.getElementById("<%=txtOthincsrc.ClientID %>");
            var txtS10LTA = document.getElementById("<%=txtS10LTA.ClientID %>");
            var txtS10Gratuity = document.getElementById("<%=txtS10Gratuity.ClientID %>");
            var txtS10Pension = document.getElementById("<%=txtS10Pension.ClientID %>");
            var txtS10LSE = document.getElementById("<%=txtS10LSE.ClientID %>");
            var txtS10HRA = document.getElementById("<%=txtS10HRA.ClientID %>");
            var txtS10OTH = document.getElementById("<%=txtS10OTH.ClientID %>");
            var txtGrossTotalIncome = document.getElementById("<%=txtGrossTotalIncome.ClientID %>");
            var txtChapterVIA80CCE = document.getElementById("<%=txtChapterVIA80CCE.ClientID%>");
            var txtChapterVIA80CCF = document.getElementById("<%=txtChapterVIA80CCF.ClientID%>");
            var txtChapterVIA80CCG = document.getElementById("<%=txtChapterVIA80CCG.ClientID%>");
            var txtVIA80OThers = document.getElementById("<%=txtChapterVIAOthers.ClientID %>");
            var txtChapterVIA80C = document.getElementById("<%=txtChapterVIA80C.ClientID %>");
            var txtChapterVIA80CCC = document.getElementById("<%=txtChapterVIA80CCC.ClientID %>");
            var txtChapterVIA80CCD_1 = document.getElementById("<%=txtChapterVIA80CCD_1.ClientID %>");
            var txtChapterVIA80CCD_1B = document.getElementById("<%=txtChapterVIA80CCD_1B.ClientID %>");
            var txtChapterVIA80CCD_2 = document.getElementById("<%=txtChapterVIA80CCD_2.ClientID %>");
            var txtChapterVIA80D = document.getElementById("<%=txtChapterVIA80D.ClientID %>");
            var txtChapterVIA80E = document.getElementById("<%=txtChapterVIA80E.ClientID %>");
            var txtChapterVIA80G = document.getElementById("<%=txtChapterVIA80G.ClientID %>");
            var txtChapterVIA80TTA = document.getElementById("<%=txtChapterVIA80TTA.ClientID %>");
            var txtCurrentTaxableIncome = document.getElementById("<%=txtCurrentTaxableIncome.ClientID %>");
            var txtPrevTaxableIncome = document.getElementById("<%=txtPrevTaxableIncome.ClientID %>");
            var tempValue;
            var txtET = document.getElementById("<%=txtET.ClientID %>");
            var txtPT = document.getElementById("<%=txtPT.ClientID %>");
            var txtTotalTaxableIncome = document.getElementById("<%=txtTotalTaxableIncome.ClientID %>");
            var txtTaxOnTotalIncome = document.getElementById("<%=txtTaxOnTotalIncome.ClientID %>");
            var txtSurcharge = document.getElementById("<%=txtSurcharge.ClientID %>");
            var txtEducationCess = document.getElementById("<%=txtEducationCess.ClientID %>");
            var txtReliefUS89 = document.getElementById("<%=txtReliefUS89.ClientID %>");
            var txtNetTaxPayable = document.getElementById("<%=txtNetTaxPayable.ClientID %>");
            var txtTotalTDS = document.getElementById("<%=txtTotalTDS.ClientID %>");
            var txtTaxPayableRefundable = document.getElementById("<%=txtTaxPayableRefundable.ClientID %>");
            var txtCurrentTDS = document.getElementById("<%=txtCurrentTDS.ClientID %>");
            var txtPreviousTDS = document.getElementById("<%=txtPreviousTDS.ClientID %>");
            var txtGrossSalary = document.getElementById("<%=txtGrossSalary.ClientID %>");
            var txtCredit87A = document.getElementById("<%=txtCredit87A.ClientID %>")
            if (txtCurrentTDS != null && txtPreviousTDS != null) txtTotalTDS.value = (Return(txtCurrentTDS.value) + Return(txtPreviousTDS.value));
            if (hdnFinYear.value >= 2018) {
                var totalsec17_1_2_3 = (Return(sec17_1.value) + Return(sec17_2.value) + Return(sec17_3.value));

                tempValue = Return(totalsec17_1_2_3) + Return(txtPrevTaxableIncome.value);

                txtGrossSalary.value = tempValue;

                var totalSec10 = Return(txtS10LTA.value) + Return(txtS10Gratuity.value) + Return(txtS10Pension.value) + Return(txtS10LSE.value) + Return(txtS10HRA.value) +
                                 Return(txtS10OTH.value);


                var grossTotalIncome = Return(txtGrossSalary.value) - (Return(totalSec10)) - (Return(txtSD.value) + Return(txtET.value) + Return(txtPT.value));

                txtGrossTotalIncome.value = Return(grossTotalIncome) + Return(txtOtherIncome.value) + Return(txtOtherIncSrc.value);

                txtTotalTaxableIncome.value = (Return(txtGrossTotalIncome.value)) - (((txtChapterVIA80CCE == null ? 0 : (Return(txtChapterVIA80CCE.value))) + Return(txtVIA80OThers.value) +
                                            (txtChapterVIA80CCF == null ? 0 : (Return(txtChapterVIA80CCF.value))) + (txtChapterVIA80CCG == null ? 0 : (Return(txtChapterVIA80CCG.value))) +
                                            Return(txtChapterVIA80C.value) + Return(txtChapterVIA80CCC.value) + Return(txtChapterVIA80CCD_1.value) + Return(txtChapterVIA80CCD_1B.value) +
                                            Return(txtChapterVIA80CCD_2.value) + Return(txtChapterVIA80D.value) + Return(txtChapterVIA80E.value) +
                                            Return(txtChapterVIA80G.value) + Return(txtChapterVIA80TTA.value)));
            }
            else {
                var grossTotalIncome = Return(txtGrossSalary.value) - (Return(txtET.value) + Return(txtPT.value));
                txtGrossTotalIncome.value = Return(grossTotalIncome);
                txtTotalTaxableIncome.value = (Return(txtGrossTotalIncome.value)) -
                                                            ((txtChapterVIA80CCE == null ? 0 : (Return(txtChapterVIA80CCE.value))) + 
                                                            Return(txtVIA80OThers.value) +
                                                            (txtChapterVIA80CCF == null ? 0 : (Return(txtChapterVIA80CCF.value))) + 
                                                            (txtChapterVIA80CCG == null ? 0 : (Return(txtChapterVIA80CCG.value))));
            }

            if (txtCredit87A != null)
                txtNetTaxPayable.value = (Return(txtTaxOnTotalIncome.value) + Return(txtSurcharge.value) + Return(txtEducationCess.value)) - Return(txtReliefUS89.value) - Return(txtCredit87A.value);
            else
                txtNetTaxPayable.value = (Return(txtTaxOnTotalIncome.value) + Return(txtSurcharge.value) + Return(txtEducationCess.value)) - Return(txtReliefUS89.value);

            var payRefundable = Return(txtNetTaxPayable.value) - Return(txtTotalTDS.value);
            if (Return(payRefundable) > 0) txtTaxPayableRefundable.value = Return(payRefundable);
            else { txtTaxPayableRefundable.value = "(" + Math.abs(Return(payRefundable)) + ")"; }
        }
        function Return(tempValue) {
            if (isNaN(tempValue)) {
                tempValue = "0"
                return eval(tempValue);
            }
            else if (tempValue == "" || tempValue == "undefined") { return 0; }
            else { return eval(parseFloat(tempValue).toString()); }
        }
        function GetDeducteeNameValue(source, eventArgs) {
            var value = eventArgs.get_value();
            var arrValue = new Array();
            arrValue = value.split('-');
            document.getElementById("<%=hdnEmployeeSerialNo.ClientID%>").value = arrValue[0];
            document.getElementById("<%=txtTotalTDS.ClientID%>").value = Number(arrValue[1]);
            var content = eventArgs.get_text();
            var arr = new Array();
            arr = content.split('-');
            document.getElementById("<%=txtPan.ClientID%>").value = arr.length > 2 ? arr[2] : arr[1];
        }
        function ClearDeducteeName() {
            if (event.keyCode == 13 || event.keyCode == 37 || event.keyCode == 38 || event.keyCode == 39 || event.keyCode == 40) { }
            else {
                document.getElementById("<%=hdnEmployeeSerialNo.ClientID%>").value = "-1";
                document.getElementById("<%=txtPan.ClientID%>").value = "";
            }
        }
        function UpdateCheckBoxStatus() {
            var hdnIsChecked = document.getElementById("<%=hdnIsChecked.ClientID%>");
            hdnIsChecked.value = "False";
        }
        function SelectAllCheckBox() {
            var panel = document.getElementById("Panel1");
            for (i = 0; i < document.all.length; i++) {
                if (document.all[i].type == 'checkbox') {
                    document.all[i].checked = true;
                    UpdateCheckBoxStatus();
                }
            }
            return false;
        }
        function UnSelectAllCheckBox() {
            for (i = 0; i < document.all.length; i++) {
                if (document.all[i].type == 'checkbox') {
                    document.all[i].checked = false;
                    UpdateCheckBoxStatus();
                }
            }
            return false;
        }
        function checkFinYear(objectName, option) {
            if (document.getElementById("<%=hdnFinYear.ClientID%>").value < 2016) {
                if (option == "1" || option == "2" || option == "3" || option == "4" || option == "5" || option == "6" || option == "7" || option == "8") {
                    if (objectName.value.trim() != "") {
                        alert("Landlord detail is applicable from FY 2016-17.");
                        return false;
                    }
                }
                else {
                    if (objectName.value.trim() != "") {
                        alert("Lender detail is applicable from FY 2016-17.");
                        return false;
                    }
                }
            }
            return true;
        }
        function checkValidatePAN(objectName, option) {
            objectName.value = objectName.value.toUpperCase();
            var message = option == "1" ? "Landlord 1" : option == "2" ? "Landlord 2" : option == "3" ? "Landlord 3" : option == "4" ? "Landlord 4" : option == "5" ? "Lender 1" : option == "6" ? "Lender 2" : option == "7" ? "Lender 3" : "Lender 4";
            return ValidatePAN(objectName, message + " PAN", 10, false);
        }
        function validateMoreDetails() {
            SAFName = document.getElementById("<%=txtSAFName.ClientID%>").value
            SAFContributionFrom = document.getElementById("<%=txtSAFContributionFrom.ClientID%>").value
            SAFContributionTo = document.getElementById("<%=txtSAFContributionTo.ClientID%>").value
            SAFContributionRepaid = document.getElementById("<%=txtSAFContributionRepaid.ClientID%>").value
            SAFAvgTaxRate = document.getElementById("<%=txtSAFAvgTaxRate.ClientID%>").value
            SAFTaxDeducted = document.getElementById("<%=txtSAFTaxDeducted.ClientID%>").value
            if (SAFName.trim() != "" || SAFContributionFrom.trim() != "" || SAFContributionTo.trim() != "" || SAFContributionRepaid.trim() != "" || SAFAvgTaxRate.trim() != "" || SAFTaxDeducted.trim() != "") {
                if (SAFName.trim() == "") {
                    alert("Specify Name of the superannuation fund");
                    document.getElementById("<%=txtSAFName.ClientID%>").focus();
                    return false;
                }
                else if (SAFContributionFrom.trim() == "") {
                    alert("Specify Contribution From");
                    document.getElementById("<%=txtSAFContributionFrom.ClientID%>").focus();
                    return false;
                }
                else if (SAFContributionTo.trim() == "") {
                    alert("Specify Contribution To");
                    document.getElementById("<%=txtSAFContributionTo.ClientID%>").focus();
                    return false;
                }
                else if (SAFContributionRepaid.trim() == "") {
                    alert("Specify Contribution Repaid");
                    document.getElementById("<%=txtSAFContributionRepaid.ClientID%>").focus();
                    return false;
                }
                else if (SAFAvgTaxRate.trim() == "") {
                    alert("Specify Average tax rate");
                    document.getElementById("<%=txtSAFAvgTaxRate.ClientID%>").focus();
                    return false;
                }
                else if (SAFTaxDeducted.trim() == "") {
                    alert("Specify Tax Deducted");
                    document.getElementById("<%=txtSAFTaxDeducted.ClientID%>").focus();
                    return false;
                }
            }
            date1 = new Date();
            var date1 = new Date();
            date1.setFullYear(SAFContributionFrom.substring(6), (SAFContributionFrom.substring(3, 5)), SAFContributionFrom.substring(0, 2));
            var date2 = new Date();
            date2.setFullYear(SAFContributionTo.substring(6), (SAFContributionTo.substring(3, 5)), SAFContributionTo.substring(0, 2));
            if ((date1 >= date2) && ((SAFContributionFrom.trim() != "") || (SAFContributionTo.trim() != ""))) {
                alert("Contribution From cannot be greater than or equal to Contribution To");
                document.getElementById("<%=txtSAFContributionTo.ClientID%>").focus();
                return false;
            }
            if (Return(SAFAvgTaxRate) >= 100) {
                alert("Average tax rate should be below 100%");
                document.getElementById("<%=txtSAFAvgTaxRate.ClientID%>").focus();
                return false;
            }
            if (SAFAvgTaxRate.trim() == "0") {
                alert("Average tax rate should be greater than zero");
                document.getElementById("<%=txtSAFAvgTaxRate.ClientID%>").focus();
                return false;
            }
            var reqdTaxDeducted = Return(SAFContributionRepaid) * (Return(SAFAvgTaxRate) / 100)
            if ((Return(SAFTaxDeducted) < (reqdTaxDeducted - 10)) || (Return(SAFTaxDeducted) > (reqdTaxDeducted + 10))) {
                alert("Based on ( Contribution Repaid * Average Tax Rate (%)) Tax Deducted  is allowed a margin of error of Rs 10.");
                return false;
            }
            if ((document.getElementById("<%=txtNameLL1.ClientID%>").value == "") && (document.getElementById("<%=txtPANLL1.ClientID%>").value != "")) {
                alert("PAN for LandLord 1 is given, Provide Name for LandLord 1");
                return false;
            }
            else if ((document.getElementById("<%=txtNameLL1.ClientID%>").value != "") && (document.getElementById("<%=txtPANLL1.ClientID%>").value == "")) {
                alert("Name for LandLord 1 is given, Provide PAN for LandLord 1");
                return false;
            }
            else if ((document.getElementById("<%=txtNameLL2.ClientID%>").value == "") && (document.getElementById("<%=txtPANLL2.ClientID%>").value != "")) {
                alert("PAN for LandLord 2 is given, Provide Name for LandLord 2");
                return false;
            }
            else if ((document.getElementById("<%=txtNameLL2.ClientID%>").value != "") && (document.getElementById("<%=txtPANLL2.ClientID%>").value == "")) {
                alert("Name for LandLord 2 is given, Provide PAN for LandLord 2");
                return false;
            }
            else if ((document.getElementById("<%=txtNameLL3.ClientID%>").value == "") && (document.getElementById("<%=txtPANLL3.ClientID%>").value != "")) {
                alert("PAN for LandLord 3 is given, Provide Name for LandLord 3");
                return false;
            }
            else if ((document.getElementById("<%=txtNameLL3.ClientID%>").value != "") && (document.getElementById("<%=txtPANLL3.ClientID%>").value == "")) {
                alert("Name for LandLord 3 is given, Provide PAN for LandLord 3");
                return false;
            }
            else if ((document.getElementById("<%=txtNameLL4.ClientID%>").value == "") && (document.getElementById("<%=txtPANLL4.ClientID%>").value != "")) {
                alert("PAN for LandLord 4 is given, Provide Name for LandLord 4");
                return false;
            }
            else if ((document.getElementById("<%=txtNameLL4.ClientID%>").value != "") && (document.getElementById("<%=txtPANLL4.ClientID%>").value == "")) {
                alert("Name for LandLord 4 is given, Provide PAN for LandLord 4");
                return false;
            }
            if ((document.getElementById("<%=txtNameL1.ClientID%>").value == "") && (document.getElementById("<%=txtPANL1.ClientID%>").value != "")) {
                alert("PAN for Lender 1 is given, Provide Name for Lender 1");
                return false;
            }
            else if ((document.getElementById("<%=txtNameL1.ClientID%>").value != "") && (document.getElementById("<%=txtPANL1.ClientID%>").value == "")) {
                alert("Name for Lender 1 is given, Provide PAN for Lender 1");
                return false;
            }
            else if ((document.getElementById("<%=txtNameL2.ClientID%>").value == "") && (document.getElementById("<%=txtPANL2.ClientID%>").value != "")) {
                alert("PAN for Lender 2 is given, Provide Name for Lender 2");
                return false;
            }
            else if ((document.getElementById("<%=txtNameL2.ClientID%>").value != "") && (document.getElementById("<%=txtPANL2.ClientID%>").value == "")) {
                alert("Name for Lender 2 is given, Provide PAN for Lender 2");
                return false;
            }
            else if ((document.getElementById("<%=txtNameL3.ClientID%>").value == "") && (document.getElementById("<%=txtPANL3.ClientID%>").value != "")) {
                alert("PAN for Lender 3 is given, Provide Name for Lender 3");
                return false;
            }
            else if ((document.getElementById("<%=txtNameL3.ClientID%>").value != "") && (document.getElementById("<%=txtPANL3.ClientID%>").value == "")) {
                alert("Name for Lender 3 is given, Provide PAN for Lender 3");
                return false;
            }
            else if ((document.getElementById("<%=txtNameL4.ClientID%>").value == "") && (document.getElementById("<%=txtPANL4.ClientID%>").value != "")) {
                alert("PAN for Lender 4 is given, Provide Name for Lender 4");
                return false;
            }
            else if ((document.getElementById("<%=txtNameL4.ClientID%>").value != "") && (document.getElementById("<%=txtPANL4.ClientID%>").value == "")) {
                alert("Name for Lender 4 is given, Provide PAN for Lender 4");
                return false;
            }
            return true;
        }
        function SetStatus() {
            var hdnSearch = document.getElementById("<%=hdnSearch.ClientID%>");
            if (hdnSearch.value == "0") { hdnSearch.value = "1"; }
            else { hdnSearch.value = "0"; }
            SetSearchPanelVisibility();
        }
        function Show_Popup_Export() {
            if (document.getElementById("<%=ddlBlkUpdateType.ClientID%>").value > 0) {
                $find("popUpBulkExport_Control").show();
            }
        }
        function Show_Popup_Import() {
            $find("popUpBulkImport_Control").show();
        }
        function SetBulkUpdateType() { document.getElementById("<%=hdnBulkUpdateType.ClientID%>").value = document.getElementById("<%=ddlBlkUpdateType.ClientID%>").value; }
        function SetSearchPanelVisibility() {            
            var btnOpenSearch = document.getElementById("<%=btnOpenSearch.ClientID%>");
            var pnlSearch = document.getElementById("<%=pnlSearch.ClientID%>");
            if (btnOpenSearch == null) { document.getElementById("<%=hdnSearch.ClientID%>").value = "0"; return; }
            else {
                if (document.getElementById("<%=hdnSearch.ClientID%>").value == "0") {
                    if (btnOpenSearch != null) btnOpenSearch.style.display = '';
                    if (pnlSearch != null) pnlSearch.style.display = 'none';
                    document.getElementById("<%=txtSearchSerialNo.ClientID%>").value = "";
                    document.getElementById("<%=txtSearchPAN.ClientID%>").value = "";
                }
                else {
                    if (btnOpenSearch != null) btnOpenSearch.style.display = 'none';
                    if (pnlSearch != null) pnlSearch.style.display = '';
                }
            }
        }
    </script>
    <style type="text/css">
        .style1
        {
            width: 151px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentPlaceHolderBody" runat="Server">
    <asp:UpdatePanel ID="corrSalaryUpdatePanel" runat="server">
    
        <ContentTemplate>
            <asp:Panel ID="pnlBulkExport" runat="server" Height="100px" BackColor="White" CssClass="modalPopup"
                Style="display: none">
                <br />
                <br />
                <asp:Label ID="lblBulkExport" Font-Size="Medium" Text="Exporting Data to Excel Sheet. Please Wait....."
                    Font-Bold="true" ForeColor="Red" runat="server"> </asp:Label>
            </asp:Panel>
            <asp:Panel ID="pnlBulkImport" runat="server" Height="100px" BackColor="White" CssClass="modalPopup"
                Style="display: none">
                <br />
                <br />
                <asp:Label ID="lblBulkImport" Font-Size="Medium" Text="Importing Excel Data. Please Wait....."
                    Font-Bold="true" ForeColor="Red" runat="server"> </asp:Label>
            </asp:Panel>
            <asp:Panel ID="pnlUpBlkUpdate" runat="server" BackColor="White" CssClass="modalPopup"
                Style="display: none">
                <asp:Label ID="lblExport_Heading" Text="BULK UPDATE - EXPORT" Font-Bold="true" ForeColor="Brown"
                    runat="server"> </asp:Label>
                <hr />
                <table>
                    <tr>
                        <td style="height: 10px">
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 100px">
                            Correction Type
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlBlkUpdateType" runat="server" Width="140px" onChange="SetBulkUpdateType();">
                                <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                                <%--<asp:ListItem Text="ADD" Value="1"></asp:ListItem>--%>
                                <asp:ListItem Text="UPDATE" Value="2"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td style="height: 10px">
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                            <%--<asp:Button ID="btnOk" Text="Ok" runat="server" Width="70px" CssClass="cmnBtn" OnClick="btnOk_Click" OnClientClick="SetBulkUpdateType();" />--%>
                            <asp:Button ID="btnOk" Text="Ok" runat="server" Width="70px" CssClass="cmnBtn" OnClientClick="Show_Popup_Export();"
                                OnClick="btnExport_Click" />
                            <asp:Button ID="btnClosePopUp" Text="Close" runat="server" Width="70px" CssClass="cmnBtn" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <asp:Panel ID="pnlImport" runat="server" BackColor="White" CssClass="modalPopup"
                Width="400px" Style="display: none">
                <asp:Label ID="lblImport_Heading" Text="BULK UPDATE - IMPORT" Font-Bold="true" ForeColor="Brown"
                    runat="server"> </asp:Label>
                <hr />
                <table>
                    <tr>
                        <td style="height: 10px">
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 100px">
                            Select File
                        </td>
                        <td>
                            <asp:FileUpload ID="fileUpload" runat="server" Width="300px" />
                        </td>
                    </tr>
                    <tr>
                        <td style="height: 10px">
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td align="right">
                            <asp:Button ID="btnImportPopUp" Text="Import" runat="server" Width="70px" CssClass="cmnBtn"
                                OnClientClick="Show_Popup_Import();" OnClick="btnImportPopUp_Click" />
                            <asp:Button ID="btnCloseImportPopUp" Text="Close" runat="server" Width="70px" CssClass="cmnBtn" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <asp:Panel ID="panelAnnexure2" runat="server" CssClass="modalPopup" Style="width: 50%;
                display: none; border-style: inset; border-color: Black" BackColor="White">
                <div style="width: 100%; height: 15px; border: 1px; border-color: Black; margin-bottom: 15px;
                    background-color: Black; color: White; padding: 5px 0px 5px 0px;">
                    <center>
                        <asp:Label ID="lblAnnexure2" runat="server" Font-Bold="true"> Upload Defaults File</asp:Label>
                    </center>
                </div>
                <table style="float: inherit; margin: auto;">
                    <tr>
                        <td>
                            <label>
                                Select
                            </label>
                        </td>
                        <td>
                            <asp:FileUpload ID="fupPfxFile" runat="server" BackColor="#E5E5E5" Width="555px" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Button ID="btnUploadDefaults" runat="server" Text="Upload" CssClass="cmnBtn"
                                OnClick="btnUploadDefaults_Click" />
                        </td>
                        <td>
                            <asp:Button ID="btnCancelAnnex2" runat="server" Text="Cancel" CssClass="cmnBtn" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <cc1:ModalPopupExtender ID="allOrRowWise" runat="server" CancelControlID="btnCancelAnnex2"
                TargetControlID="btnUpdDefaults" BackgroundCssClass="modalBackground" BehaviorID="behaviourAnnexure2"
                PopupControlID="panelAnnexure2">
            </cc1:ModalPopupExtender>
            <asp:HiddenField ID="hdnEmployeeSerialNo" runat="server" Value="-1" />
            <asp:HiddenField ID="hdnCurrentCorrStatus" runat="server" Value="-1" />
            <asp:HiddenField ID="hdnPopupPageIndex" runat="server" Value="1" />
            <asp:HiddenField ID="hdnPopupPageSize" runat="server" Value="10" />
            <asp:HiddenField ID="hdnUpdatedSalsPageSize" runat="server" Value="10" />
            <asp:HiddenField ID="hdnUpdatedSalsPageIndex" runat="server" Value="1" />
            <asp:HiddenField ID="hdnSelectedItems" runat="server" Value="" />
            <asp:HiddenField ID="hdnUpdatedItems" runat="server" Value="" />
            <asp:HiddenField ID="hdnUpdateItems" runat="server" Value="" />
            <asp:HiddenField ID="hdnDeleteItems" runat="server" Value="" />
            <asp:HiddenField ID="hdnIsCorrEREturnValid" runat="server" Value="0" />
            <asp:HiddenField ID="hdnExcludedItems" runat="server" Value="" />
            <asp:HiddenField ID="hdnUnlinkedSalItems" runat="server" Value="" />
            <asp:HiddenField ID="hdnIsChecked" runat="server" Value="True" />
            <asp:HiddenField ID="hdnPageIndex" runat="server" Value="1" />
            <asp:HiddenField ID="hdnPageSize" runat="server" Value="10" />
            <asp:HiddenField ID="hdnisUpdated" runat="server" Value="0" />
            <asp:HiddenField ID="hdnFinYear" runat="server" Value="" />
            <asp:HiddenField ID="hdnSearch" runat="server" Value="0" />
            <asp:HiddenField ID="hdnBulkUpdateType" Value="-1" runat="server" />
            <asp:HiddenField ID="hdnisUpdate" runat="server" Value="N" />
            <asp:HiddenField ID="hdnisDelete" runat="server" Value="N" />
            <asp:HiddenField ID="hdnDelete" runat="server" Value="" />
            <cc1:ModalPopupExtender ID="popUpBlkUpdate" runat="server" CancelControlID="btnClosePopUp"
                BackgroundCssClass="modalBackground" TargetControlID="btnExport" PopupControlID="pnlUpBlkUpdate">
            </cc1:ModalPopupExtender>
            <cc1:ModalPopupExtender ID="popUpImport" runat="server" CancelControlID="btnCloseImportPopUp"
                BackgroundCssClass="modalBackground" TargetControlID="btnImport" PopupControlID="pnlImport">
            </cc1:ModalPopupExtender>
            <cc1:ModalPopupExtender ID="popUpBulkExport" BehaviorID="popUpBulkExport_Control"
                runat="server" CancelControlID="btnCloseImportPopUp" BackgroundCssClass="modalBackground"
                TargetControlID="lblBulkExport" PopupControlID="pnlBulkExport">
            </cc1:ModalPopupExtender>
            <cc1:ModalPopupExtender ID="popUpBulkImport" BehaviorID="popUpBulkImport_Control"
                runat="server" CancelControlID="btnCloseImportPopUp" BackgroundCssClass="modalBackground"
                TargetControlID="lblBulkImport" PopupControlID="pnlBulkImport">
            </cc1:ModalPopupExtender>
            <asp:MultiView ID="mvSalary" runat="server" ActiveViewIndex="0">
                <asp:View ID="vwSalary" runat="server">
                    <table class="nTbl">
                        <tr>
                            <td>
                                <table>
                                    <tr>
                                        <td class="vHCol">
                                            Name
                                        </td>
                                        <td class="iCol">
                                            <asp:TextBox ID="txtName" runat="server" CssClass="txtBPL" Width="500px" onkeyup="ClearDeducteeName();"></asp:TextBox>
                                            <cc1:AutoCompleteExtender ID="autoCompleteExtender" runat="server" MinimumPrefixLength="2"
                                                ServicePath="~/WebServices/AutoCompleteService.asmx" TargetControlID="txtName"
                                                ServiceMethod="GetCorrEmployeeAutocompleteForSalary" CompletionInterval="700" EnableCaching="false"
                                                CompletionSetCount="20" DelimiterCharacters="" ShowOnlyCurrentWordInCompletionListItem="true"
                                                FirstRowSelected="True" OnClientItemSelected="GetDeducteeNameValue">
                                            </cc1:AutoCompleteExtender>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table valign="top">
                                    <tr>
                                        <td valign="top" class="eCol">
                                            <table>
                                                <tr>
                                                    <td class="vHCol" style="width: 190px">
                                                        Gender
                                                    </td>
                                                    <td class="iCol" style="width: 150px">
                                                        <asp:DropDownList ID="ddlGender" runat="server" CssClass="dropDownList">
                                                            <asp:ListItem Text="Select" Value="-1"></asp:ListItem>
                                                            <asp:ListItem Text="Male" Value="0"></asp:ListItem>
                                                            <asp:ListItem Text="Female" Value="1"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="vHCol" style="width: 190px">
                                                        PAN
                                                    </td>
                                                    <td class="iCol" style="width: 150px">
                                                        <asp:TextBox ID="txtPan" runat="server" CssClass="roTxtBR" Style="text-align: left"
                                                            Enabled="false"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="vHCol" style="width: 190px">
                                                        Gross Salary
                                                    </td>
                                                    <td class="iCol" style="width: 150px">
                                                        <asp:TextBox ID="txtGrossSalary" runat="server" CssClass="txtBPR" AutoComplete="Off"
                                                            onkeypress="return numeralsOnly(this, event,10,2,0,1);" onchange="return checkDecimalNo(this);"
                                                            onkeyUp="CalculateAmount();"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr id="GrossSalarySec17" runat="server">
                                                    <td class="vHCol" style="width: 190px">
                                                        Gross Salary Sec.17(1)
                                                    </td>
                                                    <td class="iCol" style="width: 150px">
                                                        <asp:TextBox ID="txtGrossSalarySec17" runat="server" CssClass="txtBPR" AutoComplete="Off"
                                                            onkeypress="return numeralsOnly(this, event,10,2,0,1);" onchange="return checkDecimalNo(this);"
                                                            onkeyUp="CalculateAmount();"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr id="ValueOfPerq" runat="server">
                                                    <td class="vHCol" style="width: 190px">
                                                        Value Of Perquisites Sec.17(2)
                                                    </td>
                                                    <td class="iCol" style="width: 150px">
                                                        <asp:TextBox ID="txtValueOfPerq" runat="server" CssClass="txtBPR" AutoComplete="Off"
                                                            onkeypress="return numeralsOnly(this, event,10,2,0,1);" onchange="return checkDecimalNo(this);"
                                                            onkeyUp="CalculateAmount();"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr id="ProfitSalary" runat="server">
                                                    <td class="vHCol" style="width: 190px">
                                                        Profits Lieu Of Salary Sec.17(3)
                                                    </td>
                                                    <td class="iCol" style="width: 150px">
                                                        <asp:TextBox ID="txtProfitSalary" runat="server" CssClass="txtBPR" AutoComplete="Off"
                                                            onkeypress="return numeralsOnly(this, event,10,2,0,1);" onchange="return checkDecimalNo(this);"
                                                            onkeyUp="CalculateAmount();"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr id="S10LTA" runat="server">
                                                    <td class="vHCol" style="width: 190px">
                                                        Sec.10(5)
                                                    </td>
                                                    <td class="iCol" style="width: 150px">
                                                        <asp:TextBox ID="txtS10LTA" runat="server" CssClass="txtBPR" AutoComplete="Off" onkeypress="return numeralsOnly(this, event,10,2,0,1);"
                                                            onchange="return checkDecimalNo(this);" onkeyUp="CalculateAmount();"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr id="S10Gratuity" runat="server">
                                                    <td class="vHCol" style="width: 190px">
                                                        Sec.10(10)
                                                    </td>
                                                    <td class="iCol" style="width: 150px">
                                                        <asp:TextBox ID="txtS10Gratuity" runat="server" CssClass="txtBPR" AutoComplete="Off"
                                                            onkeypress="return numeralsOnly(this, event,10,2,0,1);" onchange="return checkDecimalNo(this);"
                                                            onkeyUp="CalculateAmount();"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr id="S10Pension" runat="server">
                                                    <td class="vHCol" style="width: 190px">
                                                        Sec.10(10A)
                                                    </td>
                                                    <td class="iCol" style="width: 150px">
                                                        <asp:TextBox ID="txtS10Pension" runat="server" CssClass="txtBPR" AutoComplete="Off"
                                                            onkeypress="return numeralsOnly(this, event,10,2,0,1);" onchange="return checkDecimalNo(this);"
                                                            onkeyUp="CalculateAmount();"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr id="S10LSE" runat="server">
                                                    <td class="vHCol" style="width: 190px">
                                                        Sec.10(10AA)
                                                    </td>
                                                    <td class="iCol" style="width: 150px">
                                                        <asp:TextBox ID="txtS10LSE" runat="server" CssClass="txtBPR" AutoComplete="Off" onkeypress="return numeralsOnly(this, event,10,2,0,1);"
                                                            onchange="return checkDecimalNo(this);" onkeyUp="CalculateAmount();"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr id="S10HRA" runat="server">
                                                    <td class="vHCol" style="width: 190px">
                                                        Sec.10(13A)
                                                    </td>
                                                    <td class="iCol" style="width: 150px">
                                                        <asp:TextBox ID="txtS10HRA" runat="server" CssClass="txtBPR" AutoComplete="Off" onkeypress="return numeralsOnly(this, event,10,2,0,1);"
                                                            onchange="return checkDecimalNo(this);" onkeyUp="CalculateAmount();"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr id="S10OTH" runat="server">
                                                    <td class="vHCol" style="width: 190px">
                                                        Any Other Excemption u/s10
                                                    </td>
                                                    <td class="iCol" style="width: 150px">
                                                        <asp:TextBox ID="txtS10OTH" runat="server" CssClass="txtBPR" AutoComplete="Off" onkeypress="return numeralsOnly(this, event,10,2,0,1);"
                                                            onchange="return checkDecimalNo(this);" onkeyUp="CalculateAmount();"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr id="SD" runat="server">
                                                    <td class="vHCol" style="width: 190px">
                                                        SD[16(ia)]
                                                    </td>
                                                    <td class="iCol" style="width: 150px">
                                                        <asp:TextBox ID="txtSD" runat="server" CssClass="txtBPR" AutoComplete="Off" onkeypress="return numeralsOnly(this, event,10,2,0,1);"
                                                            onchange="return checkDecimalNo(this);" onkeyUp="CalculateAmount();"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="vHCol" style="width: 190px">
                                                        ET[16(ii)]
                                                    </td>
                                                    <td class="iCol" style="width: 150px">
                                                        <asp:TextBox ID="txtET" runat="server" CssClass="txtBPR" AutoComplete="Off" onkeypress="return numeralsOnly(this, event,10,2,0,1);"
                                                            onchange="return checkDecimalNo(this);" onkeyUp="CalculateAmount();"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="vHCol" style="width: 190px">
                                                        PT[16(iii)]
                                                    </td>
                                                    <td class="iCol" style="width: 150px">
                                                        <asp:TextBox ID="txtPT" runat="server" CssClass="txtBPR" AutoComplete="Off" onkeypress="return numeralsOnly(this, event,10,2,0,1);"
                                                            onchange="return checkDecimalNo(this);" onkeyUp="CalculateAmount();"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr id="OtherIncome" runat="server">
                                                    <td class="vHCol" style="width: 190px">
                                                        <asp:Label ID="LabelOtherIncome" Text="Other Income - HP" runat="server" Width="110px">
                                                        </asp:Label>
                                                    </td>
                                                    <td class="iCol" style="width: 150px">
                                                        <asp:TextBox ID="txtOtherIncome" runat="server" CssClass="txtBPR" AutoComplete="Off"
                                                            onkeypress="return numeralsOnly(this, event,10,2,1,1);;" onchange="return checkDecimalNo(this);"
                                                            onkeyUp="CalculateAmount();"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr id="Othincsrc" runat="server">
                                                    <td class="vHCol" style="width: 190px">
                                                        Other Income Source
                                                    </td>
                                                    <td class="iCol" style="width: 150px">
                                                        <asp:TextBox ID="txtOthincsrc" runat="server" CssClass="txtBPR" AutoComplete="Off"
                                                            onkeypress="return numeralsOnly(this, event,10,2,0,1);" onchange="return checkDecimalNo(this);"
                                                            onkeyUp="CalculateAmount();"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="vHCol" style="width: 190px">
                                                        Gross Total Income
                                                    </td>
                                                    <td class="iCol" style="width: 150px">
                                                        <asp:TextBox ID="txtGrossTotalIncome" runat="server" CssClass="roTxtBR" Enabled="false"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr runat="server" id="rowCurrentIncome">
                                                    <td class="vHCol" style="width: 190px">
                                                        Taxable Inc. Current
                                                    </td>
                                                    <td class="iCol" style="width: 150px">
                                                        <asp:TextBox ID="txtCurrentTaxableIncome" runat="server" CssClass="txtBPR" onkeypress="return numeralsOnly(this, event,10,2,0,1);"
                                                            onchange="return checkDecimalNo(this);"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr runat="server" id="rowCurrentTDS">
                                                    <td class="vHCol" style="width: 190px">
                                                        TDS Current
                                                    </td>
                                                    <td class="iCol" style="width: 150px">
                                                        <asp:TextBox ID="txtCurrentTDS" runat="server" CssClass="txtBPR" onkeypress="return numeralsOnly(this, event,10,2,0,1);"
                                                            onchange="return checkDecimalNo(this);" onkeyUp="CalculateAmount();"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                    </td>
                                                    <td>
                                                        <asp:Button ID="btnMoreDetails" Text="More" runat="server" CssClass="cmnBtn" TabIndex="7"
                                                            OnClick="btnMoreDetails_Click" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td valign="top">
                                            <table>
                                                <tr>
                                                    <td class="vHCol" style="width: 190px">
                                                        Senior Citizen
                                                    </td>
                                                    <td class="iCol" style="width: 150px">
                                                        <asp:DropDownList ID="ddlSeniorCitizen" runat="server" CssClass="dropDownList">
                                                            <asp:ListItem Text="None" Value="0"></asp:ListItem>
                                                            <asp:ListItem Text="Senior Citizen" Value="1"></asp:ListItem>
                                                            <asp:ListItem Text="Very Senior Citizen" Value="2"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr id="ChapterVIA80C" runat="server">
                                                    <td class="vHCol" style="width: 190px">
                                                        Chap.VI(A)-80C
                                                    </td>
                                                    <td class="iCol" style="width: 150px">
                                                        <asp:TextBox ID="txtChapterVIA80C" runat="server" CssClass="txtBPR" AutoComplete="Off"
                                                            onkeypress="return numeralsOnly(this, event,10,2,0,1);" onchange="return checkDecimalNo(this);"
                                                            onkeyUp="CalculateAmount();"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr id="ChapterVIA80CCC" runat="server">
                                                    <td class="vHCol" style="width: 190px">
                                                        Chap.VI(A)-80CCC
                                                    </td>
                                                    <td class="iCol" style="width: 150px">
                                                        <asp:TextBox ID="txtChapterVIA80CCC" runat="server" CssClass="txtBPR" AutoComplete="Off"
                                                            onkeypress="return numeralsOnly(this, event,10,2,0,1);" onchange="return checkDecimalNo(this);"
                                                            onkeyUp="CalculateAmount();"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr id="ChapterVIA80CCD_1" runat="server">
                                                    <td class="vHCol" style="width: 190px">
                                                        Chap.VI(A)-80CCD(1)
                                                    </td>
                                                    <td class="iCol" style="width: 150px">
                                                        <asp:TextBox ID="txtChapterVIA80CCD_1" runat="server" CssClass="txtBPR" AutoComplete="Off"
                                                            onkeypress="return numeralsOnly(this, event,10,2,0,1);" onchange="return checkDecimalNo(this);"
                                                            onkeyUp="CalculateAmount();"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr id="ChapterVIA80CCD_1B" runat="server">
                                                    <td class="vHCol" style="width: 190px">
                                                        Chap.VI(A)-80CCD(1B)
                                                    </td>
                                                    <td class="iCol" style="width: 150px">
                                                        <asp:TextBox ID="txtChapterVIA80CCD_1B" runat="server" CssClass="txtBPR" AutoComplete="Off"
                                                            onkeypress="return numeralsOnly(this, event,10,2,0,1);" onchange="return checkDecimalNo(this);"
                                                            onkeyUp="CalculateAmount();"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr id="ChapterVIA80CCD_2" runat="server">
                                                    <td class="vHCol" style="width: 190px">
                                                        Chap.VI(A)-80CCD(2)
                                                    </td>
                                                    <td class="iCol" style="width: 150px">
                                                        <asp:TextBox ID="txtChapterVIA80CCD_2" runat="server" CssClass="txtBPR" AutoComplete="Off"
                                                            onkeypress="return numeralsOnly(this, event,10,2,0,1);" onchange="return checkDecimalNo(this);"
                                                            onkeyUp="CalculateAmount();"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr id="ChapterVIA80D" runat="server">
                                                    <td class="vHCol" style="width: 190px">
                                                        Chap.VI(A)-80D
                                                    </td>
                                                    <td class="iCol" style="width: 150px">
                                                        <asp:TextBox ID="txtChapterVIA80D" runat="server" CssClass="txtBPR" AutoComplete="Off"
                                                            onkeypress="return numeralsOnly(this, event,10,2,0,1);" onchange="return checkDecimalNo(this);"
                                                            onkeyUp="CalculateAmount();"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr id="ChapterVIA80E" runat="server">
                                                    <td class="vHCol" style="width: 190px">
                                                        Chap.VI(A)-80E
                                                    </td>
                                                    <td class="iCol" style="width: 150px">
                                                        <asp:TextBox ID="txtChapterVIA80E" runat="server" CssClass="txtBPR" AutoComplete="Off"
                                                            onkeypress="return numeralsOnly(this, event,10,2,0,1);" onchange="return checkDecimalNo(this);"
                                                            onkeyUp="CalculateAmount();"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr id="ChapterVIA80G" runat="server">
                                                    <td class="vHCol" style="width: 190px">
                                                        Chap.VI(A)-80G
                                                    </td>
                                                    <td class="iCol" style="width: 150px">
                                                        <asp:TextBox ID="txtChapterVIA80G" runat="server" CssClass="txtBPR" AutoComplete="Off"
                                                            onkeypress="return numeralsOnly(this, event,10,2,0,1);" onchange="return checkDecimalNo(this);"
                                                            onkeyUp="CalculateAmount();"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr id="ChapterVIA80TTA" runat="server">
                                                    <td class="vHCol" style="width: 190px">
                                                        Chap.VI(A)-80TTA
                                                    </td>
                                                    <td class="iCol" style="width: 150px">
                                                        <asp:TextBox ID="txtChapterVIA80TTA" runat="server" CssClass="txtBPR" AutoComplete="Off"
                                                            onkeypress="return numeralsOnly(this, event,10,2,0,1);" onchange="return checkDecimalNo(this);"
                                                            onkeyUp="CalculateAmount();"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr id="row80CCF" runat="server">
                                                    <td class="vHCol" style="width: 190px">
                                                        Chap.VI(A)-80CCF
                                                    </td>
                                                    <td class="iCol" style="width: 150px">
                                                        <asp:TextBox ID="txtChapterVIA80CCF" runat="server" CssClass="txtBPR" AutoComplete="Off"
                                                            onkeypress="return numeralsOnly(this, event,10,2,0,1);" onchange="return checkDecimalNo(this);"
                                                            onkeyUp="CalculateAmount();"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr runat="server" id="row80CCG">
                                                    <td class="vHCol" style="width: 190px">
                                                        Chap.VI(A)-80CCG
                                                    </td>
                                                    <td class="iCol" style="width: 150px">
                                                        <asp:TextBox ID="txtChapterVIA80CCG" runat="server" CssClass="txtBPR" AutoComplete="Off"
                                                            onkeypress="return numeralsOnly(this, event,10,2,0,1);" onchange="return checkDecimalNo(this);"
                                                            onkeyUp="CalculateAmount();"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="vHCol" style="width: 190px">
                                                        Chap.VI(A)-Others
                                                    </td>
                                                    <td class="iCol" style="width: 150px">
                                                        <asp:TextBox ID="txtChapterVIAOthers" runat="server" CssClass="txtBPR" AutoComplete="Off"
                                                            onkeypress="return numeralsOnly(this, event,10,2,0,1);" onchange="return checkDecimalNo(this);"
                                                            onkeyUp="CalculateAmount();"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr id="row80CCE" runat="server">
                                                    <td class="vHCol" style="width: 190px">
                                                        Chap.VI(A)-80CCE
                                                    </td>
                                                    <td class="iCol" style="width: 150px">
                                                        <asp:TextBox ID="txtChapterVIA80CCE" runat="server" CssClass="txtBPR" AutoComplete="Off"
                                                            onkeypress="return numeralsOnly(this, event,10,2,0,1);" onchange="return checkDecimalNo(this);"
                                                            onkeyUp="CalculateAmount();"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="vHCol" style="width: 190px">
                                                        Total Taxable Income
                                                    </td>
                                                    <td class="iCol" style="width: 150px">
                                                        <asp:TextBox ID="txtTotalTaxableIncome" runat="server" CssClass="roTxtBR" onkeypress="return numeralsOnly(this, event,10,2,0,1);"
                                                            onchange="return checkDecimalNo(this);" Enabled="false"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="vHCol" style="width: 190px">
                                                        Tax on Total Income
                                                    </td>
                                                    <td class="iCol" style="width: 150px">
                                                        <asp:TextBox ID="txtTaxOnTotalIncome" runat="server" CssClass="txtBPR" AutoComplete="Off"
                                                            onkeypress="return numeralsOnly(this, event,10,2,0,1);" onchange="return checkDecimalNo(this);"
                                                            onkeyUp="CalculateAmount();"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr id="Credit87A" runat="server">
                                                    <td class="vHCol" style="width: 190px">
                                                        Credit u/s 87A
                                                    </td>
                                                    <td class="iCol" style="width: 150px">
                                                        <asp:TextBox ID="txtCredit87A" runat="server" CssClass="txtBPR" AutoComplete="Off"
                                                            onkeypress="return numeralsOnly(this, event,10,2,0,1);" onchange="return checkDecimalNo(this);"
                                                            onkeyUp="CalculateAmount();"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="vHCol" style="width: 190px">
                                                        Surcharge
                                                    </td>
                                                    <td class="iCol" style="width: 150px">
                                                        <asp:TextBox ID="txtSurcharge" runat="server" CssClass="txtBPR" onkeypress="return numeralsOnly(this, event,10,2,0,1);"
                                                            onchange="return checkDecimalNo(this);" onkeyUp="CalculateAmount();" Enabled="false"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="vHCol" style="width: 190px">
                                                        Education Cess
                                                    </td>
                                                    <td class="iCol" style="width: 150px">
                                                        <asp:TextBox ID="txtEducationCess" runat="server" CssClass="txtBPR" AutoComplete="Off"
                                                            onkeypress="return numeralsOnly(this, event,10,2,0,1);" onchange="return checkDecimalNo(this);"
                                                            onkeyUp="CalculateAmount();"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="vHCol" style="width: 190px">
                                                        Relief u/s 89
                                                    </td>
                                                    <td class="iCol" style="width: 150px">
                                                        <asp:TextBox ID="txtReliefUS89" runat="server" CssClass="txtBPR" AutoComplete="Off"
                                                            onkeypress="return numeralsOnly(this, event,10,2,0,1);" onchange="return checkDecimalNo(this);"
                                                            onkeyUp="CalculateAmount();"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="vHCol" style="width: 190px">
                                                        Net Tax Payable
                                                    </td>
                                                    <td class="iCol" style="width: 150px">
                                                        <asp:TextBox ID="txtNetTaxPayable" runat="server" CssClass="roTxtBR" Enabled="false"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="vHCol" style="width: 190px">
                                                        Total TDS
                                                    </td>
                                                    <td class="iCol" style="width: 150px">
                                                        <asp:TextBox ID="txtTotalTDS" runat="server" CssClass="roTxtBR" Enabled="false" onkeypress="return numeralsOnly(this, event,10,2,0,1);"
                                                            onchange="return checkDecimalNo(this);" onkeyUp="CalculateAmount();"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="vHCol" style="width: 190px">
                                                        Tax Payable/Refundable
                                                    </td>
                                                    <td class="iCol" style="width: 150px">
                                                        <asp:TextBox ID="txtTaxPayableRefundable" runat="server" CssClass="roTxtBR" Enabled="false"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr runat="server" id="rowHigherRate">
                                                    <td class="vHCol" style="width: 190px">
                                                        TDS at Higher Rate
                                                    </td>
                                                    <td class="iCol" style="width: 150px">
                                                        <asp:DropDownList ID="ddlTDSHigherRate" runat="server" CssClass="dropDownList">
                                                            <asp:ListItem Text="No" Value="0"></asp:ListItem>
                                                            <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr runat="server" id="rowPreviousIncome">
                                                    <td class="vHCol" style="width: 190px">
                                                        Taxable Inc. Previous
                                                    </td>
                                                    <td class="iCol" style="width: 150px">
                                                        <asp:TextBox ID="txtPrevTaxableIncome" runat="server" CssClass="txtBPR" onkeypress="return numeralsOnly(this, event,10,2,0,1);"
                                                            onchange="return checkDecimalNo(this);" onkeyUp="CalculateAmount();"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr runat="server" id="rowPreviousTDS">
                                                    <td class="vHCol" style="width: 190px">
                                                        TDS Previous
                                                    </td>
                                                    <td class="iCol" style="width: 150px">
                                                        <asp:TextBox ID="txtPreviousTDS" runat="server" CssClass="txtBPR" onkeypress="return numeralsOnly(this, event,10,2,0,1);"
                                                            onchange="return checkDecimalNo(this);" onkeyUp="CalculateAmount();"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
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
                                            <asp:Button ID="btnViewExisting" runat="server" CssClass="cmnBtn" Text="View Existing"
                                                OnClick="btnViewExisting_Click" />
                                        </td>
                                        <td>
                                            <asp:Button ID="btnNew" runat="server" Text="New" CssClass="cmnBtn" OnClick="btnNew_Click"
                                                OnClientClick="return OnNewRecord();" />
                                        </td>
                                        <td>
                                            <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="cmnBtn" OnClick="btnUpdate_Click"
                                                OnClientClick="return Validation();" />
                                        </td>
                                        <td>
                                            <asp:Button ID="btnBlkUpdate" Text="Bulk Update" runat="server" CssClass="cmnBtn"
                                                OnClick="btnOk_Click" OnClientClick="SetBulkUpdateType();" />
                                        </td>
                                        <td>
                                            <asp:Button ID="btnRemove" runat="server" Text="Remove" CssClass="cmnBtn" OnClick="btnRemove_Click"
                                                OnClientClick="return ValidateSerialNo();" />
                                        </td>
                                        <td>
                                            <asp:Button ID="btnUpdDefaults" runat="server" Text="Update Defaults" CssClass="cmnBtn"
                                                Visible="false" OnClick="btnUpdDefaults_Click" />
                                        </td>
                                        <td>
                                            <asp:Button ID="btnClose" runat="server" Text="Close" CssClass="cmnBtn" OnClick="btnClose_Click" />
                                        </td>
                                        <td>
                                            <asp:Button ID="btnOpenSearch" runat="server" Text="Search" TabIndex="20" CssClass="cmnBtn"
                                                OnClientClick="SetStatus();" Width="80px" Style="display: none" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Panel ID="pnlSearch" runat="server" BorderStyle="Dashed" BorderWidth="1" CssClass="searchPanel">
                                    <table>
                                        <tr>
                                            <td>
                                                Name
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtSearchSerialNo" runat="server" Width="186px" TabIndex="20" CssClass="txtBPL"
                                                    onkeypress="return ValidateForAlphaNumeric(event);" MaxLength="75"></asp:TextBox>
                                            </td>
                                            <td style="width: 25px">
                                            </td>
                                            <td>
                                                PAN
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtSearchPAN" runat="server" Width="186px" TabIndex="20" CssClass="txtBPL"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3">
                                                <table>
                                                    <tr>
                                                        <td align="right">
                                                            <asp:Button ID="btnSearch1" runat="server" CssClass="cmnBtn" Text="Search" OnClick="btnSearch1_Click" />
                                                        </td>
                                                         <td>
                                                            <asp:Button ID="btnShowAll" runat="server" Text="Show All" CssClass="cmnBtn" OnClientClick="return ShowAllclick();"
                                                                OnClick="btnShowAll_Click" />
                                                        </td>
                                                        <td>
                                                            <asp:Button ID="btnClose1" runat="server" CssClass="cmnBtn" OnClick="btnClose1_Click"
                                                                OnClientClick="SetStatus();return false;" Text="Close" Width="80px" />
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
                    <table class="nTbl">
                        <tr>
                            <td>
                                <asp:Panel ID="navPanel" CssClass="navPanel" runat="server" ScrollBars="Horizontal">
                                    <asp:Repeater ID="rptrUpdatedSalary" runat="server" OnItemCommand="rptrUpdatedSalary_ItemCommand"
                                        OnItemDataBound="rptrUpdatedSalary_ItemDataBound">
                                        <HeaderTemplate>
                                            <table id="NavTable">
                                                <tr bgcolor="#EEEEEE">
                                                    <th>
                                                        Edit
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="Label18" Text="Correction Type" runat="server" Width="110px"></asp:Label>
                                                    </th>
                                                    <th style="display: none">
                                                        <asp:Label ID="Label19" Text="Serial No" runat="server" Width="50px"></asp:Label>
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="Label3" Text="Serial No" runat="server" Width="60px"></asp:Label>
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="Label1" Text="Name" runat="server" Width="250px"></asp:Label>
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="Label2" Text="PAN" runat="server" Width="80px"></asp:Label>
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="Label7" Text="Gross Salary" runat="server" Width="110px"></asp:Label>
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="Label10" Text="ET[16(II)]" runat="server" Width="110px"></asp:Label>
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="Label11" Text="PT[16(III)]" runat="server" Width="110px"></asp:Label>
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="Label8" Text="Other Income" runat="server" Width="110px"></asp:Label>
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="Label22" Text="Gross Total Income" runat="server" Width="100px"></asp:Label>
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="Label12" Text="CH VI(A)-80CCE" runat="server" Width="110px"></asp:Label>
                                                    </th>
                                                    <th runat="server" id="th80CCF">
                                                        <asp:Label ID="Label5" Text="CH VI(A)-80CCF" runat="server" Width="110px"></asp:Label>
                                                    </th>
                                                    <th runat="server" id="th80CCG">
                                                        <asp:Label ID="Label23" Text="CH VI(A)-80CCG" runat="server" Width="110px"></asp:Label>
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="Label13" Text="CH VI(A)-Others" runat="server" Width="110px"></asp:Label>
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="Label14" Text="Tax On Total Income" runat="server" Width="100px"></asp:Label>
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="Label15" Text="Surcharge" runat="server" Width="100px"></asp:Label>
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="Label16" Text="Education Cess" runat="server" Width="100px"></asp:Label>
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="Label9" Text="Relief U/S 89" runat="server" Width="100px"></asp:Label>
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="Label17" Text="Net Tax payable" runat="server" Width="100px"></asp:Label>
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="Label20" Text="Total TDS" runat="server" Width="100px"></asp:Label>
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="Label21" Text="TaxPayable/Refundable" runat="server"></asp:Label>
                                                    </th>
                                                </tr>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <tr bgcolor="white">
                                                <td>
                                                    <asp:LinkButton ID="btnEdit" runat="server" Text="Edit" CommandName="Edit" CommandArgument='<%#Eval("EmployeeSerialNo") %>'></asp:LinkButton>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblCurrentCorrStatus" Text='<%# Eval("CurrentCorrType")%>' runat="server"
                                                        Width="100px"></asp:Label>
                                                </td>
                                                <td style="text-align: center; display: none">
                                                    <asp:Label ID="lblEmpSerialNo" Text='<%# Eval("EmployeeSerialNo")%>' runat="server"> </asp:Label>
                                                </td>
                                                <td style="text-align: center">
                                                    <%# Eval("CorrEmployeeSerialNo")%>
                                                </td>
                                                <td>
                                                    <%# Eval("Name")%>
                                                </td>
                                                <td style="text-align: center">
                                                    <%# Eval("PAN")%>
                                                </td>
                                                <td style="text-align: right">
                                                    <%# Eval("GrossSalary")%>
                                                </td>
                                                <td style="text-align: right">
                                                    <%# Eval("ET")%>
                                                </td>
                                                <td style="text-align: right">
                                                    <%# Eval("PT")%>
                                                </td>
                                                <td style="text-align: right">
                                                    <%# Eval("OtherIncome")%>
                                                </td>
                                                <td style="text-align: right">
                                                    <%# Eval("GrossTotalIncome")%>
                                                </td>
                                                <td style="text-align: right">
                                                    <%# Eval("VIA80CCE")%>
                                                </td>
                                                <td style="text-align: right" runat="server" id="td80CCF">
                                                    <%# Eval("VIA80CCF")%>
                                                </td>
                                                <td style="text-align: right" runat="server" id="td80CCG">
                                                    <%# Eval("VIA80CCG")%>
                                                </td>
                                                <td style="text-align: right">
                                                    <%# Eval("VIA80Others")%>
                                                </td>
                                                <td style="text-align: right">
                                                    <%# Eval("TaxOnTotalIncome")%>
                                                </td>
                                                <td style="text-align: right">
                                                    <%# Eval("Surcharge")%>
                                                </td>
                                                <td style="text-align: right">
                                                    <%# Eval("EducationCess")%>
                                                </td>
                                                <td style="text-align: right">
                                                    <%# Eval("ReliefUS89")%>
                                                </td>
                                                <td style="text-align: right">
                                                    <%# Eval("NetTaxPayable")%>
                                                </td>
                                                <td style="text-align: right">
                                                    <%# Eval("TotalTDS")%>
                                                </td>
                                                <td style="text-align: right">
                                                    <%# Eval("TaxPayableRefundable")%>
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            </table>
                                        </FooterTemplate>
                                    </asp:Repeater>
                                </asp:Panel>
                                <table style="padding-right: 0px; margin-right: -2px; margin-bottom: -3px" align="right"
                                    id="tblPagination" runat="server" visible="false">
                                    <tr style="height: 20px!important">
                                        <td style="padding: 0px 0px 0px 0px">
                                            <asp:Label ID="Label1" runat="server" Text="Records per page : " Font-Size="X-Small" />
                                        </td>
                                        <td style="width: 50px; padding-top: 2px;">
                                            <asp:DropDownList ID="cmbGoTo" runat="server" Style="width: 50px; height: 15px; float: left;"
                                                OnSelectedIndexChanged="cmbGoTo_SelectedIndexChanged" AutoPostBack="true" Font-Size="X-Small">
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
                                            <asp:Label ID="lblGridStatus" runat="server" Style="float: left;" Text="Showing 0-0 of 0 [Page 0 of 0]"
                                                Font-Size="X-Small" />
                                        </td>
                                        <td>
                                            <asp:Button ID="btnFirst" runat="server" Text="&lt;&lt;" Font-Names="Arial" Font-Overline="False"
                                                OnClick="btnFirst_Click" Font-Size="X-Small" CssClass="navButton" Enabled="False">
                                            </asp:Button>
                                        </td>
                                        <td>
                                            <asp:Button ID="btnPrevious" runat="server" Text="&lt;" Font-Names="Arial" Font-Overline="False"
                                                OnClick="btnPrevious_Click" Font-Size="X-Small" CssClass="navButton" Enabled="False">
                                            </asp:Button>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtGoToPage" runat="server" Text="1" CssClass="navTextBox" AutoPostBack="True"
                                                OnTextChanged="txtGoToPage_TextChanged" MaxLength="5"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:Button ID="btnNext" runat="server" Text="&gt;" Font-Names="Arial" Font-Overline="False"
                                                OnClick="btnNext_Click" Font-Size="X-Small" CssClass="navButton"></asp:Button>
                                        </td>
                                        <td>
                                            <asp:Button ID="btnLast" runat="server" Text="&gt;&gt;" Font-Names="Arial" Font-Overline="False"
                                                OnClick="btnLast_Click" Font-Size="X-Small" CssClass="navButton"></asp:Button>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </asp:View>
                <asp:View ID="vwViewExisting" runat="server">
                    <table class="nTbl">
                        <tr>
                            <td>
                                <table>
                                    <tr>
                                        <td>
                                            Name
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtSearchName" runat="server" CssClass="txtBPL" Width="150px"> </asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:Button ID="btnSearch" runat="server" CssClass="cmnBtn" Text="Load" OnClick="btnSearch_Click" />
                                        </td>
                                        <td align="right" width="450px">
                                            <asp:CheckBox ID="chkShowAll" runat="server" Text="Show All Salary Records" AutoPostBack="true"
                                                OnCheckedChanged="chkShowAll_CheckedChanged"></asp:CheckBox>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Panel ID="Panel1" CssClass="navPanel" runat="server" ScrollBars="Horizontal"
                                    Width="730px" BorderStyle="Solid" BorderWidth="1px" BorderColor="Gray">
                                    <asp:Repeater ID="rptrCorrSalary" runat="server" OnItemDataBound="rptrCorrSalary_ItemDataBound">
                                        <HeaderTemplate>
                                            <table id="NavTable" border="1">
                                                <tr bgcolor="#EEEEEE">
                                                    <th runat="server" id="thSelect">
                                                    </th>
                                                    <th style="display: none">
                                                        <asp:Label ID="Label19" Text="Serial No" runat="server" Width="60px"></asp:Label>
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="Label4" Text="Serial No" runat="server" Width="60px"></asp:Label>
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="Label1" Text="Name" runat="server" Width="250px"></asp:Label>
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="Label2" Text="PAN" runat="server" Width="80px"></asp:Label>
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="Label7" Text="Gross Salary" runat="server" Width="110px"></asp:Label>
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="Label10" Text="ET[16(II)]" runat="server" Width="110px"></asp:Label>
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="Label11" Text="PT[16(III)]" runat="server" Width="110px"></asp:Label>
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="Label8" Text="Other Income" runat="server" Width="110px"></asp:Label>
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="Label22" Text="Gross Total Income" runat="server" Width="110px"></asp:Label>
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="Label12" Text="CH VI(A) - 80CCE" runat="server" Width="110px"></asp:Label>
                                                    </th>
                                                    <th runat="server" id="thExisting80CCF">
                                                        <asp:Label ID="Label6" Text="CH VI(A) - 80CCF" runat="server" Width="110px"></asp:Label>
                                                    </th>
                                                    <th runat="server" id="thExisting80CCG">
                                                        <asp:Label ID="Label24" Text="CH VI(A) - 80CCG" runat="server" Width="115px"></asp:Label>
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="Label13" Text="CH VI(A) - Others" runat="server" Width="120px"></asp:Label>
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="Label14" Text="Tax On Total Income" runat="server" Width="100px"></asp:Label>
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="Label15" Text="Surcharge" runat="server" Width="100px"></asp:Label>
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="Label16" Text="Education Cess" runat="server" Width="100px"></asp:Label>
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="Label9" Text="Relief U/S 89" runat="server" Width="100px"></asp:Label>
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="Label17" Text="Net Tax payable" runat="server" Width="100px"></asp:Label>
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="Label20" Text="Total TDS" runat="server" Width="100px"></asp:Label>
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="Label21" Text="TaxPayable/Refundable" runat="server" Width="150px"></asp:Label>
                                                    </th>
                                                </tr>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <tr bgcolor="white">
                                                <td runat="server" id="tdSelect">
                                                    <asp:CheckBox ID="chkCorrSalary" runat="server" />
                                                </td>
                                                <td style="text-align: center; display: none">
                                                    <asp:Label ID="lblEmployeeSerialNo" Text='<%# Eval("EmployeeSerialNo")%>' runat="server"></asp:Label>
                                                </td>
                                                <td style="text-align: center">
                                                    <%# Eval("CorrEmployeeSerialNo")%>
                                                </td>
                                                <td>
                                                    <%# Eval("Name")%>
                                                </td>
                                                <td>
                                                    <%# Eval("PAN")%>
                                                </td>
                                                <td style="text-align: right">
                                                    <%# Eval("GrossSalary")%>
                                                </td>
                                                <td style="text-align: right">
                                                    <%# Eval("ET")%>
                                                </td>
                                                <td style="text-align: right">
                                                    <%# Eval("PT")%>
                                                </td>
                                                <td style="text-align: right">
                                                    <%# Eval("OtherIncome")%>
                                                </td>
                                                <td style="text-align: right">
                                                    <%# Eval("GrossTotalIncome")%>
                                                </td>
                                                <td style="text-align: right">
                                                    <%# Eval("VIA80CCE")%>
                                                </td>
                                                <td style="text-align: right" runat="server" id="tdExisting80CCF">
                                                    <%# Eval("VIA80CCF")%>
                                                </td>
                                                <td style="text-align: right" runat="server" id="tdExisting80CCG">
                                                    <%# Eval("VIA80CCG")%>
                                                </td>
                                                <td style="text-align: right">
                                                    <%# Eval("VIA80Others")%>
                                                </td>
                                                <td style="text-align: right">
                                                    <%# Eval("TaxOnTotalIncome")%>
                                                </td>
                                                <td style="text-align: right">
                                                    <%# Eval("Surcharge")%>
                                                </td>
                                                <td style="text-align: right">
                                                    <%# Eval("EducationCess")%>
                                                </td>
                                                <td style="text-align: right">
                                                    <%# Eval("ReliefUS89")%>
                                                </td>
                                                <td style="text-align: right">
                                                    <%# Eval("NetTaxPayable")%>
                                                </td>
                                                <td style="text-align: right">
                                                    <%# Eval("TotalTDS")%>
                                                </td>
                                                <td style="text-align: right">
                                                    <%# Eval("TaxPayableRefundable")%>
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            </table>
                                        </FooterTemplate>
                                    </asp:Repeater>
                                </asp:Panel>
                                <table style="padding-right: 0px; margin-right: -2px; margin-bottom: -3px" align="right">
                                    <tr style="height: 20px!important">
                                        <td style="padding: 0px 0px 0px 0px">
                                            <asp:Label ID="ASPxLabel4" runat="server" Text="Records per page : " Font-Size="X-Small" />
                                        </td>
                                        <td style="width: 50px; padding-top: 2px;">
                                            <asp:DropDownList ID="cmbPopUpGoTo" runat="server" Style="width: 50px; height: 15px;
                                                float: left;" OnSelectedIndexChanged="cmbPopUpGoTo_SelectedIndexChanged" AutoPostBack="true"
                                                Font-Size="X-Small">
                                                <asp:ListItem Text="5" Value="5" />
                                                <asp:ListItem Text="10" Value="10" Selected="True" />
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
                            <td>
                                <table>
                                    <tr>
                                        <td width="40%">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblSelect" runat="server" Text="Select"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:LinkButton ID="lnkbtnCheckAll" runat="server" Text="All" OnClientClick="return SelectAllCheckBox();"></asp:LinkButton>
                                                    </td>
                                                    <td>
                                                        <asp:LinkButton ID="lnkbtnUnCheckAll" runat="server" Text="None" OnClientClick="return UnSelectAllCheckBox();"
                                                            CausesValidation="true"></asp:LinkButton>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="40%">
                                            <table>
                                                <tr>
                                                    <td>
                                                        Correction Type
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlCorrectionType" runat="server">
                                                            <asp:ListItem Text="Select" Value="-1"></asp:ListItem>
                                                            <asp:ListItem Text="Update" Value="2"></asp:ListItem>
                                                            <asp:ListItem Text="Delete" Value="4"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td>
                                                        <asp:Button ID="btnViewExistingAddAll" runat="server" Text="Add From Sl No" Width="100px"
                                                            CssClass="cmnBtn" OnClick="btnViewExistingAddAll_Click" />
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtSerialNo_From" Width="48px" MaxLength="7" CssClass="txtBPL" runat="server"
                                                            onkeypress="return ValidateForOnlyNos(event);"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td align="right" width="60%">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <asp:Button ID="btnViewExistingAdd" runat="server" Text="Add" CssClass="cmnBtn" OnClick="btnViewExistingAdd_Click"
                                                            OnClientClick="return ValidateCorrectionType();" />
                                                    </td>
                                                    <td>
                                                        <asp:Button ID="btnCreateAll" runat="server" Text="Create All" CssClass="cmnBtn"
                                                            OnClick="btnCreateAll_Click" />
                                                    </td>
                                                    <td>
                                                        <asp:Button ID="btnViewExistingClose" runat="server" Text="Close" CssClass="cmnBtn"
                                                            OnClick="btnViewExistingClose_Click" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="3">
                                            <b><font color="blue"></font></b>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </asp:View>
                <asp:View ID="vwMoreDetails" runat="server">
                    <div style="padding: 10px; border-top: solid 1px gray">
                        <table width="100%">
                            <tr>
                                <td style="padding: 4px 4px 4px 10px;" class="dHeader">
                                    If aggregate rent payment exceeds Rupees One Lakh(Rs. 1,00,000)
                                </td>
                            </tr>
                        </table>
                        <table width="100%">
                            <tr>
                                <td>
                                    PAN of Landlord 1
                                </td>
                                <td>
                                    <asp:TextBox ID="txtPANLL1" runat="server" AutoComplete="off" Width="170px" TabIndex="1"
                                        MaxLength="10" CssClass="txtAR" onblur="return checkValidatePAN(this,1);" onkeypress="return checkFinYear(this,1)"></asp:TextBox>
                                    <cc1:AutoCompleteExtender ID="AutoCompleteExtenderPANLL1" runat="server" MinimumPrefixLength="1"
                                        ServicePath="~/WebServices/AutoCompleteService.asmx" ServiceMethod="LandlordPAN"
                                        TargetControlID="txtPANLL1" CompletionInterval="700" EnableCaching="false" CompletionSetCount="20"
                                        DelimiterCharacters="" ShowOnlyCurrentWordInCompletionListItem="true" FirstRowSelected="false">
                                    </cc1:AutoCompleteExtender>
                                </td>
                                <td>
                                    Name of Landlord 1
                                </td>
                                <td>
                                    <asp:TextBox ID="txtNameLL1" runat="server" AutoComplete="off" Width="170px" TabIndex="1"
                                        CssClass="txtAR" onkeypress="return checkFinYear(this,2)"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    PAN of Landlord 2
                                </td>
                                <td>
                                    <asp:TextBox ID="txtPANLL2" runat="server" AutoComplete="off" CssClass="txtAR" MaxLength="10"
                                        TabIndex="1" Width="170px" onblur="return checkValidatePAN(this,2);" onkeypress="return checkFinYear(this,3)"></asp:TextBox>
                                    <cc1:AutoCompleteExtender ID="AutoCompleteExtenderPANLL2" runat="server" MinimumPrefixLength="1"
                                        ServicePath="~/WebServices/AutoCompleteService.asmx" ServiceMethod="LandlordPAN"
                                        TargetControlID="txtPANLL2" CompletionInterval="700" EnableCaching="false" CompletionSetCount="20"
                                        DelimiterCharacters="" ShowOnlyCurrentWordInCompletionListItem="true" FirstRowSelected="false">
                                    </cc1:AutoCompleteExtender>
                                </td>
                                <td>
                                    Name of Landlord 2
                                </td>
                                <td>
                                    <asp:TextBox ID="txtNameLL2" runat="server" AutoComplete="off" CssClass="txtAR" TabIndex="1"
                                        Width="170px" onkeypress="return checkFinYear(this,4)"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    PAN of Landlord 3
                                </td>
                                <td>
                                    <asp:TextBox ID="txtPANLL3" runat="server" AutoComplete="off" CssClass="txtAR" MaxLength="10"
                                        TabIndex="1" Width="170px" onblur="return checkValidatePAN(this,3);" onkeypress="return checkFinYear(this,5)"></asp:TextBox>
                                    <cc1:AutoCompleteExtender ID="AutoCompleteExtenderPANLL3" runat="server" MinimumPrefixLength="1"
                                        ServicePath="~/WebServices/AutoCompleteService.asmx" ServiceMethod="LandlordPAN"
                                        TargetControlID="txtPANLL3" CompletionInterval="700" EnableCaching="false" CompletionSetCount="20"
                                        DelimiterCharacters="" ShowOnlyCurrentWordInCompletionListItem="true" FirstRowSelected="false">
                                    </cc1:AutoCompleteExtender>
                                </td>
                                <td>
                                    Name of Landlord 3
                                </td>
                                <td>
                                    <asp:TextBox ID="txtNameLL3" runat="server" AutoComplete="off" CssClass="txtAR" TabIndex="1"
                                        Width="170px" onkeypress="return checkFinYear(this,6)"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    PAN of Landlord 4
                                </td>
                                <td>
                                    <asp:TextBox ID="txtPANLL4" runat="server" AutoComplete="off" CssClass="txtAR" MaxLength="10"
                                        TabIndex="1" Width="170px" onblur="return checkValidatePAN(this,4);" onkeypress="return checkFinYear(this,7)"></asp:TextBox>
                                    <cc1:AutoCompleteExtender ID="AutoCompleteExtenderPANLL4" runat="server" MinimumPrefixLength="1"
                                        ServicePath="~/WebServices/AutoCompleteService.asmx" ServiceMethod="LandlordPAN"
                                        TargetControlID="txtPANLL4" CompletionInterval="700" EnableCaching="false" CompletionSetCount="20"
                                        DelimiterCharacters="" ShowOnlyCurrentWordInCompletionListItem="true" FirstRowSelected="false">
                                    </cc1:AutoCompleteExtender>
                                </td>
                                <td>
                                    Name of Landlord 4
                                </td>
                                <td>
                                    <asp:TextBox ID="txtNameLL4" runat="server" AutoComplete="off" CssClass="txtAR" TabIndex="1"
                                        Width="170px" onkeypress="return checkFinYear(this,8)"></asp:TextBox>
                                </td>
                            </tr>
                    </div>
                    <div style="padding: 10px; border-top: solid 1px gray">
                        <table width="100%">
                            <tr>
                                <td style="padding: 4px 4px 4px 10px;" class="dHeader">
                                    If interest paid to Lender under the head &#39;Income from House Property&#39;
                                </td>
                            </tr>
                        </table>
                        <table width="100%">
                            <tr>
                                <td>
                                    PAN of Lender 1
                                </td>
                                <td>
                                    <asp:TextBox ID="txtPANL1" runat="server" AutoComplete="off" Width="170px" TabIndex="1"
                                        MaxLength="10" CssClass="txtAR" onblur="return checkValidatePAN(this,5);" onkeypress="return checkFinYear(this,9)"></asp:TextBox>
                                    <cc1:AutoCompleteExtender ID="AutoCompleteExtenderPANL1" runat="server" MinimumPrefixLength="1"
                                        ServicePath="~/WebServices/AutoCompleteService.asmx" ServiceMethod="LandlordPAN"
                                        TargetControlID="txtPANL1" CompletionInterval="700" EnableCaching="false" CompletionSetCount="20"
                                        DelimiterCharacters="" ShowOnlyCurrentWordInCompletionListItem="true" FirstRowSelected="false">
                                    </cc1:AutoCompleteExtender>
                                </td>
                                <td>
                                    Name of Lender 1
                                </td>
                                <td>
                                    <asp:TextBox ID="txtNameL1" runat="server" AutoComplete="off" Width="170px" TabIndex="1"
                                        CssClass="txtAR" onkeypress="return checkFinYear(this,10)"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    PAN of Lender 2
                                </td>
                                <td>
                                    <asp:TextBox ID="txtPANL2" runat="server" AutoComplete="off" Width="170px" TabIndex="1"
                                        MaxLength="10" CssClass="txtAR" onblur="return checkValidatePAN(this,6);" onkeypress="return checkFinYear(this,11)"></asp:TextBox>
                                    <cc1:AutoCompleteExtender ID="AutoCompleteExtenderPANL2" runat="server" MinimumPrefixLength="1"
                                        ServicePath="~/WebServices/AutoCompleteService.asmx" ServiceMethod="LandlordPAN"
                                        TargetControlID="txtPANL2" CompletionInterval="700" EnableCaching="false" CompletionSetCount="20"
                                        DelimiterCharacters="" ShowOnlyCurrentWordInCompletionListItem="true" FirstRowSelected="false">
                                    </cc1:AutoCompleteExtender>
                                </td>
                                <td>
                                    Name of Lender 2
                                </td>
                                <td>
                                    <asp:TextBox ID="txtNameL2" runat="server" AutoComplete="off" Width="170px" TabIndex="1"
                                        CssClass="txtAR" onkeypress="return checkFinYear(this,12)"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    PAN of Lender 3
                                </td>
                                <td>
                                    <asp:TextBox ID="txtPANL3" runat="server" AutoComplete="off" Width="170px" TabIndex="1"
                                        MaxLength="10" CssClass="txtAR" onblur="return checkValidatePAN(this,7);" onkeypress="return checkFinYear(this,13)"></asp:TextBox>
                                    <cc1:AutoCompleteExtender ID="AutoCompleteExtenderPANL3" runat="server" MinimumPrefixLength="1"
                                        ServicePath="~/WebServices/AutoCompleteService.asmx" ServiceMethod="LandlordPAN"
                                        TargetControlID="txtPANL3" CompletionInterval="700" EnableCaching="false" CompletionSetCount="20"
                                        DelimiterCharacters="" ShowOnlyCurrentWordInCompletionListItem="true" FirstRowSelected="false">
                                    </cc1:AutoCompleteExtender>
                                </td>
                                <td>
                                    Name of Lender 3
                                </td>
                                <td>
                                    <asp:TextBox ID="txtNameL3" runat="server" AutoComplete="off" Width="170px" TabIndex="1"
                                        CssClass="txtAR" onkeypress="return checkFinYear(this,14)"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    PAN of Lender 4
                                </td>
                                <td>
                                    <asp:TextBox ID="txtPANL4" runat="server" AutoComplete="off" Width="170px" TabIndex="1"
                                        MaxLength="10" CssClass="txtAR" onblur="return checkValidatePAN(this,8);" onkeypress="return checkFinYear(this,15)"></asp:TextBox>
                                    <cc1:AutoCompleteExtender ID="AutoCompleteExtenderPANL4" runat="server" MinimumPrefixLength="1"
                                        ServicePath="~/WebServices/AutoCompleteService.asmx" ServiceMethod="LandlordPAN"
                                        TargetControlID="txtPANL4" CompletionInterval="700" EnableCaching="false" CompletionSetCount="20"
                                        DelimiterCharacters="" ShowOnlyCurrentWordInCompletionListItem="true" FirstRowSelected="false">
                                    </cc1:AutoCompleteExtender>
                                </td>
                                <td>
                                    Name of Lender 4
                                </td>
                                <td>
                                    <asp:TextBox ID="txtNameL4" runat="server" AutoComplete="off" Width="170px" TabIndex="1"
                                        CssClass="txtAR" onkeypress="return checkFinYear(this,16)"></asp:TextBox>
                                </td>
                            </tr>
                    </div>
                    <div style="padding: 10px; border-top: solid 1px gray">
                        <table width="100%">
                            <tr>
                                <td style="padding: 4px 4px 4px 10px;" class="dHeader">
                                    If contributions paid by the trustees of an approved superannuation fund
                                </td>
                            </tr>
                        </table>
                        <table width="100%">
                            <tr>
                                <td>
                                    Name of the superannuation fund
                                </td>
                                <td>
                                    <asp:TextBox ID="txtSAFName" runat="server" AutoComplete="off" Width="170px" TabIndex="1"
                                        CssClass="txtAR"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Contribution From
                                </td>
                                <td>
                                    <asp:TextBox ID="txtSAFContributionFrom" runat="server" AutoComplete="off" Width="170px"
                                        TabIndex="1" CssClass="txtAR" ToolTip="Enter Date (Format: DD/MM/YYYY or DD MM YYYY)"
                                        onBlur="setDateFormat(this);"></asp:TextBox>
                                </td>
                                <td>
                                    Contribution To
                                </td>
                                <td>
                                    <asp:TextBox ID="txtSAFContributionTo" runat="server" AutoComplete="off" Width="170px"
                                        TabIndex="1" CssClass="txtAR" ToolTip="Enter Date (Format: DD/MM/YYYY or DD MM YYYY)"
                                        onBlur="setDateFormat(this);"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Contribution Repaid
                                </td>
                                <td>
                                    <asp:TextBox ID="txtSAFContributionRepaid" runat="server" AutoComplete="off" Width="170px"
                                        TabIndex="1" MaxLength="12" CssClass="txtAR" onkeypress="return numeralsOnly(this, event,12,0,0,0);"></asp:TextBox>
                                </td>
                                <td>
                                    Average Tax Rate (%)
                                </td>
                                <td>
                                    <asp:TextBox ID="txtSAFAvgTaxRate" runat="server" AutoComplete="off" Width="170px"
                                        TabIndex="1" MaxLength="12" CssClass="txtAR" onkeypress="return numeralsOnly(this, event,7,4,0,1,0);"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Tax Deducted
                                </td>
                                <td>
                                    <asp:TextBox ID="txtSAFTaxDeducted" runat="server" AutoComplete="off" Width="170px"
                                        TabIndex="1" MaxLength="12" CssClass="txtAR" onkeypress="return numeralsOnly(this, event,12,0,0,0);"></asp:TextBox>
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                            </tr>
                    </div>
                    <tr>
                        <td colspan="2">
                            <asp:Button ID="btnOkMoreDetails" Text="OK" runat="server" CssClass="cmnBtn" TabIndex="6"
                                OnClientClick="return validateMoreDetails();" OnClick="btnOkMoreDetails_Click" />
                            <asp:Button ID="btnCloseMoreDetails" Text="Back" runat="server" CssClass="cmnBtn"
                                TabIndex="6" OnClick="btnCloseMoreDetails_Click" />
                        </td>
                    </tr>
                    </table>
                </asp:View>
                <asp:View ID="vwBulkUpdate" runat="server">
                    <table class="nTbl">
                        <tr>
                            <td>
                                <table width="100%">
                                    <tr>
                                        <td width="100px">
                                            <asp:Button ID="btnExport" runat="server" Text="Export" CssClass="cmnBtn" OnClick="btnBlkUpdate_Click" />
                                        </td>
                                        <td width="100px">
                                            <asp:Button ID="btnImport" runat="server" Text="Import" CssClass="cmnBtn" />
                                        </td>
                                        <td width="100px">
                                            <asp:Button ID="btnBulkUpdate" runat="server" Text="Update" CssClass="cmnBtn" OnClick="btnBulkUpdate_Click"
                                                Visible="False" />
                                        </td>
                                        <td>
                                            <asp:HyperLink ID="hlnkOpenErrors" runat="server" Text="" Target="_blank" Visible="false">
                                            </asp:HyperLink>
                                        </td>
                                        <td align="right">
                                            <asp:Button ID="btnBulkClose" runat="server" Text="Close" CssClass="cmnBtn" OnClick="btnBulkClose_Click" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </asp:View>
            </asp:MultiView>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
