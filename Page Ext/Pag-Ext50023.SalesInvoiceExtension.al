pageextension 50023 "Sales Invoice Extension" extends "Sales Invoice"
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
        addlast(Category_PrintSend)
        {
            actionref("DeliveryNoteReport"; "Delivery Note Report")
            {
            }
            actionref("InvoicePackingListReport"; "Invoice Packing List Report")
            {
            }
        }
        addafter("P&osting")
        {
            action("Delivery Note Report")
            {
                ApplicationArea = all;
                Caption = 'Delivery Note Report';
                Ellipsis = true;
                Image = Report;
                ToolTip = 'Prepare to print the document. The report request window for the document opens where you can specify what to include on the print-out.';
                trigger OnAction()
                var
                    DeliveryNoteReport: Report 50002;
                begin
                    SalesHeaderRec.Reset();
                    SalesHeaderRec.SetRange("No.", Rec."No.");
                    if SalesHeaderRec.FindFirst() then begin
                        Report.Run(50202, false, true, SalesHeaderRec);
                    end;
                end;
            }
            action("Invoice Packing List Report")
            {
                ApplicationArea = all;
                Caption = 'Invoice/Packing List Report';
                Ellipsis = true;
                Image = Report;
                ToolTip = 'Prepare to print the document. The report request window for the document opens where you can specify what to include on the print-out.';
                trigger OnAction()
                var
                    InvoicePackingListReport: Report 50004;
                begin
                    SalesHeaderRec.Reset();
                    SalesHeaderRec.SetRange("No.", Rec."No.");
                    if SalesHeaderRec.FindFirst() then begin
                        Report.Run(50204, false, true, SalesHeaderRec);
                    end;
                end;
            }
        }
    }
    var
        SalesHeaderRec: Record "Sales Header";
}
