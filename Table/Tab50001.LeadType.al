table 50001 "Lead Type"
{
    Caption = 'Lead Type';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Lead Code"; Code[20])
        {
            Caption = 'Lead Code';
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
    }
    keys
    {
        key(PK; "Lead Code")
        {
            Clustered = true;
        }
    }
}
