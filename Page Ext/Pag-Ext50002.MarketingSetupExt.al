pageextension 50002 MarketingSetupExt extends "Marketing Setup"
{
    layout
    {
        addafter("Opportunity Nos.")
        {
            field("CRN Number No. Series"; Rec."CRN Number No. Series")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the CRN Number No. Series field.';
            }
        }
    }
}
