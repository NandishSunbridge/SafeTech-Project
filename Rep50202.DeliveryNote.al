report 50202 "Delivery Note Report"
{
    ApplicationArea = All;
    Caption = 'Delivery Note Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'DeliveryNoteReport.rdl';
    dataset
    {
        dataitem(SalesHeader; "Sales Header")
        {
            PrintOnlyIfDetail = true;
            DataItemTableView = sorting("No.", "Document Type") where("Document Type" = filter(Invoice));
            column(No; "No.")
            {
            }
            column(SelltoCustomerNo; "Sell-to Customer No.")
            {
            }
            column(SelltoCustomerName; "Sell-to Customer Name")
            {
            }
            column(SelltoAddress; "Sell-to Address")
            {
            }
            column(SelltoAddress2; "Sell-to Address 2")
            {
            }
            column(SelltoCity; "Sell-to City")
            {
            }
            column(SelltoCountryRegionCode; "Sell-to Country/Region Code")
            {
            }
            column(SelltoCounty; "Sell-to County")
            {
            }
            column(SelltoPostCode; "Sell-to Post Code")
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
            column(CompanyLogo1; CompanyInfo."Picture 1")
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
                column(Slno; Slno)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    ////Serial Number Increment///////
                    Slno += 1;

                    ////////Getting Company Information//////
                    CompanyInfo.Get();
                    CompanyInfo.CalcFields(Picture);
                    CompanyInfo.CalcFields("Picture 1");
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
        Slno: Integer;
        CompanyInfo: Record "Company Information";
        CutomerRec: Record Customer;
        Phoneno: Text[30];
        Faxno: Text[30];
        Email: Text[80];

}
