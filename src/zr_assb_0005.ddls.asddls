@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '[SB] 저장위치레벨 월 수불'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZR_ASSB_0005  as select from zassbt0005 as _sb
    join            I_ProductValuationBasic       as _mbew on  _sb.matnr = _mbew.Product
                                                           and _sb.bwkey = _mbew.ValuationArea
    join            I_Product                     as _mara on _mbew.Product = _mara.Product

    left outer join I_ProductStorageLocationBasic as _mard on  _sb.matnr = _mard.Product
                                                           and _sb.bwkey = _mard.Plant
                                                           and _sb.lgort = _mard.StorageLocation
  association [0..1] to I_ProductText        as _makt  on  _mbew.Product  = _makt.Product
                                                       and _makt.Language = '3'
  association [0..1] to I_ProductGroupText_2 as _Matkl on  $projection.Matkl = _Matkl.ProductGroup
                                                       and _Matkl.Language   = '3'
  association [0..1] to I_BusinessPartner    as _Lif   on  $projection.Lifnr = _Lif.BusinessPartner
  association [0..1] to I_BusinessPartner    as _Kur   on  $projection.Kunnr = _Kur.BusinessPartner
  association [0..1] to I_StorageLocation     as _Lgo   on  $projection.Lgort = _Lgo.StorageLocation
                                                        and $projection.bwkey = _Lgo.Plant
                                        
{
  key _sb.uuid                 as UUID,
      @EndUserText.label: '년월'
      _sb.spmon                as Spmon,
      @EndUserText.label: '원기추정번호'
      _sb.kalnr                as Kalnr,
      @ObjectModel.text.element: ['maktx']
      @EndUserText.label: '자재번호'
      _sb.matnr                as Matnr,
      @EndUserText.label: '평가유형'
      _sb.bwkey                as bwkey,
      @EndUserText.label: '평가클래스'
      _sb.bklas                as bklas,
      @ObjectModel.text.element: ['Lgortt']
      @EndUserText.label: '저장위치'
      _sb.lgort                as Lgort,
      @ObjectModel.text.element: ['Lifnrt']
      @EndUserText.label: '공급업체'
      _sb.lifnr                as Lifnr,
      @ObjectModel.text.element: ['Kunnrt']
      @EndUserText.label: '고객'
      _sb.kunnr                as Kunnr,
      @EndUserText.label: '특별재고'
      _sb.sobkz                as Sobkz,

      @EndUserText.label: '자재명'
      _makt.ProductName        as maktx,
      @EndUserText.label: '저장위치명'
      _Lgo.StorageLocationName as Lgortt,
      @EndUserText.label: '자재유형'
      _mara.ProductType        as Mtart,
      @EndUserText.label: '공급업체명'
      _Lif.BusinessPartnerName as Lifnrt,
      @EndUserText.label: '고객명'
      _Kur.BusinessPartnerName as Kunnrt,
      @ObjectModel.text.element: ['Matklt']
      @EndUserText.label: '자재그룹'
      _mara.ProductGroup       as Matkl,
      @EndUserText.label: '자재그룹명'
      _Matkl.ProductGroupText  as Matklt,
      @EndUserText.label: '단위'
      _mbew.BaseUnit           as Meins,
      @EndUserText.label: '통화'
      _mbew.Currency           as Waers,

      @Semantics.quantity.unitOfMeasure: 'meins'
      _sb.f000m,

      _sb.f000a,

      _sb.f000d,
      @Semantics.quantity.unitOfMeasure: 'meins'

      _sb.f001m,

      _sb.f001a,

      _sb.f001d,
      @Semantics.quantity.unitOfMeasure: 'meins'
      _sb.f002m,
      _sb.f002a,
      _sb.f002d,
      @Semantics.quantity.unitOfMeasure: 'meins'
      _sb.f003m,
      _sb.f003a,
      _sb.f003d,
      @Semantics.quantity.unitOfMeasure: 'meins'
      _sb.f004m,
      _sb.f004a,
      _sb.f004d,
      @Semantics.quantity.unitOfMeasure: 'meins'
      _sb.f005m,
      _sb.f005a,
      _sb.f005d,
      @Semantics.quantity.unitOfMeasure: 'meins'
      _sb.f006m,
      _sb.f006a,
      _sb.f006d,
      @Semantics.quantity.unitOfMeasure: 'meins'
      _sb.f007m,
      _sb.f007a,
      _sb.f007d,
      @Semantics.quantity.unitOfMeasure: 'meins'
      _sb.f008m,
      _sb.f008a,
      _sb.f008d,
      @Semantics.quantity.unitOfMeasure: 'meins'
      _sb.f009m,
      _sb.f009a,
      _sb.f009d,
      @Semantics.quantity.unitOfMeasure: 'meins'
      _sb.f010m,
      _sb.f010a,
      _sb.f010d,
      @Semantics.quantity.unitOfMeasure: 'meins'
      _sb.f011m,
      _sb.f011a,
      _sb.f011d,
      @Semantics.quantity.unitOfMeasure: 'meins'
      _sb.f012m,
      _sb.f012a,
      _sb.f012d,
      @Semantics.quantity.unitOfMeasure: 'meins'
      _sb.f013m,
      _sb.f013a,
      _sb.f013d,
      @Semantics.quantity.unitOfMeasure: 'meins'
      _sb.f014m,
      _sb.f014a,
      _sb.f014d,
      @Semantics.quantity.unitOfMeasure: 'meins'
      _sb.f015m,
      _sb.f015a,
      _sb.f015d,
      @Semantics.quantity.unitOfMeasure: 'meins'
      _sb.f016m,
      _sb.f016a,
      _sb.f016d,
      @Semantics.quantity.unitOfMeasure: 'meins'
      _sb.f017m,
      _sb.f017a,
      _sb.f017d,
      @Semantics.quantity.unitOfMeasure: 'meins'
      _sb.f018m,
      _sb.f018a,
      _sb.f018d,
      @Semantics.quantity.unitOfMeasure: 'meins'
      _sb.f019m,
      _sb.f019a,
      _sb.f019d,
      @Semantics.quantity.unitOfMeasure: 'meins'
      _sb.f020m,
      _sb.f020a,
      _sb.f020d,
      @Semantics.quantity.unitOfMeasure: 'meins'
      _sb.f021m,
      _sb.f021a,
      _sb.f021d,
      @Semantics.quantity.unitOfMeasure: 'meins'
      _sb.f022m,
      _sb.f022a,
      _sb.f022d,
      @Semantics.quantity.unitOfMeasure: 'meins'
      _sb.f023m,
      _sb.f023a,
      _sb.f023d,
      @Semantics.quantity.unitOfMeasure: 'meins'
      _sb.f024m,
      _sb.f024a,
      _sb.f024d,
      @Semantics.quantity.unitOfMeasure: 'meins'
      _sb.f025m,
      _sb.f025a,
      _sb.f025d,
      @Semantics.quantity.unitOfMeasure: 'meins'
      _sb.f026m,
      _sb.f026a,
      _sb.f026d,
      @Semantics.quantity.unitOfMeasure: 'meins'
      _sb.f027m,
      _sb.f027a,
      _sb.f027d,
      @Semantics.quantity.unitOfMeasure: 'meins'
      _sb.f028m,
      _sb.f028a,
      _sb.f028d,
      @Semantics.quantity.unitOfMeasure: 'meins'
      _sb.f029m,
      _sb.f029a,
      _sb.f029d,
      @Semantics.quantity.unitOfMeasure: 'meins'
      _sb.f030m,
      _sb.f030a,
      _sb.f030d,
      @Semantics.quantity.unitOfMeasure: 'meins'
      _sb.f031m,
      _sb.f031a,
      _sb.f031d,
      @Semantics.quantity.unitOfMeasure: 'meins'
      _sb.f032m,
      _sb.f032a,
      _sb.f032d,
      @Semantics.quantity.unitOfMeasure: 'meins'
      _sb.f033m,
      _sb.f033a,
      _sb.f033d,
      @Semantics.quantity.unitOfMeasure: 'meins'
      _sb.f034m,
      _sb.f034a,
      _sb.f034d,
      @Semantics.quantity.unitOfMeasure: 'meins'
      _sb.f035m,
      _sb.f035a,
      _sb.f035d,
      @Semantics.quantity.unitOfMeasure: 'meins'
      _sb.f036m,
      _sb.f036a,
      _sb.f036d,
      @Semantics.quantity.unitOfMeasure: 'meins'
      _sb.f037m,
      _sb.f037a,
      _sb.f037d,
      @Semantics.quantity.unitOfMeasure: 'meins'
      _sb.f038m,
      _sb.f038a,
      _sb.f038d,
      @Semantics.quantity.unitOfMeasure: 'meins'
      _sb.f039m,
      _sb.f039a,
      _sb.f039d,
      @Semantics.quantity.unitOfMeasure: 'meins'
      _sb.f040m,
      _sb.f040a,
      _sb.f040d,
      @Semantics.quantity.unitOfMeasure: 'meins'
      _sb.f041m,
      _sb.f041a,
      _sb.f041d,
      @Semantics.quantity.unitOfMeasure: 'meins'
      _sb.f042m,
      _sb.f042a,
      _sb.f042d,
      @Semantics.quantity.unitOfMeasure: 'meins'
      _sb.f043m,
      _sb.f043a,
      _sb.f043d,
      @Semantics.quantity.unitOfMeasure: 'meins'
      _sb.f044m,
      _sb.f044a,
      _sb.f044d,
      @Semantics.quantity.unitOfMeasure: 'meins'
      _sb.f045m,
      _sb.f045a,
      _sb.f045d,
      @Semantics.quantity.unitOfMeasure: 'meins'
      _sb.f046m,
      _sb.f046a,
      _sb.f046d,
      @Semantics.quantity.unitOfMeasure: 'meins'
      _sb.f047m,
      _sb.f047a,
      _sb.f047d,
      @Semantics.quantity.unitOfMeasure: 'meins'
      _sb.f048m,
      _sb.f048a,
      _sb.f048d,
      @Semantics.quantity.unitOfMeasure: 'meins'
      _sb.f049m,
      _sb.f049a,
      _sb.f049d,
      @Semantics.quantity.unitOfMeasure: 'meins'
      _sb.f050m,
      _sb.f050a,
      _sb.f050d,
      @Semantics.quantity.unitOfMeasure: 'meins'
      _sb.f099m,
      _sb.f099a,
      _sb.f099d

}
where
     _sb.f000m <> 0
  or _sb.f001m <> 0
  or _sb.f002m <> 0
  or _sb.f003m <> 0
  or _sb.f004m <> 0
  or _sb.f005m <> 0
  or _sb.f006m <> 0
  or _sb.f007m <> 0
  or _sb.f008m <> 0
  or _sb.f009m <> 0
  or _sb.f010m <> 0
  or _sb.f011m <> 0
  or _sb.f012m <> 0
  or _sb.f013m <> 0
  or _sb.f014m <> 0
  or _sb.f015m <> 0
  or _sb.f016m <> 0
  or _sb.f017m <> 0
  or _sb.f018m <> 0
  or _sb.f019m <> 0
  or _sb.f020m <> 0
  or _sb.f021m <> 0
  or _sb.f022m <> 0
  or _sb.f023m <> 0
  or _sb.f024m <> 0
  or _sb.f025m <> 0
  or _sb.f026m <> 0
  or _sb.f027m <> 0
  or _sb.f028m <> 0
  or _sb.f029m <> 0
  or _sb.f030m <> 0
  or _sb.f031m <> 0
  or _sb.f032m <> 0
  or _sb.f033m <> 0
  or _sb.f034m <> 0
  or _sb.f035m <> 0
  or _sb.f036m <> 0
  or _sb.f037m <> 0
  or _sb.f038m <> 0
  or _sb.f039m <> 0
  or _sb.f040m <> 0
  or _sb.f041m <> 0
  or _sb.f042m <> 0
  or _sb.f043m <> 0
  or _sb.f044m <> 0
  or _sb.f045m <> 0
  or _sb.f046m <> 0
  or _sb.f047m <> 0
  or _sb.f048m <> 0
  or _sb.f049m <> 0
  or _sb.f050m <> 0
  or _sb.f099m <> 0
  or _sb.f000a <> 0
  or _sb.f001a <> 0
  or _sb.f002a <> 0
  or _sb.f003a <> 0
  or _sb.f004a <> 0
  or _sb.f005a <> 0
  or _sb.f006a <> 0
  or _sb.f007a <> 0
  or _sb.f008a <> 0
  or _sb.f009a <> 0
  or _sb.f010a <> 0
  or _sb.f011a <> 0
  or _sb.f012a <> 0
  or _sb.f013a <> 0
  or _sb.f014a <> 0
  or _sb.f015a <> 0
  or _sb.f016a <> 0
  or _sb.f017a <> 0
  or _sb.f018a <> 0
  or _sb.f019a <> 0
  or _sb.f020a <> 0
  or _sb.f021a <> 0
  or _sb.f022a <> 0
  or _sb.f023a <> 0
  or _sb.f024a <> 0
  or _sb.f025a <> 0
  or _sb.f026a <> 0
  or _sb.f027a <> 0
  or _sb.f028a <> 0
  or _sb.f029a <> 0
  or _sb.f030a <> 0
  or _sb.f031a <> 0
  or _sb.f032a <> 0
  or _sb.f033a <> 0
  or _sb.f034a <> 0
  or _sb.f035a <> 0
  or _sb.f036a <> 0
  or _sb.f037a <> 0
  or _sb.f038a <> 0
  or _sb.f039a <> 0
  or _sb.f040a <> 0
  or _sb.f041a <> 0
  or _sb.f042a <> 0
  or _sb.f043a <> 0
  or _sb.f044a <> 0
  or _sb.f045a <> 0
  or _sb.f046a <> 0
  or _sb.f047a <> 0
  or _sb.f048a <> 0
  or _sb.f049a <> 0
  or _sb.f050a <> 0
  or _sb.f099a <> 0
