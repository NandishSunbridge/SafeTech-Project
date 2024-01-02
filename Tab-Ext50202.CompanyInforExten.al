tableextension 50202 "Company Infor Exten" extends "Company Information"
{
    fields
    {
        field(50000; "Picture 1"; Blob)
        {
            Caption = 'Picture 1';
            DataClassification = ToBeClassified;
            Subtype = Bitmap;
        }
        field(50001; "Arabic Name"; Text[50])
        {
            Caption = 'Arabic Name';
            DataClassification = ToBeClassified;
        }
    }
}
