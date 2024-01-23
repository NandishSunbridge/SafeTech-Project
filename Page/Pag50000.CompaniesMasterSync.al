page 50000 "Companies Master Sync"
{
    ApplicationArea = All;
    Caption = 'Companies Master Sync';
    PageType = List;
    SourceTable = Companies;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(ActiveYesNo; Rec.ActiveYesNo)
                {
                    ToolTip = 'Specifies the value of the Active Yes/No field.';
                }
                field(Copied; Rec.Copied)
                {
                    ToolTip = 'Specifies the value of the Copied field.';
                }
                field("Create Time"; Rec."Create Time")
                {
                    ToolTip = 'Specifies the value of the Create Time field.';
                }
                field("Created Date"; Rec."Created Date")
                {
                    ToolTip = 'Specifies the value of the Created Date field.';
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the value of the User Id field.';
                }
                field("Comany Name"; Rec."Comany Name")
                {
                    ToolTip = 'Specifies the value of the Comany Name field.';
                }
            }
        }
    }
}
