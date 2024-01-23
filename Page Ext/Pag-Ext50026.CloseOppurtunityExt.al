pageextension 50026 "Close Oppurtunity Ext" extends "Close Opportunity"
{
    layout
    {
        addlast(General)
        {
            field(Remark; Rec.Remark)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Remark field.';
            }
        }
    }
}
