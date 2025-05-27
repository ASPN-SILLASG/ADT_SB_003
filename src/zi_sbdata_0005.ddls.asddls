@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '[SB] 생산입고 하위품목 출고'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_SBDATA_0005 
  with parameters
    p_year  : gjahr,
    p_month : poper
  as select from    ZI_SBDATA_0001 ( p_month: $parameters.p_month, p_year: $parameters.p_year ) as _Fidvf
    left outer join ZI_SBDATA_0001 ( p_month: $parameters.p_month, p_year: $parameters.p_year ) as _Fidbf 
                                             on  _Fidvf.AUFNR  = _Fidbf.AUFNR
                                            and _Fidvf.SPMON  = _Fidbf.SPMON
                                            and _Fidbf.KTOSL  = 'BSX'
                                            and _Fidbf.Mlptyp = 'BF'
{
  key    _Fidvf.SPMON      as SPMON,
  key    _Fidvf.AUFNR      as AUFNR,
  key    _Fidvf.MATNR      as FMATNR,
  key    _Fidvf.BWKEY      as FWERKS,
  key    _Fidvf.BWTAR      as FBWTAR,
  key    _Fidvf.KALNR      as FKALNR,
  key    _Fidvf.BKLAS      as FBKLAS,
  key    _Fidbf.MATNR      as TMATNR,
  key    _Fidbf.BWKEY      as TWERKS,
  key    _Fidbf.BWTAR      as TBWTAR,
  key    _Fidbf.KALNR      as TKALNR,
  key    _Fidbf.BKLAS      as TBKLAS,
  cast( '' as abap.char(1)) as Gb,
         _Fidvf.MEINS      as FMEINS,
         _Fidvf.RHCUR      as FRHCUR,
         @Semantics.quantity.unitOfMeasure: 'FMEINS'
         sum( case when _Fidvf.SHKZG = 'S' then _Fidvf.MENGE * -1
              else _Fidvf.MENGE
              end )        as FMENGE,
         @Semantics.amount.currencyCode: 'FRHCUR'
         sum( _Fidvf.HSL ) as FHSL,
         _Fidbf.MEINS      as TMEINS,
         _Fidbf.RHCUR      as TRHCUR,
         @Semantics.quantity.unitOfMeasure: 'TMEINS'
         sum( case when _Fidbf.SHKZG = 'H' then _Fidbf.MENGE * -1
             else _Fidbf.MENGE
             end )         as TMENGE,
         @Semantics.amount.currencyCode: 'TRHCUR'
         sum( _Fidbf.HSL ) as THSL
}
where
      _Fidvf.AWTYP  = 'MKPF'
  and _Fidvf.KTOSL  = 'BSX'
  and _Fidvf.Mlptyp = 'VF'

group by
  _Fidvf.SPMON,
  _Fidvf.AUFNR,
  _Fidvf.MATNR,
  _Fidvf.BWKEY,
  _Fidvf.BWTAR,
  _Fidvf.KALNR,
  _Fidvf.BKLAS,
  _Fidvf.MEINS,
  _Fidvf.RHCUR,
  _Fidbf.MATNR,
  _Fidbf.BWKEY,
  _Fidbf.BWTAR,
  _Fidbf.KALNR,
  _Fidbf.BKLAS,
  _Fidbf.MEINS,
  _Fidbf.RHCUR

  union all 
  select from    ZI_SBDATA_0001( p_month: $parameters.p_month, p_year: $parameters.p_year ) as _Fidvf
    left outer join ZI_SBDATA_0004 as _Fidbf 
                                             on  _Fidvf.AUFNR  = _Fidbf.AUFNR
                                            and _Fidvf.SPMON  = _Fidbf.SPMON
                                            and _Fidbf.KTOSL  = 'PRD'
                                            and _Fidbf.Mlptyp = 'BF'
{
  key    _Fidvf.SPMON      as SPMON,
  key    _Fidvf.AUFNR      as AUFNR,
  key    _Fidvf.MATNR      as FMATNR,
  key    _Fidvf.BWKEY      as FWERKS,
  key    _Fidvf.BWTAR      as FBWTAR,
  key    _Fidvf.KALNR      as FKALNR,
  key    _Fidvf.BKLAS      as FBKLAS,
  key    _Fidbf.MATNR      as TMATNR,
  key    _Fidbf.BWKEY      as TWERKS,
  key    _Fidbf.BWTAR      as TBWTAR,
  key    _Fidbf.KALNR      as TKALNR,
  key    _Fidbf.BKLAS      as TBKLAS,
  cast( 'X' as abap.char(1)) as Gb,
         _Fidvf.MEINS      as FMEINS,
         _Fidvf.RHCUR      as FRHCUR,
         sum( case when _Fidvf.SHKZG = 'S' then _Fidvf.MENGE * -1
              else _Fidvf.MENGE
              end )        as FMENGE,
         sum( _Fidvf.HSL ) as FHSL,
         _Fidbf.MEINS      as TMEINS,
         _Fidbf.WAERS      as TRHCUR,
         cast('0' as abap.dec(20,3))        as TMENGE,
         sum( _Fidbf.HSL ) as THSL
}
where
      _Fidvf.AWTYP  = 'MKPF'
  and _Fidvf.KTOSL  = 'BSX'
  and _Fidvf.Mlptyp = 'VF'

group by
  _Fidvf.SPMON,
  _Fidvf.AUFNR,
  _Fidvf.MATNR,
  _Fidvf.BWKEY,
  _Fidvf.BWTAR,
  _Fidvf.KALNR,
  _Fidvf.BKLAS,
  _Fidvf.MEINS,
  _Fidvf.RHCUR,
  _Fidbf.MATNR,
  _Fidbf.BWKEY,
  _Fidbf.BWTAR,
  _Fidbf.KALNR,
  _Fidbf.BKLAS,
  _Fidbf.MEINS,
  _Fidbf.WAERS
  
