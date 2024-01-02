pageextension 50202 "Sales Subform Extension" extends "Sales Quote Subform"
{
    layout
    {
        addafter("Qty. Assigned")
        {
            //     field("Mfg. Part. No"; Rec."Mfg. Part. No")
            //     {
            //         ApplicationArea = All;
            //         ToolTip = 'Specifies the value of the Mfg. Part. No  field.';
            //     }
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
}
