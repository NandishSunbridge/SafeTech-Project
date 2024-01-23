pageextension 50016 PurchaseQuotesListExt extends "Purchase Quotes"
{
    layout
    {
        addafter("Buy-from Vendor Name")
        {
            field("CRN No."; Rec."CRN No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the CRN No. field.';
                Editable = false;
            }
            field("End User"; Rec."End User")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the End User field.';
            }
            field("End User Code"; Rec."End User Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the End User Code field.';
            }
            field("Opportunity No."; Rec."Opportunity No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Opportunity No. field.';
            }
        }
    }
    actions
    {
        addafter(MakeOrder)
        {
            action("Update Sales Quote Line")
            {
                ApplicationArea = all;
                Caption = 'Update Sales Quote Line';
                Image = Allocate;
                ToolTip = 'Create a saels quote line with the opportunity inserted as the vendor.';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var

                    Ok: Boolean;
                    MangeCRNCU: Codeunit "MangeCRN.";


                begin
                    Ok := false;
                    Ok := Confirm('Are you sure want to create sales quote line', true, false);
                    if not Ok then begin
                        exit;
                    end;
                    MangeCRNCU.SalesQuoteLineCreate(Rec);
                end;
            }
            action("Show Sales Quote")
            {
                ApplicationArea = RelationshipMgmt;
                Caption = 'Show Sales Quote';
                Image = Quote;
                ToolTip = 'Show the assigned sales quote.';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    SalesHeaderRec: Record "Sales Header";
                    OpportunityRec: Record Opportunity;
                begin

                    Rec.TestField("Opportunity No.");
                    Rec.TestField("CRN No.");
                    OpportunityRec.Reset();
                    if not OpportunityRec.Get(Rec."Opportunity No.") then begin
                        Error('Opportunity No. %1 not found', Rec."Opportunity No.");
                    end;
                    OpportunityRec.TestField("Sales Document No.");

                    SalesHeaderRec.Reset();
                    SalesHeaderRec.SetRange("Document Type", SalesHeaderRec."Document Type"::Quote);
                    SalesHeaderRec.SetRange("No.", OpportunityRec."Sales Document No.");
                    if not SalesHeaderRec.FindFirst() then begin
                        Error('Sales Quote No. %1 not found for Opportunity No. %2', OpportunityRec."Sales Document No.", Rec."Opportunity No.");
                    end else begin
                        PAGE.Run(PAGE::"Sales Quote", SalesHeaderRec)
                    end;
                end;
            }
        }
    }
}
