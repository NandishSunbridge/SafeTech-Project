report 50000 "Item Comparison Report"
{
    ApplicationArea = All;
    Caption = 'Item Comparison Report';
    UsageCategory = ReportsAndAnalysis;

    RDLCLayout = './Layouts/Item Comparison Report.rdl';
    DefaultLayout = RDLC;
    dataset
    {
        dataitem(SalesHeader; "Sales Header")
        {
            column(CRN; "CRN No.")
            {
            }
            dataitem(SalesLine; "Sales Line")
            {
                DataItemLink = "Document No." = field("No.");
                //DataItemTableView = where("No." = filter(<> ''));
                DataItemTableView = SORTING("Document Type") ORDER(Descending) WHERE("No." = filter(<> ''));
                column(Type; "Type")
                {
                }
                column(DocumentType_SalesLine; "Document Type")
                {
                }
                column(No; "No.")
                {
                }
                column(UnitPrice_SalesLine; "Unit Price")
                {
                }
                column(CompanyName; CompanyInformationRec.Name)
                {
                }
                column(CompanyAddress; CompanyInformationRec.Address)
                {
                }
                column(CompanyAddress2; CompanyInformationRec."Address 2")
                {
                }
                column(CompanyPostCode; CompanyInformationRec."Post Code")
                {
                }
                column(CompanyCity; CompanyInformationRec.City)
                {
                }
                column(CompanyPicture; CompanyInformationRec.Picture)
                {
                }
            }
            trigger OnPreDataItem();
            begin
                CompanyInformationRec.Get();
                CompanyInformationRec.CalcFields(CompanyInformationRec.Picture);
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
        CompanyInformationRec: Record "Company Information";
}
