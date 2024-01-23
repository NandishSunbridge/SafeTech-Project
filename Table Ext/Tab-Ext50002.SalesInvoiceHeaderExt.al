tableextension 50002 SalesInvoiceHeaderExt extends "Sales Invoice Header"
{
    fields
    {
        field(50002; "CRN No."; Code[20])
        {
            Caption = 'CRN No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50006; "End User"; Text[100])
        {
            Caption = 'End User';
            DataClassification = ToBeClassified;
        }
        field(50007; "End User Code"; Code[20])
        {
            Caption = 'End User Code';
            DataClassification = ToBeClassified;
        }
    }
}
