tableextension 50004 "Purch.Inv.HeaderExt" extends "Purch. Inv. Header"
{
    fields
    {
        field(50000; "CRN No."; Code[20])
        {
            Caption = 'CRN No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50002; "End User"; Text[100])
        {
            Caption = 'End User';
            DataClassification = ToBeClassified;
        }
        field(50003; "End User Code"; Code[20])
        {
            Caption = 'End User Code';
            DataClassification = ToBeClassified;
        }
    }
}
