@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '[SB] 수불 업데이트'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZC_ASSB_0000 as projection on ZR_ASSB_0000
{
   @UI: {
          selectionField: [{ position: 10 }],
          lineItem: [{ position: 10 }, { type: #FOR_ACTION, dataAction: 'calc_value', label: '수불 업데이트' }]
       }
    key UUID,
    Spmon,
    Kalnr,
    Matnr,
    maktx,
    Bwkey,
    Bklas,
    Meins,
    Waers,
    f000m,
    f000a,
    f000d,
    f001m,
    f001a,
    f001d,
    f002m,
    f002a,
    f002d,
    f003m,
    f003a,
    f003d,
    f004m,
    f004a,
    f004d,
    f005m,
    f005a,
    f005d,
    f006m,
    f006a,
    f006d,
    f007m,
    f007a,
    f007d,
    f008m,
    f008a,
    f008d,
    f009m,
    f009a,
    f009d,
    f010m,
    f010a,
    f010d,
    f011m,
    f011a,
    f011d,
    f012m,
    f012a,
    f012d,
    f013m,
    f013a,
    f013d,
    f014m,
    f014a,
    f014d,
    f015m,
    f015a,
    f015d,
    f016m,
    f016a,
    f016d,
    f017m,
    f017a,
    f017d,
    f018m,
    f018a,
    f018d,
    f019m,
    f019a,
    f019d,
    f020m,
    f020a,
    f020d,
    f021m,
    f021a,
    f021d,
    f022m,
    f022a,
    f022d,
    f023m,
    f023a,
    f023d,
    f024m,
    f024a,
    f024d,
    f025m,
    f025a,
    f025d,
    f026m,
    f026a,
    f026d,
    f027m,
    f027a,
    f027d,
    f028m,
    f028a,
    f028d,
    f029m,
    f029a,
    f029d,
    f030m,
    f030a,
    f030d,
    f031m,
    f031a,
    f031d,
    f032m,
    f032a,
    f032d,
    f033m,
    f033a,
    f033d,
    f034m,
    f034a,
    f034d,
    f035m,
    f035a,
    f035d,
    f036m,
    f036a,
    f036d,
    f037m,
    f037a,
    f037d,
    f038m,
    f038a,
    f038d,
    f039m,
    f039a,
    f039d,
    f040m,
    f040a,
    f040d,
    f041m,
    f041a,
    f041d,
    f042m,
    f042a,
    f042d,
    f043m,
    f043a,
    f043d,
    f044m,
    f044a,
    f044d,
    f045m,
    f045a,
    f045d,
    f046m,
    f046a,
    f046d,
    f047m,
    f047a,
    f047d,
    f048m,
    f048a,
    f048d,
    f049m,
    f049a,
    f049d,
    f050m,
    f050a,
    f050d,
    f099m,
    f099a,
    f099d
}
