tableextension 50007 "Sales Header Ext" extends "Sales Header"
{
    fields
    {
        field(50000; "Lead Time"; Text[15])
        {
            Caption = 'Lead Time';
            DataClassification = ToBeClassified;
        }
        field(50001; "Inco Terms"; Text[35])
        {
            Caption = 'Inco Terms';
            DataClassification = ToBeClassified;
        }
        field(50002; "CRN No."; Code[20])
        {
            Caption = 'CRN No.';
            DataClassification = ToBeClassified;
            // Editable = true;
            // trigger OnLookup()
            // var
            //     OppurtunityRec: Record Opportunity
            // begin
            //     OppurtunityRec.Reset();
            //     OppurtunityRec.SetRange();
            //     if CustomerRec.FindFirst() then begin
            //         if Page.RunModal(Page::"Customer List", CustomerRec) = Action::LookupOK then begin
            //             "End User" := CustomerRec.Name;
            //             "End User Code" := CustomerRec."No.";
            //         end;
            //     end;
            // end;
        }
        field(50003; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50004; "Vendor Name"; Text[50])
        {
            Caption = 'Vendor Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50005; "Purchase Quote No."; Code[20])
        {
            Caption = 'Purchase Quote No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50006; "End User"; Text[100])           ///////Nandish 02-24/////////
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
        field(50007; "End User Code"; Code[20])           ///////Nandish 02-24/////////
        {
            Caption = 'End User Code';
            DataClassification = ToBeClassified;
        }
        field(50008; "Lead Type"; Text[50])
        {
            Caption = 'Lead Type';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }
    trigger OnAfterInsert()
    var
        OpportunityRec: Record Opportunity;
    begin
        OpportunityRec.Reset();
        OpportunityRec.SetRange("No.", Rec."Opportunity No.");
        if OpportunityRec.FindFirst() then begin
            Rec."CRN No." := OpportunityRec."CRN No.";
            Rec."End User" := OpportunityRec."End User";
            Rec."End User Code" := OpportunityRec."End User Code";
            Rec."Lead Type" := OpportunityRec."Lead Type";
            Rec.Modify(true);
        end;
    end;
}
