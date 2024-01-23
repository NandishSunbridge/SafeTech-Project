report 50004 "Invoice and Packaging List"
{
    ApplicationArea = All;
    Caption = 'Invoice and Packaging List';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'InvoiceandPackagingReport.rdl';
    dataset
    {
        dataitem(SalesHeader; "Sales Header")
        {
            column(No; "No.")
            {
            }
            column(DocumentDate; "Document Date")
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
            column(ShiptoName; "Ship-to Name")
            {
            }
            column(ShiptoAddress; "Ship-to Address")
            {
            }
            column(ShiptoAddress2; "Ship-to Address 2")
            {
            }
            column(ShiptoCity; "Ship-to City")
            {
            }
            column(ShiptoCountryRegionCode; "Ship-to Country/Region Code")
            {
            }
            column(ShiptoCounty; "Ship-to County")
            {
            }
            column(ShiptoPostCode; "Ship-to Post Code")
            {
            }
            column(ShipmentDate_SalesHeader; "Shipment Date")
            {
            }
            column(SelltoContact_SalesHeader; "Sell-to Contact")
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
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document No." = field("No.");
                column(Quantity_SalesLine; Quantity)
                {
                }
                column(Description_SalesLine; Description)
                {
                }
                column(No_SalesLine; "No.")
                {
                }
                column(UnitPrice_SalesLine; "Unit Price")
                {
                }
                column(UnitofMeasureCode_SalesLine; "Unit of Measure Code")
                {
                }
                column(Amount_SalesLine; Amount)
                {
                }
                column(SubTotal; SubTotal)
                {
                }
                column(SrNo; SrNo)
                {
                }
                column(GrandTotal; GrandTotal)
                {
                }
                column(AmountInWords; AmountInWords)
                {
                }
                trigger OnAfterGetRecord()
                var
                    SalesLineRec: Record "Sales Line";
                begin
                    SrNo += 1;
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
                end;
            }
            trigger OnAfterGetRecord()
            begin
                ////////Getting Company Information//////
                CompanyInfo.get;
                CompanyInfo.CalcFields(Picture);

                ////////Amount in words//////////////
                Direction := '=';
                AmountSales := ROUND(SubTotal, 0.01, Direction);
                Repcheck.InitTextVariable;
                RepCheck.FormatNoText(NoText, AmountSales, "Currency Code");
                AmountInWords := NoText[1];
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
        SrNo: Integer;
        CompanyInfo: Record "Company Information";
        SubTotal: Decimal;
        Repcheck: Report Check;
        NoText: array[2] of Text;
        AmountSales: Decimal;
        AmountInWords: text;
        GrandTotal: Decimal;
        Direction: Text;
}
