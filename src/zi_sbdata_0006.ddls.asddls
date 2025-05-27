@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '[SB] 외주입고 하위품목 출고'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_SBDATA_0006 
  with parameters
    p_year  : gjahr,
    p_month : poper
  as select from    ZI_SBDATA_0001 ( p_month: $parameters.p_month, p_year: $parameters.p_year ) as _Fidvl
    left outer join ZI_SBDATA_0001 ( p_month: $parameters.p_month, p_year: $parameters.p_year ) as _Fidbl on  _Fidvl.EBELN  = _Fidbl.EBELN
                                                                                                         and _Fidvl.EBELP  = _Fidbl.EBELP
                                                                                                         and _Fidvl.SPMON  = _Fidbl.SPMON
                                                                                                         and _Fidbl.KTOSL  = 'BSX'
                                                                                                         and _Fidbl.Mlptyp = 'BL'

{
  key _Fidvl.SPMON      as SPMON,
  key _Fidvl.EBELN      as EBELN,
  key _Fidvl.EBELP      as EBELP,
  key _Fidvl.MATNR      as FMATNR,
  key _Fidvl.BWKEY      as FWERKS,
  key _Fidvl.BWTAR      as FBWTAR,
  key _Fidvl.KALNR      as FKALNR,
  key _Fidvl.BKLAS      as FBKLAS,
  key _Fidbl.MATNR      as TMATNR,
  key _Fidbl.BWKEY      as TWERKS,
  key _Fidbl.BWTAR      as TBWTAR,
  key _Fidbl.KALNR      as TKALNR,
  key _Fidbl.BKLAS      as TBKLAS,
      _Fidvl.MEINS      as FMEINS,
      _Fidvl.RHCUR      as FRHCUR,
      @Semantics.quantity.unitOfMeasure: 'FMEINS'
      sum( case when _Fidvl.SHKZG = 'S' then _Fidvl.MENGE * -1
           else _Fidvl.MENGE
           end )        as FMENGE,
      @Semantics.amount.currencyCode: 'FRHCUR'
      sum( _Fidvl.HSL ) as FHSL,

      _Fidbl.MEINS      as TMEINS,
      _Fidbl.RHCUR      as TRHCUR,
      @Semantics.quantity.unitOfMeasure: 'TMEINS'
      sum( case when _Fidbl.SHKZG = 'H' then _Fidbl.MENGE * -1
          else _Fidbl.MENGE
          end )         as TMENGE,
      @Semantics.amount.currencyCode: 'TRHCUR'
      sum( _Fidbl.HSL ) as THSL
}
where
      _Fidvl.AWTYP  = 'MKPF'
  and _Fidvl.KTOSL  = 'BSX'
  and _Fidvl.Mlptyp = 'VL'

group by
  _Fidvl.SPMON,
  _Fidvl.EBELN,
  _Fidvl.EBELP,
  _Fidvl.MATNR,
  _Fidvl.BWKEY,
  _Fidvl.BWTAR,
  _Fidvl.KALNR,
  _Fidvl.BKLAS,
  _Fidbl.MATNR,
  _Fidbl.BWKEY,
  _Fidbl.BWTAR,
  _Fidbl.KALNR,
  _Fidbl.BKLAS,
  _Fidvl.MEINS,
  _Fidvl.RHCUR,
  _Fidbl.MEINS,
  _Fidbl.RHCUR
