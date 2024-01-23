table 50000 Companies
{
    Caption = 'Companies';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            Editable = false;
            AutoIncrement = true;
        }
        field(2; "Comany Name"; Text[50])
        {
            Caption = 'Comany Name';
            TableRelation = Company;
        }
        field(3; Copied; Boolean)
        {
            Caption = 'Copied';
        }
        field(4; Remarks; Text[100])
        {
            Caption = 'Remarks';
        }
        field(5; ActiveYesNo; Boolean)
        {
            Caption = 'Active Yes/No';
        }
        field(6; "Created Date"; Date)
        {
            Caption = 'Created Date';
            Editable = false;
        }
        field(7; "Create Time"; Time)
        {
            Caption = 'Create Time';
            Editable = false;
        }
        field(8; "User ID"; Code[50])
        {
            Caption = 'User Id';
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        CompaiesRec: Record Companies;
    begin
        if CompaiesRec.FindLast() then
            "Entry No." := CompaiesRec."Entry No." + 1
        else
            "Entry No." := 1;
        "Created Date" := Today;
        "Create Time" := time;
        "User ID" := UserId;
    end;

    trigger OnModify()
    var
    begin
        "Created Date" := Today;
        "Create Time" := time;
        "User ID" := UserId;
    end;
}
