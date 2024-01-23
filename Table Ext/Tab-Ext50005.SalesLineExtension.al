tableextension 50005 "Sales Line Exten" extends "Sales Line"
{
    fields
    {
        // field(50000; "Mfg. Part. No"; Code[20])
        // {
        //     Caption = 'Mfg. Part. No ';
        //     DataClassification = ToBeClassified;
        // }
        field(50001; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            DataClassification = ToBeClassified;
            TableRelation = Vendor."No.";
            trigger OnValidate()
            var
                VendorRec: Record Vendor;
            begin
                VendorRec.Reset();
                VendorRec.SetRange("No.", Rec."Vendor No.");
                if VendorRec.FindFirst() then begin
                    Rec."Vendor Name" := VendorRec.Name;
                end;
            end;
        }
        field(50002; "Purchase Quotation No."; Code[20])
        {
            Caption = 'Purchase Quotation No.';
            DataClassification = ToBeClassified;
        }
        field(50003; "Vendor Unit Price"; Decimal)
        {
            Caption = 'Vendor Unit Price';
            DataClassification = ToBeClassified;
        }
        field(50004; "Vendor Currency Code"; Text[30])
        {
            Caption = 'Vendor Currency Code';
            DataClassification = ToBeClassified;
            TableRelation = Currency.Code;
            // trigger OnLookup()
            // var
            //     CurrencyRec: Record Currency;
            // begin
            //     If Page.RunModal(Page::Currencies, CurrencyRec) = Action::LookupOK then
            //         Rec."Vendor Currency Code" := CurrencyRec.Description;
            // end;
        }
        field(50005; "Vendor Name"; Text[100])
        {
            Caption = 'Vendor Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }
    keys
    {
        key(VendorNo; "Vendor No.")
        {

        }
    }

}
