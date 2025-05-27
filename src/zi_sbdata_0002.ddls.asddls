@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '[SB] 플랜트레벨 기초기말'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_SBDATA_0002 with parameters
    p_syear  : gjahr,
    p_smonth : poper,
    p_eyear  : gjahr,
    p_emonth : poper
  as select from I_InventoryAmtByFsclPerd( P_FiscalPeriod: $parameters.p_emonth, P_FiscalYear: $parameters.p_eyear ) as _e



  association [0..1] to I_ProductValuationBasic  as _mbew on  _mbew.Product       = _e.Material
                                                          and _mbew.ValuationArea = _e.ValuationArea
                                                          and _mbew.ValuationType = _e.ValuationType
  association [0..1] to I_Product                as _mara on  _e.Material = _mara.Product
  association [0..1] to I_ProductText            as _makt on  _e.Material    = _makt.Product
                                                          and _makt.Language = '3'
  association [0..1] to I_InventoryAmtByFsclPerd as _s    on  _e.CostEstimate = _s.CostEstimate
                                                          and _s.Ledger       = '0L'
{
  key _e.CostEstimate                                                                                                                                                                              as Kalnr,
  key concat(_s( P_FiscalPeriod: $parameters.p_smonth, P_FiscalYear: $parameters.p_syear ).FiscalYear, _s( P_FiscalPeriod: $parameters.p_smonth, P_FiscalYear: $parameters.p_syear ).FiscalPeriod) as Sspmon,
  key concat(_e.FiscalYear, _e.FiscalPeriod)                                                                                                                                                       as Espmon,
      _e.Material                                                                                                                                                                                  as Matnr,
      _makt.ProductName                                                                                                                                                                            as maktx,
      _e.ValuationType                                                                                                                                                                             as Bwtar,
      _e.ValuationArea                                                                                                                                                                             as Bwkey,
      _mbew.ValuationClass                                                                                                                                                                         as Bklas,
      _mara.ProductType                                                                                                                                                                            as Mtart,
      _mara.ProductGroup                                                                                                                                                                           as Matkl,

      _mara.BaseUnit                                                                                                                                                                               as Meins,
      _mbew.Currency                                                                                                                                                                               as Waers,

      _s( P_FiscalPeriod: $parameters.p_smonth, P_FiscalYear: $parameters.p_syear ).InvtryValnSpecialStockType                                                                                     as SSobkz,
      _s( P_FiscalPeriod: $parameters.p_smonth, P_FiscalYear: $parameters.p_syear ).SalesOrder                                                                                                     as SKdauf,
      _s( P_FiscalPeriod: $parameters.p_smonth, P_FiscalYear: $parameters.p_syear ).SalesOrderItem                                                                                                 as SKdpos,
      _s( P_FiscalPeriod: $parameters.p_smonth, P_FiscalYear: $parameters.p_syear ).WBSElementInternalID                                                                                           as SPs_psp_pnr,

      @Semantics.quantity.unitOfMeasure: 'meins'
      _s( P_FiscalPeriod: $parameters.p_smonth, P_FiscalYear: $parameters.p_syear ).ValuationQuantity                                                                                              as Smenge,
      @Semantics: { amount : {currencyCode: 'Waers'} }
      _s( P_FiscalPeriod: $parameters.p_smonth, P_FiscalYear: $parameters.p_syear ).AmountInCompanyCodeCurrency * 100                                                                              as Sdmbtr,

      _e.InvtryValnSpecialStockType                                                                                                                                                                as ESobkz,
      _e.SalesOrder                                                                                                                                                                                as EKdauf,
      _e.SalesOrderItem                                                                                                                                                                            as EKdpos,
      _e.WBSElementInternalID                                                                                                                                                                      as EPs_psp_pnr,

      @Semantics.quantity.unitOfMeasure: 'Meins'
      _e.ValuationQuantity                                                                                                                                                                         as Emenge,
      @Semantics: { amount : {currencyCode: 'Waers'} }
      _e.AmountInCompanyCodeCurrency * 100                                                                                                                                                         as Edmbtr

}
where
  _e.Ledger = '0L'

union all select from I_InventoryAmtByFsclPerd( P_FiscalPeriod: $parameters.p_smonth, P_FiscalYear: $parameters.p_syear ) as _s

  left outer join     I_InventoryAmtByFsclPerd( P_FiscalPeriod: $parameters.p_emonth, P_FiscalYear: $parameters.p_eyear ) as _e on  _e.CostEstimate = _s.CostEstimate
                                                                                                                                and _e.Ledger       = '0L'

association [0..1] to I_ProductValuationBasic as _mbew on  _mbew.Product       = _s.Material
                                                       and _mbew.ValuationArea = _s.ValuationArea
                                                       and _mbew.ValuationType = _s.ValuationType
association [0..1] to I_Product               as _mara on  _s.Material = _mara.Product
association [0..1] to I_ProductText           as _makt on  _s.Material    = _makt.Product
                                                       and _makt.Language = '3'
{
  key _s.CostEstimate                        as Kalnr,
  key concat(_s.FiscalYear, _s.FiscalPeriod) as Sspmon,
  key concat(_e.FiscalYear, _e.FiscalPeriod) as Espmon,
      _s.Material                            as Matnr,
      _makt.ProductName                      as maktx,
      _s.ValuationType                       as Bwtar,
      _s.ValuationArea                       as Bwkey,
      _mbew.ValuationClass                   as Bklas,
      _mara.ProductType                      as Mtart,
      _mara.ProductGroup                     as Matkl,

      _mara.BaseUnit                         as Meins,
      _mbew.Currency                         as Waers,

      _s.InvtryValnSpecialStockType          as SSobkz,
      _s.SalesOrder                          as SKdauf,
      _s.SalesOrderItem                      as SKdpos,
      _s.WBSElementInternalID                as SPs_psp_pnr,
      _s.ValuationQuantity                   as Smenge,
      _s.AmountInCompanyCodeCurrency * 100   as Sdmbtr,

      _e.InvtryValnSpecialStockType          as ESobkz,
      _e.SalesOrder                          as EKdauf,
      _e.SalesOrderItem                      as EKdpos,
      _e.WBSElementInternalID                as EPs_psp_pnr,
      _e.ValuationQuantity                   as Emenge,
      _e.AmountInCompanyCodeCurrency * 100   as Edmbtr

}
where
      _s.Ledger       = '0L'
  and _e.CostEstimate is null
