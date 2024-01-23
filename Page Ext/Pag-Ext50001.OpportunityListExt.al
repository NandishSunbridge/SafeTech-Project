pageextension 50001 OpportunityListExt extends "Opportunity List"
{
    layout
    {
        addafter("No.")
        {
            field("CRN No."; Rec."CRN No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the CRN No. field.';
            }
        }
        addafter(Description)
        {
            field("Vendor No."; Rec."Vendor No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vendor No. field.';
                Visible = false;
            }
            field("Vendor Name"; Rec."Vendor Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vendor No. field.';
                Visible = false;
            }
        }
        addafter("Vendor Name")
        {
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
        }
    }
    actions
    {

        modify(CreateSalesQuote)
        {
            trigger OnAfterAction()
            var
                SalesHDRec: Record "Sales Header";
            begin
                SalesHDRec.Reset();
                SalesHDRec.SetRange("Document Type", SalesHDRec."Document Type"::Quote);
                SalesHDRec.SetRange("No.", Rec."Sales Document No.");
                if SalesHDRec.FindFirst() then begin
                    SalesHDRec."CRN No." := Rec."CRN No.";
                    SalesHDRec."End User" := Rec."End User";
                    SalesHDRec."End User Code" := Rec."End User Code";
                    SalesHDRec.Modify(true);
                end;
                //Message('Test-', Rec."CRN No.");
            end;
        }
        addafter(CreateSalesQuote)
        {
            action("Create Purchase Quote")
            {
                ApplicationArea = all;
                Caption = 'Create Purchase Quote';
                Image = Allocate;
                ToolTip = 'Create a new purchase quote with the opportunity inserted as the vendor.';
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin

                end;
            }
        }
        addafter("Create Purchase Quote")
        {
            action("Item Comparison Report")
            {
                ApplicationArea = all;
                Caption = 'Item Comparison Report';
                Image = CompareCost;
                Promoted = true;
                PromotedCategory = "Report";
                ToolTip = 'Executes the  item comparison report action.';
                trigger OnAction()
                begin
                    Report.RunModal(Report::"Item Comparison Report");
                end;
            }
        }
    }
}
