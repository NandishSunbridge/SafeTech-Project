pageextension 50201 "Sales Quote Extension" extends "Sales Quote"
{
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
}
