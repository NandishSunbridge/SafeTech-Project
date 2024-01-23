pageextension 50028 "Item List Ext" extends "Item List"
{
    layout
    {
        addafter("Unit Price")
        {
            field("Brand Name"; Rec."Brand Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Brand Name field.';
            }
            field("Manufacturer Code(UD)"; Rec."Manufacturer Code(UD)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Manufacturer Code(UD) field.';
            }
        }
    }
}
