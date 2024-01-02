report 50203 "Pro Forma Invoice Report"
{
    ApplicationArea = All;
    Caption = 'Pro Forma Invoice Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'ProFormaInvoiceReport.rdl';
    dataset
    {
        dataitem(SalesHeader; "Sales Header")
        {
            column(No; "No.")
            {
            }
            column(BilltoName_SalesHeader; "Bill-to Name")
            {
            }
            column(BilltoAddress_SalesHeader; "Bill-to Address")
            {
            }
            column(BilltoAddress2_SalesHeader; "Bill-to Address 2")
            {
            }
            column(BilltoCity_SalesHeader; "Bill-to City")
            {
            }
            column(BilltoCounty_SalesHeader; "Bill-to County")
            {
            }
            column(BilltoCountryRegionCode_SalesHeader; "Bill-to Country/Region Code")
            {
            }
            column(BilltoPostCode_SalesHeader; "Bill-to Post Code")
            {
            }
            column(DocumentDate_SalesHeader; "Document Date")
            {
            }
            column(ShipmentDate_SalesHeader; "Shipment Date")
            {
            }
            column(YourReference_SalesHeader; "Your Reference")
            {
            }
            column(CurrencyCode_SalesHeader; "Currency Code")
            {
            }
            column(PaymentTermsCode_SalesHeader; "Payment Terms Code")
            {
            }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyAddress; CompanyInfo.Address)
            {
            }
            column(CompanyAddress2; CompanyInfo."Address 2")
            {
            }
            column(CompanyCity; CompanyInfo.City)
            {
            }
            column(CompanyCountry; CompanyInfo."Country/Region Code")
            {
            }
            column(CompanyPostCode; CompanyInfo."Post Code")
            {
            }
            column(CompanyLogo; CompanyInfo.Picture)
            {
            }
            column(CompanyEMail; CompanyInfo."E-Mail")
            {
            }
            column(CompanyFaxNo; CompanyInfo."Fax No.")
            {
            }
            column(CompanyHomePage; CompanyInfo."Home Page")
            {
            }
            column(CompanyPhoneno; CompanyInfo."Phone No.")
            {
            }
            column(CompanyBankname; CompanyInfo."Bank Name")
            {
            }
            column(CompanyBankaccno; CompanyInfo."Bank Account No.")
            {
            }
            column(CompanyBankbranchno; CompanyInfo."Bank Branch No.")
            {
            }
            column(CompanySwiftcode; CompanyInfo."SWIFT Code")
            {
            }
            column(CompanyIban; CompanyInfo.IBAN)
            {
            }
            column(CompanyVatno; CompanyInfo."VAT Registration No.")
            {
            }
            column(CustomerPhoneno; Phoneno)
            {
            }
            column(CustomerFaxno; Faxno)
            {
            }
            column(CustomerEmail; Email)
            {
            }

            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document No." = field("No.");
                column(No_SalesLine; "No.")
                {
                }
                column(Description_SalesLine; Description)
                {
                }
                column(Quantity_SalesLine; Quantity)
                {
                }
                column(UnitofMeasureCode_SalesLine; "Unit of Measure Code")
                {
                }
                column(UnitPrice_SalesLine; "Unit Price")
                {
                }
                column(LineAmount_SalesLine; "Line Amount")
                {
                }
                column(VAT_SalesLine; "VAT %")
                {
                }
                column(AmountIncludingVAT_SalesLine; "Amount Including VAT")
                {
                }
                column(Slno; Slno)
                {
                }
                column(SubTotal; SubTotal)
                {
                }
                column(GrandTotal; GrandTotal)
                {
                }
                column(Vatamount; Vatamount)
                {
                }
                trigger OnAfterGetRecord()
                var
                    SalesLineRec: Record "Sales Line";
                begin
                    ////////Serial No////////
                    Slno += 1;

                    ////////Company Information//////////
                    CompanyInfo.get;
                    CompanyInfo.CalcFields(Picture);

                    ///////Calculation of Sub-Total//////////
                    SalesLineRec.RESET;
                    SalesLineRec.SETRANGE("Document No.", "Sales Line"."Document No.");
                    IF SalesLineRec.FINDFIRST THEN BEGIN
                        repeat
                            SubTotal += SalesLineRec.Amount;
                        until SalesLineRec.Next() = 0;
                    END;

                    //////Amount Including VAT-Grand Total///////
                    SalesLineRec.RESET;
                    SalesLineRec.SETRANGE("Document No.", "Sales Line"."Document No.");
                    IF SalesLineRec.FINDFIRST THEN BEGIN
                        repeat
                            GrandTotal += SalesLineRec."Amount Including VAT";
                        until SalesLineRec.Next() = 0;
                    END;
                    ///////Calculate Vat Amount///////////
                    SalesLineRec.RESET;
                    SalesLineRec.SETRANGE("Document No.", "Sales Line"."Document No.");
                    //  SalesLineRec.SetRange("Line No.", "Sales Line"."Line No.");
                    // SalesLineRec.SetRange("No.", "Sales Line"."No.");
                    if SalesLineRec.FindFirst() then begin
                        repeat
                            Vatamount += (SalesLineRec."Line Amount" / 100) * SalesLineRec."VAT %";
                        until SalesLineRec.Next() = 0;
                    end;
                end;
            }
            trigger OnAfterGetRecord()
            begin
                CutomerRec.Reset();
                CutomerRec.SetRange("No.", "Sell-to Customer No.");
                if CutomerRec.FindFirst() then begin
                    Phoneno := CutomerRec."Phone No.";
                    Faxno := CutomerRec."Fax No.";
                    Email := CutomerRec."E-Mail";
                    Vatno := CutomerRec."VAT Registration No.";
                end;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    var
        CompanyInfo: Record "Company Information";
        Slno: Integer;
        SubTotal: Decimal;
        CutomerRec: Record Customer;
        Phoneno: Text[30];
        Faxno: Text[30];
        Email: Text[80];
        Vatno: Code[20];
        GrandTotal: Decimal;
        Vatamount: Decimal;
}
