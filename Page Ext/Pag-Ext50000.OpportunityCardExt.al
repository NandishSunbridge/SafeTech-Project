pageextension 50000 OpportunityCardExt extends "Opportunity Card"
{
    layout
    {
        addafter("No.")
        {
            field("Lead Type"; Rec."Lead Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Lead Type field.';
            }
        }
        addafter("Contact Name")
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
        addafter("Contact No.")
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
                    SalesHDRec."Lead Type" := Rec."Lead Type";
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
                var
                    SalesHeaderRec: Record "Sales Header";
                    SalesLineRec: Record "Sales Line";
                    PurchaseHeaderRec: Record "Purchase Header";
                    PurchaseLineRec: Record "Purchase Line";
                    Ok: Boolean;
                    PurchaseQuoteNo: Code[20];
                    LineCount: Integer;

                begin
                    Ok := false;
                    Ok := Confirm('Are you sure want to create purchase quote', true, false);
                    if not Ok then begin
                        exit;
                    end;
                    Rec.TestField("Vendor No.");
                    SalesHeaderRec.Reset();
                    SalesHeaderRec.SetRange("Document Type", SalesHeaderRec."Document Type"::Quote);
                    SalesHeaderRec.SetRange("No.", Rec."Sales Document No.");
                    if not SalesHeaderRec.FindFirst() then begin
                        Error('Before Creating Purchase quote Sales Quote must be created for the Opportunity No. %1', Rec."No.");
                    end else begin
                        //// Checking Slaes Quote Line Start ////////////////////////////////
                        SalesLineRec.Reset();
                        SalesLineRec.SetRange("Document Type", SalesLineRec."Document Type"::Quote);
                        SalesLineRec.SetRange("Document No.", SalesHeaderRec."No.");
                        //SalesLineRec.SetRange(Type, SalesLineRec.Type::Item);
                        SalesLineRec.SetFilter(Type, '%1|%2', SalesLineRec.Type::Item, SalesLineRec.Type::"G/L Account");
                        SalesLineRec.SetFilter("No.", '<>%1', '');
                        SalesLineRec.SetFilter(Quantity, '<>%1', 0);
                        LineCount := 0;
                        if SalesLineRec.FindFirst() then begin
                            repeat
                                LineCount += 1;
                            until SalesLineRec.Next = 0;
                        end;

                        //// Checking Slaes Quote Line End ////////////////////////////////
                        if LineCount <= 0 then begin
                            Error('There is no Sales Quote Line exits for Quote No. %1\' + SalesLineRec.GetFilters, SalesHeaderRec."No.");
                        end;
                        PurchaseHeaderRec.Init();
                        PurchaseHeaderRec."Document Type" := PurchaseHeaderRec."Document Type"::Quote;
                        PurchaseHeaderRec."No." := '';
                        If PurchaseHeaderRec.Insert(true) then begin
                            PurchaseQuoteNo := PurchaseHeaderRec."No.";
                            PurchaseHeaderRec.Validate("Buy-from Vendor No.", Rec."Vendor No.");
                            PurchaseHeaderRec.Validate("Order Date", SalesHeaderRec."Order Date");
                            PurchaseHeaderRec.Validate("Document Date", SalesHeaderRec."Document Date");
                            if SalesHeaderRec."Posting Date" = 0D then begin
                                PurchaseHeaderRec.Validate("Posting Date", Today);
                            end else begin
                                PurchaseHeaderRec.Validate("Posting Date", SalesHeaderRec."Posting Date");
                            end;
                            PurchaseHeaderRec."Opportunity No." := Rec."No.";
                            PurchaseHeaderRec."CRN No." := Rec."CRN No.";
                            PurchaseHeaderRec.Modify(true);
                            //Message('Po no. is %1 = %2', PurchaseHeaderRec."No.", PurchaseQuoteNo);
                            SalesLineRec.Reset();
                            SalesLineRec.SetRange("Document Type", SalesLineRec."Document Type"::Quote);
                            SalesLineRec.SetRange("Document No.", SalesHeaderRec."No.");
                            if SalesLineRec.FindFirst() then begin
                                repeat
                                    PurchaseLineRec.Init();
                                    PurchaseLineRec.Validate("Document Type", PurchaseLineRec."Document Type"::Quote);
                                    PurchaseLineRec.Validate("Document No.", PurchaseHeaderRec."No.");
                                    PurchaseLineRec.Validate("Line No.", SalesLineRec."Line No.");
                                    if PurchaseLineRec.Insert(true) then begin
                                        PurchaseLineRec.Validate(Type, PurchaseLineRec.Type::Item);
                                        PurchaseLineRec.Validate("No.", SalesLineRec."No.");
                                        PurchaseLineRec.Validate(Quantity, SalesLineRec.Quantity);
                                        PurchaseLineRec.Validate("Direct Unit Cost", SalesLineRec."Unit Cost");
                                        PurchaseLineRec.Modify(true);
                                    end;
                                until SalesLineRec.Next = 0;

                            end;
                        end;
                        Message('Purchase quote has been created Successfully. Purchase quote No. is %1', PurchaseHeaderRec."No.");
                        Commit();
                        PAGE.RunModal(PAGE::"Purchase Quote", PurchaseHeaderRec);
                    end;
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
