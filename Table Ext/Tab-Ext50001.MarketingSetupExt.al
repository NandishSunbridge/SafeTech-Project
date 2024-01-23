tableextension 50001 MarketingSetupExt extends "Marketing Setup"
{
    fields
    {
        field(50000; "CRN Number No. Series"; Code[10])
        {
            Caption = 'CRN Number No. Series';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
    }
}
