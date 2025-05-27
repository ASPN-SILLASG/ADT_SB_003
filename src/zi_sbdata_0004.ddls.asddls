@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '[SB] 오더정산'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_SBDATA_0004 as select distinct from I_JournalEntryItem      as _Fidoc
    join                  I_Product               as _Mara on _Fidoc.Product = _Mara.Product
    join                  I_ProductValuationBasic as _Mbew on  _Fidoc.Product                = _Mbew.Product
                                                           and _Fidoc.ValuationArea          = _Mbew.ValuationArea
                                                           and _Fidoc.InventoryValuationType = _Mbew.ValuationType
  association [0..1] to I_ProductText as _makt on  _Fidoc.Product = _makt.Product
                                               and _makt.Language = '3'

{
  key _Fidoc.AccountingDocument                       as Belnr,
  key _Fidoc.LedgerGLLineItem                         as Docln,
  key _Fidoc.FiscalYear                               as Gjahr,
  key _Fidoc.CompanyCode                              as Bukrs,
      concat(_Fidoc.FiscalYear, _Fidoc.FiscalPeriod ) as SPMON,
      _Fidoc.PostingDate                              as BUDAT,
      _Fidoc.OriginOrder                              as AUFNR,
      _Fidoc.CostEstimate                             as KALNR,
      _Fidoc.Product                                  as MATNR,
      _makt.ProductName                               as MAKTX,
      _Mara.ProductType                               as MTART,
      _Mara.ProductGroup                              as MATKL,
      _Fidoc.Plant                                    as WERKS,
      _Mbew.ValuationArea                             as BWKEY,
      _Mbew.ValuationClass                            as BKLAS,
      _Fidoc.InventoryValuationType                   as BWTAR,
      _Fidoc.InventorySpclStkSalesDocument            as SPSO,
      _Fidoc.InventorySpclStkSalesDocItm              as SPSOI,
      _Fidoc.InvtrySpclStockWBSElmntIntID             as SPWBS,
      _Fidoc.InventorySpecialStockType                as SOBKZ,
      _Fidoc.TransactionTypeDetermination             as KTOSL,
      _Fidoc.GLAccount                                as RACCT,
      _Fidoc.OffsettingAccount                        as RACCTA,
      _Fidoc.CompanyCodeCurrency                      as WAERS,
      _Mara.BaseUnit                                  as MEINS,
      @Semantics: { amount : {currencyCode: 'WAERS'} }
      _Fidoc.AmountInCompanyCodeCurrency              as HSL,

      _Fidoc.MaterialLedgerCategory                   as Mlcat,
      _Fidoc.MaterialLedgerProcessType                as Mlptyp

}
where
  (
       _Fidoc.ReferenceDocumentType        =  'EBWP'
    or _Fidoc.ReferenceDocumentType        =  'EBWI'
  )
  and  _Fidoc.TransactionTypeDetermination =  'PRD'
  and  _Fidoc.Product                      <> ''
  and  _Fidoc.Ledger                       =  '0L'
