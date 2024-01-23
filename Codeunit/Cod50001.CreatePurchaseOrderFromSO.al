codeunit 50001 "Create Purchase Order"
{
    TableNo = "Sales Line";
    Permissions = tabledata "Purchase Header" = rimd, tabledata "Purchase Line" = rimd;

    var
        PurchaseHeaderRec: Record "Purchase Header";
        PurchaseLineRec: Record "Purchase Line";
        SalesHeaderRec: Record "Sales Header";
        SalesLineRec: Record "Sales Line";
        LineNo: Integer;
        LineNo1: Integer;
        PurchPayableSetupRec: Record "Purchases & Payables Setup";
        NoSeriesMgmt: codeunit NoSeriesManagement;
        NextNo: Code[20];
        TempSalesLineRec: Record "Sales Line" temporary;
        VendorNo: Code[20];
        PreviousVendorNo: Code[20];
        Crypt: Codeunit "Cryptography Management";

    trigger OnRun()
    begin

        SalesLineRec.Reset();
        SalesLineRec.SetRange("Document Type", SalesLineRec."Document Type"::Order);
        SalesLineRec.SetCurrentKey("Vendor No.", "Document No.");
        if SalesLineRec.FindSet() then begin
            // Declare a variable to store the previous vendor number
            PreviousVendorNo := '';
            Rec.SetCurrentKey("Vendor No.");
            repeat
                if Rec."Vendor No." <> PreviousVendorNo then begin
                    ///////////Mapping////////////
                    PurchaseHeaderRec.Init();
                    PurchaseHeaderRec.Validate("Document Type", PurchaseHeaderRec."Document Type"::Order);

                    ////////////No series//////////////////
                    PurchPayableSetupRec.Get();
                    PurchPayableSetupRec.TestField("Order Nos.");
                    NextNo := NoSeriesMgmt.GetNextNo(PurchPayableSetupRec."Order Nos.", WorkDate(), true);

                    PurchaseHeaderRec.Validate("No.", NextNo);
                    if PurchaseHeaderRec.Insert(true) then;
                    PurchaseHeaderRec.Validate("Buy-from Vendor No.", Rec."Vendor No.");
                    PurchaseHeaderRec.Validate("Document Date", Today);
                    PurchaseHeaderRec.Validate("Location Code", Rec."Location Code");
                    ////CRN NO Mapping////////
                    SalesHeaderRec.Reset();
                    SalesHeaderRec.SetRange("No.", Rec."Document No.");
                    if SalesHeaderRec.FindFirst() then begin
                        PurchaseHeaderRec.Validate("CRN No.", SalesHeaderRec."CRN No.");
                        PurchaseHeaderRec.Validate("End User", SalesHeaderRec."End User");
                        PurchaseHeaderRec.Validate("End User Code", SalesHeaderRec."End User Code");
                    end;
                    if PurchaseHeaderRec.Modify(true) then;
                    LineNo := 1000;

                    PurchaseLineRec.Validate("Document Type", PurchaseLineRec."Document Type"::Order);
                    PurchaseLineRec.Validate("Document No.", PurchaseHeaderRec."No.");
                    PurchaseLineRec.Validate("Line No.", LineNo);
                    if PurchaseLineRec.Insert(true) then;
                    PurchaseLineRec.Validate(Type, PurchaseLineRec.Type::Item);
                    PurchaseLineRec.Validate("No.", Rec."No.");
                    PurchaseLineRec.Validate(Quantity, Rec.Quantity);
                    PurchaseLineRec.Validate("Direct Unit Cost", Rec."Vendor Unit Price");
                    PurchaseLineRec.Validate("Location Code", Rec."Location Code");
                    PurchaseLineRec.Modify(true);
                    LineNo += 10000;

                    PreviousVendorNo := Rec."Vendor No.";
                end else begin

                    PurchaseLineRec.SetRange("Document Type", PurchaseLineRec."Document Type"::Order);
                    PurchaseLineRec.SetRange("Document No.", PurchaseHeaderRec."No.");
                    if PurchaseLineRec.FindFirst() then begin
                        PurchaseLineRec.Reset();
                        PurchaseLineRec.SetRange("Document Type", PurchaseLineRec."Document Type"::Order);
                        PurchaseLineRec.SetRange("Document No.", PurchaseHeaderRec."No.");
                        if PurchaseLineRec.FindLast() then begin
                            LineNo1 := PurchaseLineRec."Line No." + 10000;
                        end;

                        PurchaseLineRec.Init();
                        PurchaseLineRec.Validate("Line No.", LineNo1);
                        if PurchaseLineRec.Insert(true) then begin
                            PurchaseLineRec.Validate(Type, PurchaseLineRec.Type::Item);
                            PurchaseLineRec.Validate("No.", Rec."No.");
                            PurchaseLineRec.Validate(Quantity, Rec.Quantity);
                            PurchaseLineRec.Validate("Direct Unit Cost", Rec."Vendor Unit Price");
                            PurchaseLineRec.Validate("Location Code", Rec."Location Code");
                            PurchaseLineRec.Modify(true);
                            LineNo += 10000;
                        end;
                    end;
                end;
            until Rec.Next() = 0;
            Message('Purchase Order is Created');
        end;
    end;
}
