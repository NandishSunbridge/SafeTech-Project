tableextension 50201 "Sales Line Extension" extends "Sales Line"
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
        }
        field(50002; "Purchase Quotation No."; Code[20])
        {
            Caption = 'Purchase Quotation No.';
            DataClassification = ToBeClassified;
        }
        field(50003; "Proposed Rate"; Decimal)
        {
            Caption = 'Proposed Rate';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(VendorNo; "Vendor No.")
        {

        }
    }

}
