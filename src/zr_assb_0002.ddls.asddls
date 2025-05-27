@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '[SB] 재무기준 월 수불'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZR_ASSB_0002 as select from zassbt0002 as _sb
    join         I_ProductValuationBasic as _mbew on _sb.kalnr = _mbew.ProdCostEstNumber
    join         I_Product               as _mara on _mbew.Product = _mara.Product
  association [1..1] to I_ProductText   as _makt on  _mbew.Product  = _makt.Product
                                                 and _makt.Language = '3'
  association [0..1] to zassbt0010      as _set  on  _mbew.ValuationClass = _set.bklas
                                                 and _mbew.ValuationArea  = _set.werks
                                                 and _sb.zsfld            = _set.zsfld
  association [1..1] to I_GLAccountText as _Glt  on  _sb.racct     = _Glt.GLAccount
                                                 and _Glt.Language = '3'
{
  key _sb.uuid            as UUID,
      @EndUserText.label: '년월'
      _sb.spmon           as Spmon,
      @EndUserText.label: '원가번호'
      _sb.kalnr           as Kalnr,
      @EndUserText.label: '자재번호'
      _sb.matnr           as Matnr,
      @EndUserText.label: '자재명'
      _makt.ProductName   as maktx,
      @EndUserText.label: '평가유형'
      _mbew.ValuationType as Bwtar,
      @EndUserText.label: '플랜트'
      _sb.bwkey           as Bwkey,
      @EndUserText.label: '평가클래스'
      _sb.bklas           as Bklas,
      @EndUserText.label: '자재유형'
      _mara.ProductType   as Mtart,
      @EndUserText.label: '자재그룹'
      _mara.ProductGroup  as Matkl,
      @EndUserText.label: '항목'
      _sb.zsfld           as Zsfld,
      @EndUserText.label: '항목명'
      _set.fieldname      as Zsfldt,
      @EndUserText.label: '계정번호'
      _sb.racct           as Racct,
      @EndUserText.label: '계정명'
      _Glt.GLAccountLongName  as Racctt,
      @EndUserText.label: '트랜젝션타입'
      _sb.ktosl           as Ktosl,
      @EndUserText.label: '참조정보'
      _sb.reftxt          as Reftxt,

      @EndUserText.label: '단위'
      _mbew.BaseUnit      as Meins,
      @EndUserText.label: '통화'
      _mbew.Currency      as Waers,

      @Semantics.quantity.unitOfMeasure: 'meins'
      @EndUserText.label: '수량'
      _sb.menge           as Menge,

      @EndUserText.label: '원가금액'
      _sb.dmbtr           as Dmbtr,
      @EndUserText.label: '차이금액'
      _sb.dmbtr1          as Dmbtr1,
      @EndUserText.label: '실제금액'
      _sb.dmbtr2          as Dmbtr2,
      @EndUserText.label: '계정금액'
      _sb.dmbtr3          as Dmbtr3

}
where _sb.ktosl <> 'WRX'
  and _sb.ktosl <> 'PK1'
  and _sb.ktosl <> 'PK2'
