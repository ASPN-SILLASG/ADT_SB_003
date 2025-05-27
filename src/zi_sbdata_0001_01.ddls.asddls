@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '[SB] 저장위치레벨 물류'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_SBDATA_0001_01 with parameters
    p_year  : gjahr,
    p_month : poper
  as select distinct from I_MaterialDocumentItem_2 as _Mmdoci
    join                  I_Product                as _Mara   on _Mmdoci.Material = _Mara.Product
    join                  I_ProductPlantBasic      as _Marc   on  _Mmdoci.Material = _Marc.Product
                                                              and _Mmdoci.Plant    = _Marc.Plant
    join                  I_ProductValuationBasic  as _Mbew   on  _Mmdoci.Material               = _Mbew.Product
                                                              and _Mmdoci.Plant                  = _Mbew.ValuationArea
                                                              and _Mmdoci.InventoryValuationType = _Mbew.ValuationType
    left outer join       I_JournalEntryItem       as _Fidoc  on  _Mmdoci.MaterialDocumentItem = right(
      _Fidoc.ReferenceDocumentItem, 4
    )
                                                              and _Mmdoci.MaterialDocument     = _Fidoc.ReferenceDocument
                                                              and _Mmdoci.MaterialDocumentYear = right(
      _Fidoc.ReferenceDocumentContext, 4
    )
                                                              and _Fidoc.Ledger                = '0L'
    left outer join       I_MaterialDocumentItem_2 as _Umdoci on  _Umdoci.OriginalMaterialDocumentItem =  _Mmdoci.MaterialDocumentItem
                                                              and _Umdoci.MaterialDocumentItem         <> _Mmdoci.MaterialDocumentItem
                                                              and _Umdoci.MaterialDocument             =  _Mmdoci.MaterialDocument
                                                              and _Umdoci.MaterialDocumentYear         =  _Mmdoci.MaterialDocumentYear
                                                              and _Umdoci.DebitCreditCode              <> _Mmdoci.DebitCreditCode
  association [0..1] to ZI_SBDATA_0008            as _Mbew1 on  _Umdoci.Material                       = _Mbew1.Matnr
                                                           and _Umdoci.Plant                          = _Mbew1.Bwkey
                                                           and _Umdoci.InventoryValuationType         = _Mbew1.Bwtar
                                                           and _Umdoci.SpecialStockIdfgSalesOrder     = _Mbew1.Spso
                                                           and _Umdoci.SpecialStockIdfgSalesOrderItem = _Mbew1.Spsoi
                                                           and _Umdoci.SpecialStockIdfgSalesOrder     = _Mbew1.Spwbs
  association [0..1] to I_GoodsMovementTypeT     as _Bwt   on  _Bwt.GoodsMovementType = _Mmdoci.GoodsMovementType
                                                           and _Bwt.Language          = '3'
  association [0..1] to I_BusinessPartner        as _Lif   on  $projection.LIFNR = _Lif.BusinessPartner
  association [0..1] to I_BusinessPartner        as _Kur   on  $projection.KUNNR = _Kur.BusinessPartner
  association [1..1] to I_ProductText            as _Mat   on  $projection.MATNR = _Mat.Product
                                                           and _Mat.Language     = '3'
  association [1..1] to I_ProductText            as _Umt   on  $projection.UMMAT = _Umt.Product
                                                           and _Umt.Language     = '3'
  association [1..1] to I_GLAccountText          as _Glt   on  $projection.MGKONT = _Glt.GLAccount
                                                           and _Glt.Language      = '3'
  association [0..1] to I_SalesOrder             as _Soh   on  $projection.KDAUF = _Soh.SalesOrder
  association [0..1] to I_SalesOrderItem         as _Soi   on  $projection.KDAUF = _Soi.SalesOrder
                                                           and $projection.KDPOS = _Soi.SalesOrderItem
  association [0..1] to I_DeliveryDocumentItem   as _Doi   on  $projection.VBELN_IM = _Doi.DeliveryDocument
                                                           and $projection.VBELP_IM = _Doi.DeliveryDocumentItem
  association [0..1] to I_DeliveryDocument       as _Do    on  $projection.VBELN_IM = _Do.DeliveryDocument
  association [0..1] to I_PurchaseOrderAPI01     as _Poh   on  $projection.EBELN = _Poh.PurchaseOrder
  association [0..1] to I_PurchaseOrderItemAPI01 as _Poi   on  $projection.EBELN = _Poi.PurchaseOrder
                                                           and $projection.EBELP = _Poi.PurchaseOrderItem
  association [0..1] to I_MfgOrderForExtraction  as _Moh   on  $projection.AUFNR = _Moh.ManufacturingOrder
                                                           and $projection.AUFPS = _Moh.ManufacturingOrderItem



{
  key    _Mmdoci.MaterialDocument                                                 as MBLNR,
  key    _Mmdoci.MaterialDocumentYear                                             as MJAHR,
  key    _Mmdoci.MaterialDocumentItem                                             as ZEILE,

         _Mmdoci.CompanyCode                                                      as Bukrs,

         _Mmdoci.CompanyCodeCurrency                                              as RHCUR,
         _Mmdoci.CostCenter                                                       as RCNTR,
         _Mmdoci.ProfitCenter                                                     as PRCTR,
         _Mmdoci.BusinessArea                                                     as RBUSA,
         _Mmdoci.DebitCreditCode                                                  as DRCRK,
         _Mmdoci.FiscalYearPeriod                                                 as SPMON,
         _Mmdoci.PostingDate                                                      as BUDAT,
         _Mmdoci.PurchaseOrder                                                    as EBELN,
         _Mmdoci.PurchaseOrderItem                                                as EBELP,
         _Mmdoci.SalesOrder                                                       as KDAUF,
         _Mmdoci.SalesOrderItem                                                   as KDPOS,
         _Mmdoci.Material                                                         as MATNR,
         _Mat.ProductName                                                         as MATNRT,
         _Mmdoci.Plant                                                            as WERKS,
         _Mmdoci.Supplier                                                         as LIFNR,
         _Lif.BusinessPartnerName                                                 as LIFNRT,
         _Mmdoci.Customer                                                         as KUNNR,
         _Kur.BusinessPartnerName                                                 as KUNNRT,
         _Mbew.ProdCostEstNumber                                                  as KALNR,
         _Mmdoci.InventoryValuationType                                           as BWTAR,
         _Mbew.ValuationArea                                                      as BWKEY,
         _Mmdoci.WBSElementInternalID                                             as PS_PSP_PNR,
         _Mmdoci.ProjectNetwork                                                   as NPLNR,
         _Mmdoci.InventorySpecialStockType                                        as SOBKZ,
         _Mara.BaseUnit                                                           as MEINS,
         cast( _Mmdoci.QuantityInBaseUnit as abap.dec(20,3) )                     as MENGE,
         _Mmdoci.EntryUnit                                                        as ERFME,
         cast( _Mmdoci.QuantityInEntryUnit as abap.dec(20,2) )                    as ERFMG,

         _Mmdoci.OriginalMaterialDocumentItem                                     as ORLINE,
         _Mmdoci.ReversedMaterialDocumentYear                                     as SJAHR,
         _Mmdoci.ReversedMaterialDocument                                         as SMBLN,
         _Mmdoci.ReversedMaterialDocumentItem                                     as SMBLP,
         _Mmdoci.OrderID                                                          as AUFNR,
         _Mmdoci.OrderItem                                                        as AUFPS,
         _Mmdoci._MaterialDocumentHeader.ReferenceDocument                        as XBLNR,
         _Mmdoci.DeliveryDocument                                                 as VBELN_IM,
         _Mmdoci.DeliveryDocumentItem                                             as VBELP_IM,
         _Doi.ReferenceSDDocument                                                 as KDAUF_IM,
         _Doi.ReferenceSDDocumentItem                                             as KDPOS_IM,
         _Mmdoci.GoodsMovementType                                                as BWART,
         _Bwt.GoodsMovementTypeName                                               as BWARTT,
         _Mmdoci.IsAutomaticallyCreated                                           as XAUTO,
         _Mmdoci.StorageLocation                                                  as LGORT,
         _Mmdoci.Batch                                                            as CHARG,
         _Mmdoci.DebitCreditCode                                                  as SHKZG,
         _Mmdoci.MaterialDocumentItemText                                         as MMSGTXT,
         _Mmdoci.GoodsRecipientName                                               as WEMPF,
         _Mmdoci.UnloadingPointName                                               as ABLAD,
         _Mmdoci.GoodsMovementRefDocType                                          as KZBEW,
         _Mmdoci.ConsumptionPosting                                               as KZVBR,
         _Mmdoci.SpecialStockIdfgSalesOrder                                       as SPSO,
         _Mmdoci.SpecialStockIdfgSalesOrderItem                                   as SPSOI,
         _Mmdoci.SpecialStockIdfgWBSElement                                       as SPWBS,
         _Mmdoci.GLAccount                                                        as MGKONT,
         _Glt.GLAccountName                                                       as MGKONTT,
         _Umdoci.Material                                                         as UMMAT,
         _Umt.ProductName                                                         as UMMATT,
         _Mmdoci.IssgOrRcvgBatch                                                  as UMCHA,
         _Umdoci.Plant                                                            as UMWRK,
         _Mmdoci.IssuingOrReceivingStorageLoc                                     as UMLGO,
         _Umdoci.SpecialStockIdfgSalesOrder                                       as UMSO,
         _Umdoci.SpecialStockIdfgSalesOrderItem                                   as UMSOI,
         _Umdoci.SpecialStockIdfgWBSElement                                       as UMWBS,
         _Umdoci.InventorySpecialStockType                                        as UMSOB,
         _Umdoci.InventoryValuationType                                           as UMBWT,
         _Mbew1( p_year: $parameters.p_year, p_month: $parameters.p_month ).Kalnr as UMKAL,

         _Mara.CreationDate                                                       as ERSDA,
         _Mara.CreatedByUser                                                      as ERNAM,
         _Mara.IsMarkedForDeletion                                                as LVORM_MARA,
         _Mara.ProductType                                                        as MTART,
         _Mara.IndustrySector                                                     as MBRSH,
         _Mara.ProductGroup                                                       as MATKL,
         _Mara.ProductOldID                                                       as BISMT,
         _Mara.ItemCategoryGroup                                                  as NORMT,
         _Mara.WarehouseStorageCondition                                          as RAUBE,
         _Mara.TransportationGroup                                                as TRAGR,
         _Mara.Division                                                           as SPART,
         _Mara.ExternalProductGroup                                               as EXTWG,

         _Marc.MaintenanceStatusName                                              as PSTAT,
         _Marc.IsMarkedForDeletion                                                as LVORM_MARC,
         _Marc.IsInternalBatchManaged                                             as XCHAR,
         _Marc.ABCIndicator                                                       as MAABC,
         _Marc.PurchasingGroup                                                    as EKGRP,
         _Marc.MRPType                                                            as DISMM,
         _Marc.MRPResponsible                                                     as DISPO,
         _Marc.ProcurementType                                                    as BESKZ,
         _Marc.SpecialProcurementType                                             as SOBSL,
         _Marc.ProductLogisticsHandlingGroup                                      as LADGR,
         _Marc.IsBatchManagementRequired                                          as XCHPF,
         _Marc.AvailabilityCheckType                                              as MTVFP,
         _Marc.SerialNumberProfile                                                as SERNP,

         _Mbew.IsMarkedForDeletion                                                as LVORM_MBEW,
         _Mbew.InventoryValuationProcedure                                        as VPRSV,
         _Mbew.PriceDeterminationControl                                          as VERPR,
         _Mbew.ValuationClass                                                     as BKLAS,
         _Mbew.Currency                                                           as WAERS,
         @Semantics.amount.currencyCode: 'WAERS'
         _Mbew.StandardPrice                                                      as STPRS,
         _Mbew.ValuationCategory                                                  as BWTTY,

         _Soh.SalesOrderType                                                      as STYPE,
         _Soh.SalesOrderProcessingType                                            as VBKLT,
         _Soh.CreatedByUser                                                       as SERNAM,
         _Soh.LastChangedByUser                                                   as SLRNAM,
         _Soh.CreationDate                                                        as SERDAT,
         _Soh.LastChangeDate                                                      as SAEDAT,
         _Soh.SenderBusinessSystemName                                            as SESYSID,
         _Soh.ExternalDocumentID                                                  as SEDOCID,
         _Soh.SalesGroup                                                          as VKGRP,
         _Soh.SalesOffice                                                         as VKBUR,
         _Soh.SoldToParty                                                         as KUNAG,
         _Soh.CustomerGroup                                                       as KDGRP,
         _Soh.AdditionalCustomerGroup1                                            as KVGR1,
         _Soh.AdditionalCustomerGroup2                                            as KVGR2,
         _Soh.AdditionalCustomerGroup3                                            as KVGR3,
         _Soh.AdditionalCustomerGroup4                                            as KVGR4,
         _Soh.AdditionalCustomerGroup5                                            as KVGR5,
         _Soh.CreditControlArea                                                   as KKBER,
         _Soh.SalesOrderDate                                                      as SAUDAT,
         _Soh.SDDocumentReason                                                    as SAUGRU,
         _Soh.PurchaseOrderByCustomer                                             as BSTKD,
         _Soh.PurchaseOrderByShipToParty                                          as BSTKD_E,
         _Soh.SDDocumentCollectiveNumber                                          as SUBMI_SD,
         _Soh.CustomerPurchaseOrderType                                           as BSARK,
         _Soh.SalesDistrict                                                       as BZIRK,
         _Soh.ProductCatalog                                                      as WMINR,
         _Soh.BillingPlan                                                         as FPLNR,
         _Soh.CustomerTaxClassification1                                          as STAXK1,
         _Soh.CustomerTaxClassification2                                          as STAXK2,
         _Soh.CustomerTaxClassification3                                          as STAXK3,
         _Soh.CustomerTaxClassification4                                          as STAXK4,
         _Soh.CustomerTaxClassification5                                          as STAXK5,
         _Soh.CustomerTaxClassification6                                          as STAXK6,
         _Soh.CustomerTaxClassification7                                          as STAXK7,
         _Soh.CustomerTaxClassification8                                          as STAXK8,
         _Soh.CustomerTaxClassification9                                          as STAXK9,
         _Soh.RequestedDeliveryDate                                               as SDELDT,
         _Soh.ShippingType                                                        as VSARTTR,
         _Soh.ShippingCondition                                                   as VSBED,
         _Soh.ReceivingPoint                                                      as EMPST,
         _Soh.IncotermsClassification                                             as SINCO1,
         _Soh.IncotermsTransferLocation                                           as SINCO2,
         _Soh.IncotermsLocation1                                                  as SINCO2_L,
         _Soh.IncotermsLocation2                                                  as SINCO3_L,
         _Soh.IncotermsVersion                                                    as SINCOV,
         _Soh.CustomerPaymentTerms                                                as SZTERM,
         _Soh.PaymentMethod                                                       as SSCHZW,
         _Soh.AssignmentReference                                                 as ORDNR_V,
         _Soh.ReferenceSDDocument                                                 as SVGBEL,
         _Soh.ReferenceSDDocumentCategory                                         as SVBTYPL,

         _Soi.SalesOrderItemCategory                                              as PSTYV,
         _Soi.SalesOrderItemType                                                  as POSAR,
         _Soi.IsReturnsItem                                                       as SHKZG_VA,
         _Soi.MaterialByCustomer                                                  as MATNR_KU,
         _Soi.MaterialSubstitutionReason                                          as SYGRD,
         _Soi.DeliveryGroup                                                       as GRKOR,
         _Soi.ProductConfiguration                                                as CUOBJ_VA,
         _Soi.SalesOrderItemText                                                  as ARKTX,
         _Soi.UnderlyingPurchaseOrderItem                                         as POSEX,
         _Soi.ExternalItemID                                                      as SERIID,

         _Do.SDDocumentCategory                                                   as DCAT,
         _Do.DeliveryDocumentType                                                 as DTYPE,

         _Poh.PurchaseOrderType                                                   as ESART,
         _Poh.CreatedByUser                                                       as PERNAM,
         _Poh.CreationDate                                                        as PERDAT,
         _Poh.PurchaseOrderDate                                                   as BEDAT,
         _Poh.PurchasingOrganization                                              as PEKORG,
         _Poh.PurchasingGroup                                                     as PEKGRP,
         _Poh.SupplierRespSalesPersonName                                         as PEVERK,
         _Poh.SupplyingSupplier                                                   as LLIEF,
         _Poh.SupplyingPlant                                                      as RESWK,
         _Poh.InvoicingParty                                                      as LIFRE,
         _Poh.Customer                                                            as PKUNNR,
         _Poh.PaymentTerms                                                        as PZTERM,
         _Poh.IncotermsClassification                                             as PINCO1,
         _Poh.IncotermsTransferLocation                                           as PINCO2,
         _Poh.IncotermsVersion                                                    as PINOCV,
         _Poh.IncotermsLocation1                                                  as PINCO2_L,
         _Poh.IncotermsLocation2                                                  as PINCO3_L,

         _Poi.PurchaseOrderCategory                                               as BSTYP,
         _Poi.DocumentCurrency                                                    as PWAERS,
         _Poi.PurchasingDocumentItemOrigin                                        as ASTAT,
         _Poi.SupplierMaterialNumber                                              as IDNLF,
         _Poi.SupplierSubrange                                                    as LTSNR,
         _Poi.ManufacturerPartNmbr                                                as MFRPN,
         _Poi.Manufacturer                                                        as MFRNR,
         _Poi.Subcontractor                                                       as EMLIF,
         _Poi.SupplierIsSubcontractor                                             as LBLKZ,
         _Poi.GoodsReceiptIsExpected                                              as WEPOS,
         _Poi.InvoiceIsExpected                                                   as REPOS,
         _Poi.InvoiceIsGoodsReceiptBased                                          as WEBRE,
         _Poi.PurchaseContractItem                                                as KTPNR,
         _Poi.PurchaseContract                                                    as KONNR,
         _Poi.PurchaseRequisition                                                 as BANFN,
         _Poi.RequirementTracking                                                 as BEDNR,
         _Poi.PurchaseRequisitionItem                                             as BNFPO,
         _Poi.EvaldRcptSettlmtIsAllowed                                           as XERSY,
         _Poi.RequisitionerName                                                   as AFNAM,
         _Poi.PurchaseOrderItemCategory                                           as PSTYP,
         _Poi.IsReturnsItem                                                       as RETPO,
         _Poi.PurchasingOrderReason                                               as BSGRU,
         _Poi.CommodityCode                                                       as PCOMCO,
         _Poi.AccountAssignmentCategory                                           as KNTTP,
         _Poi.GoodsReceiptIsNonValuated                                           as WEUNB,
         _Poi.TaxCode                                                             as PMWSKZ,
         _Poi.TaxJurisdiction                                                     as TXJCD,
         _Poi.ShippingInstruction                                                 as PEVERS,
         _Poi.ShippingType                                                        as PVERSART,
         _Poi.StockType                                                           as PINSMK,
         _Poi.DeliveryDocumentType                                                as LFRET,
         _Poi.IssuingStorageLocation                                              as RESLO,

         _Moh.ManufacturingOrderCategory                                          as AUTYP,
         _Moh.ManufacturingOrderType                                              as AUFART,
         _Moh.ManufacturingOrderText                                              as MATEXT,
         _Moh.ManufacturingOrderHasLongText                                       as AUFTEXT,
         _Moh.ManufacturingOrderImportance                                        as MORIMP,
         _Moh.MfgOrderIsPartOfCollvOrder                                          as CO_PRODNET,
         _Moh.MfgOrderHierarchyLevelValue                                         as HISTU,
         _Moh.MfgOrderHierarchyPathValue                                          as WEGXX,
         _Moh.CreationDate                                                        as MERDAT,
         _Moh.CreatedByUser                                                       as MERNAM,
         _Moh.LastChangeDate                                                      as MAEDAT,
         _Moh.LastChangedByUser                                                   as MAENAM,
         _Moh.Material                                                            as MMATNR,
         _Moh.StorageLocation                                                     as MLGORT,

         _Moh.GoodsRecipientName                                                  as MWEMPF,
         _Moh.UnloadingPointName                                                  as MABLAD,
         _Moh.MfgOrderInternalID                                                  as MAUFPL,
         _Moh.ReferenceOrder                                                      as FIS_AUFREFNR,
         _Moh.LeadingOrder                                                        as LAUFNR,
         _Moh.SuperiorOrder                                                       as MFEVOR,
         _Moh.ProductionVersion                                                   as VERID,
         _Moh.SalesOrder                                                          as MKDAUF,
         _Moh.SalesOrderItem                                                      as MKDPOS,
         _Moh.Reservation                                                         as MRSNUM,
         _Moh.PlannedOrder                                                        as MPLNUM,
         _Moh.ObjectInternalID                                                    as MOBJNR,
         _Moh.ProductConfiguration                                                as MPRCON,
         _Moh.BillOfOperationsMaterial                                            as BOOMAT,
         _Moh.BillOfOperationsType                                                as BOOTYP,
         _Moh.BillOfOperationsGroup                                               as BOOGRP,
         _Moh.BillOfOperationsUsage                                               as BOOUSG,
         _Moh.BillOfMaterialCategory                                              as MSTLTY,
         _Moh.BillOfMaterial                                                      as MSTNUM,
         _Moh.BillOfMaterialVariant                                               as MSTALT,
         _Moh.BillOfMaterialVariantUsage                                          as MSTLAN,
         _Moh.ProfitCenter                                                        as MPRCTR,
         _Moh.CostCenter                                                          as MKOSTL,
         _Moh.CostElement                                                         as MKSTAR,
         _Moh.GLAccount                                                           as MSAKNR,
         _Moh.ProductCostCollector                                                as MPKOSA
}
where
      _Fidoc.AccountingDocument is null
  and _Mmdoci.FiscalYearPeriod  = concat( $parameters.p_year, $parameters.p_month)
