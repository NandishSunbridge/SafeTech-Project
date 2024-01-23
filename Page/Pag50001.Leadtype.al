page 50001 "Lead type"
{
    ApplicationArea = All;
    Caption = 'Lead type';
    PageType = List;
    SourceTable = "Lead Type";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Lead Code"; Rec."Lead Code")
                {
                    ToolTip = 'Specifies the value of the Lead Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
            }
        }
    }
}
