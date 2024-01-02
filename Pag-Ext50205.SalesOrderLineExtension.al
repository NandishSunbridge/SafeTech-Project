pageextension 50205 "Sales Order Line Extension" extends "Sales Order Subform"
{
    layout
    {
        addafter("Qty. Assigned")
        {
            field("Vendor No."; Rec."Vendor No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vendor No. field.';
            }
            field("Purchase Quotation No."; Rec."Purchase Quotation No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Purchase Quotation No. field.';
            }
            field("Proposed Rate"; Rec."Proposed Rate")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Proposed Rate field.';
            }
        }
    }
    actions
    {
        addafter("O&rder")
        {
            action("Create Purchase Order")
            {
                ApplicationArea = all;
                Caption = 'Create Purchase Order';
                Image = Document;
                ToolTip = 'Creates purchase order based on vendor no in lines.';
                trigger OnAction()
                var
                    ok: Boolean;
                    ProgressWindow: Dialog;
                    Createpurchaseordercu: Codeunit "Create Purchase Order From SO";
                begin
                    ok := Confirm('Do you want to create purchase order?', true, false);
                    if not ok then
                        exit;
                    ProgressWindow.Open('Processing #######  #1');
                    Createpurchaseordercu.Run(Rec);
                    // ProgressWindow.UPDATE(1, );
                    ProgressWindow.Close;
                end;
            }
        }
    }
}
