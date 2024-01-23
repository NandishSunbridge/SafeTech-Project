tableextension 50000 "Opportunity Extension" extends Opportunity
{
    fields
    {
        field(50000; "CRN No."; Code[20])
        {
            Caption = 'Customer Reference Number (CRN)';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50001; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            DataClassification = ToBeClassified;
            TableRelation = Vendor;

            trigger OnValidate()
            var
                VendorRec: Record Vendor;
                OpportunityRec: Record Opportunity;
            begin
                "Vendor Name" := '';
                if VendorRec.Get("Vendor No.") then begin
                    "Vendor Name" := VendorRec.Name;
                end;
            end;
        }

        field(50002; "Vendor Name"; Text[100])
        {
            Caption = 'Vendor Name';
            DataClassification = ToBeClassified;
            TableRelation = Vendor;
            Editable = false;
        }
        field(50003; "End User"; Text[100])           ///////Nandish 02-24/////////
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
        field(50004; "End User Code"; Code[20])           ///////Nandish 02-24/////////
        {
            Caption = 'End User Code';
            DataClassification = ToBeClassified;
        }
        field(50005; "Lead Type"; Text[50])
        {
            Caption = 'Lead Type';
            DataClassification = ToBeClassified;
            trigger OnLookup()
            var
                LeadTypeRec: Record "Lead Type";
            begin
                If Page.RunModal(Page::"Lead Type", LeadTypeRec) = Action::LookupOK then
                    Rec."Lead Type" := LeadTypeRec.Description;
            end;
        }

        modify("Contact No.")
        {
            trigger OnAfterValidate()
            var
                MarketingSetupRec: record "Marketing Setup";
                OpportunityRec: Record Opportunity;
                NoSeriesMgtCU: Codeunit NoSeriesManagement;

            begin
                IF MarketingSetupRec.Get() then;
                MarketingSetupRec.TestField("CRN Number No. Series");
                if Rec."CRN No." = '' then begin
                    NoSeriesMgtCU.InitSeries(MarketingSetupRec."CRN Number No. Series", MarketingSetupRec."CRN Number No. Series", 0D, Rec."CRN No.", MarketingSetupRec."CRN Number No. Series");
                end;
            end;
        }

    }
    trigger OnAfterModify()
    var
        SalesHDRec: Record "Sales Header";
    begin
        SalesHDRec.Reset();
        SalesHDRec.SetRange("Document Type", SalesHDRec."Document Type"::Quote);
        SalesHDRec.SetRange("No.", Rec."Sales Document No.");
        if SalesHDRec.FindFirst() then begin
            SalesHDRec."CRN No." := Rec."CRN No.";
            SalesHDRec.Modify(true);
        end;
    end;
}
