pageextension 50003 SalesQuotesListExt extends "Sales Quotes"
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
    }
}
