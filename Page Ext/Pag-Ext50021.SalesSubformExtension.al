pageextension 50021 "Sales Subform Extension" extends "Sales Quote Subform"
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
            field("Proposed Rate"; Rec."Vendor Unit Price")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Proposed Rate field.';
            }
            field("Vendor Name"; Rec."Vendor Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vendor Name field.';
            }
            // field("Vendor Currency Code"; Rec."Vendor Currency Code")
            // {
            //     ApplicationArea = All;
            //     ToolTip = 'Specifies the value of the Vendor Currency Code field.';
            // }
        }
    }
}
