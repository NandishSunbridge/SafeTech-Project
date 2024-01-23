tableextension 50003 PurchaseHeaderExt extends "Purchase Header"
{
    fields
    {
        field(50000; "CRN No."; Code[20])
        {
            Caption = 'CRN No.';
            DataClassification = ToBeClassified;
            ///Editable = false;
        }
        field(50001; "Opportunity No."; Code[20])
        {
            Caption = 'Opportunity No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50002; "End User"; Text[100])
        {
            Caption = 'End User';
            DataClassification = ToBeClassified;
            trigger OnLookup()
            var
                CustomerRec: Record Customer;
            begin
                CustomerRec.Reset();
                if CustomerRec.FindFirst() then begin
                    if Page.RunModal(Page::"Customer List", CustomerRec) = Action::LookupOK then begin
                        "End User" := CustomerRec.Name;
                        "End User Code" := CustomerRec."No.";
                    end;
                end;
            end;
        }
        field(50003; "End User Code"; Code[20])
        {
            Caption = 'End User Code';
            DataClassification = ToBeClassified;
        }
    }
}
