<%@ page language="C#" autoeventwireup="true" masterpagefile="~/SaralTDS.master" inherits="SalaryDetails_SalaryDetails, App_Web_salarydetails.aspx.43d195c7" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript" language="javascript" src="../JavaScript/Validations.js"></script>
    <script src="../JavaScript/jquery_1_11_2.min.js" type="text/javascript"></script>
    <script type="text/javascript" language="javascript">
        function GetRateSlabDetails() {
            var txtReliefCalculatedAmount = document.getElementById("<%=txtReliefCalculatedAmount.ClientID%>").value;
            var txtReliefTaxbleIncome = document.getElementById("<%=txtReliefTaxbleIncome.ClientID%>").value;
            var txtReliefArrearReceived = document.getElementById("<%=txtReliefArrearReceived.ClientID%>").value;
            var txtTotalTaxableIncome = document.getElementById("<%=hdnTotalTaxableIncome.ClientID%>").value;
            var obj = document.getElementById("<%=ddlReliefFinYear.ClientID%>").value + "@" + document.getElementById("<%=hdnIsSeniorCitizen.ClientID%>").value + "@" + document.getElementById("<%=hdnGender.ClientID%>").value;
            $.ajax({
                type: "POST",
                url: "SalaryDetails.aspx/GetRateSlabDetails",
                data: "{'args': '" + obj + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: true,
                error: function (jqXHR, textStatus, errorThrown) {
                    alert(errorThrown);
                    alert(textStatus);
                },
                success: function (msg) {
                    var taxAmountWithArrearsInPresentYear = CalculateReliefUS89(msg.d.split('@'), (Return(txtTotalTaxableIncome) + Return(txtReliefArrearReceived)), "Present Year")
                    //alert("Tax Amount With Arrears In Present Year = " + taxAmountWithArrearsInPresentYear);

                    var taxAmountWithoutArrearsInPresentYear = CalculateReliefUS89(msg.d.split('@'), Return(txtTotalTaxableIncome), "Present Year")
                    //alert("Tax Amount Without Arrears In Present Year = " + taxAmountWithoutArrearsInPresentYear);

                    var taxAmountWithArrearsInPreviousYear = CalculateReliefUS89(msg.d.split('@'), (Return(txtReliefTaxbleIncome) + Return(txtReliefArrearReceived)), "Previous Year")
                    //alert("Tax Amount With Arrears In Previous Year = " + taxAmountWithArrearsInPreviousYear);

                    var taxAmountWithoutArrearsInPreviousYear = CalculateReliefUS89(msg.d.split('@'), Return(txtReliefTaxbleIncome), "Previous Year")
                    //alert("Tax Amount Without Arrears In Previous Year = " + taxAmountWithoutArrearsInPreviousYear);

                    var presentYearTax = Return(taxAmountWithArrearsInPresentYear) - Return(taxAmountWithoutArrearsInPresentYear);
                    //alert("Present Year Tax = " + presentYearTax);

                    var previousYearTax = Return(taxAmountWithArrearsInPreviousYear) - Return(taxAmountWithoutArrearsInPreviousYear);
                    //alert("Previous Year Tax = " + previousYearTax);

                    txtReliefCalculatedAmount = Return(presentYearTax) - Return(previousYearTax)

                    if (Return(txtReliefCalculatedAmount) < 0)
                        txtReliefCalculatedAmount = 0;

                    document.getElementById("<%=txtReliefCalculatedAmount.ClientID%>").value = txtReliefCalculatedAmount.toFixed(2);
                    document.getElementById("<%=txtReliefTaxbleIncome.ClientID%>").value = Return(txtReliefTaxbleIncome).toFixed(2);
                    document.getElementById("<%=txtReliefArrearReceived.ClientID%>").value = Return(txtReliefArrearReceived).toFixed(2);
                }
            });
        }

        function CalculateReliefUS89(rateSlabsAll, taxableIncome, yearType) {
            var taxRate = 0;
            var taxes = 0; var eduCess = 0; var taxOnTotalIncome = 0;
            var rate1 = 10; var rate2 = 20; var rate3 = 30;
            var firstSlab = 0, secondSlab = 0, thirdSlab = 0;
            var firstSlabAmt = 0, secondSlabAmt = 0, thirdSlabAmt = 0;
            var finYear = document.getElementById("<%=hdnFinYear.ClientID%>").value;
            var IsSeniorCitizen = document.getElementById("<%=hdnIsSeniorCitizen.ClientID%>").value;
            var IsInvalidPAN = document.getElementById("<%=hdnIsInValidPAN.ClientID%>").value;
            var txtCreditUS87A = 0;
            var creditUS87A = 0;

            if (yearType == "Previous Year") {
                for (var record = 0; record < rateSlabsAll.length - 1; record++) {
                    var rateSlabs = rateSlabsAll[record].split('^');
                    finYear = rateSlabs[0];
                    if (record == 0) {
                        //var rateSlabsFinYear = rateSlabs[0];
                        //var rateSlabsCatID = rateSlabs[1];
                        //var rateSlabsDSLNo = rateSlabs[2];
                        //var rateSlabsBFrom = rateSlabs[3];
                        //var rateSlabsBTo = rateSlabs[4];
                        firstSlab = rateSlabs[4];
                    }
                    if (record == 1) {
                        rate1 = rateSlabs[5];
                        secondSlab = rateSlabs[4];
                    }
                    if (record == 2) {
                        rate2 = rateSlabs[5];
                        thirdSlab = rateSlabs[4];
                    }
                    if (record == 3) {
                        rate3 = rateSlabs[5];
                    }
                }
            }
            else {
                if (Number(finYear) >= 2017)
                    rate1 = 5;
                switch (Return(IsSeniorCitizen)) {
                    case 0:
                        firstSlab = Number(finYear) > 2013 ? 250000 : 200000;
                        secondSlab = 500000; thirdSlab = 1000000;
                        break;
                    case 1:
                        firstSlab = Number(finYear) > 2013 ? 300000 : 250000;
                        secondSlab = 500000; thirdSlab = 1000000;
                        break;
                    case 2:
                        rate1 = 20; rate2 = 30;
                        firstSlab = 500000; secondSlab = 1000000;
                        break;
                }
            }

            if (Return(taxableIncome) > 200000 && Return(taxableIncome) <= 500000) {
                if (finYear >= 2013 && finYear <= 2015)
                    txtCreditUS87A = 2000;
                else if (finYear == 2016)
                    txtCreditUS87A = 5000;
                else if (finYear > 2016 && finYear <= 2018 && Return(taxableIncome) <= 350000)
                    txtCreditUS87A = 2500;
                else if (finYear >= 2019 && Return(taxableIncome) <= 500000)
                    txtCreditUS87A = 12500;
                else
                    txtCreditUS87A = 0;
            }

            creditUS87A = txtCreditUS87A;

            if (taxableIncome > firstSlab) {
                firstSlabAmt = taxableIncome - firstSlab;
                if (firstSlabAmt >= secondSlab - firstSlab) {
                    secondSlabAmt = secondSlab - firstSlab;
                    taxes = taxes + (secondSlabAmt * rate1 / 100);
                    firstSlabAmt = firstSlabAmt - secondSlabAmt;
                    if (firstSlabAmt >= thirdSlab - secondSlab) {
                        secondSlabAmt = thirdSlab - secondSlab;
                        taxes = taxes + (secondSlabAmt * rate2 / 100);
                        thirdSlabAmt = firstSlabAmt - secondSlabAmt;
                        taxes = taxes + (thirdSlabAmt * rate3 / 100);
                        taxRate = 1;
                    }
                    else
                        taxes = taxes + (firstSlabAmt * rate2 / 100);
                }
                else
                    taxes = taxes + (firstSlabAmt * rate1 / 100);

                taxOnTotalIncome = taxes;

                if (Number(finYear) < 2018)
                    eduCess = Math.round((taxOnTotalIncome - Math.min(taxOnTotalIncome, creditUS87A)) * 0.03, 0);
                else
                    eduCess = Math.round((taxOnTotalIncome - Math.min(taxOnTotalIncome, creditUS87A)) * 0.04, 0);

                if (finYear >= 2014 && taxRate == 0) {
                    if (IsSeniorCitizen == 0)
                        if (Return(IsInvalidPAN) == 1) {
                            if ((taxOnTotalIncome / taxableIncome) * 100 < 20) {
                                eduCess = ""; rate1 = 0;
                                taxOnTotalIncome = (taxableIncome) * 0.2;
                                txtCreditUS87A = 0;
                            }
                        }
                    if (IsSeniorCitizen == 1)
                        if (Return(IsInvalidPAN) == 1) {
                            if ((taxOnTotalIncome / taxableIncome) * 100 < 20) {
                                eduCess = ""; rate1 = 0;
                                taxOnTotalIncome = (taxableIncome) * 0.2;
                                txtCreditUS87A = 0;
                            }
                        }
                    if (IsSeniorCitizen == 2)
                        if (Return(IsInvalidPAN) == 1) {
                            if ((taxOnTotalIncome / taxableIncome) * 100 < 20) {
                                eduCess = ""; rate1 = 0;
                                taxOnTotalIncome = (taxableIncome) * 0.2;
                                txtCreditUS87A = 0;
                            }
                        }
                }
                else {
                    if (IsSeniorCitizen == 0)
                        if (Return(IsInvalidPAN) == 1) {
                            if ((taxOnTotalIncome / taxableIncome) * 100 < 20) {
                                eduCess = ""; taxOnTotalIncome = (taxableIncome) * 0.2;
                            }
                        }
                    if (IsSeniorCitizen == 1)
                        if (Return(IsInvalidPAN) == 1) {
                            if ((taxOnTotalIncome / taxableIncome) * 100 < 20) {
                                eduCess = ""; taxOnTotalIncome = (taxableIncome) * 0.2;
                            }
                        }
                    if (IsSeniorCitizen == 2)
                        if (Return(IsInvalidPAN) == 1) {
                            if ((taxOnTotalIncome / taxableIncome) * 100 < 20) {
                                eduCess = ""; taxOnTotalIncome = (taxableIncome) * 0.2;
                            }
                        }
                }
                taxOnTotalIncome = Math.round(taxOnTotalIncome, 0);
            }
            if (rate1 != 0) {
                if (txtCreditUS87A != null) {
                    creditUS87A = Return(taxOnTotalIncome) > 0 ? txtCreditUS87A : 0;
                    txtCreditUS87A = Math.min(Return(txtCreditUS87A), Return(taxOnTotalIncome));
                    creditUS87A = txtCreditUS87A;
                }
            }
            else { creditUS87A = 0; }
            return (Return(taxOnTotalIncome) - Return(creditUS87A)) + Return(eduCess);
        }

        function OnDelete(obj) { return confirm(obj); }

        function ClearTDSMadeDetails() {
            document.getElementById("<%=txtPrevEmpIncTax.ClientID %>").value = "";
            document.getElementById("<%=txtPrevEmpSurcharge.ClientID %>").value = "";
            document.getElementById("<%=txtPrevEmpCess.ClientID %>").value = "";
            document.getElementById("<%=txtPrevEmpTotal.ClientID %>").value = "";
            document.getElementById("<%=txtWithoutDedDetailsIncTax.ClientID %>").value = "";
            document.getElementById("<%=txtWithoutDedDetailsSurcharge.ClientID %>").value = "";
            document.getElementById("<%=txtWithoutDedDetailsCess.ClientID %>").value = "";
        }
        function AlertUser() {
            if ((document.getElementById("<%=hdnDeducteeID.ClientID%>").value == "-1") || (document.getElementById("<%=hdnDeducteeID.ClientID%>").value != "-1" && document.getElementById("<%=hdnIsLoaded.ClientID%>").value == "False")) {
                alert('Click on Load to view the Salary Detail.');
                return false;
            } return true;
        }

        function ValidationsSD() {
            var sdValue = 0;
            var hdnFinYear = document.getElementById("<%=hdnFinYear.ClientID %>").value;
            var SD = document.getElementById("<%=txtSD.ClientID%>");
            var ET = document.getElementById("<%=txtET.ClientID%>");
            var PT = document.getElementById("<%=txtPT.ClientID%>");
            var grossSalary = document.getElementById("<%=txtGrossSalary.ClientID%>");
            var result = "";

            if (hdnFinYear == 2018)
                sdValue = 40000;
            else if (hdnFinYear >= 2019)
                sdValue = 50000;
            else
                sdValue = 0;

            if (hdnFinYear >= 2018) {
                if (Return(SD.value) == 0 && grossSalary.value > 0) {
                    result = confirm("'Standard Deduction' is applicable from FY 2018-19.\nDo you want to save without utilising it?")
                    if (result == false) {
                        SD.value = sdValue;
                        CalculateValues();
                        SD.focus();
                        return false;
                    }
                }
                else {
                    if (Return(SD.value) > sdValue) {
                        alert("'Standard Deduction' cannot be more than Rs. " + sdValue);
                        SD.focus();
                        return false;
                    }

                    // If Gross Salary is above Rs.40,000 but Standard Deduction is less than Rs.40,000
                    if (Return(grossSalary.value) > sdValue && Return(SD.value) < sdValue) {
                        result = confirm("'Standard Deduction' upto Rs. " + sdValue + " can be availed.\nDo you want to avail for lesser amount?");
                        if (result == false) {
                            SD.value = sdValue;
                            CalculateValues();
                            SD.focus();
                            return false;
                        }
                    }

                    // If Gross Salary is less than Standard Deduction
                    if (Return(grossSalary.value) < Return(SD.value)) {
                        alert("'Standard Deduction' cannot be more than 'Gross Salary'.");
                        SD.focus();
                        return false;
                    }

                    //If Standard Deduction is less than Gross Salary when not Rs.40,000
                    if (Return(grossSalary.value) < sdValue) {
                        if (Return(SD.value) < (Return(grossSalary.value) - (Return(ET.value) + Return(PT.value)))) {
                            result = confirm("'Standard Deduction' upto Rs. " + (Return(grossSalary.value) - (Return(ET.value) + Return(PT.value)) +
                                            " can be availed.\nDo you want to avail for lesser amount?"));
                            if (result == false) {
                                SD.focus();
                                return false;
                            }
                        }
                    }
                }
                return true;
            }
        }

        function Validations() {
            var txtTotalTaxableIncome = document.getElementById("<%=txtTotalTaxableIncome.ClientID%>");
            if (ValidateName() == false) return false;
            if (ValidateGrossTotalIncome(document.getElementById("<%=txtIncomefromSalaries.ClientID%>"), document.getElementById("<%=txtGrossTotalIncome.ClientID%>")) == false) return false;
            if (ValidateTotalTaxableIncome(document.getElementById("<%=txtTotalTaxableIncome.ClientID %>")) == false) return false;
            if (ValidateTaxOnTotalIncome(document.getElementById("<%=txtTaxOnTotalIncome.ClientID%>"), document.getElementById("<%=txtTotalTaxableIncome.ClientID%>")) == false) return false;
            if (ValidateNetTaxPayable(document.getElementById("<%=txtNetTaxPayable.ClientID%>"), document.getElementById("<%=txtReliefUnderSection89.ClientID%>")) == false) return false;
            if (ValidationsSD() == false) return false;
            var totaltaxableincome = document.getElementById("<%=txtTotalTaxableIncome.ClientID%>").value;
            if (totaltaxableincome > 9999999999) {
                alert("Total Taxable Income should be less than 1000 Crores.")
                //document.getElementById("<%=txtTotalTaxableIncome.ClientID%>").focus();
                return false;
            }
            else { return true };
        }
        function ValidateName() {
            if (document.getElementById("<%=hdnDeducteeID.ClientID%>").value == "-1") {
                var IsSB = document.getElementById("<%=hdnIsSB.ClientID%>").value;
                var text = IsSB == "1" ? "Employee No." : "Employee Name";
                alert("Specify Valid " + text);
                document.getElementById("<%=txtName.ClientID%>").focus();
                document.getElementById("<%=lblEmpDetails.ClientID%>").style.display = 'none';
                return false;
            } else {
                document.getElementById("<%=hdnIsLoaded.ClientID%>").value = "True";
                return true;
            }
        }
        function ValidateGrossTotalIncome(incomeFromSalaries, grossTotalIncome) {
            if (Return(incomeFromSalaries.value) < 0) {
                alert("Income from Salaries cannot be negative.");
                return false;
            }
            else if (Return(grossTotalIncome.value) < 0) {
                alert("Gross Total Income cannot be negative.");
                return false;
            } return true;
        }
        function ValidateTotalTaxableIncome(totalTaxableIncome) {
            if (Return(totalTaxableIncome.value) < 0) {
                alert("Total Taxable Income cannot be negative\n(Deductions Under Chapter VI(A) is more than Gross Total Income)");
                return false;
            } return true;
        }
        function ValidateTaxOnTotalIncome(taxOnTotalIncome, totalTaxableIncome) {
            if (Return(taxOnTotalIncome.value) > Return(totalTaxableIncome.value)) {
                alert("Tax on Total Income cannot be more than Total Taxable Income.");
                taxOnTotalIncome.focus();
                return false;
            } return true;
        }
        function ValidateNetTaxPayable(netTaxPayable, reliefUnderSec89) {
            if (Return(netTaxPayable.value) < 0) {
                alert("Net Tax Payable cannot be negative.");
                return false;
            } return true;
        }
        function ValidatePerqDetail() {
            if (ValidatePerquisiteDetails(document.getElementById("<%=txtPerkAccUnfurnished.ClientID%>"), document.getElementById("<%=txtPerkFurnishedValue.ClientID%>"), document.getElementById("<%=txtCostOfFurniture.ClientID%>"),
                                          document.getElementById("<%=txtRentPaid.ClientID%>"), document.getElementById("<%=txtValueofPerquisites.ClientID%>"))) {
                UpdateTaxPerq();
            }
            else return false;
        }
        function ValidatePerquisiteDetails(perkAccUnfurnished, perkFurnishedValue, costOfFurniture, rentPaid, valueOfPerquisites) {
            if (Return(perkAccUnfurnished.value) != 0 && Return(perkFurnishedValue.value) != 0) {
                alert("Either mention Perk-Where accomodation is un furnished or Furnished Details.\nBoth cannot be claimed together.");
                perkAccUnfurnished.focus();
                return false;
            }
            else if (Return(perkFurnishedValue.value) > 0 && Return(costOfFurniture.value) == 0) {
                alert("Since Perk-Furnished-Value is specified,\nCost Of Furniture should also be specified.");
                costOfFurniture.focus();
                return false;
            }
            else if (Return(costOfFurniture.value) > 0 && Return(perkFurnishedValue.value) == 0) {
                alert("Since Perk-Furnished-Value is not specified,\nCost Of Furniture need not be specified.");
                perkFurnishedValue.focus();
                return false;
            }
            else if (Return(valueOfPerquisites.value) < 0) {
                alert("Rent Paid cannot be more than Total value of accomodation.");
                rentPaid.focus();
                return false;
            } return true;
        }
        function UpdateOtherInc() { document.getElementById("<%=hdnOtherIncome.ClientID%>").value = Return(document.getElementById("<%=txtTotalOtherIncomeDetails.ClientID%>").value) - Return(document.getElementById("<%=txtInterestOnSBAccount.ClientID%>").value); }
        function UpdateTaxPerq() { document.getElementById("<%=hdnTotalTaxPerk.ClientID%>").value = document.getElementById("<%=txtTotalValueOfPerquisite.ClientID%>").value; }
        function UpdateTotalTDS() { document.getElementById("<%=hdnTotalTDS.ClientID%>").value = document.getElementById("<%=txtTotalDedDetailsTotal.ClientID%>").value; }
        function UpdateChapterVIATot() { document.getElementById("<%=hdnChapVIATotal.ClientID%>").value = document.getElementById("<%=txtTotalDeductible.ClientID%>").value; }
        function CalculateTaxPerks() {
            var perkAccUnfurnished = document.getElementById("<%=txtPerkAccUnfurnished.ClientID%>");
            var perkFurValue = document.getElementById("<%=txtPerkFurnishedValue.ClientID%>");
            var costOfFur = document.getElementById("<%=txtCostOfFurniture.ClientID%>");
            var furRentals = document.getElementById("<%=txtFurnitureRentals.ClientID%>");
            var perkValueOfFur = document.getElementById("<%=txtPerquisiteValueOfFurniture.ClientID%>");
            var perkFurTotal = document.getElementById("<%=txtPerkFurnishedTotal.ClientID %>");
            var rentPaid = document.getElementById("<%=txtRentPaid.ClientID%>");
            var valueOfPerq = document.getElementById("<%=txtValueofPerquisites.ClientID%>");
            var conveyance = document.getElementById("<%=txtConveyance.ClientID%>");
            var remuneration = document.getElementById("<%=txtRemuneration.ClientID%>");
            var taxableLTC = document.getElementById("<%=txtTaxableLTC.ClientID%>");
            var otherBenefit = document.getElementById("<%=txtOtherBenefit.ClientID%>");
            var pfInExc = document.getElementById("<%=txtPFInExcess.ClientID %>");
            var excessInterest = document.getElementById("<%= txtExcessInterest.ClientID%>");
            var totalValueOfPerq = document.getElementById("<%= txtTotalValueOfPerquisite.ClientID%>");
            var tempValue;
            tempValue = (Return(costOfFur.value) * 0.1) + Return(furRentals.value);
            perkValueOfFur.value = Return(tempValue.toFixed(2));
            tempValue = Return(perkValueOfFur.value) + Return(perkFurValue.value);
            perkFurTotal.value = Return(tempValue.toFixed(2));
            valueOfPerq.value = perkFurTotal.value;
            totalValueOfPerq.value = perkFurTotal.value;
            if (Return(perkAccUnfurnished.value) != 0) {
                if (Return(perkFurValue.value) == 0) {
                    if (Return(furRentals.value) != 0) {
                        tempValue = Return(perkFurTotal.value) - Return(rentPaid.value);
                    }
                    else if (Return(furRentals.value) == 0) {
                        tempValue = Return(perkAccUnfurnished.value) - Return(rentPaid.value);
                    }
                }
                else if (Return(perkFurValue.value) != 0) {
                    tempValue = Return(perkFurTotal.value) - Return(rentPaid.value);
                }
            }
            else if (Return(perkAccUnfurnished.value) == 0) {
                if (Return(perkFurValue.value) == 0) {
                    if (Return(furRentals.value) != 0 || Return(furRentals.value) == 0) {
                        tempValue = Return(perkFurTotal.value) - Return(rentPaid.value);
                    }
                }
                else if (Return(perkFurValue.value) != 0) {
                    tempValue = Return(perkFurTotal.value) - Return(rentPaid.value);
                }
            }
            valueOfPerq.value = Return(tempValue.toFixed(2)); totalValueOfPerq.value = valueOfPerq.value;
            tempValue = Return(valueOfPerq.value) + Return(conveyance.value) + Return(remuneration.value) + Return(taxableLTC.value) + Return(otherBenefit.value) + Return(pfInExc.value) + Return(excessInterest.value);
            totalValueOfPerq.value = tempValue.toFixed(2);
        }
        function CalculateOtherIncome() {
            var tta = document.getElementById("<%=hdn80TTA.ClientID%>");
            var ttb = document.getElementById("<%=hdn80TTB.ClientID%>");
            var salaryFrmPrevEmp = document.getElementById("<%= txtSalaryFromPrevEmp.ClientID%>");
            var incomeFromHouseProp = document.getElementById("<%= txtIncomeFromHouseProp.ClientID%>");
            var incomeFromBsnAndProf = document.getElementById("<%= txtIncomeFromBsnProf.ClientID%>");
            var capitalGains = document.getElementById("<%= txtCapitalGains.ClientID%>");
            var incomeFrmOtherSources = document.getElementById("<%= txtIncomeFromOtherSources.ClientID%>");
            var totalOtherIncomeDetails = document.getElementById("<%= txtTotalOtherIncomeDetails.ClientID%>");
            var otherIncome = document.getElementById("<%= txtOtherIncome.ClientID%>");
            var tempValue = Return(tta.value) + Return(ttb.value) + Return(salaryFrmPrevEmp.value) + Return(incomeFromHouseProp.value) + Return(incomeFromBsnAndProf.value) + Return(capitalGains.value) + Return(incomeFrmOtherSources.value);
            totalOtherIncomeDetails.value = Return(tempValue.toFixed(2));
        }
        function CalculateTDSDetails() {
            var prevEmpIT = document.getElementById("<%=txtPrevEmpIncTax.ClientID%>");
            var prevEmpSur = document.getElementById("<%=txtPrevEmpSurcharge.ClientID%>");
            var prevEmpCess = document.getElementById("<%=txtPrevEmpCess.ClientID%>");
            var prevEmpTotal = document.getElementById("<%=txtPrevEmpTotal.ClientID%>");
            var withoutDedDetIT = document.getElementById("<%=txtWithoutDedDetailsIncTax.ClientID%>");
            var withoutDedDetSur = document.getElementById("<%=txtWithoutDedDetailsSurcharge.ClientID%>");
            var withoutDedDetCess = document.getElementById("<%=txtWithoutDedDetailsCess.ClientID%>");
            var withoutDedDetTotal = document.getElementById("<%=txtWithoutDedDetailsTotal.ClientID%>");
            var withDedDetIT = document.getElementById("<%=txtWithDedDetailsIncTax.ClientID%>");
            var totalDedDetIT = document.getElementById("<%=txtTotalDedDetailsIncTax.ClientID%>");
            var totalDedDetCess = document.getElementById("<%=txtTotalDedDetailsCess.ClientID%>");
            var withDedDetCess = document.getElementById("<%=txtWithDedDetailsCess.ClientID%>");
            var totalDedDetTotal = document.getElementById("<%=txtTotalDedDetailsTotal.ClientID%>");
            var withDedDetTotal = document.getElementById("<%=txtWithDedDetailsTotal.ClientID%>");
            var tempValue = Return(prevEmpIT.value) + Return(prevEmpSur.value) + Return(prevEmpCess.value);
            prevEmpTotal.value = Return(tempValue.toFixed(2));
            tempValue = Return(withoutDedDetIT.value) + Return(withoutDedDetSur.value) + Return(withoutDedDetCess.value);
            withoutDedDetTotal.value = Return(tempValue.toFixed(2));
            tempValue = Return(prevEmpIT.value) + Return(withoutDedDetIT.value) + Return(withDedDetIT.value);
            totalDedDetIT.value = Return(tempValue.toFixed(2));
            tempValue = Return(prevEmpCess.value) + Return(withoutDedDetCess.value) + Return(withDedDetCess.value);
            totalDedDetCess.value = Return(tempValue.toFixed(2));
            tempValue = Return(prevEmpTotal.value) + Return(withoutDedDetTotal.value) + Return(withDedDetTotal.value)
            totalDedDetTotal.value = Return(tempValue.toFixed(2));
        }
        function CalculateValues() {
            var tempValue;
            var IsInvalidPAN = document.getElementById("<%=hdnIsInValidPAN.ClientID%>");
            var FinYear = document.getElementById("<%=hdnFinYear.ClientID%>");
            var basicSalary = document.getElementById("<%=txtBasicSalary.ClientID%>");
            var taxableAllowance = document.getElementById("<%=txtTaxableAllowance.ClientID%>");
            var grossSalary = document.getElementById("<%=txtGrossSalary.ClientID%>");
            var taxablePerq = document.getElementById("<%= txtTaxablePerquisites.ClientID%>");
            var ExemptedAllowancesAndPerqs = document.getElementById("<%= txtExemptedAllowancesAndPerqs.ClientID%>");
            var SD = document.getElementById("<%=txtSD.ClientID%>");
            var ET = document.getElementById("<%=txtET.ClientID%>");
            var PT = document.getElementById("<%=txtPT.ClientID%>");
            var dedUnderSec16 = document.getElementById("<%= txtDeductionUnderSection16.ClientID%>");
            var incomefrmSalaries = document.getElementById("<%=txtIncomefromSalaries.ClientID%>");
            var grossTotIncome = document.getElementById("<%= txtGrossTotalIncome.ClientID%>");
            var totalDedUnderChapterVIA = document.getElementById("<%=txtTotalDeductions.ClientID %>");
            var totTaxableIncome = document.getElementById("<%= txtTotalTaxableIncome.ClientID%>");
            var otherIncome = document.getElementById("<%=txtOtherIncome.ClientID%>");
            var creditUS87A = document.getElementById("<%=txtCreditUS87A.ClientID%>");

            IsInvalidPAN = IsInvalidPAN == null ? "0" : IsInvalidPAN;
            FinYear = FinYear == null ? "0" : FinYear;
            basicSalary = basicSalary == null ? "0" : basicSalary;
            taxableAllowance = taxableAllowance == null ? "0" : taxableAllowance;
            grossSalary = grossSalary == null ? "0" : grossSalary;
            taxablePerq = taxablePerq == null ? "0" : taxablePerq;
            ExemptedAllowancesAndPerqs = ExemptedAllowancesAndPerqs == null ? "0" : ExemptedAllowancesAndPerqs;
            SD = SD == null ? "0" : SD;
            ET = ET == null ? "0" : ET;
            PT = PT == null ? "0" : PT;
            dedUnderSec16 = dedUnderSec16 == null ? "0" : dedUnderSec16;
            incomefrmSalaries = incomefrmSalaries == null ? "0" : incomefrmSalaries;
            grossTotIncome = grossTotIncome == null ? "0" : grossTotIncome;
            totalDedUnderChapterVIA = totalDedUnderChapterVIA == null ? "0" : totalDedUnderChapterVIA;
            totTaxableIncome = totTaxableIncome == null ? "0" : totTaxableIncome;
            otherIncome = otherIncome == null ? "0" : otherIncome;
            creditUS87A = creditUS87A == null ? "0" : creditUS87A;

            //var creditValue = 2000;
            tempValue = Return(basicSalary.value) + Return(taxableAllowance.value) + Return(taxablePerq.value);
            grossSalary.value = tempValue.toFixed(2);
            if (FinYear.value >= 2018) {
                tempValue = Return(SD.value) + Return(ET.value) + Return(PT.value);
            }
            else {
                tempValue = Return(ET.value) + Return(PT.value);
            }
            dedUnderSec16.value = tempValue.toFixed(2);
            tempValue = Return(grossSalary.value) - Return(dedUnderSec16.value);
            incomefrmSalaries.value = tempValue.toFixed(2);
            tempValue = Return(incomefrmSalaries.value) + Return(otherIncome.value);
            grossTotIncome.value = Return(tempValue.toFixed(2));
            tempValue = Return(grossTotIncome.value) - Return(totalDedUnderChapterVIA.value);
            if (tempValue > 0) { totTaxableIncome.value = Math.round(tempValue); }
            else { totTaxableIncome.value = Return(tempValue.toFixed(2)); }
            if (creditUS87A != null) {
                creditUS87A.value = "";
                if (IsInvalidPAN.value == 1) {
                    creditUS87A.value = 0;
                }
                else {
                    if (Return(totTaxableIncome.value) > 200000 && Return(totTaxableIncome.value) <= 500000) {
                        if (FinYear.value >= 2013 && FinYear.value <= 2015) {
                            creditUS87A.value = 2000;
                        }
                        else if (FinYear.value == 2016) {
                            creditUS87A.value = 5000;
                        }
                        else if (FinYear.value > 2016 && FinYear.value <= 2018 && Return(totTaxableIncome.value) <= 350000) {
                            creditUS87A.value = 2500;
                        }
                        else if (FinYear.value >= 2019 && Return(totTaxableIncome.value) <= 500000) {
                            creditUS87A.value = 12500;
                        }
                        else {
                            creditUS87A.value = 0;
                        }
                    }
                }
            } CalculateTax();
        }
        function CalculateTax() {
            var creditUS87A = 0;
            if (document.getElementById("<%=txtCreditUS87A.ClientID%>") != null)
                creditUS87A = document.getElementById("<%=txtCreditUS87A.ClientID%>").value;
            var taxRate = 0;
            var taxes = 0; var eduCess = 0; var taxOnTotalIncome = 0; var rate1 = 10;
            var rate2 = 20; var rate3 = 30;
            var firstSlab = 0, secondSlab = 0, thirdSlab = 0;
            var firstSlabAmt = 0, secondSlabAmt = 0, thirdSlabAmt = 0;
            var IsSeniorCitizen = document.getElementById("<%=hdnIsSeniorCitizen.ClientID%>").value;
            var taxableIncome = document.getElementById("<%=txtTotalTaxableIncome.ClientID%>").value;
            taxableIncome = Return(taxableIncome);
            var IsInvalidPAN = document.getElementById("<%=hdnIsInValidPAN.ClientID%>").value;
            taxOnTotalIncome = 0; var temp = 0;
            var finYear = document.getElementById("<%=hdnFinYear.ClientID%>").value;
            //
            if (Number(finYear) >= 2017)
                rate1 = 5;
            switch (Return(IsSeniorCitizen)) {
                case 0:
                    firstSlab = Number(finYear) > 2013 ? 250000 : 200000;
                    secondSlab = 500000; thirdSlab = 1000000;
                    break;
                case 1:
                    firstSlab = Number(finYear) > 2013 ? 300000 : 250000;
                    secondSlab = 500000; thirdSlab = 1000000;
                    break;
                case 2:
                    rate1 = 20; rate2 = 30;
                    firstSlab = 500000; secondSlab = 1000000;
                    break;
            }
            if (taxableIncome > firstSlab) {
                firstSlabAmt = taxableIncome - firstSlab;
                if (firstSlabAmt >= secondSlab - firstSlab) {
                    secondSlabAmt = secondSlab - firstSlab;
                    taxes = taxes + (secondSlabAmt * rate1 / 100);
                    firstSlabAmt = firstSlabAmt - secondSlabAmt;
                    if (firstSlabAmt >= thirdSlab - secondSlab) {
                        secondSlabAmt = thirdSlab - secondSlab;
                        taxes = taxes + (secondSlabAmt * rate2 / 100);
                        thirdSlabAmt = firstSlabAmt - secondSlabAmt;
                        taxes = taxes + (thirdSlabAmt * rate3 / 100);
                        taxRate = 1;
                    }
                    else {
                        taxes = taxes + (firstSlabAmt * rate2 / 100);
                    }
                }
                else {
                    taxes = taxes + (firstSlabAmt * rate1 / 100);
                }
                taxOnTotalIncome = taxes;
                if (Number(finYear) < 2018) {
                    eduCess = Math.round((taxOnTotalIncome - Math.min(taxOnTotalIncome, creditUS87A)) * 0.03, 0);
                }
                else {
                    eduCess = Math.round((taxOnTotalIncome - Math.min(taxOnTotalIncome, creditUS87A)) * 0.04, 0);
                }
                if (finYear >= 2014 && taxRate == 0) {
                    if (IsSeniorCitizen == 0)
                        if (Return(IsInvalidPAN) == 1) {
                            if ((taxOnTotalIncome / taxableIncome) * 100 < 20) {
                                eduCess = ""; rate1 = 0;
                                document.getElementById("<%=txtCreditUS87A.ClientID%>").value = "";
                                taxOnTotalIncome = (taxableIncome) * 0.2;
                            }
                        }
                    if (IsSeniorCitizen == 1)
                        if (Return(IsInvalidPAN) == 1) {
                            if ((taxOnTotalIncome / taxableIncome) * 100 < 20) {
                                eduCess = ""; rate1 = 0;
                                document.getElementById("<%=txtCreditUS87A.ClientID%>").value = "";
                                taxOnTotalIncome = (taxableIncome) * 0.2;
                            }
                        }
                    if (IsSeniorCitizen == 2)
                        if (Return(IsInvalidPAN) == 1) {
                            if ((taxOnTotalIncome / taxableIncome) * 100 < 20) {
                                eduCess = ""; rate1 = 0;
                                document.getElementById("<%=txtCreditUS87A.ClientID%>").value = "";
                                taxOnTotalIncome = (taxableIncome) * 0.2;
                            }
                        }
                }
                else {
                    if (IsSeniorCitizen == 0)
                        if (Return(IsInvalidPAN) == 1) {
                            if ((taxOnTotalIncome / taxableIncome) * 100 < 20) {
                                eduCess = ""; taxOnTotalIncome = (taxableIncome) * 0.2;
                            }
                        }
                    if (IsSeniorCitizen == 1)
                        if (Return(IsInvalidPAN) == 1) {
                            if ((taxOnTotalIncome / taxableIncome) * 100 < 20) {
                                eduCess = ""; taxOnTotalIncome = (taxableIncome) * 0.2;
                            }
                        }
                    if (IsSeniorCitizen == 2)
                        if (Return(IsInvalidPAN) == 1) {
                            if ((taxOnTotalIncome / taxableIncome) * 100 < 20) {
                                eduCess = ""; taxOnTotalIncome = (taxableIncome) * 0.2;
                            }
                        }
                }
                taxOnTotalIncome = Math.round(taxOnTotalIncome, 0);
            }
            document.getElementById("<%=txtTaxOnTotalIncome.ClientID%>").value = taxOnTotalIncome;
            document.getElementById("<%=txtEduCess.ClientID%>").value = eduCess;
            if (rate1 != 0) {
                if (document.getElementById("<%=txtCreditUS87A.ClientID%>") != null) {
                    creditUS87A = Return(document.getElementById("<%=txtTaxOnTotalIncome.ClientID%>").value) > 0 ? document.getElementById("<%=txtCreditUS87A.ClientID%>").value : "";
                    document.getElementById("<%=txtCreditUS87A.ClientID%>").value = Math.min(Return(document.getElementById("<%=txtCreditUS87A.ClientID%>").value), Return(document.getElementById("<%=txtTaxOnTotalIncome.ClientID%>").value));
                    creditUS87A = document.getElementById("<%=txtCreditUS87A.ClientID%>").value;
                }
            }
            else { creditUS87A = 0; }
            temp = (Return(taxOnTotalIncome) - Return(creditUS87A)) + Return(eduCess);
            document.getElementById("<%=txtTotalITPayable.ClientID%>").value = temp;
            document.getElementById("<%=txtNetTaxPayable.ClientID%>").value = (Return(document.getElementById("<%=txtTotalITPayable.ClientID%>").value) - Return(document.getElementById("<%=txtReliefUnderSection89.ClientID%>").value)).toFixed(2);
            temp = Return(document.getElementById("<%=txtNetTaxPayable.ClientID %>").value) - Return(document.getElementById("<%=txtTotalTDS.ClientID%>").value);
            temp = (Math.round(temp / 10)) * 10;
            if (Return(temp) < 0) {
                document.getElementById("<%=txtTaxPayable.ClientID%>").value = "(" + Math.abs(temp) + ")";
            }
            else { document.getElementById("<%=txtTaxPayable.ClientID%>").value = temp; }
        }
        function Return(tempValue) {
            if (isNaN(tempValue)) {
                tempValue = "0"
                return eval(tempValue);
            }
            else if (tempValue == "" || tempValue == "undefined") {
                return 0;
            }
            else {
                return eval(parseFloat(tempValue).toString());
            }
        }
        function CalculateTaxAmounts() {
            var temp;
            if (document.getElementById("<%=txtCreditUS87A.ClientID%>") != null && document.getElementById("<%=hdnIsInValidPAN.ClientID%>").value == 0) {
                //                document.getElementById("<%=txtCreditUS87A.ClientID%>").value = Return(document.getElementById("<%=txtTotalTaxableIncome.ClientID%>").value) >= 200000 && Return(document.getElementById("<%=txtTotalTaxableIncome.ClientID%>").value) <= 500000 ? (Return(document.getElementById("<%=txtTotalTaxableIncome.ClientID%>").value) <= 500000 && Return(document.getElementById("<%=txtTaxOnTotalIncome.ClientID%>").value) > 0 && Return(document.getElementById("<%=txtTaxOnTotalIncome.ClientID%>").value) <= 2000 ? document.getElementById("<%=txtTaxOnTotalIncome.ClientID%>").value : Return(document.getElementById("<%=txtTaxOnTotalIncome.ClientID%>").value) > 0 ? "2000" : "") : "";
                if (Return(document.getElementById("<%=txtTotalTaxableIncome.ClientID%>").value) > 200000 && Return(document.getElementById("<%=txtTotalTaxableIncome.ClientID%>").value) <= 500000) {
                    if (document.getElementById("<%=hdnFinYear.ClientID%>").value >= 2013 && document.getElementById("<%=hdnFinYear.ClientID%>").value <= 2015) {
                        document.getElementById("<%=txtCreditUS87A.ClientID%>").value = 2000;
                    }
                    else if (document.getElementById("<%=hdnFinYear.ClientID%>").value == 2016) {
                        document.getElementById("<%=txtCreditUS87A.ClientID%>").value = 5000;
                    }
                    else if (document.getElementById("<%=hdnFinYear.ClientID%>").value > 2016 && document.getElementById("<%=hdnFinYear.ClientID%>").value <= 2018 && Return(document.getElementById("<%=txtTotalTaxableIncome.ClientID%>").value) <= 350000) {
                        document.getElementById("<%=txtCreditUS87A.ClientID%>").value = 2500;
                    }
                    else if (document.getElementById("<%=hdnFinYear.ClientID%>").value >= 2019 && Return(document.getElementById("<%=txtTotalTaxableIncome.ClientID%>").value) <= 500000) {
                        document.getElementById("<%=txtCreditUS87A.ClientID%>").value = 12500;
                    }
                    else {
                        document.getElementById("<%=txtCreditUS87A.ClientID%>").value = 0;
                    }
                }
                if (Return(document.getElementById("<%=txtTaxOnTotalIncome.ClientID%>").value) < Return(document.getElementById("<%=txtCreditUS87A.ClientID%>").value)) {
                    document.getElementById("<%=txtCreditUS87A.ClientID%>").value = document.getElementById("<%=txtTaxOnTotalIncome.ClientID%>").value;
                }

            }
            else {
                document.getElementById("<%=txtCreditUS87A.ClientID%>").value = "";
            }
            var creditUS87A = (document.getElementById("<%=txtCreditUS87A.ClientID%>") != null && Return(document.getElementById("<%=txtTaxOnTotalIncome.ClientID%>").value) > 0) ? document.getElementById("<%=txtCreditUS87A.ClientID%>").value : "";
            var IsInvalidPAN = document.getElementById("<%=hdnIsInValidPAN.ClientID%>").value;
            var FinYear = document.getElementById("<%=hdnFinYear.ClientID%>").value;
            if (FinYear < 2018) {
                document.getElementById("<%=txtEduCess.ClientID%>").value = Math.round(Math.floor((Return(document.getElementById("<%=txtTaxOnTotalIncome.ClientID%>").value) - (document.getElementById("<%=txtCreditUS87A.ClientID%>") != null ? Return(document.getElementById("<%=txtCreditUS87A.ClientID%>").value) : 0)) * 0.03)).toFixed(2);
            }
            else {
                document.getElementById("<%=txtEduCess.ClientID%>").value = Math.round(Math.floor((Return(document.getElementById("<%=txtTaxOnTotalIncome.ClientID%>").value) - (document.getElementById("<%=txtCreditUS87A.ClientID%>") != null ? Return(document.getElementById("<%=txtCreditUS87A.ClientID%>").value) : 0)) * 0.04)).toFixed(2);
            }
            document.getElementById("<%=txtTotalITPayable.ClientID%>").value = (Return(document.getElementById("<%=txtTaxOnTotalIncome.ClientID%>").value) - Return(creditUS87A)) + Return(document.getElementById("<%=txtSurcharge.ClientID%>").value) + Return(document.getElementById("<%=txtEduCess.ClientID%>").value);
            temp = Return(document.getElementById("<%=txtTotalITPayable.ClientID %>").value) - Return(document.getElementById("<%=txtReliefUnderSection89.ClientID %>").value);
            document.getElementById("<%=txtNetTaxPayable.ClientID %>").value = temp.toFixed(2);
            temp = Return(document.getElementById("<%=txtNetTaxPayable.ClientID %>").value) - Return(document.getElementById("<%=txtTotalTDS.ClientID%>").value);
            temp = (Math.round(temp / 10)) * 10;
            if (Return(temp) < 0) {
                document.getElementById("<%=txtTaxPayable.ClientID%>").value = "(" + Math.abs(temp) + ")";
            }
            else {
                document.getElementById("<%=txtTaxPayable.ClientID%>").value = temp;
            }
        }
        function GetUserNameValue(source, eventArgs) {
            var content = eventArgs.get_value();
            var arr = new Array();
            arr = content.split('-');
            if (arr.length == 4) {
                document.getElementById("<%=hdnDeducteeID.ClientID%>").value = arr[0];
                document.getElementById("<%=hdnGender.ClientID%>").value = arr[1];
                document.getElementById("<%=hdnIsSeniorCitizen.ClientID%>").value = arr[2];
                document.getElementById("<%=hdnIsInValidPAN.ClientID%>").value = arr[3];
            }
            else {
                document.getElementById("<%=hdnDeducteeID.ClientID%>").value = arr[1];
                document.getElementById("<%=hdnGender.ClientID%>").value = arr[5];
                document.getElementById("<%=hdnIsSeniorCitizen.ClientID%>").value = arr[4];
                document.getElementById("<%=lblEmpDetails.ClientID%>").style.display = '';
                document.getElementById("<%=hdnEmpDetails.ClientID%>").value = arr[2] + "-" + arr[3];
                document.getElementById("<%=hdnIsInValidPAN.ClientID%>").value = (arr[3] == "PANINVALID" || arr[3] == "PANAPPLIED" || arr[3] == "PANNOTAVBL") ? "1" : "0";
            }
        }
        function ClearUserName() {
            if (event.keyCode == 13 || event.keyCode == 37 || event.keyCode == 38 || event.keyCode == 39 || event.keyCode == 40) {
            }
            else {
                document.getElementById("<%=hdnDeducteeID.ClientID%>").value = "-1";
                document.getElementById("<%=hdnIsLoaded.ClientID%>").value = "False";
            }
        }
        function LoadData() {
            var IsSB = document.getElementById("<%=hdnIsSB.ClientID%>").value;
            var text = IsSB == "1" ? "Employee No." : "Employee Name";
            if (document.getElementById("<%=hdnDeducteeID.ClientID%>").value == "-1") {
                alert("Specify Valid " + text);
                document.getElementById("<%=txtName.ClientID%>").focus();
                return false;
            }
            else {
                document.getElementById("<%=hdnIsLoaded.ClientID%>").value = "True";
                return true;
            }
        }
        function ValidateChapterVIDeds() {
            if (document.getElementById("<%=cmbSection.ClientID%>").value == "4" || document.getElementById("<%=cmbSection.ClientID%>").value == "20") {
                if (document.getElementById("<%=txtGrossAmount.ClientID%>").value != "") {
                    if (ValidateTotDedAmounts(document.getElementById("<%=hdn80CDeductible.ClientID%>"),
                                     document.getElementById("<%=hdn80CCC.ClientID%>"),
                                     document.getElementById("<%=hdn80CCD.ClientID%>"), document.getElementById("<%=txtDeductibleAmount.ClientID%>"))) {
                        UpdateChapterVIATot();
                    }
                    else return false;
                }
            }
        }
        function ValidateTotDedAmounts(hdn80CValue, hdn80CCCValue, hdn80CCDValue, deductibleAmnt) {
            var hdnFinYear = document.getElementById("<%=hdnFinYear.ClientID %>").value;
            if (hdnFinYear <= 2013) {
                if (Return(document.getElementById("<%=hdn80CDeductible.ClientID%>").value) + Return(document.getElementById("<%=hdn80CCC.ClientID%>").value) + Return(document.getElementById("<%=hdn80CCD.ClientID%>").value) > 100000) {
                    alert("Since Total Deductible amounts U/s 80C,80CCC,80CCD1 are crossing Rs.1,00,000\nit should be limited to Rs.1,00,000/-");
                    document.getElementById("<%=txtDeductibleAmount.ClientID%>").focus();
                    return false;
                }
            }
            else {
                if (Return(document.getElementById("<%=hdn80CDeductible.ClientID%>").value) + Return(document.getElementById("<%=hdn80CCC.ClientID%>").value) + Return(document.getElementById("<%=hdn80CCD.ClientID%>").value) > 150000) {
                    alert("Since Total Deductible amounts U/s 80C,80CCC,80CCD1 are crossing Rs.1,50,000\nit should be limited to Rs.1,50,000/-");
                    document.getElementById("<%=txtDeductibleAmount.ClientID%>").focus();
                    return false;
                }
            } return true;
        }
        function SetValues() {
            switch (document.getElementById("<%=cmbSection.ClientID%>").value) {
                case "3": document.getElementById("<%=hdn80C.ClientID%>").value = Return(document.getElementById("<%=txtDeductibleAmount.ClientID%>").value); break;
                case "4": document.getElementById("<%=hdn80CCC.ClientID%>").value = Return(document.getElementById("<%=txtDeductibleAmount.ClientID%>").value); break;
                case "5":
                case "20":
                    document.getElementById("<%=hdn80CCD.ClientID%>").value = Return(document.getElementById("<%=txtDeductibleAmount.ClientID%>").value); break;
            }
        }
        function ValidateTotalDeductibleAmnt() {
            var rbnValue3 = document.getElementById("<%=rbnValue3.ClientID%>")

            if (rbnValue3 == null)
                rbnValue3 = document.getElementById("<%=rbnValue2.ClientID%>")

            if (ValidateTotalDeductibleAmount(document.getElementById("<%=cmbSection.ClientID%>"),
                                                            document.getElementById("<%=rbnValue2.ClientID%>"),
                                                            rbnValue3,
                                                            document.getElementById("<%=txtGrossAmount.ClientID%>"),
                                                            document.getElementById("<%=txtQualifyingAmount.ClientID%>"),
                                                            document.getElementById("<%=txtDeductibleAmount.ClientID %>"))) {
                SetValues();
            }
            else {
                return false;
            }
        }
        function ValidateTotalDeductibleAmount(section, value2, value3, grossAmnt, qualifyingAmnt, deductibleAmnt) {
            var minVal, maxVal;
            var finYear = document.getElementById("<%=hdnFinYear.ClientID%>").value;
            var txtGrossAmount = document.getElementById("<%=txtGrossAmount.ClientID%>").value;
            var txtQualifyingAmount = document.getElementById("<%=txtQualifyingAmount.ClientID%>").value;
            var txtDeductibleAmount = document.getElementById("<%=txtDeductibleAmount.ClientID%>").value;

            if (Return(qualifyingAmnt.value) > Return(grossAmnt.value)) {
                alert("Qualifying Amount cannot exceed Gross Amount.");
                return false;
            }
            else if (Return(deductibleAmnt.value) > Return(qualifyingAmnt.value)) {
                alert("Ded Amount cannot exceed Qualifying Amount.");
                return false;
            }
            else {
                switch (section.value) {
                    case "3":
                        if ((Return(qualifyingAmnt.value)) > (((document.getElementById("<%=hdnFinYear.ClientID%>").value) > 2013) ? 150000 : 100000)) {
                            qualifyingAmnt.value = ((document.getElementById("<%=hdnFinYear.ClientID%>").value) > 2013) ? 150000 : 100000;
                            deductibleAmnt.value = ((document.getElementById("<%=hdnFinYear.ClientID%>").value) > 2013) ? 150000 : 100000;
                        }
                        else if (Return(deductibleAmnt.value) > Return(qualifyingAmnt.value)) {
                            alert("Deductible Amount cannot exceed Qualifying Amount.");
                            return false;
                        }
                        break;
                    case "4":
                        if (Return(qualifyingAmnt.value) > ((Number(finYear) > 2014) ? 150000 : 100000)) {
                            qualifyingAmnt.value = ((Number(finYear) > 2014) ? 150000 : 100000);
                            deductibleAmnt.value = ((Number(finYear) > 2014) ? 150000 : 100000);
                        }
                        else if (Return(deductibleAmnt.value) > Return(qualifyingAmnt.value)) {
                            alert("Deductible Amount cannot exceed Qualifying Amount.");
                            return false;
                        }
                        break;
                    case "5":
                        if (Return(deductibleAmnt.value) > Return(qualifyingAmnt.value)) {
                            alert("Deductible Amount cannot exceed Qualifying Amount.");
                            return false;
                        }
                        break;
                    case "6":
                        if (Number(finYear) <= 2017)
                            maxVal = ((Number(finYear) > 2014) ? 60000 : 40000);
                        else
                            maxVal = 125000;

                        minVal = ((Number(finYear) > 2014) ? 50000 : 30000);
                        if (value2.checked) {
                            if (Return(document.getElementById("<%=txtQualifyingAmount.ClientID%>").value) > maxVal) {
                                document.getElementById("<%=txtQualifyingAmount.ClientID %>").value = maxVal;
                                document.getElementById("<%=txtDeductibleAmount.ClientID %>").value = maxVal;
                            }
                        } else {
                            if (Return(qualifyingAmnt.value) > minVal) {
                                if (Return(deductibleAmnt.value) > minVal) {
                                    qualifyingAmnt.value = minVal;
                                    deductibleAmnt.value = minVal;
                                }
                                else {
                                    qualifyingAmnt.value = minVal;
                                }
                            }
                            else if (Return(deductibleAmnt.value) > Return(qualifyingAmnt.value)) {
                                alert("Deductible Amount cannot exceed Qualifying Amount.");
                                deductibleAmnt.focus();
                                return false;
                            }
                        }
                        break;
                    case "7":
                        maxVal = ((Number(finYear) > 2014) ? 125000 : 100000);
                        minVal = ((Number(finYear) > 2014) ? 75000 : 50000);
                        if (value2.checked) {
                            if (Return(qualifyingAmnt.value) > maxVal) {
                                qualifyingAmnt.value = maxVal;
                                deductibleAmnt.value = maxVal;
                            }
                        }
                        else {
                            if (Return(qualifyingAmnt.value) > minVal) {
                                if (Return(deductibleAmnt.value) > minVal) {
                                    qualifyingAmnt.value = minVal;
                                    deductibleAmnt.value = minVal;
                                }
                                else {
                                    document.getElementById("<%=txtQualifyingAmount.ClientID %>").value = minVal;
                                }
                            }
                            else if (Return(deductibleAmnt.value) > Return(qualifyingAmnt.value)) {
                                alert("Deductible Amount cannot exceed Qualifying Amount.");
                                deductibleAmnt.focus();
                                return false;
                            }
                        }
                        break;
                    case "8":
                        maxVal = ((Number(finYear) >= 2016) ? 80000 : 0);
                        if (Number(finYear) <= 2017) {
                            if (value3.checked) {
                                if (Return(qualifyingAmnt.value) > maxVal) {
                                    qualifyingAmnt.value = maxVal;
                                    deductibleAmnt.value = maxVal;
                                }
                            }
                        }
                        else
                            maxVal = 100000;

                        if (value2.checked) {
                            if (Number(finYear) <= 2017) {
                                if (Return(qualifyingAmnt.value) > 60000) {
                                    qualifyingAmnt.value = 60000;
                                    deductibleAmnt.value = 60000;
                                }
                            }
                            else {
                                if (Return(qualifyingAmnt.value) > maxVal) {
                                    qualifyingAmnt.value = maxVal;
                                    deductibleAmnt.value = maxVal;
                                }
                            }
                        }
                        else if (value3.checked) {
                            if (Number(finYear) <= 2017) {
                                if (Return(qualifyingAmnt.value) > 80000) {
                                    qualifyingAmnt.value = 80000;
                                    deductibleAmnt.value = 80000;
                                }
                            }
                            else {
                                if (Return(qualifyingAmnt.value) > maxVal) {
                                    qualifyingAmnt.value = maxVal;
                                    deductibleAmnt.value = maxVal;
                                }
                            }
                        }
                        else {
                            if (Return(qualifyingAmnt.value) > 40000) {
                                if (Return(deductibleAmnt.value) > 40000) {
                                    qualifyingAmnt.value = 40000;
                                    deductibleAmnt.value = 40000;
                                }
                                else {
                                    qualifyingAmnt.value = 40000;
                                }
                            }
                            else if (Return(deductibleAmnt.value) > Return(qualifyingAmnt.value)) {
                                alert("Deductible Amount cannot exceed Qualifying Amount.");
                                deductibleAmnt.focus();
                                return false;
                            }
                        }
                        break;
                    case "9":
                        if (Return(deductibleAmnt.value) > Return(qualifyingAmnt.value)) {
                            alert("Deductible Amount cannot exceed Qualifying Amount.");
                            return false;
                        }
                        break;
                    case "10":
                        if (Return(deductibleAmnt.value) > Return(qualifyingAmnt.value)) {
                            alert("Deductible Amount cannot exceed Qualifying Amount.");
                            return false;
                        }
                        break;
                    case "11":
                        maxVal = ((Number(finYear) >= 2016) ? 60000 : 24000);
                        if (Return(qualifyingAmnt.value) > maxVal) {
                            qualifyingAmnt.value = maxVal;
                            deductibleAmnt.value = maxVal;
                        }
                        else if (Return(deductibleAmnt.value) > Return(qualifyingAmnt.value)) {
                            alert("Deductible Amount cannot exceed Qualifying Amount.");
                            return false;
                        }
                        break;
                    case "12":
                    case "13":
                        if (Return(qualifyingAmnt.value) > 300000) {
                            qualifyingAmnt.value = 300000;
                            deductibleAmnt.value = 300000;
                        }
                        else if (Return(deductibleAmnt.value) > Return(qualifyingAmnt.value)) {
                            alert("Deductible Amount cannot exceed Qualifying Amount.");
                            return false;
                        }
                        break;
                    case "14":
                        maxVal = ((Number(finYear) > 2014) ? 125000 : 100000);
                        minVal = ((Number(finYear) > 2014) ? 75000 : 50000);
                        if (value2.checked) {
                            if (Return(qualifyingAmnt.value) > maxVal) {
                                qualifyingAmnt.value = maxVal;
                                deductibleAmnt.value = maxVal;
                            }
                        }
                        else {
                            if (Return(qualifyingAmnt.value) > minVal) {
                                if (Return(deductibleAmnt.value) > minVal) {
                                    qualifyingAmnt.value = minVal;
                                    deductibleAmnt.value = minVal;
                                }
                                else {
                                    qualifyingAmnt.value = minVal;
                                }
                            }
                            else if (Return(deductibleAmnt.value) > Return(qualifyingAmnt.value)) {
                                alert("Deductible Amount cannot exceed Qualifying Amount.");
                                deductibleAmnt.focus();
                                return false;
                            }
                        }
                        break;
                    case "15":
                        if (Return(qualifyingAmnt.value) > 20000) {
                            qualifyingAmnt.value = 20000;
                            deductibleAmnt.value = 20000;
                        }
                        else if (Return(deductibleAmnt.value) > Return(qualifyingAmnt.value)) {
                            alert("Deductible Amount cannot exceed Qualifying Amount.");
                            return false;
                        }
                        break;
                    case "18":
                        if (Number(finYear) >= 2018) {
                            var isSeniorCitizen = document.getElementById("<%=hdnIsSeniorCitizen.ClientID%>").value;
                            if (txtGrossAmount != "" && txtQualifyingAmount != "" && txtDeductibleAmount != "") {
                                if (isSeniorCitizen == "1" || isSeniorCitizen == "2") {
                                    alert("Deduction u/s 80TTA is not applicable for employee above 60 years \nUse 80TTB to avail deduction on account of interest from Savings Deposit");
                                    return false;
                                }
                            }
                        }
                        break;
                    case "19":
                        if (Return(deductibleAmnt.value) > 25000) {
                            deductibleAmnt.value = 25000;
                        }
                        else if (Return(deductibleAmnt.value) > Return(qualifyingAmnt.value)) {
                            alert("Deductible Amount cannot exceed Qualifying Amount.");
                            return false;
                        }
                        break;
                    case "23":
                        if (Return(deductibleAmnt.value) > 50000) {
                            deductibleAmnt.value = 50000;
                        }
                        else if (Return(deductibleAmnt.value) > Return(qualifyingAmnt.value)) {
                            alert("Deductible Amount cannot exceed Qualifying Amount.");
                            return false;
                        }
                        break;
                    case "25":
                        if (Number(finYear) >= 2018) {
                            var isSeniorCitizen = document.getElementById("<%=hdnIsSeniorCitizen.ClientID%>").value;
                            if (txtGrossAmount != "" && txtQualifyingAmount != "" && txtDeductibleAmount != "") {
                                if (isSeniorCitizen == "0") {
                                    alert("Deduction u/s 80TTB is not applicable for employee below 60 years \nUse 80TTA to avail deduction on account of interest from Savings Deposit");
                                    return false;
                                }
                            }
                        }
                        break;
                }
            } return true;
        }
        function SetLimitValues() {
            var minVal, maxVal;
            var finYear = document.getElementById("<%=hdnFinYear.ClientID%>").value;
            switch (document.getElementById("<%=cmbSection.ClientID%>").value) {
                case "6":
                    minVal = (Number(finYear) > 2014) ? "50000" : "30000";

                    if (Number(finYear) > 2014 && Number(finYear) < 2017)
                        maxVal = (Number(finYear) > 2014) ? "60000" : "40000";
                    else
                        maxVal = "100000";

                    if (document.getElementById("<%=rbnValue1.ClientID%>").checked) {
                        if (confirm("Do you want to set the Qualifying Amount for the section 80D to " + minVal + "?")) {
                            if (document.getElementById("<%=txtGrossAmount.ClientID%>").value == "")
                                document.getElementById("<%=txtGrossAmount.ClientID%>").value = minVal;
                            document.getElementById("<%=txtQualifyingAmount.ClientID%>").value = minVal;
                            document.getElementById("<%=txtDeductibleAmount.ClientID%>").value = minVal;
                        }
                        else {
                            document.getElementById("<%=rbnValue2.ClientID%>").checked = true;
                        }
                    }
                    else if (Return(document.getElementById("<%=txtQualifyingAmount.ClientID%>").value) != 0 && document.getElementById("<%=rbnValue2.ClientID%>").checked) {
                        if (confirm("Qualifying Amount for the section 80D is " + document.getElementById("<%=txtQualifyingAmount.ClientID%>").value + ".\nDo you want to set it to " + maxVal + "?")) {
                            if (document.getElementById("<%=txtGrossAmount.ClientID%>").value == "")
                                document.getElementById("<%=txtGrossAmount.ClientID%>").value = minVal;
                            document.getElementById("<%=txtQualifyingAmount.ClientID%>").value = maxVal;
                            document.getElementById("<%=txtDeductibleAmount.ClientID%>").value = maxVal;
                        }
                        else {
                            document.getElementById("<%=rbnValue2.ClientID%>").checked = false;
                        }
                    }
                    break;
                case "7":
                case "14":
                    var secName;
                    if (document.getElementById("<%=cmbSection.ClientID%>").value == "7")
                        secName = "80DD";
                    else { secName = "80U"; }
                    minVal = (Number(finYear) > 2014) ? "75000" : "50000"; maxVal = (Number(finYear) > 2014) ? "125000" : "100000";
                    if (document.getElementById("<%=rbnValue1.ClientID%>").checked) {
                        if (confirm("Do you want to set the Qualifying Amount for the section " + secName + " to " + minVal + "?")) {
                            if (document.getElementById("<%=txtGrossAmount.ClientID%>").value == "")
                                document.getElementById("<%=txtGrossAmount.ClientID%>").value = minVal;
                            document.getElementById("<%=txtQualifyingAmount.ClientID%>").value = minVal;
                            document.getElementById("<%=txtDeductibleAmount.ClientID%>").value = minVal;
                        }
                        else {
                            document.getElementById("<%=rbnValue2.ClientID%>").checked = true;
                        }
                    }
                    else if (Return(document.getElementById("<%=txtQualifyingAmount.ClientID%>").value) != 0 && document.getElementById("<%=rbnValue2.ClientID%>").checked) {
                        if (confirm("Qualifying Amount for the section " + secName + " is " + document.getElementById("<%=txtQualifyingAmount.ClientID%>").value + ".\nDo you want to set it to " + maxVal + "?")) {
                            if (document.getElementById("<%=txtGrossAmount.ClientID%>").value == "")
                                document.getElementById("<%=txtGrossAmount.ClientID%>").value = minVal;
                            document.getElementById("<%=txtQualifyingAmount.ClientID%>").value = maxVal;
                            document.getElementById("<%=txtDeductibleAmount.ClientID%>").value = maxVal;
                        }
                        else {
                            document.getElementById("<%=rbnValue2.ClientID%>").checked = false;
                        }
                    }
                    break;
                case "8":
                    minVal = "40000";

                    if (Number(finYear) >= 2016 && Number(finYear) <= 2017)
                        maxVal = (Number(finYear) >= 2016) ? "80000" : "0";
                    else
                        maxVal = "100000";

                    if (document.getElementById("<%=rbnValue1.ClientID%>").checked) {
                        if (confirm("Do you want to set the Qualifying Amount for the section 80DDB to " + minVal + "?")) {
                            if (document.getElementById("<%=txtGrossAmount.ClientID%>").value == "")
                                document.getElementById("<%=txtGrossAmount.ClientID%>").value = minVal;
                            document.getElementById("<%=txtQualifyingAmount.ClientID%>").value = minVal;
                            document.getElementById("<%=txtDeductibleAmount.ClientID%>").value = minVal;
                        }
                        else {
                            document.getElementById("<%=rbnValue2.ClientID%>").checked = true;
                        }
                    }
                    else if (Return(document.getElementById("<%=txtQualifyingAmount.ClientID%>").value) != 0 && document.getElementById("<%=rbnValue2.ClientID%>").checked) {
                        if (Number(finYear) > 2017) {
                            if (confirm("Qualifying Amount for the section 80DDB is " + document.getElementById("<%=txtQualifyingAmount.ClientID%>").value + ".\nDo you want to set it to " + maxVal + "?")) {
                                if (document.getElementById("<%=txtGrossAmount.ClientID%>").value == "")
                                    document.getElementById("<%=txtGrossAmount.ClientID%>").value = maxVal;
                                document.getElementById("<%=txtQualifyingAmount.ClientID%>").value = maxVal;
                                document.getElementById("<%=txtDeductibleAmount.ClientID%>").value = maxVal;
                            }
                            else {
                                document.getElementById("<%=rbnValue2.ClientID%>").checked = false;
                                document.getElementById("<%=rbnValue3.ClientID%>").checked = true;
                            }
                        }
                        else {
                            if (confirm("Qualifying Amount for the section 80DDB is " + document.getElementById("<%=txtQualifyingAmount.ClientID%>").value + ".\nDo you want to set it to " + "60000" + "?")) {
                                if (document.getElementById("<%=txtGrossAmount.ClientID%>").value == "")
                                    document.getElementById("<%=txtGrossAmount.ClientID%>").value = "60000";
                                document.getElementById("<%=txtQualifyingAmount.ClientID%>").value = "60000";
                                document.getElementById("<%=txtDeductibleAmount.ClientID%>").value = "60000";
                            }
                            else {
                                document.getElementById("<%=rbnValue2.ClientID%>").checked = false;
                                document.getElementById("<%=rbnValue3.ClientID%>").checked = true;
                            }
                        }
                    }
                    else if (Return(document.getElementById("<%=txtQualifyingAmount.ClientID%>").value) != 0 && document.getElementById("<%=rbnValue3.ClientID%>").checked) {
                        if (confirm("Qualifying Amount for the section 80DDB is " + document.getElementById("<%=txtQualifyingAmount.ClientID%>").value + ".\nDo you want to set it to " + maxVal + "?")) {
                            if (document.getElementById("<%=txtGrossAmount.ClientID%>").value == "")
                                document.getElementById("<%=txtGrossAmount.ClientID%>").value = maxVal;
                            document.getElementById("<%=txtQualifyingAmount.ClientID%>").value = maxVal;
                            document.getElementById("<%=txtDeductibleAmount.ClientID%>").value = maxVal;
                        }
                        else {
                            document.getElementById("<%=rbnValue3.ClientID%>").checked = false;
                        }
                    }
                    break;
            }
        }
        function SetQualifyingAmount() {
            var maxVal; var minVal;
            var sectionID = document.getElementById("<%=hdnSalarySection.ClientID%>").value;
            var rbtnValue1 = document.getElementById("<%=rbnValue1.ClientID%>");
            var rbtnValue2 = document.getElementById("<%=rbnValue2.ClientID%>");
            var rbtnValue3 = document.getElementById("<%=rbnValue3.ClientID%>");
            var finYear = Number(document.getElementById("<%=hdnFinYear.ClientID%>").value);
            var qualifyingAmt = 0;
            switch (sectionID) {
                case "80C": qualifyingAmt = Number(finYear) > 2013 ? 150000 : 100000; break;
                case "80CCC": qualifyingAmt = Number(finYear) > 2014 ? 150000 : 100000; break;
                case "80CCG": qualifyingAmt = Math.ceil(Return(document.getElementById("<%=txtGrossAmount.ClientID%>").value) / 2); break;
                case "80D":
                    if (rbtnValue2.checked) {
                        if (Number(finYear) <= 2017)
                            qualifyingAmt = finYear > 2014 ? 60000 : 40000;
                        else
                            qualifyingAmt = 100000;
                    }
                    else
                        qualifyingAmt = finYear > 2014 ? 50000 : 30000;
                    break;
                case "80DD":
                    maxVal = ((Number(finYear) > 2014) ? 125000 : 100000);
                    minVal = ((Number(finYear) > 2014) ? 75000 : 50000);
                    if ((!rbtnValue1.checked && !rbtnValue2.checked) || rbtnValue1.checked)
                        qualifyingAmt = minVal;
                    else if (rbtnValue2.checked)
                        qualifyingAmt = maxVal;
                    break;
                case "80DDB":
                    maxVal = ((Number(finYear) >= 2016) ? 80000 : 0);
                    if (Number(finYear) <= 2017) {
                        if ((!rbtnValue1.checked && !rbtnValue2.checked && !rbtnValue3.checked) || rbtnValue1.checked)
                            qualifyingAmt = 40000;
                        else if (rbtnValue2.checked)
                            qualifyingAmt = 60000;
                        else if (rbtnValue3.checked)
                            qualifyingAmt = maxVal;
                    }
                    else {
                        if ((!rbtnValue1.checked && !rbtnValue2.checked) || rbtnValue1.checked)
                            qualifyingAmt = 40000;
                        else if (rbtnValue2.checked)
                            qualifyingAmt = 100000;
                    }
                    break;
                case "80GG": qualifyingAmt = finYear >= 2016 ? 60000 : 24000; break;
                case "80QQB": qualifyingAmt = 300000; break;
                case "RRB": qualifyingAmt = 300000; break;
                case "80TTA": qualifyingAmt = finYear <= 2018 ? 10000 : 10000; break;
                case "80TTB": qualifyingAmt = 50000; break;
                case "80U":
                    maxVal = ((Number(finYear) > 2014) ? 125000 : 100000);
                    minVal = ((Number(finYear) > 2014) ? 75000 : 50000);
                    if ((!rbtnValue1.checked && !rbtnValue2.checked) || rbtnValue1.checked)
                        qualifyingAmt = minVal;
                    else if (rbtnValue2.checked)
                        qualifyingAmt = maxVal;
                    break;
                case "80CCD(1B)": qualifyingAmt = 50000; break;
            }
            if (Return(document.getElementById("<%=txtGrossAmount.ClientID%>").value) > 0) {
                if (document.getElementById("<%=txtQualifyingAmount.ClientID%>").value == "") {
                    if (sectionID != "80CCG")
                        document.getElementById("<%=txtQualifyingAmount.ClientID%>").value = document.getElementById("<%=txtGrossAmount.ClientID%>").value;
                    else
                        document.getElementById("<%=txtQualifyingAmount.ClientID%>").value = qualifyingAmt;
                } CheckQualifyingAmount();
            }
            else document.getElementById("<%=txtQualifyingAmount.ClientID%>").value = "";
        }

        function CheckQualifyingAmount() {
            var maxVal; var minVal;
            var sectionID = document.getElementById("<%=hdnSalarySection.ClientID%>").value;
            var qualifying = document.getElementById("<%=txtQualifyingAmount.ClientID%>").value;
            var gross = document.getElementById("<%=txtGrossAmount.ClientID%>").value;
            var rbtnValue1 = document.getElementById("<%=rbnValue1.ClientID%>");
            var rbtnValue2 = document.getElementById("<%=rbnValue2.ClientID%>");
            var rbtnValue3 = document.getElementById("<%=rbnValue3.ClientID%>");
            var finYear = Number(document.getElementById("<%=hdnFinYear.ClientID%>").value);
            var HasError = "0";
            if (Return(qualifying) > Return(gross)) {
                document.getElementById("<%=txtQualifyingAmount.ClientID%>").value = document.getElementById("<%=txtGrossAmount.ClientID%>").value;
            }
            switch (sectionID) {
                case "80C":
                    if (Number(finYear) <= 2013) {
                        if (Return(qualifying) > 100000) {
                            alert("Maximum Qualifying Amount for the section 80C is 1,00,000.\nQualifying amount is limited to 1,00,000");
                            document.getElementById("<%=txtQualifyingAmount.ClientID%>").value = "100000";
                        }
                    }
                    else if (Number(finYear) >= 2014) {
                        if (Return(qualifying) > 150000) {
                            alert("Maximum Qualifying Amount for the section 80C is 1,50,000.\nQualifying amount is limited to 1,50,000");
                            document.getElementById("<%=txtQualifyingAmount.ClientID%>").value = "150000";
                        }
                    } break;
                case "80EE":
                    if (Return(qualifying) > 100000) {
                        alert("Maximum Qualifying Amount for the section 80EE is 1,00,000.\nQualifying amount is limited to 1,00,000");
                        document.getElementById("<%=txtQualifyingAmount.ClientID%>").value = "100000";
                    } break;
                case "80CCC":
                    if (Return(qualifying) > 100000) {
                        alert("Maximum Qualifying Amount for the section 80CCC is 1,00,000.\nQualifying amount is limited to 1,00,000");
                        document.getElementById("<%=txtQualifyingAmount.ClientID%>").value = "100000";
                    } break;
                case "80CCG":
                    if (Return(qualifying) > Math.ceil(Return(gross) / 2)) {
                        alert("Maximum Qualifying Amount for the section 80CCG is " + Math.ceil(Return(gross) / 2) + ".\nQualifying amount is limited to " + Math.ceil(Return(gross) / 2));
                        document.getElementById("<%=txtQualifyingAmount.ClientID%>").value = Math.ceil(Return(gross) / 2);
                    } break;
                case "80D":
                    if (finYear < 2015) {
                        if ((!rbtnValue1.checked && !rbtnValue2.checked) || rbtnValue1.checked) {
                            if (Return(qualifying) > 30000) {
                                alert("Maximum Qualifying Amount for the section 80D is 30,000.\nQualifying amount is limited to 30,000");
                                document.getElementById("<%=txtQualifyingAmount.ClientID%>").value = "30000";
                            }
                        }
                        else if (rbtnValue2.checked) {
                            if (Return(qualifying) > 40000) {
                                alert("Maximum Qualifying Amount for the section 80D is 40,000.\nQualifying amount is limited to 40,000");
                                document.getElementById("<%=txtQualifyingAmount.ClientID%>").value = "40000";
                            }
                        }
                    }
                    else {
                        if ((!rbtnValue1.checked && !rbtnValue2.checked) || rbtnValue1.checked) {
                            if (Return(qualifying) > 50000) {
                                alert("Maximum Qualifying Amount for the section 80D is 50,000.\nQualifying amount is limited to 50,000");
                                document.getElementById("<%=txtQualifyingAmount.ClientID%>").value = "50000";
                            }
                        }
                        else if (rbtnValue2.checked) {
                            if (Number(finYear) <= 2017) {
                                if (Return(qualifying) > 60000) {
                                    alert("Maximum Qualifying Amount for the section 80D is 60,000.\nQualifying amount is limited to 60,000");
                                    document.getElementById("<%=txtQualifyingAmount.ClientID%>").value = "60000";
                                }
                            }
                            else {
                                if (Return(qualifying) > 100000) {
                                    alert("Maximum Qualifying Amount for the section 80D is 1,00,000.\nQualifying amount is limited to 1,00,000");
                                    document.getElementById("<%=txtQualifyingAmount.ClientID%>").value = "100000";
                                }
                            }
                        }
                    } break;
                case "80DD":
                    maxVal = ((Number(finYear) > 2014) ? 125000 : 100000);
                    minVal = ((Number(finYear) > 2014) ? 75000 : 50000);
                    if ((!rbtnValue1.checked && !rbtnValue2.checked) || rbtnValue1.checked) {
                        if (Return(qualifying) > minVal) {
                            alert("Maximum Qualifying Amount for the section 80DD is " + ((Number(finYear) > 2014) ? "75,000" : "50,000") + ".\nQualifying amount is limited to " + ((Number(finYear) > 2014) ? "75,000" : "50,000"));
                            document.getElementById("<%=txtQualifyingAmount.ClientID%>").value = (Number(finYear) > 2014) ? "75000" : "50000";
                        }
                    }
                    else if (rbtnValue2.checked) {
                        if (Return(qualifying) > maxVal) {
                            alert("Maximum Qualifying Amount for the section 80DD is " + ((Number(finYear) > 2014) ? "1,25,000" : "1,00,000") + ".\nQualifying amount is limited to " + ((Number(finYear) > 2014) ? "1,25,000" : "1,00,000"));
                            document.getElementById("<%=txtQualifyingAmount.ClientID%>").value = (Number(finYear) > 2014) ? "125000" : "100000";
                        }
                    }
                    break;
                case "80DDB":
                    if (Number(finYear) <= 2017) {
                        if ((!rbtnValue1.checked && !rbtnValue2.checked && !rbtnValue3.checked) || rbtnValue1.checked) {
                            if (Return(qualifying) > 40000) {
                                alert("Maximum Qualifying Amount for the section 80DDB is 40,000.\nQualifying amount is limited to 40,000");
                                document.getElementById("<%=txtQualifyingAmount.ClientID%>").value = "40000";
                            }
                        }
                    }
                    else {
                        if ((!rbtnValue1.checked && !rbtnValue2.checked) || rbtnValue1.checked) {
                            if (Return(qualifying) > 40000) {
                                alert("Maximum Qualifying Amount for the section 80DDB is 40,000.\nQualifying amount is limited to 40,000");
                                document.getElementById("<%=txtQualifyingAmount.ClientID%>").value = "40000";
                            }
                        }
                    }
                    if (rbtnValue2.checked) {
                        if (Number(finYear) <= 2017) {
                            if (Return(qualifying) > 60000) {
                                alert("Maximum Qualifying Amount for the section 80DDB is 60,000.\nQualifying amount is limited to 60,000");
                                document.getElementById("<%=txtQualifyingAmount.ClientID%>").value = "60000";
                            }
                        }
                        else {
                            if (Return(qualifying) > 100000) {
                                alert("Maximum Qualifying Amount for the section 80DDB is 1,00,000.\nQualifying amount is limited to 1,00,000");
                                document.getElementById("<%=txtQualifyingAmount.ClientID%>").value = "100000";
                            }
                        }
                    }
                    else {
                        if (Number(finYear) <= 2017) {
                            if (rbtnValue3.checked) {
                                if (Return(qualifying) > 80000) {
                                    alert("Maximum Qualifying Amount for the section 80DDB is " + ((Number(finYear) >= 2016) ? "80,000" : "0") + ".\nQualifying amount is limited to " + ((Number(finYear) >= 2016) ? "80,000" : "0"));
                                    document.getElementById("<%=txtQualifyingAmount.ClientID%>").value = (Number(finYear) >= 2016) ? "80000" : "0";
                                }
                            }
                        }
                    }
                    break;
                case "80GG":
                    maxVal = ((Number(finYear) >= 2016) ? 60000 : 24000);
                    if (Return(qualifying) > maxVal) {
                        alert("Maximum Qualifying Amount for the section 80GG is " + ((Number(finYear) >= 2016) ? "60,000" : "24,000") + ".\nQualifying amount is limited to " + ((Number(finYear) >= 2016) ? "60,000" : "24,000"));
                        document.getElementById("<%=txtQualifyingAmount.ClientID%>").value = (Number(finYear) >= 2016) ? "60000" : "24000";
                    } break;
                case "80QQB":
                    if (Return(qualifying) > 300000) {
                        alert("Maximum Qualifying Amount for the section 80QQB is 3,00,000.\nQualifying amount is limited to 3,00,000");
                        document.getElementById("<%=txtQualifyingAmount.ClientID%>").value = "300000";
                    } break;
                case "80RRB":
                    if (Return(qualifying) > 300000) {
                        alert("Maximum Qualifying Amount for the section 80RRB is 3,00,000.\nQualifying amount is limited to 3,00,000");
                        document.getElementById("<%=txtQualifyingAmount.ClientID%>").value = "300000";
                    } break;
                case "80TTA":
                    if (Return(qualifying) > 10000 && (Number(finYear) <= 2018)) {
                        alert("Maximum Qualifying Amount for the section 80TTA is 10,000.\nQualifying amount is limited to 10,000");
                        document.getElementById("<%=txtQualifyingAmount.ClientID%>").value = "10000";
                    }
                    else if (Return(qualifying) > 10000 && (Number(finYear) >= 2019)) {
                        alert("Maximum Qualifying Amount for the section 80TTA is 10,000.\nQualifying amount is limited to 10,000");
                        document.getElementById("<%=txtQualifyingAmount.ClientID%>").value = "10000";
                    }
                    break;
                case "80TTB":
                    if (Return(qualifying) > 50000) {
                        alert("Maximum Qualifying Amount for the section 80TTB is 50,000.\nQualifying amount is limited to 50,000");
                        document.getElementById("<%=txtQualifyingAmount.ClientID%>").value = "50000";
                    } break;
                case "80U":
                    maxVal = ((Number(finYear) > 2014) ? 125000 : 100000);
                    minVal = ((Number(finYear) > 2014) ? 75000 : 50000);
                    if ((!rbtnValue1.checked && !rbtnValue2.checked) || rbtnValue1.checked) {
                        if (Return(qualifying) > minVal) {
                            alert("Maximum Qualifying Amount for the section 80U is " + ((Number(finYear) > 2014) ? "75,000" : "50,000") + ".\nQualifying amount is limited to " + ((Number(finYear) > 2014) ? "75,000" : "50,000"));
                            document.getElementById("<%=txtQualifyingAmount.ClientID%>").value = (Number(finYear) > 2014) ? "75000" : "50000";
                        }
                    }
                    else if (rbtnValue2.checked) {
                        if (Return(qualifying) > maxVal) {
                            alert("Maximum Qualifying Amount for the section 80U is " + ((Number(finYear) > 2014) ? "1,25,000" : "1,00,000") + ".\nQualifying amount is limited to " + ((Number(finYear) > 2014) ? "1,25,000" : "1,00,000"));
                            document.getElementById("<%=txtQualifyingAmount.ClientID%>").value = (Number(finYear) > 2014) ? "125000" : "100000";
                        }
                    } break;
                case "80CCD(1B)":
                    if (Return(qualifying) > 50000) {
                        alert("Maximum Qualifying Amount for the section 80CCD(1B) is 50,000.\nQualifying amount is limited to 50,000");
                        document.getElementById("<%=txtQualifyingAmount.ClientID%>").value = "50000";
                    } break;
            } return true;
        }
        function ShowHideControls() {
            var finYear = document.getElementById("<%=hdnFinYear.ClientID%>").value;
            if (Number(finYear) > 2011) {
                if (document.getElementById("<%=rowInterest.ClientID%>") != null)
                    document.getElementById("<%=rowInterest.ClientID%>").style.display = '';
            }
            else {
                if (document.getElementById("<%=rowInterest.ClientID%>") != null)
                    document.getElementById("<%=rowInterest.ClientID%>").style.display = 'none';
            }
        }
        function ValidateQualifyingAmount() {
            var grossAmount = document.getElementById("<%=txt80CGross.ClientID%>");
            var qualifyingAmount = document.getElementById("<%=txt80CQualifying.ClientID%>");
            var deductibleAmount = document.getElementById("<%=txt80CDeductible.ClientID%>");
            var finYear = document.getElementById("<%=hdnFinYear.ClientID%>").value;
            if (Number(finYear) <= 2013) {
                if (Return(qualifyingAmount.value) > 100000) {
                    alert("Maximum Qualifying Amount for the section 80C is 1,00,000.\nQualifying amount is limited to 1,00,000");
                    qualifyingAmount.value = "100000";
                }
            }
            else if (Number(finYear) >= 2014) {
                if (Return(qualifyingAmount.value) > 150000) {
                    alert("Maximum Qualifying Amount for the section 80C is 1,50,000.\nQualifying amount is limited to 1,50,000");
                    qualifyingAmount.value = "150000";
                }
            }
            if (Return(qualifyingAmount.value) > Return(grossAmount.value)) {
                alert("Qualifying Amount can not be more than Gross Amount. \nSo Qualifying amount is limited to Gross Amount.");
                qualifyingAmount.value = grossAmount.value;
            }
            if (Return(deductibleAmount.value) > Return(qualifyingAmount.value)) { deductibleAmount.value = qualifyingAmount.value; }
        }
        function Show80CPanel(objValue) {
            if (objValue == 0) {
                document.getElementById("<%=div80CDetails.ClientID%>").style.display = 'none';
                document.getElementById("<%=MaskedDiv1.ClientID%>").style.display = 'none';
                document.getElementById("<%=txtGrossAmount.ClientID%>").value = Return(document.getElementById("<%=hdn80CGross.ClientID%>").value) > 0 ? document.getElementById("<%=hdn80CGross.ClientID%>").value : "";
                document.getElementById("<%=txtQualifyingAmount.ClientID%>").value = Return(document.getElementById("<%=hdn80CQualifying.ClientID%>").value) > 0 ? document.getElementById("<%=hdn80CQualifying.ClientID%>").value : "";
                document.getElementById("<%=txtDeductibleAmount.ClientID%>").value = Return(document.getElementById("<%=hdn80CDeductible.ClientID%>").value) > 0 ? document.getElementById("<%=hdn80CDeductible.ClientID%>").value : "";
                document.getElementById("<%=txtTotalGross.ClientID%>").value = Return(document.getElementById("<%=hdn80CGross.ClientID%>").value) + Return(document.getElementById("<%=hdnOtherGross.ClientID%>").value);
                document.getElementById("<%=txtTotalQualifying.ClientID%>").value = Return(document.getElementById("<%=hdn80CQualifying.ClientID%>").value) + Return(document.getElementById("<%=hdnOtherQualifying.ClientID%>").value);
                document.getElementById("<%=txtTotalDeductible.ClientID%>").value = Return(document.getElementById("<%=hdn80CDeductible.ClientID%>").value) + Return(document.getElementById("<%=hdnOtherDeductible.ClientID%>").value);
            }
            else {
                document.getElementById("<%=div80CDetails.ClientID%>").style.display = '';
                document.getElementById("<%=MaskedDiv1.ClientID%>").style.display = '';
                document.getElementById('<%=MaskedDiv1.ClientID%>').style.visibility = 'visible';
                document.getElementById('<%=MaskedDiv1.ClientID%>').style.top = '0px';
                document.getElementById('<%=MaskedDiv1.ClientID%>').style.left = '0px';
                document.getElementById('<%=MaskedDiv1.ClientID%>').style.width = document.documentElement.offsetWidth + 'px';
                document.getElementById('<%=MaskedDiv1.ClientID%>').style.height = document.documentElement.offsetHeight + 'px'; // (typeof window.innerHeight != 'undefined' ? window.innerHeight : document.body.offsetHeight) + 'px';
            }
        }
        function Validate80CDetail() {
            var ParticularID = document.getElementById("<%=ddlParticulars.ClientID%>");
            var gross = document.getElementById("<%=txt80CGross.ClientID%>");
            var qualifying = document.getElementById("<%=txt80CQualifying.ClientID%>");
            if (ParticularID.value == "-1") {
                alert("Specify Particulars.");
                document.getElementById("<%=ddlParticulars.ClientID%>").focus();
                return false;
            }
            else if (Return(gross.value) == 0) {
                alert("Specify Gross amount.");
                gross.focus();
                return false;
            }
            else if (Return(qualifying.value) > Return(gross.value)) {
                qualifying.value = gross.value;
            } return true;
        }
        function ValidateSection10Detail() {
            var ddlEASectionName = document.getElementById("<%=ddlEASectionName.ClientID%>");
            var txtEAAmount = document.getElementById("<%=txtEAAmount.ClientID%>");
            var txtEARemarks = document.getElementById("<%=txtEARemarks.ClientID%>");
            if (Return(txtEAAmount.value) == 0) {
                alert("Specify Amount.");
                txtEAAmount.focus();
                return false;
            }
            if (txtEARemarks.value == "") {
                alert("Specify Remarks.");
                txtEARemarks.focus();
                return false;
            }
        }
        function ValidateRelief89Details(condition) {
            var ddlReliefFinYear = document.getElementById("<%=ddlReliefFinYear.ClientID%>");
            var txtReliefTaxbleIncome = document.getElementById("<%=txtReliefTaxbleIncome.ClientID%>");
            var txtReliefArrearReceived = document.getElementById("<%=txtReliefArrearReceived.ClientID%>");
            var txtReliefCalculatedAmount = document.getElementById("<%=txtReliefCalculatedAmount.ClientID%>");
            if (ddlReliefFinYear.value == "-1") {
                alert("Select Financial Year.");
                document.getElementById("<%=ddlReliefFinYear.ClientID%>").focus();
                return false;
            }
            if (Return(txtReliefTaxbleIncome.value) == 0) {
                alert("Specify Taxable Income.");
                txtReliefTaxbleIncome.focus();
                return false;
            }
            if (txtReliefArrearReceived.value == "") {
                alert("Specify Arrears Received.");
                txtReliefArrearReceived.focus();
                return false;
            }

            if (condition == false) {
                GetRateSlabDetails();
            }

            return condition;
        }
        function Clear80CControls() {
            document.getElementById("<%=ddlParticulars.ClientID%>").value = "-1";
            document.getElementById("<%=txt80CGross.ClientID%>").value = "";
            document.getElementById("<%=txt80CQualifying.ClientID%>").value = "";
            document.getElementById("<%=txt80CDeductible.ClientID%>").value = "";
        }
        function ClearSection10Controls() {
            document.getElementById("<%=ddlEASectionName.ClientID%>").value = "-1";
            document.getElementById("<%=txtEAAmount.ClientID%>").value = "";
            document.getElementById("<%=txtEARemarks.ClientID%>").value = "";
            document.getElementById("<%=hdnSalaryDetailRowNo.ClientID%>").value = "-1";
        }
        function ClearReliefUS89Controls() {
            document.getElementById("<%=ddlReliefFinYear.ClientID%>").value = "-1";
            document.getElementById("<%=txtReliefTaxbleIncome.ClientID%>").value = "";
            document.getElementById("<%=txtReliefArrearReceived.ClientID%>").value = "";
            document.getElementById("<%=txtReliefCalculatedAmount.ClientID%>").value = "";
            document.getElementById("<%=hdnReliefDetailRowNo.ClientID%>").value = "-1";
        }
        function EnableDisable() {
            var sectionID = document.getElementById("<%=cmbSection.ClientID%>").value;
            if (sectionID == 3) {
                if (document.getElementById("<%=btn80CDetails.ClientID%>") != null)
                    document.getElementById("<%=btn80CDetails.ClientID%>").style.display = '';
                document.getElementById("<%=txtGrossAmount.ClientID%>").disabled = Return(document.getElementById("<%=hdnIs80CDetail.ClientID%>").value) == "1" && Return(document.getElementById("<%=hdn80CGross.ClientID%>").value) > 0;
                document.getElementById("<%=txtQualifyingAmount.ClientID%>").disabled = Return(document.getElementById("<%=hdnIs80CDetail.ClientID%>").value) == "1" && Return(document.getElementById("<%=hdn80CGross.ClientID%>").value) > 0;
                document.getElementById("<%=txtDeductibleAmount.ClientID%>").disabled = Return(document.getElementById("<%=hdnIs80CDetail.ClientID%>").value) == "1" && Return(document.getElementById("<%=hdn80CGross.ClientID%>").value) > 0;
                document.getElementById("<%=txtGrossAmount.ClientID%>").style.backgroundColor = Return(document.getElementById("<%=hdnIs80CDetail.ClientID%>").value) == "1" && Return(document.getElementById("<%=hdn80CGross.ClientID%>").value) > 0 ? "#FFFFCC" : "White";
                document.getElementById("<%=txtQualifyingAmount.ClientID%>").style.backgroundColor = Return(document.getElementById("<%=hdnIs80CDetail.ClientID%>").value) == "1" && Return(document.getElementById("<%=hdn80CGross.ClientID%>").value) > 0 ? "#FFFFCC" : "White";
                document.getElementById("<%=txtDeductibleAmount.ClientID%>").style.backgroundColor = Return(document.getElementById("<%=hdnIs80CDetail.ClientID%>").value) == "1" && Return(document.getElementById("<%=hdn80CGross.ClientID%>").value) > 0 ? "#FFFFCC" : "White";
            }
            else {
                if (document.getElementById("<%=btn80CDetails.ClientID%>") != null)
                    document.getElementById("<%=btn80CDetails.ClientID%>").style.display = 'none';
                document.getElementById("<%=txtGrossAmount.ClientID%>").disabled = false;
                document.getElementById("<%=txtQualifyingAmount.ClientID%>").disabled = false;
                document.getElementById("<%=txtDeductibleAmount.ClientID%>").disabled = false;
                document.getElementById("<%=txtGrossAmount.ClientID%>").style.backgroundColor = "white";
                document.getElementById("<%=txtQualifyingAmount.ClientID%>").style.backgroundColor = "white";
                document.getElementById("<%=txtDeductibleAmount.ClientID%>").style.backgroundColor = "white";
            }
        }
        function ValidateData() {
            if (Return(document.getElementById("<%=txtGrossAmount.ClientID%>").value) > 0 && (Return(document.getElementById("<%=hdn80CGross.ClientID%>").value) == 0 || Return(document.getElementById("<%=hdnIs80CDetail.ClientID%>").value) == 0)) {
                if (confirm("Manual given amounts will be deleted. Do you want to proceed?")) {
                    Show80CPanel(1);
                    document.getElementById("<%=txtGrossAmount.ClientID%>").value = "";
                    document.getElementById("<%=txtQualifyingAmount.ClientID%>").value = "";
                    document.getElementById("<%=txtDeductibleAmount.ClientID%>").value = "";
                    document.getElementById("<%=hdn80CGross.ClientID%>").value = "";
                    document.getElementById("<%=hdn80CQualifying.ClientID%>").value = "";
                    document.getElementById("<%=hdn80CDeductible.ClientID%>").value = "";
                    document.getElementById("<%=hdnIs80CDetail.ClientID%>").value = "1";
                }
                else return false;
            }
            else { Show80CPanel(1); }
        }
        function ValidateChapter80CRelatedDeds() {
            if (document.getElementById("<%=cmbSection.ClientID%>").value == "4" || document.getElementById("<%=cmbSection.ClientID%>").value == "20") {
                if (document.getElementById("<%=txtGrossAmount.ClientID%>").value != "") {
                    ValidateTot80CRelatedDedAmounts(document.getElementById("<%=hdn80CDeductible.ClientID%>"),
                                     document.getElementById("<%=hdn80CCC.ClientID%>"),
                                     document.getElementById("<%=hdn80CCD.ClientID%>"), document.getElementById("<%=txtDeductibleAmount.ClientID%>"))
                }
            }
        }
        function ValidateTot80CRelatedDedAmounts(hdn80CValue, hdn80CCCValue, hdn80CCDValue, deductibleAmnt) {
            var hdnFinYear = document.getElementById("<%=hdnFinYear.ClientID %>").value;
            if (hdnFinYear <= 2013) {
                if (Return(document.getElementById("<%=hdn80CDeductible.ClientID%>").value) + Return(document.getElementById("<%=hdn80CCC.ClientID%>").value) + Return(document.getElementById("<%=hdn80CCD.ClientID%>").value) + Return(document.getElementById("<%=txtDeductibleAmount.ClientID%>").value) > 100000) {
                    alert("Since Total Deductible amounts U/s 80C,80CCC,80CCD1 are crossing Rs.1,00,000\nit should be limited to Rs.1,00,000/-");
                    document.getElementById("<%=txtQualifyingAmount.ClientID%>").value = "";
                    document.getElementById("<%=txtDeductibleAmount.ClientID%>").value = "";
                    return false;
                }
            }
            else {
                if (Return(document.getElementById("<%=hdn80CDeductible.ClientID%>").value) + Return(document.getElementById("<%=hdn80CCC.ClientID%>").value) + Return(document.getElementById("<%=hdn80CCD.ClientID%>").value) + Return(document.getElementById("<%=txtDeductibleAmount.ClientID%>").value) > 150000) {
                    alert("Since Total Deductible amounts U/s 80C,80CCC,80CCD1 are crossing Rs.1,50,000\nit should be limited to Rs.1,50,000/-");
                    document.getElementById("<%=txtQualifyingAmount.ClientID%>").value = "";
                    document.getElementById("<%=txtDeductibleAmount.ClientID%>").value = "";
                    return false;
                }
            } return true;
        }
        function checkValidatePAN(objectName, option) {
            objectName.value = objectName.value.toUpperCase();
            var message = option == "1" ? "Landlord 1" : option == "2" ? "Landlord 2" : option == "3" ? "Landlord 3" : option == "4" ? "Landlord 4" : option == "5" ? "Lender 1" : option == "6" ? "Lender 2" : option == "7" ? "Lender 3" : "Lender 4";
            return ValidatePAN(objectName, message + " PAN", 10, false);
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
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentPlaceHolderBody" runat="Server">
    <div id="MaskedDiv1" class="MaskedDiv" runat="server">
    </div>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:HiddenField ID="hdnTotalTaxableIncome" runat="server" Value="0" />
            <asp:HiddenField ID="hdnSalaryDetailRowNo" runat="server" Value="0" />
            <asp:HiddenField ID="hdnReliefDetailRowNo" runat="server" Value="0" />
            <asp:HiddenField ID="hdnSalaryDetID" runat="server" />
            <asp:HiddenField ID="hdnFinYear" runat="server" Value="" />
            <asp:HiddenField ID="hdnGender" runat="server" Value="0" />
            <asp:HiddenField ID="hdnIsSeniorCitizen" runat="server" Value="0" />
            <asp:HiddenField ID="hdnSalarySection" runat="server" />
            <asp:HiddenField ID="hdnIsInValidPAN" runat="server" />
            <asp:HiddenField ID="hdnDeducteeID" Value="-1" runat="server" />
            <asp:HiddenField ID="hdnIsLoaded" Value="False" runat="server" />
            <asp:HiddenField ID="hdnTotalTaxPerk" Value="0" runat="server" />
            <asp:HiddenField ID="hdnOtherIncome" Value="0" runat="server" />
            <asp:HiddenField ID="hdnOtherTotal" Value="0" runat="server" />
            <asp:HiddenField ID="hdnChapVIATotal" Value="0" runat="server" />
            <asp:HiddenField ID="hdnTotalTDS" Value="0" runat="server" />
            <asp:HiddenField ID="hdn80C" Value="0" runat="server" />
            <asp:HiddenField ID="hdn80CCC" Value="0" runat="server" />
            <asp:HiddenField ID="hdn80CCD" Value="0" runat="server" />
            <asp:HiddenField ID="hdn80TTA" Value="0" runat="server" />
            <asp:HiddenField ID="hdn80TTB" Value="0" runat="server" />
            <asp:HiddenField ID="hdnCVIA80CID" runat="server" Value="-1" />
            <asp:HiddenField ID="hdn80CGross" runat="server" Value="" />
            <asp:HiddenField ID="hdn80CQualifying" runat="server" Value="" />
            <asp:HiddenField ID="hdn80CDeductible" runat="server" Value="" />
            <asp:HiddenField ID="hdnOtherGross" runat="server" Value="-" />
            <asp:HiddenField ID="hdnOtherQualifying" runat="server" Value="" />
            <asp:HiddenField ID="hdnOtherDeductible" runat="server" Value="" />
            <asp:HiddenField ID="hdnIs80CDetail" runat="server" Value="0" />
            <asp:HiddenField ID="hdnEmpDetails" runat="server" Value="0" />
            <asp:HiddenField ID="hdnIsSB" runat="server" Value="0" />
            <asp:HiddenField ID="hdn80CrelatedQalAmt" runat="server" Value="" />
            <asp:HiddenField ID="hdn80CrelatedDedAmt" runat="server" Value="" />
            <asp:HiddenField ID="hdn80CrelatedGrossAmt" runat="server" Value="" />
            <div class="divPopUp" id="div80CDetails" runat="server" style="width: 712px; display: none">
                <table style="border: 2px solid #7f858b; height: auto;">
                    <tr style="height: 20px; background-color: #7f858b; color: White;">
                        <th style="text-align: left; border: 0px" colspan="2">
                            Deduction in respect of specified Investments / Savings
                        </th>
                    </tr>
                    <tr>
                        <td colspan="2">
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-left: 8px">
                            Particulars
                        </td>
                        <td style="padding-right: 10px">
                            <asp:DropDownList ID="ddlParticulars" runat="server" Width="320px" CssClass="dropDownList"
                                BackColor="#E5E5E5">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-left: 8px">
                            Gross Amount
                        </td>
                        <td style="padding-right: 10px">
                            <asp:TextBox ID="txt80CGross" runat="server" CssClass="txtBMR" Width="120px" onkeypress="return ValidateForOnlyNos(event);">
                            </asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-left: 8px">
                            Qualifying Amount
                        </td>
                        <td style="padding-right: 10px">
                            <asp:TextBox ID="txt80CQualifying" runat="server" CssClass="txtAR" Width="120px"
                                onkeypress="return ValidateForOnlyNos(event);" onkeyup="ValidateQualifyingAmount();">
                            </asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-left: 8px">
                            Deductible Amount
                        </td>
                        <td style="padding-right: 10px">
                            <asp:TextBox ID="txt80CDeductible" runat="server" CssClass="txtAR" Width="120px"
                                onkeypress="return ValidateForOnlyNos(event);" onkeyup="ValidateQualifyingAmount();">
                            </asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" align="left">
                            <asp:Button ID="btnClearChapterVIA80C" Text="Clear" runat="server" CssClass="cmnBtn"
                                OnClientClick="Clear80CControls();return false" />
                            <asp:Button ID="btnSaveChapterVIA80C" Text="Save" runat="server" CssClass="cmnBtn"
                                OnClientClick="return Validate80CDetail();" OnClick="btnSave80CDetails_Click" />
                            <asp:Button ID="btnCloseChapterVIA80C" Text="Close" runat="server" CssClass="cmnBtn"
                                OnClientClick="Clear80CControls();EnableDisable();Show80CPanel(0);return false;" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <asp:Panel ID="C80DetailsPanel" runat="server" CssClass="navPanel" Width="700px">
                                <asp:Repeater ID="rptr80CDetails" runat="server" OnItemCommand="rptr80CDetails_ItemCommand">
                                    <HeaderTemplate>
                                        <table class="nTbl">
                                            <tr bgcolor="#EEEEEE">
                                                <th style="display: none">
                                                </th>
                                                <th colspan="2" id="headerDeductionAction" runat="server">
                                                    <asp:Label runat="server" ID="lblAction" Width="70px" Text="Action" />
                                                </th>
                                                <th>
                                                    <asp:Label runat="server" ID="lblSerNo" Width="250px" Text="Particulars" />
                                                </th>
                                                <th>
                                                    <asp:Label runat="server" ID="lblGrossAmount" Width="90px" Text="Gross Amount" />
                                                </th>
                                                <th>
                                                    <asp:Label runat="server" ID="Label1" Width="90px" Text="Qualifying Amount" />
                                                </th>
                                                <th style="border-right-width: 0px">
                                                    <asp:Label runat="server" ID="Label2" Width="90px" Text="Deductible Amount" />
                                                </th>
                                            </tr>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <tr bgcolor="white">
                                            <td style="display: none">
                                                <asp:Label runat="server" ID="lblParticularID" Width="120px" Text='<%#Eval("CVIA80CID") %>' />
                                            </td>
                                            <td id="edit" runat="server">
                                                <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" TabIndex="33" CommandName="Edit"
                                                    Font-Underline="false" CommandArgument='<%#Eval("CVIA80CID") %>'></asp:LinkButton>
                                            </td>
                                            <td id="coldelete" runat="server">
                                                <asp:LinkButton ID="lnkDelete" runat="server" TabIndex="34" Text="Delete" CommandName="Delete"
                                                    CommandArgument='<%#Eval("CVIA80CID") %>' Font-Underline="false"></asp:LinkButton>
                                            </td>
                                            <td>
                                                <%# Eval("CVIA80CDESC")%>
                                            </td>
                                            <td style="text-align: right">
                                                <%# Eval("GrossAmount")%>
                                            </td>
                                            <td style="text-align: right">
                                                <%# Eval("QualifyingAmount")%>
                                            </td>
                                            <td style="text-align: right; border-right-width: 0px">
                                                <%# Eval("DeductibleAmount")%>
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
                        <td colspan="2">
                        </td>
                    </tr>
                </table>
            </div>
            <asp:MultiView ID="mvwSalaryDetails" runat="server" ActiveViewIndex="0">
                <asp:View ID="vwMain" runat="server">
                    <table class="nTbl">
                        <tr>
                            <td>
                                <asp:Label ID="lblNote" runat="server" Text="Note: Select Employee Name and click on Load"
                                    ForeColor="#0000CC"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblSalModificationBlock" runat="server" Text="Salary Detail modification is blocked. Contact Tax Cell if changes are to be made."
                                    ForeColor="Red" Visible="false"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table class="nTbl">
                                    <tr>
                                        <td class="eCol" width="770px" valign="top">
                                            <table style="height: 331px; width: 100%">
                                                <tr>
                                                    <td class="vHCol">
                                                        <asp:Label ID="lblName" runat="server" Text="Name"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <table>
                                                            <tr>
                                                                <td style="padding-left: 1px">
                                                                    <asp:TextBox ID="txtName" runat="server" onkeyup="ClearUserName()" CssClass="txtBML"
                                                                        TabIndex="1" Width="155px"></asp:TextBox>
                                                                    <cc1:AutoCompleteExtender ID="AutoCompleteExtenderName" runat="server" MinimumPrefixLength="2"
                                                                        ServicePath="~/WebServices/AutoCompleteService.asmx" ServiceMethod="GetAllEmployeeBranch"
                                                                        TargetControlID="txtName" CompletionInterval="700" EnableCaching="false" CompletionSetCount="20"
                                                                        DelimiterCharacters="" ShowOnlyCurrentWordInCompletionListItem="true" FirstRowSelected="True"
                                                                        OnClientItemSelected="GetUserNameValue">
                                                                    </cc1:AutoCompleteExtender>
                                                                </td>
                                                                <td>
                                                                    <asp:Button ID="btnLoad" runat="server" Text="Load" CssClass="popBtn" OnClientClick="return ValidateName();"
                                                                        OnClick="btnLoad_Click" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="vHCol">
                                                    </td>
                                                    <td class="aligntd">
                                                        <asp:Label ID="lblEmpDetails" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="vHCol">
                                                        Basic Salary
                                                    </td>
                                                    <td class="aligntd">
                                                        <asp:TextBox ID="txtBasicSalary" runat="server" MaxLength="14" AutoComplete="off"
                                                            TabIndex="2" CssClass="txtAR" onkeypress="return numeralsOnly(this, event,10,0,0,1);"
                                                            onchange="return checkDecimalNo(this);" onkeyup="CalculateValues();"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="vHCol">
                                                        Taxable Allowance (allowance less section 10 exemptions)
                                                    </td>
                                                    <td class="aligntd">
                                                        <asp:TextBox ID="txtTaxableAllowance" runat="server" AutoComplete="off" TabIndex="3"
                                                            MaxLength="14" CssClass="txtAR" onkeypress="return numeralsOnly(this, event,10,0,0,1);"
                                                            onchange="return checkDecimalNo(this);" onkeyup="CalculateValues();">                                                
                                                        </asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr id="rowExemptedAllowance" runat="server">
                                                    <td class="vHCol">
                                                        Exempted Amount (not used in calculation)
                                                    </td>
                                                    <td class="aligntd">
                                                        <asp:TextBox ID="txtExemptedAllowance" runat="server" AutoComplete="off" TabIndex="3"
                                                            MaxLength="14" CssClass="txtAR" onkeypress="return numeralsOnly(this, event,10,0,0,1);"
                                                            onchange="return checkDecimalNo(this);">                                                
                                                        </asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        Taxable Perquisites
                                                    </td>
                                                    <td>
                                                        <table>
                                                            <tr>
                                                                <td style="padding-left: 1px">
                                                                    <asp:TextBox ID="txtTaxablePerquisites" runat="server" CssClass="txtBPop" MaxLength="14"
                                                                        Enabled="false" onkeypress="return numeralsOnly(this, event,10,0,0,1);" onchange="return checkDecimalNo(this);">                                                
                                                                    </asp:TextBox>
                                                                </td>
                                                                <td>
                                                                    <asp:Button ID="btnTaxablePerq" Text="..." runat="server" CssClass="popBtn" OnClientClick="return AlertUser();"
                                                                        OnClick="btnTaxablePerq_Click" TabIndex="4" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr id="trExmptedAP" runat="server">
                                                    <td>
                                                        Exempted Allowances & Perqs
                                                    </td>
                                                    <td>
                                                        <table>
                                                            <tr>
                                                                <td style="padding-left: 1px">
                                                                    <asp:TextBox ID="txtExemptedAllowancesAndPerqs" runat="server" CssClass="txtBPop"
                                                                        MaxLength="14" Enabled="false" onkeypress="return numeralsOnly(this, event,10,0,0,1);"
                                                                        onchange="return checkDecimalNo(this);">                                                
                                                                    </asp:TextBox>
                                                                </td>
                                                                <td>
                                                                    <asp:Button ID="btnExmptedAllowances" Text="..." runat="server" CssClass="popBtn"
                                                                        OnClientClick="return AlertUser();" OnClick="btnExmptedAllowances_Click" TabIndex="4" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="vHCol">
                                                        Gross Salary
                                                    </td>
                                                    <td class="aligntd">
                                                        <asp:TextBox ID="txtGrossSalary" runat="server" MaxLength="14" CssClass="txtARM"
                                                            Enabled="false" onkeypress="return numeralsOnly(this, event,10,0,0,1);" onchange="return checkDecimalNo(this);"
                                                            onkeyup="CalculateValues();">                                                
                                                        </asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr id="rowSD" runat="server">
                                                    <td class="vHCol">
                                                        Standard Deduction&nbsp;&nbsp;&nbsp;
                                                        <br />
                                                        16(ia)
                                                    </td>
                                                    <td class="aligntd">
                                                        <asp:TextBox ID="txtSD" runat="server" MaxLength="14" AutoComplete="off" TabIndex="5"
                                                            CssClass="txtAR" onkeypress="return numeralsOnly(this, event,10,0,0,1);" onchange="return checkDecimalNo(this);"
                                                            onkeyup="CalculateValues();">                                                
                                                        </asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="vHCol">
                                                        ET 16(ii)
                                                    </td>
                                                    <td class="aligntd">
                                                        <asp:TextBox ID="txtET" runat="server" MaxLength="14" AutoComplete="off" TabIndex="6"
                                                            CssClass="txtAR" onkeypress="return numeralsOnly(this, event,10,0,0,1);" onchange="return checkDecimalNo(this);"
                                                            onkeyup="CalculateValues();">                                                
                                                        </asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="vHCol">
                                                        PT 16(iii)
                                                    </td>
                                                    <td class="aligntd">
                                                        <asp:TextBox ID="txtPT" runat="server" AutoComplete="off" TabIndex="7" MaxLength="14"
                                                            CssClass="txtAR" onkeypress="return numeralsOnly(this, event,10,0,0,1);" onchange="return checkDecimalNo(this);"
                                                            onkeyup="CalculateValues();">                                                
                                                        </asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="vHCol">
                                                        Deduction U/S 16
                                                    </td>
                                                    <td class="aligntd">
                                                        <asp:TextBox ID="txtDeductionUnderSection16" runat="server" MaxLength="14" Enabled="false"
                                                            CssClass="txtARM" onkeypress="return numeralsOnly(this, event,10,0,0,1);" onchange="return checkDecimalNo(this);"
                                                            onkeyup="CalculateValues()">                                                
                                                        </asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="vHCol">
                                                        Income from Salaries
                                                    </td>
                                                    <td class="aligntd">
                                                        <asp:TextBox ID="txtIncomefromSalaries" runat="server" MaxLength="14" Enabled="false"
                                                            CssClass="txtARM" onkeypress="return numeralsOnly(this, event,10,0,0,1);" onchange="return checkDecimalNo(this);"
                                                            onkeyup="CalculateValues();"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="vHCol">
                                                        Other Income
                                                    </td>
                                                    <td>
                                                        <table border="0">
                                                            <tr>
                                                                <td style="padding-left: 1px">
                                                                    <asp:TextBox ID="txtOtherIncome" runat="server" MaxLength="14" Enabled="false" CssClass="txtBPop"
                                                                        onkeypress="return numeralsOnly(this, event,10,0,0,1);" onchange="return checkDecimalNo(this);"
                                                                        onkeyup="CalculateValues();">                                                
                                                                    </asp:TextBox>
                                                                </td>
                                                                <td>
                                                                    <asp:Button ID="btnOtherIncomeDetails" Text="..." runat="server" CssClass="popBtn"
                                                                        OnClientClick="return AlertUser();" OnClick="btnOtherIncomeDetails_Click" TabIndex="8" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="vHCol">
                                                        Gross Total Income
                                                    </td>
                                                    <td class="aligntd">
                                                        <asp:TextBox ID="txtGrossTotalIncome" runat="server" MaxLength="14" Enabled="false"
                                                            CssClass="txtARM" onkeypress="return numeralsOnly(this, event,10,0,0,1);" onchange="return checkDecimalNo(this);"
                                                            onkeyup="CalculateValues()"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                    </td>
                                                    <td>
                                                        <asp:Button ID="btnMoreDetails" Text="More" runat="server" CssClass="cmnBtn" TabIndex="9"
                                                            OnClick="btnMoreDetails_Click" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td class="eCol" width="770px" valign="top">
                                            <table width="100%">
                                                <tr>
                                                    <td class="vHCol">
                                                        Total Deductions Under Chapter VI(A)
                                                    </td>
                                                    <td class="aligntd">
                                                        <table>
                                                            <tr>
                                                                <td>
                                                                    <asp:TextBox ID="txtTotalDeductions" runat="server" CssClass="txtBPop" MaxLength="14"
                                                                        Enabled="false" onkeypress="return numeralsOnly(this, event,10,0,0,1);" onchange="return checkDecimalNo(this);">
                                                                    </asp:TextBox>
                                                                </td>
                                                                <td>
                                                                    <asp:Button ID="btnDeductionUc" Text="..." runat="server" CssClass="popBtn" OnClientClick="return AlertUser();"
                                                                        OnClick="btnDeductionUc_Click" TabIndex="10" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="vHCol">
                                                        Total Taxable Income
                                                    </td>
                                                    <td class="aligntd">
                                                        <asp:TextBox ID="txtTotalTaxableIncome" runat="server" MaxLength="14" Enabled="false"
                                                            CssClass="txtARM" onkeypress="return numeralsOnly(this, event,10,0,0,1);" onchange="return checkDecimalNo(this);"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="vHCol">
                                                        Tax on Total Income
                                                    </td>
                                                    <td class="aligntd">
                                                        <asp:TextBox ID="txtTaxOnTotalIncome" runat="server" AutoComplete="off" TabIndex="11"
                                                            MaxLength="14" CssClass="txtAR" onkeypress="return numeralsOnly(this, event,10,0,0,1);"
                                                            onchange="return checkDecimalNo(this);" onkeyup="CalculateTaxAmounts();"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr id="rowCreditUS87A" runat="server">
                                                    <td class="vHCol">
                                                        Credit u/s 87A
                                                    </td>
                                                    <td class="aligntd">
                                                        <asp:TextBox ID="txtCreditUS87A" runat="server" AutoComplete="off" TabIndex="12"
                                                            MaxLength="14" Enabled="false" CssClass="txtAR"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="vHCol">
                                                        Surcharge
                                                    </td>
                                                    <td class="aligntd">
                                                        <asp:TextBox ID="txtSurcharge" runat="server" MaxLength="14" CssClass="txtAR" Enabled="true"
                                                            onkeypress="return numeralsOnly(this, event,10,0,0,1);" onchange="return checkDecimalNo(this);"
                                                            onkeyup="CalculateTaxAmounts();"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="vHCol">
                                                        Education Cess
                                                    </td>
                                                    <td class="aligntd">
                                                        <asp:TextBox ID="txtEduCess" runat="server" AutoComplete="off" TabIndex="13" MaxLength="14"
                                                            CssClass="txtAR" onkeypress="return numeralsOnly(this, event,10,0,0,1);" onchange="return checkDecimalNo(this);"
                                                            onkeyup="CalculateTaxAmounts();"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="vHCol">
                                                        Total Income Tax Payable
                                                    </td>
                                                    <td class="aligntd">
                                                        <asp:TextBox ID="txtTotalITPayable" runat="server" MaxLength="14" CssClass="txtARM"
                                                            Enabled="false" onkeypress="return numeralsOnly(this, event,10,0,0,1);" onchange="return checkDecimalNo(this);"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="vHCol">
                                                        Relief U/S 89
                                                    </td>
                                                    <td class="aligntd">
                                                        <table>
                                                            <tr>
                                                                <td>
                                                                    <asp:TextBox ID="txtReliefUnderSection89" runat="server" AutoComplete="off" TabIndex="14"
                                                                        MaxLength="14" CssClass="txtAR" onkeypress="return numeralsOnly(this, event,10,0,0,1);"
                                                                        Width="152px" onchange="return checkDecimalNo(this);" onkeyup="CalculateTaxAmounts();">
                                                                    </asp:TextBox>
                                                                </td>
                                                                <td id="tdReliefUS89MadeDetails" runat="server">
                                                                    <asp:Button ID="btnReliefUS89MadeDetails" Text="..." runat="server" CssClass="popBtn"
                                                                        OnClientClick="return AlertUser(); ClearReliefUS89Controls();" OnClick="btnReliefUS89MadeDetails_Click"
                                                                        TabIndex="14" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        Net Tax Payable
                                                    </td>
                                                    <td class="aligntd">
                                                        <asp:TextBox ID="txtNetTaxPayable" runat="server" MaxLength="14" CssClass="txtARM"
                                                            Enabled="false" onkeypress="return numeralsOnly(this, event,10,0,0,1);" onchange="return checkDecimalNo(this);"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="vHCol">
                                                        TDS - Income Tax (Deducted)
                                                    </td>
                                                    <td class="aligntd">
                                                        <asp:TextBox ID="txtTDSITDeducted" runat="server" MaxLength="14" CssClass="txtARM"
                                                            Enabled="false" onkeypress="return numeralsOnly(this, event,10,0,0,1);" onchange="return checkDecimalNo(this);"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="vHCol">
                                                        TDS - Surcharge(Deducted)
                                                    </td>
                                                    <td class="aligntd">
                                                        <asp:TextBox ID="txtTDSSurchargeDeducted" runat="server" MaxLength="14" Enabled="false"
                                                            CssClass="txtARM" onkeypress="return numeralsOnly(this, event,10,0,0,1);" onchange="return checkDecimalNo(this);"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="vHCol">
                                                        Education Cess (Deducted)
                                                    </td>
                                                    <td class="aligntd">
                                                        <asp:TextBox ID="txtEducationCessDeducted" runat="server" MaxLength="14" Enabled="false"
                                                            CssClass="txtARM" onkeypress="return numeralsOnly(this, event,10,0,0,1);" onchange="return checkDecimalNo(this);"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="vHCol">
                                                        Total TDS
                                                    </td>
                                                    <td class="aligntd">
                                                        <table>
                                                            <tr>
                                                                <td>
                                                                    <asp:TextBox ID="txtTotalTDS" runat="server" CssClass="txtBPop" MaxLength="14" Enabled="false"
                                                                        onkeypress="return numeralsOnly(this, event,10,0,0,1);" onchange="return checkDecimalNo(this);">
                                                                    </asp:TextBox>
                                                                </td>
                                                                <td>
                                                                    <asp:Button ID="btnTDSMadeDetails" Text="..." runat="server" CssClass="popBtn" OnClientClick="return AlertUser();"
                                                                        OnClick="btnTDSMadeDetails_Click" TabIndex="15" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="vHCol">
                                                        TAX PAYABLE/(REFUNDABLE)
                                                    </td>
                                                    <td class="aligntd">
                                                        <asp:TextBox ID="txtTaxPayable" runat="server" MaxLength="14" CssClass="txtARM" Enabled="false"
                                                            onkeypress="return numeralsOnly(this, event,10,0,0,1);" onchange="return checkDecimalNo(this);"></asp:TextBox>
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
                                            <asp:Button ID="btnNew" Text="New" runat="server" CssClass="cmnBtn" OnClick="btnNew_Click"
                                                UseSubmitBehavior="False" />
                                        </td>
                                        <td>
                                            <asp:Button runat="server" ID="btnSave" Text="Save" OnClientClick="return Validations();"
                                                OnClick="btnSave_Click" CssClass="cmnBtn" />
                                        </td>
                                        <td>
                                            <asp:Button runat="server" ID="btnRecalculate" Text="Recalculate" OnClientClick="return CalculateValues();"
                                                CssClass="cmnBtn" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </asp:View>
                <asp:View ID="vwExemtedAllowances" runat="server">
                    <table style="border: 2px solid #7f858b; height: auto; width: 742px">
                        <tr style="height: 20px; background-color: #7f858b; color: White;">
                            <th style="text-align: left; border: 0px" colspan="2">
                                <div class="dHeader">
                                    Exempted Allowances & Perqs
                                </div>
                            </th>
                        </tr>
                        <tr>
                            <td style="padding-left: 8px" width="100px">
                                Section Name
                            </td>
                            <td style="padding-right: 10px">
                                <asp:DropDownList ID="ddlEASectionName" runat="server" Width="500px" CssClass="dropDownList"
                                    BackColor="#E5E5E5">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-left: 8px">
                                Amount
                            </td>
                            <td style="padding-right: 10px">
                                <asp:TextBox ID="txtEAAmount" runat="server" CssClass="txtBMR" Width="120px" MaxLength="10"
                                    onkeypress="return ValidateForOnlyNos(event);"> </asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-left: 8px">
                                Remarks
                            </td>
                            <td style="padding-right: 10px">
                                <asp:TextBox ID="txtEARemarks" runat="server" CssClass="txtBML" BackColor="#E5E5E5"
                                    MaxLength="255" Width="500px"> </asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <captions>
                                <td align="left" colspan="2">
                                    <br />
                                    &nbsp
                                    <asp:Button ID="btnEAClear" Text="Clear" runat="server" CssClass="cmnBtn"
                                        OnClientClick="ClearSection10Controls();return false" />
                                    <asp:Button ID="btnEASave" runat="server" CssClass="cmnBtn" 
                                        OnClick="btnEASave_Click" OnClientClick="return ValidateSection10Detail();"  Text="Save" />
                                    <asp:Button ID="btnEAClose" runat="server" CssClass="cmnBtn"  Text="Close"  
                                        OnClientClick="ClearSection10Controls();" OnClick="btnEAClose_Click" />
                                </td>
                            </captions>
                        </tr>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:Panel ID="EADetailsPanel" runat="server" CssClass="navPanel" Width="730px" ScrollBars="Horizontal">
                                    <asp:Repeater ID="rptrEADetails" runat="server" OnItemCommand="rptrEADetails_ItemCommand"
                                        OnItemDataBound="rptrEADetails_ItemDataBound">
                                        <HeaderTemplate>
                                            <table class="nTbl">
                                                <tr bgcolor="#EEEEEE">
                                                    <th style="display: none">
                                                    </th>
                                                    <th colspan="2" id="headerDeductionAction" runat="server" style="width: 100px">
                                                        <asp:Label runat="server" ID="lblAction" Width="70px" Text="Action" />
                                                    </th>
                                                    <th style="width: 300px">
                                                        <asp:Label runat="server" ID="lblEASectionName" Width="100px" Text="Section Name" />
                                                    </th>
                                                    <th style="width: 70px">
                                                        <asp:Label runat="server" ID="lblEAAmount" Width="70px" Text="Amount" />
                                                    </th>
                                                    <th style="width: 200px">
                                                        <asp:Label runat="server" ID="lblEARemarks" Width="90px" Text="Remarks" />
                                                    </th>
                                                </tr>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <tr bgcolor="white">
                                                <td style="display: none">
                                                    <asp:Label runat="server" ID="lblSection10DetailId" Width="120px" Text='<%#Eval("SECTION10DETAILID") %>' />
                                                    <asp:Label runat="server" ID="lblSalaryDetailId" Width="120px" Text='<%#Eval("SALARYDETAILID") %>' />
                                                    <asp:Label runat="server" ID="lblSalarySectionId" Width="120px" Text='<%#Eval("SALARYSECTIONID") %>' />
                                                </td>
                                                <td id="edit" runat="server" style="width: 50px">
                                                    <asp:LinkButton ID="lnkEAEdit" runat="server" Text="Edit" TabIndex="33" CommandName="Edit"
                                                        Font-Underline="false" CommandArgument='<%#Eval("SalaryDetailRowNo") %>'></asp:LinkButton>
                                                </td>
                                                <td id="coldelete" runat="server" style="width: 50px">
                                                    <asp:LinkButton ID="lnkEADelete" runat="server" TabIndex="34" Text="Delete" CommandName="Delete"
                                                        CommandArgument='<%#Eval("SalaryDetailRowNo") %>' Font-Underline="false"></asp:LinkButton>
                                                </td>
                                                <td style="width: 300px">
                                                    <%# Eval("SalarySectionName")%>
                                                </td>
                                                <td style="width: 70px; text-align: right">
                                                    <%# Eval("Amount")%>
                                                </td>
                                                <td style="width: 200px; text-align: left">
                                                    <%# Eval("Remarks")%>
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
                            <td colspan="2">
                            </td>
                        </tr>
                    </table>
                </asp:View>
                <asp:View ID="vwReliefUS89" runat="server">
                    <table style="height: auto; width: 742px">
                        <tr>
                            <td style="width: 90px">
                                Financial Year
                            </td>
                            <td style="width: 100px">
                                <asp:DropDownList ID="ddlReliefFinYear" runat="server" BackColor="#E5E5E5" CssClass="dropDownList"
                                    Width="100px">
                                </asp:DropDownList>
                            </td>
                            <td style="width: 90px">
                                Taxable Income
                            </td>
                            <td style="width: 150px">
                                <asp:TextBox ID="txtReliefTaxbleIncome" runat="server" CssClass="txtBMR" MaxLength="10"
                                    onkeypress="return ValidateForOnlyNos(event);" Width="150px"> </asp:TextBox>
                            </td>
                            <td style="width: 90px">
                                Arrears Received
                            </td>
                            <td style="width: 160px">
                                <asp:TextBox ID="txtReliefArrearReceived" runat="server" CssClass="txtBMR" MaxLength="10"
                                    onkeypress="return ValidateForOnlyNos(event);" Width="160px"> </asp:TextBox>
                            </td>
                        </tr>
                    </table>
                    </tr>
                    <tr>
                        <table>
                        </table>
                    </tr>
                    <tr>
                        <table style="width: 742px">
                            <tr>
                                <td style="width: 100px">
                                    <asp:Button ID="btnReliefCalculate" runat="server" CssClass="cmnBtn" OnClientClick="return ValidateRelief89Details(false);"
                                        Text="Calculate" Width="100px" AutoPostBack="false" />
                                </td>
                                <td style="width: 120px">
                                    &nbsp;&nbsp;&nbsp;&nbsp; Relief Amount
                                </td>
                                <td style="width: 150px">
                                    <asp:TextBox ID="txtReliefCalculatedAmount" runat="server" CssClass="txtBMR" Enabled="true"
                                        onkeypress="return ValidateForOnlyNos(event);" MaxLength="10" Width="150px"> </asp:TextBox>
                                </td>
                                <td style="width: 80px">
                                </td>
                                <td style="width: 80px">
                                </td>
                                <td style="width: 80px">
                                </td>
                                <td style="width: 80px">
                                    <asp:Button ID="btnReliefAdd" runat="server" CssClass="cmnBtn" Text="Add" OnClick="btnReliefAdd_Click"
                                        OnClientClick="return ValidateRelief89Details(true);" Width="80px" />
                                </td>
                                <td style="width: 80px">
                                    <asp:Button ID="btnReliefClose" runat="server" CssClass="cmnBtn" Text="Close" Width="80px"
                                        OnClick="btnReliefClose_Click" />
                                </td>
                            </tr>
                        </table>
                    </tr>
                    </table> </tr>
                    <tr>
                        <td colspan="6">
                            <asp:Panel ID="pnlRelief" runat="server" CssClass="navPanel" Width="742px" ScrollBars="Horizontal">
                                <asp:Repeater ID="rptrRelief" runat="server" OnItemCommand="rptrRelief_ItemCommand"
                                    OnItemDataBound="rptrRelief_ItemDataBound">
                                    <HeaderTemplate>
                                        <table class="nTbl">
                                            <tr bgcolor="#EEEEEE">
                                                <th style="text-align: left">
                                                    <asp:Label runat="server" ID="lblReliefHeadFinYear" Width="90px" Text="Financial Year" />
                                                </th>
                                                <th style="text-align: right">
                                                    <asp:Label runat="server" ID="lblReliefHeadTaxableIncome" Width="150px" Text="Taxable Income" />
                                                </th>
                                                <th style="text-align: right">
                                                    <asp:Label runat="server" ID="lblReliefHeadArrearReceived" Width="150px" Text="Arrears Received" />
                                                </th>
                                                <th style="text-align: right">
                                                    <asp:Label runat="server" ID="lblReliefHeadAmount" Width="150px" Text="Relief Amount" />
                                                </th>
                                                <th style="text-align: center">
                                                    <asp:Label runat="server" ID="lblReliefHeadAction" Width="50px" Text="Action" />
                                                </th>
                                            </tr>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <tr bgcolor="white">
                                            <td style="width: 90px">
                                                <asp:Label runat="server" ID="lblRelief89DetailID" Text='<%#Eval("RELIEF89DETAILID")%>'
                                                    Visible="false" />
                                                <%# Eval("FINANCIALYEAR")%>
                                            </td>
                                            <td style="width: 150px; text-align: right">
                                                <%# Eval("TAXABLEINCOME")%>
                                            </td>
                                            <td style="width: 150px; text-align: right">
                                                <%# Eval("ARREARRECEIVED")%>
                                            </td>
                                            <td style="width: 150px; text-align: right">
                                                <%# Eval("RELIEFAMOUNT")%>
                                            </td>
                                            <td style="text-align: center">
                                                <asp:LinkButton ID="lnkReliefDelete" runat="server" Text="Delete" CommandName="Delete"
                                                    Font-Underline="false" CommandArgument='<%#Eval("SalaryDetailRowNo") %>'></asp:LinkButton>
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                    </FooterTemplate>
                                </asp:Repeater>
                            </asp:Panel>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                        </td>
                    </tr>
                    </table>
                </asp:View>
                <asp:View ID="vwTaxPerk" runat="server">
                    <table class="nTbl">
                        <tr>
                            <td class="eCol">
                                <table>
                                    <tr>
                                        <td style="width: 45%">
                                            Perk - Where accommodation is unfurnished
                                        </td>
                                        <td style="width: 55%">
                                            <asp:TextBox ID="txtPerkAccUnfurnished" runat="server" AutoComplete="off" TabIndex="1"
                                                MaxLength="14" CssClass="txtAR" onkeypress="return numeralsOnly(this, event,10,0,0,1);"
                                                onchange="return checkDecimalNo(this);" onkeyup="CalculateTaxPerks();">
                                            </asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" width="100%">
                                            <div>
                                                <div class="dialog" style="width: 100%;">
                                                    <div class="dHeader">
                                                        Furnished Details</div>
                                                    <div style="padding: 10px; border-top: solid 1px gray">
                                                        <table class="nTbl">
                                                            <tr>
                                                                <td width="20%">
                                                                    Perk - Furnished - Value as if accomodation is unfurnished
                                                                </td>
                                                                <td style="padding-left: 8px" width="80%">
                                                                    <asp:TextBox ID="txtPerkFurnishedValue" runat="server" AutoComplete="off" TabIndex="2"
                                                                        CssClass="txtAR" MaxLength="14" onkeypress="return numeralsOnly(this, event,10,0,0,1);"
                                                                        onchange="return checkDecimalNo(this);" onkeyup="CalculateTaxPerks();">
                                                                    </asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    Cost of Furniture
                                                                </td>
                                                                <td style="padding-left: 8px">
                                                                    <asp:TextBox ID="txtCostOfFurniture" runat="server" AutoComplete="off" TabIndex="3"
                                                                        MaxLength="14" CssClass="txtAR" onkeypress="return numeralsOnly(this, event,10,0,0,1);"
                                                                        onchange="return checkDecimalNo(this);" onkeyup="CalculateTaxPerks();">
                                                                    </asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    Furniture Rentals
                                                                </td>
                                                                <td style="padding-left: 8px">
                                                                    <asp:TextBox ID="txtFurnitureRentals" runat="server" AutoComplete="off" TabIndex="4"
                                                                        MaxLength="14" CssClass="txtAR" onkeypress="return numeralsOnly(this, event,10,0,0,1);"
                                                                        onchange="return checkDecimalNo(this);" onkeyup="CalculateTaxPerks();">
                                                                    </asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    Perquisite value of furniture
                                                                </td>
                                                                <td style="padding-left: 8px">
                                                                    <asp:TextBox ID="txtPerquisiteValueOfFurniture" runat="server" AutoComplete="off"
                                                                        MaxLength="14" Enabled="false" CssClass="txtARM" onkeypress="return numeralsOnly(this, event,10,0,0,1);"
                                                                        onchange="return checkDecimalNo(this);"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td width="50%">
                                                                    Perk-Furnished-Total
                                                                </td>
                                                                <td style="padding-left: 8px">
                                                                    <asp:TextBox ID="txtPerkFurnishedTotal" runat="server" AutoComplete="off" MaxLength="14"
                                                                        Enabled="false" CssClass="txtARM" onkeypress="return numeralsOnly(this, event,10,0,0,1);"
                                                                        onchange="return checkDecimalNo(this);"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 51%">
                                            Rent paid by employee
                                        </td>
                                        <td style="width: 49%">
                                            <asp:TextBox ID="txtRentPaid" runat="server" AutoComplete="off" TabIndex="5" CssClass="txtAR"
                                                MaxLength="14" onchange="return checkDecimalNo(this);" onkeypress="return numeralsOnly(this, event,10,0,0,1);"
                                                onkeyup="CalculateTaxPerks();" Width="95%">
                                            </asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 45%">
                                            Value of perquisites
                                        </td>
                                        <td style="width: 55%; padding-left: 1px; padding-right: 3px;">
                                            <asp:TextBox ID="txtValueofPerquisites" runat="server" AutoComplete="off" Enabled="false"
                                                MaxLength="14" CssClass="txtARM" onkeypress="return numeralsOnly(this, event,10,0,0,1);"
                                                onchange="return checkDecimalNo(this);"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td class="eCol" valign="top">
                                <table>
                                    <tr>
                                        <td class="vHCol">
                                            Conveyance
                                        </td>
                                        <td class="iCol">
                                            <asp:TextBox ID="txtConveyance" runat="server" AutoComplete="off" TabIndex="6" CssClass="txtAR"
                                                MaxLength="14" onkeypress="return numeralsOnly(this, event,10,0,0,1);" onchange="return checkDecimalNo(this);"
                                                onkeyup="CalculateTaxPerks();">
                                            </asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="vHCol">
                                            Remuneration paid on behalf of employee
                                        </td>
                                        <td class="iCol">
                                            <asp:TextBox ID="txtRemuneration" runat="server" AutoComplete="off" TabIndex="7"
                                                CssClass="txtAR" MaxLength="14" onkeypress="return numeralsOnly(this, event,10,0,0,1);"
                                                onchange="return checkDecimalNo(this);" onkeyup="CalculateTaxPerks();">
                                            </asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="vHCol">
                                            Taxable LTC
                                        </td>
                                        <td class="iCol">
                                            <asp:TextBox ID="txtTaxableLTC" runat="server" AutoComplete="off" TabIndex="8" CssClass="txtAR"
                                                MaxLength="14" onkeypress="return numeralsOnly(this, event,10,0,0,1);" onchange="return checkDecimalNo(this);"
                                                onkeyup="CalculateTaxPerks();">
                                            </asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="vHCol">
                                            Others Benefits
                                        </td>
                                        <td class="iCol">
                                            <asp:TextBox ID="txtOtherBenefit" runat="server" AutoComplete="off" TabIndex="9"
                                                CssClass="txtAR" MaxLength="14" onkeypress="return numeralsOnly(this, event,10,0,0,1);"
                                                onchange="return checkDecimalNo(this);" onkeyup="CalculateTaxPerks();">
                                            </asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="vHCol">
                                            PF in excess of 12%
                                        </td>
                                        <td class="iCol">
                                            <asp:TextBox ID="txtPFInExcess" runat="server" AutoComplete="off" TabIndex="10" CssClass="txtAR"
                                                MaxLength="14" onkeypress="return numeralsOnly(this, event,10,0,0,1);" onchange="return checkDecimalNo(this);"
                                                onkeyup="CalculateTaxPerks();">
                                            </asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="vHCol">
                                            Excess interest Credited
                                        </td>
                                        <td class="iCol">
                                            <asp:TextBox ID="txtExcessInterest" runat="server" AutoComplete="off" TabIndex="11"
                                                CssClass="txtAR" MaxLength="14" onkeypress="return numeralsOnly(this, event,10,0,0,1);"
                                                onchange="return checkDecimalNo(this);" onkeyup="CalculateTaxPerks();">
                                            </asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="vHCol">
                                            Total value of perquisite
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtTotalValueOfPerquisite" runat="server" AutoComplete="off" CssClass="txtARM"
                                                MaxLength="14" Enabled="false" onkeypress="return numeralsOnly(this, event,10,0,0,1);"
                                                onchange="return checkDecimalNo(this);"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Button ID="btnOkPerquisitesDetails" Text="OK" runat="server" CssClass="cmnBtn"
                                    TabIndex="12" OnClientClick="return ValidatePerqDetail();" OnClick="btnOkPerquisitesDetails_Click" />
                                <asp:Button ID="btnClosePerquisitesDetails" Text="Back" runat="server" CssClass="cmnBtn"
                                    TabIndex="12" OnClick="btnClosePerquisitesDetails_Click" />
                            </td>
                        </tr>
                    </table>
                </asp:View>
                <asp:View ID="vwOtherIncome" runat="server">
                    <table width="100%">
                        <tr>
                            <td width="35%">
                                Salary from previous employment
                            </td>
                            <td>
                                <asp:TextBox ID="txtSalaryFromPrevEmp" runat="server" AutoComplete="off" Width="170px"
                                    TabIndex="1" MaxLength="14" CssClass="txtAR" onkeypress="return numeralsOnly(this, event,10,0,0,1);"
                                    onchange="return checkDecimalNo(this);" onkeyup="CalculateOtherIncome();"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Income from House Property
                            </td>
                            <td>
                                <asp:TextBox ID="txtIncomeFromHouseProp" runat="server" AutoComplete="off" Width="170px"
                                    TabIndex="2" MaxLength="14" CssClass="txtAR" onkeypress="return numeralsOnly(this, event,10,0,1,1);"
                                    onchange="return checkDecimalNo(this);" onkeyup="CalculateOtherIncome();"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Income from Business/Profession
                            </td>
                            <td>
                                <asp:TextBox ID="txtIncomeFromBsnProf" runat="server" AutoComplete="off" TabIndex="3"
                                    MaxLength="14" CssClass="txtAR" onkeypress="return numeralsOnly(this, event,10,0,0,1);"
                                    onchange="return checkDecimalNo(this);" onkeyup="CalculateOtherIncome();" Width="170px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Capital Gains
                            </td>
                            <td>
                                <asp:TextBox ID="txtCapitalGains" runat="server" AutoComplete="off" TabIndex="4"
                                    MaxLength="14" CssClass="txtAR" onkeypress="return numeralsOnly(this, event,10,0,0,1);"
                                    onchange="return checkDecimalNo(this);" onkeyup="CalculateOtherIncome();" Width="170px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Income from Other Sources
                            </td>
                            <td>
                                <asp:TextBox ID="txtIncomeFromOtherSources" runat="server" AutoComplete="off" MaxLength="14"
                                    TabIndex="5" CssClass="txtAR" onkeypress="return numeralsOnly(this, event,10,0,0,1);"
                                    onchange="return checkDecimalNo(this);" onkeyup="CalculateOtherIncome();" Width="170px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr runat="server" id="rowInterest">
                            <td>
                                Interest On SB Account
                            </td>
                            <td>
                                <asp:TextBox ID="txtInterestOnSBAccount" runat="server" AutoComplete="off" MaxLength="14"
                                    Enabled="false" CssClass="txtARM" Width="170px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Total
                            </td>
                            <td>
                                <asp:TextBox ID="txtTotalOtherIncomeDetails" runat="server" MaxLength="14" Enabled="false"
                                    CssClass="txtARM" onkeypress="return numeralsOnly(this, event,10,0,0,1);" onchange="return checkDecimalNo(this);"
                                    Width="170px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:Button ID="btnOkOtherIncomeDetails" Text="OK" runat="server" CssClass="cmnBtn"
                                    TabIndex="6" OnClientClick="UpdateOtherInc();" OnClick="btnOkOtherIncomeDetails_Click" />
                                <asp:Button ID="btnCloseOtherIncomeDetails" Text="Back" runat="server" CssClass="cmnBtn"
                                    TabIndex="6" OnClick="btnCloseOtherIncomeDetails_Click" />
                            </td>
                        </tr>
                    </table>
                </asp:View>
                <asp:View ID="vwTDSMade" runat="server">
                    <table style="width: 540px" border="0" cellpadding="0" cellspacing="0">
                        <tr style="width: 540px">
                            <td style="width: 540px">
                                <table style="width: 540px" border="0" cellpadding="0" cellspacing="10">
                                    <tr style="width: 540px">
                                        <td style="width: 170px">
                                            TDS Made
                                        </td>
                                        <td align="center" style="width: 85px">
                                            Income Tax
                                        </td>
                                        <td align="center" style="width: 85px">
                                            Surcharge
                                        </td>
                                        <td align="center" style="width: 85px">
                                            Cess
                                        </td>
                                        <td align="center" style="width: 85px">
                                            Total
                                        </td>
                                    </tr>
                                    <tr valign="top">
                                        <td>
                                            Previous Employment
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtPrevEmpIncTax" runat="server" AutoComplete="off" TabIndex="1"
                                                MaxLength="14" CssClass="txtAR" onkeypress="return numeralsOnly(this, event,10,0,0,1);"
                                                onchange="return checkDecimalNo(this);" onkeyup="CalculateTDSDetails();">
                                            </asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtPrevEmpSurcharge" runat="server" CssClass="txtAR" MaxLength="14"
                                                Enabled="false" onkeypress="return numeralsOnly(this, event,10,0,0,1);">
                                            </asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtPrevEmpCess" runat="server" AutoComplete="off" TabIndex="2" MaxLength="14"
                                                CssClass="txtAR" onkeypress="return numeralsOnly(this, event,10,0,0,1);" onchange="return checkDecimalNo(this);"
                                                onkeyup="CalculateTDSDetails();">
                                            </asp:TextBox>
                                        </td>
                                        <td style="width: 75px">
                                            <asp:TextBox ID="txtPrevEmpTotal" runat="server" MaxLength="14" CssClass="txtARM"
                                                Enabled="false" onkeypress="return numeralsOnly(this, event,10,0,0,1);" onchange="return checkDecimalNo(this);"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Without Deduction Details
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtWithoutDedDetailsIncTax" runat="server" MaxLength="14" CssClass="txtAR"
                                                onkeypress="return numeralsOnly(this, event,10,0,0,1);" onchange="return checkDecimalNo(this);"
                                                onkeyup="CalculateTDSDetails();" AutoComplete="off" TabIndex="3">
                                            </asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtWithoutDedDetailsSurcharge" runat="server" CssClass="txtAR" MaxLength="14"
                                                onkeypress="return numeralsOnly(this, event,10,0,0,1);" onchange="return checkDecimalNo(this);">
                                            </asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtWithoutDedDetailsCess" runat="server" AutoComplete="off" TabIndex="4"
                                                CssClass="txtAR" MaxLength="14" onkeypress="return numeralsOnly(this, event,10,0,0,1);"
                                                onchange="return checkDecimalNo(this);" onkeyup="CalculateTDSDetails();">
                                            </asp:TextBox>
                                        </td>
                                        <td style="width: 75px">
                                            <asp:TextBox ID="txtWithoutDedDetailsTotal" runat="server" MaxLength="14" CssClass="txtARM"
                                                Enabled="false" onkeypress="return numeralsOnly(this, event,10,0,0,1);" onchange="return checkDecimalNo(this);"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            With Deduction Details
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtWithDedDetailsIncTax" runat="server" MaxLength="14" CssClass="txtARM"
                                                Enabled="false" onkeypress="return numeralsOnly(this, event,10,0,0,1);" onchange="return checkDecimalNo(this);"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtWithDedDetailsSurcharge" runat="server" MaxLength="14" Enabled="false"
                                                CssClass="txtARM" onkeypress="return numeralsOnly(this, event,10,0,0,1);" onchange="return checkDecimalNo(this);"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtWithDedDetailsCess" runat="server" MaxLength="14" CssClass="txtARM"
                                                Enabled="false" onkeypress="return numeralsOnly(this, event,10,0,0,1);" onchange="return checkDecimalNo(this);"></asp:TextBox>
                                        </td>
                                        <td style="width: 75px">
                                            <asp:TextBox ID="txtWithDedDetailsTotal" runat="server" MaxLength="14" CssClass="txtARM"
                                                Enabled="false" onkeypress="return numeralsOnly(this, event,10,0,0,1);" onchange="return checkDecimalNo(this);"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Total
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtTotalDedDetailsIncTax" runat="server" CssClass="txtARM" MaxLength="14"
                                                Enabled="false" onkeypress="return numeralsOnly(this, event,10,0,0,1);" onchange="return checkDecimalNo(this);"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtTotalDedDetailsSurcharge" runat="server" CssClass="txtARM" MaxLength="14"
                                                Enabled="false" onkeypress="return numeralsOnly(this, event,10,0,0,1);" onchange="return checkDecimalNo(this);"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtTotalDedDetailsCess" runat="server" CssClass="txtARM" MaxLength="14"
                                                Enabled="false" onkeypress="return numeralsOnly(this, event,10,0,0,1);" onchange="return checkDecimalNo(this);"></asp:TextBox>
                                        </td>
                                        <td style="width: 75px">
                                            <asp:TextBox ID="txtTotalDedDetailsTotal" runat="server" CssClass="txtARM" MaxLength="14"
                                                Enabled="false" onkeypress="return numeralsOnly(this, event,10,0,0,1);" onchange="return checkDecimalNo(this);"></asp:TextBox>
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
                                            <asp:Button ID="btnDeleteTDSMadeDetails" Text="Delete" runat="server" CssClass="cmnBtn"
                                                Width="80px" OnClientClick="ClearTDSMadeDetails();
                                                                            CalculateTDSDetails();" UseSubmitBehavior="False" />
                                        </td>
                                        <td>
                                            <asp:Button ID="btnOkTDSMadeDetails" Text="OK" runat="server" CssClass="cmnBtn" Width="80px"
                                                OnClientClick="UpdateTotalTDS();" OnClick="btnOkTDSMadeDetails_Click" TabIndex="5" />
                                        </td>
                                        <td>
                                            <asp:Button ID="btnCloseTDSMadeDetails" Text="Back" runat="server" CssClass="cmnBtn"
                                                Width="80px" OnClick="btnCloseTDSMadeDetails_Click" TabIndex="5" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </asp:View>
                <asp:View ID="vwChapterVIA" runat="server">
                    <table width="550px" border="0">
                        <tr>
                            <td style="width: 120px">
                                Section Name
                            </td>
                            <td style="width: 145px">
                                <asp:DropDownList ID="cmbSection" runat="server" AutoPostBack="true" OnSelectedIndexChanged="cmbSection_SelectedIndexChanged"
                                    Width="141px">
                                </asp:DropDownList>
                            </td>
                            <td style="width: 30px">
                                <asp:Button ID="btn80CDetails" runat="server" Text="..." CssClass="cmnBtn" Width="30px"
                                    ToolTip="80C Details" OnClientClick="ValidateData();return false" Visible="false" />
                            </td>
                            <td style="width: 55px">
                                <asp:Label ID="lblMaxLimit" runat="server" Text="Max Limit" Visible="false"></asp:Label>
                            </td>
                            <td style="width: 50px">
                                <asp:RadioButton ID="rbnValue1" runat="server" Text="10000" GroupName="Limit" Visible="false"
                                    onClick="SetLimitValues();" />
                            </td>
                            <td style="width: 50px">
                                <asp:RadioButton ID="rbnValue2" runat="server" Text="15000" GroupName="Limit" Visible="false"
                                    onClick="SetLimitValues();" />
                            </td>
                            <td>
                                <asp:RadioButton ID="rbnValue3" runat="server" Text="80000" GroupName="Limit" Visible="false"
                                    onClick="SetLimitValues();" />
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 120px">
                                Gross Amount
                            </td>
                            <td style="width: 145px">
                                <asp:TextBox ID="txtGrossAmount" runat="server" MaxLength="14" CssClass="txtAR" Width="135px"
                                    onblur="SetQualifyingAmount();return true" onkeypress="return numeralsOnly(this, event,10,0,0,1);"
                                    onchange="return checkDecimalNo(this);" AutoComplete="off"></asp:TextBox>
                            </td>
                            <td colspan="5">
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 120px">
                                Qualifying Amount
                            </td>
                            <td style="width: 145px">
                                <asp:TextBox ID="txtQualifyingAmount" runat="server" MaxLength="14" CssClass="txtAR"
                                    onblur="return CheckQualifyingAmount();" Width="135px" onkeypress="return numeralsOnly(this, event,10,0,0,1);"
                                    onchange="return checkDecimalNo(this);" AutoComplete="off"></asp:TextBox>
                            </td>
                            <td colspan="5">
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 120px">
                                Deductible Amount
                            </td>
                            <td style="width: 145px">
                                <asp:TextBox ID="txtDeductibleAmount" runat="server" MaxLength="14" CssClass="txtAR"
                                    Width="135px" onkeypress="return numeralsOnly(this, event,10,0,0,1);" onchange="return checkDecimalNo(this);"
                                    onblur="return ValidateChapter80CRelatedDeds();" AutoComplete="off"></asp:TextBox>
                            </td>
                            <td colspan="5">
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 120px">
                                Remarks
                            </td>
                            <td style="width: 145px">
                                <asp:TextBox ID="txtRemarks" runat="server" MaxLength="50" CssClass="txtAR" Width="135px"
                                    AutoComplete="off"></asp:TextBox>
                            </td>
                            <td colspan="5">
                            </td>
                        </tr>
                        <tr>
                            <td align="left" colspan="7">
                                <table cellpadding="0" cellspacing="1">
                                    <tr>
                                        <td align="right" style="width: 50px">
                                        </td>
                                        <td align="center" style="width: 130px">
                                            Gross
                                        </td>
                                        <td align="center" style="width: 130px">
                                            Qualifying
                                        </td>
                                        <td align="center" style="width: 130px">
                                            Deductible
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left" style="width: 50px">
                                            Total
                                        </td>
                                        <td align="right">
                                            <asp:TextBox ID="txtTotalGross" runat="server" CssClass="txtARM" Enabled="false"
                                                MaxLength="14" Width="130px"></asp:TextBox>
                                        </td>
                                        <td align="right">
                                            <asp:TextBox ID="txtTotalQualifying" runat="server" CssClass="txtARM" Enabled="false"
                                                MaxLength="14" Width="130px"></asp:TextBox>
                                        </td>
                                        <td align="right">
                                            <asp:TextBox ID="txtTotalDeductible" runat="server" CssClass="txtARM" Enabled="false"
                                                MaxLength="14" Width="130px"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <table align="left">
                                    <tr>
                                        <td>
                                            <asp:Button ID="btnOkDeductionUc" runat="server" CssClass="cmnBtn" OnClick="btnOkDeductionUc_Click"
                                                OnClientClick="return ValidateTotalDeductibleAmnt();" Text="OK" Width="80px" />
                                        </td>
                                        <td valign="middle">
                                            <asp:Button ID="btnClose" runat="server" CssClass="cmnBtn" OnClick="btnClose_Click"
                                                OnClientClick="return ValidateChapterVIDeds();" Text="Back" Width="80px" />
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
                                        TargetControlID="txtPANLL3" CompletionInterval="2" EnableCaching="false" CompletionSetCount="20"
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
            </asp:MultiView>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
