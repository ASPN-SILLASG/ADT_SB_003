@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '[SB] 자재원장결산 데이터'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_SBDATA_0003
  as select distinct from I_JournalEntryItem      as _Fidoc
    join                  I_Product               as _Mara on _Fidoc.Product = _Mara.Product
    join                  I_ProductValuationBasic as _Mbew on  _Fidoc.Product                = _Mbew.Product
                                                           and _Fidoc.ValuationArea          = _Mbew.ValuationArea
                                                           and _Fidoc.InventoryValuationType = _Mbew.ValuationType

  /*소비재평가*/
    left outer join       I_JournalEntryItem      as _Vn1  on  _Fidoc.ReferenceDocumentType             = _Vn1.ReferenceDocumentType
                                                           and _Fidoc.ReferenceDocument                 = _Vn1.ReferenceDocument
                                                           and _Fidoc.ReferenceDocumentContext          = _Vn1.ReferenceDocumentContext
                                                           and _Fidoc.ReferenceDocumentItem             = _Vn1.ReferenceDocumentItem
                                                           and _Fidoc.ReferenceDocumentItemGroup        = _Vn1.ReferenceDocumentItemGroup
                                                           and (
                                                              (
                                                                'VNPRD'                                 = left(
                                                                  _Fidoc.DocumentItemText, 5
                                                                )
                                                                and _Fidoc.TransactionTypeDetermination = 'PRY'
                                                              )
                                                              or(
                                                                'VNKDM'                                 = left(
                                                                  _Fidoc.DocumentItemText, 5
                                                                )
                                                                and _Fidoc.TransactionTypeDetermination = 'KDM'
                                                              )
                                                            )
                                                           and 'VERBR'                                  = left(
      _Vn1.DocumentItemText, 5
    )
                                                           and _Fidoc.Product                           = _Vn1.Product
  /*상위롤업*/
    left outer join       I_JournalEntryItem      as _Vn2  on  _Fidoc.ReferenceDocumentType             =  _Vn2.ReferenceDocumentType
                                                           and _Fidoc.ReferenceDocument                 =  _Vn2.ReferenceDocument
                                                           and _Fidoc.ReferenceDocumentContext          =  _Vn2.ReferenceDocumentContext
                                                           and _Fidoc.ReferenceDocumentItem             <> _Vn2.ReferenceDocumentItem
                                                           and _Fidoc.ReferenceDocumentItemGroup        =  _Vn2.ReferenceDocumentItemGroup
                                                           and (
                                                              (
                                                                'VNPRD'                                 = left(
                                                                  _Fidoc.DocumentItemText, 5
                                                                )
                                                                and 'ZUPRV'                             = left(
                                                                  _Vn2.DocumentItemText, 5
                                                                )
                                                                and _Fidoc.TransactionTypeDetermination =  'PRY'
                                                              )
                                                              or(
                                                                'VNPRD'                                 = left(
                                                                  _Fidoc.DocumentItemText, 5
                                                                )
                                                                and 'ZUKDV'                             = left(
                                                                  _Vn2.DocumentItemText, 5
                                                                )
                                                                and _Fidoc.TransactionTypeDetermination =  'KDM'
                                                              )
                                                            )

  /*하위롤업*/
    left outer join       I_JournalEntryItem      as _Vn3  on  _Fidoc.ReferenceDocumentType             =  _Vn3.ReferenceDocumentType
                                                           and _Fidoc.ReferenceDocument                 =  _Vn3.ReferenceDocument
                                                           and _Fidoc.ReferenceDocumentContext          =  _Vn3.ReferenceDocumentContext
                                                           and _Fidoc.ReferenceDocumentItem             <> _Vn3.ReferenceDocumentItem
                                                           and _Fidoc.ReferenceDocumentItemGroup        =  _Vn3.ReferenceDocumentItemGroup
                                                           and (
                                                              (
                                                                'ZUPRV'                                 = left(
                                                                  _Fidoc.DocumentItemText, 5
                                                                )
                                                                and 'VNPRD'                             = left(
                                                                  _Vn3.DocumentItemText, 5
                                                                )
                                                                and _Fidoc.TransactionTypeDetermination =  'PRY'
                                                              )
                                                              or(
                                                                'ZUKDV'                                 = left(
                                                                  _Fidoc.DocumentItemText, 5
                                                                )
                                                                and 'VNPRD'                             = left(
                                                                  _Vn3.DocumentItemText, 5
                                                                )
                                                                and _Fidoc.TransactionTypeDetermination =  'KDM'
                                                              )
                                                            )
  /*엑티비티*/
    left outer join       I_JournalEntryItem      as _Vn4  on  _Fidoc.ReferenceDocumentType      =  _Vn4.ReferenceDocumentType
                                                           and _Fidoc.ReferenceDocument          =  _Vn4.ReferenceDocument
                                                           and _Fidoc.ReferenceDocumentContext   =  _Vn4.ReferenceDocumentContext
                                                           and _Fidoc.ReferenceDocumentItem      <> _Vn4.ReferenceDocumentItem
                                                           and _Fidoc.ReferenceDocumentItemGroup =  _Vn4.ReferenceDocumentItemGroup
                                                           and ( ( 'ZUPRV: 투입'                           = left( _Fidoc.DocumentItemText, 9 )
                                                                and 'GBBAUI'                       = left( _Vn4.DocumentItemText, 6 ) ) 
                                                              or ( 'ZUPRV: WIP'                       = left( _Fidoc.DocumentItemText, 10 )
                                                                and 'GBWIP: WIP'                       = left( _Vn4.DocumentItemText, 10 ) ) ) 
  /*WIP소비재평가*/
    left outer join       I_JournalEntryItem      as _Vn5  on  _Fidoc.ReferenceDocumentType             = _Vn5.ReferenceDocumentType
                                                           and _Fidoc.ReferenceDocument                 = _Vn5.ReferenceDocument
                                                           and _Fidoc.ReferenceDocumentContext          = _Vn5.ReferenceDocumentContext
                                                           and _Fidoc.ReferenceDocumentItem             = _Vn5.ReferenceDocumentItem
                                                           and _Fidoc.ReferenceDocumentItemGroup        = _Vn5.ReferenceDocumentItemGroup
                                                           and (
                                                              (
                                                                'VNPRD'                                 = left(
                                                                  _Fidoc.DocumentItemText, 5
                                                                )
                                                                and _Fidoc.TransactionTypeDetermination = 'PRY'
                                                              )
                                                              or(
                                                                'VNKDM'                                 = left(
                                                                  _Fidoc.DocumentItemText, 5
                                                                )
                                                                and _Fidoc.TransactionTypeDetermination = 'KDM'
                                                              )
                                                            )
                                                           and 'ZUWIP'                                  = left(
      _Vn5.DocumentItemText, 5
    )
                                                           and _Fidoc.Product                           = _Vn5.Product
                                                           and _Vn5.TransactionTypeDetermination        = 'WPM'

{
  key _Fidoc.AccountingDocument                       as Belnr,
  key _Fidoc.LedgerGLLineItem                         as Docln,
  key _Fidoc.FiscalYear                               as Gjahr,
  key _Fidoc.CompanyCode                              as Bukrs,
      concat(_Fidoc.FiscalYear, _Fidoc.FiscalPeriod ) as SPMON,
      _Fidoc.PostingDate                              as BUDAT,
      _Fidoc.CostEstimate                             as KALNR,
      _Fidoc.Product                                  as MATNR,
      _Fidoc.Plant                                    as WERKS,
      _Mbew.ValuationArea                             as BWKEY,
      _Mbew.ValuationClass                            as BKLAS,
      _Fidoc.InventoryValuationType                   as BWTAR,
      _Mara.ProductType                               as MTART,
      _Mara.ProductGroup                              as MATKL,
      _Fidoc.InventorySpclStkSalesDocument            as SPSO,
      _Fidoc.InventorySpclStkSalesDocItm              as SPSOI,
      _Fidoc.InvtrySpclStockWBSElmntIntID             as SPWBS,
      _Fidoc.InventorySpecialStockType                as SOBKZ,
      _Fidoc.GLAccount                                as RACCTA,
      _Fidoc.TransactionTypeDetermination             as KTOSL,
      cast(_Fidoc.ReferenceDocumentItem as abap.dec(6)) + 1  as uline,
      cast(_Fidoc.ReferenceDocumentItem as abap.dec(6)) - 1 as dline,
      _Fidoc.CompanyCodeCurrency                      as WAERS,
      _Mara.BaseUnit                                  as MEINS,
      _Fidoc.CompanyCodeCurrency                      as RHCUR,
      @Semantics: { amount : {currencyCode: 'WAERS'} }
      _Fidoc.AmountInCompanyCodeCurrency              as HSL,
      left( _Fidoc.DocumentItemText , 5 )             as TYP1,

      case when _Vn1.DocumentItemText is not initial then _Vn1.GLAccount
           when _Vn5.DocumentItemText is not initial then _Vn5.GLAccount
           when _Vn4.DocumentItemText is not initial then _Vn4.GLAccount
           when _Vn2.DocumentItemText is not initial then _Vn2.GLAccount
           when _Vn3.DocumentItemText is not initial then _Vn3.GLAccount
           else '' end                                as RACCT,
      case when _Vn1.DocumentItemText is not initial then _Vn1.TransactionTypeDetermination
           when _Vn5.DocumentItemText is not initial then _Vn5.TransactionTypeDetermination
           when _Vn4.DocumentItemText is not initial then _Vn4.TransactionTypeDetermination
           when _Vn2.DocumentItemText is not initial then _Vn2.TransactionTypeDetermination
           when _Vn3.DocumentItemText is not initial then _Vn3.TransactionTypeDetermination
           else '' end                                as KTOSL1,
      case when _Vn1.SalesDocument = ''
        then _Vn1.CostCenter else '' end              as RCNTR,
      _Vn1.SalesDocument                              as KDAUF,
      _Vn1.SalesDocumentItem                          as KDPOS,
      _Vn1.AccountAssignment                          as ACCAS,
      left( _Vn1.DocumentItemText , 5 )               as TYP2,

      case when $projection.TYP3 <> '' then _Vn2.CostEstimate
      else '000000000000' end                         as UMKAL,
      case when $projection.TYP3 <> '' then _Vn2.Product
      else '' end                                     as UMMAT,
      case when $projection.TYP3 <> '' then _Vn2.Plant
      else '' end                                     as UMWRK,
      case when $projection.TYP3 <> '' then _Vn2.InventoryValuationType
      else '' end                                     as UMBWT,
      case when $projection.TYP3 <> '' then _Vn2.InventorySpclStkSalesDocument
      else '' end                                     as UMSO,
      case when $projection.TYP3 <> '' then _Vn2.InventorySpclStkSalesDocItm
      else '000000' end                               as UMSOI,
      case when $projection.TYP3 <> '' then _Vn2.InvtrySpclStockWBSElmntIntID
      else '00000000' end                             as UMWBS,
      case when $projection.TYP3 <> '' then _Vn2.InventorySpecialStockType
      else '' end                                     as UMSOK,
      case when $projection.KTOSL1 = $projection.KTOSL 
                and _Fidoc.AmountInCompanyCodeCurrency * -1 = _Vn2.AmountInCompanyCodeCurrency
                and $projection.uline = cast(_Vn2.ReferenceDocumentItem as abap.dec(6))
                then left( _Vn2.DocumentItemText , 5 )
           else ''
           end                                        as TYP3,

      case when $projection.TYP4 <> '' then _Vn3.CostEstimate
      else '000000000000' end                         as ISKALNR,
      case when $projection.TYP4 <> '' then _Vn3.Product
      else '' end                                     as ISMATNR,
      case when $projection.TYP4 <> '' then _Vn3.Plant
      else '' end                                     as ISWERKS,
      case when $projection.TYP4 <> '' then _Vn3.InventoryValuationType
      else '' end                                     as ISBWTAR,
      case when $projection.TYP4 <> '' then _Vn3.InventorySpclStkSalesDocument
      else '' end                                     as ISSPSO,
      case when $projection.TYP4 <> '' then _Vn3.InventorySpclStkSalesDocItm
      else '000000' end                               as ISSPSOI,
      case when $projection.TYP4 <> '' then _Vn3.InvtrySpclStockWBSElmntIntID
      else '00000000' end                             as ISSPWBS,
      case when $projection.TYP4 <> '' then _Vn3.InventorySpecialStockType
      else '' end                                     as ISSOBKZ,
      case when $projection.KTOSL1 = $projection.KTOSL
                and _Fidoc.AmountInCompanyCodeCurrency * -1 = _Vn3.AmountInCompanyCodeCurrency
                and $projection.dline = cast(_Vn3.ReferenceDocumentItem as abap.dec(6)) 
                then left( _Vn3.DocumentItemText , 5 )
           else ''
           end                                        as TYP4,

      _Vn4.CostCtrActivityType                        as LSTAR,
      case when left( _Fidoc.DocumentItemText , 10 ) = 'ZUPRV: WIP' 
                and _Fidoc.AmountInCompanyCodeCurrency * -1 = _Vn4.AmountInCompanyCodeCurrency
                and $projection.dline = cast(_Vn4.ReferenceDocumentItem as abap.dec(6))
                then left( _Vn4.DocumentItemText , 5 )
           when left( _Fidoc.DocumentItemText , 9 ) = 'ZUPRV: 투입'
           then left( _Vn4.DocumentItemText , 5 )
           else ''
           end                as TYP5,
      case when $projection.KTOSL1 = 'WPM' then left( _Vn5.DocumentItemText , 5 )
           else ''
           end                                        as TYP6
}
where
       _Fidoc.ReferenceDocumentType        =  'MLHD'
  and(
       _Fidoc.TransactionTypeDetermination =  'PRD'
    or _Fidoc.TransactionTypeDetermination =  'PRY'
    or _Fidoc.TransactionTypeDetermination =  'KDM'
  )
  and  left(_Fidoc.DocumentItemText , 5)   <> 'EBPRD'
  and  left(_Fidoc.DocumentItemText , 5)   <> 'EBKDM'
  and  _Fidoc.Product                      <> ''
  and  _Fidoc.Ledger                       =  '0L'
  and  _Fidoc.IsReversal                   =  ''
  and  _Fidoc.IsReversed                   =  ''
