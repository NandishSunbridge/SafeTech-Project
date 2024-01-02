pageextension 50204 "Sales Invoice Extension" extends "Sales Invoice"
{
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
                    DeliveryNoteReport: Report 50202;
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
                    InvoicePackingListReport: Report 50204;
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
