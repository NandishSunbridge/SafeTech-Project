pageextension 50025 SalesOrderExtension extends "Sales Order"
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
        addafter("Shipping Time")
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
                    ProFormaInvoiceReport: Report 50003;
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
