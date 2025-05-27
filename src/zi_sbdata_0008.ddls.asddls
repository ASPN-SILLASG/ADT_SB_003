@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '[SB] 기간별 원가추정번호'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_SBDATA_0008    
  with parameters
    p_year  : gjahr,
    p_month : poper
  as select distinct from I_InventoryAmtByFsclPerd( P_FiscalPeriod: $parameters.p_month, P_FiscalYear: $parameters.p_year ) as _e
   association [0..1] to I_ProductValuationBasic as _mbew on  _mbew.Product = _e.Material
                                                          and _mbew.ValuationArea = _e.ValuationArea
                                                          and _mbew.ValuationType = _e.ValuationType 
{
   key _e.CostEstimate as Kalnr,
   key _e.CompanyCode as Bukrs,
       _e.Material as Matnr,
       _e.ValuationArea as Bwkey,
       _e.ValuationType as Bwtar,
       _mbew.ValuationClass as Bklas,
       _e.InvtryValnSpecialStockType as Sobkz,
       _e.SalesOrder as Spso,
       _e.SalesOrderItem as Spsoi,
       _e.Supplier as Lifnr,
       _e.WBSElementInternalID as Spwbs
  
} where _e.Ledger               = '0L'
