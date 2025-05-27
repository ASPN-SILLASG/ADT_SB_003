@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '[SB] 기간별 자재표준단가'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_SBDATA_0007  as select from I_ProductCostEstimateItem as _Coi
    join         I_ProductCostEstimate     as _Co   on  _Coi.TransferCostEstimate = _Co.CostEstimate
                                                    and _Coi.TransferCostingDate  = _Co.CostingDate
                                                    and _Coi.TransferCostingType = _Co.CostingType
                                                    and _Coi.TransferCostingVersion = _Co.CostingVersion
    join         I_ProductValuationBasic   as _Mbew on _Co.Product = _Mbew.Product
                                                    and _Co.ValuationArea = _Mbew.ValuationArea
                                                    and _Co.ValuationType = _Mbew.ValuationType
{
  key _Co.CostEstimate                          as KALNR,
  key concat( _Co.PostingFiscalYear, _Co.PostingPeriod ) as SPMON,
  key _Co.Product                                       as MATNR,
  key _Mbew.ValuationClass                               as BKLAS,
  key _Co.Plant                                         as WERKS,
      _Co.CompanyCodeCurrency                            as WAERS,
      _Mbew.PriceUnitQty                                 as PEINH,
      @Semantics.amount.currencyCode: 'WAERS'
      sum(  _Coi.TotalAmountInCoCodeCrcy )               as DMBTR
}
where
      _Co.CostEstimateStatus     = 'FR'
  and _Co.CostEstimateIsReleased = 'X'

group by
  _Co.CostEstimate,
  _Co.PostingFiscalYear,
  _Co.PostingPeriod,
  _Co.Product,
  _Mbew.ValuationClass,
  _Co.Plant,
  _Co.CompanyCodeCurrency,
  _Mbew.PriceUnitQty
