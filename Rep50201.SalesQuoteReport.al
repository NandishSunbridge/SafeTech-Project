report 50201 "Sales Quote Report"
{
    ApplicationArea = All;
    Caption = 'Sales Quote Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'SalesQuoteReport.rdl';
    dataset
    {
        dataitem(SalesHeader; "Sales Header")
        {
            //   DataItemTableView = sorting("No.", "Document Type") where("Document Type" = filter(Quote));
            column(No; "No.")
            {
            }
            column(DocumentDate; "Document Date")
            {
            }
            column(DueDate; "Due Date")
            {
            }
            column(SelltoCustomerNo_SalesHeader; "Sell-to Customer No.")
            {
            }
            column(SelltoCustomerName_SalesHeader; "Sell-to Customer Name")
            {
            }
            column(SelltoAddress_SalesHeader; "Sell-to Address")
            {
            }
            column(SelltoAddress2_SalesHeader; "Sell-to Address 2")
            {
            }
            column(SelltoCity_SalesHeader; "Sell-to City")
            {
            }
            column(SelltoCounty_SalesHeader; "Sell-to County")
            {
            }
            column(SelltoCountryRegionCode_SalesHeader; "Sell-to Country/Region Code")
            {
            }
            column(SelltoPhoneNo_SalesHeader; "Sell-to Phone No.")
            {
            }
            column(SelltoPostCode_SalesHeader; "Sell-to Post Code")
            {
            }
            column(CurrencyCode_SalesHeader; "Currency Code")
            {
            }
            column(YourReference_SalesHeader; "Your Reference")
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
            column(Salespersonname; Salespersonname)
            {
            }
            column(RequestedDeliveryDate_SalesHeader; "Requested Delivery Date")
            {
            }
            column(CustPhoneno; CustPhoneno)
            {
            }
            column(CustFaxno; CustFaxno)
            {
            }
            column(CustEmail; CustEmail)
            {
            }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document No." = field("No.");
                column(No_SalesLine; "No.")
                {
                }
                column(Slno; Slno)
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
                // column(MfgPartNo_SalesLine; "Mfg. Part. No")
                // {
                // }
                column(UnitPrice_SalesLine; "Unit Price")
                {
                }
                column(LineAmount_SalesLine; "Line Amount")
                {
                }
                column(Total; Total)
                {
                }
                column(AmountInWords; AmountInWords)
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
                    ////Serial Number Increment///////
                    Slno += 1;

                    ////////Getting Company Information//////
                    CompanyInfo.get;
                    CompanyInfo.CalcFields(Picture);

                    ///////Calculation of Sub-Total//////////
                    SalesLineRec.RESET;
                    SalesLineRec.SETRANGE("Document No.", "Sales Line"."Document No.");
                    IF SalesLineRec.FINDFIRST THEN BEGIN
                        repeat
                            TOTAL += SalesLineRec.Amount;
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

                    ///////Getting Extended text for item/////////
                    SalesLineRec.RESET;
                    SalesLineRec.SETRANGE("Document No.", "Sales Line"."Document No.");
                    SalesLineRec.SetRange("Line No.", "Sales Line"."Line No.");
                    IF SalesLineRec.FINDFIRST THEN BEGIN
                        ExtendedTextLineRec.Reset();
                        ExtendedTextLineRec.SetRange("No.", SalesLineRec."No.");
                        if ExtendedTextLineRec.FindFirst() then begin

                        end;
                    END;

                    ///////Getting SalesPerson Name////////////
                    SalespersonRec.Reset();
                    SalespersonRec.SetRange(Code, SalesHeader."Salesperson Code");
                    if SalespersonRec.FindFirst() then begin
                        Salespersonname := SalespersonRec.Name;
                    end;

                    /////////Amount in words////////////////
                    //Direction := '=';
                    AmountSales := ROUND(GrandTotal, 0.01);
                    RepCheck.InitTextVariable;
                    RepCheck.FormatNoText(NoText, AmountSales, "Currency Code");
                    AmountInWords := NoText[1];
                end;
            }
            dataitem(ExtendedTextLine; "Extended Text Line")
            {
                DataItemLink = "No." = field("No.");
                column(Text_ExtendedTextLine; "Text")
                {
                }
            }
            trigger OnAfterGetRecord()
            begin
                CustomerRec.Reset();
                CustomerRec.SetRange("No.", SalesHeader."Sell-to Customer No.");
                if CustomerRec.FindFirst() then begin
                    CustPhoneno := CustomerRec."Phone No.";
                    CustFaxno := CustomerRec."Fax No.";
                    CustEmail := CustomerRec."E-Mail";
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
        Total: Decimal;
        ExtendedTextLineRec: Record "Extended Text Line";
        SalespersonRec: Record "Salesperson/Purchaser";
        Salespersonname: Text[50];
        RepCheck: Report Check;
        AmountSales: Decimal;
        NoText: array[2] of Text;
        AmountInWords: text;
        SalesStatisticsPage: page "Sales Statistics";
        CustomerRec: Record Customer;
        CustPhoneno: Text[30];
        CustFaxno: Text[30];
        CustEmail: Text[80];
        GrandTotal: Decimal;
        Direction: Text;
        Vatamount: Decimal;
}
