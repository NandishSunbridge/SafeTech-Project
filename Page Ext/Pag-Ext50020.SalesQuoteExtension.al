/*pageextension 50020 "Sales Quote Extension" extends "Sales Quote"
{
    layout
    {
        addafter("Sell-to Customer Name")
        {
            field("CRN No."; Rec."CRN No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the CRN No. field.';
                Editable = false;
            }
            field("End User"; Rec."End User")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the End User field.';
            }
            field("End User Code"; Rec."End User Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the End User Code field.';
            }
            field("Lead Type"; Rec."Lead Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Lead Type field.';
            }
            field("Vendor No."; Rec."Vendor No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vendor No. field.';
            }
            field("Vendor Name"; Rec."Vendor Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vendor Name field.';
            }
            field("Purchase Quote No."; Rec."Purchase Quote No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Purchase Quote No. field.';
            }
        }
        addafter("Shipment Method Code")
        {
            field("Inco Terms"; Rec."Inco Terms")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Inco Terms field.';
            }
        }
        addafter(BillToOptions)
        {
            field("Lead Time"; Rec."Lead Time")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Lead Time field.';
            }
        }

    }
    actions
    {
        addlast(Category_Category9)
        {
            actionref("SalesQuoteReport"; "Sales Quote Report")
            {

            }
        }
        addafter(Print)
        {
            action("Sales Quote Report")
            {
                ApplicationArea = all;
                Caption = 'Sales Quote Report';
                Ellipsis = true;
                Image = Report;
                ToolTip = 'Prepare to print the document. The report request window for the document opens where you can specify what to include on the print-out.';
                trigger OnAction()
                var
                    SalesQuoteReport: Report 50201;
                begin
                    SalesHeaderRec.Reset();
                    SalesHeaderRec.SetRange("No.", Rec."No.");
                    if SalesHeaderRec.FindFirst() then begin
                        Report.Run(50201, false, true, SalesHeaderRec);
                    end;
                end;
            }
        }
    }
    var
        SalesHeaderRec: Record "Sales Header";
}*/
