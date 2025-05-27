@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '[SB] 플랜트레벨 물류 데이터'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_SBDATA_0001  
  with parameters
        p_year  : gjahr,
        p_month : poper
  as select distinct from I_JournalEntryItem       as _Fidoc
    join                  I_Product                as _Mara   on _Fidoc.Product = _Mara.Product
    join                  I_ProductPlantBasic      as _Marc   on  _Fidoc.Product = _Marc.Product
                                                              and _Fidoc.Plant   = _Marc.Plant
    join                  I_ProductValuationBasic  as _Mbew   on  _Fidoc.Product                = _Mbew.Product
                                                              and _Fidoc.ValuationArea          = _Mbew.ValuationArea
                                                              and _Fidoc.InventoryValuationType = _Mbew.ValuationType
    left outer join       I_ProductSalesDelivery   as _Mvke   on  _Fidoc.Product             = _Mvke.Product
                                                              and _Fidoc.SalesOrganization   = _Mvke.ProductSalesOrg
                                                              and _Fidoc.DistributionChannel = _Mvke.ProductDistributionChnl
    left outer join       I_MaterialDocumentItem_2 as _Mmdoci on  _Mmdoci.MaterialDocumentItem = right(
      _Fidoc.ReferenceDocumentItem, 4
    )
                                                              and _Mmdoci.MaterialDocument     = _Fidoc.ReferenceDocument
                                                              and _Mmdoci.MaterialDocumentYear = right(
      _Fidoc.ReferenceDocumentContext, 4
    )
    left outer join       I_MaterialDocumentItem_2 as _Umdoci on  _Umdoci.OriginalMaterialDocumentItem =  _Mmdoci.OriginalMaterialDocumentItem
                                                              and _Umdoci.MaterialDocumentItem         <> _Mmdoci.MaterialDocumentItem
                                                              and _Umdoci.MaterialDocument             =  _Mmdoci.MaterialDocument
                                                              and _Umdoci.MaterialDocumentYear         =  _Mmdoci.MaterialDocumentYear
                                                              and _Umdoci.DebitCreditCode              <> _Mmdoci.DebitCreditCode
                                                              and (
                                                                 _Fidoc.MaterialLedgerProcessType      =  'VF'
                                                                 or _Fidoc.MaterialLedgerProcessType   =  'VL'
                                                                 or _Fidoc.MaterialLedgerProcessType   =  'VU'
                                                                 or _Fidoc.MaterialLedgerProcessType   =  'VUBM'
                                                                 or _Fidoc.MaterialLedgerProcessType   =  'BU'
                                                                 or _Fidoc.MaterialLedgerProcessType   =  'BUBM'
                                                                 or _Fidoc.MaterialLedgerProcessType   =  'BUBS'
                                                                 or _Fidoc.MaterialLedgerProcessType   =  'VUBS'
                                                               )
    left outer join       I_MfgOrderForExtraction  as _Moh    on _Mmdoci.OrderID = _Moh.ManufacturingOrder
    left outer join       I_Batch                  as _Bt     on  _Bt.Material = _Moh.Product
                                                              and _Bt.Plant    = _Moh.ProductionPlant
                                                              and _Bt.Batch    = _Moh.Batch
  //  association [0..*] to YI_SBDATA_008            as _Mbew1 on  _Umdoci.Material                       = _Mbew1.Matnr
  //                                                           and _Umdoci.Plant                          = _Mbew1.Bwkey
  //                                                           and _Umdoci.InventoryValuationType         = _Mbew1.Bwtar
  //                                                           and _Umdoci.SpecialStockIdfgSalesOrder     = _Mbew1.Spso
  //                                                           and _Umdoci.SpecialStockIdfgSalesOrderItem = _Mbew1.Spsoi
  //                                                           and _Umdoci.SpecialStockIdfgWBSElement     = _Mbew1.Spwbs
    left outer join       I_JournalEntryItem       as _Mbew1  on  _Umdoci.MaterialDocumentItem        = right(
      _Mbew1.ReferenceDocumentItem, 4
    )
                                                              and _Umdoci.MaterialDocument            = _Mbew1.ReferenceDocument
                                                              and _Umdoci.MaterialDocumentYear        = right(
      _Mbew1.ReferenceDocumentContext, 4
    )
                                                              and _Mbew1.TransactionTypeDetermination = 'BSX'
  left outer join I_SupplierInvoiceAPI01 as _Ivh on _Fidoc.ReferenceDocumentType = 'RMRP'
                                                 and _Fidoc.ReferenceDocument = _Ivh.SupplierInvoice
                                                 and _Ivh.FiscalYear = right(
      _Fidoc.ReferenceDocumentContext, 4
    )
  left outer join I_DeliveryDocument       as _Do    on  _Mmdoci.DeliveryDocument = _Do.DeliveryDocument
  left outer join I_DeliveryDocumentItem   as _Doi   on  _Mmdoci.DeliveryDocument= _Doi.DeliveryDocument
                                                     and _Mmdoci.DeliveryDocumentItem = _Doi.DeliveryDocumentItem
  association [0..*] to ZI_SBDATA_0008            as _Mbew2 on  _Moh.Product              = _Mbew2.Matnr
                                                           and _Moh.ProductionPlant      = _Mbew2.Bwkey
  //                                                           and _Bt.InventoryValuationType = _Mbew2.Bwtar
                                                           and _Moh.SalesOrder           = _Mbew2.Spso
                                                           and _Moh.SalesOrderItem       = _Mbew2.Spsoi
                                                           and _Moh.WBSElementInternalID = _Mbew2.Spwbs
  association [0..*] to I_JournalEntryItem       as _ptyp  on  _Fidoc.SourceLedger             =  _ptyp.SourceLedger
                                                           and _Fidoc.CompanyCode              =  _ptyp.CompanyCode
                                                           and _Fidoc.FiscalYear               =  _ptyp.FiscalYear
                                                           and _Fidoc.AccountingDocument       =  _ptyp.AccountingDocument
                                                           and _Fidoc.Ledger                   =  _ptyp.Ledger
                                                           and _Fidoc.ReferenceDocument        =  _ptyp.ReferenceDocument
                                                           and _Fidoc.ReferenceDocumentItem    =  _ptyp.ReferenceDocumentItem
                                                           and _ptyp.MaterialLedgerProcessType <> ''

  association [0..1] to I_GoodsMovementTypeT     as _Bwt   on  _Bwt.GoodsMovementType = _Mmdoci.GoodsMovementType
                                                           and _Bwt.Language          = '3'
  association [0..1] to I_BusinessPartner        as _Lif   on  $projection.LIFNR = _Lif.BusinessPartner
  association [0..1] to I_BusinessPartner        as _Kur   on  $projection.KUNNR = _Kur.BusinessPartner
  association [1..1] to I_ProductText            as _Mat   on  $projection.MATNR = _Mat.Product
                                                           and _Mat.Language     = '3'
  association [1..1] to I_GLAccountText          as _Glt   on  $projection.MGKONT     = _Glt.GLAccount
                                                           and _Fidoc.ChartOfAccounts = _Glt.ChartOfAccounts
                                                           and _Glt.Language          = '3'
  association [0..1] to I_SalesDocument             as _Soh   on  _Doi.ReferenceSDDocument = _Soh.SalesDocument
  association [0..1] to I_SalesDocumentItem         as _Soi   on  _Doi.ReferenceSDDocument = _Soi.SalesDocument
                                                              and _Doi.ReferenceSDDocumentItem = _Soi.SalesDocumentItem
  association [0..1] to I_PurchaseOrderAPI01     as _Poh   on  _Fidoc.PurchasingDocument = _Poh.PurchaseOrder
  association [0..1] to I_PurchaseOrderItemAPI01 as _Poi   on  $projection.EBELN = _Poi.PurchaseOrder
                                                           and $projection.EBELP = _Poi.PurchaseOrderItem
  association [0..1] to I_MfgOrderWithStatus     as _Mohs  on  _Mmdoci.OrderID = _Mohs.ManufacturingOrder
//  association [0..1] to I_SupplierCompany        as _Lifa  on  _Lifa.Supplier    = _Fidoc.Supplier
//                                                           and _Lifa.CompanyCode = _Fidoc.CompanyCode
  association [0..1] to I_SupplierCompany        as _Lifa1  on  _Lifa1.Supplier    = _Ivh.InvoicingParty
                                                           and _Lifa1.CompanyCode = _Ivh.CompanyCode


{
  key _Fidoc.AccountingDocument                         as Belnr,
  key _Fidoc.LedgerGLLineItem                           as Docln,
  key _Fidoc.FiscalYear                                 as Gjahr,
  key _Fidoc.CompanyCode                                as Bukrs,
      _Fidoc.GLRecordType                               as RRCTY,
      _Fidoc.BusinessTransactionType                    as BTTYPE,
      _Fidoc.ReferenceDocumentType                      as AWTYP,
      _Fidoc.ReferenceDocumentContext                   as AWORG,
      _Fidoc.ReferenceDocument                          as AWREF,
      _Fidoc.ReferenceDocumentItem                      as AWITEM,
      _Fidoc.IsReversal                                 as XREVERSING,
      _Fidoc.IsReversed                                 as XREVERSED,
      _Fidoc.ReversalReferenceDocumentCntxt             as AWORG_REV,
      _Fidoc.ReversalReferenceDocument                  as AWREF_REV,
      _Fidoc.TransactionCurrency                        as RWCUR,
      _Fidoc.CompanyCodeCurrency                        as RHCUR,
      _Fidoc.GLAccount                                  as RACCT,
      _Fidoc.CostCenter                                 as RCNTR,
      _Fidoc.ProfitCenter                               as PRCTR,
      _Fidoc.FunctionalArea                             as RFAREA,
      _Fidoc.BusinessArea                               as RBUSA,
      @Semantics: { amount : {currencyCode: 'RHCUR'} }
      _Fidoc.AmountInCompanyCodeCurrency                as HSL,
      _Fidoc.DebitCreditCode                            as DRCRK,
      _Fidoc.FiscalPeriod                               as POPER,
      concat(_Fidoc.FiscalYear, _Fidoc.FiscalPeriod )   as SPMON,
      _Fidoc.PostingDate                                as BUDAT,
      _Fidoc.AccountingDocumentType                     as BLART,
      _Fidoc.AccountingDocumentItem                     as BUZEI,
      _Fidoc.AssignmentReference                        as ZUONR,
      _Fidoc.AccountAssignment                          as ACCAS,
      _Fidoc.PostingKey                                 as BSCHL,
      _Fidoc.TransactionTypeDetermination               as KTOSL,
      _Fidoc.AccountingDocCreatedByUser                 as USNAM,
      _Fidoc.CreationDateTime                           as TIMESTAMP,
      _Fidoc.GLAccountType                              as GLACCOUNT_TYPE,
      _Fidoc.ChartOfAccounts                            as KTOPL,
      _Fidoc.PurchasingDocument                         as EBELN,
      _Fidoc.PurchasingDocumentItem                     as EBELP,
      _Fidoc.DocumentItemText                           as SGTXT,
      _Fidoc.SalesDocument                              as KDAUF,
      _Fidoc.SalesDocumentItem                          as KDPOS,
      _Fidoc.Product                                    as MATNR,
      _Mat.ProductName                                  as MATNRT,
      _Fidoc.Plant                                      as WERKS,
      _Fidoc.Supplier                                   as LIFNR,
      _Lif.BusinessPartnerName                          as LIFNRT,
      _Fidoc.Customer                                   as KUNNR,
      _Kur.BusinessPartnerName                          as KUNNRT,
      _Fidoc.FinancialAccountType                       as KOART,
      _Fidoc.TaxCode                                    as MWSKZ,
      _Fidoc.ClearingDate                               as AUGDT,
      _Fidoc.CostEstimate                               as KALNR,
      _Fidoc.InventoryValuationType                     as BWTAR,
      _Fidoc.ValuationArea                              as BWKEY,
      case when $projection.AWTYP = 'RMRP' and $projection.BLART = 'RE' then _Lifa1.ReconciliationAccount
           else _Fidoc.OffsettingAccount
           end                                          as GKONT,
      _Fidoc.OffsettingAccountType                      as GKOAR,
      _Fidoc.PersonnelNumber                            as PERNR,
      _Fidoc.WBSElementInternalID                       as PS_PSP_PNR,
      _Fidoc.ProjectInternalID                          as PS_PRJ_PNR,
      _Fidoc.ProjectNetwork                             as NPLNR,
      _Fidoc.SalesOrganization                          as VKORG,
      _Fidoc.DistributionChannel                        as VTWEG,
      _Fidoc.BillToParty                                as KUNRE,
      _Fidoc.ShipToParty                                as KUNWE,
      _Fidoc._JournalEntry.AccountingDocumentHeaderText as BKTXT,
      _Mmdoci.InventorySpecialStockType                 as SOBKZ,
      case
       when _Fidoc.ReferenceDocumentType = 'PRCHG' then 'EB'
       when _Fidoc.ReferenceDocumentType = 'VBRK' and _Fidoc.MaterialLedgerProcessType = '' then 'SD'
       when _Fidoc.ReferenceDocumentType = 'RMRP' and _Fidoc.MaterialLedgerProcessType = '' then 'BB' 
       when _Fidoc.ReferenceDocumentType <> 'PRCHG'
           and _Fidoc.ReferenceDocumentType <> 'VBRK'
           and _Fidoc.ReferenceDocumentType <> 'RMRP'
           and _Fidoc.MaterialLedgerProcessType = '' then _ptyp.MaterialLedgerProcessType
       else _Fidoc.MaterialLedgerProcessType
      end                                               as Mlptyp,
      //      _Fidoc.MaterialLedgerProcessType as Mlptyp,

      _Fidoc.MaterialLedgerCategory                     as Mlcat,

      _Mara.BaseUnit                                    as MEINS,
      case when $projection.BLART <> 'PR' and _Fidoc.TransactionTypeDetermination = 'BSX' then cast( _Mmdoci.QuantityInBaseUnit as abap.dec(20,3) )
           else cast( 0 as abap.dec(20,3)) end          as MENGE,
      _Mmdoci.EntryUnit                                 as ERFME,
      case when $projection.BLART <> 'PR' and _Fidoc.TransactionTypeDetermination = 'BSX' then cast( _Mmdoci.QuantityInEntryUnit as abap.dec(20,2) )
           else cast( 0 as abap.dec(20,3)) end          as ERFMG,

      _Mmdoci.MaterialDocument                          as MBLNR,
      _Mmdoci.MaterialDocumentYear                      as MJAHR,
      _Mmdoci.MaterialDocumentItem                      as ZEILE,
      _Mmdoci.OriginalMaterialDocumentItem              as ORLINE,
      case $projection.Mlptyp
           when 'BB' then concat($projection.EBELN, $projection.EBELP)
           when 'BL' then concat($projection.EBELN, $projection.EBELP)
           when 'VL' then concat($projection.EBELN, $projection.EBELP)
           when 'BF' then $projection.AUFNR
           when 'VF' then $projection.AUFNR
           else concat(_Mmdoci.MaterialDocument, _Mmdoci.OriginalMaterialDocumentItem)
           end                                          as ORREF,
      _Mmdoci.ReversedMaterialDocumentYear              as SJAHR,
      _Mmdoci.ReversedMaterialDocument                  as SMBLN,
      _Mmdoci.ReversedMaterialDocumentItem              as SMBLP,
      _Mmdoci.OrderID                                   as AUFNR,
      _Mmdoci._MaterialDocumentHeader.ReferenceDocument as XBLNR,
      _Mmdoci.DeliveryDocument                          as VBELN_IM,
      _Mmdoci.DeliveryDocumentItem                      as VBELP_IM,
      case when _Soh.SalesDocumentType = 'CBAR' or _Soh.SalesDocumentType = 'CBRE' then case when _Soi.ReferenceSDDocument = '' or _Soi.ReferenceSDDocument is null then _Doi.ReferenceSDDocument 
                                                                                             else _Soi.ReferenceSDDocument
                                                                                             end 
           else _Doi.ReferenceSDDocument 
           end as KDAUF_IM,
      case when _Soh.SalesDocumentType = 'CBAR' or _Soh.SalesDocumentType = 'CBRE' then case when _Soi.ReferenceSDDocument = '' or _Soi.ReferenceSDDocument is null then _Doi.ReferenceSDDocumentItem                      
                                                                                             else _Soi.ReferenceSDDocumentItem
                                                                                             end 
           else _Doi.ReferenceSDDocumentItem 
           end as KDPOS_IM,
      _Mmdoci.GoodsMovementType                         as BWART,
      _Bwt.GoodsMovementTypeName                        as BWARTT,
      _Mmdoci.IsAutomaticallyCreated                    as XAUTO,
      _Mmdoci.StorageLocation                           as LGORT,
      _Mmdoci.Batch                                     as CHARG,
      _Mmdoci.DebitCreditCode                           as SHKZG,
      _Mmdoci.MaterialDocumentItemText                  as MMSGTXT,
      _Mmdoci.GoodsRecipientName                        as WEMPF,
      _Mmdoci.UnloadingPointName                        as ABLAD,
      _Mmdoci.GoodsMovementRefDocType                   as KZBEW,
      _Mmdoci.ConsumptionPosting                        as KZVBR,
      _Fidoc.InventorySpclStkSalesDocument              as SPSO,
      _Fidoc.InventorySpclStkSalesDocItm                as SPSOI,
      _Fidoc.InvtrySpclStockWBSElmntIntID               as SPWBS,
      _Mmdoci.OrderItem                                 as AUFPS,
      _Mmdoci.GLAccount                                 as MGKONT,
      _Mmdoci.CostCenter                                as COCTL,
      _Glt.GLAccountName                                as MGKONTT,
      case when $projection.Mlptyp = 'VU' or $projection.Mlptyp = 'VUBM' or
                $projection.Mlptyp = 'BU' or $projection.Mlptyp = 'BUBM' or
                $projection.Mlptyp = 'VL' or $projection.Mlptyp = 'BUBS' or
                $projection.Mlptyp = 'VUBS'
                then _Umdoci.Material
           when $projection.Mlptyp = 'VF'
                then _Moh.Product
           else _Mmdoci.IssgOrRcvgMaterial
      end                                               as UMMAT,
      case when $projection.Mlptyp = 'VU' or $projection.Mlptyp = 'VUBM' or
                $projection.Mlptyp = 'BU' or $projection.Mlptyp = 'BUBM' or
                $projection.Mlptyp = 'VL' or $projection.Mlptyp = 'BUBS' or
                $projection.Mlptyp = 'VUBS'
                then _Umdoci.Plant
           when $projection.Mlptyp = 'VF'
                then _Moh.ProductionPlant
           else _Mmdoci.IssuingOrReceivingPlant
      end                                               as UMWRK,
      case when $projection.Mlptyp = 'VU' or $projection.Mlptyp = 'VUBM' or
                $projection.Mlptyp = 'BU' or $projection.Mlptyp = 'BUBM' or
                $projection.Mlptyp = 'VL' or $projection.Mlptyp = 'BUBS' or
                $projection.Mlptyp = 'VUBS'
                then _Umdoci.StorageLocation
           when $projection.Mlptyp = 'VF'
                then _Moh.StorageLocation
           else _Mmdoci.IssuingOrReceivingStorageLoc
      end                                               as UMLGO,
      case when $projection.Mlptyp = 'VU' or $projection.Mlptyp = 'VUBM' or
                $projection.Mlptyp = 'BU' or $projection.Mlptyp = 'BUBM' or
                $projection.Mlptyp = 'VL' or $projection.Mlptyp = 'BUBS' or
                $projection.Mlptyp = 'VUBS'
                then _Umdoci.SpecialStockIdfgSalesOrder
           when $projection.Mlptyp = 'VF'
                then _Moh.SalesOrder
           else ''
      end                                               as UMSO,
      case when $projection.Mlptyp = 'VU' or $projection.Mlptyp = 'VUBM' or
                $projection.Mlptyp = 'BU' or $projection.Mlptyp = 'BUBM' or
                $projection.Mlptyp = 'VL' or $projection.Mlptyp = 'BUBS' or
                $projection.Mlptyp = 'VUBS'
                then _Umdoci.SpecialStockIdfgSalesOrderItem
           when $projection.Mlptyp = 'VF'
                then _Moh.SalesOrderItem
           else cast( '000000' as abap.numc(6) )
      end                                               as UMSOI,
      case when $projection.Mlptyp = 'VU' or $projection.Mlptyp = 'VUBM' or
                $projection.Mlptyp = 'BU' or $projection.Mlptyp = 'BUBM' or
                $projection.Mlptyp = 'VL' or $projection.Mlptyp = 'BUBS' or
                $projection.Mlptyp = 'VUBS'
                then _Umdoci.SpecialStockIdfgWBSElement
           when $projection.Mlptyp = 'VF'
                then _Moh.WBSElementInternalID
           else cast( '00000000' as abap.numc(8) )
      end                                               as UMWBS,
      case when $projection.Mlptyp = 'VU' or $projection.Mlptyp = 'VUBM' or
                $projection.Mlptyp = 'BU' or $projection.Mlptyp = 'BUBM' or
                $projection.Mlptyp = 'VL' or $projection.Mlptyp = 'BUBS' or
                $projection.Mlptyp = 'VUBS'
                then _Umdoci.InventorySpecialStockType
           when $projection.Mlptyp = 'VF' and _Moh.SalesOrder <> ''and _Moh.WBSElementInternalID = '00000000'
                then 'E'
           when $projection.Mlptyp = 'VF' and _Moh.WBSElementInternalID <> '00000000' and _Moh.SalesOrder = ''
                then 'Q'
           else ''
      end                                               as UMSOB,
      case when $projection.Mlptyp = 'VU' or $projection.Mlptyp = 'VUBM' or
                $projection.Mlptyp = 'BU' or $projection.Mlptyp = 'BUBM' or
                $projection.Mlptyp = 'VL' or $projection.Mlptyp = 'BUBS' or
                $projection.Mlptyp = 'VUBS'
                then _Umdoci.InventoryValuationType
           when $projection.Mlptyp = 'VF'
                then _Mbew2( p_year: $parameters.p_year, p_month: $parameters.p_month ).Bwtar
           else ''
      end                                               as UMBWT,
      case when $projection.Mlptyp = 'VU' or $projection.Mlptyp = 'VUBM' or
                $projection.Mlptyp = 'BU' or $projection.Mlptyp = 'BUBM' or
                $projection.Mlptyp = 'VL' or $projection.Mlptyp = 'BUBS' or
                $projection.Mlptyp = 'VUBS'
                then _Mbew1.CostEstimate
           when $projection.Mlptyp = 'VF'
                then _Mbew2( p_year: $parameters.p_year, p_month: $parameters.p_month ).Kalnr
           else cast( '000000000000' as abap.numc(12) )
      end                                               as UMKAL,

      _Mohs.OrderIsDelivered                            as MOSTATUS1,
      _Mohs.OrderIsTechnicallyCompleted                 as MOSTATUS2,

      /*      _Mmdoci.IssgOrRcvgMaterial                        as UMMAT,
            _Umt.ProductName                                  as UMMATT,
            _Mmdoci.IssgOrRcvgBatch                           as UMCHA,
            _Mmdoci.IssuingOrReceivingPlant                   as UMWRK,
            _Mmdoci.IssuingOrReceivingStorageLoc              as UMLGO,
            _Mmdoci.IssgOrRcvgSpclStockInd                    as UMSOK,
            _Bt.InventoryValuationType                        as UMBWT,
            case when _Mmdoci.IssgOrRcvgMaterial is not null and _Bt.InventoryValuationType is null
            then _Mbew1.ProdCostEstNumber
            when _Mmdoci.IssgOrRcvgMaterial is not null and _Bt.InventoryValuationType is not null
            then _Mbew2.ProdCostEstNumber
            else '000000000000'
            end                                               as UMKAL,
      */
      _Mara.CreationDate                                as ERSDA,
      _Mara.CreatedByUser                               as ERNAM,
      _Mara.IsMarkedForDeletion                         as LVORM_MARA,
      _Mara.ProductType                                 as MTART,
      _Mara.IndustrySector                              as MBRSH,
      _Mara.ProductGroup                                as MATKL,
      _Mara.ProductOldID                                as BISMT,
      _Mara.ItemCategoryGroup                           as NORMT,
      _Mara.WarehouseStorageCondition                   as RAUBE,
      _Mara.TransportationGroup                         as TRAGR,
      _Mara.Division                                    as SPART,
      _Mara.ExternalProductGroup                        as EXTWG,

      _Marc.MaintenanceStatusName                       as PSTAT,
      _Marc.IsMarkedForDeletion                         as LVORM_MARC,
      _Marc.IsInternalBatchManaged                      as XCHAR,
      _Marc.ABCIndicator                                as MAABC,
      _Marc.PurchasingGroup                             as EKGRP,
      _Marc.MRPType                                     as DISMM,
      _Marc.MRPResponsible                              as DISPO,
      _Marc.ProcurementType                             as BESKZ,
      _Marc.SpecialProcurementType                      as SOBSL,
      _Marc.ProductLogisticsHandlingGroup               as LADGR,
      _Marc.IsBatchManagementRequired                   as XCHPF,
      _Marc.AvailabilityCheckType                       as MTVFP,
      _Marc.SerialNumberProfile                         as SERNP,

      _Mvke.IsMarkedForDeletion                         as LVORM_MVKE,
      _Mvke.LogisticsStatisticsGroup                    as VERSG,
      _Mvke.ProductHierarchy                            as PRODH,
      _Mvke.PriceSpecificationProductGroup              as KONDM,
      _Mvke.AccountDetnProductGroup                     as KTGRM,
      _Mvke.FirstSalesSpecProductGroup                  as MVGR1,
      _Mvke.SecondSalesSpecProductGroup                 as MVGR2,
      _Mvke.ThirdSalesSpecProductGroup                  as MVGR3,
      _Mvke.FourthSalesSpecProductGroup                 as MVGR4,
      _Mvke.FifthSalesSpecProductGroup                  as MVGR5,
      _Mvke.ProductHasAttributeID01                     as PRAT1,
      _Mvke.ProductHasAttributeID02                     as PRAT2,
      _Mvke.ProductHasAttributeID03                     as PRAT3,
      _Mvke.ProductHasAttributeID04                     as PRAT4,
      _Mvke.ProductHasAttributeID05                     as PRAT5,
      _Mvke.ProductHasAttributeID06                     as PRAT6,
      _Mvke.ProductHasAttributeID07                     as PRAT7,
      _Mvke.ProductHasAttributeID08                     as PRAT8,
      _Mvke.ProductHasAttributeID09                     as PRAT9,
      _Mvke.ProductHasAttributeID10                     as PRATA,

      _Mbew.IsMarkedForDeletion                         as LVORM_MBEW,
      _Mbew.InventoryValuationProcedure                 as VPRSV,
      _Mbew.PriceDeterminationControl                   as VERPR,
      _Mbew.ValuationClass                              as BKLAS,
      _Mbew.Currency                                    as WAERS,
      _Mbew.ValuationCategory                           as BWTTY,

      _Soh.SalesDocumentType                            as STYPE,
      _Soh.SalesDocumentProcessingType                  as VBKLT,
      _Soh.CreatedByUser                                as SERNAM,
      _Soh.LastChangedByUser                            as SLRNAM,
      _Soh.CreationDate                                 as SERDAT,
      _Soh.LastChangeDate                               as SAEDAT,
      _Soh.SenderBusinessSystemName                     as SESYSID,
      _Soh.ExternalDocumentID                           as SEDOCID,
      _Soh.SalesGroup                                   as VKGRP,
      _Soh.SalesOffice                                  as VKBUR,
      _Soh.SoldToParty                                  as KUNAG,
      _Soh.CustomerGroup                                as KDGRP,
      _Soh.AdditionalCustomerGroup1                     as KVGR1,
      _Soh.AdditionalCustomerGroup2                     as KVGR2,
      _Soh.AdditionalCustomerGroup3                     as KVGR3,
      _Soh.AdditionalCustomerGroup4                     as KVGR4,
      _Soh.AdditionalCustomerGroup5                     as KVGR5,
      _Soh.CreditControlArea                            as KKBER,
      _Soh.SalesDocumentDate                            as SAUDAT,
      _Soh.SDDocumentReason                             as SAUGRU,
      _Soh.PurchaseOrderByCustomer                      as BSTKD,
      _Soh.PurchaseOrderByShipToParty                   as BSTKD_E,
      _Soh.SDDocumentCollectiveNumber                   as SUBMI_SD,
      _Soh.CustomerPurchaseOrderType                    as BSARK,
      _Soh.SalesDistrict                                as BZIRK,
      _Soh.ProductCatalog                               as WMINR,
      _Soh.BillingPlan                                  as FPLNR,
      _Soh.CustomerTaxClassification1                   as STAXK1,
      _Soh.CustomerTaxClassification2                   as STAXK2,
      _Soh.CustomerTaxClassification3                   as STAXK3,
      _Soh.CustomerTaxClassification4                   as STAXK4,
      _Soh.CustomerTaxClassification5                   as STAXK5,
      _Soh.CustomerTaxClassification6                   as STAXK6,
      _Soh.CustomerTaxClassification7                   as STAXK7,
      _Soh.CustomerTaxClassification8                   as STAXK8,
      _Soh.CustomerTaxClassification9                   as STAXK9,
      _Soh.RequestedDeliveryDate                        as SDELDT,
      _Soh.ShippingType                                 as VSARTTR,
      _Soh.ShippingCondition                            as VSBED,
      _Soh.ReceivingPoint                               as EMPST,
      _Soh.IncotermsClassification                      as SINCO1,
      _Soh.IncotermsTransferLocation                    as SINCO2,
      _Soh.IncotermsLocation1                           as SINCO2_L,
      _Soh.IncotermsLocation2                           as SINCO3_L,
      _Soh.IncotermsVersion                             as SINCOV,
      _Soh.CustomerPaymentTerms                         as SZTERM,
      _Soh.PaymentMethod                                as SSCHZW,
      _Soh.AssignmentReference                          as ORDNR_V,
      _Soh.ReferenceSDDocument                          as SVGBEL,
      _Soh.ReferenceSDDocumentCategory                  as SVBTYPL,

      _Soi.SalesDocumentItemCategory                    as PSTYV,
      _Soi.SalesDocumentItemType                        as POSAR,
      _Soi.IsReturnsItem                                as SHKZG_VA,
      _Soi.MaterialByCustomer                           as MATNR_KU,
      _Soi.MaterialSubstitutionReason                   as SYGRD,
      _Soi.DeliveryGroup                                as GRKOR,
      _Soi.ProductConfiguration                         as CUOBJ_VA,
      _Soi.SalesDocumentItemText                           as ARKTX,
      _Soi.UnderlyingPurchaseOrderItem                  as POSEX,
      _Soi.ExternalItemID                               as SERIID,

      _Do.SDDocumentCategory                            as DCAT,
      _Do.DeliveryDocumentType                          as DTYPE,

      _Poh.PurchaseOrderType                            as ESART,
      _Poh.CreatedByUser                                as PERNAM,
      _Poh.CreationDate                                 as PERDAT,
      _Poh.PurchaseOrderDate                            as BEDAT,
      _Poh.PurchasingOrganization                       as PEKORG,
      _Poh.PurchasingGroup                              as PEKGRP,
      _Poh.SupplierRespSalesPersonName                  as PEVERK,
      _Poh.SupplyingSupplier                            as LLIEF,
      _Poh.SupplyingPlant                               as RESWK,
      _Poh.InvoicingParty                               as LIFRE,
      _Poh.Customer                                     as PKUNNR,
      _Poh.PaymentTerms                                 as PZTERM,
      _Poh.IncotermsClassification                      as PINCO1,
      _Poh.IncotermsTransferLocation                    as PINCO2,
      _Poh.IncotermsVersion                             as PINOCV,
      _Poh.IncotermsLocation1                           as PINCO2_L,
      _Poh.IncotermsLocation2                           as PINCO3_L,

      _Poi.PurchaseOrderCategory                        as BSTYP,
      _Poi.DocumentCurrency                             as PWAERS,
      _Poi.PurchasingDocumentItemOrigin                 as ASTAT,
      _Poi.SupplierMaterialNumber                       as IDNLF,
      _Poi.SupplierSubrange                             as LTSNR,
      _Poi.ManufacturerPartNmbr                         as MFRPN,
      _Poi.Manufacturer                                 as MFRNR,
      _Poi.Subcontractor                                as EMLIF,
      _Poi.SupplierIsSubcontractor                      as LBLKZ,
      _Poi.GoodsReceiptIsExpected                       as WEPOS,
      _Poi.InvoiceIsExpected                            as REPOS,
      _Poi.InvoiceIsGoodsReceiptBased                   as WEBRE,
      _Poi.PurchaseContractItem                         as KTPNR,
      _Poi.PurchaseContract                             as KONNR,
      _Poi.PurchaseRequisition                          as BANFN,
      _Poi.RequirementTracking                          as BEDNR,
      _Poi.PurchaseRequisitionItem                      as BNFPO,
      _Poi.EvaldRcptSettlmtIsAllowed                    as XERSY,
      _Poi.RequisitionerName                            as AFNAM,
      _Poi.PurchaseOrderItemCategory                    as PSTYP,
      _Poi.IsReturnsItem                                as RETPO,
      _Poi.PurchasingOrderReason                        as BSGRU,
      _Poi.CommodityCode                                as PCOMCO,
      _Poi.AccountAssignmentCategory                    as KNTTP,
      _Poi.GoodsReceiptIsNonValuated                    as WEUNB,
      _Poi.TaxCode                                      as PMWSKZ,
      _Poi.TaxJurisdiction                              as TXJCD,
      _Poi.ShippingInstruction                          as PEVERS,
      _Poi.ShippingType                                 as PVERSART,
      _Poi.StockType                                    as PINSMK,
      _Poi.DeliveryDocumentType                         as LFRET,
      _Poi.IssuingStorageLocation                       as RESLO,

      _Moh.ManufacturingOrderCategory                   as AUTYP,
      _Moh.ManufacturingOrderType                       as AUFART,
      _Moh.ManufacturingOrderText                       as MATEXT,
      _Moh.ManufacturingOrderHasLongText                as AUFTEXT,
      _Moh.ManufacturingOrderImportance                 as MORIMP,
      _Moh.MfgOrderIsPartOfCollvOrder                   as CO_PRODNET,
      _Moh.MfgOrderHierarchyLevelValue                  as HISTU,
      _Moh.MfgOrderHierarchyPathValue                   as WEGXX,
      _Moh.CreationDate                                 as MERDAT,
      _Moh.CreatedByUser                                as MERNAM,
      _Moh.LastChangeDate                               as MAEDAT,
      _Moh.LastChangedByUser                            as MAENAM,
      _Moh.Material                                     as MMATNR,
      _Moh.StorageLocation                              as MLGORT,

      _Moh.GoodsRecipientName                           as MWEMPF,
      _Moh.UnloadingPointName                           as MABLAD,
      _Moh.MfgOrderInternalID                           as MAUFPL,
      _Moh.ReferenceOrder                               as FIS_AUFREFNR,
      _Moh.LeadingOrder                                 as LAUFNR,
      _Moh.SuperiorOrder                                as MFEVOR,
      _Moh.ProductionVersion                            as VERID,
      _Moh.SalesOrder                                   as MKDAUF,
      _Moh.SalesOrderItem                               as MKDPOS,
      _Moh.Reservation                                  as MRSNUM,
      _Moh.PlannedOrder                                 as MPLNUM,
      _Moh.ObjectInternalID                             as MOBJNR,
      _Moh.ProductConfiguration                         as MPRCON,
      _Moh.BillOfOperationsMaterial                     as BOOMAT,
      _Moh.BillOfOperationsType                         as BOOTYP,
      _Moh.BillOfOperationsGroup                        as BOOGRP,
      _Moh.BillOfOperationsUsage                        as BOOUSG,
      _Moh.BillOfMaterialCategory                       as MSTLTY,
      _Moh.BillOfMaterial                               as MSTNUM,
      _Moh.BillOfMaterialVariant                        as MSTALT,
      _Moh.BillOfMaterialVariantUsage                   as MSTLAN,
      _Moh.ProfitCenter                                 as MPRCTR,
      _Moh.CostCenter                                   as MKOSTL,
      _Moh.CostElement                                  as MKSTAR,
      _Moh.GLAccount                                    as MSAKNR,
      _Moh.ProductCostCollector                         as MPKOSA


}
where
  (
       _Fidoc.ReferenceDocumentType        =  'MKPF'
    or _Fidoc.ReferenceDocumentType        =  'RMRP'
    or _Fidoc.ReferenceDocumentType        =  'PRCHG'
    or _Fidoc.ReferenceDocumentType        =  'VBRK'

  )
  and  _Fidoc.TransactionTypeDetermination <> 'MWS'
  and  _Fidoc.Ledger                       =  '0L'
  and  _Fidoc.FiscalYear                   = $parameters.p_year
  and  _Fidoc.FiscalPeriod                 = $parameters.p_month
