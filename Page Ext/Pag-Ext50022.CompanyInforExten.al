pageextension 50022 "Company Infor Exten" extends "Company Information"
{
    layout
    {
        addafter(Picture)
        {
            field("Picture 1"; Rec."Picture 1")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Picture 1 field.';
            }
            field("Arabic Name"; Rec."Arabic Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Arabic Name field.';
            }
        }
    }
}
