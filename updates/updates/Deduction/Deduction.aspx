<%@ page title="" language="C#" masterpagefile="~/SaralTDS.master" autoeventwireup="true" inherits="Deduction_Deduction, App_Web_deduction.aspx.5ca9984b" enableeventvalidation="false" %>

<%@ MasterType VirtualPath="~/SaralTDS.master" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript" language="javascript">
        function Validations() { 
            if (!ValidateLength(document.getElementById("<%=txtName.ClientID%>"), "Deductee Name.", 75, true)) return false;
            if (!ValidateDeductee(document.getElementById("<%=hdnDeducteeID.ClientID%>"), document.getElementById("<%=txtName.ClientID%>"), null)) return false;
            if (document.getElementById("<%=rowSection.ClientID%>").style.display == '') {
                if (document.getElementById("<%=hdnSectionID.ClientID%>").value == "-1" || document.getElementById("<%=hdnSectionID.ClientID%>").value == "0") {
                    if (!ValidateDropDown(document.getElementById("<%=ddlSection.ClientID%>"), ((document.getElementById("<%=hdnIsCBI.ClientID%>").value == "1" && document.getElementById("<%=hdnFormType.ClientID%>").value == "Form26") ? "BGLCode" : "Section."))) return false;
                }
            }
            if (!ValidateLength(document.getElementById("<%=txtAmountOfPayment.ClientID%>"), "Amount Of Payment.", 14, true)) return false;
            var section = document.getElementById("<%=ddlSection.ClientID%>")[document.getElementById("<%=ddlSection.ClientID%>").selectedIndex].text;
            var txtAmtCashDrawn = document.getElementById("<%=txtAmtCashDrawn.ClientID%>");
            if (txtAmtCashDrawn != null) {
                if (section.indexOf("194N") != -1) {
                    if (!ValidateLength(document.getElementById("<%=txtAmtCashDrawn.ClientID%>"), "Amount of Cash Withdrawal", 14, true)) return false;
                }
            }     
            if (document.getElementById("<%=hdnIsValid.ClientID%>").value == "0" && document.getElementById("<%=hdnFormType.ClientID%>").value == "Form27E")
                if (!ValidateLength(document.getElementById("<%=txtTotalValueOfPurchase.ClientID%>"), "Total Value of Pur.(s)", 14, true)) return false;
            if (!ValidateCreditedDate()) return false;
            if (!ValidateRates(document.getElementById("<%=txtSurchargeRate.ClientID%>"), document.getElementById("<%=txtEduCessRate.ClientID%>"), document.getElementById("<%=txtTaxDeductedRate.ClientID%>"), document.getElementById("<%=hdnFormType.ClientID%>"))) return false;
            if (!ValidateTaxDedDate()) return false;
            if (document.getElementById("<%=txtTaxDedDate.ClientID%>").value != "" && document.getElementById("<%=txtCreditedDate.ClientID%>").value != "") {
                if (!ValidateDates(document.getElementById("<%=txtCreditedDate.ClientID%>").value, document.getElementById("<%=txtTaxDedDate.ClientID%>").value)) return false;
            }
            if (document.getElementById("<%=hdnFormType.ClientID%>").value == "Form26") {
                if (!ValidateNonDeductionReason(document.getElementById("<%=ddlSection.ClientID%>"), document.getElementById("<%=ddlNonDeductionReason.ClientID%>"), document.getElementById("<%=hdnFinYear.ClientID%>"))) return false;
                if (!ValidateTaxAmountsForParticularSections(document.getElementById("<%=txtTaxDeducted.ClientID%>"), document.getElementById("<%=txtTaxDeductedRate.ClientID%>"), document.getElementById("<%=txtITRate.ClientID%>"), document.getElementById("<%=ddlSection.ClientID%>"), document.getElementById("<%=ddlNonDeductionReason.ClientID%>"), document.getElementById("<%=hdnFinYear.ClientID%>"))) return false;
                if (document.getElementById("<%=hdnFinYear.ClientID%>").value != 2009 && document.getElementById("<%=ddlSection.ClientID%>").display != 'none') {
                    if (!ValidateThreshold(document.getElementById("<%=ddlSection.ClientID%>"), document.getElementById("<%=ddlNonDeductionReason.ClientID%>"))) return false;
                }
            }
            else if (document.getElementById("<%=hdnFormType.ClientID%>").value == "Form27") {
                if (!ValidateTaxAmountsForParticularSections(document.getElementById("<%=txtTaxDeducted.ClientID%>"), document.getElementById("<%=txtTaxDeductedRate.ClientID%>"), document.getElementById("<%=txtITRate.ClientID%>"), document.getElementById("<%=ddlSection.ClientID%>"), document.getElementById("<%=ddlNonDeductionReason.ClientID%>"), document.getElementById("<%=hdnFinYear.ClientID%>"))) return false;
            }            
            if (section.indexOf("194LD") != -1) {
                if (!ValidateSectionBasedOnDate()) return false;
            }
            if (section.indexOf("192A") != -1 || section.indexOf("194LBB") != -1) {
                var date = new Date(2015, 05, 01);
                var paymentDate = document.getElementById("<%=txtCreditedDate.ClientID%>");
                var date1 = paymentDate.value.split('/', 3);
                var creditedDate = new Date(date1[2], (Return(date1[1]) - 1), date1[0]);
                if (creditedDate < date) {
                    alert("Section '" + ((section.indexOf("192A") != -1) ? "192A" : "194LBB") + "' is Applicable from '01/06/2015'.");
                    return false;
                }
            }                
            if (section.indexOf("194N") != -1) {                
                if (!Validate194NSectionBasedOnDate()) return false;
            }                    

            if (Return(document.getElementById("<%=hdnFinYear.ClientID%>").value) >= 2012 && section.indexOf("194LC") != -1 && document.getElementById("<%=ddlNonDeductionReason.ClientID%>").value == "3") {
                alert("The Deduction Remark 'Deduction at Higher Rate 20% - PANNOTAVBL' is not applicable for Section 194LC");
                return false;
            }
            if (Return(document.getElementById("<%=txtTaxDeducted.ClientID%>").value) == 0 && (Return(document.getElementById("<%=hdnChallanID.ClientID%>").value) == -1 && Return(document.getElementById("<%=ddlNonDeductionReason.ClientID%>").selectedIndex) == 0)) {
                if (document.getElementById("<%=hdnFormType.ClientID%>").value != "Form24") {
                    alert("Specify the Remarks for Deduction.");
                    document.getElementById("<%=ddlNonDeductionReason.ClientID%>").focus();
                    return false;
                }
                else {
                    return confirm("'Remarks for Deduction' is required for Non-Deduction records.\nIf none are applicable, recommended to link to a paid challan.");
                }
            }
            if (document.getElementById("<%=hdnFormType.ClientID%>").value == "Form24") {
                if (document.getElementById("<%=hdnIsUCO.ClientID%>").value == "1") {
                    if (Return(document.getElementById("<%=txtTaxDeducted.ClientID%>").value) > 0) {
                        if (Return(document.getElementById("<%=txtEduCessAmount.ClientID%>").value) <= 0) {
                            alert("Specify Edu Cess for Deduction.");
                            return false;
                        }
                    }
                }
            }
            if (document.getElementById("<%=hdnFormType.ClientID%>").value == "Form26" || document.getElementById("<%=hdnFormType.ClientID%>").value == "Form27") {
                if (!ValidateSectionandNonDedReason()) return false;
                if (document.getElementById("<%=ddlNonDeductionReason.ClientID%>").value == "6") {
                    if (!ValidatePaymentDateBasedOnSection()) return false;
                }
            }
            if (document.getElementById("<%=divChallanDetail.ClientID%>") != null) {
                if (!ValidateChallanDetails(document.getElementById("<%=hdnChallanID.ClientID%>"), document.getElementById("<%=txtTaxDeducted.ClientID%>"), document.getElementById("<%=txtChallanSlNo.ClientID%>"), document.getElementById("<%=ddlQuarter.ClientID%>"))) return false;
            }
            if (document.getElementById("<%=hdnFinYear.ClientID%>").value != "2009" && document.getElementById("<%=hdnIsValid.ClientID%>").value != "1") {
                if (Return(document.getElementById("<%=hdnFinYear.ClientID%>").value) >= 2012 && section.indexOf("194LC") == -1) {
                    if (!ValidateIfPANNotAvailableOthers(0, document.getElementById("<%=hdnIsValidPAN.ClientID%>"), document.getElementById("<%=hdnFormType.ClientID%>"), document.getElementById("<%=txtTaxDeductedRate.ClientID%>"),
                    document.getElementById("<%=ddlNonDeductionReason.ClientID%>"), document.getElementById("<%=txtTaxDeducted.ClientID%>"), document.getElementById("<%=txtITRate.ClientID%>"), document.getElementById("<%=txtIncomeTaxAmount.ClientID%>"))) return false;
                }
            }

                   
            var txtAmountOfPayment = document.getElementById("<%=txtAmountOfPayment.ClientID %>");
            var txtTaxDeducted = document.getElementById("<%=txtTaxDeducted.ClientID%>");
            if (txtAmtCashDrawn != null) {
                if (section.indexOf("194N") != -1) {
                    //                if (!Validate194NSectionBasedOnDate()) return false;
                    if ((Return(txtAmtCashDrawn.value)) > (Return(txtAmountOfPayment.value))) {
                        alert("Amount of Cash Withdrawal should be less than or equal to Amount of Payment")
                        return false;
                    }
                    if ((Return(txtTaxDeducted.value)) > (Return(txtAmtCashDrawn.value))) {
                        alert("Tax Deducted Amount should be less than or equal to Amount of Cash Withdrawal")
                        return false;
                    }
                }
            }
            else {
                if ((Return(txtTaxDeducted.value)) > (Return(txtAmountOfPayment.value))) {
                    alert("Tax Deducted Amount should be less than or equal to Amount of Payment")
                    return false;
                }
            }

            if (section.indexOf("194N") != -1) {
//                if (!Validate194NSectionBasedOnDate()) return false;
//                if ((Return(txtAmtCashDrawn.value)) > (Return(txtAmountOfPayment.value))) {
//                    alert("Amount of Cash Withdrawal should be less than or equal to Amount of Payment")
//                    return false;
//                }
                if (!ValidateNonDedReasonfor194N(document.getElementById("<%=ddlNonDeductionReason.ClientID%>"), document.getElementById("<%=txtTaxDeducted.ClientID%>"))) return false;
            }
            if (document.getElementById("<%=hdnFormType.ClientID%>").value == "Form26" && document.getElementById("<%=hdnIsTran.ClientID%>").value == "True") {
                if (!ValidateIfPANAndTransporter(document.getElementById("<%=hdnIsTran.ClientID%>"), document.getElementById("<%=hdnIsValidPAN.ClientID%>"),
                                document.getElementById("<%=txtTaxDeductedRate.ClientID%>"), document.getElementById("<%=txtTaxDeducted.ClientID%>"),
                                document.getElementById("<%=ddlNonDeductionReason.ClientID%>"), document.getElementById("<%=hdnFormType.ClientID%>"), document.getElementById("<%=txtITRate.ClientID%>"))) return false;
                if (!ValidateIfTransporter(document.getElementById("<%=hdnIsValidPAN.ClientID%>"), document.getElementById("<%=txtTaxDeducted.ClientID%>"), document.getElementById("<%=ddlNonDeductionReason.ClientID%>"),
                     document.getElementById("<%=txtITRate.ClientID%>"), document.getElementById("<%=txtTaxDeductedRate.ClientID%>"))) return false;
            }
            if (document.getElementById("<%=hdnFormType.ClientID%>").value != "Form24") {
                var itRate = document.getElementById("<%=txtITRate.ClientID%>").value;
                var incomeTaxAmt = document.getElementById("<%=txtIncomeTaxAmount.ClientID%>").value;
                if (Return(itRate) == 0 && Return(incomeTaxAmt) > 0) {
                    alert("Please specify both Tax Rate and Tax Amount");
                    return false;
                }
            }
            if (document.getElementById("<%=hdnIsChildBranch.ClientID%>").value == "1") {
                if (document.getElementById("<%=hdnFormType.ClientID%>").value == "Form26") {
                    if (!(Return(document.getElementById("<%=hdnSectionID.ClientID%>").value) == 5 || Return(document.getElementById("<%=hdnSectionID.ClientID%>").value) == 3)) {
                        alert("Select only 193 or 194A section.");
                        return false;
                    }
                }
                else if (document.getElementById("<%=hdnFormType.ClientID%>").value == "Form27" && Return(document.getElementById("<%=hdnSectionID.ClientID%>").value) != 17) {
                    alert("Select only 195 section.");
                    return false;
                }
            }
            if (document.getElementById("<%=hdnFormType.ClientID%>").value == "Form26") {
                if (document.getElementById("<%=ddlNonDeductionReason.ClientID%>").value == "7" && Return(document.getElementById("<%=txtTaxDeducted.ClientID%>").value) > 0) {
                    if (!confirm("Tax amount is specified for 'NO DEDUCTION U/S 197A(1F)'.\nDo you want to continue with update?"))
                        return false;
                }
            }
            if (Return(document.getElementById("<%=hdnFinYear.ClientID%>").value) > 2012) {
                if (document.getElementById("<%=hdnFormType.ClientID%>").value == "Form24" || document.getElementById("<%=hdnFormType.ClientID%>").value == "Form27") {
                    if (document.getElementById("<%=ddlNonDeductionReason.ClientID%>").value == "1" || document.getElementById("<%=ddlNonDeductionReason.ClientID%>").value == "2") {
                        if (document.getElementById("<%=txtCertNo.ClientID%>").value.trim() == "") {
                            alert("Specify 'U/s 197 Cert.No.'.");
                            document.getElementById("<%=txtCertNo.ClientID%>").focus();
                            return false;
                        }
                        else {
                            if (!ValidateCertificateNumber(document.getElementById("<%=txtCertNo.ClientID%>"), "U/s 197 Cert.No.", 10, true))
                                return false;
                        }
                    }
                }
                else if (document.getElementById("<%=ddlNonDeductionReason.ClientID%>").value == "1" || document.getElementById("<%=ddlNonDeductionReason.ClientID%>").value == "2") {
                    if (document.getElementById("<%=ddlNonDeductionReason.ClientID%>").value == "1" && document.getElementById("<%=txtCertNo.ClientID%>").value.trim() == "") {
                        alert("Specify 'U/s 197 Cert.No.'.");
                        document.getElementById("<%=txtCertNo.ClientID%>").focus();
                        return false;
                    }
                    else {
                        if (document.getElementById("<%=ddlNonDeductionReason.ClientID%>").value == "2") {
                            if ((Return(document.getElementById("<%=hdnQuarter.ClientID%>").value == "Quarter1" ? 1 : document.getElementById("<%=hdnQuarter.ClientID%>").value == "Quarter2" ? 2 : document.getElementById("<%=hdnQuarter.ClientID%>").value == "Quarter3" ? 3 : document.getElementById("<%=hdnQuarter.ClientID%>").value == "Quarter4" ? 4 : 0) > 2 && Return(document.getElementById("<%=hdnFinYear.ClientID%>").value) == 2015) || Return(document.getElementById("<%=hdnFinYear.ClientID%>").value) > 2015) {
                                if (document.getElementById("<%=txtCertNo.ClientID%>").value.trim() != "") {
                                    var pattern = /^[gGhH]{1}[0-9]{9}$/;
                                    var val = document.getElementById("<%=txtCertNo.ClientID%>").value;
                                    var matchArray = val.match(pattern);
                                    if (matchArray == null) {
                                        alert("Specify valid 15G/15H UIN.\nEx: G123456789/H123456789");
                                        document.getElementById("<%=txtCertNo.ClientID%>").focus();
                                        return false;
                                    }
                                }
                            }
                        }
                        else {
                            if (!ValidateCertificateNumber(document.getElementById("<%=txtCertNo.ClientID%>"), "U/s 197 Cert.No.", 10, true))
                                return false;
                        }
                    }
                }
                if (Return(document.getElementById("<%=hdnFinYear.ClientID%>").value) > 2016
                            && document.getElementById("<%=hdnFormType.ClientID%>").value == "Form27E") {
                    if (document.getElementById("<%=ddlDedNonRes.ClientID%>").selectedIndex == 0) {
                        alert("Specify whether Deductee is Non-Resident.");
                        return false;
                    }
                    else if (document.getElementById("<%=ddlDedNonRes.ClientID%>").selectedIndex == 1) {
                        if (document.getElementById("<%=ddlDedPerEstaIndia.ClientID%>").selectedIndex == 0) {
                            alert("Specify whether Deductee is having Permanent Establishment in India.");
                            return false;
                        }
                    }
                }
                if (document.getElementById("<%=hdnFormType.ClientID%>").value == "Form27") {
                    if (!ValidateAckNo(document.getElementById("<%=txtAckNo.ClientID%>"), "15CA Ack. No.", 15, 12, false)) return false;
                    if (document.getElementById("<%=ddlNatureofRemittance.ClientID%>").selectedIndex == 0) {
                        alert("Select Nature of Remittance.");
                        return false;
                    }
                    if (document.getElementById("<%=ddlCountries.ClientID%>").selectedIndex == 0) {
                        alert("Select Country of Residence.");
                        return false;
                    }
                }
                var hasMultiplePayment = document.getElementById("<%=hdnHasMultiplePayment.ClientID%>").value;
                if (hasMultiplePayment == "1") {
                    if (document.getElementById("<%=hdnFormType.ClientID%>").value == "Form27") {
                        return confirm("Concessional Rate Limit crossed.\nOne more deduction with \nAmount of Payment : Rs. " + document.getElementById("<%=txtPaymentMade.ClientID%>").value + "\n" +
                                                                           "IT Rate : " + document.getElementById("<%=txtRate.ClientID%>").value + "%" + "\n" +
                                                                           "IT Amount : Rs. " + document.getElementById("<%=txtRateAmount.ClientID%>").value + "\n" +
                                                                           "Surcharge Amount : Rs. " + document.getElementById("<%=txtSecSurchargeAmount.ClientID%>").value + "\n" +
                                                                           "Edu Cess Amount : Rs. " + document.getElementById("<%=txtSecEduCessAmount.ClientID%>").value + "\n" +
                                                                           "TDS Amount : Rs. " + document.getElementById("<%=txtSecTaxDeducted.ClientID%>").value + "\n" +
                                                                           "Net Amount Payable : Rs. " + document.getElementById("<%=txtPayable.ClientID%>").value + "\n" +
                                                                           "will be created.\nDo you want to continue?");
                    }
                    else {
                        return confirm("Concessional Rate Limit crossed.\nOne more deduction with \nAmount of Payment : Rs. " + document.getElementById("<%=txtPaymentMade.ClientID%>").value + "\n" +
                                                                           "IT Rate : " + document.getElementById("<%=txtRate.ClientID%>").value + "%" + "\n" +
                                                                           "TDS Amount : Rs. " + document.getElementById("<%=txtRateAmount.ClientID%>").value + "\n" +
                                                                           "Net Amount Payable : Rs. " + document.getElementById("<%=txtPayable.ClientID%>").value + "\n" +
                                                                           "will be created.\nDo you want to continue?");
                    }
                }
                if (document.getElementById("<%=hdnFormType.ClientID%>").value != "Form24" && document.getElementById("<%=hdnIsValid.ClientID%>").value == "1" && document.getElementById("<%=hdnIsSuperAdmin.ClientID%>").value == "0") {
                    return confirm("Once records saved cannot be edited/deleted.\nEnsure all details are proper before saving.\nDo you want to continue?");
                }
            }
            if (document.getElementById("<%=hdnFormType.ClientID%>").value == "Form24") {
                var amt = document.getElementById("<%=txtAmountOfPayment.ClientID%>").value;
                if (amt > 999999999) {
                    alert("Amount of Payment should be less than 100 Crores.")
                    document.getElementById("<%=txtAmountOfPayment.ClientID%>").focus();
                    return false;
                }
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
            var IsSBP = document.getElementById("<%=hdnIsSBP.ClientID %>").value;
            if (IsSBP == "1") {
                var hdnRoundOff = document.getElementById("<%=hdnRoundOff.ClientID%>");
                if (hdnRoundOff.value == "HigherRupee") {
                    var incomeTaxAmount = document.getElementById("<%=txtIncomeTaxAmount.ClientID%>");
                    var surchargeAmount = document.getElementById("<%=txtSurchargeAmount.ClientID%>");
                    var eduCessAmount = document.getElementById("<%=txtEduCessAmount.ClientID%>");
                    if (incomeTaxAmount.value > 0) {
                        if (incomeTaxAmount.value != Math.ceil(incomeTaxAmount.value)) {
                            alert("Income Tax amount should be rounded to Higher Rupee.")
                            return false;
                        }
                    }
                    if (surchargeAmount.value > 0) {
                        if (surchargeAmount.value != Math.ceil(surchargeAmount.value)) {
                            alert("Surcharge amount should be rounded to Higher Rupee.")
                            return false;
                        }
                    }
                    if (eduCessAmount.value > 0) {
                        if (eduCessAmount.value != Math.ceil(eduCessAmount.value)) {
                            alert("Education Cess amount should be rounded to Higher Rupee.")
                            return false;
                        }
                    }
                }
            }
            if (Return(document.getElementById("<%=hdnFinYear.ClientID%>").value) >= 2016 && document.getElementById("<%=hdnFormType.ClientID%>").value == "Form27") {
                if (document.getElementById("<%=hdnIsValidPAN.ClientID%>").value != "1" && (Return(document.getElementById("<%=txtITRate.ClientID%>").value) < 20) && document.getElementById("<%=ddlNonDeductionReason.ClientID%>").value == "3"
                && (document.getElementById("<%=ddlNatureofRemittance.ClientID%>").value == "27" || document.getElementById("<%=ddlNatureofRemittance.ClientID%>").value == "49" || document.getElementById("<%=ddlNatureofRemittance.ClientID%>").value == "21"
                  || document.getElementById("<%=ddlNatureofRemittance.ClientID%>").value == "52" || document.getElementById("<%=ddlNatureofRemittance.ClientID%>").value == "31")) {
                    if (document.getElementById("<%=txtEmailDed.ClientID%>").value.trim() == "") {
                        alert("For Invalid PAN with NonDeduction Remark \"C\", Deductee Email is mandatory.")
                        return false;
                    }
                    else if (document.getElementById("<%=txtContactNoDed.ClientID%>").value.trim() == "") {
                        alert("For Invalid PAN with NonDeduction Remark \"C\", Deductee Contact Number is mandatory.")
                        return false;
                    }
                    else if (document.getElementById("<%=txtAddressDed.ClientID%>").value.trim() == "") {
                        alert("For Invalid PAN with NonDeduction Remark \"C\", Deductee Address is mandatory.")
                        return false;
                    }
                    else if (document.getElementById("<%=txtIdentNumDed.ClientID%>").value.trim() == "") {
                        alert("For Invalid PAN with NonDeduction Remark \"C\", Deductee Identification Number is mandatory.")
                        return false;
                    }
                }
                else {
                    if (document.getElementById("<%=txtEmailDed.ClientID%>").value.trim() != "") {
                        alert("Deductee Email should not be given.")
                        return false;
                    }
                    else if (document.getElementById("<%=txtContactNoDed.ClientID%>").value.trim() != "") {
                        alert("Deductee Contact Number should not be given.")
                        return false;
                    }
                    else if (document.getElementById("<%=txtAddressDed.ClientID%>").value.trim() != "") {
                        alert("Deductee Address should not be given.")
                        return false;
                    }
                    else if (document.getElementById("<%=txtIdentNumDed.ClientID%>").value.trim() != "") {
                        alert("Deductee Identification Number should not be given.")
                        return false;
                    }
                }
            }
            return true;
        }
        function ValidateSectionBasedOnDate() {
            var date = new Date(2013, 06, 01);
            var paymentDate = document.getElementById("<%=txtCreditedDate.ClientID%>");
            var date1 = paymentDate.value.split('/', 3);
            var creditedDate = new Date(date1[2], date1[1], date1[0]);
            if (creditedDate < date) {
                alert("Section '194LD' is Applicable from '01/06/2013' to '31/05/2015'.\nSpecify the correct date in Paid/Credited Date");
                return false;
            }
            return true;
        }        

        function ValidatePaymentDateBasedOnSection() {
            var date = new Date(2012, 07, 01);
            var paymentDate = document.getElementById("<%=txtCreditedDate.ClientID%>");
            var date1 = paymentDate.value.split('/', 3);            
            var creditedDate = new Date(date1[2], date1[1], date1[0]);
            if (creditedDate > date) {
                alert("Remarks 'Software Vendor Transaction' is Applicable from '01/07/2012'.");
                return false;
            }
            return true;
        }
        function ValidateSectionandNonDedReason() {
            var nonDedReason = document.getElementById("<%=ddlNonDeductionReason.ClientID%>");
            var section = document.getElementById("<%=hdnSectionID.ClientID%>");
            var formType = document.getElementById("<%=hdnFormType.ClientID%>");
            if (formType.value == "Form26") {
                if (nonDedReason.value == "6" && section.value != "16") {
                    alert("Deduction Remarks 'Software Vendor Transaction' is applicable for Section 194J/195 Only.");
                    return false;
                }
                if (nonDedReason.value == "8" && section.value != "5") {
                    alert("Deduction Remarks 'Deduction on Interest Income for Senior Citizens' is applicable for Section 194A Only.");
                    return false;
                }
            }
            else if (formType.value == "Form27") {
                if (nonDedReason.value == "6" && section.value != "17") {
                    alert("Deduction Remarks 'Software Vendor Transaction' is applicable for Section 194J/195 Only.");
                    return false;
                }
            }
            return true;
        }
        function ValidateDates(creditedDate, deductedDate) {
            var IsUBI = document.getElementById("<%=hdnIsUBI.ClientID%>").value;
            var IsSBP = document.getElementById("<%=hdnIsSBP.ClientID %>").value;
            var date1 = creditedDate.split('/', 3);
            var date2 = deductedDate.split('/', 3);

            var paymentDate = new Date(date1[2], date1[1], date1[0]);
            var dedDate = new Date(date2[2], date2[1], date2[0]);
            if (paymentDate > dedDate) {
                if (IsUBI == "1") {
                    document.getElementById("<%=txtTaxDedDate.ClientID%>").value = creditedDate;
                }
                else {
                    alert("Paid/Credited Date should be less than or equal to Tax Deducted Date.");
                    return false;
                }
            }
            if (IsSBP == "1") {
                if (paymentDate > dedDate || paymentDate < dedDate) {
                    alert("Paid/Credited Date & Tax Deducted Date should be Same.")
                    return false;
                }
            }
            return true;
        }
        function ClearAOP(ctrl) {
            if (eval(ctrl.value) == 0) {
                ctrl.value = "";
            }
        }
        function ValidateCreditedDate() {
            var creditedDate = document.getElementById("<%=txtCreditedDate.ClientID%>").value;
            var finYear = document.getElementById("<%=hdnFinYear.ClientID%>").value;
            var formType = document.getElementById("<%=hdnFormType.ClientID%>").value == "Form27E" ? "1" : "0";
            var date = creditedDate.split('/', 3);
            var endrange = new Date(date[2], date[1] - 1, date[0]);
            var quarterNo = document.getElementById("<%=hdnQuarter.ClientID%>").value;
            var stardateFY = new Date(finYear, 03, 01);
            var IsUBI = document.getElementById("<%=hdnIsUBI.ClientID%>").value;
            if (creditedDate == "") {
                if (formType == 1) {
                    alert("Specify Received/Debited Date");
                    document.getElementById("<%=txtCreditedDate.ClientID%>").focus();
                    return false;

                } else {
                    alert("Specify Paid/Credited Date.");
                    document.getElementById("<%=txtCreditedDate.ClientID%>").focus();
                    return false;
                }
            }
            if (quarterNo == "Quarter1") {
                minQuarterDate = new Date(finYear, 03, 01);
                maxQuarterDate = new Date(finYear, 05, 30);
            }
            else if (quarterNo == "Quarter2") {
                minQuarterDate = new Date(finYear, 06, 01);
                maxQuarterDate = new Date(finYear, 08, 30);
            }
            else if (quarterNo == "Quarter3") {
                minQuarterDate = new Date(finYear, 09, 01);
                maxQuarterDate = new Date(finYear, 11, 31);
            }
            else if (quarterNo == "Quarter4") {
                minQuarterDate = new Date(eval(finYear) + 1, 00, 01);
                maxQuarterDate = new Date(eval(finYear) + 1, 02, 31);
            }
            if (IsUBI == "0") {
                //if (endrange > maxQuarterDate || endrange < stardateFY) {
                if (endrange > maxQuarterDate || endrange < minQuarterDate || endrange < stardateFY) {
                    alert((formType == "0" ? "Paid/Credited " : "Received/Debited ") + "Date should be within\nstart of Financial Year and end of Quarter.");
                    document.getElementById("<%=txtCreditedDate.ClientID%>").focus();
                    return false;
                }
            }
            else {
                if (endrange > maxQuarterDate || endrange < minQuarterDate) {
                    alert((formType == "0" ? "Paid/Credited " : "Received/Debited ") + "Date should be within\nthe quarter of Financial Year.");
                    document.getElementById("<%=txtCreditedDate.ClientID%>").focus();
                    return false;
                }
            }
            return true;
        }
        function ValidateTaxDedDate() {
            var IsUBI = document.getElementById("<%=hdnIsUBI.ClientID%>").value;
            var finYear = document.getElementById("<%=hdnFinYear.ClientID%>").value;
            var formType = document.getElementById("<%=hdnFormType.ClientID%>").value == "Form27E" ? "1" : "0";
            var quarter = document.getElementById("<%=hdnQuarter.ClientID%>").value;
            var deductedAmt = document.getElementById("<%=txtTaxDeducted.ClientID%>").value;
            var deductedDate = document.getElementById("<%=txtTaxDedDate.ClientID%>").value;
            var creditedDate = document.getElementById("<%=txtCreditedDate.ClientID%>").value;
            var minQuarterDate, maxQuarterDate;
            if (Return(deductedAmt) > 0) {

                if (deductedDate == "") {
                    if (Return(IsUBI) == 0) {
                        deductedDate = creditedDate;
                        document.getElementById("<%=txtTaxDedDate.ClientID%>").value = creditedDate;
                    }
                    else {
                        alert("Specify Tax " + (formType == "0" ? "Deducted" : "Collected") + " Date.");
                        if (document.getElementById("<%=txtTaxDedDate.ClientID%>") != null)
                            document.getElementById("<%=txtTaxDedDate.ClientID%>").focus();
                        return false;
                    }
                }
                if (deductedDate == "") {
                    var tdsDate = new Date(parseInt(deductedDate.substring(6, 10), 10), parseInt(deductedDate.substring(3, 5), 10) - 1, parseInt(deductedDate.substring(0, 2), 10));
                    var currentDate = new Date();

                    if (quarter == "Quarter1") {
                        minQuarterDate = new Date(finYear, 03, 01);
                        maxQuarterDate = new Date(finYear, 05, 30);
                    }
                    else if (quarter == "Quarter2") {
                        minQuarterDate = new Date(finYear, 06, 01);
                        maxQuarterDate = new Date(finYear, 08, 30);
                    }
                    else if (quarter == "Quarter3") {
                        minQuarterDate = new Date(finYear, 09, 01);
                        maxQuarterDate = new Date(finYear, 11, 31);
                    }
                    else if (quarter == "Quarter4") {
                        minQuarterDate = new Date(eval(finYear) + 1, 00, 01);
                        maxQuarterDate = new Date(eval(finYear) + 1, 02, 31);
                    }
                    if (tdsDate < minQuarterDate) {
                        alert("Tax " + (formType == "0" ? "Deducted" : "Collected") + " Date cannot be before Current Quarter.");
                        if (document.getElementById("<%=txtTaxDedDate.ClientID%>") != null)
                            document.getElementById("<%=txtTaxDedDate.ClientID%>").focus();
                        return false;
                    }
                    if (tdsDate > maxQuarterDate) {
                        alert("Tax " + (formType == "0" ? "Deducted" : "Collected") + " Date cannot be after Current Quarter.");
                        if (document.getElementById("<%=txtTaxDedDate.ClientID%>") != null)
                            document.getElementById("<%=txtTaxDedDate.ClientID%>").focus();
                        return false;
                    }
                    if (tdsDate > currentDate) {
                        alert("Tax " + (formType == "0" ? "Deducted" : "Collected") + " Date can not be future date.");
                        if (document.getElementById("<%=txtTaxDedDate.ClientID%>") != null)
                            document.getElementById("<%=txtTaxDedDate.ClientID%>").focus();
                        return false;
                    }
                }
            }
            else {
                if (deductedDate != "") {
                    alert("Tax " + (formType == "0" ? "Deducted" : "Collected") + " Amount is zero.\nSo Tax " + (formType == "0" ? "Deducted" : "Collected") + " Date need not be specified.");
                    document.getElementById("<%=txtTaxDedDate.ClientID%>").focus();
                    return false;
                }
            }
            return true;
        }
        function CalculateValues() {
            var amountOfPayment = document.getElementById("<%=txtAmountOfPayment.ClientID%>");
            var AmountOfCashWithdrawal = document.getElementById("<%=txtAmtCashDrawn.ClientID%>");
            if (AmountOfCashWithdrawal != null) {
                amountOfPayment = document.getElementById("<%=txtAmtCashDrawn.ClientID%>");
            }

            var incomeTaxRate = document.getElementById("<%=txtITRate.ClientID%>");
            var incomeTaxAmount = document.getElementById("<%=txtIncomeTaxAmount.ClientID%>");
            var surchargeRate = document.getElementById("<%=txtSurchargeRate.ClientID%>");
            var surchargeAmount = document.getElementById("<%=txtSurchargeAmount.ClientID%>");
            var eduCessRate = document.getElementById("<%=txtEduCessRate.ClientID%>");
            var eduCessAmount = document.getElementById("<%=txtEduCessAmount.ClientID%>");
            var taxDeductedRate = document.getElementById("<%=txtTaxDeductedRate.ClientID%>");
            var taxDeducted = document.getElementById("<%=txtTaxDeducted.ClientID%>");
            var creditedDate = document.getElementById("<%=txtCreditedDate.ClientID%>");
            var hdnRoundOff = document.getElementById("<%=hdnRoundOff.ClientID%>");
            var chkEdit = document.getElementById("<%=chkEdit.ClientID%>");
            var hdnSetColor = document.getElementById("<%=hdnSetColor.ClientID%>");
            var deductedDate = document.getElementById("<%=txtTaxDedDate.ClientID%>");
            var IsSBP = document.getElementById("<%=hdnIsSBP.ClientID %>").value;
            if (document.getElementById("<%=hdnFormType.ClientID%>").value == "Form24") {
                CalculateTaxDeductedForForm24(amountOfPayment, creditedDate, incomeTaxAmount, surchargeRate, surchargeAmount, eduCessRate, eduCessAmount, taxDeducted, hdnRoundOff, chkEdit, hdnSetColor, deductedDate);
            }
            else if (document.getElementById("<%=hdnFormType.ClientID%>").value == "Form26" || document.getElementById("<%=hdnFormType.ClientID%>").value == "Form27" || document.getElementById("<%=hdnFormType.ClientID%>").value == "Form27E") {
                CalculateTaxDeducted(amountOfPayment, creditedDate, incomeTaxRate, incomeTaxAmount, surchargeRate, surchargeAmount, eduCessRate, eduCessAmount, taxDeductedRate, taxDeducted, deductedDate,
                hdnRoundOff, chkEdit, hdnSetColor);
            }

        }
        function Return(tempValue) {
            if (isNaN(tempValue)) {
                return tempValue = "0";
            }
            else if (tempValue == "" || tempValue == "undefined") {
                return 0;
            }
            else if (tempValue == "0.00" || tempValue == "0.0000") {
                return 0;
            }
            else {
                return eval(parseFloat(tempValue).toString());
            }
        }
        function EnableDisableControls(value) {
            var edit = document.getElementById("<%=chkEdit.ClientID%>");
            if (edit != null) {
                if (edit.checked && document.getElementById("<%=hdnEnable.ClientID%>").value == "0") {
                    if (document.getElementById("<%=hdnFormType.ClientID%>").value == "Form26" || document.getElementById("<%=hdnFormType.ClientID%>").value == "Form27" || document.getElementById("<%=hdnFormType.ClientID%>").value == "Form27E") {
                        if (document.getElementById("<%=hdnFormType.ClientID%>").value == "Form26") {
                            document.getElementById("<%=txtEduCessAmount.ClientID%>").disabled = true;
                            document.getElementById("<%=txtSurchargeAmount.ClientID%>").disabled = true;
                            document.getElementById("<%=txtIncomeTaxAmount.ClientID%>").disabled = false;
                        } else {
                            document.getElementById("<%=txtIncomeTaxAmount.ClientID%>").disabled = false;
                            document.getElementById("<%=txtSurchargeAmount.ClientID%>").disabled = false;
                            document.getElementById("<%=txtEduCessAmount.ClientID%>").disabled = false;
                        }
                    }
                    else if (document.getElementById("<%=hdnFormType.ClientID%>").value == "Form24") {
                        document.getElementById("<%=txtEduCessAmount.ClientID%>").disabled = false;
                    }
                }
                else {
                    if (document.getElementById("<%=hdnFormType.ClientID%>").value == "Form26" || document.getElementById("<%=hdnFormType.ClientID%>").value == "Form27" || document.getElementById("<%=hdnFormType.ClientID%>").value == "Form27E") {
                        document.getElementById("<%=txtIncomeTaxAmount.ClientID%>").disabled = true;
                        document.getElementById("<%=txtSurchargeAmount.ClientID%>").disabled = true;
                        document.getElementById("<%=txtEduCessAmount.ClientID%>").disabled = true;
                    }
                    else if (document.getElementById("<%=hdnFormType.ClientID%>").value == "Form24") {
                        document.getElementById("<%=txtEduCessAmount.ClientID%>").disabled = true;
                    }
                }
                if (value == 1) {
                    CalculateValues();
                }
            }
            if (edit.disabled) {
                document.getElementById("<%=txtIncomeTaxAmount.ClientID%>").disabled = true;
            }
        }
        function GetDeducteeNameValue(source, eventArgs) {
            document.getElementById("<%=hdnIsChallanModified.ClientID%>").value = "1";
            var content = eventArgs.get_value();
            var arr = new Array();
            arr = content.indexOf(';') != -1 ? content.split(';') : content.split('-');
            if (document.getElementById("<%=hdnFormType.ClientID%>").value == "Form24") {
                document.getElementById("<%=hdnDeducteeID.ClientID%>").value = arr[0];
                document.getElementById("<%=hdnIsValidPAN.ClientID%>").value = arr[3] == "0" ? "1" : "0";
                document.getElementById("<%=hdnIsTran.ClientID%>").value = arr[2];
            }
            else {
                document.getElementById("<%=hdnDeducteeID.ClientID%>").value = arr[0];
                document.getElementById("<%=hdnIsValidPAN.ClientID%>").value = arr[1] == "" ? "0" : arr[1];
                document.getElementById("<%=hdnIsTran.ClientID%>").value = arr[2];
            }
        }
        function ClearDeducteeName() {
            if (event.keyCode == 13 || event.keyCode == 37 || event.keyCode == 38 || event.keyCode == 39 || event.keyCode == 40) {
            }
            else {
                document.getElementById("<%=hdnDeducteeID.ClientID%>").value = "-1";
            }
        }
        function GetChallanSlNoValue(source, eventArgs) {
            var content = eventArgs.get_value();
            var contents = new Array();
            contents = content.split(';');
            if (document.getElementById("<%=hdnIsPartPaymentActive.ClientID%>").value == "0") {
                document.getElementById("<%=hdnChallanID.ClientID%>").value = contents[0];
                document.getElementById("<%=txtChallanNo.ClientID%>").value = contents[1];
                document.getElementById("<%=txtChallanDate.ClientID%>").value = contents[2];
                document.getElementById("<%=txtTotalAmount.ClientID%>").value = contents[6];
                document.getElementById("<%=hdnIsAutoGenChallan.ClientID%>").value = contents[8] == 1 ? "1" : "0";
            }
            else {
                document.getElementById("<%=hdnChallanID.ClientID%>").value = contents[0];
                document.getElementById("<%=txtPPChallanNo.ClientID%>").value = contents[1];
                document.getElementById("<%=txtPPChallanDate.ClientID%>").value = contents[2];
                document.getElementById("<%=txtPPChallanIncomeTax.ClientID%>").value = contents[3];
                document.getElementById("<%=txtPPChallanSurcharge.ClientID%>").value = contents[4];
                document.getElementById("<%=txtPPChallanEduCess.ClientID%>").value = contents[5];
                document.getElementById("<%=txtPPChallanTotalAmount.ClientID%>").value = contents[6];
                document.getElementById("<%=hdnIsAutoGenChallan.ClientID%>").value = contents[8] == 1 ? "1" : "0";
            }
        }
        function ClearChallanSlNo(screenType) {
            if (event.keyCode == 13 || event.keyCode == 37 || event.keyCode == 38 || event.keyCode == 39 || event.keyCode == 40) {
            }
            else {
                if (screenType == 1) {
                    document.getElementById("<%=hdnChallanID.ClientID%>").value = "-1";
                    document.getElementById("<%=txtChallanNo.ClientID%>").value = "";
                    document.getElementById("<%=txtChallanDate.ClientID%>").value = "";
                    document.getElementById("<%=txtTotalAmount.ClientID%>").value = "";
                }
                else {
                    document.getElementById("<%=hdnChallanID.ClientID%>").value = "-1";
                    document.getElementById("<%=txtPPChallanNo.ClientID%>").value = "";
                    document.getElementById("<%=txtPPChallanDate.ClientID%>").value = "";
                    document.getElementById("<%=txtPPChallanIncomeTax.ClientID%>").value = "";
                    document.getElementById("<%=txtPPChallanSurcharge.ClientID%>").value = "";
                    document.getElementById("<%=txtPPChallanEduCess.ClientID%>").value = "";
                    document.getElementById("<%=txtPPChallanTotalAmount.ClientID%>").value = "";
                }
            }
        }
        function GetResult(returnValue, context) {

            var isPartPayment = document.getElementById("<%=hdnIsPartPaymentActive.ClientID%>").value == "1";
            if (isPartPayment) {
                if (returnValue.length > 4) {
                    var array = returnValue.split("*");
                    document.getElementById("<%=hdnChallanID.ClientID%>").value = array[0];
                    document.getElementById("<%=txtPPChallanNo.ClientID%>").value = array[1];
                    document.getElementById("<%=txtPPChallanDate.ClientID%>").value = array[2];
                    document.getElementById("<%=txtPPChallanIncomeTax.ClientID%>").value = array[3];
                    document.getElementById("<%=txtPPChallanSurcharge.ClientID%>").value = array[4];
                    document.getElementById("<%=txtPPChallanEduCess.ClientID%>").value = array[5];
                    document.getElementById("<%=txtPPChallanTotalAmount.ClientID%>").value = array[6];
                }
                else {
                    alert("Challan Details doesn't exist for the specified Serial No. under\nthe selected Section and Quarter.");
                    document.getElementById("<%=txtPPChallanSlNo.ClientID%>").value = "";
                    document.getElementById("<%=txtPPChallanSlNo.ClientID%>").focus();
                    document.getElementById("<%=hdnChallanID.ClientID%>").value = "-1";
                    document.getElementById("<%=txtPPChallanNo.ClientID%>").value = "";
                    document.getElementById("<%=txtPPChallanDate.ClientID%>").value = "";
                    document.getElementById("<%=txtPPChallanIncomeTax.ClientID%>").value = "";
                    document.getElementById("<%=txtPPChallanSurcharge.ClientID%>").value = "";
                    document.getElementById("<%=txtPPChallanEduCess.ClientID%>").value = "";
                    document.getElementById("<%=txtPPChallanTotalAmount.ClientID%>").value = "";
                }
            }
            else {
                if (returnValue.length > 4) {
                    var array = returnValue.split("*");
                    document.getElementById("<%=hdnChallanID.ClientID%>").value = array[0];
                    document.getElementById("<%=txtChallanNo.ClientID%>").value = array[8];
                    document.getElementById("<%=txtChallanDate.ClientID%>").value = array[2];
                    document.getElementById("<%=txtTotalAmount.ClientID%>").value = array[3];
                }
                else {
                    alert("Challan Details doesn't exist for the specified Serial No. under\nthe selected Section and Quarter.");
                    document.getElementById("<%=hdnChallanID.ClientID%>").value = "-1";
                    document.getElementById("<%=txtChallanSlNo.ClientID%>").value = "";
                    document.getElementById("<%=txtChallanSlNo.ClientID%>").focus();
                    document.getElementById("<%=txtChallanNo.ClientID%>").value = "";
                    document.getElementById("<%=txtChallanDate.ClientID%>").value = "";
                    document.getElementById("<%=txtTotalAmount.ClientID%>").value = "";
                }
            }
        }
        function SendRequest(challanSerialNo) {
            CallServer(challanSerialNo);
            return false;
        }
        function GetDetails(challanSlNo) {
            document.getElementById("<%=hdnIsChallanModified.ClientID%>").value = "1";
            if (document.getElementById("<%=hdnIsPartPaymentActive.ClientID%>").value == "0") {
                if (document.getElementById("<%=hdnChallanID.ClientID%>").value == "-1" && document.getElementById("<%=txtChallanSlNo.ClientID%>").value != "") {
                    SendRequest(challanSlNo.value);
                }
            }
            else {
                if (document.getElementById("<%=hdnChallanID.ClientID%>").value == "-1" && document.getElementById("<%=txtPPChallanSlNo.ClientID%>").value != "") {
                    SendRequest(challanSlNo.value);
                }
            }
        }
        function FormatPaymentSearch() {
            var branchName = document.getElementById("<%=txtSearchBranchName.ClientID%>");
            var branchCode = document.getElementById("<%=txtSearchBranchCode.ClientID%>");
            var name = document.getElementById("<%=txtSearchVendorName.ClientID%>");
            var pan = document.getElementById("<%=txtSearchVendorPAN.ClientID%>");
            var amtFrom = document.getElementById("<%=txtAmountEnteredFrom.ClientID%>");
            var amtTo = document.getElementById("<%=txtAmountEnteredTo.ClientID%>");
            var bglCode = document.getElementById("<%=txtSearchBGLCode.ClientID%>");
            if (amtFrom.value != "" && amtTo.value == "") {
                document.getElementById("<%=txtAmountEnteredTo.ClientID%>").value = amtFrom.value;
            }
            else if (amtFrom.value == "" && amtTo.value != "") {
                document.getElementById("<%=txtAmountEnteredFrom.ClientID%>").value = amtTo.value;
            }
            else if (amtFrom.value != "" && amtTo.value != "") {
                if (eval(amtFrom.value) > eval(amtTo.value)) {
                    var temp = amtFrom.value;
                    document.getElementById("<%=txtAmountEnteredFrom.ClientID%>").value = amtTo.value;
                    document.getElementById("<%=txtAmountEnteredTo.ClientID%>").value = temp;
                }
            }
        }

        function CheckPANValue() {
            if (document.getElementById("<%=ddlSearchPAN.ClientID%>").value == 1) {
                document.getElementById("<%=txtPANRefNo.ClientID%>").disabled = false;
                document.getElementById("<%=txtPANRefNo.ClientID%>").focus();
            }
            else {
                document.getElementById("<%=txtPANRefNo.ClientID%>").value = "";
                document.getElementById("<%=txtPANRefNo.ClientID%>").disabled = true;
            }
        }

        function FormatSearch() {
            var txtSearchAmountFrom = document.getElementById("<%=txtSearchAmountFrom.ClientID%>");
            var txtSearchAmountTo = document.getElementById("<%=txtSearchAmountTo.ClientID%>");
            var txtSearchPaidDateFrom = document.getElementById("<%=txtSearchPaidDateFrom.ClientID%>");
            var txtSearchPaidDateTo = document.getElementById("<%=txtSearchPaidDateTo.ClientID%>");
            var txtSrchTaxDeductedFrom = document.getElementById("<%=txtSrchTaxDeductedFrom.ClientID%>");
            var txtSrchTaxDeductedTo = document.getElementById("<%=txtSrchTaxDeductedTo.ClientID%>");
            var txtSrchTaxDateFrom = document.getElementById("<%=txtSrchTaxDateFrom.ClientID%>");
            var txtSrchTaxDateTo = document.getElementById("<%=txtSrchTaxDateTo.ClientID%>");
            var txtSearchDedSerialNo = document.getElementById("<%=txtSearchDedSerialNo.ClientID%>");
            var txtSearchName = document.getElementById("<%=txtSearchName.ClientID%>");
            var txtPANRefNo = document.getElementById("<%=txtPANRefNo.ClientID%>");

            if (document.getElementById("<%=ddlSearchPAN.ClientID%>").value == 1) {
                if (document.getElementById("<%=txtPANRefNo.ClientID%>").value != "") {
                    if (!ValidatePAN(document.getElementById("<%=txtPANRefNo.ClientID%>"), "PAN", 10, true)) return false;
                }
            }
            if (txtPANRefNo.value.trim() == "" && txtSearchAmountFrom.value.trim() == "" && txtSearchAmountTo.value.trim() == "" && txtSearchPaidDateFrom.value.trim() == "" && txtSearchPaidDateTo.value.trim() == "" && txtSrchTaxDeductedFrom.value.trim() == "" && txtSrchTaxDeductedTo.value.trim() == "" && txtSrchTaxDateFrom.value.trim() == "" && txtSrchTaxDateTo.value.trim() == "" && txtSearchDedSerialNo.value.trim() == "" && txtSearchName.value.trim() == "") {
                var confirmLoad;
                if (confirm("Loading all details will take time.\nRecommend to use search filters.\n\nDo you want to continue?") == true) {
                    return true;
                } else {
                    return false;
                }
            }
            else {
                if ((txtSearchAmountFrom.value != "") && (txtSearchAmountTo.value == "")) {
                    txtSearchAmountTo.value = txtSearchAmountFrom.value; //if To amount is empty put the same value of From amount
                }
                else if ((txtSearchAmountFrom.value == "") && (txtSearchAmountTo.value != "")) {
                    txtSearchAmountFrom.value = txtSearchAmountTo.value; //if From amount is empty put the same value of To Amount
                }
                else if ((txtSearchAmountFrom.value != "") && (txtSearchAmountTo.value != "")) {
                    if (eval(txtSearchAmountTo.value) < eval(txtSearchAmountFrom.value)) {//If To amount is less than from Amount swap the values
                        var temp = txtSearchAmountFrom.value;
                        txtSearchAmountFrom.value = txtSearchAmountTo.value;
                        txtSearchAmountTo.value = temp;
                    }
                }
                if ((txtSrchTaxDeductedFrom.value != "") && (txtSrchTaxDeductedTo.value == "")) {
                    txtSrchTaxDeductedTo.value = txtSrchTaxDeductedFrom.value; //if To amount is empty put the same value of From amount
                }
                else if ((txtSrchTaxDeductedFrom.value == "") && (txtSrchTaxDeductedTo.value != "")) {
                    txtSrchTaxDeductedFrom.value = txtSrchTaxDeductedTo.value; //if From amount is empty put the same value of To Amount
                }
                else if ((txtSrchTaxDeductedFrom.value != "") && (txtSrchTaxDeductedTo.value != "")) {
                    if (eval(txtSrchTaxDeductedTo.value) < eval(txtSrchTaxDeductedFrom.value)) {//If To amount is less than from Amount swap the values
                        var temp = txtSrchTaxDeductedFrom.value;
                        txtSrchTaxDeductedFrom.value = txtSrchTaxDeductedTo.value;
                        txtSrchTaxDeductedTo.value = temp;
                    }
                }
                if ((txtSearchPaidDateFrom.value.trim() != "") && (txtSearchPaidDateTo.value.trim() == "")) {
                    txtSearchPaidDateTo.value = txtSearchPaidDateFrom.value; //if To amount is empty put the same value of From amount
                }
                else if ((txtSearchPaidDateFrom.value.trim() == "") && (txtSearchPaidDateTo.value.trim() != "")) {
                    txtSearchPaidDateFrom.value = txtSearchPaidDateTo.value; //if From amount is empty put the same value of To Amount
                }
                if (!CheckDate(txtSearchPaidDateFrom.value, txtSearchPaidDateTo.value)) {//If to date is less Than From Date then Swap
                    var temp = txtSearchPaidDateTo.value;
                    txtSearchPaidDateTo.value = txtSearchPaidDateFrom.value;
                    txtSearchPaidDateFrom.value = temp;
                }
                if ((txtSrchTaxDateFrom.value.trim() != "") && (txtSrchTaxDateTo.value.trim() == "")) {
                    txtSrchTaxDateTo.value = txtSrchTaxDateFrom.value; //if To amount is empty put the same value of From amount
                }
                else if ((txtSrchTaxDateFrom.value.trim() == "") && (txtSrchTaxDateTo.value.trim() != "")) {
                    txtSrchTaxDateFrom.value = txtSrchTaxDateTo.value; //if From amount is empty put the same value of To Amount
                }
                if (!CheckDate(txtSrchTaxDateFrom.value, txtSrchTaxDateTo.value)) {//If to date is less Than From Date then Swap
                    var temp = txtSrchTaxDateTo.value;
                    txtSrchTaxDateTo.value = txtSrchTaxDateFrom.value;
                    txtSrchTaxDateFrom.value = temp;
                }
            }
        }
        function CheckDate(fromDate, toDate) {
            var fromDateDay = parseInt(fromDate.substring(0, 2), 10);
            var fromDateMonth = parseInt(fromDate.substring(3, 5), 10);
            var fromDateYear = parseInt(fromDate.substring(6, 10), 10);
            var toDatedDay = parseInt(toDate.substring(0, 2), 10);
            var toDatedMonth = parseInt(toDate.substring(3, 5), 10);
            var toDatedYear = parseInt(toDate.substring(6, 10), 10);
            //Month will start from  0 to 11
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
                document.getElementById("<%=ddlGoTo.ClientID %>").value = document.getElementById("<%=selectedPageSize.ClientID %>").value;
                document.getElementById("<%=txtGoToPage.ClientID %>").value = document.getElementById("<%=selectedPageIndex.ClientID %>").value;
                alert("Search parameters are changed; So,Click on search and continue");
                return false;
            }
            else {
                return true;
            }
        }
        function CalculatePPAmounts() {
            var value;
            var ppAmountToCalc = document.getElementById("<%=txtPPAmountToCalculate.ClientID%>");
            var ppIT = document.getElementById("<%=txtPPIncomeTax.ClientID%>");
            var ppSur = document.getElementById("<%=txtPPSurcharge.ClientID%>");
            var ppEduCess = document.getElementById("<%=txtPPEduCess.ClientID%>");
            var ppTotal = document.getElementById("<%=txtPPTotal.ClientID%>");
            var ppTotal = document.getElementById("<%=txtPPTotal.ClientID%>");
            var incomeTax = document.getElementById("<%=hdnIT.ClientID%>");
            var surcharge = document.getElementById("<%=hdnSur.ClientID%>");
            var taxDeducted = document.getElementById("<%=hdnTaxDeducted.ClientID%>");
            value = Return((eval(Return(ppAmountToCalc.value)) / eval(Return(taxDeducted.value))) * eval(Return(incomeTax.value)));
            ppIT.value = Math.round(value);
            value = Return((eval(Return(ppAmountToCalc.value)) / eval(Return(taxDeducted.value))) * eval(Return(surcharge.value)));
            ppSur.value = Math.round(value);
            value = eval(Return(ppAmountToCalc.value)) - (eval(Return(ppIT.value)) + eval(Return(ppSur.value)));
            ppEduCess.value = Math.round(value);
            ppTotal.value = (eval(ppIT.value) + eval(ppSur.value) + eval(ppEduCess.value)).toFixed(2);
        }
        function CalcPPAmounts() {
            var ppIT = document.getElementById("<%=txtPPIncomeTax.ClientID%>");
            var ppSur = document.getElementById("<%=txtPPSurcharge.ClientID%>");
            var ppEduCess = document.getElementById("<%=txtPPEduCess.ClientID%>");
            var ppTotal = document.getElementById("<%=txtPPTotal.ClientID%>");
            ppTotal.value = (eval(Return(ppIT.value)) + eval(Return(ppSur.value)) + eval(Return(ppEduCess.value))).toFixed(2);
        }
        function EnableDisablePP() {
            if (document.getElementById("<%=chkPartPayment.ClientID%>").checked) {
                if (document.getElementById("<%=ddlQuarter.ClientID%>").selectedIndex > 0) {
                    if (document.getElementById("<%=txtChallanSlNo.ClientID%>").value != "") {
                        var res = confirm("Do you want to clear the Challan details and continue ?");
                        if (res) {
                            __doPostBack('<%=deductionUpdatePanel.UniqueID%>', 'DeductionDetail');
                        }
                        else {
                            document.getElementById("<%=hdnToBeUnlinked.ClientID%>").value = "0";
                            document.getElementById("<%=chkPartPayment.ClientID%>").checked = false;
                        }
                    }
                    else {
                        alert("Since Challan Details is not specified,\nChallan Quarter need not be specified.");
                        document.getElementById("<%=chkPartPayment.ClientID%>").checked = false;
                        return false;
                    }
                }
                else {
                    document.getElementById("<%=hdnToBeUnlinked.ClientID%>").value = "1";
                    if (ValidateForPP()) {
                        document.getElementById("<%=btnPartPayment.ClientID%>").disabled = false;
                        document.getElementById("<%=ddlQuarter.ClientID%>").disabled = true;
                        document.getElementById("<%=txtChallanSlNo.ClientID%>").disabled = true;
                        document.getElementById("<%=txtChallanNo.ClientID%>").disabled = true;
                        document.getElementById("<%=txtChallanDate.ClientID%>").disabled = true;
                        document.getElementById("<%=txtTotalAmount.ClientID%>").disabled = true;
                    }
                    else {
                        document.getElementById("<%=chkPartPayment.ClientID%>").checked = false;
                    }
                }
            }
            else {
                document.getElementById("<%=hdnToBeUnlinked.ClientID%>").value = "0";
                document.getElementById("<%=btnPartPayment.ClientID%>").disabled = true;
                document.getElementById("<%=ddlQuarter.ClientID%>").disabled = false;
                document.getElementById("<%=txtChallanSlNo.ClientID%>").disabled = document.getElementById("<%=ddlQuarter.ClientID%>").selectedIndex > 0 ? false : true;
            }
        }
        function ClearPPControls() {
            document.getElementById("<%=hdnLinkID.ClientID%>").value = "-1";
            document.getElementById("<%=hdnDeductionID.ClientID%>").value = "-1";
            document.getElementById("<%=hdnChallanID.ClientID%>").value = "-1";
            document.getElementById("<%=txtPPSlNo.ClientID%>").value = "";
            document.getElementById("<%=txtPPAmountToCalculate.ClientID%>").value = "";
            document.getElementById("<%=txtPPIncomeTax.ClientID%>").value = "";
            document.getElementById("<%=txtPPSurcharge.ClientID%>").value = "";
            document.getElementById("<%=txtPPEduCess.ClientID%>").value = "";
            document.getElementById("<%=txtPPTotal.ClientID%>").value = "";
            document.getElementById("<%=ddlPPQuarter.ClientID%>").selectedIndex = document.getElementById("<%=hdnQuarter.ClientID%>").value == "Quarter1" ? 1 : document.getElementById("<%=hdnQuarter.ClientID%>").value == "Quarter2" ? 2 : document.getElementById("<%=hdnQuarter.ClientID%>").value == "Quarter3" ? 3 : document.getElementById("<%=hdnQuarter.ClientID%>").value == "Quarter4" ? 4 : 0;
            document.getElementById("<%=txtPPChallanSlNo.ClientID%>").disabled = false;
            document.getElementById("<%=txtPPChallanSlNo.ClientID%>").value = "";
            document.getElementById("<%=txtPPChallanNo.ClientID%>").value = "";
            document.getElementById("<%=txtPPChallanDate.ClientID%>").value = "";
            document.getElementById("<%=txtPPChallanIncomeTax.ClientID%>").value = "";
            document.getElementById("<%=txtPPChallanSurcharge.ClientID%>").value = "";
            document.getElementById("<%=txtPPChallanEduCess.ClientID%>").value = "";
            document.getElementById("<%=txtPPChallanTotalAmount.ClientID%>").value = "";
        }
        function ValidateForPP() {
            if (document.getElementById("<%=hdnLinkID.ClientID%>").value != "-1" && document.getElementById("<%=hdnToBeUnlinked.ClientID%>").value == "1") {
                alert("Save the Deduction detail first & later proceed to Part Payment.");
                return false;
            }
            else {
                document.getElementById("<%=hdnIsPartPaymentActive.ClientID%>").value = "0";
                return true;
            }
        }
        function ValidatePP() {
            if (eval(Return(document.getElementById("<%=txtPPTotal.ClientID%>").value)) == "") {
                alert("Specify Amount.");
                document.getElementById("<%=txtPPIncomeTax.ClientID%>").focus();
                return false;
            }
            if (!ValidateDropDown(document.getElementById("<%=ddlPPQuarter.ClientID%>"), "Challan Quarter.")) return false;
            if (document.getElementById("<%=txtPPChallanSlNo.ClientID%>").value == "") {
                alert("Specify Challan Sl.No.");
                document.getElementById("<%=txtPPChallanSlNo.ClientID%>").focus();
                return false;
            }
            else
                return true;
        }
        function DoRoundOff() {
            var chkEdit = document.getElementById("<%=chkEdit.ClientID%>");
            if (!chkEdit.checked) {
                if (document.getElementById("<%=hdnRoundOff.ClientID%>").value == "HigherRupee") {
                    document.getElementById("<%=txtIncomeTaxAmount.ClientID%>").value = Math.ceil(eval(Return(document.getElementById("<%=txtIncomeTaxAmount.ClientID%>").value)));
                    document.getElementById("<%=txtSurchargeAmount.ClientID%>").value = Math.ceil(eval(Return(document.getElementById("<%=txtSurchargeAmount.ClientID%>").value)));
                    document.getElementById("<%=txtEduCessAmount.ClientID%>").value = Math.ceil(eval(Return(document.getElementById("<%=txtEduCessAmount.ClientID%>").value)));
                    CalculateValues();
                }
            }
        }
        function ShowSectionHelp() {
            if (document.getElementById("<%=hdnFinYear.ClientID%>").value != 2009) {
                if (document.getElementById("<%=hdnFormType .ClientID%>").value == "Form26")
                    window.open('../TDS_Help/TDS_Rates/Form_26_(2010_11).htm');
                else if (document.getElementById("<%=hdnFormType .ClientID%>").value == "Form27")
                    window.open('../TDS_Help/TDS_Rates/Form_27_(2010_11).htm');
                else
                    window.open('../TDS_Help/TDS_Rates/Form27E_(2010-11).htm');
            }
            else {
                if (document.getElementById("<%=hdnFormType .ClientID%>").value == "Form26")
                    window.open('../TDS_Help/TDS_Rates/Form_26_(2009_10)(Oct_Mar).htm');
                else
                    window.open('../TDS_Help/TDS_Rates/Form_27_(2009_10)(Oct_Mar).htm');

            }
        }
        function ConfirmDelete() {
            if (confirm("This is Auto-Generated Deduction.\nDeletion will result in mismatch.\nDelete only if necessary.\n\n Do you want to Delete?")) {
                __doPostBack("deductionUpdatePanel", "Delete");
            }
            else {
                return false;
            }
        }
        function ConfirmEdit() {
            if (confirm("This is Auto-Generated Deduction.\nOnly Name,Remarks and U/s 197 Cert. No will be updated.\n\n Do you want to Continue?")) {
                __doPostBack("deductionUpdatePanel", "Edit");
            }
            else {
                return false;
            }
        }
        function ConfirmSelect() {
            if (confirm("Selected Payment will be split to two deductions as \nConcessional Limit is Crossed.\n\n Do you want to Continue?")) {
                __doPostBack("deductionUpdatePanel", "Select");
            }
            else {
                return false;
            }
        }
        function HideDisaplay(objValue) {
            var rowSecondDed = document.getElementById("<%=rowSecondDeduction.ClientID%>");
            var rowSecDedSurcharge = document.getElementById("<%=rowSecDedSurcharge.ClientID %>");
            var rowSecDedEduCess = document.getElementById("<%=rowSecDedEduCess.ClientID %>");
            var formType = document.getElementById("<%=hdnFormType.ClientID%>").value;
            if (objValue == "1") {
                if (rowSecondDed != null)
                    rowSecondDed.style.display = 'none';
            }
            else {
                if (rowSecondDed != null) {
                    rowSecondDed.style.display = ''
                    if (formType == "Form27") {
                        rowSecDedSurcharge.style.display = ''
                        rowSecDedEduCess.style.display = ''
                    }
                }
            }
        }
        function CalculateTDSForMultipleDeduction() {
            var sectionID = document.getElementById("<%=hdnSectionID.ClientID%>").value;
            var taxRate = document.getElementById("<%=hdnTaxRate.ClientID%>").value;
            var mode = document.getElementById("<%=hdnPaymentMode.ClientID%>").value;
            var amtOfPayment = document.getElementById("<%=txtAmountOfPayment.ClientID%>").value;
            var excludeST = document.getElementById("<%=txtExcludingTax.ClientID%>").value;
            var extraPayment = document.getElementById("<%=hdnExtraPaymentMade.ClientID%>").value;
            var InvalidPAN = document.getElementById("<%=hdnIsValidPAN.ClientID%>").value;
            var serviceTax = document.getElementById("<%=hdnServiceTax.ClientID%>").value;
            document.getElementById("<%=hdnNonDedReason.ClientID%>").value = "0";
            if (InvalidPAN == "1") {
                document.getElementById("<%=hdnNonDedReason.ClientID%>").value = "3";
                if (Return(taxRate) < 20) {
                    taxRate = 20;
                }
            }
            document.getElementById("<%=txtPaymentMade.ClientID%>").value = Return(extraPayment);
            var total = Return(extraPayment) + Return(serviceTax);

            var fullPayment = document.getElementById("<%=txtPaymentMade.ClientID%>").value;
            document.getElementById("<%=txtRate.ClientID%>").value = Return(taxRate);
            document.getElementById("<%=txtRateAmount.ClientID%>").value = mode == "-1" ? Return(Return(fullPayment) * Return(taxRate) / 100).toFixed(2) : Math.ceil(eval(Return(fullPayment) * Return(taxRate) / 100));
            document.getElementById("<%=txtPayable.ClientID%>").value = mode == "-1" ? Return(Return(total) - Return(document.getElementById("<%=txtRateAmount.ClientID%>").value)).toFixed(2) : Math.ceil(eval(Return(total) - Return(document.getElementById("<%=txtRateAmount.ClientID%>").value)));
        }
        function Calculate194CAmount() {
            var makeTDSFromFirstPayment = document.getElementById("<%=hdnMakeTDSFromFirstPayment.ClientID%>").value;
            var paymentMade = document.getElementById("<%=txtAmountOfPayment.ClientID%>").value;
            var prevPaymentMade = document.getElementById("<%=hdnPreviousPaymentMade.ClientID%>").value;
            var tdsMade = document.getElementById("<%=hdnTDSMade.ClientID%>").value;
            var dedAmt = document.getElementById("<%=hdnDedAmt.ClientID%>").value;
            var included = document.getElementById("<%=hdnIncludeAmt.ClientID%>").value;
            var thresholdLimit = document.getElementById("<%=hdnThresholdLimit.ClientID%>").value;
            var taxRate = document.getElementById("<%=hdnTaxRate.ClientID%>").value;
            var conTaxRate = document.getElementById("<%=hdnConTaxRate.ClientID%>").value;
            var conLimit = document.getElementById("<%=hdnConLimit.ClientID%>").value;
            var mode = document.getElementById("<%=hdnPaymentMode.ClientID%>").value;
            var fullPayment;
            var tdsRate = document.getElementById("<%=txtTaxDeductedRate.ClientID%>");
            var tds = document.getElementById("<%=txtTaxDeducted.ClientID%>");
            var netPayable = document.getElementById("<%=txtNetPayable.ClientID%>");
            var sectionID = document.getElementById("<%=hdnSectionID.ClientID%>");
            var InvalidPAN = document.getElementById("<%=hdnIsValidPAN.ClientID%>").value;
            var IsThresholdCrossed = document.getElementById("<%=hdnIsThresholdCrossed.ClientID%>").value;
            var IsConTaxRateCrossed = document.getElementById("<%=hdnIsConTaxRateCrossed.ClientID%>").value;
            var currentPaymentMade = document.getElementById("<%=hdnCurrentPaymentMade.ClientID%>").value;
            var makeTDSFromFirstPayment = document.getElementById("<%=hdnMakeTDSFromFirstPayment.ClientID%>").value;
            var hdnIsDeductionsIncluded = document.getElementById("<%=hdnIsDeductionsIncluded.ClientID%>");
            var totalST = Return(document.getElementById("<%=txtExcludingTax.ClientID%>").value) + Return(document.getElementById("<%=txtServiceTax.ClientID%>").value);
            document.getElementById("<%=ddlNonDeductionReason.ClientID%>").selectedIndex = 0;
            var hasMultiplePayment = document.getElementById("<%=hdnHasMultiplePayment.ClientID%>").value;
            if (hasMultiplePayment == "1")
                IsConTaxRateCrossed = "0";
            if (InvalidPAN == "1") {
                document.getElementById("<%=ddlNonDeductionReason.ClientID%>").selectedIndex = 3;
                if (Return(taxRate) < 20) {
                    taxRate = 20;
                }
                if (Return(conTaxRate) < 20 && Return(conTaxRate) > 0) {
                    conTaxRate = 20;
                }
            }
            hdnIsDeductionsIncluded.value = Return(paymentMade) > 30000 ? "1" : "0";
            if (hdnIsDeductionsIncluded.value == "1") {
                var MultipleIncluded = Return(Return(paymentMade) + Return(prevPaymentMade)) <= 75000 ? "0" : "1";
                if (hdnIsDeductionsIncluded.value == "1" && MultipleIncluded == 1) {
                    hdnIsDeductionsIncluded.value = "1";
                }
            }
            else {
                hdnIsDeductionsIncluded.value = Return(Return(paymentMade) + Return(prevPaymentMade)) <= 75000 ? "0" : "1";
                if (hdnIsDeductionsIncluded.value == 0) {
                    var totalPayment = Return(paymentMade) + Return(included) + Return(tdsMade) + Return(prevPaymentMade);
                    if (totalPayment < conLimit && totalPayment > 75000) {
                        hdnIsDeductionsIncluded.value = "1";
                    }

                }
            }
            if (Return(makeTDSFromFirstPayment) == 0) {
                if (Return(IsThresholdCrossed) == 1) {
                    if (Return(paymentMade) > 30000) {
                        var totalPayment = Return(paymentMade) + Return(included) + Return(tdsMade) + Return(prevPaymentMade);
                        fullPayment = Return(paymentMade);
                        fullPayment = totalPayment;
                        var con = fullPayment >= Return(conLimit) ? Return(conLimit) : fullPayment;
                        var tds = fullPayment - Return(con);
                        var conAmount = mode == "-1" ? Return(Return(con) * Return(conTaxRate) / 100).toFixed(2) : Math.ceil(eval(Return(con) * Return(conTaxRate) / 100));
                        var tdsAmount = mode == "-1" ? Return(Return(tds) * Return(taxRate) / 100).toFixed(2) : Math.ceil(eval(Return(tds) * Return(taxRate) / 100));
                        var total = Return(conAmount) + Return(tdsAmount) - Return(dedAmt);
                        var rate = 0;
                        if (Return(IsConTaxRateCrossed) == 0) {
                            rate = conTaxRate;
                        }
                        else {
                            rate = taxRate;
                        }
                    }
                    else {
                        fullPayment = Return(paymentMade) + Return(prevPaymentMade) + Return(included) + Return(tdsMade);
                        var con = fullPayment >= Return(conLimit) ? Return(conLimit) : fullPayment;
                        var tds = fullPayment - Return(con);
                        var conAmount = mode == "-1" ? Return(Return(con) * Return(conTaxRate) / 100).toFixed(2) : Math.ceil(eval(Return(con) * Return(conTaxRate) / 100));
                        var tdsAmount = mode == "-1" ? Return(Return(tds) * Return(taxRate) / 100).toFixed(2) : Math.ceil(eval(Return(tds) * Return(taxRate) / 100));
                        var total = Return(conAmount) + Return(tdsAmount) - Return(dedAmt);
                        var rate = 0;
                        if (Return(IsConTaxRateCrossed) == 0) {
                            rate = conTaxRate;
                        }
                        else {
                            rate = taxRate;
                        }
                    }
                    document.getElementById("<%=txtTaxDeducted.ClientID%>").value = Return(total) > Return(paymentMade) ? Return(paymentMade) : (mode == "-1" ? Return(total).toFixed(2) : Math.ceil(Return(total)));
                    document.getElementById("<%=txtTaxDeductedRate.ClientID%>").value = rate;
                    document.getElementById("<%=txtIncomeTaxAmount.ClientID%>").value = Return(total) > Return(paymentMade) ? Return(paymentMade) : (mode == "-1" ? Return(total).toFixed(2) : Math.ceil(Return(total)));
                    document.getElementById("<%=txtITRate.ClientID%>").value = rate;
                    if (document.getElementById("<%=ddlNonDeductionReason.ClientID%>").selectedIndex == 0)
                        document.getElementById("<%=ddlNonDeductionReason.ClientID%>").selectedIndex = Return(IsConTaxRateCrossed) == 0 ? 1 : 0;
                }
                else {
                    if (document.getElementById("<%=ddlNonDeductionReason.ClientID%>").selectedIndex == 0)
                        document.getElementById("<%=ddlNonDeductionReason.ClientID%>").selectedIndex = 5;
                }
            }
            else {
                if (Return(IsConTaxRateCrossed) == 0) {
                    document.getElementById("<%=txtTaxDeducted.ClientID%>").value = mode == "-1" ? Return(Return(paymentMade) * Return(conTaxRate) / 100).toFixed(2) : Math.ceil(eval(Return(paymentMade) * Return(conTaxRate) / 100));
                    document.getElementById("<%=txtTaxDeductedRate.ClientID%>").value = Return(conTaxRate);
                    document.getElementById("<%=txtIncomeTaxAmount.ClientID%>").value = mode == "-1" ? Return(Return(paymentMade) * Return(conTaxRate) / 100).toFixed(2) : Math.ceil(eval(Return(paymentMade) * Return(conTaxRate) / 100));
                    document.getElementById("<%=txtITRate.ClientID%>").value = Return(conTaxRate);
                    if (document.getElementById("<%=ddlNonDeductionReason.ClientID%>").selectedIndex == 0)
                        document.getElementById("<%=ddlNonDeductionReason.ClientID%>").selectedIndex = 1;
                }
                else {
                    document.getElementById("<%=txtTaxDeducted.ClientID%>").value = mode == "-1" ? Return(Return(paymentMade) * Return(taxRate) / 100).toFixed(2) : Math.ceil(eval(Return(paymentMade) * Return(taxRate) / 100));
                    document.getElementById("<%=txtTaxDeductedRate.ClientID%>").value = Return(taxRate);
                    document.getElementById("<%=txtIncomeTaxAmount.ClientID%>").value = mode == "-1" ? Return(Return(paymentMade) * Return(taxRate) / 100).toFixed(2) : Math.ceil(eval(Return(paymentMade) * Return(taxRate) / 100));
                    document.getElementById("<%=txtITRate.ClientID%>").value = Return(taxRate);
                }
            }
            if (Return(document.getElementById("<%=txtTaxDeducted.ClientID%>").value) > 0) {
                document.getElementById("<%=txtTaxDedDate.ClientID%>").value = document.getElementById("<%=hdnCurrentDate.ClientID%>").value;
                document.getElementById("<%=txtTaxDedDate.ClientID%>").style.backgroundColor = "#E5E5E5";
            }
            else {
                document.getElementById("<%=txtTaxDedDate.ClientID%>").value = "";
                document.getElementById("<%=txtTaxDedDate.ClientID%>").style.backgroundColor = "white";
            }
            var number = Return(totalST) - Return(document.getElementById("<%=txtTaxDeducted.ClientID%>").value);
            document.getElementById("<%=txtNetPayable.ClientID%>").value = mode == "-1" ? number.toFixed(2) : Math.ceil(eval(number));
            if (hasMultiplePayment == "1") {
                CalculateTDSForMultipleDeduction();
            }
        }
        function CalculatedTDSfor194C() {
            var makeTDSFromFirstPayment = document.getElementById("<%=hdnMakeTDSFromFirstPayment.ClientID%>").value;
            var paymentMade = document.getElementById("<%=txtAmountOfPayment.ClientID%>").value;
            var prevPaymentMade = document.getElementById("<%=hdnPreviousPaymentMade.ClientID%>").value;
            var tdsMade = document.getElementById("<%=hdnTDSMade.ClientID%>").value;
            var dedAmt = document.getElementById("<%=hdnDedAmt.ClientID%>").value;
            var included = document.getElementById("<%=hdnIncludeAmt.ClientID%>").value;
            var thresholdLimit = document.getElementById("<%=hdnThresholdLimit.ClientID%>").value;
            var taxRate = document.getElementById("<%=hdnTaxRate.ClientID%>").value;
            var conTaxRate = document.getElementById("<%=hdnConTaxRate.ClientID%>").value;
            var conLimit = document.getElementById("<%=hdnConLimit.ClientID%>").value;
            var mode = document.getElementById("<%=hdnPaymentMode.ClientID%>").value;
            var fullPayment;
            var tdsRate = document.getElementById("<%=txtTaxDeductedRate.ClientID%>");
            var tds = document.getElementById("<%=txtTaxDeducted.ClientID%>");
            var netPayable = document.getElementById("<%=txtNetPayable.ClientID%>");
            var sectionID = document.getElementById("<%=hdnSectionID.ClientID%>");
            var InvalidPAN = document.getElementById("<%=hdnIsValidPAN.ClientID%>").value;
            var IsThresholdCrossed = document.getElementById("<%=hdnIsThresholdCrossed.ClientID%>").value;
            var IsConTaxRateCrossed = document.getElementById("<%=hdnIsConTaxRateCrossed.ClientID%>").value;
            var currentPaymentMade = document.getElementById("<%=hdnCurrentPaymentMade.ClientID%>").value;
            var makeTDSFromFirstPayment = document.getElementById("<%=hdnMakeTDSFromFirstPayment.ClientID%>").value;
            var hdnIsDeductionsIncluded = document.getElementById("<%=hdnIsDeductionsIncluded.ClientID%>");
            var totalST = Return(document.getElementById("<%=txtExcludingTax.ClientID%>").value) + Return(document.getElementById("<%=txtServiceTax.ClientID%>").value);
            document.getElementById("<%=ddlNonDeductionReason.ClientID%>").selectedIndex = 0;
            document.getElementById("<%=hdnIsDeductionsIncluded.ClientID%>").value = Return(prevPaymentMade) > 0 ? "1" : "0";
            var hasMultiplePayment = document.getElementById("<%=hdnHasMultiplePayment.ClientID%>").value;
            var tdsPayment = 0;
            if (InvalidPAN == "1") {
                document.getElementById("<%=ddlNonDeductionReason.ClientID%>").selectedIndex = 3;
                if (Return(taxRate) < 20) {
                    taxRate = 20;
                }
                if (Return(conTaxRate) < 20 && Return(conTaxRate) > 0) {
                    conTaxRate = 20;
                }
            }
            if (InvalidPAN == "1" && Return(conTaxRate) == 0) {
                document.getElementById("<%=txtTaxDeducted.ClientID%>").value = "0";
                document.getElementById("<%=txtTaxDeductedRate.ClientID%>").value = Return(conTaxRate);
                document.getElementById("<%=txtIncomeTaxAmount.ClientID%>").value = "0";
                document.getElementById("<%=txtITRate.ClientID%>").value = Return(conTaxRate);
                return;
            }
            if (makeTDSFromFirstPayment == "0") {
                fullPayment = Return(currentPaymentMade) > 30000 ? Return(paymentMade) : Return(paymentMade) + Return(prevPaymentMade) + Return(tdsMade);
                hdnIsDeductionsIncluded.value = Return(currentPaymentMade) > 30000 ? "0" : "1";
                if (Return(makeTDSFromFirstPayment) == 0) {
                    if (Return(IsConTaxRateCrossed) == 0) {
                        tdsPayment = mode == "-1" ? Return(Return(fullPayment) * Return(conTaxRate) / 100).toFixed(2) : Math.ceil(eval(Return(fullPayment) * Return(conTaxRate) / 100));
                    }
                    else {
                        tdsPayment = mode == "-1" ? Return(Return(fullPayment) * Return(taxRate) / 100).toFixed(2) : Math.ceil(eval(Return(fullPayment) * Return(taxRate) / 100));
                    }
                }
                else {
                    if (Return(IsConTaxRateCrossed) == 0) {
                        tdsPayment = mode == "-1" ? Return(Return(paymentMade) * Return(conTaxRate) / 100).toFixed(2) : Math.ceil(eval(Return(paymentMade) * Return(conTaxRate) / 100));
                    }
                    else {
                        tdsPayment = mode == "-1" ? Return(Return(paymentMade) * Return(taxRate) / 100).toFixed(2) : Math.ceil(eval(Return(paymentMade) * Return(taxRate) / 100));
                    }
                }
                if (Return(IsThresholdCrossed) == 1) {
                    if (Return(conLimit) > 0) {
                        var con = fullPayment <= conLimit ? fullPayment : conLimit;
                        var conAmount = mode == "-1" ? Return(Return(con) * Return(conTaxRate) / 100).toFixed(2) : Math.ceil(eval(Return(con) * Return(conTaxRate) / 100));
                        var tds = Return(fullPayment) - Return(conAmount);
                        var tdsAmount = mode == "-1" ? Return(Return(tds) * Return(taxRate) / 100).toFixed(2) : Math.ceil(eval(Return(tds) * Return(taxRate) / 100));
                        var total = Return(conAmount) + Return(tdsAmount);
                        var remain = Return(total) - Return(dedAmt);
                    }
                    document.getElementById("<%=txtTaxDeducted.ClientID%>").value = tdsPayment;
                    document.getElementById("<%=txtTaxDeductedRate.ClientID%>").value = Return(IsConTaxRateCrossed) == 0 ? Return(conTaxRate) : Return(taxRate);
                    document.getElementById("<%=txtIncomeTaxAmount.ClientID%>").value = tdsPayment;
                    document.getElementById("<%=txtITRate.ClientID%>").value = Return(IsConTaxRateCrossed) == 0 ? Return(conTaxRate) : Return(taxRate);
                    if (document.getElementById("<%=ddlNonDeductionReason.ClientID%>").selectedIndex == 0)
                        document.getElementById("<%=ddlNonDeductionReason.ClientID%>").selectedIndex = Return(IsConTaxRateCrossed) == 0 ? 1 : 0;
                }
                else {
                    if (document.getElementById("<%=ddlNonDeductionReason.ClientID%>").selectedIndex == 0)
                        document.getElementById("<%=ddlNonDeductionReason.ClientID%>").selectedIndex = 5;
                }
                if (Return(document.getElementById("<%=txtAmountOfPayment.ClientID%>").value) < Return(document.getElementById("<%=txtTaxDeducted.ClientID%>").value)) {
                    var finalRate = document.getElementById("<%=txtTaxDeductedRate.ClientID%>").value;
                    document.getElementById("<%=txtTaxDeducted.ClientID%>").value = mode == "-1" ? Return(document.getElementById("<%=txtAmountOfPayment.ClientID%>").value) : Math.ceil(eval(document.getElementById("<%=txtAmountOfPayment.ClientID%>").value));
                    document.getElementById("<%=txtIncomeTaxAmount.ClientID%>").value = mode == "-1" ? Return(document.getElementById("<%=txtAmountOfPayment.ClientID%>").value) : Math.ceil(eval(document.getElementById("<%=txtAmountOfPayment.ClientID%>").value));
                    document.getElementById("<%=hdnIsDeductionsIncluded.ClientID%>").value = "1";
                }
            }
            else {
                if (IsConTaxRateCrossed == "0") {
                    document.getElementById("<%=txtTaxDeducted.ClientID%>").value = mode == "-1" ? Return(Return(paymentMade) * Return(conTaxRate) / 100).toFixed(2) : Math.ceil(eval(Return(paymentMade) * Return(conTaxRate) / 100));
                    document.getElementById("<%=txtTaxDeductedRate.ClientID%>").value = Return(conTaxRate);
                    document.getElementById("<%=txtIncomeTaxAmount.ClientID%>").value = mode == "-1" ? Return(Return(paymentMade) * Return(conTaxRate) / 100).toFixed(2) : Math.ceil(eval(Return(paymentMade) * Return(conTaxRate) / 100));
                    document.getElementById("<%=txtITRate.ClientID%>").value = Return(conTaxRate);
                    if (document.getElementById("<%=ddlNonDeductionReason.ClientID%>").selectedIndex == 0)
                        document.getElementById("<%=ddlNonDeductionReason.ClientID%>").selectedIndex = 1;
                }
                else {
                    document.getElementById("<%=txtTaxDeducted.ClientID%>").value = mode == "-1" ? Return(Return(paymentMade) * Return(taxRate) / 100).toFixed(2) : Math.ceil(eval(Return(paymentMade) * Return(taxRate) / 100));
                    document.getElementById("<%=txtTaxDeductedRate.ClientID%>").value = Return(taxRate);
                    document.getElementById("<%=txtIncomeTaxAmount.ClientID%>").value = mode == "-1" ? Return(Return(paymentMade) * Return(taxRate) / 100).toFixed(2) : Math.ceil(eval(Return(paymentMade) * Return(taxRate) / 100));
                    document.getElementById("<%=txtITRate.ClientID%>").value = Return(taxRate);
                }
            }
            if (Return(document.getElementById("<%=txtTaxDeducted.ClientID%>").value) > 0) {
                document.getElementById("<%=txtTaxDedDate.ClientID%>").value = document.getElementById("<%=hdnCurrentDate.ClientID%>").value;
                document.getElementById("<%=txtTaxDedDate.ClientID%>").style.backgroundColor = "#E5E5E5";
            }
            else {
                document.getElementById("<%=txtTaxDedDate.ClientID%>").value = "";
                document.getElementById("<%=txtTaxDedDate.ClientID%>").style.backgroundColor = "white";
            }
            var number = Return(totalST) - Return(document.getElementById("<%=txtTaxDeducted.ClientID%>").value);
            document.getElementById("<%=txtNetPayable.ClientID%>").value = mode == "-1" ? number.toFixed(2) : Math.ceil(eval(number));
            if (hasMultiplePayment == "1") {
                CalculateTDSForMultipleDeduction();
            }
        }
        function Calculate() {

            var makeTDSFromFirstPayment = document.getElementById("<%=hdnMakeTDSFromFirstPayment.ClientID%>");
            var paymentMade = document.getElementById("<%=txtAmountOfPayment.ClientID%>");
            var prevPaymentMade = document.getElementById("<%=hdnPreviousPaymentMade.ClientID%>");
            var tdsMade = document.getElementById("<%=hdnTDSMade.ClientID%>");
            var dedAmt = document.getElementById("<%=hdnDedAmt.ClientID%>");
            var included = document.getElementById("<%=hdnIncludeAmt.ClientID%>");
            var thresholdLimit = document.getElementById("<%=hdnThresholdLimit.ClientID%>");
            var taxRate = document.getElementById("<%=hdnTaxRate.ClientID%>");
            var conTaxRate = document.getElementById("<%=hdnConTaxRate.ClientID%>");
            var conLimit = document.getElementById("<%=hdnConLimit.ClientID%>");
            var mode = document.getElementById("<%=hdnPaymentMode.ClientID%>");
            var fullPayment = Return(paymentMade) + Return(prevPaymentMade);
            var taxDedRate = document.getElementById("<%=txtTaxDeductedRate.ClientID%>");
            var taxDeducted = document.getElementById("<%=txtTaxDeducted.ClientID%>");
            var netPayable = document.getElementById("<%=txtNetPayable.ClientID%>");
            var sectionID = document.getElementById("<%=hdnSectionID.ClientID%>");
            var InvalidPAN = document.getElementById("<%=hdnIsValidPAN.ClientID%>");
            var IsThresholdCrossed = document.getElementById("<%=hdnIsThresholdCrossed.ClientID%>");
            var IsConTaxRateCrossed = document.getElementById("<%=hdnIsConTaxRateCrossed.ClientID%>");
            var serviceTax = document.getElementById("<%=txtServiceTax.ClientID%>");
            var excludingST = document.getElementById("<%=txtExcludingTax.ClientID%>");
            document.getElementById("<%=ddlNonDeductionReason.ClientID%>").selectedIndex = 0;
            var nonDedReason = document.getElementById("<%=ddlNonDeductionReason.ClientID%>");
            var hdnIsDeductionsIncluded = document.getElementById("<%=hdnIsDeductionsIncluded.ClientID%>");
            var hasMultiplePayment = document.getElementById("<%=hdnHasMultiplePayment.ClientID%>");
            var incomeTax = document.getElementById("<%=txtIncomeTaxAmount.ClientID%>");
            var itRate = document.getElementById("<%=txtITRate.ClientID%>");
            var chkEdit = document.getElementById("<%=chkEdit.ClientID%>");
            var deductedDate = document.getElementById("<%=txtTaxDedDate.ClientID%>");
            var currentDate = document.getElementById("<%=hdnCurrentDate.ClientID%>");
            var extraAmount = document.getElementById("<%=hdnExtraPaymentMade.ClientID%>");
            var ST = document.getElementById("<%=hdnServiceTax.ClientID%>");
            var payment = document.getElementById("<%=txtPaymentMade.ClientID%>");
            var txtRate = document.getElementById("<%=txtRate.ClientID%>");
            var rateAmount = document.getElementById("<%=txtRate.ClientID%>");
            var payable = document.getElementById("<%=txtPayable.ClientID%>");
            var hdnNonDedReason = document.getElementById("<%=hdnNonDedReason.ClientID%>");
            var hdnTaxRate = document.getElementById("<%=hdnTaxRate.ClientID%>");

            CalculateTDSAmount(makeTDSFromFirstPayment, paymentMade, prevPaymentMade, tdsMade, dedAmt, included, thresholdLimit, taxRate, conTaxRate, conLimit, mode, taxDedRate,
                    taxDeducted, netPayable, sectionID, InvalidPAN, IsThresholdCrossed, IsConTaxRateCrossed, nonDedReason, hdnIsDeductionsIncluded, excludingST, serviceTax,
                    incomeTax, itRate, chkEdit, deductedDate, currentDate, hasMultiplePayment);
            if (hasMultiplePayment.value == "1") {
                CalculateTDSForMultipleDeduction();
            }
        }
        function EnableDisable(objValue) {
            var paymentMade = document.getElementById("<%=txtAmountOfPayment.ClientID%>");
            var name = document.getElementById("<%=txtName.ClientID%>");
            var itrate = document.getElementById("<%=txtITRate.ClientID%>");
            var itAmt = document.getElementById("<%=txtIncomeTaxAmount.ClientID%>");
            var surchargeRate = document.getElementById("<%=txtSurchargeRate.ClientID%>");
            var surchargeAmt = document.getElementById("<%=txtSurchargeAmount.ClientID%>");
            var cessRate = document.getElementById("<%=txtEduCessRate.ClientID%>");
            var cessAmt = document.getElementById("<%=txtEduCessAmount.ClientID%>");
            var edit = document.getElementById("<%=chkEdit.ClientID%>");
            var editSec = document.getElementById("<%=chkSecEdit.ClientID %>");
            var nondedReason = document.getElementById("<%=ddlNonDeductionReason.ClientID%>");
            var accNum = document.getElementById("<%=txtAccNum.ClientID%>");
            var ifscCode = document.getElementById("<%=txtCode.ClientID%>");
            var excludeST = document.getElementById("<%=txtExcludingTax.ClientID%>");
            var ST = document.getElementById("<%=txtServiceTax.ClientID%>");
            var netPayable = document.getElementById("<%=txtNetPayable.ClientID%>");
            var creditedDate = document.getElementById("<%=txtCreditedDate.ClientID%>");
            var deductedDate = document.getElementById("<%=txtTaxDedDate.ClientID%>");
            var bankBranchName = document.getElementById("<%=txtBankBranchName.ClientID%>");
            var secondPayment = document.getElementById("<%=txtPaymentMade.ClientID%>");
            var taxRate = document.getElementById("<%=txtRate.ClientID%>");
            var rateAmt = document.getElementById("<%=txtRateAmount.ClientID%>");
            var payable = document.getElementById("<%=txtPayable.ClientID%>");
            var STRegNo = document.getElementById("<%=txtRegNo.ClientID%>");
            var IsSuperAdmin = document.getElementById("<%=hdnIsSuperAdmin.ClientID%>");
            var certNo = document.getElementById("<%=txtCertNo.ClientID%>");
            if (objValue == 1) {
                if (name != null) name.readOnly = true;
                if (paymentMade != null) paymentMade.readOnly = true;
                if (itrate != null) itrate.readOnly = true;
                if (itAmt != null) itAmt.readOnly = true;
                if (surchargeRate != null) surchargeRate.readOnly = true;
                if (surchargeAmt != null) surchargeAmt.readOnly = true;
                if (cessRate != null) cessRate.readOnly = true;
                if (cessAmt != null) cessAmt.readOnly = true;
                if (edit != null) edit.disabled = true;
                if (editSec != null) editSec.disabled = true;
                if (nondedReason != null) nondedReason.disabled = true;
                if (accNum != null) accNum.readOnly = true;
                if (ifscCode != null) ifscCode.readOnly = true;
                if (excludeST != null) excludeST.readOnly = true;
                if (ST != null) ST.readOnly = true;
                if (secondPayment != null) secondPayment.readOnly = true;
                if (taxRate != null) taxRate.readOnly = true;
                if (rateAmt != null) rateAmt.readOnly = true;
                if (payable != null) payable.readOnly = true;
                if (netPayable != null) netPayable.readOnly = true;
                if (bankBranchName != null) bankBranchName.readOnly = true;
                if (STRegNo != null) STRegNo.readOnly = true;
                if (creditedDate != null) creditedDate.readOnly = true;
                if (deductedDate != null) deductedDate.readOnly = true;
                if (certNo != null) certNo.readOnly = true;
            }
            else {
                if (name != null) name.readOnly = true;
                if (paymentMade != null) paymentMade.readOnly = false;
                if (itrate != null) itrate.readOnly = false;
                if (itAmt != null) itAmt.readOnly = false;
                if (surchargeRate != null) surchargeRate.readOnly = false;
                if (surchargeAmt != null) surchargeAmt.readOnly = false;
                if (cessRate != null) cessRate.readOnly = false;
                if (cessAmt != null) cessAmt.readOnly = false;
                if (edit != null) edit.disabled = false;
                if (nondedReason != null) nondedReason.disabled = false;
                if (accNum != null) accNum.readOnly = false;
                if (ifscCode != null) ifscCode.readOnly = false;
                if (excludeST != null) excludeST.readOnly = false;
                if (ST != null) ST.readOnly = false;
                if (netPayable != null) netPayable.readOnly = false;
                if (bankBranchName != null) bankBranchName.readOnly = false;
                if (secondPayment != null) secondPayment.readOnly = false;
                if (taxRate != null) taxRate.readOnly = false;
                if (rateAmt != null) rateAmt.readOnly = false;
                if (payable != null) payable.readOnly = false;
                if (STRegNo != null) STRegNo.readOnly = false;
                if (creditedDate != null) creditedDate.readOnly = false;
                if (deductedDate != null) deductedDate.readOnly = false;
                if (certNo != null) certNo.readOnly = false;
            }
            if (objValue == 3) {
                if (name != null) name.readOnly = false;
            }
            if (IsSuperAdmin.value == "1") {
                if (creditedDate != null) creditedDate.readOnly = false;
                if (deductedDate != null) deductedDate.readOnly = false;
            }
        }
        function HideControls(objValue) {
            var hdnIsCBI = document.getElementById("<%=hdnIsCBI.ClientID%>");
            var rowSection = document.getElementById("<%=rowSection.ClientID%>");
            var rowBGLCode = document.getElementById("<%=rowBGLCode.ClientID%>");
            if (objValue == 1) {
                if (rowBGLCode != null) document.getElementById("<%=rowBGLCode.ClientID%>").style.display = 'none';
                if (rowSection != null) document.getElementById("<%=rowSection.ClientID%>").style.display = '';
            }
            else {
                if (rowSection != null) document.getElementById("<%=rowSection.ClientID%>").style.display = 'none';
                if (rowBGLCode != null) document.getElementById("<%=rowBGLCode.ClientID%>").style.display = '';
            }
            if (hdnIsCBI.value == "1" && (document.getElementById("<%=hdnFormType.ClientID%>").value == "Form26" || document.getElementById("<%=hdnFormType.ClientID%>").value == "Form27")) {
                if (rowBGLCode != null) document.getElementById("<%=rowBGLCode.ClientID%>").style.display = '';
                if (rowSection != null) document.getElementById("<%=rowSection.ClientID%>").style.display = '';
            }
        }
        function ValidateDate() {
            var date1 = document.getElementById("<%=txtFromDate.ClientID%>").value;
            var date2 = document.getElementById("<%=txtToDate.ClientID%>").value;
            if (date1 != "" || date2 != "") {
                var fromDate = new Date(document.getElementById("<%=txtFromDate.ClientID%>").value);
                var toDate = new Date(document.getElementById("<%=txtToDate.ClientID%>").value);
                if (date1 != "" && date2 == "") {
                    document.getElementById("<%=txtToDate.ClientID%>").value = date1;
                }
                else if (date1 == "" && date2 != "") {
                    document.getElementById("<%=txtFromDate.ClientID%>").value = date2;
                }
                else if (!CheckDate(document.getElementById("<%=txtFromDate.ClientID%>").value, document.getElementById("<%=txtToDate.ClientID%>").value)) {//If to date is less Than From Date then Swap
                    var temp = document.getElementById("<%=txtToDate.ClientID%>").value;
                    document.getElementById("<%=txtToDate.ClientID%>").value = document.getElementById("<%=txtFromDate.ClientID%>").value;
                    document.getElementById("<%=txtFromDate.ClientID%>").value = temp;
                }
            }
            else {
                var finYear = Number(document.getElementById("<%=hdnFinYear.ClientID%>").value);
                var minFinDate = new Date(finYear, 03, 01);
                var maxFinDate = new Date(eval(finYear) + 1, 02, 31);
                document.getElementById("<%=txtFromDate.ClientID%>").value = minFinDate.getDate() + "/" + (minFinDate.getMonth() + 1) + "/" + minFinDate.getFullYear();
                document.getElementById("<%=txtToDate.ClientID%>").value = maxFinDate.getDate() + "/" + (maxFinDate.getMonth() + 1) + "/" + maxFinDate.getFullYear();
                setDateFormat(document.getElementById("<%=txtFromDate.ClientID%>"));
                setDateFormat(document.getElementById("<%=txtToDate.ClientID%>"));
            }
            return true;
        }
        function SetDate(objValue) {
            document.getElementById("<%=txtDate.ClientID%>").value = "";
            document.getElementById("<%=hdnReportType.ClientID%>").value = objValue;
            var now = new Date();
            if (objValue == 1)
                document.getElementById("<%=txtDate.ClientID%>").value = now.getDate() + "/" + (now.getMonth() + 1) + "/" + now.getFullYear();
            else if (document.getElementById("<%=txtDate.ClientID%>").value == "")
                document.getElementById("<%=txtDate.ClientID%>").value = now.getDate() + "/" + (now.getMonth() + 1) + "/" + now.getFullYear();
            setDateFormat(document.getElementById("<%=txtDate.ClientID%>"));
            Show();
            return false;
        }

        function Show() {
            if (document.getElementById("<%=verDiv.ClientID%>").style.display == '') {
                document.getElementById("<%=verDiv.ClientID%>").style.display = 'none';
                document.getElementById("<%=MaskedDiv1.ClientID%>").style.display = 'none';
            }
            else {
                document.getElementById("<%=verDiv.ClientID%>").style.display = '';
                document.getElementById("<%=MaskedDiv1.ClientID%>").style.display = '';
                document.getElementById('<%=MaskedDiv1.ClientID%>').style.visibility = 'visible';
                document.getElementById('<%=MaskedDiv1.ClientID%>').style.top = '0px';
                document.getElementById('<%=MaskedDiv1.ClientID%>').style.left = '0px';
                document.getElementById('<%=MaskedDiv1.ClientID%>').style.width = document.documentElement.offsetWidth + 'px';
                document.getElementById('<%=MaskedDiv1.ClientID%>').style.height = (typeof window.innerHeight != 'undefined' ? window.innerHeight : document.body.offsetHeight) + 'px';
            }
            reportType = document.getElementById("<%=hdnReportType.ClientID%>").value;
            lblReport = document.getElementById("<%=lblReport.ClientID%>");
            trTrans = document.getElementById("<%=trTrans.ClientID%>");
            btnDailyReportPreview = document.getElementById("<%=btnDailyReportPreview.ClientID%>");
            if (reportType == 1) {
                lblReport.innerText = "Daily Report";
                btnDailyReportPreview.value = "Preview"
                trTrans.style.display = 'none';
            }
            else {
                lblReport.innerText = "CBS File Generation";
                btnDailyReportPreview.value = "Generate";
                document.getElementById("<%=txtTransDate.ClientID%>").value = document.getElementById("<%=txtDate.ClientID%>").value
                trTrans.style.display = '';
            }
        }
        function ShowDate() {
            var rowDate = document.getElementById("<%=rowCreatedOn.ClientID%>");
            if (document.getElementById("<%=hdnIsSuperAdmin.ClientID%>").value == "1")
                rowDate.style.display = '';
            else
                rowDate.style.display = 'none';
        }
        function SetNonDedReason() {
            var isUCO = document.getElementById("<%=hdnIsUCO.ClientID%>");
            var isSuperAdmin = document.getElementById("<%=hdnIsSuperAdmin.ClientID%>");
            var isBranchAdmin = document.getElementById("<%=hdnIsBranchAdmin.ClientID%>");
            var theDropDown = document.getElementById("<%=ddlNonDeductionReason.ClientID%>");
            if (document.getElementById("<%=txtITRate.ClientID%>") != null) {
                if (theDropDown.selectedIndex != "0" && isUCO.value == "1") {
                    document.getElementById("<%=txtITRate.ClientID%>").disabled = false;
                }
                else if (theDropDown.selectedIndex == "0" && isUCO.value == "1" && !(isSuperAdmin.value == "1" || isBranchAdmin.value == "1")) {
                    document.getElementById("<%=txtITRate.ClientID%>").disabled = true;
                }
            }
            var toolTipObj = new Object();
            var formType = document.getElementById("<%=hdnFormType.ClientID%>").value;
            var txtCertNo = document.getElementById("<%=txtCertNo.ClientID%>");
            toolTipObj = document.getElementById("tooltip");
            if (theDropDown != null) {
                toolTipObj.innerHTML = theDropDown.options[theDropDown.selectedIndex].value != "0" ? theDropDown.options[theDropDown.selectedIndex].text : "";
                if (txtCertNo != null) {
                    var value = theDropDown.value;
                    if (formType == "Form24" || formType == "Form27") {
                        if (Return(value) == 1 || Return(value) == 2)
                            txtCertNo.style.backgroundColor = "#E5E5E5";
                        else
                            txtCertNo.style.backgroundColor = "White";
                    }
                    else {
                        if (Return(value) == 1) {
                            txtCertNo.style.backgroundColor = "#E5E5E5";
                            HideRow(document.getElementById("<%=tdGetUIN.ClientID%>"));
                            document.getElementById("<%=Label17.ClientID%>").innerHTML = "U/s 197 Cert. No.";
                        }
                        else {
                            if (Return(value) == 2) {
                                if ((Return(document.getElementById("<%=hdnQuarter.ClientID%>").value == "Quarter1" ? 1 : document.getElementById("<%=hdnQuarter.ClientID%>").value == "Quarter2" ? 2 : document.getElementById("<%=hdnQuarter.ClientID%>").value == "Quarter3" ? 3 : document.getElementById("<%=hdnQuarter.ClientID%>").value == "Quarter4" ? 4 : 0) > 2 && Return(document.getElementById("<%=hdnFinYear.ClientID%>").value) == 2015) || Return(document.getElementById("<%=hdnFinYear.ClientID%>").value) > 2015) {
                                    DisplayRow(document.getElementById("<%=tdGetUIN.ClientID%>"));
                                    document.getElementById("<%=Label17.ClientID%>").innerHTML = "15G/15H UIN";
                                }
                            }
                            else {
                                document.getElementById("<%=Label17.ClientID%>").innerHTML = "U/s 197 Cert. No.";
                                HideRow(document.getElementById("<%=tdGetUIN.ClientID%>"));
                            }

                            txtCertNo.style.backgroundColor = "White";
                        }
                    }
                    if (value == 0)
                        txtCertNo.value = "";
                }
            }
        }
        function DisplayRow(row) {
            row.style.display = '';
        }
        function HideRow(row) {
            row.style.display = 'none';
        }
        function SetSection() {
            var cbl = document.getElementById('<%=chkSections.ClientID%>');
            var values = "";
            var tbody = cbl.childNodes[0];
            var length = (tbody.childNodes.length);
            for (i = 0; i < length; i++) {
                var td = tbody.childNodes[i].childNodes[0];
                var chk = td.childNodes[0];
                if (chk.checked) {
                    values = td.innerText.substring(0, td.innerText.indexOf('-')).trim() + "," + values;
                }
            }
            document.getElementById("<%=txtSection.ClientID%>").value = values;
        }
        function ShowProcessText(obj) {
            if (document.getElementById("<%=hdnReportType.ClientID%>").value == "2") {
                var quarter = GetQuarter(document.getElementById("<%=txtDate.ClientID%>").value.trim().split('/')[1]);
                if (quarter != document.getElementById("<%=hdnQuarter.ClientID%>").value) {
                    document.getElementById("<%=txtDate.ClientID%>").focus();
                    alert("Paid Date should be in the selected quarter.");
                    return false;
                }
                if (obj.value == "Generate") {
                    var hDownLoad = document.getElementById("<%=hlinkDownloadFile.ClientID%>");
                    var hSkippedDownLoad = document.getElementById("<%=hlinkDownloadSkippedFile.ClientID%>");
                    if (hDownLoad != null) {
                        hDownLoad.style.display = 'none';
                    }
                    if (hSkippedDownLoad != null) {
                        hSkippedDownLoad.style.display = 'none';
                    }
                    obj.value = "Please wait.....";
                    return true;
                }
                else if (obj.value == "Please wait.....") {
                    return false;
                }
            }
        }
        function GetQuarter(month) {
            var quarter = "0";
            switch (month) {
                case "04":
                case "05":
                case "06":
                    quarter = "1";
                    break;
                case "07":
                case "08":
                case "09":
                    quarter = "2";
                    break;

                case "10":
                case "11":
                case "12":
                    quarter = "3";
                    break;
                case "01":
                case "02":
                case "03":
                    quarter = "4"
                    break;
            }
            return "Quarter" + quarter;
        }
        function GenerateCBSFile() {
            if (confirm("CBS File already generated.\nDo You want to generate file again?"))
                __doPostBack('CBSFileGen', 'CBSFileGen')
        }
        function DisplayControls() {
            var finYear = document.getElementById("<%=hdnFinYear.ClientID%>").value;
            var formType = document.getElementById("<%=hdnFormType.ClientID%>").value;
            var pnlDetailsHead = document.getElementById("<%=pnlDetailsHead.ClientID%>");
            var pnlMoreDetails = document.getElementById("<%=pnlMoreDetails.ClientID%>");
            var rowCertNo = document.getElementById("<%=rowCertNo.ClientID%>");
            var rowReferenceNo = document.getElementById("<%=rowReferenceNo.ClientID%>");           
            if (rowCertNo != null)
                rowCertNo.style.display = Return(finYear) > 2012 ? '' : 'none';
            if (formType != "Form24" && document.getElementById("<%=hdnIsCBI.ClientID%>").value == 1) {
                if (rowReferenceNo != null)
                    rowReferenceNo.style.display = '';
            }
            else {
                if (rowReferenceNo != null)
                    rowReferenceNo.style.display = 'none';
            }
            if (Return(finYear) > 2012 && formType == "Form27") {
                if (pnlDetailsHead != null)
                    pnlDetailsHead.style.display = '';
                if (pnlMoreDetails != null)
                    pnlMoreDetails.style.display = '';
            }
            else {
                if (pnlDetailsHead != null)
                    pnlDetailsHead.style.display = 'none';
                if (pnlMoreDetails != null)
                    pnlMoreDetails.style.display = 'none';
            }
        }
        function SetDeductedDate() {
            var taxDeducted = document.getElementById("<%=txtTaxDeducted.ClientID%>");
            var deductedDate = document.getElementById("<%=txtTaxDedDate.ClientID%>");
            var creditedDate = document.getElementById("<%=txtCreditedDate.ClientID%>");
            var IsUBI = document.getElementById("<%=hdnIsUBI.ClientID%>");

            if (Return(taxDeducted.value) > 0) {
                deductedDate.value = creditedDate.value;
            }
        }
        function ValidateIfPANNotAvailableOthers(isSB, hdnIsValidPAN, hdnFormType, txtTaxDeductedRate, ddlNonDeductionReason, txtTaxDeducted, txtITRate, txtIncomeTaxAmount) {
            if (hdnIsValidPAN.value != "1") {
                if (hdnFormType.value != "Form24" && hdnFormType.value != "Form27E") {
                    if (Return(txtTaxDeductedRate.value) < 20) {
                        if (!isSB) {
                            var res = confirm('Since Deductee is having invalid PAN structure,\nTDS has to be deducted at the rate of 20%.\nDo you want to continue?');
                            if (res) {
                                if (ddlNonDeductionReason.value == "3") {
                                    if (Return(txtTaxDeducted.value) == 0) {
                                        alert("For 'PAN Not available - Higher Rate (20%)',\nTax Deducted can't be Nil.'");
                                        txtITRate.focus();
                                        return false;
                                    }
                                }
                            }
                            else {
                                return false;
                            }
                        }
                        else {
                            alert("Since Deductee is having invalid PAN structure,\nTDS has to be deducted at the rate of 20%");
                            return false;
                        }
                    }
                    else {
                        if (Return(txtTaxDeducted.value) == 0 && Return(txtTaxDeductedRate.value) != 0) {
                            alert('Since Tax Dedcuted Amount is zero,\nTax Deducted Rate should also be zero.');
                            txtITRate.focus();
                            return false;
                        }
                    }
                }
                else if (hdnFormType.value == "Form27E") {
                    if (Return(txtTaxDeductedRate.value) < 5) {
                        alert("Since Deductee is having invalid PAN structure,\nTDS has to be deducted at the rate of 5%");
                        return false;
                    }
                }
                else {
                    if (ddlNonDeductionReason.value == "3") {
                        if (hdnFormType.value == "Form24") {
                            if (Return(txtTaxDeducted.value) == 0) {
                                alert("For 'PAN Not available - Higher Rate (20%)',\nTax Deducted can't be Nil.'");
                                txtIncomeTaxAmount.focus();
                                return false;
                            }
                        }
                        else {
                            if (Return(txtTaxDeducted.value) == 0 &&
                            Return(txtTaxDeductedRate.value) == 0) {
                                alert("For 'PAN Not available - Higher Rate (20%)',\nTax Deducted can't be Nil.'");
                                if (hdnFormType.value != "Form24") {
                                    txtITRate.focus();
                                    return false;
                                }
                            }
                            else if (Return(txtTaxDeducted.value) == 0 && Return(txtTaxDeductedRate.value) != 0) {
                                alert("For 'PAN Not available - Higher Rate (20%)',\nTax Deducted can't be Nil.'");
                                txtITRate.focus();
                                return false;
                            }
                            else if (Return(txtTaxDeducted.value) != 0 && Return(txtTaxDeductedRate.value) == 0) {
                                alert("For 'PAN Not available - Higher Rate (20%)',\nTax Deducted Rate can't be Nil.'");
                                txtITRate.focus();
                                return false;
                            }
                        }
                    }
                    return true;
                }
            }
            return true;
        }
        function ValidateLoadAll() {
            return confirm("Loading all details will take time.\nRecommend to use search filters.\n\nDo you want to continue?");
        }
        function checkValidEmail(object) {
            if (object.value.trim() != "") {
                if (!ValidateEmail(object)) {
                    document.getElementById("<%=txtEmailDed.ClientID%>").value = "";
                    return false;
                }
            }
        }
        function checkValidContactNo(inputtxt) {
            var numbers = /^[0-9]+$/;
            if (inputtxt.value.trim() != "") {
                if (!inputtxt.value.match(numbers)) {
                    alert('Please input valid Contact Number.');
                    document.getElementById("<%=txtContactNoDed.ClientID%>").value = "";
                    return false;
                }
                else {
                    return true;
                }
            }
        }
        function checkValidDedAddress(inputtxt) {
            if (inputtxt.value != "") {
                if (!InputValidationsForAddress(inputtxt)) {
                    document.getElementById("<%=txtAddressDed.ClientID%>").value = "";
                    return false;
                }
            }
        }
        function InputValidationsForIdentNum(objName) {
            var alphaExp = /[a-zA-Z0-9]/;
            var specialcharsExp = /[`~!@#$%^&*()_+,.?;:[{]}|\/]/;
            var zeros = /[0]+$/;
            if (objName.value != "") {
                if (!objName.value.match(alphaExp)) {
                    if (!objName.value.match(specialcharsExp)) {
                        alert("Only Zeros, Special Characters or blank spaces are not allowed");
                        document.getElementById("<%=txtIdentNumDed.ClientID%>").value = "";
                        return false;
                    }
                    else {
                        return true;
                    }
                }
                else if (objName.value.match(zeros)) {
                    alert("Only Zeros, Special Characters or blank spaces are not allowed");
                    document.getElementById("<%=txtIdentNumDed.ClientID%>").value = "";
                    return false;
                }
                else {
                    return true;
                }
            }
        }

        function ValidateNonDedReasonfor194N(ddlNonDeductionReason, txtTaxDeducted) 
        {
	        if (ddlNonDeductionReason.value == "9" && Return(txtTaxDeducted.value) != 0) {
		        var res = confirm('For remark No deduction on account of Section 194N clause (iii) or (iv) or (v),\n\nDeduction amount is given.\n\nDo you want to continue?');																		   
		        if (res) {
			        return true;
		        }
		        else {
			        return false;
		        }                        
	        }
	        return true;
        }
        function Validate194NSectionBasedOnDate() {
            var date = new Date(2019, 09, 01);
            var paymentDate = document.getElementById("<%=txtCreditedDate.ClientID%>");
            var date1 = paymentDate.value;
            if (date1.toString().indexOf("-") != -1) {
                date1 = date1.split('-', 3);
            }
            else {
                date1 = date1.split('/', 3);
            }
            var creditedDate = new Date(date1[2], date1[1], date1[0]);
            if (creditedDate < date) {
                alert("Section '194N' is Applicable from '01/09/2019'.\nSpecify the correct date in Paid/Credited Date");
                return false;
            }
            return true;
        }
    </script>
    <script type="text/javascript" language="javascript" src="../JavaScript/Validations.js"></script>
    <script type="text/javascript" language="javascript" src="../JavaScript/TDSValidations.js"></script>
    <style type="text/css">
        .style2
        {
            width: 281px;
        }
        .style4
        {
            width: 28px;
        }
        .style5
        {
            width: 125px;
        }
        .style6
        {
            width: 46px;
        }
        .style7
        {
            width: 105px;
        }
        .style8
        {
            height: 16px;
        }
        /*Modal Popup*/.modalBackground
        {
            background-color: Gray;
            filter: alpha(opacity=70);
            opacity: 0.7;
        }
        .modalPopup
        {
            background-color: #ffffdd;
            border-width: 5px;
            border-style: solid;
            border-color: Gray;
            padding: 10px;
            width: 270px;
        }
        .style9
        {
            width: 375px;
        }
        #rowNote
        {
            width: 344px;
        }
        .style10
        {
            width: 287px;
        }
        .cmnBtn
        {
            height: 26px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentPlaceHolderBody" runat="Server">
    <div id="MaskedDiv1" class="MaskedDiv" runat="server">
    </div>
    <div class="divDailyReport" id="verDiv" runat="server" style="display: none">
        <table width="100%" style="border-style: solid; border-width: 2px; border-color: #7f858b;
            height: auto" cellpadding="0" cellspacing="0">
            <tr style="height: 20px; background-color: #7f858b; color: White; font-size: small">
                <th style="text-align: left; border: 0px" colspan="2">
                    <asp:Label ID="lblReport" runat="server" Text="Daily Report"></asp:Label>
                </th>
            </tr>
            <tr style="height: 20px;">
                <td colspan="2">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td align="left" style="font-weight: bold; color: Black; padding-left: 10px">
                    Paid Date
                </td>
                <td style="padding-left: 50px">
                    <asp:TextBox ID="txtDate" runat="server" Width="150px" CssClass="txtBPR" onblur="setDateFormat(this);" />
                </td>
            </tr>
            <tr id="trTrans" runat="server">
                <td align="left" style="font-weight: bold; color: Black; padding-left: 10px">
                    Transaction Date
                </td>
                <td style="padding-left: 50px">
                    <asp:TextBox ID="txtTransDate" runat="server" Width="150px" CssClass="txtBPR" onblur="setDateFormat(this);" />
                </td>
            </tr>
            <tr>
                <td align="center" style="font-weight: bold; color: White">
                    &nbsp;
                </td>
                <td style="font-weight: bold; color: White">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td style="font-weight: bold; color: White" align="center" colspan="2">
                    <asp:Button ID="btnDailyReportPreview" runat="server" Text="Preview" CssClass="cmnBtn"
                        OnClientClick=" return ShowProcessText(this)" OnClick="btnDailyReportPreview_Click" />&nbsp;
                    <asp:Button ID="btnVerClose" runat="server" Text="Close" CssClass="cmnBtn" OnClientClick="Show();return false;" />
                </td>
            </tr>
            <tr style="height: 5px">
                <td colspan="2">
                </td>
            </tr>
        </table>
    </div>
    <asp:UpdatePanel ID="deductionUpdatePanel" runat="server">
        <ContentTemplate>
            <asp:HiddenField ID="hdnIsSBP" runat="server" Value="0" />
            <asp:HiddenField ID="hdnIsUBI" runat="server" Value="0" />
            <asp:HiddenField ID="hdnReportType" runat="server" Value="1" />
            <asp:HiddenField ID="hdnCurrentPaymentMade" runat="server" Value="0" />
            <asp:HiddenField ID="hdnIsSuperAdmin" runat="server" Value="0" />
            <asp:HiddenField ID="hdnIsChildBranch" runat="server" Value="0" />
            <asp:HiddenField ID="hdnEntryType" runat="server" Value="1" />
            <asp:HiddenField ID="hdnNonDedReason" runat="server" Value="0" />
            <asp:HiddenField ID="hdnDedAmt" runat="server" Value="0" />
            <asp:HiddenField ID="hdnIncludeAmt" runat="server" Value="0" />
            <asp:HiddenField ID="hdnHasMultiplePayment" runat="server" Value="0" />
            <asp:HiddenField ID="hdnExtraPaymentMade" runat="server" Value="0" />
            <asp:HiddenField ID="hdnCurrentDate" runat="server" Value="" />
            <asp:HiddenField ID="hdnPaymentMode" runat="server" Value="-1" />
            <asp:HiddenField ID="hdnMakeTDSFromFirstPayment" runat="server" Value="0" />
            <asp:HiddenField ID="hdnIsValid" runat="server" Value="0" />
            <asp:HiddenField ID="hdnEnable" runat="server" Value="0" />
            <asp:HiddenField ID="hdnFormType" runat="server" />
            <asp:HiddenField ID="hdnLinkID" runat="server" Value="-1" />
            <asp:HiddenField ID="hdnQuarter" runat="server" />
            <asp:HiddenField ID="hdnChallanID" runat="server" Value="-1" />
            <asp:HiddenField ID="hdnNonEmployeeCode" runat="server" />
            <asp:HiddenField ID="hdnChallanCode" runat="server" />
            <asp:HiddenField ID="selectedPageSize" runat="server" />
            <asp:HiddenField ID="hdnIsQuarterLocked" runat="server" Value="0" />
            <asp:HiddenField ID="selectedPageIndex" runat="server" />
            <asp:HiddenField ID="hdnDeducteeID" Value="-1" runat="server" />
            <asp:HiddenField ID="hdnFinYear" Value="-1" runat="server" />
            <asp:HiddenField ID="hdnIsValidPAN" Value="-1" runat="server" />
            <asp:HiddenField ID="hdnIsTran" Value="-1" runat="server" />
            <asp:HiddenField ID="hdnIsEReturnGenerated" Value="N" runat="server" />
            <asp:HiddenField ID="hdnSetColor" runat="server" Value="White" />
            <asp:HiddenField ID="hdnSearch" runat="server" Value="1" />
            <asp:HiddenField ID="hdnIsSearchActive" runat="server" Value="0" />
            <asp:HiddenField ID="hdnIsSearchParameterChanged" runat="server" Value="0" />
            <asp:HiddenField ID="hdnSectionID" runat="server" Value="-1" />
            <asp:HiddenField ID="hdnIsPartPaymentActive" runat="server" Value="0" />
            <asp:HiddenField ID="hdnPartPaymentID" runat="server" Value="-1" />
            <asp:HiddenField ID="hdnDeductionID" runat="server" Value="-1" />
            <asp:HiddenField ID="hdnIT" runat="server" Value="-1" />
            <asp:HiddenField ID="hdnSur" runat="server" Value="-1" />
            <asp:HiddenField ID="hdnEduCess" runat="server" Value="-1" />
            <asp:HiddenField ID="hdnTaxDeducted" runat="server" Value="-1" />
            <asp:HiddenField ID="hdnPaymentMade" runat="server" Value="-1" />
            <asp:HiddenField ID="hdnToBeUnlinked" runat="server" Value="-1" />
            <asp:HiddenField ID="hdnIsChallanModified" runat="server" Value="-1" />
            <asp:HiddenField ID="hdnRoundOff" runat="server" Value="1" />
            <asp:HiddenField ID="hdnIsInvolvedInPP" runat="server" Value="1" />
            <asp:HiddenField ID="hdnAllow92A92B" runat="server" Value="1" />
            <asp:HiddenField ID="hdnDeductorStatus" runat="server" />
            <asp:HiddenField ID="hdnThresholdLimit" runat="server" Value="0" />
            <asp:HiddenField ID="hdnTaxRate" runat="server" Value="0" />
            <asp:HiddenField ID="hdnConTaxRate" runat="server" Value="-1" />
            <asp:HiddenField ID="hdnConLimit" runat="server" Value="" />
            <asp:HiddenField ID="hdnPreviousPaymentMade" runat="server" Value="" />
            <asp:HiddenField ID="hdnReportPaymentID" runat="server" Value="-1" />
            <asp:HiddenField ID="hdnBGLCodeID" runat="server" Value="-1" />
            <asp:HiddenField ID="hdnIsDeductionsIncluded" runat="server" Value="0" />
            <asp:HiddenField ID="hdnTotalPaymentMade" runat="server" Value="-1" />
            <asp:HiddenField ID="hdnBranchInputPageIndex" runat="server" Value="1" />
            <asp:HiddenField ID="hdnBranchInputPageSize" runat="server" Value="10" />
            <asp:HiddenField ID="hdnTDSMade" runat="server" Value="" />
            <asp:HiddenField ID="hdnServiceTax" runat="server" Value="0" />
            <asp:HiddenField ID="hdnExcludeST" runat="server" Value="0" />
            <asp:HiddenField ID="hdnIsThresholdCrossed" runat="server" Value="0" />
            <asp:HiddenField ID="hdnIsConTaxRateCrossed" runat="server" Value="0" />
            <asp:HiddenField ID="hdnIsPaymentDetails" runat="server" Value="0" />
            <asp:HiddenField ID="hdnIsPaymentSearchActive" runat="server" Value="0" />
            <asp:HiddenField ID="hdnPaymentSearch" runat="server" Value="1" />
            <asp:HiddenField ID="hdnSectionIDs" runat="server" Value="" />
            <asp:HiddenField ID="hdnSelectedSectionID" runat="server" Value="" />
            <asp:HiddenField ID="hdnIsCollapse" runat="server" Value="1" />
            <asp:HiddenField ID="hdnCertDetailID" runat="server" Value="-1" />
            <asp:HiddenField ID="hdnIsSecDeductionsIncluded" runat="server" Value="0" />
            <asp:HiddenField ID="hdnITRate" runat="server" Value="0" />
            <asp:HiddenField ID="hdnPAN" runat="server" Value="" />
            <asp:HiddenField ID="hdnIsUCO" runat="server" Value="" />
            <asp:HiddenField ID="hdnIsCBI" runat="server" Value="0" />
            <asp:HiddenField ID="hdnIsBranchAdmin" runat="server" Value="0" />
            <asp:HiddenField ID="hdnIsAutoGenChallan" runat="server" Value="0" />
            <asp:HiddenField ID="hdnAvlChallanAmt" runat="server" Value="0" />
            <asp:HiddenField ID="hdnNewBranchIDAB" runat="server" Value="0" />
            <asp:HiddenField ID="hdnChallanQuarter" runat="server" Value="0" />
            <asp:HiddenField ID="hdnCustReferenceNo" runat="server" Value="0" />
            <asp:MultiView ID="mvDeduction" runat="server" ActiveViewIndex="0">
                <asp:View ID="vwDeduction" runat="server" OnActivate="vwDeduction_Activate">
                    <cc1:CollapsiblePanelExtender ID="pnlChallanCollapsible" runat="server" CollapseControlID="pnlChallanHeader"
                        CollapsedText="Show" CollapsedImage="~/App_Themes/Standard/Images/collapse.png"
                        ImageControlID="imgToggle" Collapsed="false" ExpandControlID="pnlChallanHeader"
                        ExpandedText="Hide" ExpandDirection="Vertical" TargetControlID="pnlChallan" ExpandedImage="~/App_Themes/Standard/Images/expand.png">
                    </cc1:CollapsiblePanelExtender>
                    <cc1:CollapsiblePanelExtender ID="pnlDetailsCollapsible" runat="server" CollapseControlID="pnlDetailsHead"
                        CollapsedText="Show" CollapsedImage="~/App_Themes/Standard/Images/collapse.png"
                        ImageControlID="ImgToggleDetails" Collapsed="false" ExpandControlID="pnlDetailsHead"
                        ExpandedText="Hide" ExpandDirection="Vertical" TargetControlID="pnlMoreDetails"
                        ExpandedImage="~/App_Themes/Standard/Images/expand.png">
                    </cc1:CollapsiblePanelExtender>
                    <table class="nTbl">
                        <tr>
                            <td valign="top">
                                <table class="nTbl">
                                    <tr>
                                        <td valign="top" style="margin-left: 0px" class="style9">
                                            <table class="eCol" cellpadding="0">
                                                <tr>
                                                    <td class="vHCol">
                                                        Serial No.
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtSerialNo" runat="server" ReadOnly="true" Style="background-color: #d5dadd;
                                                            color: Black;" CssClass="txtBPL"> </asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="vHCol">
                                                        Name
                                                    </td>
                                                    <td class="iCol" style="width: 195px">
                                                        <asp:TextBox ID="txtName" Width="195px" runat="server" onkeyup="ClearDeducteeName()"
                                                            CssClass="txtBML" TabIndex="1" onkeypress="return ValidateDelimiter(this,event);"></asp:TextBox>
                                                        <cc1:AutoCompleteExtender ID="autoCompleteExtender" runat="server" MinimumPrefixLength="2"
                                                            ServicePath="~/WebServices/AutoCompleteService.asmx" TargetControlID="txtName"
                                                            CompletionInterval="700" EnableCaching="false" CompletionSetCount="20" DelimiterCharacters=""
                                                            ShowOnlyCurrentWordInCompletionListItem="true" FirstRowSelected="True" OnClientItemSelected="GetDeducteeNameValue">
                                                        </cc1:AutoCompleteExtender>
                                                    </td>
                                                </tr>
                                                <tr runat="server" id="rowSection">
                                                    <td class="vHCol">
                                                        <asp:Label ID="lblSection" runat="server" Text="Section"></asp:Label>
                                                    </td>
                                                    <td class="iCol">
                                                        <asp:DropDownList ID="ddlSection" runat="server" AutoPostBack="true" CssClass="mdropDownList"
                                                            Width="175px" TabIndex="2" Font-Size="9" OnSelectedIndexChanged="ddlSection_SelectedIndexChanged">
                                                        </asp:DropDownList>
                                                        <asp:Button ID="btnSectionHelp" runat="server" Text="?" OnClientClick="ShowSectionHelp();return false;"
                                                            CssClass="cmnBtn" Height="20px" Width="20px" />
                                                    </td>
                                                </tr>
                                                <tr runat="server" id="rowBGLCode">
                                                    <td class="vHCol">
                                                        <asp:Label ID="lblBGLCodeDescription" runat="server" Text="BGLCode"></asp:Label>
                                                    </td>
                                                    <td class="iCol">
                                                        <asp:Label ID="lblBGLCode" runat="server" Text=""></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr id= "trAmtCashDrawn" runat ="server" visible="false">
                                                    <td class="vHCol">
                                                        Amount of Cash Withdrawal
                                                    </td>
                                                    <td class="iCol">
                                                        <asp:TextBox ID="txtAmtCashDrawn" runat="server" MaxLength="14" AutoComplete="Off"
                                                            onchange="return checkDecimalNo(this);" onkeypress="return numeralsOnly(this, event,11,2,0,1);"
                                                            onkeyup="CalculateValues()" onBlur="ClearAOP(this);" TabIndex="3" CssClass="txtBMR"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="vHCol">
                                                        Amount of Payment
                                                    </td>
                                                    <td class="iCol">
                                                        <asp:TextBox ID="txtAmountOfPayment" runat="server" MaxLength="14" AutoComplete="Off"
                                                            onchange="return checkDecimalNo(this);" onkeypress="return numeralsOnly(this, event,11,2,0,1);"
                                                            onkeyup="CalculateValues()" onBlur="ClearAOP(this);" TabIndex="3" CssClass="txtBMR"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr runat="server" id="rowForm27EDeductedDate">
                                                    <td class="vHCol">
                                                        Total Value of Pur.(s)
                                                    </td>
                                                    <td class="iCol">
                                                        <asp:TextBox ID="txtTotalValueOfPurchase" runat="server" MaxLength="14" AutoComplete="Off"
                                                            onchange="return checkDecimalNo(this);" onkeypress="return numeralsOnly(this, event,11,2,0,1);"
                                                            onkeyup="CalculateValues()" onBlur="ClearAOP(this);" TabIndex="3" CssClass="txtBMR"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="vHCol">
                                                        <asp:Label ID="lblpaidDate" runat="server" Text="Paid/Credited Date"></asp:Label>
                                                    </td>
                                                    <td class="iCol">
                                                        <asp:TextBox ID="txtCreditedDate" ToolTip="Enter Date (Format: DD/MM/YYYY or DD MM YYYY)"
                                                            runat="server" Width="195px" BackColor="#E5E5E5" AutoComplete="Off" CssClass="txtBPR"
                                                            TabIndex="4" onBlur="setDateFormat(this);SetDeductedDate();"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="vHCol">
                                                        <asp:Label ID="lblIncomeTaxPercAndAmnt" runat="server" Text="Income Tax(% and Amt)"> </asp:Label>
                                                    </td>
                                                    <td style="width: 199px">
                                                        <table width="199px" cellpadding="0" cellspacing="0" border="0">
                                                            <tr style="width: 199px">
                                                                <td width="85px" class="iCol">
                                                                    <asp:TextBox ID="txtITRate" Style="border: 1px solid #9f9f9f; width: 50px; text-align: right"
                                                                        AutoComplete="Off" runat="server" MaxLength="14" onchange="return checkDecimalNo(this);"
                                                                        onkeypress="return numeralsOnly(this, event,2,3,0,1);" onkeyup="CalculateValues()"
                                                                        onBlur="SetDeductedDate();" TabIndex="5" CssClass="txtBPL"></asp:TextBox>
                                                                </td>
                                                                <td width="127px" align="left">
                                                                    <asp:TextBox ID="txtIncomeTaxAmount" Style="border: 1px solid #9f9f9f; width: 133px;
                                                                        text-align: right" AutoComplete="Off" runat="server" MaxLength="14" Enabled="true"
                                                                        onchange="return checkDecimalNo(this);" onkeypress="return numeralsOnly(this, event,11,2,0,1);"
                                                                        onkeyup="CalculateValues();" onBlur="DoRoundOff();SetDeductedDate();" TabIndex="6"
                                                                        CssClass="txtBPL"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="vHCol">
                                                        Surcharge (% and Amt)
                                                    </td>
                                                    <td style="width: 199px">
                                                        <table width="199px" cellpadding="0" cellspacing="0" style="padding: 0px">
                                                            <tr style="width: 199px">
                                                                <td width="85px" class="iCol">
                                                                    <asp:TextBox ID="txtSurchargeRate" runat="server" Style="border: 1px solid #9f9f9f;
                                                                        width: 50px; text-align: right" AutoComplete="Off" TabIndex="7" MaxLength="14"
                                                                        onchange="return checkDecimalNo(this);" onkeypress="return numeralsOnly(this, event,2,3,0,1);"
                                                                        onkeyup="CalculateValues()" onBlur="DoRoundOff();" CssClass="txtBPL"></asp:TextBox>
                                                                </td>
                                                                <td width="127px">
                                                                    <asp:TextBox ID="txtSurchargeAmount" runat="server" Style="border: 1px solid #9f9f9f;
                                                                        width: 133px; text-align: right" AutoComplete="Off" TabIndex="8" MaxLength="14"
                                                                        Enabled="false" onchange="return checkDecimalNo(this);" onkeypress="return numeralsOnly(this, event,11,2,0,1);"
                                                                        onkeyup="CalculateValues()" CssClass="txtBPL"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="vHCol">
                                                        Edu Cess (% and Amt)
                                                    </td>
                                                    <td style="width: 199px">
                                                        <table width="199px" cellpadding="0" cellspacing="0">
                                                            <tr style="width: 199px">
                                                                <td width="85px" class="iCol">
                                                                    <asp:TextBox ID="txtEduCessRate" runat="server" Style="border: 1px solid #9f9f9f;
                                                                        width: 50px; text-align: right" AutoComplete="Off" MaxLength="14" onchange="return checkDecimalNo(this);"
                                                                        onkeypress="return numeralsOnly(this, event,2,3,0,1);" onkeyup="CalculateValues()"
                                                                        onBlur="DoRoundOff();" TabIndex="9" CssClass="txtBPL"></asp:TextBox>
                                                                </td>
                                                                <td width="129px">
                                                                    <asp:TextBox ID="txtEduCessAmount" runat="server" Style="border: 1px solid #9f9f9f;
                                                                        width: 133px; text-align: right" AutoComplete="Off" TabIndex="10" MaxLength="14"
                                                                        onchange="return checkDecimalNo(this);" onkeypress="return numeralsOnly(this, event,11,2,0,1);"
                                                                        onkeyup="CalculateValues()" CssClass="txtBPL"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="vHCol">
                                                        <table class="vHCol" cellpadding="0" cellspacing="0">
                                                            <tr>
                                                                <td valign="top">
                                                                    <asp:Label ID="lblTaxDeducted" runat="server" Text="Tax Deducted"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:CheckBox ID="chkEdit" Text="Edit" runat="server" TabIndex="11" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td style="width: 199px">
                                                        <table width="199px" cellpadding="0" cellspacing="0">
                                                            <tr style="width: 199px">
                                                                <td width="85px" class="iCol ">
                                                                    <asp:TextBox ID="txtTaxDeductedRate" runat="server" MaxLength="14" CssClass="txtboxRO"
                                                                        AutoComplete="Off" Style="width: 50px;" Enabled="false"></asp:TextBox>
                                                                </td>
                                                                <td width="130">
                                                                    <asp:TextBox ID="txtTaxDeducted" runat="server" AutoComplete="Off" CssClass="txtboxRO"
                                                                        Style="width: 132px; text-align: right" MaxLength="14" Enabled="false"> </asp:TextBox>
                                                                </td>
                                                            </tr>                                                            
                                                        </table>
                                                    </td>
                                                </tr>
                                                <table cellpadding="0" cellspacing="0" runat=server id="rowNote" visible=false>
                                                    <caption>
                                                        <tr runat="server">
                                                            <td colspan="4">
                                                                <br />
                                                                <asp:Label ID="lblStaffPensionerNote" runat="server" Font-Bold="true" 
                                                                    Font-Size="Larger" ForeColor="Red" 
                                                                    Text="NOTE : Enter Deductions of Staff Pensioner only" Width="300px" />                                                                
                                                            </td>
                                                        </tr>
                                                    </caption>
                                                </table>
                                                <tr id="rowCreatedOn" runat="server" style="display: none">
                                                    <td class="style9" colspan=2>
                                                        <table class="vHCol" cellpadding="0" cellspacing="0">
                                                            <tr>
                                                                <td valign="top">
                                                                    <asp:Label ID="Label12" runat="server" Text="Created On : "></asp:Label>
                                                                    <asp:Label ID="lblCreatedOn" runat="server" Text="" Font-Bold="true" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr runat="server" id="rowSecondDeduction" style="display: none">
                                                    <td colspan="2" class="style9">
                                                        <table>
                                                            <tr>
                                                                <td>
                                                                    <div class="dHeader">
                                                                        Details for Second Deduction</div>
                                                                    <div style="border: solid 1px gray">
                                                                        <table>
                                                                            <tr>
                                                                                <td class="vHCol">
                                                                                    Amount of Payment
                                                                                </td>
                                                                                <td class="iCol">
                                                                                    <asp:TextBox ID="txtPaymentMade" runat="server" CssClass="txtBMR"></asp:TextBox>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td class="vHCol">
                                                                                    Rate (% and Amt)
                                                                                </td>
                                                                                <td class="iCol">
                                                                                    <table width="199px" cellpadding="0" cellspacing="0" border="0">
                                                                                        <tr style="width: 199px">
                                                                                            <td width="85px" class="iCol">
                                                                                                <asp:TextBox ID="txtRate" Style="border: 1px solid #9f9f9f; width: 50px; text-align: right"
                                                                                                    runat="server" TabIndex="5" CssClass="txtBPL"></asp:TextBox>
                                                                                            </td>
                                                                                            <td width="127px" align="left">
                                                                                                <asp:TextBox ID="txtRateAmount" Style="border: 1px solid #9f9f9f; width: 133px; text-align: right"
                                                                                                    runat="server" TabIndex="6" CssClass="txtBPL"></asp:TextBox>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </td>
                                                                            </tr>
                                                                            <tr runat="server" id="rowSecDedSurcharge">
                                                                                <td class="vHCol">
                                                                                    Surcharge (% and Amt)
                                                                                </td>
                                                                                <td style="width: 199px">
                                                                                    <table width="199px" cellpadding="0" cellspacing="0" style="padding: 0px">
                                                                                        <tr style="width: 199px">
                                                                                            <td width="85px" class="iCol">
                                                                                                <asp:TextBox ID="txtSecSurchargeRate" runat="server" Style="border: 1px solid #9f9f9f;
                                                                                                    width: 50px; text-align: right" AutoComplete="Off" TabIndex="7" MaxLength="14"
                                                                                                    Enabled="false" onchange="return checkDecimalNo(this);" onkeypress="return numeralsOnly(this, event,2,3,0,1);"
                                                                                                    onkeyup="CalculateValues()" onBlur="DoRoundOff();" CssClass="txtBPL"></asp:TextBox>
                                                                                            </td>
                                                                                            <td width="127px">
                                                                                                <asp:TextBox ID="txtSecSurchargeAmount" runat="server" Style="border: 1px solid #9f9f9f;
                                                                                                    width: 133px; text-align: right" AutoComplete="Off" TabIndex="8" MaxLength="14"
                                                                                                    Enabled="false" onchange="return checkDecimalNo(this);" onkeypress="return numeralsOnly(this, event,11,2,0,1);"
                                                                                                    onkeyup="CalculateValues()" CssClass="txtBPL"></asp:TextBox>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </td>
                                                                            </tr>
                                                                            <tr id="rowSecDedEduCess" runat="server">
                                                                                <td class="vHCol">
                                                                                    Edu Cess (% and Amt)
                                                                                </td>
                                                                                <td style="width: 199px">
                                                                                    <table width="199px" cellpadding="0" cellspacing="0">
                                                                                        <tr style="width: 199px">
                                                                                            <td width="85px" class="iCol">
                                                                                                <asp:TextBox ID="txtSecEduCessRate" runat="server" Style="border: 1px solid #9f9f9f;
                                                                                                    width: 50px; text-align: right" AutoComplete="Off" MaxLength="14" onchange="return checkDecimalNo(this);"
                                                                                                    Enabled="false" onkeypress="return numeralsOnly(this, event,2,3,0,1);" onkeyup="CalculateValues()"
                                                                                                    onBlur="DoRoundOff();" TabIndex="9" CssClass="txtBPL"></asp:TextBox>
                                                                                            </td>
                                                                                            <td width="129px">
                                                                                                <asp:TextBox ID="txtSecEduCessAmount" runat="server" Style="border: 1px solid #9f9f9f;
                                                                                                    width: 133px; text-align: right" AutoComplete="Off" TabIndex="10" MaxLength="14"
                                                                                                    Enabled="false" onchange="return checkDecimalNo(this);" onkeypress="return numeralsOnly(this, event,11,2,0,1);"
                                                                                                    onkeyup="CalculateValues()" CssClass="txtBPL"></asp:TextBox>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td class="vHCol">
                                                                                    <table class="vHCol" cellpadding="0" cellspacing="0">
                                                                                        <tr>
                                                                                            <td valign="top">
                                                                                                <asp:Label ID="lblSecTaxDeducted" runat="server" Text="Tax Deducted"></asp:Label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:CheckBox ID="chkSecEdit" Text="Edit" runat="server" TabIndex="11" />
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </td>
                                                                                <td style="width: 199px">
                                                                                    <table width="199px" cellpadding="0" cellspacing="0">
                                                                                        <tr style="width: 199px">
                                                                                            <td width="85px" class="iCol ">
                                                                                                <asp:TextBox ID="txtSecTaxDeductedRate" runat="server" MaxLength="14" CssClass="txtboxRO"
                                                                                                    AutoComplete="Off" Style="width: 50px;" Enabled="false"></asp:TextBox>
                                                                                            </td>
                                                                                            <td width="130">
                                                                                                <asp:TextBox ID="txtSecTaxDeducted" runat="server" AutoComplete="Off" CssClass="txtboxRO"
                                                                                                    Style="width: 132px; text-align: right" MaxLength="14" Enabled="false"> </asp:TextBox>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td class="vHCol">
                                                                                    Net Amount Payable
                                                                                </td>
                                                                                <td class="iCol">
                                                                                    <asp:TextBox ID="txtPayable" runat="server" CssClass="txtBMR"></asp:TextBox>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td class="eCol" valign="top">
                                            <table>
                                                <tr>
                                                    <td class="vHCol">
                                                        <asp:Label ID="lblDeductedDate" Text="Tax Deducted Date" runat="server"></asp:Label>
                                                    </td>
                                                    <td class="iCol">
                                                        <asp:TextBox ID="txtTaxDedDate" ToolTip="Enter Date (Format: DD/MM/YYYY or DD MM YYYY)"
                                                            runat="server" BackColor="#E5E5E5" onBlur="setDateFormat(this);" CssClass="txtBPR"
                                                            TabIndex="12" AutoComplete="Off"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr runat="server" id="rowForm27ECertDate">
                                                    <td class="vHCol">
                                                        <asp:Label ID="lblCertDate" Text="TCS Cert. Date" runat="server"></asp:Label>
                                                    </td>
                                                    <td class="iCol">
                                                        <asp:TextBox ID="txtCertDate" ToolTip="Enter Date (Format: DD/MM/YYYY or DD MM YYYY)"
                                                            runat="server" BackColor="White" onBlur="setDateFormat(this);" CssClass="txtBPR"
                                                            TabIndex="12" AutoComplete="Off"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                    </td>
                                                    <td class="iCol">
                                                        <asp:CheckBox ID="chkBookEntry" runat="server" Text="Book Entry" TabIndex="13" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="vHCol">
                                                        <asp:Label ID="lblNonDedReason" runat="server" Text=""></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlNonDeductionReason" runat="server" Width="200" Font-Size="9"
                                                            CssClass="dropDownList" TabIndex="16" OnChange="SetNonDedReason();">
                                                        </asp:DropDownList>
                                                        <div id="tooltip">
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr runat="server" id="tdGetUIN" style="display: none">
                                                    <td>
                                                        <asp:LinkButton ID="lnkGetUIN" runat="server" Text="Get UIN" Font-Bold="true" OnClick="lnkGetUIN_Click"></asp:LinkButton>
                                                    </td>
                                                    <td>
                                                    </td>
                                                </tr>
                                                <tr runat="server" id="rowCertNo">
                                                    <td class="vHCol">
                                                        <asp:Label ID="Label17" runat="server" Text="U/s 197 Cert. No."></asp:Label>
                                                    </td>
                                                    <td class="iCol">
                                                        <asp:TextBox ID="txtCertNo" runat="server" TabIndex="16" CssClass="txtBPL" MaxLength="20"
                                                            onBlur="ConvertToUC(this);" onkeypress="return ValidateForAlphaNumeric(event);">
                                                        </asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="vHCol">
                                                        <asp:Label ID="lblGrossingUpIndicator" runat="server" Text="Grossing up Indicator"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlGrossingUpIndicator" runat="server" Width="200" TabIndex="17"
                                                            CssClass="dropDownList">
                                                            <asp:ListItem Text="Yes" Value="True"> </asp:ListItem>
                                                            <asp:ListItem Text="No" Value="False"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr runat="server" id="rowReferenceNo">
                                                    <td class="vHCol">
                                                        <asp:Label ID="lblReferenceNo" runat="server" Text="Reference No" Visible="false"></asp:Label>
                                                    </td>
                                                    <td class="iCol">
                                                        <asp:TextBox ID="txtReferenceNo" runat="server" TabIndex="16" CssClass="txtBPL" MaxLength="20"
                                                            Visible="false" onBlur="ConvertToUC(this);" onkeypress="return ValidateForAlphaNumeric(event);">
                                                        </asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2" width="100%">
                                                        <asp:Panel ID="PnlResidentDetails" runat="server" CssClass="dialog" Style="border-top-width: 0px"
                                                            Visible="false">
                                                            <div style="padding: 10px; border-top: solid 1px gray" id="Div1" runat="server">
                                                                <table>
                                                                    <tr>
                                                                        <td class="vHCol" width="355px">
                                                                            Deductee is Non-Resident
                                                                        </td>
                                                                        <td class="iCol" style="padding-left: 5px">
                                                                            <asp:DropDownList ID="ddlDedNonRes" runat="server" CssClass="mdropDownList" Width="100px"
                                                                                OnSelectedIndexChanged="ddlDedNonRes_SelectedIndexChanged" AutoPostBack="true">
                                                                                <asp:ListItem Text="Select" Value=""></asp:ListItem>
                                                                                <asp:ListItem Text="Yes" Value="Y"></asp:ListItem>
                                                                                <asp:ListItem Text="No" Value="N"></asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td width="355px">
                                                                            Deductee is having Permanent Establishment in India
                                                                        </td>
                                                                        <td class="iCol" style="padding-left: 5px">
                                                                            <asp:DropDownList ID="ddlDedPerEstaIndia" runat="server" CssClass="dropDownList"
                                                                                Width="100px">
                                                                                <asp:ListItem Text="Select" Value=""></asp:ListItem>
                                                                                <asp:ListItem Text="Yes" Value="Y"></asp:ListItem>
                                                                                <asp:ListItem Text="No" Value="N"></asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                        </asp:Panel>
                                                    </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2" width="100%">
                                                            <asp:Panel runat="server" CssClass="dHeader" ID="pnlDetailsHead" Style="cursor: hand">
                                                                More Details
                                                                <asp:Image ID="ImgToggleDetails" runat="server" Style="margin-left: 228px; cursor: hand" />
                                                            </asp:Panel>
                                                            <asp:Panel ID="pnlMoreDetails" runat="server" CssClass="dialog" Style="border-top-width: 0px">
                                                                <div style="padding: 10px; border-top: solid 1px gray" id="Div2" runat="server">
                                                                    <table>
                                                                        <tr>
                                                                            <td>
                                                                                TDS Rate as per
                                                                            </td>
                                                                            <td class="iCol">
                                                                                <asp:DropDownList ID="ddlRateType" runat="server" TabIndex="16" CssClass="dropDownList"
                                                                                    Width="200px">
                                                                                    <asp:ListItem Text="Select" Value="-1"></asp:ListItem>
                                                                                    <asp:ListItem Text="IT Act" Value="A"></asp:ListItem>
                                                                                    <asp:ListItem Text="DTAA" Value="B"></asp:ListItem>
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td width="130px">
                                                                                15CA Ack. No.
                                                                            </td>
                                                                            <td class="iCol">
                                                                                <asp:TextBox ID="txtAckNo" runat="server" TabIndex="16" CssClass="txtBPL" MaxLength="15"
                                                                                    onkeypress="return ValidateForAlphaNumeric(event);" onBlur="ConvertToUC(this);">
                                                                                </asp:TextBox>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                Nature of Remittance
                                                                            </td>
                                                                            <td class="iCol">
                                                                                <asp:DropDownList ID="ddlNatureofRemittance" runat="server" TabIndex="16" CssClass="mdropDownList"
                                                                                    Width="200px">
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                Country of Residence
                                                                            </td>
                                                                            <td class="iCol">
                                                                                <asp:DropDownList ID="ddlCountries" runat="server" TabIndex="16" CssClass="mdropDownList"
                                                                                    Width="200px">
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                Deductee Email
                                                                            </td>
                                                                            <td class="iCol">
                                                                                <asp:TextBox ID="txtEmailDed" runat="server" TabIndex="16" CssClass="txtBPL" MaxLength="75"
                                                                                    onchange="return checkValidEmail(this);">
                                                                                </asp:TextBox>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                Deductee Contact No.
                                                                            </td>
                                                                            <td class="iCol">
                                                                                <asp:TextBox ID="txtContactNoDed" runat="server" TabIndex="16" CssClass="txtBPL"
                                                                                    MaxLength="15" onchange="return checkValidContactNo(this);">
                                                                                </asp:TextBox>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                Deductee Address
                                                                            </td>
                                                                            <td class="iCol">
                                                                                <asp:TextBox ID="txtAddressDed" runat="server" TabIndex="16" CssClass="txtBPL" MaxLength="150"
                                                                                    onchange="return checkValidDedAddress(this);">
                                                                                </asp:TextBox>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                Deductee Identification No.
                                                                            </td>
                                                                            <td class="iCol">
                                                                                <asp:TextBox ID="txtIdentNumDed" runat="server" TabIndex="16" CssClass="txtBPL" MaxLength="25"
                                                                                    onchange="return InputValidationsForIdentNum(this);">
                                                                                </asp:TextBox>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                            </asp:Panel>
                                                        </td>
                                                </tr>
                                                <tr runat="server" id="divChallanDetail">
                                                    <td colspan="2" width="100%">
                                                        <asp:Panel ID="pnlChallanHeader" runat="server" CssClass="dHeader" Style="cursor: hand">
                                                            Challan Details
                                                            <asp:Image ID="imgToggle" runat="server" Style="margin-left: 215px; cursor: hand" />
                                                        </asp:Panel>
                                                        <asp:Panel ID="pnlChallan" runat="server" CssClass="dialog" Style="border-top-width: 0px">
                                                            <div style="padding: 10px; border-top: solid 1px gray" id="challanDiv" runat="server">
                                                                <table>
                                                                    <tr>
                                                                        <td>
                                                                            Part Payment
                                                                        </td>
                                                                        <td style="padding-left: 32px">
                                                                            <table>
                                                                                <tr>
                                                                                    <td>
                                                                                        <asp:CheckBox ID="chkPartPayment" runat="server" OnClick="EnableDisablePP();" />
                                                                                    </td>
                                                                                    <td style="width: 150px">
                                                                                        <asp:Button ID="btnPartPayment" runat="server" CssClass="cmnBtn" Style="width: 150px;"
                                                                                            OnClientClick="return ValidateForPP();" Text="Part Payment Details" OnClick="btnPartPayment_Click" />
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td width="130px">
                                                                            Serial No.
                                                                        </td>
                                                                        <td style="padding-left: 32px">
                                                                            <table>
                                                                                <tr>
                                                                                    <td>
                                                                                        <asp:DropDownList ID="ddlQuarter" runat="server" Enabled="false" AutoPostBack="true"
                                                                                            CssClass="dropDownList" Width="75px" TabIndex="14" OnSelectedIndexChanged="ddlQuarter_SelectedIndexChanged">
                                                                                        </asp:DropDownList>
                                                                                    </td>
                                                                                    <td>
                                                                                        <asp:TextBox ID="txtChallanSlNo" runat="server" Enabled="false" TabIndex="15" Width="90px"
                                                                                            onkeypress="return ValidateForOnlyNos(event);" onkeyup="ClearChallanSlNo(1);"
                                                                                            OnBlur="return GetDetails(this);" CssClass="txtBPL"></asp:TextBox>
                                                                                        <cc1:AutoCompleteExtender ID="challanSlNoAutoCompleteExtender" runat="server" MinimumPrefixLength="1"
                                                                                            ServicePath="~/WebServices/AutoCompleteService.asmx" TargetControlID="txtChallanSlNo"
                                                                                            ServiceMethod="GetChallanSlNosForAutoComplete" CompletionInterval="700" EnableCaching="false"
                                                                                            CompletionSetCount="20" DelimiterCharacters="" ShowOnlyCurrentWordInCompletionListItem="true"
                                                                                            FirstRowSelected="True" OnClientItemSelected="GetChallanSlNoValue">
                                                                                        </cc1:AutoCompleteExtender>
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            Challan/Vou No.
                                                                            <br />
                                                                            &amp; Date
                                                                        </td>
                                                                        <td style="padding-left: 28px">
                                                                            <table style="margin: 0px; padding: 0px" cellpadding="0px" cellspacing="0px">
                                                                                <tr>
                                                                                    <td width="20%" class="iCol" style="padding-left: 4px">
                                                                                        <asp:TextBox ID="txtChallanNo" runat="server" CssClass="txtboxRO" Style="width: 92px;
                                                                                            text-align: right" Enabled="false"> </asp:TextBox>
                                                                                    </td>
                                                                                    <td width="80%">
                                                                                        <asp:TextBox ID="txtChallanDate" runat="server" CssClass="txtboxRO" Style="width: 80px;
                                                                                            text-align: right" Enabled="false"> </asp:TextBox>
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            Total Amount
                                                                        </td>
                                                                        <td class="iCol" style="padding-left: 32px">
                                                                            <asp:TextBox ID="txtTotalAmount" runat="server" MaxLength="14" CssClass="txtboxRO"
                                                                                Style="width: 177px;" Enabled="false"> </asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                        </asp:Panel>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2" width="100%">
                                                        <div style="padding-bottom: 3px" id="divBranchInput" runat="server">
                                                            <div class="dialog" style="width: 100%;">
                                                                <div class="dHeader">
                                                                    Branch Input Details</div>
                                                                <div style="padding: 10px; border-top: solid 1px gray">
                                                                    <table>
                                                                        <tr>
                                                                            <td class="style2">
                                                                                Account Number
                                                                            </td>
                                                                            <td style="text-align: right">
                                                                                <asp:TextBox ID="txtAccNum" runat="server" Text="" CssClass="txtBPL" Width="150px"></asp:TextBox>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="style2">
                                                                                IFSC Code
                                                                            </td>
                                                                            <td style="text-align: right">
                                                                                <asp:TextBox ID="txtCode" runat="server" Text="" CssClass="txtBPL" Width="150px"></asp:TextBox>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="style2">
                                                                                Bank Name / Branch Name
                                                                            </td>
                                                                            <td class="iCol" style="text-align: right">
                                                                                <asp:TextBox ID="txtBankBranchName" runat="server" Text="" CssClass="txtBPL" Width="150px"></asp:TextBox>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="style2">
                                                                                Amount excluding Service Tax
                                                                            </td>
                                                                            <td style="text-align: right" valign="top">
                                                                                <asp:TextBox ID="txtExcludingTax" runat="server" Text="" CssClass="txtBPL" Width="150px"></asp:TextBox>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="style2">
                                                                                Service Tax Amount
                                                                            </td>
                                                                            <td class="iCol" style="text-align: right">
                                                                                <asp:TextBox ID="txtServiceTax" runat="server" Text="" CssClass="txtBPL" Width="150px"></asp:TextBox>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="style2">
                                                                                Net Amount Payable
                                                                            </td>
                                                                            <td class="iCol" style="text-align: right">
                                                                                <asp:TextBox ID="txtNetPayable" runat="server" Text="" CssClass="txtBPL" Width="150px"></asp:TextBox>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="style2">
                                                                                S.T. Reg No.
                                                                            </td>
                                                                            <td class="iCol" style="text-align: right">
                                                                                <asp:TextBox ID="txtRegNo" runat="server" Text="" CssClass="txtBPL" Width="150px"></asp:TextBox>
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
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td id="rwNote" runat="server" visible="false" valign=top style="width:380px">
                                            <span><b>Note : &nbsp</b></span>
                                            <asp:Label ID="lblmsg" runat="server" Text="" Style="color: Blue;"></asp:Label>
                                        </td>
                                        <td id="rowAccNo" runat=server visible=false style="padding-bottom: 10px" 
                                            align=left class="style10">
                                            <span><b><asp:Label ID="lblAccNoHeader" runat="server" Text="" Style="color: Black;"></asp:Label> &nbsp </b></span>
                                            <asp:Label ID="lblAccNo" runat="server" Text="" Style="color: Blue;"></asp:Label>
                                            <div id="AdditionalAcInfo" runat=server visible=false>
                                                <div>
                                                    <span><b><asp:Label ID="lblCustomerIDHead" runat="server" Text="Customer ID : " Style="color: Black;"></asp:Label> &nbsp </b></span>
                                                    <asp:Label ID="lblCustomerID" runat="server" Text="" Style="color: Blue;"></asp:Label>
                                                </div>
                                                <div id="SubAdditionalAcInfo" runat=server visible=false>
                                                    <span><b><asp:Label ID="lblURNHead" runat="server" Text="Unique Ref No : " Style="color: Black;"></asp:Label> &nbsp </b></span>
                                                    <asp:Label ID="lblURN" runat="server" Text="" Style="color: Blue;"></asp:Label>
                                                </div>
                                                <br />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td id="rowCorrRequest" runat="server" visible="false" valign=bottom colspan="1">
                                            Correction Type
                                            <asp:DropDownList ID="ddlGrievanceAddress" runat="server" BackColor="#E5E5E5" CssClass="dropDownList" Width="150px">
                                            <asp:ListItem Text="Select" Value="-1"></asp:ListItem>
                                            <asp:ListItem Text="PAN Update" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="Deduction Modification" Value="2"></asp:ListItem>
                                            <asp:ListItem Text="Deduction Delete" Value="4"></asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:Button ID="btnCorrRequest" Text="Send Request" runat="server" CssClass="cmnBtn" Width="90px"
                                            onClick="btnCorrRequest_Click" />
                                        </td>                                        
                                    </tr>
                                    <tr>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td valign=bottom>                                            
                                            <asp:Button ID="btnNew" Text="New" runat="server" CssClass="cmnBtn" Width="70px"
                                                UseSubmitBehavior="false" TabIndex="19" OnClick="btnNew_Click" />
                                            <asp:Button ID="btnSave" Text="Save" OnClientClick="javascript:return Validations();"
                                                OnClick="btnSave_Click" runat="server" CssClass="cmnBtn" Width="70px" TabIndex="18" />
                                            <asp:Button ID="btnBranchInput" runat="server" Text="Select Payment" TabIndex="20"
                                                Width="120px" CssClass="cmnBtn" OnClick="btnBranchInput_Click" />
                                            <asp:Button ID="btnOpenSearch" runat="server" Text="Search" TabIndex="20" OnClick="btnOpenSearch_Click"
                                                CssClass="cmnBtn" />
                                            <asp:Button ID="btnReport" runat="server" Text="Report" CssClass="cmnBtn" OnClick="btnReport_Click" />
                                            <asp:Button ID="btnDailyReport" runat="server" Text="Daily Report" CssClass="cmnBtn"
                                                OnClientClick="return SetDate(1);" />
                                            <asp:Button ID="btnCBSFile" runat="server" Text="CBS File" CssClass="cmnBtn" OnClientClick="return SetDate(2);" />
                                        </td>
                                    </tr>
                                    <tr id="trCBS" runat="server" style="display: block">
                                        <td style="padding-left: 10px" align="right" colspan="2">
                                            <asp:HyperLink ID="hlinkDownloadSkippedFile" runat="server" Target="_blank" Font-Bold="false"
                                                Font-Underline="true" Visible="false" ForeColor="Green" ToolTip="click here to download CBS transaction file">Download Skipped Deduction(s)</asp:HyperLink>&nbsp;&nbsp
                                            <asp:HyperLink ID="hlinkDownloadFile" runat="server" Target="_blank" Font-Bold="false"
                                                Font-Underline="true" Visible="false" ForeColor="Green" ToolTip="click here to download CBS transaction file">Download CBS File</asp:HyperLink>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding-left: 10px">
                                            <asp:Label ID="lblNote" runat="server" Visible="false" ForeColor="#0000CC" Width="400px"></asp:Label>
                                        </td>
                                        <td style="padding-left: 10px" class="style10">
                                            <asp:Label ID="lblBulk" runat="server" Visible="false" ForeColor="#0000CC"></asp:Label>
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
                                            <td colspan="2">
                                                Serial No.
                                            </td>
                                            <td colspan="3">
                                                <asp:TextBox ID="txtSearchDedSerialNo" runat="server" Width="186px" TabIndex="20"
                                                    CssClass="txtBPL" onkeypress="return numeralsOnly(this, event,11,2,0,1);" MaxLength="75"
                                                    onchange="ParameterChanged();"></asp:TextBox>
                                            </td>
                                            <td style="width: 25px">
                                            </td>
                                            <td colspan="2">
                                                <asp:Label ID="lblSearchSection" Text="Section" runat="server"></asp:Label>
                                            </td>
                                            <td colspan="3">
                                                <asp:DropDownList ID="ddlSearchSection" runat="server" TabIndex="21" Width="191"
                                                    CssClass="dropDownList" Font-Size="9" onchange="ParameterChanged();" Visible="false">
                                                </asp:DropDownList>
                                                <asp:Panel ID="Panel1" runat="server" Style="background-color: white; width: 191px;
                                                    border-right: 1px solid #9f9f9f; border-left: 1px solid #9f9f9f; border-bottom: 1px solid #9f9f9f">
                                                    <asp:CheckBoxList ID="chkSections" runat="server">
                                                    </asp:CheckBoxList>
                                                </asp:Panel>
                                                <asp:TextBox ID="txtSection" runat="server" TabIndex="22" CssClass="txtBPL" Width="190px"></asp:TextBox>
                                                <cc1:PopupControlExtender ID="PopEx" runat="server" TargetControlID="txtSection"
                                                    PopupControlID="Panel1" Position="Bottom" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                Name
                                            </td>
                                            <td colspan="3">
                                                <asp:TextBox ID="txtSearchName" runat="server" Width="186px" TabIndex="23" CssClass="txtBPL"
                                                    onkeypress="return ValidateForAlphaNumeric(event);" MaxLength="75" onchange="ParameterChanged();"></asp:TextBox>
                                            </td>
                                            <td style="width: 25px">
                                            </td>
                                            <td colspan="2">
                                            </td>
                                            <td colspan="3">
                                        </tr>
                                        <tr>
                                            <td>
                                                Amount of Payment
                                            </td>
                                            <td style="padding-left: 2px; font-size: 9px" align="right">
                                                From
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtSearchAmountFrom" runat="server" Width="80px" onkeypress="return numeralsOnly(this, event,11,2,0,1);"
                                                    Style="border: 1px solid #9f9f9f; text-align: right" MaxLength="14" TabIndex="24"
                                                    onchange="ParameterChanged();" CssClass="txtBPL"></asp:TextBox>
                                            </td>
                                            <td style="padding-left: 2px; font-size: 9px" align="right">
                                                To
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtSearchAmountTo" runat="server" Width="80px" onkeypress="return numeralsOnly(this, event,11,2,0,1);"
                                                    Style="border: 1px solid #9f9f9f; text-align: right" MaxLength="14" TabIndex="25"
                                                    onchange="ParameterChanged();" CssClass="txtBPL"></asp:TextBox>
                                            </td>
                                            <td style="width: 25px">
                                            </td>
                                            <td>
                                                <asp:Label ID="lblSearchPaidDate" Text="Paid/Credited Date" runat="server"></asp:Label>
                                            </td>
                                            <td style="padding-left: 2px; font-size: 9px" align="right">
                                                From
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtSearchPaidDateFrom" runat="server" Width="80px" CssClass="txtBPR"
                                                    onBlur="setDateFormat(this);" TabIndex="26" onchange="ParameterChanged();"></asp:TextBox>
                                            </td>
                                            <td style="padding-left: 2px; font-size: 9px" align="right">
                                                To
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtSearchPaidDateTo" runat="server" Width="80px" CssClass="txtBPR"
                                                    onBlur="setDateFormat(this);" TabIndex="27" onchange="ParameterChanged();"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblSearchDeducted" Text="Tax Deducted Amount" runat="server"></asp:Label>
                                            </td>
                                            <td style="padding-left: 2px; font-size: 9px" align="right">
                                                From
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtSrchTaxDeductedFrom" runat="server" Width="80px" onkeypress="return numeralsOnly(this, event,11,2,0,1);"
                                                    Style="border: 1px solid #9f9f9f; text-align: right" MaxLength="14" TabIndex="28"
                                                    onchange="ParameterChanged();" CssClass="txtBPL"></asp:TextBox>
                                            </td>
                                            <td style="padding-left: 2px; font-size: 9px" align="right">
                                                To
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtSrchTaxDeductedTo" runat="server" Width="80px" onkeypress="return numeralsOnly(this, event,11,2,0,1);"
                                                    Style="border: 1px solid #9f9f9f; text-align: right" MaxLength="14" TabIndex="29"
                                                    onchange="ParameterChanged();" CssClass="txtBPL"></asp:TextBox>
                                            </td>
                                            <td style="width: 25px">
                                            </td>
                                            <td>
                                                <asp:Label ID="lblSearchDeductedDate" Text="Tax Deducted Date" runat="server"></asp:Label>
                                            </td>
                                            <td style="padding-left: 2px; font-size: 9px" align="right">
                                                From
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtSrchTaxDateFrom" runat="server" Width="80px" CssClass="txtBPR"
                                                    onBlur="setDateFormat(this);" TabIndex="30" onchange="ParameterChanged();"></asp:TextBox>
                                            </td>
                                            <td style="padding-left: 2px; font-size: 9px" align="right">
                                                To
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtSrchTaxDateTo" runat="server" Width="80px" CssClass="txtBPR"
                                                    onBlur="setDateFormat(this);" TabIndex="31" onchange="ParameterChanged();"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                Non Deduction Reason
                                            </td>
                                            <td colspan="3">
                                                <asp:DropDownList ID="ddlSearchNonDedReason" runat="server" Width="186px" TabIndex="32"
                                                    CssClass="dropDownList">
                                                </asp:DropDownList>
                                            </td>
                                            <td style="width: 25px">
                                            </td>
                                            <td colspan="5" align="left" id="tdReferenceNo" runat="server">
                                                <table>
                                                    <tr>
                                                        <td style="width: 130px;">
                                                            <asp:Label ID="lblSearchRefNo" runat="server" Text="Reference No." Style="color: Black;"></asp:Label>                                                            
                                                        </td>
                                                        <td style="width: 10px">
                                                            <asp:TextBox ID="txtSearchReferenceNo" CssClass="txtBPL" Width="190px" TabIndex="32"
                                                                runat="server"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr id="rowSearchAccNo" runat="server" visible="false">
                                            <td colspan="2">
                                                Acc No.
                                            </td>
                                            <td colspan="3">
                                                <asp:TextBox ID="txtSearchAccNo" CssClass="txtBPL" Width="190px" TabIndex="33"
                                                    runat="server"></asp:TextBox>
                                            </td>
                                            <td style="width: 25px">
                                            </td>
                                            <td colspan="5" align="left" id="td3" runat="server">
                                                <table>
                                                    <tr>
                                                        <td style="width: 130px;">
                                                            Unique Ref No.
                                                        </td>
                                                        <td style="width: 10px">
                                                            <asp:TextBox ID="txtSearchUniqueRefNo" CssClass="txtBPL" Width="190px" TabIndex="34"
                                                                runat="server"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                </table>    
                                            </td>
                                        </tr>

                                        <tr>
                                            <td colspan="2">
                                                PAN
                                            </td>
                                            <td colspan="3">
                                                <asp:DropDownList ID="ddlSearchPAN" runat="server" Width="190px" 
                                                     CssClass="dropDownList" TabIndex="35" OnChange="CheckPANValue();" >
                                                    <asp:ListItem Text="Select" Value="-1"></asp:ListItem>
                                                    <asp:ListItem Text="PAN Given" Value="1"></asp:ListItem>
                                                    <asp:ListItem Text="PANAPPLIED" Value="2"></asp:ListItem>
                                                    <asp:ListItem Text="PANINVALID" Value="3"></asp:ListItem>
                                                    <asp:ListItem Text="PANNOTAVBL" Value="4"></asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                            <td style="width: 25px">                                                
                                            </td>
                                            <td colspan="5" align="left" id="td4" runat="server">
                                                <table>
                                                    <tr>
                                                        <td style="width: 130px;">
                                                            PAN as this
                                                        </td>
                                                        <td style="width: 10px">
                                                            <asp:TextBox ID="txtPANRefNo" CssClass="txtBPL" Width="190px" TabIndex="36"
                                                                runat="server" onBlur="ConvertToUC(this);" BackColor="White" MaxLength="10"
                                                                onkeypress="return ValidateForAlphaNumeric(event);"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                </table>    
                                            </td>
                                        </tr>

                                        <tr id="rowSearchRTBranchCode" runat="server" visible="false">
                                            <td colspan="2">
                                                Branch Code
                                            </td>
                                            <td colspan="3">
                                                <asp:TextBox ID="txtSearchRTBranchCode" CssClass="txtBPL" Width="190px" TabIndex="37"
                                                    runat="server"></asp:TextBox>
                                            </td>
                                            <td style="width: 25px">
                                            </td>
                                            <td colspan="5" align="left" id="td2" runat="server">                                                
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="9">
                                                <table>
                                                    <tr>
                                                        <td align="right">
                                                            <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="cmnBtn" TabIndex="38"
                                                                OnClientClick="return FormatSearch()" OnClick="btnSearch_Click" />
                                                        </td>
                                                        <td align="right" id="rowSearchBranch" runat="server" visible="false">
                                                            <asp:Button ID="btnSearchBranch" runat="server" Text="Search Branch" CssClass="cmnBtn"
                                                                TabIndex="30" OnClientClick="return FormatSearch()" OnClick="btnSearchBranch_Click" />
                                                        </td>
                                                        <td>
                                                            <asp:Button ID="btnClear" runat="server" Text="Show All" CssClass="cmnBtn" TabIndex="31"
                                                                OnClientClick="return ValidateLoadAll()" OnClick="btnClear_Click" />
                                                        </td>
                                                        <td id="rowShowAllBranch" runat="server" visible="false">
                                                            <asp:Button ID="btnShowAllBranch" runat="server" Text="Show All Branch" Width="110px"
                                                                CssClass="cmnBtn" TabIndex="31" OnClientClick="return ValidateLoadAll()" OnClick="btnShowAllBranch_Click" />
                                                        </td>
                                                        <td id="rowShowAllVendor" runat="server" visible="false">
                                                            <asp:Button ID="btnShowAllVendor" runat="server" Text="Show All Vendor Data" Width="100px"
                                                                CssClass="cmnBtn" TabIndex="31" OnClientClick="return ValidateLoadAll()" 
                                                                onclick="btnShowAllVendor_Click"/>
                                                        </td>
                                                        <td>
                                                            <asp:Button ID="btnClose" runat="server" Text="Close" Width="55px" CssClass="cmnBtn"
                                                                TabIndex="32" OnClick="btnClose_Click" />
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
                                    Visible="false">
                                    <asp:Repeater ID="rptrDeduction" runat="server" OnItemCommand="rptrDeduction_ItemCommand"
                                        OnItemDataBound="rptrDeduction_ItemDataBound">
                                        <HeaderTemplate>
                                            <table id="NavTable" border="0">
                                                <tr bgcolor="#EEEEEE">
                                                    <th colspan="2" id="headerDeductionAction" runat="server">
                                                        <asp:Label runat="server" ID="Label7" Width="100px" Text="Action" />
                                                    </th>
                                                    <th id="headerBranchInputAction" runat="server" colspan="2">
                                                        <asp:Label runat="server" ID="Label8" Width="100px" Text="Action" />
                                                    </th>
                                                    <th>
                                                        <asp:Label runat="server" ID="lblSerNo" Width="80px" Text="Serial No." />
                                                    </th>
                                                    <th>
                                                        <asp:Label runat="server" ID="lblName" Width="230px" Text="Name" />
                                                    </th>
                                                    <th>
                                                        <asp:Label runat="server" ID="lblPAN" Width="90px" Text="PAN" />
                                                    </th>
                                                    <th>
                                                        <asp:Label runat="server" ID="lblSection" Width="70px" Text="Section" />
                                                    </th>
                                                    <th>
                                                        <asp:Label runat="server" ID="Label13" Width="100px" Text="Challan Number" />
                                                    </th>
                                                    <th>
                                                        <asp:Label runat="server" ID="Label14" Width="100px" Text="Challan Date" />
                                                    </th>
                                                    <th>
                                                        <asp:Label runat="server" ID="Label15" Width="70px" Text="BSR Code" />
                                                    </th>
                                                    <th>
                                                        <asp:Label runat="server" ID="lblAmountOfPayment" Width="150px" Text="Amount Of Payment" />
                                                    </th>
                                                    <th id="headerValueOfPur" runat="server">
                                                        <asp:Label runat="server" ID="lblValueOfPur" Width="150px" Text="Total Value of Purchase(s) " />
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="lblDate" Text="Paid/Credited Date" runat="server" Width="150px"></asp:Label>
                                                    </th>
                                                    <th id="headerITRate" runat="server">
                                                        <asp:Label runat="server" ID="lblIncomeTaxRate" Width="120px" Text="Income Tax Rate" />
                                                    </th>
                                                    <th>
                                                        <asp:Label runat="server" ID="Label2" Width="100px" Text="Income Tax" />
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="Labels2" Text="Surcharge Rate" runat="server" Width="130px"></asp:Label>
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="Label3" runat="server" Width="100px" Text="Surcharge" />
                                                    </th>
                                                    <th>
                                                        <asp:Label runat="server" ID="lblCessRate" Width="80px" Text="Cess Rate" />
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="Label4" runat="server" Width="100px" Text="Cess" />
                                                    </th>
                                                    <th id="headerTaxRate" runat="server">
                                                        <asp:Label runat="server" ID="lblTaxRate" Width="100px" Text="Tax Rate" />
                                                    </th>
                                                    <th>
                                                        <asp:Label runat="server" ID="lblTaxDeducted" Width="100px" Text="Tax Deducted" />
                                                    </th>
                                                    <th>
                                                        <asp:Label runat="server" ID="lblTaxDedDate" Width="130px" Text=" Tax Deducted Date" />
                                                    </th>
                                                    <th id="headerTCSCertDate" runat="server">
                                                        <asp:Label runat="server" ID="lblTCSCertDate" Width="130px" Text="Tax Collection Cert Date" />
                                                    </th>
                                                    <th id="headerBookEntry" runat="server">
                                                        <asp:Label ID="lblBookEntry" runat="server" Width="100px" Text="Book Entry" />
                                                    </th>
                                                    <th>
                                                        <asp:Label runat="server" ID="lblNonDeductionReason" Width="290px" Text="Non Deduction Reason" />
                                                    </th>
                                                    <th style="display: none">
                                                        <asp:Label runat="server" ID="EntryType" Width="290px" Text="Entry Type" />
                                                    </th>
                                                    <th id="headerGrossUp" runat="server">
                                                        <asp:Label ID="Label5" runat="server" Width="130px" Text="Grossing Up Indicator" />
                                                    </th>
                                                </tr>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <tr bgcolor="white">
                                                <td id="edit" runat="server">
                                                    <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" TabIndex="33" CommandName="Edit"
                                                        CommandArgument='<%#Eval("PartPaymentID") %>'></asp:LinkButton>
                                                        <%--CommandArgument='<%#Eval("DeductionID") %>'></asp:LinkButton>--%>
                                                        
                                                </td>
                                                <td id="coldelete" runat="server">
                                                    <asp:LinkButton ID="lnkDelete" runat="server" TabIndex="34" Text="Delete" CommandName="Delete"                                                        
                                                        CommandArgument='<%#Eval("PartPaymentID") %>'></asp:LinkButton>

                                                        <%--CommandArgument='<%#Eval("DeductionID") %>'></asp:LinkButton>--%>
                                                </td>
                                                <td id="view" runat="server">
                                                    <asp:LinkButton ID="lnkView" runat="server" TabIndex="34" Text="View" CommandName="View"
                                                        CommandArgument='<%#Eval("PartPaymentID") %>'></asp:LinkButton>
                                                       <%-- CommandArgument='<%#Eval("DeductionID") %>'></asp:LinkButton>--%>
                                                </td>
                                                <td id="print" runat="server">
                                                    <asp:LinkButton ID="lnkPrint" runat="server" TabIndex="34" Text="Print" CommandName="Print"
                                                        CommandArgument='<%#Eval("PartPaymentID") %>'></asp:LinkButton>
                                                </td>
                                                <td>
                                                    <%# Eval("SLNo")%>
                                                </td>
                                                <td>
                                                    <%# Eval("Name")%>
                                                </td>
                                                <td>
                                                    <%# Eval("PAN")%>
                                                </td>
                                                <td>
                                                    <%# Eval("Section")%>
                                                </td>
                                                <td>
                                                    <%# Eval("ChallanNo")%>
                                                </td>
                                                <td>
                                                    <%# Eval("ChallanDate")%>
                                                </td>
                                                <td>
                                                    <%# Eval("BSRCode")%>
                                                </td>
                                                <td style="text-align: right">
                                                    <%# Eval("PaymentMade")%>
                                                </td>
                                                <td style="text-align: right" id="tdValueofPurchase" runat="server">
                                                    <%# Eval("TotalValueofPurchase")%>
                                                </td>
                                                <td style="text-align: right">
                                                    <%# Eval("CreditedDate")%>
                                                </td>
                                                <td style="text-align: right" id="dataITRate" runat="server">
                                                    <%# Eval("IncomeTaxPerc")%>
                                                </td>
                                                <td style="text-align: right">
                                                    <%# Eval("IncomeTax") %>
                                                </td>
                                                <td style="text-align: right">
                                                    <%# Eval("SurchargeRate")%>
                                                </td>
                                                <td style="text-align: right">
                                                    <%# Eval("Surcharge")%>
                                                </td>
                                                <td style="width: 400px!important; text-align: right">
                                                    <%# Eval("CessRate")%>
                                                </td>
                                                <td style="width: 400px!important; text-align: right">
                                                    <%# Eval("Cess")%>
                                                </td>
                                                <td style="text-align: right" id="dataTaxRate" runat="server">
                                                    <%# Eval("TaxRate")%>
                                                </td>
                                                <td style="text-align: right">
                                                    <%# Eval("TaxDeducted")%>
                                                </td>
                                                <td style="text-align: right">
                                                    <%# Eval("TaxDeductedDate")%>
                                                </td>
                                                <td style="text-align: right" id="tdCertDate" runat="server">
                                                    <%# Eval("TaxCertDate")%>
                                                </td>
                                                <td id="dataBookEntry" runat="server">
                                                    <%#Eval("BookEntry") %>
                                                </td>
                                                <td>
                                                    <%# Eval("NonDeductionReason")%>
                                                </td>
                                                <td style="display: none">
                                                    <asp:Label ID="lblEntryType" runat="server" Text='<%# Eval("EntryType")%>'></asp:Label>
                                                </td>
                                                <td id="dataGrossUp" runat="server">
                                                    <%# Eval("GrossingUpIndicator")%>
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            </table>
                                        </FooterTemplate>
                                    </asp:Repeater>
                                </asp:Panel>
                                <table id="tblPagination" runat="server" style="padding-right: 0px; margin-right: -2px;
                                    margin-bottom: -3px; display: none" align="right">
                                    <tr>
                                        <td width="230px" align="left">
                                            <asp:Label ID="lblDeductionTotal" runat="server" Text="DeductionTotal : Nil" Font-Size="Small" />
                                        </td>
                                        <td style="padding: 0px 0px 0px 0px">
                                            <asp:Label ID="ASPxLabel4" runat="server" Text="Records per page : " Font-Size="X-Small" />
                                        </td>
                                        <td style="width: 50px; padding-top: 2px;">
                                            <asp:DropDownList ID="ddlGoTo" runat="server" Style="width: 50px; height: 15px; float: left;"
                                                CssClass="dropDownList" onchange="if(!OnParameterChanged()) return false" OnSelectedIndexChanged="ddlGoTo_SelectedIndexChanged"
                                                AutoPostBack="true" TabIndex="35" Font-Size="X-Small">
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
                                            <asp:Label ID="lblGridStatus" runat="server" Style="float: left;" Text="" Font-Size="X-Small"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Button ID="btnFirst" runat="server" Text="&lt;&lt;" Width="35px" Font-Names="Arial"
                                                Font-Overline="False" Font-Size="X-Small" OnClick="btnFirst_Click" CssClass="navButton"
                                                Enabled="False" TabIndex="36" OnClientClick="return OnParameterChanged();"></asp:Button>
                                        </td>
                                        <td>
                                            <asp:Button ID="btnPrevious" runat="server" Text="&lt;" Font-Names="Arial" Font-Overline="False"
                                                Font-Size="X-Small" OnClick="btnPrevious_Click" CssClass="navButton" Enabled="False"
                                                TabIndex="37" OnClientClick="return OnParameterChanged();"></asp:Button>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtGoToPage" runat="server" Text="1" CssClass="navTextBox" AutoPostBack="True"
                                                OnTextChanged="txtGoToPage_TextChanged" MaxLength="5" TabIndex="38" onchange="if(!OnParameterChanged()) return false"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:Button ID="btnNext" runat="server" Text="&gt;" Font-Names="Arial" Font-Overline="False"
                                                Font-Size="X-Small" OnClick="btnNext_Click" CssClass="navButton" TabIndex="39"
                                                OnClientClick="return OnParameterChanged();"></asp:Button>
                                        </td>
                                        <td>
                                            <asp:Button ID="btnLast" runat="server" Text="&gt;&gt;" Font-Names="Arial" Font-Overline="False"
                                                Font-Size="X-Small" OnClick="btnLast_Click" CssClass="navButton" TabIndex="40"
                                                OnClientClick="return OnParameterChanged();"></asp:Button>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </asp:View>
                <asp:View ID="vwPartPayment" runat="server" OnActivate="vwPartPayment_Activate">
                    <table class="nTbl">
                        <tr>
                            <td valign="top">
                                <table class="nTbl">
                                    <tr>
                                        <td valign="top" style="margin-left: 0px">
                                            <table class="eCol" cellpadding="0">
                                                <tr>
                                                    <td class="vHCol">
                                                        Serial No.
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtPPSlNo" runat="server" ReadOnly="true" Style="background-color: #d5dadd;
                                                            color: Black;" CssClass="txtBPL"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="vHCol">
                                                        Amount to Calc
                                                    </td>
                                                    <td class="iCol">
                                                        <asp:TextBox ID="txtPPAmountToCalculate" runat="server" MaxLength="14" AutoComplete="Off"
                                                            TabIndex="1" CssClass="txtBPR" onchange="return checkDecimalNo(this);" onkeypress="return numeralsOnly(this, event,11,2,0,1);"
                                                            onkeyup="CalculatePPAmounts();"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="vHCol">
                                                        Income Tax
                                                    </td>
                                                    <td class="iCol">
                                                        <asp:TextBox ID="txtPPIncomeTax" CssClass="txtBPR" AutoComplete="Off" runat="server"
                                                            MaxLength="14" Enabled="true" onchange="return checkDecimalNo(this);" onkeypress="return numeralsOnly(this, event,11,2,0,1);"
                                                            onkeyup="CalcPPAmounts();" TabIndex="2"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="vHCol">
                                                        Surcharge
                                                    </td>
                                                    <td class="iCol">
                                                        <asp:TextBox ID="txtPPSurcharge" runat="server" CssClass="txtBPR" AutoComplete="Off"
                                                            TabIndex="3" MaxLength="14" Enabled="true" onchange="return checkDecimalNo(this);"
                                                            onkeyup="CalcPPAmounts();" onkeypress="return numeralsOnly(this, event,11,2,0,1);"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="vHCol">
                                                        Edu Cess
                                                    </td>
                                                    <td class="iCol">
                                                        <asp:TextBox ID="txtPPEduCess" runat="server" CssClass="txtBPR" AutoComplete="Off"
                                                            TabIndex="4" MaxLength="14" onchange="return checkDecimalNo(this);" onkeypress="return numeralsOnly(this, event,11,2,0,1);"
                                                            onkeyup="CalcPPAmounts();"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="vHCol">
                                                        Total
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtPPTotal" runat="server" AutoComplete="Off" CssClass="txtboxRO"
                                                            Width="196px" MaxLength="14" Enabled="false"> </asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td class="eCol" valign="top">
                                            <table>
                                                <tr>
                                                    <td width="100%" id="Td1">
                                                        <div style="padding-bottom: 3px">
                                                            <div class="dialog" style="width: 100%;">
                                                                <div class="dHeader">
                                                                    Challan Details</div>
                                                                <div style="padding: 5px 5px 10px 10px; border-top: solid 1px gray">
                                                                    <table>
                                                                        <tr>
                                                                            <td width="130px">
                                                                                Serial No.
                                                                            </td>
                                                                            <td style="padding-left: 32px">
                                                                                <table>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <asp:DropDownList ID="ddlPPQuarter" runat="server" AutoPostBack="true" CssClass="dropDownList"
                                                                                                Width="75px" TabIndex="5" Font-Size="9" OnSelectedIndexChanged="ddlPPQuarter_SelectedIndexChanged">
                                                                                            </asp:DropDownList>
                                                                                        </td>
                                                                                        <td>
                                                                                            <cc1:AutoCompleteExtender ID="partPaymentAutoCompleteExtender" runat="server" MinimumPrefixLength="1"
                                                                                                ServicePath="~/WebServices/AutoCompleteService.asmx" TargetControlID="txtPPChallanSlNo"
                                                                                                ServiceMethod="GetChallanSlNosForAutoComplete" CompletionInterval="700" EnableCaching="false"
                                                                                                CompletionSetCount="20" DelimiterCharacters="" ShowOnlyCurrentWordInCompletionListItem="true"
                                                                                                FirstRowSelected="True" OnClientItemSelected="GetChallanSlNoValue">
                                                                                            </cc1:AutoCompleteExtender>
                                                                                            <asp:TextBox ID="txtPPChallanSlNo" runat="server" Enabled="false" Width="93px" onkeypress="return ValidateForOnlyNos(event);"
                                                                                                CssClass="txtBPL" BackColor="#E5E5E5" onkeyup="ClearChallanSlNo(2);" OnBlur="return GetDetails(this);"
                                                                                                TabIndex="6"></asp:TextBox>
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                Challan/Vou No.
                                                                                <br />
                                                                                &amp; Date
                                                                            </td>
                                                                            <td style="padding-left: 28px">
                                                                                <table style="margin: 0px; padding: 0px" cellpadding="0px" cellspacing="0px">
                                                                                    <tr>
                                                                                        <td width="20%" class="iCol" style="padding-left: 4px">
                                                                                            <asp:TextBox ID="txtPPChallanNo" runat="server" CssClass="txtboxRO" Style="width: 92px;
                                                                                                text-align: right" Enabled="false"> </asp:TextBox>
                                                                                        </td>
                                                                                        <td width="80%">
                                                                                            <asp:TextBox ID="txtPPChallanDate" runat="server" CssClass="txtboxRO" Style="width: 80px;
                                                                                                text-align: right" Enabled="false"> </asp:TextBox>
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                Income Tax
                                                                            </td>
                                                                            <td class="iCol" style="padding-left: 32px">
                                                                                <asp:TextBox ID="txtPPChallanIncomeTax" runat="server" MaxLength="14" CssClass="txtboxRO"
                                                                                    Style="width: 177px;" Enabled="false"> </asp:TextBox>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                Surcharge
                                                                            </td>
                                                                            <td class="iCol" style="padding-left: 32px">
                                                                                <asp:TextBox ID="txtPPChallanSurcharge" runat="server" MaxLength="14" CssClass="txtboxRO"
                                                                                    Style="width: 177px;" Enabled="false"> </asp:TextBox>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                Edu Cess
                                                                            </td>
                                                                            <td class="iCol" style="padding-left: 32px">
                                                                                <asp:TextBox ID="txtPPChallanEduCess" runat="server" MaxLength="14" CssClass="txtboxRO"
                                                                                    Style="width: 177px;" Enabled="false"> </asp:TextBox>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                Total Amount
                                                                            </td>
                                                                            <td class="iCol" style="padding-left: 32px">
                                                                                <asp:TextBox ID="txtPPChallanTotalAmount" runat="server" MaxLength="14" CssClass="txtboxRO"
                                                                                    Style="width: 177px;" Enabled="false"> </asp:TextBox>
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
                                    <tr>
                                        <td colspan="2">
                                            <table cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td>
                                                        <asp:Button ID="btnPPNew" Text="New" runat="server" CssClass="cmnBtn" Width="80px"
                                                            OnClientClick="return ClearPPControls();" UseSubmitBehavior="False" TabIndex="8" />
                                                    </td>
                                                    <td style="padding-left: 4px">
                                                        <asp:Button ID="btnPPSave" Text="Save" runat="server" CssClass="cmnBtn" Width="80px"
                                                            TabIndex="7" OnClientClick="return ValidatePP();" OnClick="btnPPSave_Click" />
                                                    </td>
                                                    <td style="padding-left: 4px">
                                                        <asp:Button ID="btnPPClose" runat="server" OnClientClick="ValidateForPP();" Text="Close"
                                                            TabIndex="9" CssClass="cmnBtn" OnClick="btnPPClose_Click" />
                                                    </td>
                                                    <td style="padding-left: 10px">
                                                        <asp:Label ID="lblPPNote" runat="server" Visible="false" ForeColor="#0000CC"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <asp:Panel ID="partPaymentPanel" CssClass="navPanel" runat="server" ScrollBars="Horizontal">
                                                <asp:Repeater ID="rptrPartPayment" runat="server" OnItemCommand="rptrPartPayment_ItemCommand"
                                                    OnItemDataBound="rptrPartPayment_ItemDataBound">
                                                    <HeaderTemplate>
                                                        <table id="NavTable" border="0">
                                                            <tr bgcolor="#EEEEEE">
                                                                <th colspan="2">
                                                                    Action
                                                                </th>
                                                                <th>
                                                                    <asp:Label runat="server" ID="Label2" Width="112px" Text="Income Tax" />
                                                                </th>
                                                                <th>
                                                                    <asp:Label ID="Label4" runat="server" Width="115px" Text="Surcharge" />
                                                                </th>
                                                                <th>
                                                                    <asp:Label ID="lblEduCess" runat="server" Width="120px" Text="Edu Cess" />
                                                                </th>
                                                                <th>
                                                                    <asp:Label runat="server" ID="lblAmount" Width="120px" Text="Amount" />
                                                                </th>
                                                                <th>
                                                                    <asp:Label runat="server" ID="lblTaxDedDate" Width="120px" Text="Challan" />
                                                                </th>
                                                            </tr>
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <tr bgcolor="white">
                                                            <td>
                                                                <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" TabIndex="10" CommandName="Edit"
                                                                    CommandArgument='<%#Eval("DeductionID") %>'></asp:LinkButton>
                                                            </td>
                                                            <td>
                                                                <asp:LinkButton ID="lnkDelete" runat="server" TabIndex="11" Text="Delete" CommandName="Delete"
                                                                    CommandArgument='<%#Eval("DeductionID") %>'></asp:LinkButton>
                                                            </td>
                                                            <td style="text-align: right">
                                                                <%# Eval("IncomeTax") %>
                                                            </td>
                                                            <td style="text-align: right">
                                                                <%# Eval("Surcharge")%>
                                                            </td>
                                                            <td style="width: 400px!important; text-align: right">
                                                                <%# Eval("Cess")%>
                                                            </td>
                                                            <td style="text-align: right">
                                                                <%# Eval("TotalDeducted")%>
                                                            </td>
                                                            <td style="border-right-style: none; text-align: left">
                                                                <%# Eval("Challan")%>
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
                                </table>
                            </td>
                        </tr>
                    </table>
                </asp:View>
                <asp:View ID="viewBranchInput" runat="server">
                    <table>
                        <tr>
                            <td>
                                <asp:Panel ID="pnlBranchInput" CssClass="navPanel" runat="server" ScrollBars="Horizontal">
                                    <asp:Repeater ID="repeaterBranchInput" runat="server" OnItemCommand="repeaterBranchInput_ItemCommand">
                                        <HeaderTemplate>
                                            <table id="NavTable" border="0">
                                                <tr bgcolor="#EEEEEE">
                                                    <th>
                                                        Action
                                                    </th>
                                                    <th>
                                                        <asp:Label runat="server" ID="Label6" Width="80px" Text="Created On" />
                                                    </th>
                                                    <th>
                                                        <asp:Label runat="server" ID="lblBranchName" Width="230px" Text="Branch Name" />
                                                    </th>
                                                    <th>
                                                        <asp:Label runat="server" ID="lblSerNo" Width="60px" Text="Serial No." />
                                                    </th>
                                                    <th>
                                                        <asp:Label runat="server" ID="lblName" Width="230px" Text="Name" />
                                                    </th>
                                                    <th>
                                                        <asp:Label runat="server" ID="lblPAN" Width="80px" Text="PAN" />
                                                    </th>
                                                    <th style="display: none">
                                                        <asp:Label runat="server" ID="Label16" Width="80px" Text="SectionID" />
                                                    </th>
                                                    <th>
                                                        <asp:Label runat="server" ID="Label10" Width="60px" Text="BGL Code" />
                                                    </th>
                                                    <th>
                                                        <asp:Label runat="server" ID="lblSection" Width="350px" Text="Section" />
                                                    </th>
                                                    <th>
                                                        <asp:Label runat="server" ID="lblAmountOfPayment" Width="120px" Text="Amount Entered" />
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="Label1" Text="Bill Number" runat="server" Width="80px"></asp:Label>
                                                    </th>
                                                    <th>
                                                        <asp:Label runat="server" ID="Label2" Width="100px" Text="Bill Date" />
                                                    </th>
                                                </tr>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <tr bgcolor="white">
                                                <td>
                                                    <asp:LinkButton ID="lnkSelect" runat="server" Text="Select" TabIndex="33" CommandName="Select"
                                                        CommandArgument='<%#Eval("ID") %>'></asp:LinkButton>
                                                </td>
                                                <td style="text-align: center">
                                                    <%#Eval("CREATEDON")%>
                                                </td>
                                                <td>
                                                    <%#Eval("BRANCHNAME") %>
                                                </td>
                                                <td>
                                                    <%# Eval("SERIALNO")%>
                                                </td>
                                                <td>
                                                    <%# Eval("NAME")%>
                                                </td>
                                                <td>
                                                    <%# Eval("PAN")%>
                                                </td>
                                                <td style="display: none">
                                                    <asp:Label ID="lblSectionID" runat="server" Text='<%# Eval("SectionID")%>'></asp:Label>
                                                </td>
                                                <td>
                                                    <%# Eval("BGLCODE")%>
                                                </td>
                                                <td style="text-align: left">
                                                    <%# Eval("SECTIONNAME")%>
                                                </td>
                                                <td style="text-align: right">
                                                    <%# Eval("PAYMENTAMOUNT")%>
                                                </td>
                                                <td style="text-align: right">
                                                    <%# Eval("BILLNUM") %>
                                                </td>
                                                <td style="text-align: right">
                                                    <%# Eval("BILLDATE")%>
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            </table>
                                        </FooterTemplate>
                                    </asp:Repeater>
                                </asp:Panel>
                                <table style="padding-right: 0px; margin-right: -2px; margin-bottom: -3px" align="left">
                                    <tr>
                                        <td style="padding: 0px 0px 0px 0px">
                                            <asp:Label ID="lblRecordsPerPage" runat="server" Text="Records per page : " Font-Size="X-Small" />
                                        </td>
                                        <td style="width: 50px; padding-top: 2px;">
                                            <asp:DropDownList ID="ddlBranchInputGoTo" runat="server" Style="width: 50px; height: 15px;
                                                float: left;" onchange="if(!OnParameterChanged()) return false" OnSelectedIndexChanged="ddlBranchInputGoTo_SelectedIndexChanged"
                                                AutoPostBack="true" TabIndex="35" Font-Size="X-Small" CssClass="dropDownList">
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
                                            <asp:Label ID="lblBranchInputStatus" runat="server" Style="float: left;" Font-Size="X-Small"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Button ID="btnBranchInputFirst" runat="server" Text="&lt;&lt;" Width="35px"
                                                Font-Names="Arial" Font-Overline="False" Font-Size="X-Small" OnClick="btnBranchInputFirst_Click"
                                                CssClass="navButton" Enabled="False" TabIndex="36" OnClientClick="return OnParameterChanged();">
                                            </asp:Button>
                                        </td>
                                        <td>
                                            <asp:Button ID="btnBranchInputPrevious" runat="server" Text="&lt;" Font-Names="Arial"
                                                Font-Overline="False" Font-Size="X-Small" OnClick="btnBranchInputPrevious_Click"
                                                CssClass="navButton" Enabled="False" TabIndex="37" OnClientClick="return OnParameterChanged();">
                                            </asp:Button>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtBranchInputGoTo" runat="server" Text="1" CssClass="navTextBox"
                                                AutoPostBack="True" OnTextChanged="txtBranchInputGoTo_TextChanged" MaxLength="5"
                                                TabIndex="38" onchange="if(!OnParameterChanged()) return false"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:Button ID="btnBranchInputNext" runat="server" Text="&gt;" Font-Names="Arial"
                                                Font-Overline="False" Font-Size="X-Small" OnClick="btnBranchInputNext_Click"
                                                CssClass="navButton" TabIndex="39" OnClientClick="return OnParameterChanged();">
                                            </asp:Button>
                                        </td>
                                        <td>
                                            <asp:Button ID="btnBranchInputLast" runat="server" Text="&gt;&gt;" Font-Names="Arial"
                                                Font-Overline="False" Font-Size="X-Small" OnClick="btnBranchInputLast_Click"
                                                CssClass="navButton" TabIndex="40" OnClientClick="return OnParameterChanged();">
                                            </asp:Button>
                                        </td>
                                    </tr>
                                </table>
                                <table align="right">
                                    <tr>
                                        <td style="text-align: right">
                                            <asp:Button ID="btnSearchBranchInput" runat="server" Text="Search" CssClass="cmnBtn"
                                                OnClick="btnSearchBranchInput_Click" />
                                            <asp:Button ID="btnBack" runat="server" Text="Back" CssClass="cmnBtn" OnClick="btnBack_Click" />
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
                                            <asp:Panel ID="pnlBranchInputSearch" runat="server" BorderStyle="Dashed" BorderWidth="1"
                                                CssClass="searchPanel" Style="display: none">
                                                <table>
                                                    <tr>
                                                        <td colspan="2">
                                                            Branch Name
                                                        </td>
                                                        <td colspan="3">
                                                            <asp:TextBox ID="txtSearchBranchName" runat="server" Width="186px" TabIndex="20"
                                                                CssClass="txtBPL" onkeypress="return ValidateForAlphaNumeric(event);" MaxLength="75"></asp:TextBox>
                                                        </td>
                                                        <td class="style4">
                                                        </td>
                                                        <td class="style5">
                                                            <asp:Label ID="Label11" Text="Branch Code" runat="server"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtSearchBranchCode" runat="server" TabIndex="21" Width="191" Font-Size="9"
                                                                CssClass="txtBPL"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2">
                                                            Name
                                                        </td>
                                                        <td colspan="3">
                                                            <asp:TextBox ID="txtSearchVendorName" runat="server" Width="186px" TabIndex="20"
                                                                CssClass="txtBPL" onkeypress="return ValidateForAlphaNumeric(event);" MaxLength="75"></asp:TextBox>
                                                        </td>
                                                        <td class="style4">
                                                        </td>
                                                        <td class="style5">
                                                            <asp:Label ID="Label9" Text="PAN" runat="server"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtSearchVendorPAN" runat="server" TabIndex="21" Width="191" Font-Size="9"
                                                                CssClass="txtBPL" onBlur="ConvertToUC(this);"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="style7">
                                                            Amount Entered
                                                        </td>
                                                        <td style="padding-left: 2px; font-size: 9px" align="right" class="style6">
                                                            From
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtAmountEnteredFrom" runat="server" Width="80px" onkeypress="return numeralsOnly(this, event,11,2,0,1);"
                                                                Style="border: 1px solid #9f9f9f; text-align: right" MaxLength="14" TabIndex="22"></asp:TextBox>
                                                        </td>
                                                        <td style="padding-left: 2px; font-size: 9px" align="right">
                                                            To
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtAmountEnteredTo" runat="server" Width="80px" onkeypress="return numeralsOnly(this, event,11,2,0,1);"
                                                                Style="border: 1px solid #9f9f9f; text-align: right" MaxLength="14" TabIndex="23"></asp:TextBox>
                                                        </td>
                                                        <td class="style4">
                                                        </td>
                                                        <td class="style5">
                                                            BGL Code
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtSearchBGLCode" runat="server" CssClass="txtBPL" TabIndex="24"
                                                                Width="191px"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2">
                                                            Creation Date
                                                        </td>
                                                        <td colspan="3">
                                                            <asp:TextBox ID="txtCreationDate" runat="server" Width="186px" TabIndex="20" CssClass="txtBPL"
                                                                onBlur="setDateFormat(this);"></asp:TextBox>
                                                        </td>
                                                        <td colspan="3" align="right">
                                                            <table>
                                                                <tr>
                                                                    <td align="right">
                                                                        <asp:Button ID="btnSearchPaymentDetails" runat="server" Text="Search" CssClass="cmnBtn"
                                                                            OnClientClick="FormatPaymentSearch(); return true" TabIndex="30" OnClick="btnSearchPaymentDetails_Click" />
                                                                    </td>
                                                                    <td>
                                                                        <asp:Button ID="btnSearchBranchInputClear" runat="server" Text="Clear Search" CssClass="cmnBtn"
                                                                            TabIndex="31" OnClick="btnSearchBranchInputClear_Click" />
                                                                    </td>
                                                                    <td>
                                                                        <asp:Button ID="btnSearchBranchInputClose" runat="server" Text="Close" Width="80px"
                                                                            CssClass="cmnBtn" TabIndex="32" OnClick="btnSearchBranchInputClose_Click" />
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
                            </td>
                        </tr>
                    </table>
                </asp:View>
                <asp:View ID="viewReport" runat="server">
                    <table class="nTbl">
                        <tr>
                            <td>
                                From Date :
                            </td>
                            <td>
                                <asp:TextBox ID="txtFromDate" runat="server" CssClass="txtBPR" Width="186px" onBlur="setDateFormat(this);"></asp:TextBox>
                            </td>
                            <td>
                                To Date :
                            </td>
                            <td>
                                <asp:TextBox ID="txtToDate" runat="server" CssClass="txtBPR" Width="186px" onBlur="setDateFormat(this);"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4" class="style8">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4">
                                <asp:Button ID="btnPreview" Text="Preview" runat="server" CssClass="cmnBtn" OnClientClick="return ValidateDate();"
                                    OnClick="btnPreview_Click" />&nbsp;
                                <asp:Button ID="btnBackTo" Text="Back" runat="server" CssClass="cmnBtn" OnClick="btnBackTo_Click" />
                            </td>
                        </tr>
                    </table>
                </asp:View>
            </asp:MultiView>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnSearch" />
            <asp:PostBackTrigger ControlID="btnOpenSearch" />
            <asp:PostBackTrigger ControlID="btnClear" />
            <asp:PostBackTrigger ControlID="btnClose" />
            <asp:PostBackTrigger ControlID="btnNew" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
