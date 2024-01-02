pageextension 50206 SalesOrderExtension extends "Sales Order"
{
    actions
    {
        addlast(Category_Category11)
        {
            actionref("ProFormaInvoiceReport"; "Pro Forma Invoice Report")
            {

            }
        }
        addafter("P&osting")
        {
            action("Pro Forma Invoice Report")
            {
                ApplicationArea = all;
                Caption = 'Pro Forma Invoice Report';
                Ellipsis = true;
                Image = Report;
                ToolTip = 'Prepare to print the document. The report request window for the document opens where you can specify what to include on the print-out.';
                trigger OnAction()
                var
                    ProFormaInvoiceReport: Report 50203;
                begin
                    SalesHeaderRec.Reset();
                    SalesHeaderRec.SetRange("No.", Rec."No.");
                    if SalesHeaderRec.FindFirst() then begin
                        Report.Run(50203, false, true, SalesHeaderRec);
                    end;
                end;
            }
        }
    }
    var
        SalesHeaderRec: Record "Sales Header";
}
