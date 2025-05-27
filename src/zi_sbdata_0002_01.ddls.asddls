@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '[SB] 저장위치레벨 기초기말'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_SBDATA_0002_01 with parameters
    p_date  : vdm_v_key_date,
    p_year  : gjahr,
    p_month : poper
  as select from    I_MatlStkAtKeyDateInAltUoM( P_KeyDate : $parameters.p_date ) as _Mardh
    join            I_Product                                                    as _Mara on _Mara.Product = _Mardh.Product

    left outer join I_Batch                                                      as _Bt   on  _Bt.Material = _Mardh.Product
                                                                                          and _Bt.Plant    = _Mardh.Plant
                                                                                          and _Bt.Batch    = _Mardh.Batch
  association [0..1] to I_ProductValuationBasic as _Mbew  on  _Mbew.Product       = _Mardh.Product
                                                          and _Mbew.ValuationArea = _Mardh.Plant
                                                          and _Mbew.ValuationType = ''
  association [0..1] to ZI_SBDATA_0008            as _Mbew1 on  _Mardh.Product              = _Mbew1.Matnr
                                                          and _Mardh.Plant                = _Mbew1.Bwkey
                                                          and _Mbew1.Bwtar                = ''
                                                          and _Mardh.SDDocument           = _Mbew1.Spso
                                                          and _Mardh.SDDocumentItem       = _Mbew1.Spsoi
                                                          and _Mardh.WBSElementInternalID = _Mbew1.Spwbs
  association [0..1] to ZI_SBDATA_0008            as _Mbew2 on  _Mardh.Product              = _Mbew2.Matnr
                                                          and _Mardh.Plant                = _Mbew2.Bwkey
                                                          and _Bt.InventoryValuationType  = _Mbew2.Bwtar
                                                          and _Mardh.SDDocument           = _Mbew2.Spso
                                                          and _Mardh.SDDocumentItem       = _Mbew2.Spsoi
                                                          and _Mardh.WBSElementInternalID = _Mbew2.Spwbs
  association [0..1] to I_ProductText           as _Makt  on  _Mara.Product  = _Makt.Product
                                                          and _Makt.Language = '3'

{
  key _Mardh.Product                                                                         as Matnr,
  key _Mardh.Plant                                                                           as Werks,
  key _Mardh.StorageLocation                                                                 as Lgort,
  key _Mardh.Supplier                                                                        as Lifnr,
  key _Mardh.Customer                                                                        as Kunnr,
  key _Mardh.SDDocument                                                                      as Kdauf,
  key _Mardh.SDDocumentItem                                                                  as Kdpos,
  key _Mardh.WBSElementInternalID                                                            as Wbsid,
  key _Mardh.InventorySpecialStockType                                                       as Sobkz,
  key case when _Bt.InventoryValuationType <> '' then _Mbew2( p_year: $parameters.p_year, p_month: $parameters.p_month ).Bwtar
           else _Mbew1( p_year: $parameters.p_year, p_month: $parameters.p_month ).Bwtar end as Bwtar,
  key case when _Bt.InventoryValuationType <> '' then _Mbew1( p_year: $parameters.p_year, p_month: $parameters.p_month ).Kalnr
           else _Mbew1( p_year: $parameters.p_year, p_month: $parameters.p_month ).Kalnr end as Kalnr,
  key $parameters.p_date                                                                     as budat,

      _Makt.ProductName                                                                      as maktx,

      _Mbew.ValuationArea                                                                    as Bwkey,
      _Mbew.ValuationClass                                                                   as Bklas,
      _Mara.ProductType                                                                      as Mtart,
      _Mara.ProductGroup                                                                     as Matkl,
      _Mara.BaseUnit                                                                         as Meins,

      @Semantics.quantity.unitOfMeasure: 'Meins'
      sum(_Mardh.MatlWrhsStkQtyInMatlBaseUnit)                                               as Menge,

      cast( 0 as abap.dec(20,5) )                                                            as Dmbtr,
      cast( 0 as abap.dec(20,5) )                                                            as Danga


}
where
  _Mardh.MaterialBaseUnit = _Mardh.AlternativeUnit
group by
  _Mardh.Product,
  _Mardh.Plant,
  _Mardh.StorageLocation,
  _Mardh.Supplier,
  _Mardh.Customer,
  _Mardh.SDDocument,
  _Mardh.SDDocumentItem,
  _Mardh.WBSElementInternalID,
  _Mardh.InventorySpecialStockType,
  _Bt.InventoryValuationType,
  _Mbew1( p_year: $parameters.p_year, p_month: $parameters.p_month ).Bwtar,
  _Mbew1( p_year: $parameters.p_year, p_month: $parameters.p_month ).Kalnr,
  _Mbew2( p_year: $parameters.p_year, p_month: $parameters.p_month ).Bwtar,
  _Mbew2( p_year: $parameters.p_year, p_month: $parameters.p_month ).Kalnr,
  _Makt.ProductName,
  _Mbew.ValuationArea,
  _Mbew.ValuationClass,
  _Mara.ProductType,
  _Mara.ProductGroup,
  _Mara.BaseUnit
