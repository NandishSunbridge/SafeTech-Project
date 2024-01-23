codeunit 50000 "MangeCRN."
{

    procedure SalesQuoteLineCreate(Rec: Record "Purchase Header")
    var
        SalesHeaderRec: Record "Sales Header";
        SalesLineRec: Record "Sales Line";
        PurchaseHeaderRec: Record "Purchase Header";
        PurchaseLineRec: Record "Purchase Line";
        OpportunityRec: Record Opportunity;
        Ok: Boolean;
        PurchaseQuoteNo: Code[20];
        LineCount: Integer;
        Cnt: Integer;
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
        end;
        PurchaseLineRec.Reset();
        PurchaseLineRec.SetRange("Document Type", PurchaseLineRec."Document Type"::Quote);
        PurchaseLineRec.SetRange("Document No.", Rec."No.");
        Cnt := 0;

        if PurchaseLineRec.FindFirst() then begin
            repeat
                SalesLineRec.Reset();
                SalesLineRec.SetRange("Document Type", SalesLineRec."Document Type"::Quote);
                SalesLineRec.SetRange("Document No.", SalesHeaderRec."No.");
                SalesLineRec.SetRange(Type, PurchaseLineRec.Type);
                SalesLineRec.SetRange("No.", PurchaseLineRec."No.");
                If SalesLineRec.FindFirst() then begin
                    Error('Sales line already exits for Document No. %1 with blow filter\', SalesLineRec.GetFilters);
                end else begin
                    SalesLineRec.Init();
                    SalesLineRec.Validate("Document Type", SalesLineRec."Document Type"::Quote);
                    SalesLineRec.Validate("Document No.", SalesHeaderRec."No.");
                    SalesLineRec.Validate("Line No.", PurchaseLineRec."Line No.");
                    if SalesLineRec.Insert(true) then begin
                        SalesLineRec.Validate(Type, PurchaseLineRec.Type::Item);
                        SalesLineRec.Validate("No.", PurchaseLineRec."No.");
                        SalesLineRec.Validate(Quantity, PurchaseLineRec.Quantity);
                        SalesLineRec.Validate("Unit Price", PurchaseLineRec."Direct Unit Cost");
                        SalesLineRec.Modify(true);
                        Cnt += 1;
                    end;
                end;
            until PurchaseLineRec.Next = 0;
        end;
        /////////////////// Update Sales Quote Header- Vendor No.,Name, Purchase Quote No.//////////////////////////////////////
        SalesHeaderRec."Vendor No." := Rec."Buy-from Vendor No.";
        SalesHeaderRec."Vendor Name" := Rec."Buy-from Vendor Name";
        SalesHeaderRec."Purchase Quote No." := Rec."No.";
        SalesHeaderRec.Modify(true);

        Message('Sales quote line has been created Successfully. Sales quote No. is %1', SalesHeaderRec."No.");
        Commit();
        PAGE.RunModal(PAGE::"Sales Quote", SalesHeaderRec);
    end;


    //////////////// Master data Sync Start + ////////////////////////////////////////////
    [EventSubscriber(ObjectType::Table, Database::Item, 'OnAfterInsertEvent', '', true, true)]
    local procedure InsertItmeMaster(var Rec: Record Item; RunTrigger: Boolean)
    var
        CompaniesRec: Record Companies;
        ItemRec: Record Item;
        ItemUOM: Record "Item Unit of Measure";
    begin
        /*
        CompaniesRec.Reset();
        CompaniesRec.SetRange(Copied, true);
        CompaniesRec.SetRange(ActiveYesNo, true);
        // if not CompaniesRec.FindFirst() then begin
        //     Error('No setup found in Companies Master Sync table with blow filter\', CompaniesRec.GetFilters);
        // end;

        if CompaniesRec.FindFirst() then begin
            repeat
                //ItemRec.Reset();
                ItemRec.ChangeCompany(CompaniesRec."Comany Name");
                //ItemRec.Init();
                ItemRec.TransferFields(Rec);
                ItemRec.Insert();
                ItemUOM.Reset();
                ItemUOM.ChangeCompany(CompaniesRec."Comany Name");
                if not ItemUOM.Get(ItemRec."No.", ItemRec."Base Unit of Measure") then begin
                    ItemUOM.Init;
                    ItemUOM."Item No." := ItemRec."No.";
                    ItemUOM.Code := ItemRec."Base Unit of Measure";
                    ItemUOM."Qty. per Unit of Measure" := 1;
                    ItemUOM.Insert;
                end;
            until CompaniesRec.Next = 0;
            */
    end;
    ///////////------- Master Data Modify Start +/  ------------//////////////////////////
    [EventSubscriber(ObjectType::Page, Page::"Item Card", 'OnClosePageEvent', '', true, true)]

    local procedure ModifyItmeMaster(var Rec: Record Item)
    var
        CompaniesRec: Record Companies;
        ItemRec: Record Item;
        ItemUOM: Record "Item Unit of Measure";
    begin
        CompaniesRec.Reset();
        CompaniesRec.SetRange(Copied, true);
        CompaniesRec.SetRange(ActiveYesNo, true);
        // if not CompaniesRec.FindFirst() then begin
        //     Error('No setup found in Companies Master Sync table with blow filter\', CompaniesRec.GetFilters);
        // end;

        if CompaniesRec.FindFirst() then begin
            repeat
                ItemRec.Reset();
                ItemRec.ChangeCompany(CompaniesRec."Comany Name");
                if ItemRec.Get(Rec."No.") then begin
                    ItemRec.TransferFields(Rec);
                    ItemRec.Modify();
                    ItemUOM.ChangeCompany(CompaniesRec."Comany Name");
                    if not ItemUOM.Get(ItemRec."No.", ItemRec."Base Unit of Measure") then begin
                        ItemUOM.Init;
                        ItemUOM."Item No." := ItemRec."No.";
                        ItemUOM.Code := ItemRec."Base Unit of Measure";
                        ItemUOM."Qty. per Unit of Measure" := 1;
                        ItemUOM.Insert;
                    end;
                end else begin
                    ItemRec.TransferFields(Rec);
                    ItemRec.Insert();
                    ItemUOM.Reset();
                    ItemUOM.ChangeCompany(CompaniesRec."Comany Name");
                    if not ItemUOM.Get(ItemRec."No.", ItemRec."Base Unit of Measure") then begin
                        ItemUOM.Init;
                        ItemUOM."Item No." := ItemRec."No.";
                        ItemUOM.Code := ItemRec."Base Unit of Measure";
                        ItemUOM."Qty. per Unit of Measure" := 1;
                        ItemUOM.Insert;
                    end;
                end;
            until CompaniesRec.Next = 0;
        end;
    end;
    ///////////------- Master Data Modify End -/  ------------//////////////////////////
    //////////////// Master data Sync End - ////////////////////////////////////////////


}
