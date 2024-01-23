tableextension 50009 "Item Extension" extends Item
{
    fields
    {
        field(50000; "Brand Name"; Text[50])
        {
            Caption = 'Brand Name';
            DataClassification = ToBeClassified;
        }
        field(50001; "Manufacturer Code(UD)"; Code[20])
        {
            Caption = 'Manufacturer Code(UD)';
            DataClassification = ToBeClassified;
        }
    }
}
