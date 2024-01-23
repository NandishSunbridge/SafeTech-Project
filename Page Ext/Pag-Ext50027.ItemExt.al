pageextension 50027 "Item Ext" extends "Item Card"
{
    layout
    {
        addlast(Item)
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
