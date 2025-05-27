CLASS lhc_subul DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PUBLIC SECTION.
    CLASS-DATA return_msg TYPE string.

  PRIVATE SECTION.
    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR subul RESULT result.

    METHODS calc_value FOR MODIFY
      IMPORTING keys FOR ACTION subul~calc_value RESULT result.

      "-[타입]----------------------------------------------------------------------------------
    "수불데이터 타입 정의
    TYPES ly_list TYPE ZR_ASSB_0000.
    TYPES ly_listd TYPE ZR_ASSB_0001.
    TYPES ly_listl TYPE ZR_ASSB_0005.
    TYPES ly_lista TYPE ZR_ASSB_0002.

    TYPES: BEGIN OF ly_kalnr,
             kalnr TYPE ZI_SBDATA_0001-kalnr,
             matnr TYPE ZI_SBDATA_0001-matnr,
             bwkey TYPE ZI_SBDATA_0001-bwkey,
             bklas TYPE ZI_SBDATA_0001-bklas,
             sobkz TYPE ZI_SBDATA_0001-sobkz,
             spso  TYPE ZI_SBDATA_0001-spso,
             spsoi TYPE ZI_SBDATA_0001-spsoi,
             spwbs TYPE ZI_SBDATA_0001-spwbs,
             bwtar TYPE ZI_SBDATA_0001-bwtar,
             meins TYPE ZI_SBDATA_0001-meins,
             waers TYPE ZI_SBDATA_0001-waers,
             spmon TYPE ZR_ASSB_0000-spmon,
           END OF ly_kalnr.

    "수불 차이 데이터 타입 정의
    TYPES ly_list4 TYPE zassbt0004.

    "소비재평가 배분을 위한 타입 정의
    TYPES: BEGIN OF ly_vn1,
             kalnr    TYPE ZI_SBDATA_0001-kalnr,
             spmon    TYPE ZI_SBDATA_0001-spmon,
             mgkont   TYPE ZI_SBDATA_0001-mgkont,
             coctl    TYPE ZI_SBDATA_0001-coctl,
             kdauf_im TYPE ZI_SBDATA_0001-kdauf,
             kdpos_im TYPE ZI_SBDATA_0001-kdpos,
             zsfld    TYPE c LENGTH 4,
             zsbgb    TYPE c LENGTH 1,
             menge    TYPE p LENGTH 16         DECIMALS 3,
             hsl      TYPE p LENGTH 16         DECIMALS 0,
           END OF ly_vn1.
    TYPES: BEGIN OF ly_vn2,
             kalnr    TYPE ZI_SBDATA_0001-kalnr,
             spmon    TYPE ZI_SBDATA_0001-spmon,
             mgkont   TYPE ZI_SBDATA_0001-mgkont,
             coctl    TYPE ZI_SBDATA_0001-coctl,
             kdauf_im TYPE ZI_SBDATA_0001-kdauf,
             kdpos_im TYPE ZI_SBDATA_0001-kdpos,
             menge    TYPE p LENGTH 16         DECIMALS 3,
             hsl      TYPE p LENGTH 16         DECIMALS 0,
           END OF ly_vn2.
    TYPES: BEGIN OF ly_vn3,
             kalnr    TYPE ZI_SBDATA_0001-kalnr,
             matnr    TYPE ZI_SBDATA_0001-matnr,
             werks    TYPE ZI_SBDATA_0001-werks,
             bklas    TYPE ZI_SBDATA_0001-bklas,
             lgort    TYPE ZI_SBDATA_0001-lgort,
             bwtar    TYPE ZI_SBDATA_0001-bwtar,
             spso     TYPE ZI_SBDATA_0001-spso,
             spsoi    TYPE ZI_SBDATA_0001-spsoi,
             spwbs    TYPE ZI_SBDATA_0001-spwbs,
             sobkz    TYPE ZI_SBDATA_0001-sobkz,
             spmon    TYPE ZI_SBDATA_0001-spmon,
             mgkont   TYPE ZI_SBDATA_0001-mgkont,
             coctl    TYPE ZI_SBDATA_0001-coctl,
             kdauf_im TYPE ZI_SBDATA_0001-kdauf,
             kdpos_im TYPE ZI_SBDATA_0001-kdpos,
             zsfld    TYPE c LENGTH 4,
             zsbgb    TYPE c LENGTH 1,
             menge    TYPE p LENGTH 16         DECIMALS 3,
             hsl      TYPE p LENGTH 16         DECIMALS 0,
           END OF ly_vn3.
    "소비재평가(판매 반품) 배분을 위한 타입 정의
    TYPES: BEGIN OF ly_vnr1,
             kalnr  TYPE ZI_SBDATA_0001-kalnr,
             spmon  TYPE ZI_SBDATA_0001-spmon,
             mgkont TYPE ZI_SBDATA_0001-mgkont,
             zsfld  TYPE c LENGTH 4,
             zsbgb  TYPE c LENGTH 1,
             menge  TYPE p LENGTH 16         DECIMALS 3,
             hsl    TYPE p LENGTH 16         DECIMALS 0,
           END OF ly_vnr1.
    TYPES: BEGIN OF ly_vnr2,
             kalnr  TYPE ZI_SBDATA_0001-kalnr,
             spmon  TYPE ZI_SBDATA_0001-spmon,
             mgkont TYPE ZI_SBDATA_0001-mgkont,
             menge  TYPE p LENGTH 16         DECIMALS 3,
             hsl    TYPE p LENGTH 16         DECIMALS 0,
           END OF ly_vnr2.
    TYPES: BEGIN OF ly_vnr3,
             kalnr  TYPE ZI_SBDATA_0001-kalnr,
             matnr  TYPE ZI_SBDATA_0001-matnr,
             werks  TYPE ZI_SBDATA_0001-werks,
             bklas  TYPE ZI_SBDATA_0001-bklas,
             lgort  TYPE ZI_SBDATA_0001-lgort,
             bwtar  TYPE ZI_SBDATA_0001-bwtar,
             spso   TYPE ZI_SBDATA_0001-spso,
             spsoi  TYPE ZI_SBDATA_0001-spsoi,
             spwbs  TYPE ZI_SBDATA_0001-spwbs,
             sobkz  TYPE ZI_SBDATA_0001-sobkz,
             spmon  TYPE ZI_SBDATA_0001-spmon,
             mgkont TYPE ZI_SBDATA_0001-mgkont,
             zsfld  TYPE c LENGTH 4,
             zsbgb  TYPE c LENGTH 1,
             menge  TYPE p LENGTH 16         DECIMALS 3,
             hsl    TYPE p LENGTH 16         DECIMALS 0,
           END OF ly_vnr3.
    "상위자재로 차이할당 배분을 위한 타입 정의
    TYPES: BEGIN OF ly_tri1,
             kalnr TYPE ZI_SBDATA_0001-kalnr,
             umkal TYPE ZI_SBDATA_0001-kalnr,
             spmon TYPE ZI_SBDATA_0001-spmon,
             zsfld TYPE c LENGTH 4,
             zsbgb TYPE c LENGTH 1,
             menge TYPE p LENGTH 16         DECIMALS 3,
             hsl   TYPE p LENGTH 16         DECIMALS 0,
           END OF ly_tri1.
    TYPES: BEGIN OF ly_tri2,
             kalnr TYPE ZI_SBDATA_0001-kalnr,
             umkal TYPE ZI_SBDATA_0001-kalnr,
             spmon TYPE ZI_SBDATA_0001-spmon,
             menge TYPE p LENGTH 16         DECIMALS 3,
             hsl   TYPE p LENGTH 16         DECIMALS 0,
           END OF ly_tri2.
    TYPES: BEGIN OF ly_tri3,
             kalnr TYPE ZI_SBDATA_0001-kalnr,
             matnr TYPE ZI_SBDATA_0001-matnr,
             werks TYPE ZI_SBDATA_0001-werks,
             bklas TYPE ZI_SBDATA_0001-bklas,
             lgort TYPE ZI_SBDATA_0001-lgort,
             bwtar TYPE ZI_SBDATA_0001-bwtar,
             spso  TYPE ZI_SBDATA_0001-spso,
             spsoi TYPE ZI_SBDATA_0001-spsoi,
             spwbs TYPE ZI_SBDATA_0001-spwbs,
             sobkz TYPE ZI_SBDATA_0001-sobkz,
             umkal TYPE ZI_SBDATA_0001-kalnr,
             ummat TYPE ZI_SBDATA_0001-matnr,
             umwrk TYPE ZI_SBDATA_0001-werks,
             umlgo TYPE ZI_SBDATA_0001-lgort,
             umso  TYPE ZI_SBDATA_0001-spso,
             umsoi TYPE ZI_SBDATA_0001-spsoi,
             umwbs TYPE ZI_SBDATA_0001-spwbs,
             umsok TYPE ZI_SBDATA_0001-sobkz,
             spmon TYPE ZI_SBDATA_0001-spmon,
             zsfld TYPE c LENGTH 4,
             zsbgb TYPE c LENGTH 1,
             menge TYPE p LENGTH 16         DECIMALS 3,
             hsl   TYPE p LENGTH 16         DECIMALS 0,
           END OF ly_tri3.

    TYPES: BEGIN OF ly_triwv,
             aufnr TYPE ZI_SBDATA_0001-aufnr,
             kalnr TYPE ZI_SBDATA_0001-kalnr,
             matnr TYPE ZI_SBDATA_0001-matnr,
             werks TYPE ZI_SBDATA_0001-werks,
             bklas TYPE ZI_SBDATA_0001-bklas,
             lgort TYPE ZI_SBDATA_0001-lgort,
             bwtar TYPE ZI_SBDATA_0001-bwtar,
             spso  TYPE ZI_SBDATA_0001-spso,
             spsoi TYPE ZI_SBDATA_0001-spsoi,
             spwbs TYPE ZI_SBDATA_0001-spwbs,
             sobkz TYPE ZI_SBDATA_0001-sobkz,
             umkal TYPE ZI_SBDATA_0001-kalnr,
             ummat TYPE ZI_SBDATA_0001-matnr,
             umwrk TYPE ZI_SBDATA_0001-werks,
             umlgo TYPE ZI_SBDATA_0001-lgort,
             umso  TYPE ZI_SBDATA_0001-spso,
             umsoi TYPE ZI_SBDATA_0001-spsoi,
             umwbs TYPE ZI_SBDATA_0001-spwbs,
             umsok TYPE ZI_SBDATA_0001-sobkz,
             spmon TYPE ZI_SBDATA_0001-spmon,
             zsfld TYPE c LENGTH 4,
             zsbgb TYPE c LENGTH 1,
             menge TYPE p LENGTH 16         DECIMALS 3,
             hsl   TYPE p LENGTH 16         DECIMALS 0,
           END OF ly_triwv.
    "외주입고 하위자재로부터 차이할당 배분을 위한 타입 정의
    TYPES: BEGIN OF ly_bl1,
             ebeln  TYPE ZI_SBDATA_0001-ebeln,
             ebelp  TYPE ZI_SBDATA_0001-ebelp,
             kalnr  TYPE ZI_SBDATA_0001-kalnr,
             spmon  TYPE ZI_SBDATA_0001-spmon,
             mlptyp TYPE ZI_SBDATA_0001-mlptyp,
             zsfld  TYPE c LENGTH 4,
             zsbgb  TYPE c LENGTH 1,
             menge  TYPE p LENGTH 16         DECIMALS 3,
             hsl    TYPE p LENGTH 16         DECIMALS 0,
           END OF ly_bl1.
    TYPES: BEGIN OF ly_bl2,
             ebeln TYPE ZI_SBDATA_0001-ebeln,
             ebelp TYPE ZI_SBDATA_0001-ebelp,
             kalnr TYPE ZI_SBDATA_0001-kalnr,
             spmon TYPE ZI_SBDATA_0001-spmon,
             menge TYPE p LENGTH 16         DECIMALS 3,
             hsl   TYPE p LENGTH 16         DECIMALS 0,
           END OF ly_bl2.
    TYPES: BEGIN OF ly_bl3,
             ebeln  TYPE ZI_SBDATA_0001-ebeln,
             ebelp  TYPE ZI_SBDATA_0001-ebelp,
             kalnr  TYPE ZI_SBDATA_0001-kalnr,
             matnr  TYPE ZI_SBDATA_0001-matnr,
             werks  TYPE ZI_SBDATA_0001-werks,
             bklas  TYPE ZI_SBDATA_0001-bklas,
             lgort  TYPE ZI_SBDATA_0001-lgort,
             bwtar  TYPE ZI_SBDATA_0001-bwtar,
             spso   TYPE ZI_SBDATA_0001-spso,
             spsoi  TYPE ZI_SBDATA_0001-spsoi,
             spwbs  TYPE ZI_SBDATA_0001-spwbs,
             sobkz  TYPE ZI_SBDATA_0001-sobkz,
             spmon  TYPE ZI_SBDATA_0001-spmon,
             mlptyp TYPE ZI_SBDATA_0001-mlptyp,
             zsfld  TYPE c LENGTH 4,
             zsbgb  TYPE c LENGTH 1,
             menge  TYPE p LENGTH 16         DECIMALS 3,
             hsl    TYPE p LENGTH 16         DECIMALS 0,
           END OF ly_bl3.

    "생산 입출 차이 정보 배분을 위한 타입 정의
    TYPES: BEGIN OF ly_auak1,
             aufnr  TYPE ZI_SBDATA_0001-aufnr,
             kalnr  TYPE ZI_SBDATA_0001-kalnr,
             spmon  TYPE ZI_SBDATA_0001-spmon,
             mlptyp TYPE ZI_SBDATA_0001-mlptyp,
             zsfld  TYPE c LENGTH 4,
             zsbgb  TYPE c LENGTH 1,
             menge  TYPE p LENGTH 16         DECIMALS 3,
             hsl    TYPE p LENGTH 16         DECIMALS 0,
           END OF ly_auak1.
    TYPES: BEGIN OF ly_auak2,
             aufnr TYPE ZI_SBDATA_0001-aufnr,
             kalnr TYPE ZI_SBDATA_0001-kalnr,
             spmon TYPE ZI_SBDATA_0001-spmon,
             menge TYPE p LENGTH 16         DECIMALS 3,
             hsl   TYPE p LENGTH 16         DECIMALS 0,
           END OF ly_auak2.
    TYPES: BEGIN OF ly_auak3,
             aufnr  TYPE ZI_SBDATA_0001-aufnr,
             kalnr  TYPE ZI_SBDATA_0001-kalnr,
             matnr  TYPE ZI_SBDATA_0001-matnr,
             werks  TYPE ZI_SBDATA_0001-werks,
             bklas  TYPE ZI_SBDATA_0001-bklas,
             lgort  TYPE ZI_SBDATA_0001-lgort,
             bwtar  TYPE ZI_SBDATA_0001-bwtar,
             spso   TYPE ZI_SBDATA_0001-spso,
             spsoi  TYPE ZI_SBDATA_0001-spsoi,
             spwbs  TYPE ZI_SBDATA_0001-spwbs,
             sobkz  TYPE ZI_SBDATA_0001-sobkz,
             spmon  TYPE ZI_SBDATA_0001-spmon,
             mlptyp TYPE ZI_SBDATA_0001-mlptyp,
             zsfld  TYPE c LENGTH 4,
             zsbgb  TYPE c LENGTH 1,
             menge  TYPE p LENGTH 16         DECIMALS 3,
             hsl    TYPE p LENGTH 16         DECIMALS 0,
           END OF ly_auak3.
    "오더정산 header 데이터 취합
    TYPES: BEGIN OF ly_moh.
             INCLUDE TYPE i_mfgorderforextraction.
    TYPES: END OF ly_moh.
    "액티비티 배분을 위한 타입 정의
    TYPES: BEGIN OF ly_ac1,
             kalnr TYPE ZI_SBDATA_0001-kalnr,
             spmon TYPE ZI_SBDATA_0001-spmon,
             zsfld TYPE c LENGTH 4,
             zsbgb TYPE c LENGTH 1,
             menge TYPE p LENGTH 16         DECIMALS 3,
             hsl   TYPE p LENGTH 16         DECIMALS 0,
           END OF ly_ac1.
    TYPES: BEGIN OF ly_ac2,
             kalnr TYPE ZI_SBDATA_0001-kalnr,
             spmon TYPE ZI_SBDATA_0001-spmon,
             menge TYPE p LENGTH 16         DECIMALS 3,
             hsl   TYPE p LENGTH 16         DECIMALS 0,
           END OF ly_ac2.
    TYPES: BEGIN OF ly_ac3,
             kalnr TYPE ZI_SBDATA_0001-kalnr,
             matnr TYPE ZI_SBDATA_0001-matnr,
             werks TYPE ZI_SBDATA_0001-werks,
             bklas TYPE ZI_SBDATA_0001-bklas,
             lgort TYPE ZI_SBDATA_0001-lgort,
             bwtar TYPE ZI_SBDATA_0001-bwtar,
             spso  TYPE ZI_SBDATA_0001-spso,
             spsoi TYPE ZI_SBDATA_0001-spsoi,
             spwbs TYPE ZI_SBDATA_0001-spwbs,
             sobkz TYPE ZI_SBDATA_0001-sobkz,
             spmon TYPE ZI_SBDATA_0001-spmon,
             zsfld TYPE c LENGTH 4,
             zsbgb TYPE c LENGTH 1,
             menge TYPE p LENGTH 16         DECIMALS 3,
             hsl   TYPE p LENGTH 16         DECIMALS 0,
           END OF ly_ac3.
    "플랜트레벨 물류데이터 타입 정의
    TYPES: BEGIN OF ly_data.
             INCLUDE TYPE ZI_SBDATA_0001.
    TYPES:   zsfld TYPE c LENGTH 4.
    TYPES:   zsbgb TYPE c LENGTH 1.
    TYPES: END OF ly_data.
    "저장위치레벨 물류데이터 타입 정의
    TYPES: BEGIN OF ly_data_1.
             INCLUDE TYPE ZI_SBDATA_0001_01.
    TYPES:   zsfld TYPE c LENGTH 4.
    TYPES: END OF ly_data_1.
    "자재원장결산 데이터 타입 정의
    TYPES: BEGIN OF ly_data3.
             INCLUDE TYPE ZI_SBDATA_0003.
    TYPES:   danga TYPE p LENGTH 16 DECIMALS 5.
    TYPES:   mod TYPE p LENGTH 16 DECIMALS 0.
    TYPES:   modd TYPE p LENGTH 16 DECIMALS 0.
    TYPES:   modl TYPE p LENGTH 16 DECIMALS 0.
    TYPES: END OF ly_data3.
    "오더정산 데이터 타입 정의
    TYPES: BEGIN OF ly_data4.
             INCLUDE TYPE ZI_SBDATA_0004.
    TYPES:   danga TYPE p LENGTH 16 DECIMALS 5.
    TYPES:   mod TYPE p LENGTH 16 DECIMALS 0.
    TYPES:   modd TYPE p LENGTH 16 DECIMALS 0.
    TYPES:   modl TYPE p LENGTH 16 DECIMALS 0.
    TYPES: END OF ly_data4.
    "생산입고 하위품목출고 데이터 타입 정의
    TYPES: BEGIN OF ly_data5.
             INCLUDE TYPE ZI_SBDATA_0005.
    TYPES:   danga TYPE p LENGTH 16 DECIMALS 5.
    TYPES:   mod TYPE p LENGTH 16 DECIMALS 0.
    TYPES:   modd TYPE p LENGTH 16 DECIMALS 0.
    TYPES:   modl TYPE p LENGTH 16 DECIMALS 0.
    TYPES: END OF ly_data5.
    TYPES: ly_data5a TYPE ZI_SBDATA_0005_01.
    "외주입고 하위품목출고 데이터 타입 정의
    TYPES: BEGIN OF ly_data6.
             INCLUDE TYPE ZI_SBDATA_0006.
    TYPES:   danga TYPE p LENGTH 16 DECIMALS 5.
    TYPES:   mod TYPE p LENGTH 16 DECIMALS 0.
    TYPES:   modd TYPE p LENGTH 16 DECIMALS 0.
    TYPES:   modl TYPE p LENGTH 16 DECIMALS 0.
    TYPES: END OF ly_data6.
    TYPES: ly_data6a TYPE ZI_SBDATA_0006_01.
    "기간별 표준단가 데이터 타입 정의
    TYPES: BEGIN OF ly_data7.
             INCLUDE TYPE ZI_SBDATA_0007.
    TYPES: END OF ly_data7.
    "재무기준 데이터 타입 정의
    TYPES: BEGIN OF ly_data8,
             bklas  TYPE ZI_SBDATA_0001-bklas,
             bwkey  TYPE ZI_SBDATA_0001-bwkey,
             matnr  TYPE ZI_SBDATA_0001-matnr,
             bwtar  TYPE ZI_SBDATA_0001-bwtar,
             kalnr  TYPE ZI_SBDATA_0001-kalnr,
             meins  TYPE ZI_SBDATA_0001-meins,
             waers  TYPE ZI_SBDATA_0001-waers,
             dmbtr2 TYPE ZI_SBDATA_0001-hsl,
           END OF ly_data8.
    "플랜트레벨 기초기말데이터 타입 정의
    TYPES ly_data2 TYPE ZI_SBDATA_0002.
    "저장위치레벨 기초기말데이터 타입 정의
    TYPES ly_data2_1 TYPE ZI_SBDATA_0002_01.
    "수불구분 설정 데이터 타입 정의
    TYPES ly_0060  TYPE zassbt0010.
    "수불예외 설정 데이터 타입 정의
    TYPES: BEGIN OF ly_0080,
             werks  TYPE ZR_ASSB_0020-werks,
             bklas  TYPE ZR_ASSB_0020-bklas,
             zaexc  TYPE ZR_ASSB_0020-zaexc,
             zaexcp TYPE ZR_ASSB_0020-zaexcp,
             zfield TYPE ZR_ASSB_0020-zfield,
             zoptn  TYPE ZR_ASSB_0020-zoptn,
             zvalue TYPE ZR_ASSB_0020-zvalue,
             zsfld  TYPE ZR_ASSB_0020-zsfld,
           END OF ly_0080.
    TYPES: ly_0030 TYPE zassbt0030.
    "기간별 기초 기말 날짜계산을 위한 타입 정의
    TYPES: BEGIN OF ly_edate,
             spmon TYPE ZI_SBDATA_0001-spmon,
             sdate TYPE ZI_SBDATA_0001-budat,
             edate TYPE ZI_SBDATA_0001-budat,
           END OF ly_edate.

    TYPES ly_ex TYPE ZI_ASSB_0020_01.

    "구조 정의
    DATA ls_list  TYPE ly_list.
    DATA ls_listd TYPE ly_listd.
    DATA ls_listl TYPE ly_listl.
    DATA ls_lista TYPE ly_lista.

    "    DATA ls_list1 TYPE ly_list1.
    DATA ls_kalnr TYPE ly_kalnr.
    DATA ls_vn1 TYPE ly_vn1.
    DATA ls_vn2 TYPE ly_vn2.
    DATA ls_vn3 TYPE ly_vn3.
    DATA ls_vnr1 TYPE ly_vnr1.
    DATA ls_vnr2 TYPE ly_vnr2.
    DATA ls_vnr3 TYPE ly_vnr3.
    DATA ls_tri1 TYPE ly_tri1.
    DATA ls_tri2 TYPE ly_tri2.
    DATA ls_tri3 TYPE ly_tri3.
    DATA ls_triwv TYPE ly_tri3.
    DATA ls_trr1 TYPE ly_tri1.
    DATA ls_trr2 TYPE ly_tri2.
    DATA ls_trr3 TYPE ly_tri3.
    DATA ls_list4 TYPE ly_list4.
    DATA ls_auak1 TYPE ly_auak1.
    DATA ls_auak3 TYPE ly_auak3.
    DATA ls_auak2 TYPE ly_auak2.
    DATA ls_moh TYPE ly_moh.
    DATA ls_bf1 TYPE ly_auak1.
    DATA ls_bf2 TYPE ly_auak2.
    DATA ls_bf3 TYPE ly_auak3.
    DATA ls_bl1 TYPE ly_bl1.
    DATA ls_bl2 TYPE ly_bl2.
    DATA ls_bl3 TYPE ly_bl3.
    DATA ls_ac1 TYPE ly_ac1.
    DATA ls_ac3 TYPE ly_ac3.
    DATA ls_ac2 TYPE ly_ac2.
    DATA ls_data  TYPE ly_data.
    DATA ls_data_1  TYPE ly_data_1.
    DATA ls_data2 TYPE ly_data2.
    DATA ls_data2_1 TYPE ly_data2_1.
    DATA ls_data3 TYPE ly_data3.
    DATA ls_data4 TYPE ly_data4.
    DATA ls_data5 TYPE ly_data5.
    DATA ls_data5a TYPE ly_data5a.
    DATA ls_data6 TYPE ly_data6.
    DATA ls_data6a TYPE ly_data6a.
    DATA ls_data7 TYPE ly_data7.
    DATA ls_data8 TYPE ly_data8.
    DATA ls_0030 TYPE ly_0030.
    DATA ls_0060  TYPE ly_0060.
    DATA ls_0080  TYPE ly_0080.
    DATA ls_edate TYPE ly_edate.
    DATA ls_ex TYPE ly_ex.

    "인터널 테이블 정의
    DATA lt_list  TYPE TABLE OF ly_list WITH DEFAULT KEY.
    DATA lt_listd TYPE TABLE OF ly_listd WITH DEFAULT KEY.
    DATA lt_listl TYPE TABLE OF ly_listl WITH DEFAULT KEY.
    DATA lt_lista TYPE TABLE OF ly_lista WITH DEFAULT KEY.
    "    DATA lt_list1 TYPE TABLE OF ly_list1.
    DATA lt_kalnr TYPE TABLE OF ly_kalnr.
    DATA lt_vn1 TYPE TABLE OF ly_vn1.
    DATA lt_vn2 TYPE TABLE OF ly_vn2.
    DATA lt_vn3 TYPE TABLE OF ly_vn3.
    DATA lt_vnr1 TYPE TABLE OF ly_vnr1.
    DATA lt_vnr2 TYPE TABLE OF ly_vnr2.
    DATA lt_vnr3 TYPE TABLE OF ly_vnr3.
    DATA lt_tri1 TYPE TABLE OF ly_tri1.
    DATA lt_tri2 TYPE TABLE OF ly_tri2.
    DATA lt_tri3 TYPE TABLE OF ly_tri3.
    DATA lt_triwv TYPE TABLE OF ly_tri3.
    DATA lt_trr1 TYPE TABLE OF ly_tri1.
    DATA lt_trr2 TYPE TABLE OF ly_tri2.
    DATA lt_trr3 TYPE TABLE OF ly_tri3.
    DATA lt_list4 TYPE TABLE OF ly_list4.
    DATA lt_auak1 TYPE TABLE OF ly_auak1.
    DATA lt_auak3 TYPE TABLE OF ly_auak3.
    DATA lt_auak2 TYPE TABLE OF ly_auak2.
    DATA lt_moh TYPE TABLE OF ly_moh.
    DATA lt_bf1 TYPE TABLE OF ly_auak1.
    DATA lt_bf2 TYPE TABLE OF ly_auak2.
    DATA lt_bf3 TYPE TABLE OF ly_auak3.
    DATA lt_bl1 TYPE TABLE OF ly_bl1.
    DATA lt_bl2 TYPE TABLE OF ly_bl2.
    DATA lt_bl3 TYPE TABLE OF ly_bl3.
    DATA lt_ac1 TYPE TABLE OF ly_ac1.
    DATA lt_ac3 TYPE TABLE OF ly_ac3.
    DATA lt_ac2 TYPE TABLE OF ly_ac2.
    DATA lt_data  TYPE TABLE OF ly_data.
    DATA lt_data_a  TYPE TABLE OF ly_data.
    DATA lt_data_1  TYPE TABLE OF ly_data_1.
    DATA lt_data2 TYPE TABLE OF ly_data2.
    DATA lt_data2d TYPE TABLE OF ly_data2.
    DATA lt_data2_1 TYPE TABLE OF ly_data2_1.
    DATA lt_data3 TYPE TABLE OF ly_data3.
    DATA lt_data4 TYPE TABLE OF ly_data4.
    DATA lt_data5 TYPE TABLE OF ly_data5.
    DATA lt_data5a TYPE TABLE OF ly_data5a.
    DATA lt_data5f TYPE TABLE OF ly_data5.
    DATA lt_data5af TYPE TABLE OF ly_data5a.
    DATA lt_data6 TYPE TABLE OF ly_data6.
    DATA lt_data6a TYPE TABLE OF ly_data6a.
    DATA lt_data7 TYPE TABLE OF ly_data7.
    DATA lt_data8 TYPE TABLE OF ly_data8.
    DATA lt_mlhd  TYPE TABLE OF ly_data.
    DATA lt_0030 TYPE TABLE OF ly_0030.
    DATA lt_0060  TYPE TABLE OF ly_0060.
    DATA lt_0060a TYPE TABLE OF ly_0060.
    DATA lt_0080  TYPE TABLE OF ly_0080.
    DATA lt_edate TYPE TABLE OF ly_edate.

    "레인지 변수 정의
    DATA r_matnr  TYPE RANGE OF ZR_ASSB_0000-matnr.
    DATA r_tmatnr TYPE RANGE OF ZR_ASSB_0000-matnr.
    DATA r_werks  TYPE RANGE OF ZR_ASSB_0000-bwkey.
    DATA r_bklas  TYPE RANGE OF ZR_ASSB_0000-bklas.
    DATA r_spmon  TYPE RANGE OF ZR_ASSB_0000-spmon.
    DATA r_kalnr  TYPE RANGE OF ZR_ASSB_0000-kalnr.
    DATA r_aufnr  TYPE RANGE OF ZI_SBDATA_0001-aufnr.
    DATA r_sb000  TYPE RANGE OF ZR_ASSB_0000-uuid.
    DATA r_sb001  TYPE RANGE OF ZR_ASSB_0001-uuid.
    DATA r_sb005  TYPE RANGE OF ZR_ASSB_0005-uuid.
    DATA r_sb002  TYPE RANGE OF ZR_ASSB_0002-uuid.

ENDCLASS.

CLASS lhc_subul IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD calc_value.
      DATA fieldm TYPE string.
        DATA fielda TYPE string.
        DATA zfield TYPE string.
        DATA zvalue TYPE string.

        DATA: assign_amt TYPE p LENGTH 16 DECIMALS 0.

        DATA: lv_ch2. "저장위치레벨 수불부 업데이터 허용여부
        DATA: lv_ch3. "외주 임가공 여부 확인.

        DATA auak_d TYPE p LENGTH 16 DECIMALS 5.

        FIELD-SYMBOLS <fm> TYPE any.
        FIELD-SYMBOLS <fa> TYPE any.
        FIELD-SYMBOLS <fe> TYPE any.
        FIELD-SYMBOLS <fv> TYPE any.

        "기타 데이터 타입 정의
        DATA f    TYPE c LENGTH 1.
        DATA zfld TYPE string.

        DATA: syear  TYPE n LENGTH 4,
              eyear  TYPE n LENGTH 4,
              spoper TYPE n LENGTH 3,
              epoper TYPE n LENGTH 3,
              spmon  TYPE n LENGTH 6,
              bklas  TYPE c LENGTH 4,
              bwkey  TYPE c LENGTH 4.

        DATA: eym    TYPE n LENGTH 6.
        DATA: edate TYPE d,
              sdate TYPE d.

        DATA: lv_hsl TYPE ZI_SBDATA_0001-hsl,
              lv_mng TYPE ZI_SBDATA_0001-menge.

        DATA: ly_modm TYPE ZI_SBDATA_0001-menge.
        DATA: ly_line TYPE sy-tabix.
        DATA: ly_modm1 TYPE ZI_SBDATA_0001-menge.
        DATA: ly_line1 TYPE sy-tabix.

        DATA: lt_werks TYPE TABLE OF string,
              lt_bklas TYPE TABLE OF string,
              lt_matnr TYPE TABLE OF string.

        DATA: i_sign,
              i_option TYPE c LENGTH 2,
              i_low    TYPE string,
              i_high   TYPE string.

        DATA(key) = keys[ 1 ].


        "-[변수값 할당]----------------------------------------------------------------------------------
        " IMPORT값 RANGES 변수로 변환.
        CLEAR: r_matnr[],
               r_werks[],
               r_spmon[],
               r_bklas[],
               r_aufnr[].

        IF key-%param-spmons+4(2) = '01'.
          syear = key-%param-spmons+0(4) - 1.
          spoper = '12'.
        ELSE.
          syear = key-%param-spmons+0(4).
          spoper = key-%param-spmons+4(2) - 1.
        ENDIF.
        spoper = '0' && spoper.

        bklas = key-%param-bklas.
        spmon = key-%param-spmons.
        bwkey = key-%param-werks.
        eyear = key-%param-spmons+0(4).
        epoper = key-%param-spmons+4(2).
        epoper = '0' && epoper.

        IF key-%param-matnr = '*' OR key-%param-matnr = '' .
          CLEAR key-%param-matnr.
        ELSE.
          r_matnr = VALUE #( ( sign = 'I' option = 'EQ' low = key-%param-matnr ) ).
        ENDIF.

        IF key-%param-werks = '*'.
          CLEAR key-%param-werks.
        ELSE.
          r_werks = VALUE #( ( sign = 'I' option = 'EQ' low = key-%param-werks ) ).
        ENDIF.

        IF key-%param-bklas = '*'.
          CLEAR key-%param-bklas.
        ELSE.
          r_bklas = VALUE #( ( sign = 'I' option = 'EQ' low = key-%param-bklas ) ).
        ENDIF.



*        IF key-%param-spmone = ''.
        r_spmon = VALUE #( ( sign = 'I' option = 'EQ' low = key-%param-spmons+0(4) && '0' && key-%param-spmons+4(2) ) ).

        "월별 말일 계산.
        CLEAR: ls_edate, eym, edate, sdate.
        ls_edate-spmon = key-%param-spmons+0(4) && '0' && key-%param-spmons+4(2).

        eym = key-%param-spmons.
        sdate = eym && '01'.
        sdate = sdate - 1.
        ls_edate-sdate = sdate.

        eym = key-%param-spmons + 1.
        IF key-%param-spmons+4(2) = '12'.
          eym+0(4) = key-%param-spmons+0(4) + 1.
          eym+4(2) = '01'.
        ENDIF.
        edate = eym && '01'.
        edate = edate - 1.
        ls_edate-edate = edate.
        APPEND ls_edate TO lt_edate.
        CLEAR ls_edate.


        "-[수불 데이터 취합]----------------------------------------------------------------------------------
        CLEAR: ls_data,
               lt_data[],
               ls_data2,
               lt_data2[],
               lt_data2d[],
               ls_data3,
               lt_data3[],
               ls_data4,
               lt_data4[],
               ls_moh,
               lt_moh[],
               ls_data5,
               lt_data5[],
               lt_data5f[],
               ls_data5a,
               lt_data5a[],
               lt_data5af[],
               ls_data6,
               lt_data6[],
               ls_data6a,
               lt_data6a[],
               ls_data7,
               lt_data7[],
               ls_data_1,
               lt_data_1[],
               ls_0060,
               lt_0060[],
               lt_0060a[],
               ls_0080,
               lt_0080[],
               ls_ex.

        " 플랜트 기준 수불 데이터 추가 취합.
*        SELECT DISTINCT * FROM ZI_SBDATA_0001( p_year = @eyear, p_month = @epoper )
*          WHERE matnr IN @r_matnr
*          AND werks IN @r_werks
*          AND bklas IN @r_bklas
*          AND spmon IN @r_spmon
*          AND ( ktosl = 'BSX' OR ktosl LIKE 'PR%' OR ktosl = 'AUM' OR ktosl = 'KDM' ) "환차손익
*          AND mlcat NOT IN ( 'AB', 'EB' )
*          INTO CORRESPONDING FIELDS OF TABLE @lt_data.

        SELECT DISTINCT * FROM ZI_SBDATA_0001( p_year = @eyear, p_month = @epoper )
          WHERE matnr IN @r_matnr
          AND werks IN @r_werks
          AND bklas IN @r_bklas
          AND spmon IN @r_spmon
          AND mlptyp NOT IN ( 'AB', 'EB', '' )
          INTO CORRESPONDING FIELDS OF TABLE @lt_data.

        lt_data_a[] = lt_data[].

        DELETE lt_data WHERE ktosl <> 'BSX' AND ktosl <> 'AUM' AND ktosl <> 'KDM' AND ktosl <> 'UMB' AND ktosl+0(2) <> 'PR'.
        DELETE lt_data_a WHERE ktosl = 'BSX' OR ktosl = 'AUM' OR ktosl = 'KDM' OR ktosl = 'UMB' OR ktosl+0(2) = 'PR'.

        CLEAR: ls_kalnr, lt_kalnr.
        CLEAR: lv_ch3.
        CLEAR: r_tmatnr[].
        LOOP AT lt_data INTO ls_data.
          CLEAR ls_kalnr.
          MOVE-CORRESPONDING ls_data TO ls_kalnr.
          ls_kalnr-spmon = key-%param-spmons.
          APPEND ls_kalnr TO lt_kalnr.
          CLEAR ls_kalnr.

          IF ls_data-mlptyp = 'BL'.
            lv_ch3 = 'X'.
            r_tmatnr = VALUE #( BASE r_tmatnr ( sign = 'I' option = 'EQ' low = ls_data-matnr ) ).
          ENDIF.
        ENDLOOP.

        IF r_tmatnr[] IS NOT INITIAL.
          SORT r_tmatnr BY low.
          DELETE ADJACENT DUPLICATES FROM r_tmatnr COMPARING ALL FIELDS.
        ENDIF.

        SORT lt_kalnr BY kalnr matnr bwkey bklas sobkz spso spsoi spwbs bwtar meins waers spmon.

        DELETE ADJACENT DUPLICATES FROM lt_kalnr COMPARING ALL FIELDS.

        IF lv_ch2 = 'X'.
          " 저장위치 기준 수불 데이터 추가 취합.
          SELECT DISTINCT * FROM ZI_SBDATA_0001_01( p_year = @eyear, p_month = @epoper )
            WHERE matnr IN @r_matnr
            AND werks IN @r_werks
            AND bklas IN @r_bklas
            AND spmon IN @r_spmon
            APPENDING CORRESPONDING FIELDS OF TABLE @lt_data.
        ENDIF.

        "자재원장결산 수불 데이터 취합.
        SELECT DISTINCT * FROM ZI_SBDATA_0003
          WHERE matnr IN @r_matnr
          AND werks IN @r_werks
          AND bklas IN @r_bklas
          AND spmon IN @r_spmon
          INTO CORRESPONDING FIELDS OF TABLE @lt_data3.

*        DELETE LT_DATA3 WHERE matnr NOT IN r_matnr OR werks NOT IN r_werks OR bklas NOT IN r_bklas OR spmon NOT IN r_spmon.

        DELETE lt_data3 WHERE typ2 = '' AND typ3 = '' AND typ4 = '' AND typ5 = '' AND typ6 = ''.

        "오더정산 수불 데이터 취합
        SELECT DISTINCT * FROM ZI_SBDATA_0004
          WHERE matnr IN @r_matnr
          AND werks IN @r_werks
          AND bklas IN @r_bklas
          AND spmon IN @r_spmon
          APPENDING CORRESPONDING FIELDS OF TABLE @lt_data4.

        "오더정산 중 wip건들을 위한 오더헤더정보 취합.
        LOOP AT lt_data4 INTO ls_data4.
          r_aufnr = VALUE #( ( sign = 'I' option = 'EQ' low = ls_data4-aufnr ) ).
        ENDLOOP.
        SORT r_aufnr BY low.
        DELETE ADJACENT DUPLICATES FROM r_aufnr COMPARING low.

        IF r_aufnr[] IS NOT INITIAL.
          SELECT DISTINCT * FROM i_mfgorderforextraction
            WHERE manufacturingorder IN @r_aufnr
            INTO CORRESPONDING FIELDS OF TABLE @lt_moh.
        ENDIF.

*        "생산입고 하위품목출고 데이터 취합.
*        SELECT DISTINCT * FROM ZI_SBDATA_0005( p_year = @eyear, p_month = @epoper )
*          WHERE tmatnr IN @r_matnr
*          AND twerks IN @r_werks
*          AND tbklas IN @r_bklas
*          AND spmon IN @r_spmon
*          APPENDING CORRESPONDING FIELDS OF TABLE @lt_data5.
*
*        SELECT DISTINCT * FROM ZI_SBDATA_0005_01( p_year = @eyear, p_month = @epoper )
*          WHERE tmatnr IN @r_matnr
*          AND twerks IN @r_werks
*          AND tbklas IN @r_bklas
*          AND spmon IN @r_spmon
*          APPENDING CORRESPONDING FIELDS OF TABLE @lt_data5a.
*
*        "생산출고 상위품목입고 데이터 취합.
*        SELECT DISTINCT * FROM ZI_SBDATA_0005( p_year = @eyear, p_month = @epoper )
*          WHERE fmatnr IN @r_matnr
*          AND fwerks IN @r_werks
*          AND fbklas IN @r_bklas
*          AND spmon IN @r_spmon
*          APPENDING CORRESPONDING FIELDS OF TABLE @lt_data5f.
*
*        SELECT DISTINCT * FROM ZI_SBDATA_0005_01( p_year = @eyear, p_month = @epoper )
*          WHERE fmatnr IN @r_matnr
*          AND fwerks IN @r_werks
*          AND fbklas IN @r_bklas
*          AND spmon IN @r_spmon
*          APPENDING CORRESPONDING FIELDS OF TABLE @lt_data5af.

        "생산입고 하위품목출고 데이터 취합.
        SELECT DISTINCT * FROM ZI_SBDATA_0005( p_year = @eyear, p_month = @epoper )
          WHERE spmon IN @r_spmon
          APPENDING CORRESPONDING FIELDS OF TABLE @lt_data5.

        "생산출고 상위품목입고 데이터 취합.
        lt_data5f[] = lt_data5[].

        "생산입고 하위품목출고 데이터 취합.
        SELECT DISTINCT * FROM ZI_SBDATA_0005_01( p_year = @eyear, p_month = @epoper )
          WHERE spmon IN @r_spmon
          APPENDING CORRESPONDING FIELDS OF TABLE @lt_data5a.

        "생산출고 상위품목입고 데이터 취합.
        lt_data5af[] = lt_data5a[].

        DELETE lt_data5 WHERE tmatnr = ''.
        DELETE lt_data5 WHERE tbklas NOT IN r_bklas OR twerks NOT IN r_werks.

        DELETE lt_data5a WHERE tmatnr = ''.
        DELETE lt_data5a WHERE tbklas NOT IN r_bklas OR twerks NOT IN r_werks.

        DELETE lt_data5f WHERE fmatnr = ''.
        DELETE lt_data5f WHERE fbklas NOT IN r_bklas OR fwerks NOT IN r_werks.

        DELETE lt_data5af WHERE fmatnr = ''.
        DELETE lt_data5af WHERE fbklas NOT IN r_bklas OR fwerks NOT IN r_werks.

        IF r_matnr[] IS NOT INITIAL.
          DELETE lt_data5 WHERE tmatnr NOT IN r_matnr.
          DELETE lt_data5a WHERE tmatnr NOT IN r_matnr.
          DELETE lt_data5f WHERE fmatnr NOT IN r_matnr.
          DELETE lt_data5af WHERE fmatnr NOT IN r_matnr.
        ENDIF.

        IF lv_ch3 = 'X'.
          "외주입고 하위품목출고 데이터 취합.
          SELECT DISTINCT * FROM ZI_SBDATA_0006_01( p_year = @eyear, p_month = @epoper )
            WHERE tmatnr IN @r_tmatnr
            AND twerks IN @r_werks
            AND tbklas IN @r_bklas
            AND spmon IN @r_spmon
            APPENDING CORRESPONDING FIELDS OF TABLE @lt_data6a.

          SELECT DISTINCT * FROM ZI_SBDATA_0006( p_year = @eyear, p_month = @epoper )
            WHERE tmatnr IN @r_tmatnr
            AND twerks IN @r_werks
            AND tbklas IN @r_bklas
            AND spmon IN @r_spmon
            APPENDING CORRESPONDING FIELDS OF TABLE @lt_data6.
        ENDIF.

        IF lv_ch2 = 'X'.
          "저장위치 기준 정보의 표준원가 데이터 취합.
          READ TABLE r_spmon INTO DATA(lr_spmon) INDEX 1.
          SELECT DISTINCT * FROM ZI_SBDATA_0007
            WHERE matnr IN @r_matnr
            AND werks IN @r_werks
            AND bklas IN @r_bklas
            AND spmon <= @lr_spmon-low
            APPENDING CORRESPONDING FIELDS OF TABLE @lt_data7.
          SORT lt_data7 BY kalnr spmon DESCENDING.
        ENDIF.

        " 자재정보 및 기초기말정보 취합.
        SELECT DISTINCT *
          FROM ZI_SBDATA_0002( p_syear = @syear, p_smonth = @spoper, p_eyear = @eyear, p_emonth = @epoper )
          WHERE matnr IN @r_matnr
            AND bwkey IN @r_werks
            AND bklas IN @r_bklas
          INTO CORRESPONDING FIELDS OF TABLE @lt_data2.

        " 자재정보 및 기초기말정보 취합 (일별)
        lt_data2d[] = lt_data2[].
*        LOOP AT lt_edate INTO ls_edate.
*          SELECT DISTINCT *
*            FROM ZI_SBDATA_0002( p_syear = @ls_edate-spmon+0(4), p_smonth = @ls_edate-spmon+4(3), p_eyear = @ls_edate-spmon+0(4), p_emonth = @ls_edate-spmon+4(3) )
*            WHERE matnr IN @r_matnr
*              AND bwkey IN @r_werks
*              AND bklas IN @r_bklas
*            APPENDING CORRESPONDING FIELDS OF TABLE @lt_data2d.
*        ENDLOOP.

        IF lv_ch2 = 'X'.
          " 저장위치 자재정보 및 기초기말정보 취합
          LOOP AT lt_edate INTO ls_edate.
            SELECT DISTINCT *
              FROM ZI_SBDATA_0002_01( p_date = @ls_edate-sdate, p_year = @eyear, p_month = @epoper )
              WHERE matnr IN @r_matnr
                AND bwkey IN @r_werks
                AND bklas IN @r_bklas
              APPENDING CORRESPONDING FIELDS OF TABLE @lt_data2_1.

            SELECT DISTINCT *
              FROM ZI_SBDATA_0002_01( p_date = @ls_edate-edate, p_year = @eyear, p_month = @epoper )
              WHERE matnr IN @r_matnr
                AND bwkey IN @r_werks
                AND bklas IN @r_bklas
              APPENDING CORRESPONDING FIELDS OF TABLE @lt_data2_1.
          ENDLOOP.
        ENDIF.

        " 수불조건정보 취합.
        CLEAR: ls_0060,
               lt_0060[].
        SELECT * FROM zassbt0010
          WHERE bklas IN @r_bklas
            AND werks IN @r_werks
          INTO CORRESPONDING FIELDS OF TABLE @lt_0060.
        SORT lt_0060 BY werks
                        bklas
                        zsfld.

        lt_0060a[] = lt_0060[].

        LOOP AT lt_0060a ASSIGNING FIELD-SYMBOL(<lf_0060>).
          CLEAR <lf_0060>-ptyp.
        ENDLOOP.
        SORT lt_0060a BY werks
                        bklas
                        zsfld.

        DELETE ADJACENT DUPLICATES FROM lt_0060a COMPARING zsfld.

        " 수불예외조건정보 취합.
        CLEAR: ls_0080,
               lt_0080[].
        SELECT * FROM zassbt0020
          WHERE bklas IN @r_bklas
            AND werks IN @r_werks
          INTO CORRESPONDING FIELDS OF TABLE @lt_0080.
        SORT lt_0080 BY werks
                        bklas
                        zaexc
                        zaexcp.

        SELECT SINGLE * FROM ZI_ASSB_0020_01( p_werks = @key-%param-werks, p_bklas = @key-%param-bklas )
          INTO @ls_ex.


        "-[자재정보 및 기초기말정보 가공.]----------------------------------------------------------------------------------
        CLEAR: ls_list,
               lt_list[].
        CLEAR: ls_listd,
               lt_listd[].
        CLEAR: ls_listl,
               lt_listl[].
        CLEAR: ls_lista,
               lt_lista[].
        CLEAR: ls_data8,
               lt_data8[].

        CLEAR r_kalnr[].
        LOOP AT lt_data2 INTO ls_data2.
          MOVE-CORRESPONDING ls_data2 TO ls_list.
          CLEAR: eym, edate.
*          IF key-%param-spmons = key-%param-spmone OR key-%param-spmone = ''.
          ls_list-spmon = key-%param-spmons.

          eym = key-%param-spmons + 1.
          IF key-%param-spmons+4(2) = '12'.
            eym+0(4) = key-%param-spmons+0(4) + 1.
            eym+4(2) = '01'.
          ENDIF.
*          ELSE.
*            ls_list-spmon = key-%param-spmons && '~' && key-%param-spmone.
*
*            eym = key-%param-spmone + 1.
*            IF key-%param-spmone+4(2) = '12'.
*              eym+0(4) = key-%param-spmone+0(4) + 1.
*              eym+4(2) = '01'.
*            ENDIF.
*          ENDIF.
          edate = eym && '01'.
          edate = edate - 1.


          r_kalnr = VALUE #( BASE r_kalnr
                             ( sign = 'I' option = 'EQ' low = ls_list-kalnr high = '' ) ).

          CLEAR ls_0060.
          READ TABLE lt_0060 INTO ls_0060 WITH KEY bklas = ls_data2-bklas
                                                   werks = ls_data2-bwkey
                                                   zsbgb = 'A'.
          IF ls_0060-zsfld IS NOT INITIAL.
            CLEAR: fieldm,
                   fielda.
            CONCATENATE 'LS_LIST-' ls_0060-zsfld 'M' INTO fieldm.
            ASSIGN (fieldm) TO FIELD-SYMBOL(<wfm>).
            IF <wfm> IS ASSIGNED.
              <wfm> += ls_data2-smenge.
            ENDIF.
            UNASSIGN <wfm>.
            CONCATENATE 'LS_LIST-' ls_0060-zsfld 'A' INTO fielda.
            ASSIGN (fielda) TO FIELD-SYMBOL(<wfa>).
            IF <wfa> IS ASSIGNED.
              <wfa> += ls_data2-sdmbtr.
            ENDIF.
            UNASSIGN <wfa>.
            "일별 기초.
            MOVE-CORRESPONDING ls_data2 TO ls_listd.
            ls_listd-budat = key-%param-spmons && '01'.
            ls_listd-spmon = key-%param-spmons.
            CLEAR: fieldm,
                   fielda.
            CONCATENATE 'LS_LISTD-' ls_0060-zsfld 'M' INTO fieldm.
            ASSIGN (fieldm) TO FIELD-SYMBOL(<dfm>).
            IF <dfm> IS ASSIGNED.
              <dfm> += ls_data2-smenge.
            ENDIF.
            UNASSIGN <dfm>.
            CONCATENATE 'LS_LISTD-' ls_0060-zsfld 'A' INTO fielda.
            ASSIGN (fielda) TO FIELD-SYMBOL(<dfa>).
            IF <dfa> IS ASSIGNED.
              <dfa> += ls_data2-sdmbtr.
            ENDIF.
            UNASSIGN <dfa>.
            APPEND ls_listd TO lt_listd.
            CLEAR ls_listd.

            "재무기준 기초
            CLEAR ls_lista.
            MOVE-CORRESPONDING ls_data2 TO ls_lista.
            ls_lista-spmon = key-%param-spmons.
            ls_lista-zsfld = ls_0060-zsfld.
            ls_lista-racct = ls_0060-racct.
            ls_lista-ktosl = 'AB'.
            ls_lista-menge += ls_data2-smenge.
            IF ls_data2-sdmbtr <> 0.
              ls_data2-sdmbtr = ls_data2-sdmbtr / 100.
            ENDIF.
            ls_lista-dmbtr += ls_data2-sdmbtr.
            ls_lista-dmbtr2 += ls_data2-sdmbtr.
*            ls_lista-dmbtr3 += ls_data2-sdmbtr.
            APPEND ls_lista TO lt_lista.

            CLEAR ls_data8.
            MOVE-CORRESPONDING ls_lista TO ls_data8.

            COLLECT ls_data8 INTO lt_data8.
            CLEAR ls_data8.
            CLEAR ls_lista.
          ENDIF.

          CLEAR ls_0060.
          READ TABLE lt_0060 INTO ls_0060 WITH KEY bklas = ls_data2-bklas
                                                   werks = ls_data2-bwkey
                                                   zsbgb = 'E'.
          IF ls_0060-zsfld IS NOT INITIAL.
            CLEAR: fieldm,
                   fielda.
            CONCATENATE 'LS_LIST-' ls_0060-zsfld 'M' INTO fieldm.
            ASSIGN (fieldm) TO FIELD-SYMBOL(<wfme>).
            IF <wfme> IS ASSIGNED.
              <wfme> += ls_data2-emenge.
            ENDIF.
            UNASSIGN <wfme>.
            CONCATENATE 'LS_LIST-' ls_0060-zsfld 'A' INTO fielda.
            ASSIGN (fielda) TO FIELD-SYMBOL(<wfae>).
            IF <wfae> IS ASSIGNED.
              <wfae> += ls_data2-edmbtr.
            ENDIF.
            UNASSIGN <wfae>.

            "재무기준 기말
            CLEAR ls_lista.
            MOVE-CORRESPONDING ls_data2 TO ls_lista.
            ls_lista-spmon = key-%param-spmons.
            ls_lista-zsfld = ls_0060-zsfld.
            ls_lista-racct = ls_0060-racct.
            ls_lista-ktosl = 'ED'.
            ls_lista-menge += ls_data2-emenge * -1.
            IF ls_data2-edmbtr <> 0.
              ls_data2-edmbtr = ls_data2-edmbtr / 100 * -1.
            ENDIF.
            ls_lista-dmbtr += ls_data2-edmbtr.
            ls_lista-dmbtr2 += ls_data2-edmbtr.
*            ls_lista-dmbtr3 += ls_data2-edmbtr.
            APPEND ls_lista TO lt_lista.

            CLEAR ls_data8.
            MOVE-CORRESPONDING ls_lista TO ls_data8.

            COLLECT ls_data8 INTO lt_data8.
            CLEAR ls_data8.
            CLEAR ls_lista.
*            "일별 기말.
*            MOVE-CORRESPONDING ls_data2 TO ls_listd.
*            ls_listd-budat = edate.
*
*            CLEAR: fieldm,
*                   fielda.
*            CONCATENATE 'LS_LISTD-' ls_0060-zsfld 'M' INTO fieldm.
*            ASSIGN (fieldm) TO <fm>.
*            IF sy-subrc = 0.
*              <fm> += ls_data2-emenge.
*            ENDIF.
*
*            CONCATENATE 'LS_LISTD-' ls_0060-zsfld 'A' INTO fielda.
*            ASSIGN (fielda) TO <fa>.
*            IF sy-subrc = 0.
*              <fa> += ls_data2-edmbtr.
*            ENDIF.
*
*            APPEND ls_listd TO lt_listd.
*            CLEAR ls_listd.

          ENDIF.

          APPEND ls_list TO lt_list.
          CLEAR ls_list.
        ENDLOOP.

        SORT lt_data2d BY kalnr sspmon espmon.
        LOOP AT lt_data2d INTO ls_data2.
          CLEAR ls_0060.
          READ TABLE lt_0060 INTO ls_0060 WITH KEY bklas = ls_data2-bklas
                                                   werks = ls_data2-bwkey
                                                   zsbgb = 'E'.
          IF ls_0060-zsfld IS NOT INITIAL.
            CLEAR: fieldm,
                   fielda.

            "일별 기말.
            MOVE-CORRESPONDING ls_data2 TO ls_listd.
            ls_listd-spmon = key-%param-spmons.
            CLEAR ls_edate.
            READ TABLE lt_edate INTO ls_edate WITH KEY spmon = ls_data2-espmon.
            ls_listd-budat = ls_edate-edate.
            CLEAR: fieldm,
                   fielda.
            CONCATENATE 'LS_LISTD-' ls_0060-zsfld 'M' INTO fieldm.
            ASSIGN (fieldm) TO FIELD-SYMBOL(<dfme>).
            IF <dfme> IS ASSIGNED.
              <dfme> += ls_data2-emenge.
            ENDIF.
            UNASSIGN <dfme>.
            CONCATENATE 'LS_LISTD-' ls_0060-zsfld 'A' INTO fielda.
            ASSIGN (fielda) TO FIELD-SYMBOL(<dfae>).
            IF <dfae> IS ASSIGNED.
              <dfae> += ls_data2-edmbtr.
            ENDIF.
            UNASSIGN <dfae>.
            APPEND ls_listd TO lt_listd.
            CLEAR ls_listd.
          ENDIF.
        ENDLOOP.

        IF lv_ch2 = 'X'.
          "저장위치별 재고정보 및 기초재고 취합.
          SORT lt_edate BY spmon.
          READ TABLE lt_edate INTO ls_edate INDEX 1.

          LOOP AT lt_data2_1 INTO ls_data2_1.

            DATA(p_index) = sy-tabix.

            IF ls_data2_1-kalnr IS INITIAL OR ls_data2_1-kalnr = '000000000000'.
              READ TABLE lt_kalnr INTO ls_kalnr WITH KEY matnr = ls_data2_1-matnr
                                                         bwkey = ls_data2_1-werks
                                                         bklas = ls_data2_1-bklas
                                                         sobkz = ls_data2_1-sobkz
                                                         spso = ls_data2_1-kdauf
                                                         spsoi = ls_data2_1-kdpos.
              IF sy-subrc = 0.
                ls_data2_1-kalnr = ls_kalnr-kalnr.
              ENDIF.

            ENDIF.

            CLEAR: eym, edate.
*          IF key-%param-spmons = key-%param-spmone OR key-%param-spmone = ''.


            eym = key-%param-spmons + 1.
            IF key-%param-spmons+4(2) = '12'.
              eym+0(4) = key-%param-spmons+0(4) + 1.
              eym+4(2) = '01'.
            ENDIF.
*          ELSE.
*            ls_listl-spmon = key-%param-spmons && '~' && key-%param-spmone.
*
*            eym = key-%param-spmone + 1.
*            IF key-%param-spmone+4(2) = '12'.
*              eym+0(4) = key-%param-spmone+0(4) + 1.
*              eym+4(2) = '01'.
*            ENDIF.
*          ENDIF.
            edate = eym && '01'.
            edate = edate - 1.

            IF ls_edate-sdate = ls_data2_1-budat.
              MOVE-CORRESPONDING ls_data2_1 TO ls_listl.
              ls_listl-spmon = key-%param-spmons.
              READ TABLE lt_data2 INTO ls_data2 WITH KEY kalnr = ls_data2_1-kalnr.
              IF sy-subrc = 0.
                IF ls_data2-smenge = 0 OR ls_data2-sdmbtr = 0.
                  ls_data2_1-dmbtr = 0.
                  ls_data2_1-danga = 0.
                ELSE.
                  ls_data2_1-dmbtr = ls_data2_1-menge * ( ls_data2-sdmbtr / ls_data2-smenge ).
                  ls_data2_1-danga = ls_data2-sdmbtr / ls_data2-smenge .
                ENDIF.
              ENDIF.

              CLEAR ls_0060.
              READ TABLE lt_0060 INTO ls_0060 WITH KEY bklas = ls_data2_1-bklas
                                                       werks = ls_data2_1-werks
                                                       zsbgb = 'A'.
              IF ls_0060-zsfld IS NOT INITIAL.
                CLEAR: fieldm,
                       fielda.
                CONCATENATE 'LS_LISTL-' ls_0060-zsfld 'M' INTO fieldm.
                ASSIGN (fieldm) TO FIELD-SYMBOL(<wfml>).
                IF <wfml> IS ASSIGNED.
                  <wfml> += ls_data2_1-menge.
                ENDIF.
                UNASSIGN <wfml>.
                CONCATENATE 'LS_LISTL-' ls_0060-zsfld 'A' INTO fielda.
                ASSIGN (fielda) TO FIELD-SYMBOL(<wfal>).
                IF <wfal> IS ASSIGNED.
                  <wfal> += ls_data2_1-dmbtr.
                ENDIF.
                UNASSIGN <wfal>.

                APPEND ls_listl TO lt_listl.
                CLEAR ls_listl.
              ENDIF.

            ELSEIF ls_edate-edate = ls_data2_1-budat.
              CLEAR ls_listl.
              READ TABLE lt_listl INTO ls_listl WITH KEY kalnr = ls_data2_1-kalnr
                                                         lgort = ls_data2_1-lgort
                                                         lifnr = ls_data2_1-lifnr
                                                         kunnr = ls_data2_1-kunnr
                                                         sobkz = ls_data2_1-sobkz.
              IF sy-subrc <> 0.
                CLEAR ls_listl.
                MOVE-CORRESPONDING ls_data2_1 TO ls_listl.
                ls_listl-spmon = key-%param-spmons.
                APPEND ls_listl TO lt_listl.
              ENDIF.

              READ TABLE lt_data2 INTO ls_data2 WITH KEY kalnr = ls_data2_1-kalnr.
              IF sy-subrc = 0.
                IF ls_data2-emenge = 0 OR ls_data2-edmbtr = 0.
                  ls_data2_1-dmbtr = 0.
                  ls_data2_1-danga = 0.
                ELSE.
                  ls_data2_1-dmbtr = ls_data2_1-menge * ( ls_data2-edmbtr / ls_data2-emenge ).
                  ls_data2_1-danga = ls_data2-edmbtr / ls_data2-emenge .
                ENDIF.
              ENDIF.

              CLEAR ls_0060.
              READ TABLE lt_0060 INTO ls_0060 WITH KEY bklas = ls_data2_1-bklas
                                                     werks = ls_data2_1-werks
                                                     zsbgb = 'E'.
              IF ls_0060-zsfld IS NOT INITIAL.
                CLEAR: fieldm,
                       fielda.
                CONCATENATE 'LS_LISTL-' ls_0060-zsfld 'M' INTO fieldm.
                ASSIGN (fieldm) TO FIELD-SYMBOL(<wfmel>).
                IF <wfmel> IS ASSIGNED.
                  <wfmel> += ls_data2_1-menge.
                ENDIF.
                UNASSIGN <wfmel>.
                CONCATENATE 'LS_LISTL-' ls_0060-zsfld 'A' INTO fielda.
                ASSIGN (fielda) TO FIELD-SYMBOL(<wfael>).
                IF <wfael> IS ASSIGNED.
                  <wfael> += ls_data2_1-dmbtr.
                ENDIF.
                UNASSIGN <wfael>.

                DATA(m) = ls_0060-zsfld && 'M'.
                DATA(a) = ls_0060-zsfld && 'A'.
              ENDIF.
              MODIFY lt_listl FROM ls_listl TRANSPORTING (m) (a)
                     WHERE kalnr = ls_data2_1-kalnr
                       AND lgort = ls_data2_1-lgort
                       AND lifnr = ls_data2_1-lifnr
                       AND kunnr = ls_data2_1-kunnr
                       AND sobkz = ls_data2_1-sobkz.
            ENDIF.

            MODIFY lt_data2_1 FROM ls_data2_1 INDEX p_index TRANSPORTING dmbtr danga.
          ENDLOOP.
        ENDIF.

        "수불 데이터에 기초기말 이외 추가적인 원가추정번호 append.
        LOOP AT lt_kalnr INTO ls_kalnr.
          READ TABLE lt_list INTO ls_list WITH KEY kalnr = ls_kalnr-kalnr.
          IF sy-subrc <> 0.
            CLEAR ls_list.
            MOVE-CORRESPONDING ls_kalnr TO ls_list.
            APPEND ls_list TO lt_list.
            CLEAR ls_list.
          ENDIF.
        ENDLOOP.


        CLEAR: ls_auak1,
               lt_auak1[].
        CLEAR: ls_auak2,
               lt_auak2[].
        CLEAR: ls_auak3,
               lt_auak3[].
        CLEAR: ls_bf1,
               lt_bf1[].
        CLEAR: ls_bf2,
               lt_bf2[].
        CLEAR: ls_bf3,
               lt_bf3[].
        CLEAR: ls_bl1,
               lt_bl1[].
        CLEAR: ls_bl2,
               lt_bl2[].
        CLEAR: ls_bl3,
               lt_bl3[].
        CLEAR: ls_trr1,
               lt_trr1[].
        CLEAR: ls_trr2,
               lt_trr2[].
        CLEAR: ls_trr3,
               lt_trr3[].
        CLEAR: ls_tri1,
               lt_tri1[].
        CLEAR: ls_tri2,
               lt_tri2[].
        CLEAR: ls_tri3,
               lt_tri3[].
        CLEAR: ls_triwv,
               lt_triwv[].
        CLEAR: ls_vn1,
               lt_vn1[].
        CLEAR: ls_vn2,
               lt_vn2[].
        CLEAR: ls_vn3,
               lt_vn3[].
        CLEAR: ls_ac1,
               lt_ac1[].
        CLEAR: ls_ac2,
               lt_ac2[].
        CLEAR: ls_ac3,
               lt_ac3[].


        "-[물류 데이터 가공.]----------------------------------------------------------------------------------

        LOOP AT lt_data ASSIGNING FIELD-SYMBOL(<lf_data>).
          "저장위치 기준 데이터는 금액을 표준가 * 수량으로 기재.
*          IF <lf_data>-Belnr IS INITIAL.
*            READ TABLE lt_data2_1 INTO ls_data2_1 WITH KEY Matnr = <lf_data>-Matnr
*                                                       Bwkey = <lf_data>-Werks
*                                                       Sobkz = <lf_data>-Sobkz
*                                                       Kdauf = <lf_data>-Kdauf
*                                                       Kdpos = <lf_data>-Kdpos
*                                                       Ps_psp_pnr = <lf_data>-Ps_psp_pnr
*                                                       budat+0(6) = <lf_data>-Budat+0(6).
*            IF sy-subrc = 0.
*              <lf_data>-hsl = <lf_data>-menge * ls_data2_1-Danga.
*            ENDIF.
*          ENDIF.
          " 저장위치 기준 데이터의 금액정보가 없다면 표준원가를 가져와서 수량을 곱해준다.
          IF ( <lf_data>-hsl IS INITIAL OR <lf_data>-hsl = 0 ) AND <lf_data>-belnr = ''.
            READ TABLE lt_data7 INTO ls_data7 WITH KEY kalnr = <lf_data>-kalnr BINARY SEARCH.
            IF sy-subrc = 0.
              IF ls_data7-dmbtr <> 0.
                <lf_data>-hsl = ( ls_data7-dmbtr / ls_data7-peinh ) * 100.
                IF <lf_data>-shkzg = 'H'.
                  <lf_data>-hsl = <lf_data>-hsl * -1.
                ENDIF.
              ELSE.
                <lf_data>-hsl = 0.
              ENDIF.
            ELSE.
              CLEAR ls_data7.
              READ TABLE lt_data7 INTO ls_data7 WITH KEY werks = <lf_data>-werks
                                                         matnr = <lf_data>-matnr.
              IF sy-subrc = 0.
                IF ls_data7-dmbtr <> 0.
                  <lf_data>-hsl = ( ls_data7-dmbtr / ls_data7-peinh ) * 100.
                  IF <lf_data>-shkzg = 'H'.
                    <lf_data>-hsl = <lf_data>-hsl * -1.
                  ENDIF.
                ELSE.
                  <lf_data>-hsl = 0.
                ENDIF.
              ELSE.
                <lf_data>-hsl = 0.
              ENDIF.
            ENDIF.
          ELSE.
            <lf_data>-hsl *= 100.
          ENDIF.

          IF <lf_data>-shkzg = 'H'.
            <lf_data>-menge *= -1.
          ENDIF.


          IF lv_ch2 = 'X'.
            " 저장위치수불필드 할당
            CLEAR ls_listl.
            IF <lf_data>-sobkz = 'W'. "고객위탁
              READ TABLE lt_listl INTO ls_listl WITH KEY kalnr = <lf_data>-kalnr
                                                                  lgort = <lf_data>-lgort
                                                                  sobkz = <lf_data>-sobkz
                                                                  lifnr = ''
                                                                  kunnr = <lf_data>-kunnr.
            ELSEIF <lf_data>-sobkz = 'O'. "외주
              READ TABLE lt_listl INTO ls_listl WITH KEY kalnr = <lf_data>-kalnr
                                                                    lgort = <lf_data>-lgort
                                                                    sobkz = <lf_data>-sobkz
                                                                    lifnr = <lf_data>-lifnr
                                                                    kunnr = ''.
            ELSE.
              READ TABLE lt_listl INTO ls_listl WITH KEY kalnr = <lf_data>-kalnr
                                                                          lgort = <lf_data>-lgort
                                                                          sobkz = <lf_data>-sobkz
                                                                          lifnr = ''
                                                                          kunnr = ''.
            ENDIF.
            IF sy-subrc <> 0.
              CLEAR ls_listl.
              MOVE-CORRESPONDING <lf_data> TO ls_listl.
              ls_listl-spmon = key-%param-spmons.
              IF <lf_data>-sobkz = 'W'.
                CLEAR: ls_listl-lifnr.
              ELSEIF <lf_data>-sobkz = 'O'.
                CLEAR: ls_listl-kunnr.
              ELSE.
                CLEAR: ls_listl-kunnr, ls_listl-lifnr.
              ENDIF.

              APPEND ls_listl TO lt_listl.
              CLEAR ls_listl.
            ENDIF.

            IF <lf_data>-sobkz = 'W'. "고객위탁
              READ TABLE lt_listl ASSIGNING FIELD-SYMBOL(<lf_listl>) WITH KEY kalnr = <lf_data>-kalnr
                                                                  lgort = <lf_data>-lgort
                                                                  sobkz = <lf_data>-sobkz
                                                                  lifnr = ''
                                                                  kunnr = <lf_data>-kunnr.
            ELSEIF <lf_data>-sobkz = 'O'. "외주
              READ TABLE lt_listl ASSIGNING <lf_listl> WITH KEY kalnr = <lf_data>-kalnr
                                                                    lgort = <lf_data>-lgort
                                                                    sobkz = <lf_data>-sobkz
                                                                    lifnr = <lf_data>-lifnr
                                                                    kunnr = ''.
            ELSE.
              READ TABLE lt_listl ASSIGNING <lf_listl> WITH KEY kalnr = <lf_data>-kalnr
                                                                          lgort = <lf_data>-lgort
                                                                          sobkz = <lf_data>-sobkz
                                                                          lifnr = ''
                                                                          kunnr = ''.
            ENDIF.
          ENDIF.

          "플랜트 기준 데이터(회계전표 있는)는 플랜트 기준 수불 필드 할당에 진행,
          "회계전표가 없는 저장위치 기준 데이터는 할당에서 제외
          IF <lf_data>-belnr IS NOT INITIAL.
            " 일수불필드 확인
            READ TABLE lt_listd INTO ls_listd WITH KEY matnr = <lf_data>-matnr
                                                       bwkey = <lf_data>-bwkey
                                                       bwtar = <lf_data>-bwtar
                                                       bklas = <lf_data>-bklas
                                                       kalnr = <lf_data>-kalnr
                                                       budat = <lf_data>-budat.
            IF sy-subrc <> 0.
              "일수불데이터에 정보가 없다면 추가.
              CLEAR ls_listd.
              MOVE-CORRESPONDING <lf_data> TO ls_listd.
              ls_listd-spmon = key-%param-spmons.
              APPEND ls_listd TO lt_listd.
              CLEAR ls_listd.
            ENDIF.
            " 일수불필드 할당
            READ TABLE lt_listd ASSIGNING FIELD-SYMBOL(<lf_listd>) WITH KEY matnr = <lf_data>-matnr
                                                                          bwkey = <lf_data>-bwkey
                                                                          bwtar = <lf_data>-bwtar
                                                                          bklas = <lf_data>-bklas
                                                                          kalnr = <lf_data>-kalnr
                                                                          budat = <lf_data>-budat.

            " 수불필드 할당
            READ TABLE lt_list ASSIGNING FIELD-SYMBOL(<lf_list>) WITH KEY matnr = <lf_data>-matnr
                                                                          bwkey = <lf_data>-bwkey
                                                                          bklas = <lf_data>-bklas
                                                                          kalnr = <lf_data>-kalnr.

            CLEAR ls_0060.
            READ TABLE lt_0060 INTO ls_0060 WITH KEY bklas = <lf_data>-bklas
                                                     werks = <lf_data>-werks
                                                     ptyp  = <lf_data>-mlptyp.
            IF ls_0060-zsfld IS NOT INITIAL.
              <lf_data>-zsfld = ls_0060-zsfld.
              <lf_data>-zsbgb = ls_0060-zsbgb.
              IF ls_0060-zsbgb = 'O'.
                <lf_data>-hsl   *= -1.
                <lf_data>-menge *= -1.
              ENDIF.

              CLEAR: fieldm,
                     fielda.
              CONCATENATE '<lf_list>-' ls_0060-zsfld 'M' INTO fieldm.
              ASSIGN (fieldm) TO FIELD-SYMBOL(<fm1>).
              IF <fm1> IS ASSIGNED.
                <fm1> += <lf_data>-menge.
              ENDIF.

              CONCATENATE '<lf_list>-' ls_0060-zsfld 'A' INTO fielda.
              ASSIGN (fielda) TO FIELD-SYMBOL(<fa1>).
              IF <fa1> IS ASSIGNED.
                <fa1> += <lf_data>-hsl.
              ENDIF.

              "일별 물류
              CLEAR: fieldm,
                     fielda.
              CONCATENATE '<lf_listd>-' ls_0060-zsfld 'M' INTO fieldm.
              ASSIGN (fieldm) TO FIELD-SYMBOL(<fmd1>).
              IF <fmd1> IS ASSIGNED.
                <fmd1> += <lf_data>-menge.
              ENDIF.

              CONCATENATE '<lf_listd>-' ls_0060-zsfld 'A' INTO fielda.
              ASSIGN (fielda) TO FIELD-SYMBOL(<fad1>).
              IF <fad1> IS ASSIGNED.
                <fad1> += <lf_data>-hsl.
              ENDIF.
            ENDIF.

            IF lv_ch2 = 'X'.
              CLEAR: fieldm,
                     fielda.
              CONCATENATE '<lf_listl>-' ls_0060-zsfld 'M' INTO fieldm.
              ASSIGN (fieldm) TO FIELD-SYMBOL(<fml1>).
              IF <fml1> IS ASSIGNED.
                <fml1> += <lf_data>-menge.
              ENDIF.

              CONCATENATE '<lf_listl>-' ls_0060-zsfld 'A' INTO fielda.
              ASSIGN (fielda) TO FIELD-SYMBOL(<fal1>).
              IF <fal1> IS ASSIGNED.
                <fal1> += <lf_data>-hsl.
              ENDIF.
            ENDIF.
          ENDIF.

          IF lv_ch2 = 'X'.
            "저장위치 기준 데이터는 F099 필드심볼 데이터에 넣어서 예외처리로 넘겨줌.
            "저장위치 물류
            IF <lf_data>-belnr IS INITIAL.
              ls_0060-zsfld = 'F099'.
              <lf_data>-zsfld = ls_0060-zsfld.
              <lf_data>-zsbgb = 'I'.

              CLEAR: fieldm,
                     fielda.
              CONCATENATE '<lf_listl>-' ls_0060-zsfld 'M' INTO fieldm.
              ASSIGN (fieldm) TO <fml1>.
              IF <fml1> IS ASSIGNED.
                <fml1> += <lf_data>-menge.
              ENDIF.

              CONCATENATE '<lf_listl>-' ls_0060-zsfld 'A' INTO fielda.
              ASSIGN (fielda) TO <fal1>.
              IF <fal1> IS ASSIGNED.
                <fal1> += <lf_data>-hsl.
              ENDIF.
            ENDIF.
          ENDIF.

          "--[예외 조건 적용]------------------------------------------------------------------------------------

          DATA: zaexc TYPE ZR_ASSB_0020-zaexc,
                sfld  TYPE ZR_ASSB_0020-zsfld,
                value TYPE ZR_ASSB_0020-zvalue,
                field TYPE ZR_ASSB_0020-zfield,
                optn  TYPE ZR_ASSB_0020-zoptn.
          DATA: exfield TYPE string,
                num1    TYPE n LENGTH 3,
                num2    TYPE n LENGTH 4.

          CLEAR: num1, num2.
          num1 = '000'.

          DO 40 TIMES.

            CLEAR: zaexc.
            UNASSIGN <fe>.
            CLEAR exfield.
            exfield = 'ls_ex-Zaexc' && num1.
            ASSIGN (exfield) TO <fe>.
            IF <fe> IS ASSIGNED.
              zaexc = <fe>.
            ENDIF.

            IF zaexc IS NOT INITIAL.
              num2 = num1 && '1'.
              CLEAR: f, zfld.
              CLEAR: sfld.
              UNASSIGN <fe>.
              CLEAR exfield.
              exfield = 'ls_ex-Zsfld' && num1.
              ASSIGN (exfield) TO <fe>.
              IF <fe> IS ASSIGNED.
                sfld = <fe>.
              ENDIF.

              DO 5 TIMES.
                IF zfld = 'X'.
                  EXIT.
                ENDIF.

                CLEAR: field.
                UNASSIGN <fe>.
                CLEAR exfield.
                exfield = 'ls_ex-Zfield' && num2.
                ASSIGN (exfield) TO <fe>.
                IF <fe> IS ASSIGNED.
                  field = <fe>.
                ENDIF.

                IF field IS NOT INITIAL.
                  CLEAR: zfield, value, optn.

                  UNASSIGN <fe>.
                  CLEAR exfield.
                  exfield = 'ls_ex-Zoptn' && num2.
                  ASSIGN (exfield) TO <fe>.
                  IF <fe> IS ASSIGNED.
                    optn = <fe>.
                  ENDIF.

                  UNASSIGN <fe>.
                  CLEAR exfield.
                  exfield = 'ls_ex-Zvalue' && num2.
                  ASSIGN (exfield) TO <fe>.
                  IF <fe> IS ASSIGNED.
                    value = <fe>.
                  ENDIF.


                  CONCATENATE '<lf_data>-' field INTO zfield.
                  ASSIGN (zfield) TO <fe>.
                  IF value+0(1) = ':'.
                    CLEAR: zvalue.
                    CONCATENATE '<lf_data>-' value+1(20) INTO zvalue.
                    ASSIGN (zvalue) TO <fv>.
                    IF <fv> IS ASSIGNED.
                      IF optn = 'EQ'.
                        IF <fe> = <fv>.
                          zfld = sfld.
                        ELSE.
                          zfld = 'X'.
                        ENDIF.
                      ELSEIF optn = 'GT'.
                        IF <fe> > <fv>.
                          zfld = sfld.
                        ELSE.
                          zfld = 'X'.
                        ENDIF.
                      ELSEIF optn = 'LT'.
                        IF <fe> < <fv>.
                          zfld = sfld.
                        ELSE.
                          zfld = 'X'.
                        ENDIF.
                      ELSEIF optn = 'NE'.
                        IF <fe> <> <fv>.
                          zfld = sfld.
                        ELSE.
                          zfld = 'X'.
                        ENDIF.
                      ELSEIF optn = 'CP'.
                        IF <fe> CP <fv>.
                          zfld = sfld.
                        ELSE.
                          zfld = 'X'.
                        ENDIF.
                      ELSEIF optn = 'LE'.
                        IF <fe> <= <fv>.
                          zfld = sfld.
                        ELSE.
                          zfld = 'X'.
                        ENDIF.
                      ELSEIF optn = 'GE'.
                        IF <fe> >= <fv>.
                          zfld = sfld.
                        ELSE.
                          zfld = 'X'.
                        ENDIF.
                      ENDIF.
                    ENDIF.

                  ELSE.
                    IF optn = 'EQ'.
                      IF <fe> = value.
                        zfld = sfld.
                      ELSE.
                        zfld = 'X'.
                      ENDIF.
                    ELSEIF optn = 'GT'.
                      IF <fe> > value.
                        zfld = sfld.
                      ELSE.
                        zfld = 'X'.
                      ENDIF.
                    ELSEIF optn = 'LT'.
                      IF <fe> < value.
                        zfld = sfld.
                      ELSE.
                        zfld = 'X'.
                      ENDIF.
                    ELSEIF optn = 'NE'.
                      IF <fe> <> value.
                        zfld = sfld.
                      ELSE.
                        zfld = 'X'.
                      ENDIF.
                    ELSEIF optn = 'CP'.
                      IF <fe> CP value.
                        zfld = sfld.
                      ELSE.
                        zfld = 'X'.
                      ENDIF.
                    ELSEIF optn = 'LE'.
                      IF <fe> <= value.
                        zfld = sfld.
                      ELSE.
                        zfld = 'X'.
                      ENDIF.
                    ELSEIF optn = 'GE'.
                      IF <fe> >= value.
                        zfld = sfld.
                      ELSE.
                        zfld = 'X'.
                      ENDIF.
                    ENDIF.
                  ENDIF.
                  num2 += 1.
                ELSE.

                  IF zfld IS NOT INITIAL AND zfld <> 'X'.

                    READ TABLE lt_0060 INTO ls_0060 WITH KEY bklas = <lf_data>-bklas
                                                 werks = <lf_data>-werks
                                                 zsfld  = zfld.
                    IF sy-subrc = 0.

                      "플랜트 물류 예외처리
                      IF <lf_data>-belnr IS NOT INITIAL.
                        CLEAR: fieldm,
                               fielda.
                        <fm1> -= <lf_data>-menge.
                        CONCATENATE '<lf_list>-' zfld 'M' INTO fieldm.
                        ASSIGN (fieldm) TO FIELD-SYMBOL(<fm2>).
                        IF <fm2> IS ASSIGNED.
                          IF <lf_data>-zsbgb <> ls_0060-zsbgb.
                            <fm2> -= <lf_data>-menge.
                          ELSE.
                            <fm2> += <lf_data>-menge.
                          ENDIF.
                        ENDIF.
                        UNASSIGN <fm2>.

                        <fa1> -= <lf_data>-hsl.
                        CONCATENATE '<lf_list>-' zfld 'A' INTO fielda.
                        ASSIGN (fielda) TO FIELD-SYMBOL(<fa2>).
                        IF <fa2> IS ASSIGNED.
                          IF <lf_data>-zsbgb <> ls_0060-zsbgb.
                            <fa2> -= <lf_data>-hsl.
                          ELSE.
                            <fa2> += <lf_data>-hsl.
                          ENDIF.
                        ENDIF.
                        UNASSIGN <fa2>.

                        "일별 물류 예외처리
                        CLEAR: fieldm,
                               fielda.
                        <fmd1> -= <lf_data>-menge.
                        CONCATENATE '<lf_listd>-' zfld 'M' INTO fieldm.
                        ASSIGN (fieldm) TO FIELD-SYMBOL(<fmd2>).
                        IF <fmd2> IS ASSIGNED.
                          IF <lf_data>-zsbgb <> ls_0060-zsbgb.
                            <fmd2> -= <lf_data>-menge.
                          ELSE.
                            <fmd2> += <lf_data>-menge.
                          ENDIF.
                        ENDIF.
                        UNASSIGN <fmd2>.

                        <fad1> -= <lf_data>-hsl.
                        CONCATENATE '<lf_listd>-' zfld 'A' INTO fielda.
                        ASSIGN (fielda) TO FIELD-SYMBOL(<fad2>).
                        IF <fad2> IS ASSIGNED.
                          IF <lf_data>-zsbgb <> ls_0060-zsbgb.
                            <fad2> -= <lf_data>-hsl.
                          ELSE.
                            <fad2> += <lf_data>-hsl.
                          ENDIF.
                        ENDIF.
                        UNASSIGN <fad2>.

                        <lf_data>-zsfld = ls_0060-zsfld.
                        <lf_data>-zsbgb = ls_0060-zsbgb.
                      ENDIF.

                      IF lv_ch2 = 'X'.
                        "저장위치 물류 예외처리
                        CLEAR: fieldm,
                               fielda.
                        <fml1> -= <lf_data>-menge.
                        CONCATENATE '<lf_listl>-' zfld 'M' INTO fieldm.
                        ASSIGN (fieldm) TO FIELD-SYMBOL(<fml2>).
                        IF <fml2> IS ASSIGNED.
                          IF <lf_data>-zsbgb <> ls_0060-zsbgb.
                            <fml2> -= <lf_data>-menge.
                          ELSE.
                            <fml2> += <lf_data>-menge.
                          ENDIF.
                        ENDIF.
                        UNASSIGN <fml2>.

                        <fal1> -= <lf_data>-hsl.
                        CONCATENATE '<lf_listl>-' zfld 'A' INTO fielda.
                        ASSIGN (fielda) TO FIELD-SYMBOL(<fal2>).
                        IF <fal2> IS ASSIGNED.
                          IF <lf_data>-zsbgb <> ls_0060-zsbgb.
                            <fal2> -= <lf_data>-hsl.
                          ELSE.
                            <fal2> += <lf_data>-hsl.
                          ENDIF.
                        ENDIF.
                        UNASSIGN <fal2>.
                      ENDIF.
                    ENDIF.
                  ENDIF.

                  EXIT.
                ENDIF.
              ENDDO.
              num1 += 1.
            ELSE.
              EXIT.
            ENDIF.

          ENDDO.





*          CLEAR: f,
*                 zfld.
*          LOOP AT lt_0080 INTO ls_0080 WHERE werks = <lf_data>-werks AND bklas = <lf_data>-bklas.
*            AT NEW zaexc.
*              CLEAR: f,
*                     zfld.
*            ENDAT.
*
*            UNASSIGN <fe>.
*            UNASSIGN <fv>.
*            CLEAR: zfield.
*            CONCATENATE '<lf_data>-' ls_0080-zfield INTO zfield.
*            ASSIGN (zfield) TO <fe>.
*            IF <fe> IS ASSIGNED.
*              IF zfld <> 'X'.
*
*                IF ls_0080-zvalue+0(1) = ':'.
*                  CLEAR: zvalue.
*                  CONCATENATE '<lf_data>-' ls_0080-zvalue+1(20) INTO zvalue.
*                  ASSIGN (zvalue) TO <fv>.
*                  IF <fv> IS ASSIGNED.
*                    IF ls_0080-zoptn = 'EQ'.
*                      IF <fe> = <fv>.
*                        zfld = ls_0080-zsfld.
*                      ELSE.
*                        zfld = 'X'.
*                      ENDIF.
*                    ELSEIF ls_0080-zoptn = 'GT'.
*                      IF <fe> > <fv>.
*                        zfld = ls_0080-zsfld.
*                      ELSE.
*                        zfld = 'X'.
*                      ENDIF.
*                    ELSEIF ls_0080-zoptn = 'LT'.
*                      IF <fe> < <fv>.
*                        zfld = ls_0080-zsfld.
*                      ELSE.
*                        zfld = 'X'.
*                      ENDIF.
*                    ELSEIF ls_0080-zoptn = 'NE'.
*                      IF <fe> <> <fv>.
*                        zfld = ls_0080-zsfld.
*                      ELSE.
*                        zfld = 'X'.
*                      ENDIF.
*                    ELSEIF ls_0080-zoptn = 'CP'.
*                      IF <fe> CP <fv>.
*                        zfld = ls_0080-zsfld.
*                      ELSE.
*                        zfld = 'X'.
*                      ENDIF.
*                    ELSEIF ls_0080-zoptn = 'LE'.
*                      IF <fe> <= <fv>.
*                        zfld = ls_0080-zsfld.
*                      ELSE.
*                        zfld = 'X'.
*                      ENDIF.
*                    ELSEIF ls_0080-zoptn = 'GE'.
*                      IF <fe> >= <fv>.
*                        zfld = ls_0080-zsfld.
*                      ELSE.
*                        zfld = 'X'.
*                      ENDIF.
*                    ENDIF.
*                  ENDIF.
*
*                ELSE.
*
*                  IF ls_0080-zoptn = 'EQ'.
*                    IF <fe> = ls_0080-zvalue.
*                      zfld = ls_0080-zsfld.
*                    ELSE.
*                      zfld = 'X'.
*                    ENDIF.
*                  ELSEIF ls_0080-zoptn = 'GT'.
*                    IF <fe> > ls_0080-zvalue.
*                      zfld = ls_0080-zsfld.
*                    ELSE.
*                      zfld = 'X'.
*                    ENDIF.
*                  ELSEIF ls_0080-zoptn = 'LT'.
*                    IF <fe> < ls_0080-zvalue.
*                      zfld = ls_0080-zsfld.
*                    ELSE.
*                      zfld = 'X'.
*                    ENDIF.
*                  ELSEIF ls_0080-zoptn = 'NE'.
*                    IF <fe> <> ls_0080-zvalue.
*                      zfld = ls_0080-zsfld.
*                    ELSE.
*                      zfld = 'X'.
*                    ENDIF.
*                  ELSEIF ls_0080-zoptn = 'CP'.
*                    IF <fe> CP ls_0080-zvalue.
*                      zfld = ls_0080-zsfld.
*                    ELSE.
*                      zfld = 'X'.
*                    ENDIF.
*                  ELSEIF ls_0080-zoptn = 'LE'.
*                    IF <fe> <= ls_0080-zvalue.
*                      zfld = ls_0080-zsfld.
*                    ELSE.
*                      zfld = 'X'.
*                    ENDIF.
*                  ELSEIF ls_0080-zoptn = 'GE'.
*                    IF <fe> >= ls_0080-zvalue.
*                      zfld = ls_0080-zsfld.
*                    ELSE.
*                      zfld = 'X'.
*                    ENDIF.
*                  ENDIF.
*                ENDIF.
*              ENDIF.
*            ENDIF.
*
*            AT END OF zaexc.
*              f = 'X'.
*            ENDAT.
*
*            "F = 'X' 예외조건번호의 마지막 라인까지 수행되었다.
*            "ZFLD = 'X' 예외조건이 값과 다를 때
*            "ZFLD IS NOT INITIAL 예외조건의 값이 일치할 때
*            IF f = 'X' AND zfld IS NOT INITIAL AND zfld <> 'X'.
*
*              READ TABLE lt_0060 INTO ls_0060 WITH KEY bklas = <lf_data>-bklas
*                                           werks = <lf_data>-werks
*                                           zsfld  = zfld.
*              IF sy-subrc = 0.
*
*                "플랜트 물류 예외처리
*                IF <lf_data>-belnr IS NOT INITIAL.
*                  CLEAR: fieldm,
*                         fielda.
*                  <fm1> -= <lf_data>-menge.
*                  CONCATENATE '<lf_list>-' zfld 'M' INTO fieldm.
*                  ASSIGN (fieldm) TO FIELD-SYMBOL(<fm2>).
*                  IF <fm2> IS ASSIGNED.
*                    IF <lf_data>-zsbgb <> ls_0060-zsbgb.
*                      <fm2> -= <lf_data>-menge.
*                    ELSE.
*                      <fm2> += <lf_data>-menge.
*                    ENDIF.
*                  ENDIF.
*                  UNASSIGN <fm2>.
*
*                  <fa1> -= <lf_data>-hsl.
*                  CONCATENATE '<lf_list>-' zfld 'A' INTO fielda.
*                  ASSIGN (fielda) TO FIELD-SYMBOL(<fa2>).
*                  IF <fa2> IS ASSIGNED.
*                    IF <lf_data>-zsbgb <> ls_0060-zsbgb.
*                      <fa2> -= <lf_data>-hsl.
*                    ELSE.
*                      <fa2> += <lf_data>-hsl.
*                    ENDIF.
*                  ENDIF.
*                  UNASSIGN <fa2>.
*
*                  "일별 물류 예외처리
*                  CLEAR: fieldm,
*                         fielda.
*                  <fmd1> -= <lf_data>-menge.
*                  CONCATENATE '<lf_listd>-' zfld 'M' INTO fieldm.
*                  ASSIGN (fieldm) TO FIELD-SYMBOL(<fmd2>).
*                  IF <fmd2> IS ASSIGNED.
*                    IF <lf_data>-zsbgb <> ls_0060-zsbgb.
*                      <fmd2> -= <lf_data>-menge.
*                    ELSE.
*                      <fmd2> += <lf_data>-menge.
*                    ENDIF.
*                  ENDIF.
*                  UNASSIGN <fmd2>.
*
*                  <fad1> -= <lf_data>-hsl.
*                  CONCATENATE '<lf_listd>-' zfld 'A' INTO fielda.
*                  ASSIGN (fielda) TO FIELD-SYMBOL(<fad2>).
*                  IF <fad2> IS ASSIGNED.
*                    IF <lf_data>-zsbgb <> ls_0060-zsbgb.
*                      <fad2> -= <lf_data>-hsl.
*                    ELSE.
*                      <fad2> += <lf_data>-hsl.
*                    ENDIF.
*                  ENDIF.
*                  UNASSIGN <fad2>.
*
*                  <lf_data>-zsfld = ls_0060-zsfld.
*                  <lf_data>-zsbgb = ls_0060-zsbgb.
*                ENDIF.
*
*                "저장위치 물류 예외처리
*
*                CLEAR: fieldm,
*                       fielda.
*                <fml1> -= <lf_data>-menge.
*                CONCATENATE '<lf_listl>-' zfld 'M' INTO fieldm.
*                ASSIGN (fieldm) TO FIELD-SYMBOL(<fml2>).
*                IF <fml2> IS ASSIGNED.
*                  IF <lf_data>-zsbgb <> ls_0060-zsbgb.
*                    <fml2> -= <lf_data>-menge.
*                  ELSE.
*                    <fml2> += <lf_data>-menge.
*                  ENDIF.
*                ENDIF.
*                UNASSIGN <fml2>.
*
*                <fal1> -= <lf_data>-hsl.
*                CONCATENATE '<lf_listl>-' zfld 'A' INTO fielda.
*                ASSIGN (fielda) TO FIELD-SYMBOL(<fal2>).
*                IF <fal2> IS ASSIGNED.
*                  IF <lf_data>-zsbgb <> ls_0060-zsbgb.
*                    <fal2> -= <lf_data>-hsl.
*                  ELSE.
*                    <fal2> += <lf_data>-hsl.
*                  ENDIF.
*                ENDIF.
*                UNASSIGN <fal2>.
*              ENDIF.
*            ENDIF.
*
*          ENDLOOP.

          "재무기준 수불 데이터
          IF <lf_data>-belnr IS NOT INITIAL.
            CLEAR: lv_hsl, lv_mng.
            IF <lf_data>-hsl <> 0.
              lv_hsl = <lf_data>-hsl / 100.
            ELSE.
              lv_hsl = 0.
            ENDIF.

            lv_mng = <lf_data>-menge.
            READ TABLE lt_0060 INTO ls_0060 WITH KEY bklas = <lf_data>-bklas
                                           werks = <lf_data>-werks
                                           zsfld  = <lf_data>-zsfld.
            IF sy-subrc = 0.
              IF ls_0060-zsbgb = 'O'.
                lv_hsl = lv_hsl * -1.
                lv_mng = lv_mng * -1.
              ENDIF.
            ENDIF.


            CLEAR ls_lista.
            MOVE-CORRESPONDING <lf_data> TO ls_lista.
            ls_lista-spmon = key-%param-spmons.
            ls_lista-menge = lv_mng.
            IF ls_lista-ktosl = 'BSX'.
              ls_lista-dmbtr = lv_hsl.
              ls_lista-dmbtr2 = lv_hsl.
*              IF <lf_data>-mlptyp <> 'BB'.
              ls_lista-dmbtr3 = lv_hsl.
*              ENDIF.
            ELSEIF ls_lista-ktosl+0(2) = 'PR' OR ls_lista-ktosl = 'AUM' OR ls_lista-ktosl = 'KDM' OR ls_lista-ktosl = 'UMB'.
              CLEAR ls_lista-menge.
              ls_lista-dmbtr1 = lv_hsl.
              ls_lista-dmbtr2 = lv_hsl.
*              IF <lf_data>-mlptyp <> 'BB'.
              ls_lista-dmbtr3 = lv_hsl.
*              ENDIF.
            ELSE.
              CLEAR ls_lista-menge.
              ls_lista-dmbtr3 = lv_hsl.
            ENDIF.

            CLEAR ls_data8.
            MOVE-CORRESPONDING ls_lista TO ls_data8.

            READ TABLE lt_lista ASSIGNING FIELD-SYMBOL(<lf_lista>) WITH KEY spmon = ls_lista-spmon
                                                                       kalnr = ls_lista-kalnr
                                                                       zsfld = ls_lista-zsfld
                                                                       racct = ls_lista-racct
                                                                       ktosl = ls_lista-ktosl
                                                                       reftxt = ls_lista-reftxt.
            IF sy-subrc = 0.
              <lf_lista>-menge += ls_lista-menge.
              <lf_lista>-dmbtr += ls_lista-dmbtr.
              <lf_lista>-dmbtr1 += ls_lista-dmbtr1.
              <lf_lista>-dmbtr2 += ls_lista-dmbtr2.
              <lf_lista>-dmbtr3 += ls_lista-dmbtr3.
            ELSE.
              APPEND ls_lista TO lt_lista.
              CLEAR ls_lista.
            ENDIF.
            CLEAR ls_lista.

            COLLECT ls_data8 INTO lt_data8.
            CLEAR ls_data8.

            "재무기준 수불부 비교계정 리스트 취합.
            IF <lf_data>-awtyp = 'RMRP' AND <lf_data>-blart = 'RE' AND <lf_data>-kalnr IS NOT INITIAL
              AND <lf_data>-ktosl <> 'EIN' AND <lf_data>-ktosl <> 'EKG' AND <lf_data>-ktosl <> 'FRE'.
              lv_hsl =  lv_hsl * -1.

              MOVE-CORRESPONDING <lf_data> TO ls_lista.
              ls_lista-spmon = key-%param-spmons.
              ls_lista-zsfld = <lf_data>-zsfld.
              ls_lista-racct = <lf_data>-gkont.
              ls_lista-ktosl = 'RE'.
              CLEAR ls_lista-menge.
              ls_lista-dmbtr3 = lv_hsl.

              READ TABLE lt_lista ASSIGNING <lf_lista> WITH KEY spmon = ls_lista-spmon
                                                                kalnr = ls_lista-kalnr
                                                                zsfld = ls_lista-zsfld
                                                                racct = ls_lista-racct
                                                                ktosl = ls_lista-ktosl
                                                                reftxt = ls_lista-reftxt.
              IF sy-subrc = 0.
                <lf_lista>-dmbtr3 += ls_lista-dmbtr3.
              ELSE.
                APPEND ls_lista TO lt_lista.
              ENDIF.
              CLEAR ls_lista.
            ENDIF.

          ENDIF.

          "--[물류데이터 개별 인터널테이블 할당]------------------------------------------------------------------------------------
          IF <lf_data>-mlptyp = 'BF'.
            "오더정산 배분을 위한 데이터 따로 collect(플랜트 기준)
            MOVE-CORRESPONDING <lf_data> TO ls_auak1.
            COLLECT ls_auak1 INTO lt_auak1.
            CLEAR ls_auak1.

            "오더정산 배분을 위한 데이터 따로 collect(저장위치 기준)
            MOVE-CORRESPONDING <lf_data> TO ls_auak3.
            COLLECT ls_auak3 INTO lt_auak3.
            CLEAR ls_auak3.

            "오더정산 배분을 위한 데이터 따로 collect(오더별 총 입고수량 계산을 위한 데이터)
            MOVE-CORRESPONDING <lf_data> TO ls_auak2.
            COLLECT ls_auak2 INTO lt_auak2.
            CLEAR ls_auak2.

            "생산입고 배분을 위한 데이터 따로 collect(플랜트 기준)
            MOVE-CORRESPONDING <lf_data> TO ls_bf1.
            COLLECT ls_bf1 INTO lt_bf1.
            CLEAR ls_bf1.

            "생산입고 배분을 위한 데이터 따로 collect(저장위치 기준)
            MOVE-CORRESPONDING <lf_data> TO ls_bf3.
            COLLECT ls_bf3 INTO lt_bf3.
            CLEAR ls_bf3.

            "생산입고 배분을 위한 데이터 따로 collect(오더별 총 입고수량 계산을 위한 데이터)
            MOVE-CORRESPONDING <lf_data> TO ls_bf2.
            COLLECT ls_bf2 INTO lt_bf2.
            CLEAR ls_bf2.

            "액티비티 배분을 위한 데이터 따로 collect(플랜트 기준)
            MOVE-CORRESPONDING <lf_data> TO ls_ac1.
            COLLECT ls_ac1 INTO lt_ac1.
            CLEAR ls_ac1.

            "액티비티 배분을 위한 데이터 따로 collect(저장위치 기준)
            MOVE-CORRESPONDING <lf_data> TO ls_ac3.
            COLLECT ls_ac3 INTO lt_ac3.
            CLEAR ls_ac3.

            "액티비티 배분을 위한 데이터 따로 collect(자재기준 생산입고수량 계산을 위한 데이터)
            MOVE-CORRESPONDING <lf_data> TO ls_ac2.
            COLLECT ls_ac2 INTO lt_ac2.
            CLEAR ls_ac2.
          ENDIF.

          IF <lf_data>-mlptyp = 'BL'.
            "외주입고 배분을 위한 데이터 따로 collect(플랜트 기준)
            MOVE-CORRESPONDING <lf_data> TO ls_bl1.
            COLLECT ls_bl1 INTO lt_bl1.
            CLEAR ls_bl1.

            "외주입고 배분을 위한 데이터 따로 collect(저장위치 기준)
            MOVE-CORRESPONDING <lf_data> TO ls_bl3.
            COLLECT ls_bl3 INTO lt_bl3.
            CLEAR ls_bl3.

            "외주입고 배분을 위한 데이터 따로 collect(오더별 총 입고수량 계산을 위한 데이터)
            MOVE-CORRESPONDING <lf_data> TO ls_bl2.
            COLLECT ls_bl2 INTO lt_bl2.
            CLEAR ls_bl2.
          ENDIF.

          IF <lf_data>-mlptyp = 'BUBM' OR <lf_data>-mlptyp = 'BU' OR <lf_data>-mlptyp = 'BUBS' .
            "이동 재평가 배분을 위한 데이터 따로 Collect(플랜트 기준)
            MOVE-CORRESPONDING <lf_data> TO ls_trr1.
            COLLECT ls_trr1 INTO lt_trr1.
            CLEAR ls_trr1.

            "이동 재평가 배분을 위한 데이터 따로 Collect(저장위치 기준)
            MOVE-CORRESPONDING <lf_data> TO ls_trr2.
            COLLECT ls_trr2 INTO lt_trr2.
            CLEAR ls_trr2.

            "이동 재평가 배분을 위한 데이터 따로 Collect(소비재평가 기준 출고수량 계산을 위한 데이터)
            MOVE-CORRESPONDING <lf_data> TO ls_trr3.
            COLLECT ls_trr3 INTO lt_trr3.
            CLEAR ls_trr3.

          ENDIF.

          IF <lf_data>-mlcat = 'VN'.

            IF <lf_data>-mlptyp = 'VUBM' OR <lf_data>-mlptyp = 'VU' OR <lf_data>-mlptyp = 'VF' OR <lf_data>-mlptyp = 'VL' OR <lf_data>-mlptyp = 'VUBS'.
*              "생산오더 완료 여부 확인에 따른 취합 인터널 테이블 구분.
              IF <lf_data>-mlptyp = 'VF'.
                CLEAR ls_data5.
                READ TABLE lt_data5f INTO ls_data5 WITH KEY fkalnr = <lf_data>-kalnr
                                              aufnr = <lf_data>-aufnr
                                              gb = ''.
                IF sy-subrc = 0.
                  IF ls_data5-tkalnr IS INITIAL OR ls_data5-tkalnr = '000000000000'.
                    CLEAR ls_data5.
                    READ TABLE lt_data5f INTO ls_data5 WITH KEY fkalnr = <lf_data>-kalnr
                                              aufnr = <lf_data>-aufnr
                                              gb = 'X'.
                    IF ls_data5-tkalnr IS INITIAL OR ls_data5-tkalnr = '000000000000'.
                      "wip 출고(재공품) 건 따로 취합.
                      MOVE-CORRESPONDING <lf_data> TO ls_triwv.
                      COLLECT ls_triwv INTO lt_triwv.
                      CLEAR ls_triwv.
                    ELSE.
                      IF <lf_data>-umkal IS INITIAL OR <lf_data>-umkal = '000000000000'.
                        <lf_data>-umkal = ls_data5-tkalnr.
                      ENDIF.
                      "이동 재평가 배분을 위한 데이터 따로 Collect(플랜트 기준)
                      MOVE-CORRESPONDING <lf_data> TO ls_tri1.

                      COLLECT ls_tri1 INTO lt_tri1.
                      CLEAR ls_tri1.

                      "이동 재평가 배분을 위한 데이터 따로 Collect(저장위치 기준)
                      MOVE-CORRESPONDING <lf_data> TO ls_tri2.
                      COLLECT ls_tri2 INTO lt_tri2.
                      CLEAR ls_tri2.

                      "이동 재평가 배분을 위한 데이터 따로 Collect(소비재평가 기준 출고수량 계산을 위한 데이터)
                      MOVE-CORRESPONDING <lf_data> TO ls_tri3.
                      COLLECT ls_tri3 INTO lt_tri3.
                      CLEAR ls_tri3.
                    ENDIF.
                  ELSE.
                    IF <lf_data>-umkal IS INITIAL OR <lf_data>-umkal = '000000000000'.
                      <lf_data>-umkal = ls_data5-tkalnr.
                    ENDIF.
                    "이동 재평가 배분을 위한 데이터 따로 Collect(플랜트 기준)
                    MOVE-CORRESPONDING <lf_data> TO ls_tri1.
                    COLLECT ls_tri1 INTO lt_tri1.
                    CLEAR ls_tri1.

                    "이동 재평가 배분을 위한 데이터 따로 Collect(저장위치 기준)
                    MOVE-CORRESPONDING <lf_data> TO ls_tri2.
                    COLLECT ls_tri2 INTO lt_tri2.
                    CLEAR ls_tri2.

                    "이동 재평가 배분을 위한 데이터 따로 Collect(소비재평가 기준 출고수량 계산을 위한 데이터)
                    MOVE-CORRESPONDING <lf_data> TO ls_tri3.
                    COLLECT ls_tri3 INTO lt_tri3.
                    CLEAR ls_tri3.
                  ENDIF.
                ENDIF.
              ELSE.
*              IF <lf_data>-mlptyp = 'VF'.
*                IF <lf_data>-mostatus1 = 'X' AND <lf_data>-mostatus2 = 'X'.
*                  "이동 재평가 배분을 위한 데이터 따로 Collect(플랜트 기준)
*                  MOVE-CORRESPONDING <lf_data> TO ls_tri1.
*                  COLLECT ls_tri1 INTO lt_tri1.
*                  CLEAR ls_tri1.
*
*                  "이동 재평가 배분을 위한 데이터 따로 Collect(저장위치 기준)
*                  MOVE-CORRESPONDING <lf_data> TO ls_tri2.
*                  COLLECT ls_tri2 INTO lt_tri2.
*                  CLEAR ls_tri2.
*
*                  "이동 재평가 배분을 위한 데이터 따로 Collect(소비재평가 기준 출고수량 계산을 위한 데이터)
*                  MOVE-CORRESPONDING <lf_data> TO ls_tri3.
*                  COLLECT ls_tri3 INTO lt_tri3.
*                  CLEAR ls_tri3.
*                ELSE.
*                  "wip 출고(재공품) 건 따로 취합.
*                  MOVE-CORRESPONDING <lf_data> TO ls_triwv.
*                  COLLECT ls_triwv INTO lt_triwv.
*                  CLEAR ls_triwv.
*                ENDIF.
*
*              ELSE.
                "이동 재평가 배분을 위한 데이터 따로 Collect(플랜트 기준)
                MOVE-CORRESPONDING <lf_data> TO ls_tri1.
                COLLECT ls_tri1 INTO lt_tri1.
                CLEAR ls_tri1.

                "이동 재평가 배분을 위한 데이터 따로 Collect(저장위치 기준)
                MOVE-CORRESPONDING <lf_data> TO ls_tri2.
                COLLECT ls_tri2 INTO lt_tri2.
                CLEAR ls_tri2.

                "이동 재평가 배분을 위한 데이터 따로 Collect(소비재평가 기준 출고수량 계산을 위한 데이터)
                MOVE-CORRESPONDING <lf_data> TO ls_tri3.
                COLLECT ls_tri3 INTO lt_tri3.
                CLEAR ls_tri3.
              ENDIF.

            ELSE.
              "소비재평가 배분을 위한 데이터 따로 Collect(플랜트 기준)
              MOVE-CORRESPONDING <lf_data> TO ls_vn1.
              COLLECT ls_vn1 INTO lt_vn1.
              CLEAR ls_vn1.

              "소비재평가 배분을 위한 데이터 따로 Collect(저장위치 기준)
              MOVE-CORRESPONDING <lf_data> TO ls_vn3.
              COLLECT ls_vn3 INTO lt_vn3.
              CLEAR ls_vn3.

              "소비재평가 배분을 위한 데이터 따로 Collect(소비재평가 기준 출고수량 계산을 위한 데이터)
              MOVE-CORRESPONDING <lf_data> TO ls_vn2.
              COLLECT ls_vn2 INTO lt_vn2.
              CLEAR ls_vn2.

              IF <lf_data>-dcat = 'T'.
                "소비재평가(반품) 배분을 위한 데이터 따로 Collect(플랜트 기준)
                MOVE-CORRESPONDING <lf_data> TO ls_vnr1.
                COLLECT ls_vnr1 INTO lt_vnr1.
                CLEAR ls_vnr1.

                "소비재평가(반품) 배분을 위한 데이터 따로 Collect(저장위치 기준)
                MOVE-CORRESPONDING <lf_data> TO ls_vnr3.
                COLLECT ls_vnr3 INTO lt_vnr3.
                CLEAR ls_vnr3.

                "소비재평가(반품) 배분을 위한 데이터 따로 Collect(소비재평가 기준 출고수량 계산을 위한 데이터)
                MOVE-CORRESPONDING <lf_data> TO ls_vnr2.
                COLLECT ls_vnr2 INTO lt_vnr2.
                CLEAR ls_vnr2.
              ENDIF.
            ENDIF.


          ENDIF.

          UNASSIGN : <lf_list>, <lf_listd>, <lf_listl>.

          UNASSIGN : <fa1>, <fm1>, <fad1>, <fmd1>, <fal1>, <fml1>.

        ENDLOOP.

        UNASSIGN <lf_data>.
        "--[재무기준 수불 추가 데이터]------------------------------------------------------------------------------------
        LOOP AT lt_data_a ASSIGNING <lf_data>.
          IF <lf_data>-shkzg = 'H'.
            <lf_data>-menge *= -1.
          ENDIF.
          <lf_data>-hsl = <lf_data>-hsl * 100.

          CLEAR ls_0060.
          READ TABLE lt_0060 INTO ls_0060 WITH KEY bklas = <lf_data>-bklas
                                                   werks = <lf_data>-werks
                                                   ptyp  = <lf_data>-mlptyp.
          IF ls_0060-zsfld IS NOT INITIAL.
            <lf_data>-zsfld = ls_0060-zsfld.
            <lf_data>-zsbgb = ls_0060-zsbgb.

          ENDIF.


          "--[예외 조건 적용]------------------------------------------------------------------------------------

          CLEAR: num1, num2.
          num1 = '000'.

          DO 40 TIMES.

            CLEAR: zaexc.
            UNASSIGN <fe>.
            CLEAR exfield.
            exfield = 'ls_ex-Zaexc' && num1.
            ASSIGN (exfield) TO <fe>.
            IF <fe> IS ASSIGNED.
              zaexc = <fe>.
            ENDIF.

            IF zaexc IS NOT INITIAL.
              num2 = num1 && '1'.
              CLEAR: f, zfld.
              CLEAR: sfld.
              UNASSIGN <fe>.
              CLEAR exfield.
              exfield = 'ls_ex-Zsfld' && num1.
              ASSIGN (exfield) TO <fe>.
              IF <fe> IS ASSIGNED.
                sfld = <fe>.
              ENDIF.

              DO 5 TIMES.
                IF zfld = 'X'.
                  EXIT.
                ENDIF.

                CLEAR: field.
                UNASSIGN <fe>.
                CLEAR exfield.
                exfield = 'ls_ex-Zfield' && num2.
                ASSIGN (exfield) TO <fe>.
                IF <fe> IS ASSIGNED.
                  field = <fe>.
                ENDIF.

                IF field IS NOT INITIAL.
                  CLEAR: zfield, value, optn.

                  UNASSIGN <fe>.
                  CLEAR exfield.
                  exfield = 'ls_ex-Zoptn' && num2.
                  ASSIGN (exfield) TO <fe>.
                  IF <fe> IS ASSIGNED.
                    optn = <fe>.
                  ENDIF.

                  UNASSIGN <fe>.
                  CLEAR exfield.
                  exfield = 'ls_ex-Zvalue' && num2.
                  ASSIGN (exfield) TO <fe>.
                  IF <fe> IS ASSIGNED.
                    value = <fe>.
                  ENDIF.


                  CONCATENATE '<lf_data>-' field INTO zfield.
                  ASSIGN (zfield) TO <fe>.
                  IF value+0(1) = ':'.
                    CLEAR: zvalue.
                    CONCATENATE '<lf_data>-' value+1(20) INTO zvalue.
                    ASSIGN (zvalue) TO <fv>.
                    IF <fv> IS ASSIGNED.
                      IF optn = 'EQ'.
                        IF <fe> = <fv>.
                          zfld = sfld.
                        ELSE.
                          zfld = 'X'.
                        ENDIF.
                      ELSEIF optn = 'GT'.
                        IF <fe> > <fv>.
                          zfld = sfld.
                        ELSE.
                          zfld = 'X'.
                        ENDIF.
                      ELSEIF optn = 'LT'.
                        IF <fe> < <fv>.
                          zfld = sfld.
                        ELSE.
                          zfld = 'X'.
                        ENDIF.
                      ELSEIF optn = 'NE'.
                        IF <fe> <> <fv>.
                          zfld = sfld.
                        ELSE.
                          zfld = 'X'.
                        ENDIF.
                      ELSEIF optn = 'CP'.
                        IF <fe> CP <fv>.
                          zfld = sfld.
                        ELSE.
                          zfld = 'X'.
                        ENDIF.
                      ELSEIF optn = 'LE'.
                        IF <fe> <= <fv>.
                          zfld = sfld.
                        ELSE.
                          zfld = 'X'.
                        ENDIF.
                      ELSEIF optn = 'GE'.
                        IF <fe> >= <fv>.
                          zfld = sfld.
                        ELSE.
                          zfld = 'X'.
                        ENDIF.
                      ENDIF.
                    ENDIF.

                  ELSE.
                    IF optn = 'EQ'.
                      IF <fe> = value.
                        zfld = sfld.
                      ELSE.
                        zfld = 'X'.
                      ENDIF.
                    ELSEIF optn = 'GT'.
                      IF <fe> > value.
                        zfld = sfld.
                      ELSE.
                        zfld = 'X'.
                      ENDIF.
                    ELSEIF optn = 'LT'.
                      IF <fe> < value.
                        zfld = sfld.
                      ELSE.
                        zfld = 'X'.
                      ENDIF.
                    ELSEIF optn = 'NE'.
                      IF <fe> <> value.
                        zfld = sfld.
                      ELSE.
                        zfld = 'X'.
                      ENDIF.
                    ELSEIF optn = 'CP'.
                      IF <fe> CP value.
                        zfld = sfld.
                      ELSE.
                        zfld = 'X'.
                      ENDIF.
                    ELSEIF optn = 'LE'.
                      IF <fe> <= value.
                        zfld = sfld.
                      ELSE.
                        zfld = 'X'.
                      ENDIF.
                    ELSEIF optn = 'GE'.
                      IF <fe> >= value.
                        zfld = sfld.
                      ELSE.
                        zfld = 'X'.
                      ENDIF.
                    ENDIF.
                  ENDIF.
                  num2 += 1.
                ELSE.

                  "F = 'X' 예외조건번호의 마지막 라인까지 수행되었다.
                  "ZFLD = 'X' 예외조건이 값과 다를 때
                  "ZFLD IS NOT INITIAL 예외조건의 값이 일치할 때
                  IF zfld IS NOT INITIAL AND zfld <> 'X'.
                    "플랜트 물류 예외처리
                    CLEAR: fieldm,
                           fielda.
                    <lf_data>-zsfld = zfld.
                  ENDIF.
                  EXIT.
                ENDIF.
              ENDDO.
              num1 += 1.
            ELSE.
              EXIT.
            ENDIF.

          ENDDO.





*          CLEAR: f,
*                 zfld.
*          LOOP AT lt_0080 INTO ls_0080 WHERE werks = <lf_data>-werks AND bklas = <lf_data>-bklas.
*            AT NEW zaexc.
*              CLEAR: f,
*                     zfld.
*            ENDAT.
*
*            UNASSIGN : <fe>, <fv>.
*            CLEAR: zfield.
*            CONCATENATE '<lf_data>-' ls_0080-zfield INTO zfield.
*            ASSIGN (zfield) TO <fe>.
*            IF <fe> IS ASSIGNED.
*              IF zfld <> 'X'.
*
*                IF ls_0080-zvalue+0(1) = ':'.
*                  CLEAR: zvalue.
*                  CONCATENATE '<lf_data>-' ls_0080-zvalue+1(20) INTO zvalue.
*                  ASSIGN (zvalue) TO <fv>.
*                  IF <fv> IS ASSIGNED.
*                    IF ls_0080-zoptn = 'EQ'.
*                      IF <fe> = <fv>.
*                        zfld = ls_0080-zsfld.
*                      ELSE.
*                        zfld = 'X'.
*                      ENDIF.
*                    ELSEIF ls_0080-zoptn = 'GT'.
*                      IF <fe> > <fv>.
*                        zfld = ls_0080-zsfld.
*                      ELSE.
*                        zfld = 'X'.
*                      ENDIF.
*                    ELSEIF ls_0080-zoptn = 'LT'.
*                      IF <fe> < <fv>.
*                        zfld = ls_0080-zsfld.
*                      ELSE.
*                        zfld = 'X'.
*                      ENDIF.
*                    ELSEIF ls_0080-zoptn = 'NE'.
*                      IF <fe> <> <fv>.
*                        zfld = ls_0080-zsfld.
*                      ELSE.
*                        zfld = 'X'.
*                      ENDIF.
*                    ELSEIF ls_0080-zoptn = 'CP'.
*                      IF <fe> CP <fv>.
*                        zfld = ls_0080-zsfld.
*                      ELSE.
*                        zfld = 'X'.
*                      ENDIF.
*                    ELSEIF ls_0080-zoptn = 'LE'.
*                      IF <fe> <= <fv>.
*                        zfld = ls_0080-zsfld.
*                      ELSE.
*                        zfld = 'X'.
*                      ENDIF.
*                    ELSEIF ls_0080-zoptn = 'GE'.
*                      IF <fe> >= <fv>.
*                        zfld = ls_0080-zsfld.
*                      ELSE.
*                        zfld = 'X'.
*                      ENDIF.
*                    ENDIF.
*                  ENDIF.
*
*                ELSE.
*
*                  IF ls_0080-zoptn = 'EQ'.
*                    IF <fe> = ls_0080-zvalue.
*                      zfld = ls_0080-zsfld.
*                    ELSE.
*                      zfld = 'X'.
*                    ENDIF.
*                  ELSEIF ls_0080-zoptn = 'GT'.
*                    IF <fe> > ls_0080-zvalue.
*                      zfld = ls_0080-zsfld.
*                    ELSE.
*                      zfld = 'X'.
*                    ENDIF.
*                  ELSEIF ls_0080-zoptn = 'LT'.
*                    IF <fe> < ls_0080-zvalue.
*                      zfld = ls_0080-zsfld.
*                    ELSE.
*                      zfld = 'X'.
*                    ENDIF.
*                  ELSEIF ls_0080-zoptn = 'NE'.
*                    IF <fe> <> ls_0080-zvalue.
*                      zfld = ls_0080-zsfld.
*                    ELSE.
*                      zfld = 'X'.
*                    ENDIF.
*                  ELSEIF ls_0080-zoptn = 'CP'.
*                    IF <fe> CP ls_0080-zvalue.
*                      zfld = ls_0080-zsfld.
*                    ELSE.
*                      zfld = 'X'.
*                    ENDIF.
*                  ELSEIF ls_0080-zoptn = 'LE'.
*                    IF <fe> <= ls_0080-zvalue.
*                      zfld = ls_0080-zsfld.
*                    ELSE.
*                      zfld = 'X'.
*                    ENDIF.
*                  ELSEIF ls_0080-zoptn = 'GE'.
*                    IF <fe> >= ls_0080-zvalue.
*                      zfld = ls_0080-zsfld.
*                    ELSE.
*                      zfld = 'X'.
*                    ENDIF.
*                  ENDIF.
*                ENDIF.
*              ENDIF.
*            ENDIF.
*
*            AT END OF zaexc.
*              f = 'X'.
*            ENDAT.
*
*            "F = 'X' 예외조건번호의 마지막 라인까지 수행되었다.
*            "ZFLD = 'X' 예외조건이 값과 다를 때
*            "ZFLD IS NOT INITIAL 예외조건의 값이 일치할 때
*            IF f = 'X' AND zfld IS NOT INITIAL AND zfld <> 'X'.
*              "플랜트 물류 예외처리
*              CLEAR: fieldm,
*                     fielda.
*              <lf_data>-zsfld = zfld.
*
*            ENDIF.
*
*          ENDLOOP.

          "재무기준 수불 데이터
          IF <lf_data>-belnr IS NOT INITIAL.
            CLEAR lv_hsl.
            IF <lf_data>-hsl <> 0.
              lv_hsl = <lf_data>-hsl / 100.
            ELSE.
              lv_hsl = 0.
            ENDIF.

            CLEAR ls_lista.
            MOVE-CORRESPONDING <lf_data> TO ls_lista.
            ls_lista-spmon = key-%param-spmons.
            IF ls_lista-ktosl = 'BSX'.
              ls_lista-dmbtr = lv_hsl.
              ls_lista-dmbtr2 = lv_hsl.
*              IF <lf_data>-mlptyp <> 'BB'.
              ls_lista-dmbtr3 = lv_hsl.
*              ENDIF.
            ELSEIF ls_lista-ktosl+0(2) = 'PR' OR ls_lista-ktosl = 'AUM' OR ls_lista-ktosl = 'KDM' OR ls_lista-ktosl = 'UMB'..
              CLEAR ls_lista-menge.
              ls_lista-dmbtr1 = lv_hsl.
              ls_lista-dmbtr2 = lv_hsl.
*              IF <lf_data>-mlptyp <> 'BB'.
              ls_lista-dmbtr3 = lv_hsl.
*              ENDIF.
            ELSE.
              CLEAR ls_lista-menge.
              ls_lista-dmbtr3 = lv_hsl.
            ENDIF.

            CLEAR ls_data8.
            MOVE-CORRESPONDING ls_lista TO ls_data8.

            READ TABLE lt_lista ASSIGNING <lf_lista> WITH KEY spmon = ls_lista-spmon
                                                              kalnr = ls_lista-kalnr
                                                              zsfld = ls_lista-zsfld
                                                              racct = ls_lista-racct
                                                              ktosl = ls_lista-ktosl
                                                              reftxt = ls_lista-reftxt.
            IF sy-subrc = 0.
              <lf_lista>-menge += ls_lista-menge.
              <lf_lista>-dmbtr += ls_lista-dmbtr.
              <lf_lista>-dmbtr1 += ls_lista-dmbtr1.
              <lf_lista>-dmbtr2 += ls_lista-dmbtr2.
              <lf_lista>-dmbtr3 += ls_lista-dmbtr3.
            ELSE.
              APPEND ls_lista TO lt_lista.
              CLEAR ls_lista.
            ENDIF.
            CLEAR ls_lista.

            COLLECT ls_data8 INTO lt_data8.
            CLEAR ls_data8.

            "재무기준 수불부 비교계정 리스트 취합.
            IF <lf_data>-awtyp = 'RMRP' AND <lf_data>-blart = 'RE' AND <lf_data>-kalnr IS NOT INITIAL
              AND <lf_data>-ktosl <> 'EIN' AND <lf_data>-ktosl <> 'EKG' AND <lf_data>-ktosl <> 'FRE'.
              lv_hsl =  lv_hsl * -1.

              MOVE-CORRESPONDING <lf_data> TO ls_lista.
              ls_lista-spmon = key-%param-spmons.
              ls_lista-zsfld = <lf_data>-zsfld.
              ls_lista-racct = <lf_data>-gkont.
              ls_lista-ktosl = 'RE'.
              CLEAR ls_lista-menge.
              ls_lista-dmbtr3 = lv_hsl.

              READ TABLE lt_lista ASSIGNING <lf_lista> WITH KEY spmon = ls_lista-spmon
                                                                kalnr = ls_lista-kalnr
                                                                zsfld = ls_lista-zsfld
                                                                racct = ls_lista-racct
                                                                ktosl = ls_lista-ktosl
                                                                reftxt = ls_lista-reftxt.
              IF sy-subrc = 0.
                <lf_lista>-dmbtr3 += ls_lista-dmbtr3.
              ELSE.
                APPEND ls_lista TO lt_lista.
              ENDIF.
              CLEAR ls_lista.
            ENDIF.
          ENDIF.
        ENDLOOP.


        "--[오더정산 할당]------------------------------------------------------------------------------------
*        " 오더정산 금액 오더번호별 할당필드로 배분.
        SORT lt_auak1 BY aufnr.
        SORT lt_auak2 BY aufnr.
        SORT lt_auak3 BY aufnr.
        LOOP AT lt_data4 ASSIGNING FIELD-SYMBOL(<lf_auak>).
          READ TABLE lt_listd INTO ls_listd WITH KEY kalnr = <lf_auak>-kalnr
                                                     budat = <lf_auak>-budat.
          IF sy-subrc <> 0.
            CLEAR ls_listd.
            MOVE-CORRESPONDING <lf_auak> TO ls_listd.
            ls_listd-spmon = key-%param-spmons.
            APPEND ls_listd TO lt_listd.
            CLEAR ls_listd.
          ENDIF.

          READ TABLE lt_list INTO ls_list WITH KEY kalnr = <lf_auak>-kalnr.
          IF sy-subrc <> 0.
            CLEAR ls_list.
            MOVE-CORRESPONDING <lf_auak> TO ls_list.
            ls_list-spmon = key-%param-spmons.
            APPEND ls_list TO lt_list.
            CLEAR ls_list.
          ENDIF.

          <lf_auak>-hsl *= 100.
          READ TABLE lt_auak2 INTO ls_auak2 WITH KEY aufnr = <lf_auak>-aufnr BINARY SEARCH.
          IF sy-subrc = 0.
            IF ls_auak2-menge = 0.
              <lf_auak>-danga = 0.
            ELSE.
              <lf_auak>-danga = <lf_auak>-hsl / ls_auak2-menge.
            ENDIF.
            <lf_auak>-mod = <lf_auak>-hsl.
            <lf_auak>-modd = <lf_auak>-hsl.
            <lf_auak>-modl = <lf_auak>-hsl.

            CLEAR: ly_modm, ly_line.
            LOOP AT lt_auak1 ASSIGNING FIELD-SYMBOL(<lf_auak1>) WHERE aufnr = <lf_auak>-aufnr.

              IF ly_modm IS INITIAL.
                ly_modm = <lf_auak1>-menge.
                ly_line = sy-tabix.
              ELSE.
                IF ly_modm < <lf_auak1>-menge.
                  ly_modm = <lf_auak1>-menge.
                  ly_line = sy-tabix.
                ENDIF.
              ENDIF.

              CLEAR assign_amt.
              assign_amt = <lf_auak>-danga * <lf_auak1>-menge.

              " 수불필드 할당
              UNASSIGN <lf_list>.
              READ TABLE lt_list ASSIGNING <lf_list> WITH KEY kalnr = <lf_auak1>-kalnr.
              IF sy-subrc = 0.

                CLEAR:fielda.
                CONCATENATE '<lf_list>-' <lf_auak1>-zsfld 'A' INTO fielda.
                ASSIGN (fielda) TO FIELD-SYMBOL(<fa3>).
                IF <fa3> IS ASSIGNED.
                  IF <lf_auak1>-zsbgb = 'O'.
                    <fa3> += assign_amt * -1.
                  ELSE.
                    <fa3> += assign_amt.
                  ENDIF.
                  <lf_auak>-mod = <lf_auak>-mod - assign_amt.
                ENDIF.

              ENDIF.
              UNASSIGN <fa3>.
              " 일별수불필드 할당
              UNASSIGN <lf_listd>.
              READ TABLE lt_listd ASSIGNING <lf_listd> WITH KEY kalnr = <lf_auak1>-kalnr
                                                                budat = <lf_auak>-budat.
              IF sy-subrc = 0.
                CLEAR:fielda.
                CONCATENATE '<lf_listd>-' <lf_auak1>-zsfld 'A' INTO fielda.
                ASSIGN (fielda) TO FIELD-SYMBOL(<fad3>).
                IF <fad3> IS ASSIGNED.
                  IF <lf_auak1>-zsbgb = 'O'.
                    <fad3> += assign_amt * -1.
                  ELSE.
                    <fad3> += assign_amt.
                  ENDIF.
                  <lf_auak>-modd = <lf_auak>-modd - assign_amt.
                ENDIF.
              ENDIF.
              UNASSIGN <fad3>.

              "재무기준 수불필드 할당.
              CLEAR lv_hsl.
              IF <lf_auak>-hsl <> 0.
                lv_hsl = assign_amt / 100.
              ELSE.
                lv_hsl = 0.
              ENDIF.

              CLEAR ls_lista.
              MOVE-CORRESPONDING <lf_auak> TO ls_lista.
              ls_lista-spmon = key-%param-spmons.
              ls_lista-zsfld = <lf_auak1>-zsfld.
              IF ls_lista-ktosl = 'BSX'.
                ls_lista-dmbtr = lv_hsl.
                ls_lista-dmbtr2 = lv_hsl.
                ls_lista-dmbtr3 = lv_hsl.
              ELSEIF ls_lista-ktosl+0(2) = 'PR' OR ls_lista-ktosl = 'AUM' OR ls_lista-ktosl = 'KDM' .
                CLEAR ls_lista-menge.
                ls_lista-dmbtr1 = lv_hsl.
                ls_lista-dmbtr2 = lv_hsl.
                ls_lista-dmbtr3 = lv_hsl.
              ELSE.
                CLEAR ls_lista-menge.
                ls_lista-dmbtr3 = lv_hsl.
              ENDIF.

              CLEAR ls_data8.
              MOVE-CORRESPONDING ls_lista TO ls_data8.

              READ TABLE lt_lista ASSIGNING <lf_lista> WITH KEY spmon = ls_lista-spmon
                                                                kalnr = ls_lista-kalnr
                                                                zsfld = ls_lista-zsfld
                                                                racct = ls_lista-racct
                                                                ktosl = ls_lista-ktosl
                                                                reftxt = ls_lista-reftxt.
              IF sy-subrc = 0.
                <lf_lista>-menge += ls_lista-menge.
                <lf_lista>-dmbtr += ls_lista-dmbtr.
                <lf_lista>-dmbtr1 += ls_lista-dmbtr1.
                <lf_lista>-dmbtr2 += ls_lista-dmbtr2.
                <lf_lista>-dmbtr3 += ls_lista-dmbtr3.
              ELSE.
                APPEND ls_lista TO lt_lista.
                CLEAR ls_lista.
              ENDIF.
              CLEAR ls_lista.

              COLLECT ls_data8 INTO lt_data8.
              CLEAR ls_data8.

              "재무기준 수불부 비교계정 리스트 취합.
              lv_hsl =  lv_hsl * -1.

              MOVE-CORRESPONDING <lf_auak> TO ls_lista.
              ls_lista-spmon = key-%param-spmons.
              ls_lista-zsfld = <lf_auak1>-zsfld.
              ls_lista-racct = <lf_auak>-raccta.
              ls_lista-ktosl = 'GBB'.
              CLEAR ls_lista-menge.
              ls_lista-dmbtr3 = lv_hsl.

              READ TABLE lt_lista ASSIGNING <lf_lista> WITH KEY spmon = ls_lista-spmon
                                                                kalnr = ls_lista-kalnr
                                                                zsfld = ls_lista-zsfld
                                                                racct = ls_lista-racct
                                                                ktosl = ls_lista-ktosl
                                                                reftxt = ls_lista-reftxt.
              IF sy-subrc = 0.
                <lf_lista>-dmbtr3 += ls_lista-dmbtr3.
              ELSE.
                APPEND ls_lista TO lt_lista.
              ENDIF.
              CLEAR ls_lista.
            ENDLOOP.

            "단수차이 배분
            IF <lf_auak>-mod <> 0.
              READ TABLE lt_auak1 ASSIGNING <lf_auak1> INDEX ly_line.
              IF sy-subrc = 0.
                UNASSIGN <lf_list>.
                READ TABLE lt_list ASSIGNING <lf_list> WITH KEY kalnr = <lf_auak1>-kalnr.
                IF sy-subrc = 0.

                  CLEAR:fielda.
                  CONCATENATE '<lf_list>-' <lf_auak1>-zsfld 'A' INTO fielda.
                  ASSIGN (fielda) TO <fa3>.
                  IF <fa3> IS ASSIGNED.
                    IF <lf_auak1>-zsbgb = 'O'.
                      <fa3> += <lf_auak>-mod * -1.
                    ELSE.
                      <fa3> += <lf_auak>-mod.
                    ENDIF.
                  ENDIF.
                ENDIF.
                UNASSIGN <fa3>.

                CLEAR lv_hsl.
                IF <lf_auak>-mod <> 0.
                  lv_hsl = <lf_auak>-mod / 100.
                ELSE.
                  lv_hsl = 0.
                ENDIF.

                CLEAR ls_lista.
                MOVE-CORRESPONDING <lf_auak> TO ls_lista.
                ls_lista-spmon = key-%param-spmons.
                ls_lista-zsfld = <lf_auak1>-zsfld.
                IF ls_lista-ktosl = 'BSX'.
                  ls_lista-dmbtr = lv_hsl.
                  ls_lista-dmbtr2 = lv_hsl.
                  ls_lista-dmbtr3 = lv_hsl.
                ELSEIF ls_lista-ktosl+0(2) = 'PR' OR ls_lista-ktosl = 'AUM' OR ls_lista-ktosl = 'KDM' .
                  CLEAR ls_lista-menge.
                  ls_lista-dmbtr1 = lv_hsl.
                  ls_lista-dmbtr2 = lv_hsl.
                  ls_lista-dmbtr3 = lv_hsl.
                ELSE.
                  CLEAR ls_lista-menge.
                  ls_lista-dmbtr3 = lv_hsl.
                ENDIF.

                CLEAR ls_data8.
                MOVE-CORRESPONDING ls_lista TO ls_data8.

                READ TABLE lt_lista ASSIGNING <lf_lista> WITH KEY spmon = ls_lista-spmon
                                                                  kalnr = ls_lista-kalnr
                                                                  zsfld = ls_lista-zsfld
                                                                  racct = ls_lista-racct
                                                                  ktosl = ls_lista-ktosl
                                                                  reftxt = ls_lista-reftxt.
                IF sy-subrc = 0.
                  <lf_lista>-menge += ls_lista-menge.
                  <lf_lista>-dmbtr += ls_lista-dmbtr.
                  <lf_lista>-dmbtr1 += ls_lista-dmbtr1.
                  <lf_lista>-dmbtr2 += ls_lista-dmbtr2.
                  <lf_lista>-dmbtr3 += ls_lista-dmbtr3.
                ENDIF.
                CLEAR ls_lista.

                COLLECT ls_data8 INTO lt_data8.
                CLEAR ls_data8.

                "재무기준 수불부 비교계정 리스트 취합.
                lv_hsl =  lv_hsl * -1.

                MOVE-CORRESPONDING <lf_auak> TO ls_lista.
                ls_lista-spmon = key-%param-spmons.
                ls_lista-zsfld = <lf_auak1>-zsfld.
                ls_lista-racct = <lf_auak>-raccta.
                ls_lista-ktosl = 'GBB'.
                CLEAR ls_lista-menge.
                ls_lista-dmbtr3 = lv_hsl.

                READ TABLE lt_lista ASSIGNING <lf_lista> WITH KEY spmon = ls_lista-spmon
                                                                  kalnr = ls_lista-kalnr
                                                                  zsfld = ls_lista-zsfld
                                                                  racct = ls_lista-racct
                                                                  ktosl = ls_lista-ktosl
                                                                  reftxt = ls_lista-reftxt.
                IF sy-subrc = 0.
                  <lf_lista>-dmbtr3 += ls_lista-dmbtr3.
                ENDIF.
                CLEAR ls_lista.
              ENDIF.
            ENDIF.

            IF <lf_auak>-modd <> 0.
              READ TABLE lt_auak1 ASSIGNING <lf_auak1> INDEX ly_line.
              IF sy-subrc = 0.
                UNASSIGN <lf_listd>.
                READ TABLE lt_listd ASSIGNING <lf_listd> WITH KEY kalnr = <lf_auak1>-kalnr
                                                                  budat = <lf_auak>-budat.
                IF sy-subrc = 0.
                  CLEAR:fielda.
                  CONCATENATE '<lf_listd>-' <lf_auak1>-zsfld 'A' INTO fielda.
                  ASSIGN (fielda) TO <fad3>.
                  IF <fad3> IS ASSIGNED.
                    IF <lf_auak1>-zsbgb = 'O'.
                      <fad3> += <lf_auak>-mod * -1.
                    ELSE.
                      <fad3> += <lf_auak>-mod.
                    ENDIF.
                  ENDIF.
                ENDIF.
                UNASSIGN <fad3>.
              ENDIF.
            ENDIF.

            IF lv_ch2 = 'X'.
              CLEAR: ly_modm, ly_line.
              LOOP AT lt_auak3 ASSIGNING FIELD-SYMBOL(<lf_auak3>) WHERE aufnr = <lf_auak>-aufnr.
                IF ly_modm IS INITIAL.
                  ly_modm = <lf_auak3>-menge.
                  ly_line = sy-tabix.
                ELSE.
                  IF ly_modm < <lf_auak3>-menge.
                    ly_modm = <lf_auak3>-menge.
                    ly_line = sy-tabix.
                  ENDIF.
                ENDIF.

                CLEAR assign_amt.
                assign_amt = <lf_auak>-danga * <lf_auak3>-menge.

                "저장위치 수불필드 할당
                UNASSIGN <lf_listl>.
                READ TABLE lt_listl ASSIGNING <lf_listl> WITH KEY kalnr = <lf_auak3>-kalnr
                                                                lgort = <lf_auak3>-lgort
                                                                sobkz = <lf_auak3>-sobkz.
                IF <lf_listl> IS ASSIGNED.

                  CLEAR:fielda.
                  CONCATENATE '<lf_listl>-' <lf_auak3>-zsfld 'A' INTO fielda.
                  ASSIGN (fielda) TO FIELD-SYMBOL(<fal3>).
                  IF <fal3> IS ASSIGNED.
                    IF <lf_auak3>-zsbgb = 'O'.
                      <fal3> += assign_amt * -1.
                    ELSE.
                      <fal3> += assign_amt.
                    ENDIF.
                    <lf_auak>-modl = <lf_auak>-modl - assign_amt.
                  ENDIF.

                ENDIF.
                UNASSIGN <fal3>.
              ENDLOOP.

              "단수차이 배분.
              IF <lf_auak>-modl <> 0.
                READ TABLE lt_auak3 ASSIGNING <lf_auak3> INDEX ly_line.
                IF sy-subrc = 0.
                  UNASSIGN <lf_listl>.
                  READ TABLE lt_listl ASSIGNING <lf_listl> WITH KEY kalnr = <lf_auak3>-kalnr
                                                                  lgort = <lf_auak3>-lgort
                                                                  sobkz = <lf_auak3>-sobkz.
                  IF <lf_listl> IS ASSIGNED.
                    CLEAR:fielda.
                    CONCATENATE '<lf_listl>-' <lf_auak3>-zsfld 'A' INTO fielda.
                    ASSIGN (fielda) TO <fal3>.
                    IF <fal3> IS ASSIGNED.
                      IF <lf_auak3>-zsbgb = 'O'.
                        <fal3> += <lf_auak>-modl * -1.
                      ELSE.
                        <fal3> += <lf_auak>-modl.
                      ENDIF.
                    ENDIF.

                  ENDIF.
                  UNASSIGN <fal3>.
                ENDIF.
              ENDIF.
            ENDIF.
          ELSE.
            "오더정산 중 WIP(생산 완료되거나 입고되지 않은)건으로 바로 생산입고(BF)에 차이 지정.

            CLEAR ls_0060.
            READ TABLE lt_0060 INTO ls_0060 WITH KEY bklas = <lf_auak>-bklas
                                                     werks = <lf_auak>-werks
                                                     ptyp  = 'BF'.
            IF ls_0060-zsfld IS NOT INITIAL.

              "생산입고 배분을 위한 데이터 따로 collect(플랜트 기준)
              READ TABLE lt_bf2 INTO ls_bf2 WITH KEY kalnr = <lf_auak>-kalnr.
              IF sy-subrc <> 0.
                MOVE-CORRESPONDING <lf_auak> TO ls_bf1.
                ls_bf1-zsfld = ls_0060-zsfld.
                ls_bf1-zsbgb = ls_0060-zsbgb.
                COLLECT ls_bf1 INTO lt_bf1.
                CLEAR ls_bf1.

                "생산입고 배분을 위한 데이터 따로 collect(저장위치 기준)
                MOVE-CORRESPONDING <lf_auak> TO ls_bf3.
                ls_bf3-zsfld = ls_0060-zsfld.
                ls_bf3-zsbgb = ls_0060-zsbgb.
                COLLECT ls_bf3 INTO lt_bf3.
                CLEAR ls_bf3.

                "생산입고 배분을 위한 데이터 따로 collect(오더별 총 입고수량 계산을 위한 데이터)
                MOVE-CORRESPONDING <lf_auak> TO ls_bf2.
                COLLECT ls_bf2 INTO lt_bf2.
                CLEAR ls_bf2.

                "액티비티 배분을 위한 데이터 따로 collect(플랜트 기준)
                MOVE-CORRESPONDING <lf_auak> TO ls_ac1.
                ls_ac1-zsfld = ls_0060-zsfld.
                ls_ac1-zsbgb = ls_0060-zsbgb.
                COLLECT ls_ac1 INTO lt_ac1.
                CLEAR ls_ac1.

                "액티비티 배분을 위한 데이터 따로 collect(저장위치 기준)
                MOVE-CORRESPONDING <lf_auak> TO ls_ac3.
                ls_ac3-zsfld = ls_0060-zsfld.
                ls_ac3-zsbgb = ls_0060-zsbgb.
                COLLECT ls_ac3 INTO lt_ac3.
                CLEAR ls_ac3.

                "액티비티 배분을 위한 데이터 따로 collect(자재기준 생산입고수량 계산을 위한 데이터)
                MOVE-CORRESPONDING <lf_auak> TO ls_ac2.
                COLLECT ls_ac2 INTO lt_ac2.
                CLEAR ls_ac2.
              ENDIF.

              CLEAR lv_hsl.
              IF <lf_auak>-hsl <> 0.
                lv_hsl = <lf_auak>-hsl / 100.
              ELSE.
                lv_hsl = 0.
              ENDIF.

              IF ls_0060-zsbgb = 'O'.
                <lf_auak>-hsl   *= -1.
              ENDIF.
              " 수불필드 할당
              UNASSIGN <lf_list>.
              READ TABLE lt_list ASSIGNING <lf_list> WITH KEY kalnr = <lf_auak>-kalnr.
              IF <lf_list> IS ASSIGNED.
                CLEAR:fielda.
                CONCATENATE '<lf_list>-' ls_0060-zsfld 'A' INTO fielda.
                ASSIGN (fielda) TO FIELD-SYMBOL(<fa3e>).
                IF <fa3e> IS ASSIGNED.
                  <fa3e> += <lf_auak>-hsl.
                ENDIF.
                UNASSIGN <fa3e>.
              ENDIF.
              " 일별수불필드 할당
              UNASSIGN <lf_listd>.
              READ TABLE lt_listd ASSIGNING <lf_listd> WITH KEY kalnr = <lf_auak>-kalnr
                                                                budat = <lf_auak>-budat.
              IF <lf_listd> IS ASSIGNED.
                CLEAR:fielda.
                CONCATENATE '<lf_listd>-' ls_0060-zsfld 'A' INTO fielda.
                ASSIGN (fielda) TO FIELD-SYMBOL(<fad3e>).
                IF <fad3e> IS ASSIGNED.
                  <fad3e> += <lf_auak>-hsl.
                ENDIF.
                UNASSIGN <fad3e>.
              ENDIF.

              "재무기준 수불필드 할당.
              CLEAR ls_lista.
              MOVE-CORRESPONDING <lf_auak> TO ls_lista.
              ls_lista-spmon = key-%param-spmons.
              ls_lista-zsfld = ls_0060-zsfld.
              IF ls_lista-ktosl = 'BSX'.
                ls_lista-dmbtr = lv_hsl.
                ls_lista-dmbtr2 = lv_hsl.
                ls_lista-dmbtr3 = lv_hsl.
              ELSEIF ls_lista-ktosl+0(2) = 'PR' OR ls_lista-ktosl = 'AUM' OR ls_lista-ktosl = 'KDM'.
                CLEAR ls_lista-menge.
                ls_lista-dmbtr1 = lv_hsl.
                ls_lista-dmbtr2 = lv_hsl.
                ls_lista-dmbtr3 = lv_hsl.
              ELSE.
                CLEAR ls_lista-menge.
                ls_lista-dmbtr3 = lv_hsl.
              ENDIF.

              CLEAR ls_data8.
              MOVE-CORRESPONDING ls_lista TO ls_data8.

              READ TABLE lt_lista ASSIGNING <lf_lista> WITH KEY spmon = ls_lista-spmon
                                                                kalnr = ls_lista-kalnr
                                                                zsfld = ls_lista-zsfld
                                                                racct = ls_lista-racct
                                                                ktosl = ls_lista-ktosl
                                                                reftxt = ls_lista-reftxt.
              IF sy-subrc = 0.
                <lf_lista>-menge += ls_lista-menge.
                <lf_lista>-dmbtr += ls_lista-dmbtr.
                <lf_lista>-dmbtr1 += ls_lista-dmbtr1.
                <lf_lista>-dmbtr2 += ls_lista-dmbtr2.
                <lf_lista>-dmbtr3 += ls_lista-dmbtr3.
              ELSE.
                APPEND ls_lista TO lt_lista.
                CLEAR ls_lista.
              ENDIF.
              CLEAR ls_lista.

              COLLECT ls_data8 INTO lt_data8.
              CLEAR ls_data8.

              "재무기준 수불부 비교계정 리스트 취합.
              lv_hsl =  lv_hsl * -1.

              MOVE-CORRESPONDING <lf_auak> TO ls_lista.
              ls_lista-spmon = key-%param-spmons.
              ls_lista-zsfld = ls_0060-zsfld.
              ls_lista-racct = <lf_auak>-raccta.
              ls_lista-ktosl = 'GBB'.
              CLEAR ls_lista-menge.
              ls_lista-dmbtr3 = lv_hsl.

              READ TABLE lt_lista ASSIGNING <lf_lista> WITH KEY spmon = ls_lista-spmon
                                                                kalnr = ls_lista-kalnr
                                                                zsfld = ls_lista-zsfld
                                                                racct = ls_lista-racct
                                                                ktosl = ls_lista-ktosl
                                                                reftxt = ls_lista-reftxt.
              IF sy-subrc = 0.
                <lf_lista>-dmbtr3 += ls_lista-dmbtr3.
              ELSE.
                APPEND ls_lista TO lt_lista.
              ENDIF.
              CLEAR ls_lista.

              IF lv_ch2 = 'X'.
                "저장위치 수불필드 할당
                READ TABLE lt_moh INTO ls_moh WITH KEY manufacturingorder = <lf_auak>-aufnr.
                IF sy-subrc = 0.
                  UNASSIGN <lf_listl>.
                  READ TABLE lt_listl ASSIGNING <lf_listl> WITH KEY kalnr = <lf_auak>-kalnr
                                                                  lgort = ls_moh-storagelocation.
                  IF sy-subrc = 0.
                    CLEAR:fielda.
                    CONCATENATE '<lf_listl>-' ls_0060-zsfld 'A' INTO fielda.
                    ASSIGN (fielda) TO FIELD-SYMBOL(<fal3e>).
                    IF <fal3e> IS ASSIGNED.
                      <fal3e> += <lf_auak>-hsl.
                    ENDIF.
                    UNASSIGN <fal3e>.
                  ENDIF.
                ENDIF.
              ENDIF.

            ENDIF.

          ENDIF.
        ENDLOOP.


        "--[자재원장결산 차이 할당]------------------------------------------------------------------------------------
        " 자재원장결산 금액 오브젝트별 할당필드로 배분.
        SORT lt_vn1 BY kalnr mgkont coctl kdauf_im kdpos_im.
        SORT lt_vn2 BY kalnr mgkont coctl kdauf_im kdpos_im.
        SORT lt_vn3 BY kalnr mgkont coctl kdauf_im kdpos_im.

        SORT lt_vnr1 BY kalnr mgkont .
        SORT lt_vnr2 BY kalnr mgkont .
        SORT lt_vnr3 BY kalnr mgkont .

        SORT lt_tri1 BY kalnr umkal.
        SORT lt_tri2 BY kalnr umkal.
        SORT lt_tri3 BY kalnr umkal.

        SORT lt_trr1 BY kalnr umkal.
        SORT lt_trr2 BY kalnr umkal.
        SORT lt_trr3 BY kalnr umkal.

        SORT lt_bf1 BY aufnr.
        SORT lt_bf2 BY aufnr.
        SORT lt_bf3 BY aufnr.

        SORT lt_bl1 BY ebeln ebelp.
        SORT lt_bl2 BY ebeln ebelp.
        SORT lt_bl3 BY ebeln ebelp.

        SORT lt_ac1 BY kalnr.
        SORT lt_ac2 BY kalnr.
        SORT lt_ac3 BY kalnr.

        LOOP AT lt_data3 ASSIGNING FIELD-SYMBOL(<lf_mlhd>).
          READ TABLE lt_listd INTO ls_listd WITH KEY kalnr = <lf_mlhd>-kalnr
                                                     budat = <lf_mlhd>-budat.
          IF sy-subrc <> 0.
            CLEAR ls_listd.
            MOVE-CORRESPONDING <lf_mlhd> TO ls_listd.
            ls_listd-spmon = key-%param-spmons.
            APPEND ls_listd TO lt_listd.
            CLEAR ls_listd.
          ENDIF.

          READ TABLE lt_list INTO ls_list WITH KEY kalnr = <lf_mlhd>-kalnr.
          IF sy-subrc <> 0.
            CLEAR ls_list.
            MOVE-CORRESPONDING <lf_mlhd> TO ls_list.
            ls_list-spmon = key-%param-spmons.
            APPEND ls_list TO lt_list.
            CLEAR ls_list.
          ENDIF.

          IF <lf_mlhd>-typ2 IS NOT INITIAL AND <lf_mlhd>-typ3 IS NOT INITIAL.
            CLEAR <lf_mlhd>-typ3.
          ENDIF.
          <lf_mlhd>-hsl *= 100.

          "****WIP출고 소비재평가 배부(생산출고로 배부)****
          IF ( <lf_mlhd>-typ1 = 'VNPRD' OR <lf_mlhd>-typ1 = 'VNKDM' ) AND <lf_mlhd>-typ6 = 'ZUWIP'.
            CLEAR ls_0060.
            READ TABLE lt_0060 INTO ls_0060 WITH KEY bklas = <lf_mlhd>-bklas
                                                     werks = <lf_mlhd>-werks
                                                     ptyp  = 'VF'.
            IF ls_0060-zsfld IS NOT INITIAL.
              CLEAR lv_hsl.
              IF <lf_mlhd>-hsl <> 0.
                lv_hsl = <lf_mlhd>-hsl / 100.
              ELSE.
                lv_hsl = 0.
              ENDIF.

              IF ls_0060-zsbgb = 'O'.
                <lf_mlhd>-hsl   *= -1.
              ENDIF.
              " 수불필드 할당
              UNASSIGN <lf_list>.
              READ TABLE lt_list ASSIGNING <lf_list> WITH KEY kalnr = <lf_mlhd>-kalnr.
              IF sy-subrc = 0.
                CLEAR:fielda.
                CONCATENATE '<lf_list>-' ls_0060-zsfld 'A' INTO fielda.
                ASSIGN (fielda) TO FIELD-SYMBOL(<fawv>).
                IF <fawv> IS ASSIGNED.
                  <fawv> += <lf_mlhd>-hsl.
                ENDIF.
                UNASSIGN <fawv>.
              ENDIF.
            ENDIF.

            " 일별수불필드 할당
            UNASSIGN <lf_listd>.
            READ TABLE lt_listd ASSIGNING <lf_listd> WITH KEY kalnr = <lf_mlhd>-kalnr
                                                              budat = <lf_mlhd>-budat.
            IF <lf_listd> IS ASSIGNED.
              CLEAR:fielda.
              CONCATENATE '<lf_listd>-' ls_0060-zsfld 'A' INTO fielda.
              ASSIGN (fielda) TO FIELD-SYMBOL(<fadwv>).
              IF <fadwv> IS ASSIGNED.
                <fadwv> += <lf_mlhd>-hsl.
              ENDIF.
              UNASSIGN <fadwv>.
            ENDIF.

            "재무기준 수불필드 할당.
            CLEAR ls_lista.
            MOVE-CORRESPONDING <lf_mlhd> TO ls_lista.
            ls_lista-spmon = key-%param-spmons.
            ls_lista-zsfld = ls_0060-zsfld.
            ls_lista-racct = <lf_mlhd>-raccta.
            IF ls_lista-ktosl = 'BSX'.
              ls_lista-dmbtr = lv_hsl.
              ls_lista-dmbtr2 = lv_hsl.
              ls_lista-dmbtr3 = lv_hsl.
            ELSEIF ls_lista-ktosl+0(2) = 'PR' OR ls_lista-ktosl = 'AUM' OR ls_lista-ktosl = 'KDM' .
              CLEAR ls_lista-menge.
              ls_lista-dmbtr1 = lv_hsl.
              ls_lista-dmbtr2 = lv_hsl.
              ls_lista-dmbtr3 = lv_hsl.
            ELSE.
              CLEAR ls_lista-menge.
              ls_lista-dmbtr3 = lv_hsl.
            ENDIF.

            CLEAR ls_data8.
            MOVE-CORRESPONDING ls_lista TO ls_data8.

            READ TABLE lt_lista ASSIGNING <lf_lista> WITH KEY spmon = ls_lista-spmon
                                                              kalnr = ls_lista-kalnr
                                                              zsfld = ls_lista-zsfld
                                                              racct = ls_lista-racct
                                                              ktosl = ls_lista-ktosl
                                                              reftxt = ls_lista-reftxt.
            IF sy-subrc = 0.
              <lf_lista>-menge += ls_lista-menge.
              <lf_lista>-dmbtr += ls_lista-dmbtr.
              <lf_lista>-dmbtr1 += ls_lista-dmbtr1.
              <lf_lista>-dmbtr2 += ls_lista-dmbtr2.
              <lf_lista>-dmbtr3 += ls_lista-dmbtr3.
            ELSE.
              APPEND ls_lista TO lt_lista.
              CLEAR ls_lista.
            ENDIF.
            CLEAR ls_lista.

            COLLECT ls_data8 INTO lt_data8.
            CLEAR ls_data8.

            "재무기준 수불부 비교계정 리스트 취합.
            lv_hsl =  lv_hsl * -1.

            MOVE-CORRESPONDING <lf_mlhd> TO ls_lista.
            ls_lista-spmon = key-%param-spmons.
            ls_lista-zsfld = ls_0060-zsfld.
            ls_lista-racct = <lf_mlhd>-racct.
            ls_lista-ktosl = <lf_mlhd>-ktosl1.
            CLEAR ls_lista-menge.
            ls_lista-dmbtr3 = lv_hsl.

            READ TABLE lt_lista ASSIGNING <lf_lista> WITH KEY spmon = ls_lista-spmon
                                                              kalnr = ls_lista-kalnr
                                                              zsfld = ls_lista-zsfld
                                                              racct = ls_lista-racct
                                                              ktosl = ls_lista-ktosl
                                                              reftxt = ls_lista-reftxt.
            IF sy-subrc = 0.
              <lf_lista>-dmbtr3 += ls_lista-dmbtr3.
            ELSE.
              APPEND ls_lista TO lt_lista.
            ENDIF.
            CLEAR ls_lista.

            IF lv_ch2 = 'X'.
              "저장위치 수불필드 할당
              READ TABLE lt_triwv INTO ls_triwv WITH KEY kalnr = <lf_mlhd>-kalnr.
              IF sy-subrc = 0.
                UNASSIGN <lf_listl>.
                READ TABLE lt_listl ASSIGNING <lf_listl> WITH KEY kalnr = <lf_mlhd>-kalnr
                                                                lgort = ls_triwv-lgort.
                IF sy-subrc = 0.
                  CLEAR:fielda.
                  CONCATENATE '<lf_listl>-' ls_0060-zsfld 'A' INTO fielda.
                  ASSIGN (fielda) TO FIELD-SYMBOL(<falwv>).
                  IF <falwv> IS ASSIGNED.
                    <falwv> += <lf_mlhd>-hsl.
                  ENDIF.
                  UNASSIGN <falwv>.
                ENDIF.
              ENDIF.
            ENDIF.

          ENDIF.



          "****소비재평가 배분(세그먼트 및 계정을 가진)****
          IF ( <lf_mlhd>-typ1 = 'VNPRD' OR <lf_mlhd>-typ1 = 'VNKDM' ) AND <lf_mlhd>-typ2 = 'VERBR' AND <lf_mlhd>-ktosl1 <> 'COC'.
            CLEAR ls_vn2.
            IF <lf_mlhd>-kdauf <> ''.
              READ TABLE lt_vn2 INTO ls_vn2 WITH KEY kalnr = <lf_mlhd>-kalnr
                                                   kdauf_im = <lf_mlhd>-kdauf
                                                   kdpos_im = <lf_mlhd>-kdpos.
            ELSE.
              READ TABLE lt_vn2 INTO ls_vn2 WITH KEY kalnr = <lf_mlhd>-kalnr
                                                   mgkont = <lf_mlhd>-racct
                                                   coctl = <lf_mlhd>-rcntr.
            ENDIF.
            IF sy-subrc = 0.
              IF ls_vn2-menge = 0.
                <lf_mlhd>-danga = 0.
              ELSE.
                <lf_mlhd>-danga = <lf_mlhd>-hsl / ls_vn2-menge.
              ENDIF.
              <lf_mlhd>-mod = <lf_mlhd>-hsl.
              <lf_mlhd>-modd = <lf_mlhd>-hsl.
              <lf_mlhd>-modl = <lf_mlhd>-hsl.
            ENDIF.

            CLEAR: ly_modm, ly_line.
            LOOP AT lt_vn1 ASSIGNING FIELD-SYMBOL(<lf_vn1>) WHERE kalnr = <lf_mlhd>-kalnr
                                                   AND mgkont = <lf_mlhd>-racct
                                                   AND coctl = <lf_mlhd>-rcntr
                                                   AND kdauf_im = <lf_mlhd>-kdauf
                                                   AND kdpos_im = <lf_mlhd>-kdpos.

              IF ly_modm IS INITIAL.
                ly_modm = <lf_vn1>-menge.
                ly_line = sy-tabix.
              ELSE.
                IF ly_modm < <lf_vn1>-menge.
                  ly_modm = <lf_vn1>-menge.
                  ly_line = sy-tabix.
                ENDIF.
              ENDIF.

              CLEAR assign_amt.
              assign_amt = <lf_mlhd>-danga * <lf_vn1>-menge.


              " 수불필드 할당
              UNASSIGN <lf_list>.
              READ TABLE lt_list ASSIGNING <lf_list> WITH KEY kalnr = <lf_vn1>-kalnr.
              IF sy-subrc = 0.
                CLEAR:fielda.
                CONCATENATE '<lf_list>-' <lf_vn1>-zsfld 'A' INTO fielda.
                ASSIGN (fielda) TO FIELD-SYMBOL(<fa4>).
                IF <fa4> IS ASSIGNED.
                  IF <lf_vn1>-zsbgb = 'O'.
                    <fa4> += assign_amt * -1.
                  ELSE.
                    <fa4> += assign_amt.
                  ENDIF.
                  <lf_mlhd>-mod = <lf_mlhd>-mod - assign_amt.
                ENDIF.
                UNASSIGN <fa4>.
              ENDIF.

              " 일별수불필드 할당
              UNASSIGN <lf_listd>.
              READ TABLE lt_listd ASSIGNING <lf_listd> WITH KEY kalnr = <lf_vn1>-kalnr
                                                                budat = <lf_mlhd>-budat.
              IF sy-subrc = 0.
                CLEAR:fielda.
                CONCATENATE '<lf_listd>-' <lf_vn1>-zsfld 'A' INTO fielda.
                ASSIGN (fielda) TO FIELD-SYMBOL(<fad4>).
                IF <fad4> IS ASSIGNED.
                  IF <lf_vn1>-zsbgb = 'O'.
                    <fad4> += assign_amt * -1.
                  ELSE.
                    <fad4> += assign_amt.
                  ENDIF.
                  <lf_mlhd>-modd = <lf_mlhd>-modd - assign_amt.
                ENDIF.
                UNASSIGN <fad4>.
              ENDIF.

              "재무기준 수불필드 할당.
              CLEAR lv_hsl.
              IF <lf_mlhd>-hsl <> 0.
                lv_hsl = assign_amt / 100.
              ELSE.
                lv_hsl = 0.
              ENDIF.

              CLEAR ls_lista.
              MOVE-CORRESPONDING <lf_mlhd> TO ls_lista.
              ls_lista-spmon = key-%param-spmons.
              ls_lista-zsfld = <lf_vn1>-zsfld.
              ls_lista-racct = <lf_mlhd>-raccta.
              IF ls_lista-ktosl = 'BSX'.
                ls_lista-dmbtr = lv_hsl.
                ls_lista-dmbtr2 = lv_hsl.
                ls_lista-dmbtr3 = lv_hsl.
              ELSEIF ls_lista-ktosl+0(2) = 'PR' OR ls_lista-ktosl = 'AUM' OR ls_lista-ktosl = 'KDM' .
                CLEAR ls_lista-menge.
                ls_lista-dmbtr1 = lv_hsl.
                ls_lista-dmbtr2 = lv_hsl.
                ls_lista-dmbtr3 = lv_hsl.
              ELSE.
                CLEAR ls_lista-menge.
                ls_lista-dmbtr3 = lv_hsl.
              ENDIF.

              CLEAR ls_data8.
              MOVE-CORRESPONDING ls_lista TO ls_data8.

              READ TABLE lt_lista ASSIGNING <lf_lista> WITH KEY spmon = ls_lista-spmon
                                                                kalnr = ls_lista-kalnr
                                                                zsfld = ls_lista-zsfld
                                                                racct = ls_lista-racct
                                                                ktosl = ls_lista-ktosl
                                                                reftxt = ls_lista-reftxt.
              IF sy-subrc = 0.
                <lf_lista>-menge += ls_lista-menge.
                <lf_lista>-dmbtr += ls_lista-dmbtr.
                <lf_lista>-dmbtr1 += ls_lista-dmbtr1.
                <lf_lista>-dmbtr2 += ls_lista-dmbtr2.
                <lf_lista>-dmbtr3 += ls_lista-dmbtr3.
              ELSE.
                APPEND ls_lista TO lt_lista.
                CLEAR ls_lista.
              ENDIF.
              CLEAR ls_lista.

              COLLECT ls_data8 INTO lt_data8.
              CLEAR ls_data8.

              "재무기준 수불부 비교계정 리스트 취합.
              lv_hsl =  lv_hsl * -1.

              CLEAR ls_lista.
              MOVE-CORRESPONDING <lf_mlhd> TO ls_lista.
              ls_lista-spmon = key-%param-spmons.
              ls_lista-zsfld = <lf_vn1>-zsfld.
              ls_lista-racct = <lf_mlhd>-racct.
              ls_lista-ktosl = <lf_mlhd>-ktosl1.
              CLEAR ls_lista-menge.
              ls_lista-dmbtr3 = lv_hsl.

              READ TABLE lt_lista ASSIGNING <lf_lista> WITH KEY spmon = ls_lista-spmon
                                                                kalnr = ls_lista-kalnr
                                                                zsfld = ls_lista-zsfld
                                                                racct = ls_lista-racct
                                                                ktosl = ls_lista-ktosl
                                                                reftxt = ls_lista-reftxt.
              IF sy-subrc = 0.
                <lf_lista>-dmbtr3 += ls_lista-dmbtr3.
              ELSE.
                APPEND ls_lista TO lt_lista.
                CLEAR ls_lista.
              ENDIF.
              CLEAR ls_lista.

            ENDLOOP.

            "단수차이 배분
            IF <lf_mlhd>-mod <> 0.
              READ TABLE lt_vn1 ASSIGNING <lf_vn1> INDEX ly_line.
              IF sy-subrc = 0.

                UNASSIGN <lf_list>.
                READ TABLE lt_list ASSIGNING <lf_list> WITH KEY kalnr = <lf_vn1>-kalnr.
                IF sy-subrc = 0.
                  CLEAR:fielda.
                  CONCATENATE '<lf_list>-' <lf_vn1>-zsfld 'A' INTO fielda.
                  ASSIGN (fielda) TO <fa4>.
                  IF <fa4> IS ASSIGNED.
                    IF <lf_vn1>-zsbgb = 'O'.
                      <fa4> += <lf_mlhd>-mod * -1.
                    ELSE.
                      <fa4> += <lf_mlhd>-mod.
                    ENDIF.
                  ENDIF.
                  UNASSIGN <fa4>.
                ENDIF.

                CLEAR lv_hsl.
                IF <lf_mlhd>-mod <> 0.
                  lv_hsl = <lf_mlhd>-mod / 100.
                ELSE.
                  lv_hsl = 0.
                ENDIF.

                CLEAR ls_lista.
                MOVE-CORRESPONDING <lf_mlhd> TO ls_lista.
                ls_lista-spmon = key-%param-spmons.
                ls_lista-zsfld = <lf_vn1>-zsfld.
                ls_lista-racct = <lf_mlhd>-raccta.
                IF ls_lista-ktosl = 'BSX'.
                  ls_lista-dmbtr = lv_hsl.
                  ls_lista-dmbtr2 = lv_hsl.
                  ls_lista-dmbtr3 = lv_hsl.
                ELSEIF ls_lista-ktosl+0(2) = 'PR' OR ls_lista-ktosl = 'AUM' OR ls_lista-ktosl = 'KDM' .
                  CLEAR ls_lista-menge.
                  ls_lista-dmbtr1 = lv_hsl.
                  ls_lista-dmbtr2 = lv_hsl.
                  ls_lista-dmbtr3 = lv_hsl.
                ELSE.
                  CLEAR ls_lista-menge.
                  ls_lista-dmbtr3 = lv_hsl.
                ENDIF.

                CLEAR ls_data8.
                MOVE-CORRESPONDING ls_lista TO ls_data8.

                READ TABLE lt_lista ASSIGNING <lf_lista> WITH KEY spmon = ls_lista-spmon
                                                                  kalnr = ls_lista-kalnr
                                                                  zsfld = ls_lista-zsfld
                                                                  racct = ls_lista-racct
                                                                  ktosl = ls_lista-ktosl
                                                                  reftxt = ls_lista-reftxt.
                IF sy-subrc = 0.
                  <lf_lista>-menge += ls_lista-menge.
                  <lf_lista>-dmbtr += ls_lista-dmbtr.
                  <lf_lista>-dmbtr1 += ls_lista-dmbtr1.
                  <lf_lista>-dmbtr2 += ls_lista-dmbtr2.
                  <lf_lista>-dmbtr3 += ls_lista-dmbtr3.
                ENDIF.
                CLEAR ls_lista.

                COLLECT ls_data8 INTO lt_data8.
                CLEAR ls_data8.

                "재무기준 수불부 비교계정 리스트 취합.
                lv_hsl =  lv_hsl * -1.

                CLEAR ls_lista.
                MOVE-CORRESPONDING <lf_mlhd> TO ls_lista.
                ls_lista-spmon = key-%param-spmons.
                ls_lista-zsfld = <lf_vn1>-zsfld.
                ls_lista-racct = <lf_mlhd>-racct.
                ls_lista-ktosl = <lf_mlhd>-ktosl1.
                CLEAR ls_lista-menge.
                ls_lista-dmbtr3 = lv_hsl.

                READ TABLE lt_lista ASSIGNING <lf_lista> WITH KEY spmon = ls_lista-spmon
                                                                  kalnr = ls_lista-kalnr
                                                                  zsfld = ls_lista-zsfld
                                                                  racct = ls_lista-racct
                                                                  ktosl = ls_lista-ktosl
                                                                  reftxt = ls_lista-reftxt.
                IF sy-subrc = 0.
                  <lf_lista>-dmbtr3 += ls_lista-dmbtr3.
                ENDIF.
                CLEAR ls_lista.

              ENDIF.
            ENDIF.

            IF <lf_mlhd>-modd <> 0.
              READ TABLE lt_vn1 ASSIGNING <lf_vn1> INDEX ly_line.
              IF sy-subrc = 0.

                UNASSIGN <lf_listd>.
                READ TABLE lt_listd ASSIGNING <lf_listd> WITH KEY kalnr = <lf_vn1>-kalnr
                                                                  budat = <lf_mlhd>-budat.
                IF sy-subrc = 0.
                  CLEAR:fielda.
                  CONCATENATE '<lf_listd>-' <lf_vn1>-zsfld 'A' INTO fielda.
                  ASSIGN (fielda) TO <fad4>.
                  IF <fad4> IS ASSIGNED.
                    IF <lf_vn1>-zsbgb = 'O'.
                      <fad4> += <lf_mlhd>-modd * -1.
                    ELSE.
                      <fad4> += <lf_mlhd>-modd.
                    ENDIF.
                  ENDIF.
                  UNASSIGN <fad4>.
                ENDIF.
              ENDIF.
            ENDIF.

            IF lv_ch2 = 'X'.
              CLEAR: ly_modm, ly_line.
              LOOP AT lt_vn3 ASSIGNING FIELD-SYMBOL(<lf_vn3>) WHERE kalnr = <lf_mlhd>-kalnr
                                                     AND mgkont = <lf_mlhd>-racct
                                                     AND coctl = <lf_mlhd>-rcntr
                                                     AND kdauf_im = <lf_mlhd>-kdauf
                                                     AND kdpos_im = <lf_mlhd>-kdpos.
                IF ly_modm IS INITIAL.
                  ly_modm = <lf_vn3>-menge.
                  ly_line = sy-tabix.
                ELSE.
                  IF ly_modm < <lf_vn3>-menge.
                    ly_modm = <lf_vn3>-menge.
                    ly_line = sy-tabix.
                  ENDIF.
                ENDIF.

                CLEAR assign_amt.
                assign_amt = <lf_mlhd>-danga * <lf_vn3>-menge.


                "저장위치 수불필드 할당
                UNASSIGN <lf_listl>.
                READ TABLE lt_listl ASSIGNING <lf_listl> WITH KEY kalnr = <lf_vn3>-kalnr
                                                                lgort = <lf_vn3>-lgort.
                IF sy-subrc = 0.

                  CLEAR:fielda.
                  CONCATENATE '<lf_listl>-' <lf_vn3>-zsfld 'A' INTO fielda.
                  ASSIGN (fielda) TO FIELD-SYMBOL(<fal4>).
                  IF <fal4> IS ASSIGNED.
                    IF <lf_vn3>-zsbgb = 'O'.
                      <fal4> += assign_amt * -1.
                    ELSE.
                      <fal4> += assign_amt.
                    ENDIF.
                    <lf_mlhd>-modl = <lf_mlhd>-modl - assign_amt.
                  ENDIF.
                  UNASSIGN <fal4>.
                ENDIF.
              ENDLOOP.

              "단수차이 배분
              IF <lf_mlhd>-modl <> 0.
                READ TABLE lt_vn3 ASSIGNING <lf_vn3> INDEX ly_line.
                IF sy-subrc = 0.
                  UNASSIGN <lf_listl>.
                  READ TABLE lt_listl ASSIGNING <lf_listl> WITH KEY kalnr = <lf_vn3>-kalnr
                                                                  lgort = <lf_vn3>-lgort.
                  IF sy-subrc = 0.
                    CLEAR:fielda.
                    CONCATENATE '<lf_listl>-' <lf_vn3>-zsfld 'A' INTO fielda.
                    ASSIGN (fielda) TO <fal4>.
                    IF <fal4> IS ASSIGNED.
                      IF <lf_vn3>-zsbgb = 'O'.
                        <fal4> += <lf_mlhd>-modl * -1.
                      ELSE.
                        <fal4> += <lf_mlhd>-modl.
                      ENDIF.
                    ENDIF.
                    UNASSIGN <fal4>.
                  ENDIF.
                ENDIF.
              ENDIF.
            ENDIF.

          ENDIF.


          "****소비재평가 배분( 판매판품 )**** 특정 세그먼트로 배부되지 않은...
          "일괄 소비재평가가 여러 카테고리에 있다면 세그먼트 지정을 해줘서 일괄 소비재평가가 반품기준만 있도록 제어해야 함.
          IF ( <lf_mlhd>-typ1 = 'VNPRD' OR <lf_mlhd>-typ1 = 'VNKDM' ) AND <lf_mlhd>-typ2 = 'VERBR' AND <lf_mlhd>-ktosl1 = 'COC'.

            READ TABLE lt_vnr2 INTO ls_vnr2 WITH KEY kalnr = <lf_mlhd>-kalnr BINARY SEARCH.
            "판매반품이 있으면...
            IF sy-subrc = 0.
              IF ls_vnr2-menge = 0.
                <lf_mlhd>-danga = 0.
              ELSE.
                <lf_mlhd>-danga = <lf_mlhd>-hsl / ls_vnr2-menge.
              ENDIF.
              <lf_mlhd>-mod = <lf_mlhd>-hsl.
              <lf_mlhd>-modd = <lf_mlhd>-hsl.
              <lf_mlhd>-modl = <lf_mlhd>-hsl.

              CLEAR: ly_modm, ly_line.
              LOOP AT lt_vnr1 ASSIGNING FIELD-SYMBOL(<lf_vnr1>) WHERE kalnr = <lf_mlhd>-kalnr.

                IF ly_modm IS INITIAL.
                  ly_modm = <lf_vnr1>-menge.
                  ly_line = sy-tabix.
                ELSE.
                  IF ly_modm < <lf_vnr1>-menge.
                    ly_modm = <lf_vnr1>-menge.
                    ly_line = sy-tabix.
                  ENDIF.
                ENDIF.

                CLEAR assign_amt.
                assign_amt = <lf_mlhd>-danga * <lf_vnr1>-menge.


                " 수불필드 할당
                UNASSIGN <lf_list>.
                READ TABLE lt_list ASSIGNING <lf_list> WITH KEY kalnr = <lf_vnr1>-kalnr.
                IF sy-subrc = 0.
                  CLEAR:fielda.
                  CONCATENATE '<lf_list>-' <lf_vnr1>-zsfld 'A' INTO fielda.
                  ASSIGN (fielda) TO FIELD-SYMBOL(<far>).
                  IF <far> IS ASSIGNED.
                    IF <lf_vnr1>-zsbgb = 'O'.
                      <far> += assign_amt * -1.
                    ELSE.
                      <far> += assign_amt.
                    ENDIF.
                    <lf_mlhd>-mod = <lf_mlhd>-mod - assign_amt.
                  ENDIF.
                  UNASSIGN <far>.
                ENDIF.

                " 일별수불필드 할당
                UNASSIGN <lf_listd>.
                READ TABLE lt_listd ASSIGNING <lf_listd> WITH KEY kalnr = <lf_vnr1>-kalnr
                                                                  budat = <lf_mlhd>-budat.
                IF sy-subrc = 0.
                  CLEAR:fielda.
                  CONCATENATE '<lf_listd>-' <lf_vnr1>-zsfld 'A' INTO fielda.
                  ASSIGN (fielda) TO FIELD-SYMBOL(<fadr>).
                  IF <fadr> IS ASSIGNED.
                    IF <lf_vnr1>-zsbgb = 'O'.
                      <fadr> += assign_amt * -1.
                    ELSE.
                      <fadr> += assign_amt.
                    ENDIF.
                    <lf_mlhd>-modd = <lf_mlhd>-modd - assign_amt.
                  ENDIF.
                  UNASSIGN <fadr>.
                ENDIF.

                "재무기준 수불필드 할당.
                CLEAR lv_hsl.
                IF <lf_mlhd>-hsl <> 0.
                  lv_hsl = assign_amt / 100.
                ELSE.
                  lv_hsl = 0.
                ENDIF.

                CLEAR ls_lista.
                MOVE-CORRESPONDING <lf_mlhd> TO ls_lista.
                ls_lista-spmon = key-%param-spmons.
                ls_lista-zsfld = <lf_vnr1>-zsfld.
                ls_lista-racct = <lf_mlhd>-raccta.
                IF ls_lista-ktosl = 'BSX'.
                  ls_lista-dmbtr = lv_hsl.
                  ls_lista-dmbtr2 = lv_hsl.
                  ls_lista-dmbtr3 = lv_hsl.
                ELSEIF ls_lista-ktosl+0(2) = 'PR' OR ls_lista-ktosl = 'AUM' OR ls_lista-ktosl = 'KDM'.
                  CLEAR ls_lista-menge.
                  ls_lista-dmbtr1 = lv_hsl.
                  ls_lista-dmbtr2 = lv_hsl.
                  ls_lista-dmbtr3 = lv_hsl.
                ELSE.
                  CLEAR ls_lista-menge.
                  ls_lista-dmbtr3 = lv_hsl.
                ENDIF.

                CLEAR ls_data8.
                MOVE-CORRESPONDING ls_lista TO ls_data8.

                READ TABLE lt_lista ASSIGNING <lf_lista> WITH KEY spmon = ls_lista-spmon
                                                                  kalnr = ls_lista-kalnr
                                                                  zsfld = ls_lista-zsfld
                                                                  racct = ls_lista-racct
                                                                  ktosl = ls_lista-ktosl
                                                                  reftxt = ls_lista-reftxt.
                IF sy-subrc = 0.
                  <lf_lista>-menge += ls_lista-menge.
                  <lf_lista>-dmbtr += ls_lista-dmbtr.
                  <lf_lista>-dmbtr1 += ls_lista-dmbtr1.
                  <lf_lista>-dmbtr2 += ls_lista-dmbtr2.
                  <lf_lista>-dmbtr3 += ls_lista-dmbtr3.
                ELSE.
                  APPEND ls_lista TO lt_lista.
                  CLEAR ls_lista.
                ENDIF.
                CLEAR ls_lista.

                COLLECT ls_data8 INTO lt_data8.
                CLEAR ls_data8.

                "재무기준 수불부 비교계정 리스트 취합.
                lv_hsl =  lv_hsl * -1.

                CLEAR ls_lista.
                MOVE-CORRESPONDING <lf_mlhd> TO ls_lista.
                ls_lista-spmon = key-%param-spmons.
                ls_lista-zsfld = <lf_vnr1>-zsfld.
                ls_lista-racct = <lf_mlhd>-racct.
                ls_lista-ktosl = <lf_mlhd>-ktosl1.
                CLEAR ls_lista-menge.
                ls_lista-dmbtr3 = lv_hsl.

                READ TABLE lt_lista ASSIGNING <lf_lista> WITH KEY spmon = ls_lista-spmon
                                                                  kalnr = ls_lista-kalnr
                                                                  zsfld = ls_lista-zsfld
                                                                  racct = ls_lista-racct
                                                                  ktosl = ls_lista-ktosl
                                                                  reftxt = ls_lista-reftxt.
                IF sy-subrc = 0.
                  <lf_lista>-dmbtr3 += ls_lista-dmbtr3.
                ELSE.
                  APPEND ls_lista TO lt_lista.
                  CLEAR ls_lista.
                ENDIF.
                CLEAR ls_lista.

              ENDLOOP.

              "단수차이 배분
              IF <lf_mlhd>-mod <> 0.
                READ TABLE lt_vnr1 ASSIGNING <lf_vnr1> INDEX ly_line.
                IF sy-subrc = 0.

                  UNASSIGN <lf_list>.
                  READ TABLE lt_list ASSIGNING <lf_list> WITH KEY kalnr = <lf_vnr1>-kalnr.
                  IF sy-subrc = 0.
                    CLEAR:fielda.
                    CONCATENATE '<lf_list>-' <lf_vnr1>-zsfld 'A' INTO fielda.
                    ASSIGN (fielda) TO <far>.
                    IF <far> IS ASSIGNED.
                      IF <lf_vnr1>-zsbgb = 'O'.
                        <far> += <lf_mlhd>-mod * -1.
                      ELSE.
                        <far> += <lf_mlhd>-mod.
                      ENDIF.
                    ENDIF.
                    UNASSIGN <far>.
                  ENDIF.

                  CLEAR lv_hsl.
                  IF <lf_mlhd>-mod <> 0.
                    lv_hsl = <lf_mlhd>-mod / 100.
                  ELSE.
                    lv_hsl = 0.
                  ENDIF.

                  CLEAR ls_lista.
                  MOVE-CORRESPONDING <lf_mlhd> TO ls_lista.
                  ls_lista-spmon = key-%param-spmons.
                  ls_lista-zsfld = <lf_vnr1>-zsfld.
                  ls_lista-racct = <lf_mlhd>-raccta.
                  IF ls_lista-ktosl = 'BSX'.
                    ls_lista-dmbtr = lv_hsl.
                    ls_lista-dmbtr2 = lv_hsl.
                    ls_lista-dmbtr3 = lv_hsl.
                  ELSEIF ls_lista-ktosl+0(2) = 'PR' OR ls_lista-ktosl = 'AUM' OR ls_lista-ktosl = 'KDM'.
                    CLEAR ls_lista-menge.
                    ls_lista-dmbtr1 = lv_hsl.
                    ls_lista-dmbtr2 = lv_hsl.
                    ls_lista-dmbtr3 = lv_hsl.
                  ELSE.
                    CLEAR ls_lista-menge.
                    ls_lista-dmbtr3 = lv_hsl.
                  ENDIF.

                  CLEAR ls_data8.
                  MOVE-CORRESPONDING ls_lista TO ls_data8.

                  READ TABLE lt_lista ASSIGNING <lf_lista> WITH KEY spmon = ls_lista-spmon
                                                                    kalnr = ls_lista-kalnr
                                                                    zsfld = ls_lista-zsfld
                                                                    racct = ls_lista-racct
                                                                    ktosl = ls_lista-ktosl
                                                                    reftxt = ls_lista-reftxt.
                  IF sy-subrc = 0.
                    <lf_lista>-menge += ls_lista-menge.
                    <lf_lista>-dmbtr += ls_lista-dmbtr.
                    <lf_lista>-dmbtr1 += ls_lista-dmbtr1.
                    <lf_lista>-dmbtr2 += ls_lista-dmbtr2.
                    <lf_lista>-dmbtr3 += ls_lista-dmbtr3.
                  ENDIF.
                  CLEAR ls_lista.

                  COLLECT ls_data8 INTO lt_data8.
                  CLEAR ls_data8.

                  "재무기준 수불부 비교계정 리스트 취합.
                  lv_hsl =  lv_hsl * -1.

                  CLEAR ls_lista.
                  MOVE-CORRESPONDING <lf_mlhd> TO ls_lista.
                  ls_lista-spmon = key-%param-spmons.
                  ls_lista-zsfld = <lf_vnr1>-zsfld.
                  ls_lista-racct = <lf_mlhd>-racct.
                  ls_lista-ktosl = <lf_mlhd>-ktosl1.
                  CLEAR ls_lista-menge.
                  ls_lista-dmbtr3 = lv_hsl.

                  READ TABLE lt_lista ASSIGNING <lf_lista> WITH KEY spmon = ls_lista-spmon
                                                                    kalnr = ls_lista-kalnr
                                                                    zsfld = ls_lista-zsfld
                                                                    racct = ls_lista-racct
                                                                    ktosl = ls_lista-ktosl
                                                                    reftxt = ls_lista-reftxt.
                  IF sy-subrc = 0.
                    <lf_lista>-dmbtr3 += ls_lista-dmbtr3.
                  ENDIF.
                  CLEAR ls_lista.

                ENDIF.
              ENDIF.

              IF <lf_mlhd>-modd <> 0.
                READ TABLE lt_vnr1 ASSIGNING <lf_vnr1> INDEX ly_line.
                IF sy-subrc = 0.

                  UNASSIGN <lf_listd>.
                  READ TABLE lt_listd ASSIGNING <lf_listd> WITH KEY kalnr = <lf_vnr1>-kalnr
                                                                    budat = <lf_mlhd>-budat.
                  IF sy-subrc = 0.
                    CLEAR:fielda.
                    CONCATENATE '<lf_listd>-' <lf_vnr1>-zsfld 'A' INTO fielda.
                    ASSIGN (fielda) TO <fadr>.
                    IF <fad4> IS ASSIGNED.
                      IF <lf_vnr1>-zsbgb = 'O'.
                        <fadr> += <lf_mlhd>-modd * -1.
                      ELSE.
                        <fadr> += <lf_mlhd>-modd.
                      ENDIF.
                    ENDIF.
                    UNASSIGN <fadr>.
                  ENDIF.
                ENDIF.
              ENDIF.
              IF lv_ch2 = 'X'.
                CLEAR: ly_modm, ly_line.
                LOOP AT lt_vnr3 ASSIGNING FIELD-SYMBOL(<lf_vnr3>) WHERE kalnr = <lf_mlhd>-kalnr.
                  IF ly_modm IS INITIAL.
                    ly_modm = <lf_vnr3>-menge.
                    ly_line = sy-tabix.
                  ELSE.
                    IF ly_modm < <lf_vnr3>-menge.
                      ly_modm = <lf_vnr3>-menge.
                      ly_line = sy-tabix.
                    ENDIF.
                  ENDIF.

                  CLEAR assign_amt.
                  assign_amt = <lf_mlhd>-danga * <lf_vnr3>-menge.


                  "저장위치 수불필드 할당
                  UNASSIGN <lf_listl>.
                  READ TABLE lt_listl ASSIGNING <lf_listl> WITH KEY kalnr = <lf_vnr3>-kalnr
                                                                  lgort = <lf_vnr3>-lgort.
                  IF sy-subrc = 0.

                    CLEAR:fielda.
                    CONCATENATE '<lf_listl>-' <lf_vnr3>-zsfld 'A' INTO fielda.
                    ASSIGN (fielda) TO FIELD-SYMBOL(<falr>).
                    IF <falr> IS ASSIGNED.
                      IF <lf_vnr3>-zsbgb = 'O'.
                        <falr> += assign_amt * -1.
                      ELSE.
                        <falr> += assign_amt.
                      ENDIF.
                      <lf_mlhd>-modl = <lf_mlhd>-modl - assign_amt.
                    ENDIF.
                    UNASSIGN <falr>.
                  ENDIF.
                ENDLOOP.

                IF <lf_mlhd>-modl <> 0.
                  READ TABLE lt_vnr3 ASSIGNING <lf_vnr3> INDEX ly_line.
                  IF sy-subrc = 0.
                    UNASSIGN <lf_listl>.
                    READ TABLE lt_listl ASSIGNING <lf_listl> WITH KEY kalnr = <lf_vnr3>-kalnr
                                                                    lgort = <lf_vnr3>-lgort.
                    IF sy-subrc = 0.
                      CLEAR:fielda.
                      CONCATENATE '<lf_listl>-' <lf_vnr3>-zsfld 'A' INTO fielda.
                      ASSIGN (fielda) TO <falr>.
                      IF <falr> IS ASSIGNED.
                        IF <lf_vnr3>-zsbgb = 'O'.
                          <falr> += <lf_mlhd>-modl * -1.
                        ELSE.
                          <falr> += <lf_mlhd>-modl.
                        ENDIF.
                      ENDIF.
                      UNASSIGN <falr>.
                    ENDIF.
                  ENDIF.
                ENDIF.
              ENDIF.

            ELSE.
              "판매반품이 없으면 배부되지 않음으로 설정
              "재무기준 수불부 비교계정 리스트 취합.
              CLEAR ls_0060.
              READ TABLE lt_0060 INTO ls_0060 WITH KEY bklas = <lf_mlhd>-bklas
                                                     werks = <lf_mlhd>-werks
                                                     zdfgb = 'O'.

              CLEAR lv_hsl.
              lv_hsl = <lf_mlhd>-hsl.
              lv_hsl = lv_hsl * -1.

              CLEAR ls_lista.
              MOVE-CORRESPONDING <lf_mlhd> TO ls_lista.
              ls_lista-spmon = key-%param-spmons.
              ls_lista-zsfld = ls_0060-zsfld.
              ls_lista-racct = <lf_mlhd>-racct.
              ls_lista-ktosl = <lf_mlhd>-ktosl1.
              CLEAR ls_lista-menge.
*              ls_lista-dmbtr3 = lv_hsl.

              IF ls_lista-ktosl = 'BSX'.
                ls_lista-dmbtr = lv_hsl.
                ls_lista-dmbtr2 = lv_hsl.
                ls_lista-dmbtr3 = lv_hsl.
              ELSEIF ls_lista-ktosl+0(2) = 'PR' OR ls_lista-ktosl = 'AUM' OR ls_lista-ktosl = 'KDM'.
                CLEAR ls_lista-menge.
                ls_lista-dmbtr1 = lv_hsl.
                ls_lista-dmbtr2 = lv_hsl.
                ls_lista-dmbtr3 = lv_hsl.
              ELSE.
                CLEAR ls_lista-menge.
                ls_lista-dmbtr3 = lv_hsl.
              ENDIF.

              READ TABLE lt_lista ASSIGNING <lf_lista> WITH KEY spmon = ls_lista-spmon
                                                                kalnr = ls_lista-kalnr
                                                                zsfld = ls_lista-zsfld
                                                                racct = ls_lista-racct
                                                                ktosl = ls_lista-ktosl
                                                                reftxt = ls_lista-reftxt.
              IF sy-subrc = 0.
                <lf_lista>-menge += ls_lista-menge.
                <lf_lista>-dmbtr += ls_lista-dmbtr.
                <lf_lista>-dmbtr1 += ls_lista-dmbtr1.
                <lf_lista>-dmbtr2 += ls_lista-dmbtr2.
                <lf_lista>-dmbtr3 += ls_lista-dmbtr3.
              ELSE.
                APPEND ls_lista TO lt_lista.
                CLEAR ls_lista.
              ENDIF.
              CLEAR ls_lista.

            ENDIF.


          ENDIF.

          "****이동출고(생산,외주 포함)에 따른 소비재평가****
          IF <lf_mlhd>-typ1 = 'VNPRD' AND ( <lf_mlhd>-typ3 = 'ZUPRV' OR <lf_mlhd>-typ3 = 'ZUKDV' ).
            READ TABLE lt_tri2 INTO ls_tri2 WITH KEY kalnr = <lf_mlhd>-kalnr
                                                   umkal = <lf_mlhd>-umkal
                                                   BINARY SEARCH.
            IF sy-subrc = 0.
              IF ls_tri2-menge = 0.
                <lf_mlhd>-danga = 0.
              ELSE.
                <lf_mlhd>-danga = <lf_mlhd>-hsl / ls_tri2-menge.
              ENDIF.
              <lf_mlhd>-mod = <lf_mlhd>-hsl.
              <lf_mlhd>-modd = <lf_mlhd>-hsl.
              <lf_mlhd>-modl = <lf_mlhd>-hsl.

              CLEAR: ly_modm, ly_line.
              LOOP AT lt_tri1 ASSIGNING FIELD-SYMBOL(<lf_tri1>) WHERE kalnr = <lf_mlhd>-kalnr
                                                     AND umkal = <lf_mlhd>-umkal.

                IF ly_modm IS INITIAL.
                  ly_modm = <lf_tri1>-menge.
                  ly_line = sy-tabix.
                ELSE.
                  IF ly_modm < <lf_tri1>-menge.
                    ly_modm = <lf_tri1>-menge.
                    ly_line = sy-tabix.
                  ENDIF.
                ENDIF.

                CLEAR assign_amt.
                assign_amt = <lf_mlhd>-danga * <lf_tri1>-menge.


                " 수불필드 할당
                UNASSIGN <lf_list>.
                READ TABLE lt_list ASSIGNING <lf_list> WITH KEY kalnr = <lf_tri1>-kalnr.
                IF sy-subrc = 0.
                  CLEAR:fielda.
                  CONCATENATE '<lf_list>-' <lf_tri1>-zsfld 'A' INTO fielda.
                  ASSIGN (fielda) TO FIELD-SYMBOL(<fa5>).
                  IF <fa5> IS ASSIGNED.
                    IF <lf_tri1>-zsbgb = 'O'.
                      <fa5> += assign_amt * -1.
                    ELSE.
                      <fa5> += assign_amt.
                    ENDIF.
                    <lf_mlhd>-mod = <lf_mlhd>-mod - assign_amt.
                  ENDIF.
                  UNASSIGN <fa5>.
                ENDIF.

                " 일별수불필드 할당
                UNASSIGN <lf_listd>.
                READ TABLE lt_listd ASSIGNING <lf_listd> WITH KEY kalnr = <lf_tri1>-kalnr
                                                                  budat = <lf_mlhd>-budat.
                IF sy-subrc = 0.
                  CLEAR:fielda.
                  CONCATENATE '<lf_listd>-' <lf_tri1>-zsfld 'A' INTO fielda.
                  ASSIGN (fielda) TO FIELD-SYMBOL(<fad5>).
                  IF <fad5> IS ASSIGNED.
                    IF <lf_tri1>-zsbgb = 'O'.
                      <fad5> += assign_amt * -1.
                    ELSE.
                      <fad5> += assign_amt.
                    ENDIF.
                    <lf_mlhd>-modd = <lf_mlhd>-modd - assign_amt.
                  ENDIF.
                  UNASSIGN <fad5>.
                ENDIF.

                "재무기준 수불필드 할당.
                CLEAR lv_hsl.
                IF <lf_mlhd>-hsl <> 0.
                  lv_hsl = assign_amt / 100.
                ELSE.
                  lv_hsl = 0.
                ENDIF.

                CLEAR ls_lista.
                MOVE-CORRESPONDING <lf_mlhd> TO ls_lista.
                ls_lista-spmon = key-%param-spmons.
                ls_lista-zsfld = <lf_tri1>-zsfld.
                ls_lista-racct = <lf_mlhd>-raccta.
                IF ls_lista-ktosl = 'BSX'.
                  ls_lista-dmbtr = lv_hsl.
                  ls_lista-dmbtr2 = lv_hsl.
                  ls_lista-dmbtr3 = lv_hsl.
                ELSEIF ls_lista-ktosl+0(2) = 'PR' OR ls_lista-ktosl = 'AUM' OR ls_lista-ktosl = 'KDM'.
                  CLEAR ls_lista-menge.
                  ls_lista-dmbtr1 = lv_hsl.
                  ls_lista-dmbtr2 = lv_hsl.
                  ls_lista-dmbtr3 = lv_hsl.
                ELSE.
                  CLEAR ls_lista-menge.
                  ls_lista-dmbtr3 = lv_hsl.
                ENDIF.

                CLEAR ls_data8.
                MOVE-CORRESPONDING ls_lista TO ls_data8.

                READ TABLE lt_lista ASSIGNING <lf_lista> WITH KEY spmon = ls_lista-spmon
                                                                  kalnr = ls_lista-kalnr
                                                                  zsfld = ls_lista-zsfld
                                                                  racct = ls_lista-racct
                                                                  ktosl = ls_lista-ktosl
                                                                  reftxt = ls_lista-reftxt.
                IF sy-subrc = 0.
                  <lf_lista>-menge += ls_lista-menge.
                  <lf_lista>-dmbtr += ls_lista-dmbtr.
                  <lf_lista>-dmbtr1 += ls_lista-dmbtr1.
                  <lf_lista>-dmbtr2 += ls_lista-dmbtr2.
                  <lf_lista>-dmbtr3 += ls_lista-dmbtr3.
                ELSE.
                  APPEND ls_lista TO lt_lista.
                  CLEAR ls_lista.
                ENDIF.
                CLEAR ls_lista.

                COLLECT ls_data8 INTO lt_data8.
                CLEAR ls_data8.

                "재무기준 수불부 비교계정 리스트 취합.
                lv_hsl =  lv_hsl * -1.

                CLEAR ls_lista.
                MOVE-CORRESPONDING <lf_mlhd> TO ls_lista.
                ls_lista-spmon = key-%param-spmons.
                ls_lista-zsfld = <lf_tri1>-zsfld.
                ls_lista-racct = <lf_mlhd>-racct.
                ls_lista-ktosl = <lf_mlhd>-ktosl1.
                CLEAR ls_lista-menge.
                ls_lista-dmbtr3 = lv_hsl.

                READ TABLE lt_lista ASSIGNING <lf_lista> WITH KEY spmon = ls_lista-spmon
                                                                  kalnr = ls_lista-kalnr
                                                                  zsfld = ls_lista-zsfld
                                                                  racct = ls_lista-racct
                                                                  ktosl = ls_lista-ktosl
                                                                  reftxt = ls_lista-reftxt.
                IF sy-subrc = 0.
                  <lf_lista>-dmbtr3 += ls_lista-dmbtr3.
                ELSE.
                  APPEND ls_lista TO lt_lista.
                  CLEAR ls_lista.
                ENDIF.
                CLEAR ls_lista.
              ENDLOOP.

              "단수차이 배분
              IF <lf_mlhd>-mod <> 0.
                READ TABLE lt_tri1 ASSIGNING <lf_tri1> INDEX ly_line.
                IF sy-subrc = 0.

                  UNASSIGN <lf_list>.
                  READ TABLE lt_list ASSIGNING <lf_list> WITH KEY kalnr = <lf_tri1>-kalnr.
                  IF sy-subrc = 0.
                    CLEAR:fielda.
                    CONCATENATE '<lf_list>-' <lf_tri1>-zsfld 'A' INTO fielda.
                    ASSIGN (fielda) TO <fa5>.
                    IF <fa5> IS ASSIGNED.
                      IF <lf_tri1>-zsbgb = 'O'.
                        <fa5> += <lf_mlhd>-mod * -1.
                      ELSE.
                        <fa5> += <lf_mlhd>-mod.
                      ENDIF.
                    ENDIF.
                    UNASSIGN <fa5>.
                  ENDIF.

                  CLEAR lv_hsl.
                  IF <lf_mlhd>-mod <> 0.
                    lv_hsl = <lf_mlhd>-mod / 100.
                  ELSE.
                    lv_hsl = 0.
                  ENDIF.

                  CLEAR ls_lista.
                  MOVE-CORRESPONDING <lf_mlhd> TO ls_lista.
                  ls_lista-spmon = key-%param-spmons.
                  ls_lista-zsfld = <lf_tri1>-zsfld.
                  ls_lista-racct = <lf_mlhd>-raccta.
                  IF ls_lista-ktosl = 'BSX'.
                    ls_lista-dmbtr = lv_hsl.
                    ls_lista-dmbtr2 = lv_hsl.
                    ls_lista-dmbtr3 = lv_hsl.
                  ELSEIF ls_lista-ktosl+0(2) = 'PR' OR ls_lista-ktosl = 'AUM' OR ls_lista-ktosl = 'KDM'.
                    CLEAR ls_lista-menge.
                    ls_lista-dmbtr1 = lv_hsl.
                    ls_lista-dmbtr2 = lv_hsl.
                    ls_lista-dmbtr3 = lv_hsl.
                  ELSE.
                    CLEAR ls_lista-menge.
                    ls_lista-dmbtr3 = lv_hsl.
                  ENDIF.

                  CLEAR ls_data8.
                  MOVE-CORRESPONDING ls_lista TO ls_data8.

                  READ TABLE lt_lista ASSIGNING <lf_lista> WITH KEY spmon = ls_lista-spmon
                                                                    kalnr = ls_lista-kalnr
                                                                    zsfld = ls_lista-zsfld
                                                                    racct = ls_lista-racct
                                                                    ktosl = ls_lista-ktosl
                                                                    reftxt = ls_lista-reftxt.
                  IF sy-subrc = 0.
                    <lf_lista>-menge += ls_lista-menge.
                    <lf_lista>-dmbtr += ls_lista-dmbtr.
                    <lf_lista>-dmbtr1 += ls_lista-dmbtr1.
                    <lf_lista>-dmbtr2 += ls_lista-dmbtr2.
                    <lf_lista>-dmbtr3 += ls_lista-dmbtr3.
                  ENDIF.
                  CLEAR ls_lista.

                  COLLECT ls_data8 INTO lt_data8.
                  CLEAR ls_data8.

                  "재무기준 수불부 비교계정 리스트 취합.
                  lv_hsl =  lv_hsl * -1.

                  CLEAR ls_lista.
                  MOVE-CORRESPONDING <lf_mlhd> TO ls_lista.
                  ls_lista-spmon = key-%param-spmons.
                  ls_lista-zsfld = <lf_tri1>-zsfld.
                  ls_lista-racct = <lf_mlhd>-racct.
                  ls_lista-ktosl = <lf_mlhd>-ktosl1.
                  CLEAR ls_lista-menge.
                  ls_lista-dmbtr3 = lv_hsl.

                  READ TABLE lt_lista ASSIGNING <lf_lista> WITH KEY spmon = ls_lista-spmon
                                                                    kalnr = ls_lista-kalnr
                                                                    zsfld = ls_lista-zsfld
                                                                    racct = ls_lista-racct
                                                                    ktosl = ls_lista-ktosl
                                                                    reftxt = ls_lista-reftxt.
                  IF sy-subrc = 0.
                    <lf_lista>-dmbtr3 += ls_lista-dmbtr3.
                  ENDIF.
                  CLEAR ls_lista.

                ENDIF.
              ENDIF.

              IF <lf_mlhd>-modd <> 0.
                READ TABLE lt_tri1 ASSIGNING <lf_tri1> INDEX ly_line.
                IF sy-subrc = 0.

                  UNASSIGN <lf_listd>.
                  READ TABLE lt_listd ASSIGNING <lf_listd> WITH KEY kalnr = <lf_tri1>-kalnr
                                                                    budat = <lf_mlhd>-budat.
                  IF sy-subrc = 0.
                    CLEAR:fielda.
                    CONCATENATE '<lf_listd>-' <lf_tri1>-zsfld 'A' INTO fielda.
                    ASSIGN (fielda) TO <fad5>.
                    IF <fad5> IS ASSIGNED.
                      IF <lf_tri1>-zsbgb = 'O'.
                        <fad5> += <lf_mlhd>-modd * -1.
                      ELSE.
                        <fad5> += <lf_mlhd>-modd.
                      ENDIF.
                    ENDIF.
                    UNASSIGN <fad5>.
                  ENDIF.
                ENDIF.
              ENDIF.

              IF lv_ch2 = 'X'.
                CLEAR: ly_modm, ly_line.
                LOOP AT lt_tri3 ASSIGNING FIELD-SYMBOL(<lf_tri3>) WHERE kalnr = <lf_mlhd>-kalnr
                                                       AND umkal = <lf_mlhd>-umkal.
                  IF ly_modm IS INITIAL.
                    ly_modm = <lf_tri3>-menge.
                    ly_line = sy-tabix.
                  ELSE.
                    IF ly_modm < <lf_tri3>-menge.
                      ly_modm = <lf_tri3>-menge.
                      ly_line = sy-tabix.
                    ENDIF.
                  ENDIF.

                  CLEAR assign_amt.
                  assign_amt = <lf_mlhd>-danga * <lf_tri3>-menge.


                  "저장위치 수불필드 할당
                  UNASSIGN <lf_listl>.
                  READ TABLE lt_listl ASSIGNING <lf_listl> WITH KEY kalnr = <lf_tri3>-kalnr
                                                                  lgort = <lf_tri3>-lgort.
                  IF sy-subrc = 0.

                    CLEAR:fielda.
                    CONCATENATE '<lf_listl>-' <lf_tri3>-zsfld 'A' INTO fielda.
                    ASSIGN (fielda) TO FIELD-SYMBOL(<fal5>).
                    IF <fal5> IS ASSIGNED.
                      IF <lf_tri3>-zsbgb = 'O'.
                        <fal5> += assign_amt * -1.
                      ELSE.
                        <fal5> += assign_amt.
                      ENDIF.
                      <lf_mlhd>-modl = <lf_mlhd>-modl - assign_amt.
                    ENDIF.
                    UNASSIGN <fal5>.

                  ENDIF.
                ENDLOOP.


                IF <lf_mlhd>-modl <> 0.
                  READ TABLE lt_tri3 ASSIGNING <lf_tri3> INDEX ly_line.
                  IF sy-subrc = 0.
                    UNASSIGN <lf_listl>.
                    READ TABLE lt_listl ASSIGNING <lf_listl> WITH KEY kalnr = <lf_tri3>-kalnr
                                                                    lgort = <lf_tri3>-lgort.
                    IF sy-subrc = 0.
                      CLEAR:fielda.
                      CONCATENATE '<lf_listl>-' <lf_tri3>-zsfld 'A' INTO fielda.
                      ASSIGN (fielda) TO <fal5>.
                      IF <fal5> IS ASSIGNED.
                        IF <lf_tri3>-zsbgb = 'O'.
                          <fal5> += <lf_mlhd>-modl * -1.
                        ELSE.
                          <fal5> += <lf_mlhd>-modl.
                        ENDIF.
                      ENDIF.
                      UNASSIGN <fal5>.
                    ENDIF.
                  ENDIF.
                ENDIF.
              ENDIF.
            ENDIF.
          ENDIF.

          IF ( <lf_mlhd>-typ1 = 'ZUPRV' OR <lf_mlhd>-typ1 = 'ZUKDV' ) AND <lf_mlhd>-typ4 = 'VNPRD' .
            "****생산입고에 따른 하위레벨 차이 롤업.****
            CLEAR ls_data5a.
            READ TABLE lt_data5a INTO ls_data5a WITH KEY tkalnr = <lf_mlhd>-kalnr
                                                         fkalnr = <lf_mlhd>-iskalnr
                                                         gb = ''.
            IF sy-subrc <> 0.
              READ TABLE lt_data5a INTO ls_data5a WITH KEY tkalnr = <lf_mlhd>-kalnr
                                                         fkalnr = <lf_mlhd>-iskalnr
                                                         gb = 'X'.
            ENDIF.
            IF sy-subrc = 0.
              IF ls_data5a-fmenge = 0.
                <lf_mlhd>-danga = 0.
              ELSE.
                <lf_mlhd>-danga = <lf_mlhd>-hsl / ls_data5a-fmenge.
              ENDIF.
              <lf_mlhd>-mod = <lf_mlhd>-hsl.
              <lf_mlhd>-modd = <lf_mlhd>-hsl.
              <lf_mlhd>-modl = <lf_mlhd>-hsl.

              LOOP AT lt_data5 INTO ls_data5 WHERE tkalnr = <lf_mlhd>-kalnr
                                               AND fkalnr = <lf_mlhd>-iskalnr
                                               AND gb = ls_data5a-gb.

                READ TABLE lt_bf2 INTO ls_bf2 WITH KEY aufnr = ls_data5-aufnr
                                                       BINARY SEARCH.
                IF sy-subrc = 0.

                  CLEAR: ly_modm, ly_line.
                  LOOP AT lt_bf1 ASSIGNING FIELD-SYMBOL(<lf_bf1>) WHERE aufnr = ls_data5-aufnr.

                    IF ly_modm IS INITIAL.
                      ly_modm = <lf_bf1>-menge.
                      ly_line = sy-tabix.
                    ELSE.
                      IF ly_modm < <lf_bf1>-menge.
                        ly_modm = <lf_bf1>-menge.
                        ly_line = sy-tabix.
                      ENDIF.
                    ENDIF.

                    CLEAR assign_amt.
                    assign_amt = <lf_mlhd>-danga * <lf_bf1>-menge.


                    " 수불필드 할당
                    UNASSIGN <lf_list>.
                    READ TABLE lt_list ASSIGNING <lf_list> WITH KEY kalnr = <lf_bf1>-kalnr.
                    IF sy-subrc = 0.

                      CLEAR:fielda.
                      CONCATENATE '<lf_list>-' <lf_bf1>-zsfld 'A' INTO fielda.
                      ASSIGN (fielda) TO FIELD-SYMBOL(<fa6>).
                      IF <fa6> IS ASSIGNED.
                        IF <lf_bf1>-zsbgb = 'O'.
                          <fa6> += assign_amt * -1.
                        ELSE.
                          <fa6> += assign_amt.
                        ENDIF.
                        <lf_mlhd>-mod = <lf_mlhd>-mod - assign_amt.
                      ENDIF.
                      UNASSIGN <fa6>.

                    ENDIF.
                    " 일별수불필드 할당
                    UNASSIGN <lf_listd>.
                    READ TABLE lt_listd ASSIGNING <lf_listd> WITH KEY kalnr = <lf_bf1>-kalnr
                                                                      budat = <lf_mlhd>-budat.
                    IF sy-subrc = 0.
                      CLEAR:fielda.
                      CONCATENATE '<lf_listd>-' <lf_bf1>-zsfld 'A' INTO fielda.
                      ASSIGN (fielda) TO FIELD-SYMBOL(<fad6>).
                      IF <fad6> IS ASSIGNED.
                        IF <lf_bf1>-zsbgb = 'O'.
                          <fad6> += assign_amt * -1.
                        ELSE.
                          <fad6> += assign_amt.
                        ENDIF.
                        <lf_mlhd>-modd = <lf_mlhd>-modd - assign_amt.
                      ENDIF.
                      UNASSIGN <fad6>.
                    ENDIF.

                    "재무기준 수불필드 할당.
                    CLEAR lv_hsl.
                    IF <lf_mlhd>-hsl <> 0.
                      lv_hsl = assign_amt / 100.
                    ELSE.
                      lv_hsl = 0.
                    ENDIF.

                    CLEAR ls_lista.
                    MOVE-CORRESPONDING <lf_mlhd> TO ls_lista.
                    ls_lista-spmon = key-%param-spmons.
                    ls_lista-zsfld = <lf_bf1>-zsfld.
                    ls_lista-racct = <lf_mlhd>-raccta.
                    IF ls_lista-ktosl = 'BSX'.
                      ls_lista-dmbtr = lv_hsl.
                      ls_lista-dmbtr2 = lv_hsl.
                      ls_lista-dmbtr3 = lv_hsl.
                    ELSEIF ls_lista-ktosl+0(2) = 'PR' OR ls_lista-ktosl = 'AUM' OR ls_lista-ktosl = 'KDM'.
                      CLEAR ls_lista-menge.
                      ls_lista-dmbtr1 = lv_hsl.
                      ls_lista-dmbtr2 = lv_hsl.
                      ls_lista-dmbtr3 = lv_hsl.
                    ELSE.
                      CLEAR ls_lista-menge.
                      ls_lista-dmbtr3 = lv_hsl.
                    ENDIF.

                    CLEAR ls_data8.
                    MOVE-CORRESPONDING ls_lista TO ls_data8.

                    READ TABLE lt_lista ASSIGNING <lf_lista> WITH KEY spmon = ls_lista-spmon
                                                                      kalnr = ls_lista-kalnr
                                                                      zsfld = ls_lista-zsfld
                                                                      racct = ls_lista-racct
                                                                      ktosl = ls_lista-ktosl
                                                                      reftxt = ls_lista-reftxt.
                    IF sy-subrc = 0.
                      <lf_lista>-menge += ls_lista-menge.
                      <lf_lista>-dmbtr += ls_lista-dmbtr.
                      <lf_lista>-dmbtr1 += ls_lista-dmbtr1.
                      <lf_lista>-dmbtr2 += ls_lista-dmbtr2.
                      <lf_lista>-dmbtr3 += ls_lista-dmbtr3.
                    ELSE.
                      APPEND ls_lista TO lt_lista.
                      CLEAR ls_lista.
                    ENDIF.
                    CLEAR ls_lista.

                    COLLECT ls_data8 INTO lt_data8.
                    CLEAR ls_data8.

                    "재무기준 수불부 비교계정 리스트 취합.
                    lv_hsl =  lv_hsl * -1.

                    CLEAR ls_lista.
                    MOVE-CORRESPONDING <lf_mlhd> TO ls_lista.
                    ls_lista-spmon = key-%param-spmons.
                    ls_lista-zsfld = <lf_bf1>-zsfld.
                    ls_lista-racct = <lf_mlhd>-racct.
                    ls_lista-ktosl = <lf_mlhd>-ktosl1.
                    CLEAR ls_lista-menge.
                    ls_lista-dmbtr3 = lv_hsl.

                    READ TABLE lt_lista ASSIGNING <lf_lista> WITH KEY spmon = ls_lista-spmon
                                                                      kalnr = ls_lista-kalnr
                                                                      zsfld = ls_lista-zsfld
                                                                      racct = ls_lista-racct
                                                                      ktosl = ls_lista-ktosl
                                                                      reftxt = ls_lista-reftxt.
                    IF sy-subrc = 0.
                      <lf_lista>-dmbtr3 += ls_lista-dmbtr3.
                    ELSE.
                      APPEND ls_lista TO lt_lista.
                      CLEAR ls_lista.
                    ENDIF.
                    CLEAR ls_lista.

                  ENDLOOP.

                  IF lv_ch2 = 'X'.
                    CLEAR: ly_modm1, ly_line1.
                    LOOP AT lt_bf3 ASSIGNING FIELD-SYMBOL(<lf_bf3>) WHERE aufnr = ls_data5-aufnr.
                      IF ly_modm1 IS INITIAL.
                        ly_modm1 = <lf_bf3>-menge.
                        ly_line1 = sy-tabix.
                      ELSE.
                        IF ly_modm1 < <lf_bf3>-menge.
                          ly_modm1 = <lf_bf3>-menge.
                          ly_line1 = sy-tabix.
                        ENDIF.
                      ENDIF.

                      CLEAR assign_amt.
                      assign_amt = <lf_mlhd>-danga * <lf_bf3>-menge.


                      "저장위치 수불필드 할당
                      UNASSIGN <lf_listl>.
                      READ TABLE lt_listl ASSIGNING <lf_listl> WITH KEY kalnr = <lf_bf3>-kalnr
                                                                      lgort = <lf_bf3>-lgort.
                      IF sy-subrc = 0.

                        CLEAR:fielda.
                        CONCATENATE '<lf_listl>-' <lf_bf3>-zsfld 'A' INTO fielda.
                        ASSIGN (fielda) TO FIELD-SYMBOL(<fal6>).
                        IF <fal6> IS ASSIGNED.
                          IF <lf_bf3>-zsbgb = 'O'.
                            <fal6> += assign_amt * -1.
                          ELSE.
                            <fal6> += assign_amt.
                          ENDIF.
                          <lf_mlhd>-modl = <lf_mlhd>-modl - assign_amt.
                        ENDIF.
                        UNASSIGN <fal6>.

                      ENDIF.
                    ENDLOOP.
                  ENDIF.
                ENDIF.
              ENDLOOP.

              "단수차이 배분
              IF <lf_mlhd>-mod <> 0.
                READ TABLE lt_bf1 ASSIGNING <lf_bf1> INDEX ly_line.
                IF sy-subrc = 0.

                  UNASSIGN <lf_list>.
                  READ TABLE lt_list ASSIGNING <lf_list> WITH KEY kalnr = <lf_bf1>-kalnr.
                  IF sy-subrc = 0.
                    CLEAR:fielda.
                    CONCATENATE '<lf_list>-' <lf_bf1>-zsfld 'A' INTO fielda.
                    ASSIGN (fielda) TO <fa6>.
                    IF <fa6> IS ASSIGNED.
                      IF <lf_bf1>-zsbgb = 'O'.
                        <fa6> += <lf_mlhd>-mod * -1.
                      ELSE.
                        <fa6> += <lf_mlhd>-mod.
                      ENDIF.
                    ENDIF.
                    UNASSIGN <fa6>.
                  ENDIF.

                  CLEAR lv_hsl.
                  IF <lf_mlhd>-mod <> 0.
                    lv_hsl = <lf_mlhd>-mod / 100.
                  ELSE.
                    lv_hsl = 0.
                  ENDIF.

                  CLEAR ls_lista.
                  MOVE-CORRESPONDING <lf_mlhd> TO ls_lista.
                  ls_lista-spmon = key-%param-spmons.
                  ls_lista-zsfld = <lf_bf1>-zsfld.
                  ls_lista-racct = <lf_mlhd>-raccta.
                  IF ls_lista-ktosl = 'BSX'.
                    ls_lista-dmbtr = lv_hsl.
                    ls_lista-dmbtr2 = lv_hsl.
                    ls_lista-dmbtr3 = lv_hsl.
                  ELSEIF ls_lista-ktosl+0(2) = 'PR' OR ls_lista-ktosl = 'AUM' OR ls_lista-ktosl = 'KDM'.
                    CLEAR ls_lista-menge.
                    ls_lista-dmbtr1 = lv_hsl.
                    ls_lista-dmbtr2 = lv_hsl.
                    ls_lista-dmbtr3 = lv_hsl.
                  ELSE.
                    CLEAR ls_lista-menge.
                    ls_lista-dmbtr3 = lv_hsl.
                  ENDIF.

                  CLEAR ls_data8.
                  MOVE-CORRESPONDING ls_lista TO ls_data8.

                  READ TABLE lt_lista ASSIGNING <lf_lista> WITH KEY spmon = ls_lista-spmon
                                                                    kalnr = ls_lista-kalnr
                                                                    zsfld = ls_lista-zsfld
                                                                    racct = ls_lista-racct
                                                                    ktosl = ls_lista-ktosl
                                                                    reftxt = ls_lista-reftxt.
                  IF sy-subrc = 0.
                    <lf_lista>-menge += ls_lista-menge.
                    <lf_lista>-dmbtr += ls_lista-dmbtr.
                    <lf_lista>-dmbtr1 += ls_lista-dmbtr1.
                    <lf_lista>-dmbtr2 += ls_lista-dmbtr2.
                    <lf_lista>-dmbtr3 += ls_lista-dmbtr3.
                  ENDIF.
                  CLEAR ls_lista.

                  COLLECT ls_data8 INTO lt_data8.
                  CLEAR ls_data8.

                  "재무기준 수불부 비교계정 리스트 취합.
                  lv_hsl =  lv_hsl * -1.

                  CLEAR ls_lista.
                  MOVE-CORRESPONDING <lf_mlhd> TO ls_lista.
                  ls_lista-spmon = key-%param-spmons.
                  ls_lista-zsfld = <lf_bf1>-zsfld.
                  ls_lista-racct = <lf_mlhd>-racct.
                  ls_lista-ktosl = <lf_mlhd>-ktosl1.
                  CLEAR ls_lista-menge.
                  ls_lista-dmbtr3 = lv_hsl.

                  READ TABLE lt_lista ASSIGNING <lf_lista> WITH KEY spmon = ls_lista-spmon
                                                                    kalnr = ls_lista-kalnr
                                                                    zsfld = ls_lista-zsfld
                                                                    racct = ls_lista-racct
                                                                    ktosl = ls_lista-ktosl
                                                                    reftxt = ls_lista-reftxt.
                  IF sy-subrc = 0.
                    <lf_lista>-dmbtr3 += ls_lista-dmbtr3.
                  ENDIF.
                  CLEAR ls_lista.

                ENDIF.
              ENDIF.

              IF <lf_mlhd>-modd <> 0.
                READ TABLE lt_bf1 ASSIGNING <lf_bf1> INDEX ly_line.
                IF sy-subrc = 0.

                  UNASSIGN <lf_listd>.
                  READ TABLE lt_listd ASSIGNING <lf_listd> WITH KEY kalnr = <lf_bf1>-kalnr
                                                                    budat = <lf_mlhd>-budat.
                  IF sy-subrc = 0.
                    CLEAR:fielda.
                    CONCATENATE '<lf_listd>-' <lf_bf1>-zsfld 'A' INTO fielda.
                    ASSIGN (fielda) TO <fad6>.
                    IF <fad6> IS ASSIGNED.
                      IF <lf_bf1>-zsbgb = 'O'.
                        <fad6> += <lf_mlhd>-modd * -1.
                      ELSE.
                        <fad6> += <lf_mlhd>-modd.
                      ENDIF.
                    ENDIF.
                    UNASSIGN <fad6>.
                  ENDIF.
                ENDIF.
              ENDIF.

              IF lv_ch2 = 'X'.
                IF <lf_mlhd>-modl <> 0.
                  READ TABLE lt_bf3 ASSIGNING <lf_bf3> INDEX ly_line1.
                  IF sy-subrc = 0.
                    UNASSIGN <lf_listl>.
                    READ TABLE lt_listl ASSIGNING <lf_listl> WITH KEY kalnr = <lf_bf3>-kalnr
                                                                    lgort = <lf_bf3>-lgort.
                    IF sy-subrc = 0.
                      CLEAR:fielda.
                      CONCATENATE '<lf_listl>-' <lf_bf3>-zsfld 'A' INTO fielda.
                      ASSIGN (fielda) TO <fal6>.
                      IF <fal6> IS ASSIGNED.
                        IF <lf_bf3>-zsbgb = 'O'.
                          <fal6> += <lf_mlhd>-modl * -1.
                        ELSE.
                          <fal6> += <lf_mlhd>-modl.
                        ENDIF.
                      ENDIF.
                      UNASSIGN <fal6>.
                    ENDIF.
                  ENDIF.
                ENDIF.
              ENDIF.
            ENDIF.

            "****외주입고에 따른 하위레벨 차이 롤업.****
            READ TABLE lt_data6a INTO ls_data6a WITH KEY tkalnr = <lf_mlhd>-kalnr
                                                         fkalnr = <lf_mlhd>-iskalnr.
            IF sy-subrc = 0.
              IF ls_data6a-fmenge = 0.
                <lf_mlhd>-danga = 0.
              ELSE.
                <lf_mlhd>-danga = <lf_mlhd>-hsl / ls_data6a-fmenge.
              ENDIF.
              <lf_mlhd>-mod = <lf_mlhd>-hsl.
              <lf_mlhd>-modd = <lf_mlhd>-hsl.
              <lf_mlhd>-modl = <lf_mlhd>-hsl.

              LOOP AT lt_data6 INTO ls_data6 WHERE tkalnr = <lf_mlhd>-kalnr
                                               AND fkalnr = <lf_mlhd>-iskalnr.

                READ TABLE lt_bl2 INTO ls_bl2 WITH KEY ebeln = ls_data6-ebeln
                                                        ebelp = ls_data6-ebelp BINARY SEARCH.
                IF sy-subrc = 0.

                  CLEAR: ly_modm, ly_line.
                  LOOP AT lt_bl1 ASSIGNING FIELD-SYMBOL(<lf_bl1>) WHERE ebeln = ls_data6-ebeln
                                                                    AND ebelp = ls_data6-ebelp.

                    IF ly_modm IS INITIAL.
                      ly_modm = <lf_bl1>-menge.
                      ly_line = sy-tabix.
                    ELSE.
                      IF ly_modm < <lf_bl1>-menge.
                        ly_modm = <lf_bl1>-menge.
                        ly_line = sy-tabix.
                      ENDIF.
                    ENDIF.

                    CLEAR assign_amt.
                    assign_amt = <lf_mlhd>-danga * <lf_bl1>-menge.


                    " 수불필드 할당
                    UNASSIGN <lf_list>.
                    READ TABLE lt_list ASSIGNING <lf_list> WITH KEY kalnr = <lf_bl1>-kalnr.
                    IF sy-subrc = 0.

                      CLEAR:fielda.
                      CONCATENATE '<lf_list>-' <lf_bl1>-zsfld 'A' INTO fielda.
                      ASSIGN (fielda) TO FIELD-SYMBOL(<fa7>).
                      IF <fa7> IS ASSIGNED.
                        IF <lf_bl1>-zsbgb = 'O'.
                          <fa7> += assign_amt * -1.
                        ELSE.
                          <fa7> += assign_amt.
                        ENDIF.
                        <lf_mlhd>-mod = <lf_mlhd>-mod - assign_amt.
                      ENDIF.
                      UNASSIGN <fa7>.

                    ENDIF.
                    " 일별수불필드 할당
                    UNASSIGN <lf_listd>.
                    READ TABLE lt_listd ASSIGNING <lf_listd> WITH KEY kalnr = <lf_bl1>-kalnr
                                                                      budat = <lf_mlhd>-budat.
                    IF sy-subrc = 0.
                      CLEAR:fielda.
                      CONCATENATE '<lf_listd>-' <lf_bl1>-zsfld 'A' INTO fielda.
                      ASSIGN (fielda) TO FIELD-SYMBOL(<fad7>).
                      IF <fad7> IS ASSIGNED.
                        IF <lf_bl1>-zsbgb = 'O'.
                          <fad7> += assign_amt * -1.
                        ELSE.
                          <fad7> += assign_amt.
                        ENDIF.
                        <lf_mlhd>-modd = <lf_mlhd>-modd - assign_amt.
                      ENDIF.
                      UNASSIGN <fad7>.
                    ENDIF.

                    "재무기준 수불필드 할당.
                    CLEAR lv_hsl.
                    IF <lf_mlhd>-hsl <> 0.
                      lv_hsl = assign_amt / 100.
                    ELSE.
                      lv_hsl = 0.
                    ENDIF.

                    CLEAR ls_lista.
                    MOVE-CORRESPONDING <lf_mlhd> TO ls_lista.
                    ls_lista-spmon = key-%param-spmons.
                    ls_lista-zsfld = <lf_bl1>-zsfld.
                    ls_lista-racct = <lf_mlhd>-raccta.
                    IF ls_lista-ktosl = 'BSX'.
                      ls_lista-dmbtr = lv_hsl.
                      ls_lista-dmbtr2 = lv_hsl.
                      ls_lista-dmbtr3 = lv_hsl.
                    ELSEIF ls_lista-ktosl+0(2) = 'PR' OR ls_lista-ktosl = 'AUM' OR ls_lista-ktosl = 'KDM'.
                      CLEAR ls_lista-menge.
                      ls_lista-dmbtr1 = lv_hsl.
                      ls_lista-dmbtr2 = lv_hsl.
                      ls_lista-dmbtr3 = lv_hsl.
                    ELSE.
                      CLEAR ls_lista-menge.
                      ls_lista-dmbtr3 = lv_hsl.
                    ENDIF.

                    CLEAR ls_data8.
                    MOVE-CORRESPONDING ls_lista TO ls_data8.

                    READ TABLE lt_lista ASSIGNING <lf_lista> WITH KEY spmon = ls_lista-spmon
                                                                      kalnr = ls_lista-kalnr
                                                                      zsfld = ls_lista-zsfld
                                                                      racct = ls_lista-racct
                                                                      ktosl = ls_lista-ktosl
                                                                      reftxt = ls_lista-reftxt.
                    IF sy-subrc = 0.
                      <lf_lista>-menge += ls_lista-menge.
                      <lf_lista>-dmbtr += ls_lista-dmbtr.
                      <lf_lista>-dmbtr1 += ls_lista-dmbtr1.
                      <lf_lista>-dmbtr2 += ls_lista-dmbtr2.
                      <lf_lista>-dmbtr3 += ls_lista-dmbtr3.
                    ELSE.
                      APPEND ls_lista TO lt_lista.
                      CLEAR ls_lista.
                    ENDIF.
                    CLEAR ls_lista.

                    COLLECT ls_data8 INTO lt_data8.
                    CLEAR ls_data8.

                    "재무기준 수불부 비교계정 리스트 취합.
                    lv_hsl =  lv_hsl * -1.

                    CLEAR ls_lista.
                    MOVE-CORRESPONDING <lf_mlhd> TO ls_lista.
                    ls_lista-spmon = key-%param-spmons.
                    ls_lista-zsfld = <lf_bl1>-zsfld.
                    ls_lista-racct = <lf_mlhd>-racct.
                    ls_lista-ktosl = <lf_mlhd>-ktosl1.
                    CLEAR ls_lista-menge.
                    ls_lista-dmbtr3 = lv_hsl.

                    READ TABLE lt_lista ASSIGNING <lf_lista> WITH KEY spmon = ls_lista-spmon
                                                                      kalnr = ls_lista-kalnr
                                                                      zsfld = ls_lista-zsfld
                                                                      racct = ls_lista-racct
                                                                      ktosl = ls_lista-ktosl
                                                                      reftxt = ls_lista-reftxt.
                    IF sy-subrc = 0.
                      <lf_lista>-dmbtr3 += ls_lista-dmbtr3.
                    ELSE.
                      APPEND ls_lista TO lt_lista.
                      CLEAR ls_lista.
                    ENDIF.
                    CLEAR ls_lista.

                  ENDLOOP.



                  CLEAR: ly_modm1, ly_line1.
                  LOOP AT lt_bl3 ASSIGNING FIELD-SYMBOL(<lf_bl3>) WHERE ebeln = ls_data6-ebeln
                                                                    AND ebelp = ls_data6-ebelp.

                    IF ly_modm1 IS INITIAL.
                      ly_modm1 = <lf_bl3>-menge.
                      ly_line1 = sy-tabix.
                    ELSE.
                      IF ly_modm1 < <lf_bl3>-menge.
                        ly_modm1 = <lf_bl3>-menge.
                        ly_line1 = sy-tabix.
                      ENDIF.
                    ENDIF.

                    CLEAR assign_amt.
                    assign_amt = <lf_mlhd>-danga * <lf_bl3>-menge.


                    "저장위치 수불필드 할당
                    UNASSIGN <lf_listl>.
                    READ TABLE lt_listl ASSIGNING <lf_listl> WITH KEY kalnr = <lf_bl3>-kalnr
                                                                    lgort = <lf_bl3>-lgort.
                    IF sy-subrc = 0.

                      CLEAR:fielda.
                      CONCATENATE '<lf_listl>-' <lf_bl3>-zsfld 'A' INTO fielda.
                      ASSIGN (fielda) TO FIELD-SYMBOL(<fal7>).
                      IF <fal7> IS ASSIGNED.
                        IF <lf_bl3>-zsbgb = 'O'.
                          <fal7> += assign_amt * -1.
                        ELSE.
                          <fal7> += assign_amt.
                        ENDIF.
                        <lf_mlhd>-modl = <lf_mlhd>-modl - assign_amt.
                      ENDIF.
                      UNASSIGN <fal7>.

                    ENDIF.
                  ENDLOOP.

                ENDIF.
              ENDLOOP.

              "단수차이 배분
              IF <lf_mlhd>-mod <> 0.
                READ TABLE lt_bl1 ASSIGNING <lf_bl1> INDEX ly_line.
                IF sy-subrc = 0.

                  UNASSIGN <lf_list>.
                  READ TABLE lt_list ASSIGNING <lf_list> WITH KEY kalnr = <lf_bl1>-kalnr.
                  IF sy-subrc = 0.
                    CLEAR:fielda.
                    CONCATENATE '<lf_list>-' <lf_bl1>-zsfld 'A' INTO fielda.
                    ASSIGN (fielda) TO <fa7>.
                    IF <fa7> IS ASSIGNED.
                      IF <lf_bl1>-zsbgb = 'O'.
                        <fa7> += <lf_mlhd>-mod * -1.
                      ELSE.
                        <fa7> += <lf_mlhd>-mod.
                      ENDIF.
                    ENDIF.
                    UNASSIGN <fa7>.
                  ENDIF.

                  CLEAR lv_hsl.
                  IF <lf_mlhd>-mod <> 0.
                    lv_hsl = <lf_mlhd>-mod / 100.
                  ELSE.
                    lv_hsl = 0.
                  ENDIF.

                  CLEAR ls_lista.
                  MOVE-CORRESPONDING <lf_mlhd> TO ls_lista.
                  ls_lista-spmon = key-%param-spmons.
                  ls_lista-zsfld = <lf_bl1>-zsfld.
                  ls_lista-racct = <lf_mlhd>-raccta.
                  IF ls_lista-ktosl = 'BSX'.
                    ls_lista-dmbtr = lv_hsl.
                    ls_lista-dmbtr2 = lv_hsl.
                    ls_lista-dmbtr3 = lv_hsl.
                  ELSEIF ls_lista-ktosl+0(2) = 'PR' OR ls_lista-ktosl = 'AUM' OR ls_lista-ktosl = 'KDM'.
                    CLEAR ls_lista-menge.
                    ls_lista-dmbtr1 = lv_hsl.
                    ls_lista-dmbtr2 = lv_hsl.
                    ls_lista-dmbtr3 = lv_hsl.
                  ELSE.
                    CLEAR ls_lista-menge.
                    ls_lista-dmbtr3 = lv_hsl.
                  ENDIF.

                  CLEAR ls_data8.
                  MOVE-CORRESPONDING ls_lista TO ls_data8.

                  READ TABLE lt_lista ASSIGNING <lf_lista> WITH KEY spmon = ls_lista-spmon
                                                                    kalnr = ls_lista-kalnr
                                                                    zsfld = ls_lista-zsfld
                                                                    racct = ls_lista-racct
                                                                    ktosl = ls_lista-ktosl
                                                                    reftxt = ls_lista-reftxt.
                  IF sy-subrc = 0.
                    <lf_lista>-menge += ls_lista-menge.
                    <lf_lista>-dmbtr += ls_lista-dmbtr.
                    <lf_lista>-dmbtr1 += ls_lista-dmbtr1.
                    <lf_lista>-dmbtr2 += ls_lista-dmbtr2.
                    <lf_lista>-dmbtr3 += ls_lista-dmbtr3.
                  ENDIF.
                  CLEAR ls_lista.

                  COLLECT ls_data8 INTO lt_data8.
                  CLEAR ls_data8.

                  "재무기준 수불부 비교계정 리스트 취합.
                  lv_hsl =  lv_hsl * -1.

                  CLEAR ls_lista.
                  MOVE-CORRESPONDING <lf_mlhd> TO ls_lista.
                  ls_lista-spmon = key-%param-spmons.
                  ls_lista-zsfld = <lf_bl1>-zsfld.
                  ls_lista-racct = <lf_mlhd>-racct.
                  ls_lista-ktosl = <lf_mlhd>-ktosl1.
                  CLEAR ls_lista-menge.
                  ls_lista-dmbtr3 = lv_hsl.

                  READ TABLE lt_lista ASSIGNING <lf_lista> WITH KEY spmon = ls_lista-spmon
                                                                    kalnr = ls_lista-kalnr
                                                                    zsfld = ls_lista-zsfld
                                                                    racct = ls_lista-racct
                                                                    ktosl = ls_lista-ktosl
                                                                    reftxt = ls_lista-reftxt.
                  IF sy-subrc = 0.
                    <lf_lista>-dmbtr3 += ls_lista-dmbtr3.
                  ENDIF.
                  CLEAR ls_lista.

                ENDIF.
              ENDIF.

              IF <lf_mlhd>-modd <> 0.
                READ TABLE lt_bl1 ASSIGNING <lf_bl1> INDEX ly_line.
                IF sy-subrc = 0.

                  UNASSIGN <lf_listd>.
                  READ TABLE lt_listd ASSIGNING <lf_listd> WITH KEY kalnr = <lf_bl1>-kalnr
                                                                    budat = <lf_mlhd>-budat.
                  IF sy-subrc = 0.
                    CLEAR:fielda.
                    CONCATENATE '<lf_listd>-' <lf_bl1>-zsfld 'A' INTO fielda.
                    ASSIGN (fielda) TO <fad7>.
                    IF <fad7> IS ASSIGNED.
                      IF <lf_bl1>-zsbgb = 'O'.
                        <fad7> += <lf_mlhd>-modd * -1.
                      ELSE.
                        <fad7> += <lf_mlhd>-modd.
                      ENDIF.
                    ENDIF.
                    UNASSIGN <fad7>.
                  ENDIF.
                ENDIF.
              ENDIF.

              IF <lf_mlhd>-modl <> 0.
                READ TABLE lt_bl3 ASSIGNING <lf_bl3> INDEX ly_line1.
                IF sy-subrc = 0.
                  UNASSIGN <lf_listl>.
                  READ TABLE lt_listl ASSIGNING <lf_listl> WITH KEY kalnr = <lf_bl3>-kalnr
                                                                  lgort = <lf_bl3>-lgort.
                  IF sy-subrc = 0.
                    CLEAR:fielda.
                    CONCATENATE '<lf_listl>-' <lf_bl3>-zsfld 'A' INTO fielda.
                    ASSIGN (fielda) TO <fal7>.
                    IF <fal7> IS ASSIGNED.
                      IF <lf_bl3>-zsbgb = 'O'.
                        <fal7> += <lf_mlhd>-modl * -1.
                      ELSE.
                        <fal7> += <lf_mlhd>-modl.
                      ENDIF.
                    ENDIF.
                    UNASSIGN <fal7>.
                  ENDIF.
                ENDIF.
              ENDIF.
            ENDIF.

            "****이동 및 이전 입고에 따른 하위레벨 차이 롤업****
            READ TABLE lt_trr2 INTO ls_trr2 WITH KEY kalnr = <lf_mlhd>-kalnr
                                                     umkal = <lf_mlhd>-iskalnr.
            IF sy-subrc = 0.
              IF ls_trr2-menge = 0.
                <lf_mlhd>-danga = 0.
              ELSE.
                <lf_mlhd>-danga = <lf_mlhd>-hsl / ls_trr2-menge.
              ENDIF.
              <lf_mlhd>-mod = <lf_mlhd>-hsl.
              <lf_mlhd>-modd = <lf_mlhd>-hsl.
              <lf_mlhd>-modl = <lf_mlhd>-hsl.

              CLEAR: ly_modm, ly_line.
              LOOP AT lt_trr1 ASSIGNING FIELD-SYMBOL(<lf_trr1>) WHERE kalnr = <lf_mlhd>-kalnr
                                                     AND umkal = <lf_mlhd>-iskalnr.
                IF ly_modm IS INITIAL.
                  ly_modm = <lf_trr1>-menge.
                  ly_line = sy-tabix.
                ELSE.
                  IF ly_modm < <lf_trr1>-menge.
                    ly_modm = <lf_trr1>-menge.
                    ly_line = sy-tabix.
                  ENDIF.
                ENDIF.

                CLEAR assign_amt.
                assign_amt = <lf_mlhd>-danga * <lf_trr1>-menge.


                " 수불필드 할당
                UNASSIGN <lf_list>.
                READ TABLE lt_list ASSIGNING <lf_list> WITH KEY kalnr = <lf_trr1>-kalnr.
                IF sy-subrc = 0.
                  CLEAR:fielda.
                  CONCATENATE '<lf_list>-' <lf_trr1>-zsfld 'A' INTO fielda.
                  ASSIGN (fielda) TO FIELD-SYMBOL(<fa8>).
                  IF <fa8> IS ASSIGNED.
                    IF <lf_trr1>-zsbgb = 'O'.
                      <fa8> += assign_amt * -1.
                    ELSE.
                      <fa8> += assign_amt.
                    ENDIF.
                    <lf_mlhd>-mod = <lf_mlhd>-mod - assign_amt.
                  ENDIF.
                  UNASSIGN <fa8>.
                ENDIF.

                " 일별수불필드 할당
                UNASSIGN <lf_listd>.
                READ TABLE lt_listd ASSIGNING <lf_listd> WITH KEY kalnr = <lf_trr1>-kalnr
                                                                  budat = <lf_mlhd>-budat.
                IF sy-subrc = 0.
                  CLEAR:fielda.
                  CONCATENATE '<lf_listd>-' <lf_trr1>-zsfld 'A' INTO fielda.
                  ASSIGN (fielda) TO FIELD-SYMBOL(<fad8>).
                  IF <fad8> IS ASSIGNED.
                    IF <lf_trr1>-zsbgb = 'O'.
                      <fad8> += assign_amt * -1.
                    ELSE.
                      <fad8> += assign_amt.
                    ENDIF.
                    <lf_mlhd>-modd = <lf_mlhd>-modd - assign_amt.
                  ENDIF.
                  UNASSIGN <fad8>.
                ENDIF.

                "재무기준 수불필드 할당.
                CLEAR lv_hsl.
                IF <lf_mlhd>-hsl <> 0.
                  lv_hsl = assign_amt / 100.
                ELSE.
                  lv_hsl = 0.
                ENDIF.

                CLEAR ls_lista.
                MOVE-CORRESPONDING <lf_mlhd> TO ls_lista.
                ls_lista-spmon = key-%param-spmons.
                ls_lista-zsfld = <lf_trr1>-zsfld.
                ls_lista-racct = <lf_mlhd>-raccta.
                IF ls_lista-ktosl = 'BSX'.
                  ls_lista-dmbtr = lv_hsl.
                  ls_lista-dmbtr2 = lv_hsl.
                  ls_lista-dmbtr3 = lv_hsl.
                ELSEIF ls_lista-ktosl+0(2) = 'PR' OR ls_lista-ktosl = 'AUM' OR ls_lista-ktosl = 'KDM'.
                  CLEAR ls_lista-menge.
                  ls_lista-dmbtr1 = lv_hsl.
                  ls_lista-dmbtr2 = lv_hsl.
                  ls_lista-dmbtr3 = lv_hsl.
                ELSE.
                  CLEAR ls_lista-menge.
                  ls_lista-dmbtr3 = lv_hsl.
                ENDIF.

                CLEAR ls_data8.
                MOVE-CORRESPONDING ls_lista TO ls_data8.

                READ TABLE lt_lista ASSIGNING <lf_lista> WITH KEY spmon = ls_lista-spmon
                                                                  kalnr = ls_lista-kalnr
                                                                  zsfld = ls_lista-zsfld
                                                                  racct = ls_lista-racct
                                                                  ktosl = ls_lista-ktosl
                                                                  reftxt = ls_lista-reftxt.
                IF sy-subrc = 0.
                  <lf_lista>-menge += ls_lista-menge.
                  <lf_lista>-dmbtr += ls_lista-dmbtr.
                  <lf_lista>-dmbtr1 += ls_lista-dmbtr1.
                  <lf_lista>-dmbtr2 += ls_lista-dmbtr2.
                  <lf_lista>-dmbtr3 += ls_lista-dmbtr3.
                ELSE.
                  APPEND ls_lista TO lt_lista.
                  CLEAR ls_lista.
                ENDIF.
                CLEAR ls_lista.

                COLLECT ls_data8 INTO lt_data8.
                CLEAR ls_data8.

                "재무기준 수불부 비교계정 리스트 취합.
                lv_hsl =  lv_hsl * -1.

                CLEAR ls_lista.
                MOVE-CORRESPONDING <lf_mlhd> TO ls_lista.
                ls_lista-spmon = key-%param-spmons.
                ls_lista-zsfld = <lf_trr1>-zsfld.
                ls_lista-racct = <lf_mlhd>-racct.
                ls_lista-ktosl = <lf_mlhd>-ktosl1.
                CLEAR ls_lista-menge.
                ls_lista-dmbtr3 = lv_hsl.

                READ TABLE lt_lista ASSIGNING <lf_lista> WITH KEY spmon = ls_lista-spmon
                                                                  kalnr = ls_lista-kalnr
                                                                  zsfld = ls_lista-zsfld
                                                                  racct = ls_lista-racct
                                                                  ktosl = ls_lista-ktosl
                                                                  reftxt = ls_lista-reftxt.
                IF sy-subrc = 0.
                  <lf_lista>-dmbtr3 += ls_lista-dmbtr3.
                ELSE.
                  APPEND ls_lista TO lt_lista.
                  CLEAR ls_lista.
                ENDIF.
                CLEAR ls_lista.

              ENDLOOP.

              "단수차이 배분
              IF <lf_mlhd>-mod <> 0.
                READ TABLE lt_trr1 ASSIGNING <lf_trr1> INDEX ly_line.
                IF sy-subrc = 0.

                  UNASSIGN <lf_list>.
                  READ TABLE lt_list ASSIGNING <lf_list> WITH KEY kalnr = <lf_trr1>-kalnr.
                  IF sy-subrc = 0.
                    CLEAR:fielda.
                    CONCATENATE '<lf_list>-' <lf_trr1>-zsfld 'A' INTO fielda.
                    ASSIGN (fielda) TO <fa8>.
                    IF <fa8> IS ASSIGNED.
                      IF <lf_trr1>-zsbgb = 'O'.
                        <fa8> += <lf_mlhd>-mod * -1.
                      ELSE.
                        <fa8> += <lf_mlhd>-mod.
                      ENDIF.
                    ENDIF.
                    UNASSIGN <fa8>.
                  ENDIF.

                  CLEAR lv_hsl.
                  IF <lf_mlhd>-mod <> 0.
                    lv_hsl = <lf_mlhd>-mod / 100.
                  ELSE.
                    lv_hsl = 0.
                  ENDIF.

                  CLEAR ls_lista.
                  MOVE-CORRESPONDING <lf_mlhd> TO ls_lista.
                  ls_lista-spmon = key-%param-spmons.
                  ls_lista-zsfld = <lf_trr1>-zsfld.
                  ls_lista-racct = <lf_mlhd>-raccta.
                  IF ls_lista-ktosl = 'BSX'.
                    ls_lista-dmbtr = lv_hsl.
                    ls_lista-dmbtr2 = lv_hsl.
                    ls_lista-dmbtr3 = lv_hsl.
                  ELSEIF ls_lista-ktosl+0(2) = 'PR' OR ls_lista-ktosl = 'AUM' OR ls_lista-ktosl = 'KDM'.
                    CLEAR ls_lista-menge.
                    ls_lista-dmbtr1 = lv_hsl.
                    ls_lista-dmbtr2 = lv_hsl.
                    ls_lista-dmbtr3 = lv_hsl.
                  ELSE.
                    CLEAR ls_lista-menge.
                    ls_lista-dmbtr3 = lv_hsl.
                  ENDIF.

                  CLEAR ls_data8.
                  MOVE-CORRESPONDING ls_lista TO ls_data8.

                  READ TABLE lt_lista ASSIGNING <lf_lista> WITH KEY spmon = ls_lista-spmon
                                                                    kalnr = ls_lista-kalnr
                                                                    zsfld = ls_lista-zsfld
                                                                    racct = ls_lista-racct
                                                                    ktosl = ls_lista-ktosl
                                                                    reftxt = ls_lista-reftxt.
                  IF sy-subrc = 0.
                    <lf_lista>-menge += ls_lista-menge.
                    <lf_lista>-dmbtr += ls_lista-dmbtr.
                    <lf_lista>-dmbtr1 += ls_lista-dmbtr1.
                    <lf_lista>-dmbtr2 += ls_lista-dmbtr2.
                    <lf_lista>-dmbtr3 += ls_lista-dmbtr3.
                  ENDIF.
                  CLEAR ls_lista.

                  COLLECT ls_data8 INTO lt_data8.
                  CLEAR ls_data8.

                  "재무기준 수불부 비교계정 리스트 취합.
                  lv_hsl =  lv_hsl * -1.

                  CLEAR ls_lista.
                  MOVE-CORRESPONDING <lf_mlhd> TO ls_lista.
                  ls_lista-spmon = key-%param-spmons.
                  ls_lista-zsfld = <lf_trr1>-zsfld.
                  ls_lista-racct = <lf_mlhd>-racct.
                  ls_lista-ktosl = <lf_mlhd>-ktosl1.
                  CLEAR ls_lista-menge.
                  ls_lista-dmbtr3 = lv_hsl.

                  READ TABLE lt_lista ASSIGNING <lf_lista> WITH KEY spmon = ls_lista-spmon
                                                                    kalnr = ls_lista-kalnr
                                                                    zsfld = ls_lista-zsfld
                                                                    racct = ls_lista-racct
                                                                    ktosl = ls_lista-ktosl
                                                                    reftxt = ls_lista-reftxt.
                  IF sy-subrc = 0.
                    <lf_lista>-dmbtr3 += ls_lista-dmbtr3.
                  ENDIF.
                  CLEAR ls_lista.

                ENDIF.
              ENDIF.

              IF <lf_mlhd>-modd <> 0.
                READ TABLE lt_trr1 ASSIGNING <lf_trr1> INDEX ly_line.
                IF sy-subrc = 0.

                  UNASSIGN <lf_listd>.
                  READ TABLE lt_listd ASSIGNING <lf_listd> WITH KEY kalnr = <lf_trr1>-kalnr
                                                                    budat = <lf_mlhd>-budat.
                  IF sy-subrc = 0.
                    CLEAR:fielda.
                    CONCATENATE '<lf_listd>-' <lf_trr1>-zsfld 'A' INTO fielda.
                    ASSIGN (fielda) TO <fad8>.
                    IF <fad8> IS ASSIGNED.
                      IF <lf_trr1>-zsbgb = 'O'.
                        <fad8> += <lf_mlhd>-modd * -1.
                      ELSE.
                        <fad8> += <lf_mlhd>-modd.
                      ENDIF.
                    ENDIF.
                    UNASSIGN <fad8>.
                  ENDIF.
                ENDIF.
              ENDIF.

              CLEAR: ly_modm, ly_line.
              LOOP AT lt_trr3 ASSIGNING FIELD-SYMBOL(<lf_trr3>) WHERE kalnr = <lf_mlhd>-kalnr
                                                     AND umkal = <lf_mlhd>-iskalnr.

                IF ly_modm IS INITIAL.
                  ly_modm = <lf_trr3>-menge.
                  ly_line = sy-tabix.
                ELSE.
                  IF ly_modm < <lf_trr3>-menge.
                    ly_modm = <lf_trr3>-menge.
                    ly_line = sy-tabix.
                  ENDIF.
                ENDIF.

                CLEAR assign_amt.
                assign_amt = <lf_mlhd>-danga * <lf_trr3>-menge.


                "저장위치 수불필드 할당
                UNASSIGN <lf_listl>.
                READ TABLE lt_listl ASSIGNING <lf_listl> WITH KEY kalnr = <lf_trr3>-kalnr
                                                                lgort = <lf_trr3>-lgort.
                IF sy-subrc = 0.

                  CLEAR:fielda.
                  CONCATENATE '<lf_listl>-' <lf_trr3>-zsfld 'A' INTO fielda.
                  ASSIGN (fielda) TO FIELD-SYMBOL(<fal8>).
                  IF <fal8> IS ASSIGNED.
                    IF <lf_trr3>-zsbgb = 'O'.
                      <fal8> += assign_amt * -1.
                    ELSE.
                      <fal8> += assign_amt.
                    ENDIF.
                    <lf_mlhd>-modl = <lf_mlhd>-modl - assign_amt.
                  ENDIF.
                  UNASSIGN <fal8>.

                ENDIF.
              ENDLOOP.

              IF <lf_mlhd>-modl <> 0.
                READ TABLE lt_trr3 ASSIGNING <lf_trr3> INDEX ly_line.
                IF sy-subrc = 0.
                  UNASSIGN <lf_listl>.
                  READ TABLE lt_listl ASSIGNING <lf_listl> WITH KEY kalnr = <lf_trr3>-kalnr
                                                                  lgort = <lf_trr3>-lgort.
                  IF sy-subrc = 0.

                    CLEAR:fielda.
                    CONCATENATE '<lf_listl>-' <lf_trr3>-zsfld 'A' INTO fielda.
                    ASSIGN (fielda) TO <fal8>.
                    IF <fal8> IS ASSIGNED.
                      IF <lf_trr3>-zsbgb = 'O'.
                        <fal8> += <lf_mlhd>-modl * -1.
                      ELSE.
                        <fal8> += <lf_mlhd>-modl.
                      ENDIF.
                    ENDIF.
                    UNASSIGN <fal8>.
                  ENDIF.
                ENDIF.
              ENDIF.
            ENDIF.
          ENDIF.

          "****액티비티 값 배분*****
          IF <lf_mlhd>-typ1 = 'ZUPRV' AND ( <lf_mlhd>-typ5 = 'GBBAU' OR <lf_mlhd>-typ5 = 'ATPRD' OR <lf_mlhd>-typ5 = 'GBWIP' ) .

            READ TABLE lt_ac2 INTO ls_ac2 WITH KEY kalnr = <lf_mlhd>-kalnr
                                                   BINARY SEARCH.
            IF sy-subrc = 0.
              IF ls_ac2-menge = 0.
                <lf_mlhd>-danga = 0.
              ELSE.
                <lf_mlhd>-danga = <lf_mlhd>-hsl / ls_ac2-menge.
              ENDIF.
              <lf_mlhd>-mod = <lf_mlhd>-hsl.
              <lf_mlhd>-modd = <lf_mlhd>-hsl.
              <lf_mlhd>-modl = <lf_mlhd>-hsl.
            ENDIF.

            CLEAR: ly_modm, ly_line.
            LOOP AT lt_ac1 ASSIGNING FIELD-SYMBOL(<lf_ac1>) WHERE kalnr = <lf_mlhd>-kalnr.

              IF ly_modm IS INITIAL.
                ly_modm = <lf_ac1>-menge.
                ly_line = sy-tabix.
              ELSE.
                IF ly_modm < <lf_ac1>-menge.
                  ly_modm = <lf_ac1>-menge.
                  ly_line = sy-tabix.
                ENDIF.
              ENDIF.

              CLEAR assign_amt.
              assign_amt = <lf_mlhd>-danga * <lf_ac1>-menge.


              " 수불필드 할당
              UNASSIGN <lf_list>.
              READ TABLE lt_list ASSIGNING <lf_list> WITH KEY kalnr = <lf_ac1>-kalnr.
              IF sy-subrc = 0.
                CLEAR:fielda.
                CONCATENATE '<lf_list>-' <lf_ac1>-zsfld 'A' INTO fielda.
                ASSIGN (fielda) TO FIELD-SYMBOL(<fa9>).
                IF <fa9> IS ASSIGNED.
                  IF <lf_ac1>-zsbgb = 'O'.
                    <fa9> += assign_amt * -1.
                  ELSE.
                    <fa9> += assign_amt.
                  ENDIF.
                  <lf_mlhd>-mod = <lf_mlhd>-mod - assign_amt.
                ENDIF.
                UNASSIGN <fa9>.
              ENDIF.

              " 일별수불필드 할당
              UNASSIGN <lf_listd>.
              READ TABLE lt_listd ASSIGNING <lf_listd> WITH KEY kalnr = <lf_ac1>-kalnr
                                                                budat = <lf_mlhd>-budat.
              IF sy-subrc = 0.
                CLEAR:fielda.
                CONCATENATE '<lf_listd>-' <lf_ac1>-zsfld 'A' INTO fielda.
                ASSIGN (fielda) TO FIELD-SYMBOL(<fad9>).
                IF <fad9> IS ASSIGNED.
                  IF <lf_ac1>-zsbgb = 'O'.
                    <fad9> += assign_amt * -1.
                  ELSE.
                    <fad9> += assign_amt.
                  ENDIF.
                  <lf_mlhd>-modd = <lf_mlhd>-modd - assign_amt.
                ENDIF.
                UNASSIGN <fad9>.
              ENDIF.

              "재무기준 수불필드 할당.
              CLEAR lv_hsl.
              IF <lf_mlhd>-hsl <> 0.
                lv_hsl = assign_amt / 100.
              ELSE.
                lv_hsl = 0.
              ENDIF.

              CLEAR ls_lista.
              MOVE-CORRESPONDING <lf_mlhd> TO ls_lista.
              ls_lista-spmon = key-%param-spmons.
              ls_lista-zsfld = <lf_ac1>-zsfld.
              ls_lista-racct = <lf_mlhd>-raccta.
              IF ls_lista-ktosl = 'BSX'.
                ls_lista-dmbtr = lv_hsl.
                ls_lista-dmbtr2 = lv_hsl.
                ls_lista-dmbtr3 = lv_hsl.
              ELSEIF ls_lista-ktosl+0(2) = 'PR' OR ls_lista-ktosl = 'AUM' OR ls_lista-ktosl = 'KDM'.
                CLEAR ls_lista-menge.
                ls_lista-dmbtr1 = lv_hsl.
                ls_lista-dmbtr2 = lv_hsl.
                ls_lista-dmbtr3 = lv_hsl.
              ELSE.
                CLEAR ls_lista-menge.
                ls_lista-dmbtr3 = lv_hsl.
              ENDIF.

              CLEAR ls_data8.
              MOVE-CORRESPONDING ls_lista TO ls_data8.

              READ TABLE lt_lista ASSIGNING <lf_lista> WITH KEY spmon = ls_lista-spmon
                                                                kalnr = ls_lista-kalnr
                                                                zsfld = ls_lista-zsfld
                                                                racct = ls_lista-racct
                                                                ktosl = ls_lista-ktosl
                                                                reftxt = ls_lista-reftxt.
              IF sy-subrc = 0.
                <lf_lista>-menge += ls_lista-menge.
                <lf_lista>-dmbtr += ls_lista-dmbtr.
                <lf_lista>-dmbtr1 += ls_lista-dmbtr1.
                <lf_lista>-dmbtr2 += ls_lista-dmbtr2.
                <lf_lista>-dmbtr3 += ls_lista-dmbtr3.
              ELSE.
                APPEND ls_lista TO lt_lista.
                CLEAR ls_lista.
              ENDIF.
              CLEAR ls_lista.

              COLLECT ls_data8 INTO lt_data8.
              CLEAR ls_data8.

              "재무기준 수불부 비교계정 리스트 취합.
              lv_hsl =  lv_hsl * -1.

              CLEAR ls_lista.
              MOVE-CORRESPONDING <lf_mlhd> TO ls_lista.
              ls_lista-spmon = key-%param-spmons.
              ls_lista-zsfld = <lf_ac1>-zsfld.
              ls_lista-racct = <lf_mlhd>-racct.
              ls_lista-ktosl = <lf_mlhd>-ktosl1.
              CLEAR ls_lista-menge.
              ls_lista-dmbtr3 = lv_hsl.

              READ TABLE lt_lista ASSIGNING <lf_lista> WITH KEY spmon = ls_lista-spmon
                                                                kalnr = ls_lista-kalnr
                                                                zsfld = ls_lista-zsfld
                                                                racct = ls_lista-racct
                                                                ktosl = ls_lista-ktosl
                                                                reftxt = ls_lista-reftxt.
              IF sy-subrc = 0.
                <lf_lista>-dmbtr3 += ls_lista-dmbtr3.
              ELSE.
                APPEND ls_lista TO lt_lista.
                CLEAR ls_lista.
              ENDIF.
              CLEAR ls_lista.
            ENDLOOP.
            "단수차이 배분
            IF <lf_mlhd>-mod <> 0.
              READ TABLE lt_ac1 ASSIGNING <lf_ac1> INDEX ly_line.
              IF sy-subrc = 0.

                UNASSIGN <lf_list>.
                READ TABLE lt_list ASSIGNING <lf_list> WITH KEY kalnr = <lf_ac1>-kalnr.
                IF sy-subrc = 0.
                  CLEAR:fielda.
                  CONCATENATE '<lf_list>-' <lf_ac1>-zsfld 'A' INTO fielda.
                  ASSIGN (fielda) TO <fa9>.
                  IF <fa9> IS ASSIGNED.
                    IF <lf_ac1>-zsbgb = 'O'.
                      <fa9> += <lf_mlhd>-mod * -1.
                    ELSE.
                      <fa9> += <lf_mlhd>-mod.
                    ENDIF.
                  ENDIF.
                  UNASSIGN <fa9>.
                ENDIF.

                CLEAR lv_hsl.
                IF <lf_mlhd>-mod <> 0.
                  lv_hsl = <lf_mlhd>-mod / 100.
                ELSE.
                  lv_hsl = 0.
                ENDIF.

                CLEAR ls_lista.
                MOVE-CORRESPONDING <lf_mlhd> TO ls_lista.
                ls_lista-spmon = key-%param-spmons.
                ls_lista-zsfld = <lf_ac1>-zsfld.
                ls_lista-racct = <lf_mlhd>-raccta.
                IF ls_lista-ktosl = 'BSX'.
                  ls_lista-dmbtr = lv_hsl.
                  ls_lista-dmbtr2 = lv_hsl.
                  ls_lista-dmbtr3 = lv_hsl.
                ELSEIF ls_lista-ktosl+0(2) = 'PR' OR ls_lista-ktosl = 'AUM' OR ls_lista-ktosl = 'KDM'.
                  CLEAR ls_lista-menge.
                  ls_lista-dmbtr1 = lv_hsl.
                  ls_lista-dmbtr2 = lv_hsl.
                  ls_lista-dmbtr3 = lv_hsl.
                ELSE.
                  CLEAR ls_lista-menge.
                  ls_lista-dmbtr3 = lv_hsl.
                ENDIF.

                CLEAR ls_data8.
                MOVE-CORRESPONDING ls_lista TO ls_data8.

                READ TABLE lt_lista ASSIGNING <lf_lista> WITH KEY spmon = ls_lista-spmon
                                                                  kalnr = ls_lista-kalnr
                                                                  zsfld = ls_lista-zsfld
                                                                  racct = ls_lista-racct
                                                                  ktosl = ls_lista-ktosl
                                                                  reftxt = ls_lista-reftxt.
                IF sy-subrc = 0.
                  <lf_lista>-menge += ls_lista-menge.
                  <lf_lista>-dmbtr += ls_lista-dmbtr.
                  <lf_lista>-dmbtr1 += ls_lista-dmbtr1.
                  <lf_lista>-dmbtr2 += ls_lista-dmbtr2.
                  <lf_lista>-dmbtr3 += ls_lista-dmbtr3.
                ENDIF.
                CLEAR ls_lista.

                COLLECT ls_data8 INTO lt_data8.
                CLEAR ls_data8.

                "재무기준 수불부 비교계정 리스트 취합.
                lv_hsl =  lv_hsl * -1.

                CLEAR ls_lista.
                MOVE-CORRESPONDING <lf_mlhd> TO ls_lista.
                ls_lista-spmon = key-%param-spmons.
                ls_lista-zsfld = <lf_ac1>-zsfld.
                ls_lista-racct = <lf_mlhd>-racct.
                ls_lista-ktosl = <lf_mlhd>-ktosl1.
                CLEAR ls_lista-menge.
                ls_lista-dmbtr3 = lv_hsl.

                READ TABLE lt_lista ASSIGNING <lf_lista> WITH KEY spmon = ls_lista-spmon
                                                                  kalnr = ls_lista-kalnr
                                                                  zsfld = ls_lista-zsfld
                                                                  racct = ls_lista-racct
                                                                  ktosl = ls_lista-ktosl
                                                                  reftxt = ls_lista-reftxt.
                IF sy-subrc = 0.
                  <lf_lista>-dmbtr3 += ls_lista-dmbtr3.
                ENDIF.
                CLEAR ls_lista.

              ENDIF.
            ENDIF.

            IF <lf_mlhd>-modd <> 0.
              READ TABLE lt_ac1 ASSIGNING <lf_ac1> INDEX ly_line.
              IF sy-subrc = 0.

                UNASSIGN <lf_listd>.
                READ TABLE lt_listd ASSIGNING <lf_listd> WITH KEY kalnr = <lf_ac1>-kalnr
                                                                  budat = <lf_mlhd>-budat.
                IF sy-subrc = 0.
                  CLEAR:fielda.
                  CONCATENATE '<lf_listd>-' <lf_ac1>-zsfld 'A' INTO fielda.
                  ASSIGN (fielda) TO <fad9>.
                  IF <fad9> IS ASSIGNED.
                    IF <lf_ac1>-zsbgb = 'O'.
                      <fad9> += <lf_mlhd>-modd * -1.
                    ELSE.
                      <fad9> += <lf_mlhd>-modd.
                    ENDIF.
                  ENDIF.
                  UNASSIGN <fad9>.
                ENDIF.
              ENDIF.
            ENDIF.

            IF lv_ch2 = 'X'.
              CLEAR: ly_modm, ly_line.
              LOOP AT lt_ac3 ASSIGNING FIELD-SYMBOL(<lf_ac3>) WHERE kalnr = <lf_mlhd>-kalnr.

                IF ly_modm IS INITIAL.
                  ly_modm = <lf_ac3>-menge.
                  ly_line = sy-tabix.
                ELSE.
                  IF ly_modm < <lf_ac3>-menge.
                    ly_modm = <lf_ac3>-menge.
                    ly_line = sy-tabix.
                  ENDIF.
                ENDIF.

                CLEAR assign_amt.
                assign_amt = <lf_mlhd>-danga * <lf_ac3>-menge.


                "저장위치 수불필드 할당
                UNASSIGN <lf_listl>.
                READ TABLE lt_listl ASSIGNING <lf_listl> WITH KEY kalnr = <lf_ac3>-kalnr
                                                                lgort = <lf_ac3>-lgort.
                IF sy-subrc = 0.

                  CLEAR:fielda.
                  CONCATENATE '<lf_listl>-' <lf_ac3>-zsfld 'A' INTO fielda.
                  ASSIGN (fielda) TO FIELD-SYMBOL(<fal9>).
                  IF <fal9> IS ASSIGNED.
                    IF <lf_ac3>-zsbgb = 'O'.
                      <fal9> += assign_amt * -1.
                    ELSE.
                      <fal9> += assign_amt.
                    ENDIF.
                    <lf_mlhd>-modl = <lf_mlhd>-modl - assign_amt.
                  ENDIF.
                  UNASSIGN <fal9>.

                ENDIF.
              ENDLOOP.

              IF <lf_mlhd>-modl <> 0.
                READ TABLE lt_ac3 ASSIGNING <lf_ac3> INDEX ly_line.
                IF sy-subrc = 0.
                  UNASSIGN <lf_listl>.
                  READ TABLE lt_listl ASSIGNING <lf_listl> WITH KEY kalnr = <lf_ac3>-kalnr
                                                                  lgort = <lf_ac3>-lgort.
                  IF sy-subrc = 0.
                    CLEAR:fielda.
                    CONCATENATE '<lf_listl>-' <lf_ac3>-zsfld 'A' INTO fielda.
                    ASSIGN (fielda) TO <fal9>.
                    IF <fal9> IS ASSIGNED.
                      IF <lf_ac3>-zsbgb = 'O'.
                        <fal9> += <lf_mlhd>-modl * -1.
                      ELSE.
                        <fal9> += <lf_mlhd>-modl.
                      ENDIF.
                    ENDIF.
                    UNASSIGN <fal9>.
                  ENDIF.
                ENDIF.
              ENDIF.
            ENDIF.
          ENDIF.

        ENDLOOP.

        "--[수불데이터 수기처리 반영]------------------------------------------------------------------------------------
        READ TABLE lt_edate INTO ls_edate INDEX 1.

        DATA(p_sdate) = ls_edate-edate+0(6) && '01'.

        CLEAR: lt_0030, ls_0030.
        SELECT * FROM ZR_ASSB_0030
          WHERE matnr IN @r_matnr
          AND bwkey IN @r_werks
          AND bklas IN @r_bklas
          AND budat BETWEEN @p_sdate AND @ls_edate-edate
          INTO CORRESPONDING FIELDS OF TABLE @lt_0030.

        LOOP AT lt_0030 INTO ls_0030.
          SELECT SINGLE baseunit FROM i_product
            WHERE product = @ls_0030-matnr
            INTO @DATA(lv_meins).

          IF ls_0030-shkzg = 'H'.
            ls_0030-menge = ls_0030-menge * -1.
            ls_0030-dmbtr = ls_0030-dmbtr * -1.
          ENDIF.

*          IF ls_0030-dmbtr <> 0.
*            ls_0030-dmbtr = ls_0030-dmbtr / 100.
*          ENDIF.

          CLEAR ls_0060.
          READ TABLE lt_0060 INTO ls_0060 WITH KEY bklas = ls_0030-bklas
                                             werks = ls_0030-bwkey
                                             zsfld  = ls_0030-zsfld.
          IF sy-subrc = 0 .
            READ TABLE lt_list ASSIGNING <lf_list> WITH KEY kalnr = ls_0030-kalnr
                                                            matnr = ls_0030-matnr
                                                            bklas = ls_0030-bklas
                                                            bwkey = ls_0030-bwkey.
            IF sy-subrc = 0.
              IF ls_0030-menge <> 0.
                CONCATENATE '<lf_list>-' ls_0030-zsfld 'M' INTO DATA(f3m).
                ASSIGN (f3m) TO FIELD-SYMBOL(<fe3m>).
                IF ls_0060-zsbgb = 'A' OR ls_0060-zsbgb = 'I'.
                  <fe3m> += ls_0030-menge.
                ELSEIF ls_0060-zsbgb = 'E' OR ls_0060-zsbgb = 'O'.
                  <fe3m> -= ls_0030-menge.
                ENDIF.
              ENDIF.

              IF ls_0030-dmbtr <> 0.
                CONCATENATE '<lf_list>-' ls_0030-zsfld 'A' INTO DATA(f3a).
                ASSIGN (f3a) TO FIELD-SYMBOL(<fe3a>).
                IF ls_0060-zsbgb = 'A' OR ls_0060-zsbgb = 'I'.
                  <fe3a> += ls_0030-dmbtr.
                ELSEIF ls_0060-zsbgb = 'E' OR ls_0060-zsbgb = 'O'.
                  <fe3a> -= ls_0030-dmbtr.
                ENDIF.
              ENDIF.
            ENDIF.

            READ TABLE lt_listd ASSIGNING <lf_listd> WITH KEY kalnr = ls_0030-kalnr
                                                            matnr = ls_0030-matnr
                                                            bklas = ls_0030-bklas
                                                            bwkey = ls_0030-bwkey
                                                            budat = ls_0030-budat.
            IF sy-subrc <> 0.
              "일수불데이터에 정보가 없다면 추가.
              CLEAR ls_listd.
              MOVE-CORRESPONDING ls_0030 TO ls_listd.
              CLEAR ls_listd-uuid.
              ls_listd-spmon = key-%param-spmons.
              ls_listd-waers = 'KRW'.
              ls_listd-meins = lv_meins.
              APPEND ls_listd TO lt_listd.
              CLEAR ls_listd.
            ENDIF.

            READ TABLE lt_listd ASSIGNING <lf_listd> WITH KEY kalnr = ls_0030-kalnr
                                                            matnr = ls_0030-matnr
                                                            bklas = ls_0030-bklas
                                                            bwkey = ls_0030-bwkey
                                                            budat = ls_0030-budat.
            IF sy-subrc = 0.
              IF ls_0030-menge <> 0.
                CONCATENATE '<lf_listd>-' ls_0030-zsfld 'M' INTO DATA(f3md).
                ASSIGN (f3md) TO FIELD-SYMBOL(<fe3md>).
                IF ls_0060-zsbgb = 'A' OR ls_0060-zsbgb = 'I'.
                  <fe3md> += ls_0030-menge.
                ELSEIF ls_0060-zsbgb = 'E' OR ls_0060-zsbgb = 'O'.
                  <fe3md> -= ls_0030-menge.
                ENDIF.
              ENDIF.

              IF ls_0030-dmbtr <> 0.
                CONCATENATE '<lf_listd>-' ls_0030-zsfld 'A' INTO DATA(f3ad).
                ASSIGN (f3ad) TO FIELD-SYMBOL(<fe3ad>).
                IF ls_0060-zsbgb = 'A' OR ls_0060-zsbgb = 'I'.
                  <fe3ad> += ls_0030-dmbtr.
                ELSEIF ls_0060-zsbgb = 'E' OR ls_0060-zsbgb = 'O'.
                  <fe3ad> -= ls_0030-dmbtr.
                ENDIF.
              ENDIF.
            ENDIF.

           IF ls_0030-dmbtr <> 0.
             ls_0030-dmbtr = ls_0030-dmbtr / 100.
           ENDIF.

            CLEAR ls_lista.
            MOVE-CORRESPONDING ls_0030 TO ls_lista.
            CLEAR: ls_lista-dmbtr, ls_lista-menge.
            ls_lista-waers = 'KRW'.
            ls_lista-meins = lv_meins.
            ls_lista-spmon = key-%param-spmons.
            ls_lista-menge = ls_0030-menge.
            IF ls_lista-ktosl = 'BSX'.
              ls_lista-dmbtr = ls_0030-dmbtr.
              ls_lista-dmbtr2 = ls_0030-dmbtr.
              ls_lista-dmbtr3 = ls_0030-dmbtr.
            ELSEIF ls_lista-ktosl+0(2) = 'PR' OR ls_lista-ktosl = 'AUM' OR ls_lista-ktosl = 'KDM' OR ls_lista-ktosl = 'UMB'.
              CLEAR ls_lista-menge.
              ls_lista-dmbtr1 = ls_0030-dmbtr.
              ls_lista-dmbtr2 = ls_0030-dmbtr.
              ls_lista-dmbtr3 = ls_0030-dmbtr.
            ELSE.
              CLEAR ls_lista-menge.
              ls_lista-dmbtr3 = ls_0030-dmbtr.
            ENDIF.

            CLEAR ls_data8.
            MOVE-CORRESPONDING ls_lista TO ls_data8.

            READ TABLE lt_lista ASSIGNING <lf_lista> WITH KEY spmon = ls_lista-spmon
                                                              kalnr = ls_lista-kalnr
                                                              zsfld = ls_lista-zsfld
                                                              racct = ls_lista-racct
                                                              ktosl = ls_lista-ktosl
                                                              reftxt = ls_lista-reftxt.
            IF sy-subrc = 0.
              <lf_lista>-menge += ls_lista-menge.
              <lf_lista>-dmbtr += ls_lista-dmbtr.
              <lf_lista>-dmbtr1 += ls_lista-dmbtr1.
              <lf_lista>-dmbtr2 += ls_lista-dmbtr2.
              <lf_lista>-dmbtr3 += ls_lista-dmbtr3.
            ELSE.
              APPEND ls_lista TO lt_lista.
              CLEAR ls_lista.
            ENDIF.
            CLEAR ls_lista.

            COLLECT ls_data8 INTO lt_data8.
            CLEAR ls_data8.

          ENDIF.

        ENDLOOP.

        "--[수불데이터 가공]------------------------------------------------------------------------------------
        DATA lv_totm  TYPE p LENGTH 16 DECIMALS 3.
        DATA lv_tota  TYPE p LENGTH 16 DECIMALS 2.
        DATA lv_chaim TYPE p LENGTH 16 DECIMALS 3.
        DATA lv_chaia TYPE p LENGTH 16 DECIMALS 2.
        DATA lv_num   TYPE n LENGTH 2.

        "*******플랜트 월수불 가공*******
        CLEAR: lt_list4, ls_list4.
        LOOP AT lt_list ASSIGNING <lf_list>.
          "차이귀속
          CLEAR: lv_chaim,
                 lv_chaia.
          LOOP AT lt_0060a INTO ls_0060 WHERE     werks = <lf_list>-bwkey
                                             AND bklas = <lf_list>-bklas.
            CONCATENATE '<lf_list>-' ls_0060-zsfld 'M' INTO DATA(fcm).
            ASSIGN (fcm) TO FIELD-SYMBOL(<fecm>).
            IF <fecm> IS ASSIGNED.
              IF ls_0060-zsbgb = 'A' OR ls_0060-zsbgb = 'I'.
                lv_chaim += <fecm>.
              ELSEIF ls_0060-zsbgb = 'E' OR ls_0060-zsbgb = 'O'.
                lv_chaim -= <fecm>.
              ENDIF.
            ENDIF.

            CONCATENATE '<lf_list>-' ls_0060-zsfld 'A' INTO DATA(fca).
            ASSIGN (fca) TO FIELD-SYMBOL(<feca>).
            IF <feca> IS ASSIGNED.
              IF ls_0060-zsbgb = 'A' OR ls_0060-zsbgb = 'I'.
                lv_chaia += <feca>.
              ELSEIF ls_0060-zsbgb = 'E' OR ls_0060-zsbgb = 'O'.
                lv_chaia -= <feca>.
              ENDIF.
            ENDIF.

            UNASSIGN : <fecm>, <feca>.
          ENDLOOP.
          IF lv_chaim <> 0.
            READ TABLE lt_0060a INTO ls_0060 WITH KEY werks = <lf_list>-bwkey
                                                     bklas = <lf_list>-bklas
                                                     zdfgb = 'O'.
            IF sy-subrc = 0.
              CONCATENATE '<lf_list>-' ls_0060-zsfld 'M' INTO DATA(fcmt).
              ASSIGN (fcmt) TO FIELD-SYMBOL(<fecmt>).
              IF <fecmt> IS ASSIGNED.
*                IF ls_0060-zsbgb = 'O'.
*                  <fecmt> -= lv_chaim.
*                ELSE.
                <fecmt> += lv_chaim.
*                ENDIF.
                CLEAR ls_list4.
                MOVE-CORRESPONDING <lf_list> TO ls_list4.
                CLEAR ls_listl.
                READ TABLE lt_listl INTO ls_listl WITH KEY kalnr = ls_list4-kalnr
                                                           spmon = ls_list4-spmon.
                IF sy-subrc = 0.
                  ls_list4-sobkz = ls_listl-sobkz.
                ENDIF.
                ls_list4-mlptyp = 'ND'.
                ls_list4-zsfld = ls_0060-zsfld.
                ls_list4-mlmenge = lv_chaim.
                COLLECT ls_list4 INTO lt_list4.

              ENDIF.
              UNASSIGN <fecmt>.
            ENDIF.
          ENDIF.

          IF lv_chaia <> 0.
            READ TABLE lt_0060a INTO ls_0060 WITH KEY werks = <lf_list>-bwkey
                                                     bklas = <lf_list>-bklas
                                                     zdfgb = 'O'.
            IF sy-subrc = 0.
              CONCATENATE '<lf_list>-' ls_0060-zsfld 'A' INTO DATA(fcat).
              ASSIGN (fcat) TO FIELD-SYMBOL(<fecat>).
              IF <fecat> IS ASSIGNED.
*                IF ls_0060-zsbgb = 'O'.
*                  <fecat> -= lv_chaia.
*                ELSE.
                <fecat> += lv_chaia.

                CLEAR ls_list4.
                MOVE-CORRESPONDING <lf_list> TO ls_list4.
                CLEAR ls_listl.
                READ TABLE lt_listl INTO ls_listl WITH KEY kalnr = ls_list4-kalnr
                                                           spmon = ls_list4-spmon.
                IF sy-subrc = 0.
                  ls_list4-sobkz = ls_listl-sobkz.
                ENDIF.
                ls_list4-mlptyp = 'ND'.
                ls_list4-zsfld = ls_0060-zsfld.
                ls_list4-mlhsl = lv_chaia.
                COLLECT ls_list4 INTO lt_list4.
*                ENDIF.
              ENDIF.
              UNASSIGN <fecat>.
            ENDIF.
          ENDIF.

          " 합계처리
          LOOP AT lt_0060a INTO ls_0060 WHERE     werks = <lf_list>-bwkey
                                             AND bklas = <lf_list>-bklas
                                             AND zsbgb = 'T'.
            IF ls_0060-zsumc IS INITIAL.
              CONTINUE.
            ENDIF.

            SPLIT ls_0060-zsumc AT '+' INTO DATA(f01) DATA(f02) DATA(f03)
                  DATA(f04) DATA(f05) DATA(f06)
                  DATA(f07) DATA(f08) DATA(f09)
                  DATA(f10) DATA(f11) DATA(f12)
                  DATA(f13) DATA(f14) DATA(f15)
                  DATA(f16) DATA(f17) DATA(f18)
                  DATA(f19) DATA(f20) DATA(f21)
                  DATA(f22) DATA(f23) DATA(f24)
                  DATA(f25) DATA(f26) DATA(f27)
                  DATA(f28) DATA(f29) DATA(f30).

            CLEAR: lv_num,
                   lv_totm,
                   lv_tota.
            DO 30 TIMES.
              lv_num += 1.
              CONCATENATE 'F' lv_num INTO DATA(fn).
              ASSIGN (fn) TO FIELD-SYMBOL(<fen>).
              IF <fen> IS ASSIGNED.
                IF <fen> IS INITIAL.
                  CONTINUE.
                ENDIF.
              ELSE.
                CONTINUE.
              ENDIF.

              CONCATENATE '<lf_list>-' <fen> 'M' INTO DATA(ftm).
              ASSIGN (ftm) TO FIELD-SYMBOL(<fetm>).
              IF <fetm> IS ASSIGNED.
                lv_totm += <fetm>.
              ENDIF.
              CONCATENATE '<lf_list>-' <fen> 'A' INTO DATA(fta).
              ASSIGN (fta) TO FIELD-SYMBOL(<feta>).
              IF <feta> IS ASSIGNED.
                lv_tota += <feta>.
              ENDIF.
              UNASSIGN : <fetm>, <feta>, <fen>.
            ENDDO.

            CONCATENATE '<lf_list>-' ls_0060-zsfld 'M' INTO DATA(fieldtm).
            ASSIGN (fieldtm) TO FIELD-SYMBOL(<fietm>).
            IF <fietm> IS ASSIGNED.
              <fietm> = lv_totm.
            ENDIF.
            UNASSIGN <fietm>.
            CONCATENATE '<lf_list>-' ls_0060-zsfld 'A' INTO DATA(fieldta).
            ASSIGN (fieldta) TO FIELD-SYMBOL(<fieta>).
            IF <fieta> IS ASSIGNED.
              <fieta> = lv_tota.
            ENDIF.
            UNASSIGN <fieta>.
          ENDLOOP.

          " 단가계산
          LOOP AT lt_0060a INTO ls_0060 WHERE     werks = <lf_list>-bwkey
                                             AND bklas = <lf_list>-bklas.
            CONCATENATE '<lf_list>-' ls_0060-zsfld 'M' INTO DATA(fmd).
            ASSIGN (fmd) TO FIELD-SYMBOL(<femd>).
            IF <femd> IS NOT ASSIGNED.
              CONTINUE.
            ENDIF.
            CONCATENATE '<lf_list>-' ls_0060-zsfld 'A' INTO DATA(fad).
            ASSIGN (fad) TO FIELD-SYMBOL(<fead>).
            IF <fead> IS NOT ASSIGNED.
              CONTINUE.
            ENDIF.
            CONCATENATE '<lf_list>-' ls_0060-zsfld 'D' INTO DATA(fd).
            ASSIGN (fd) TO FIELD-SYMBOL(<fed>).
            IF <fed> IS NOT ASSIGNED.
              CONTINUE.
            ENDIF.
            IF <femd> <> 0 AND <fead> <> 0.
              <fed> = <fead> / <femd>.
            ELSE.
              <fed> = 0.
            ENDIF.
          ENDLOOP.
        ENDLOOP.

        IF lv_ch2 = 'X'.
          "*******저장위치 월수불 가공*******
          "배부되지 않음은 저장위치 9999로 지정하여 등록.
          LOOP AT lt_list4 INTO ls_list4.
            CLEAR ls_listl.
            MOVE-CORRESPONDING ls_list4 TO ls_listl.
            ls_listl-lgort = '9999'.

            READ TABLE lt_listl ASSIGNING <lf_listl> WITH KEY spmon = ls_listl-spmon
                                                              kalnr = ls_listl-kalnr
                                                              matnr = ls_listl-matnr
                                                              bwkey = ls_listl-bwkey
                                                              lgort = ls_listl-lgort.
            IF sy-subrc = 0.

              IF ls_list4-mlmenge <> 0.
                CONCATENATE '<lf_listl>-' ls_list4-zsfld 'M' INTO DATA(fm9999).
                ASSIGN (fm9999) TO FIELD-SYMBOL(<fm9999>).
                IF <fm9999> IS ASSIGNED.
                  <fm9999> += ls_list4-mlmenge.
                ENDIF.
                UNASSIGN <fm9999>.
              ENDIF.
              IF ls_list4-mlhsl <> 0.
                CONCATENATE '<lf_listl>-' ls_list4-zsfld 'A' INTO DATA(fa9999).
                ASSIGN (fa9999) TO FIELD-SYMBOL(<fa9999>).
                IF <fa9999> IS ASSIGNED.
                  <fa9999> += ls_list4-mlhsl.
                ENDIF.
                UNASSIGN <fa9999>.
              ENDIF.
            ELSE.

              APPEND ls_listl TO lt_listl.

              UNASSIGN <lf_listl>.
              READ TABLE lt_listl ASSIGNING <lf_listl> WITH KEY spmon = ls_listl-spmon
                                                              kalnr = ls_listl-kalnr
                                                              matnr = ls_listl-matnr
                                                              bwkey = ls_listl-bwkey
                                                              lgort = ls_listl-lgort.
              IF sy-subrc = 0.

                IF ls_list4-mlmenge <> 0.
                  CONCATENATE '<lf_listl>-' ls_list4-zsfld 'M' INTO fm9999.
                  ASSIGN (fm9999) TO <fm9999>.
                  IF <fm9999> IS ASSIGNED.
                    <fm9999> += ls_list4-mlmenge.
                  ENDIF.
                  UNASSIGN <fm9999>.
                ENDIF.
                IF ls_list4-mlhsl <> 0.
                  CONCATENATE '<lf_listl>-' ls_list4-zsfld 'A' INTO fa9999.
                  ASSIGN (fa9999) TO <fa9999>.
                  IF <fa9999> IS ASSIGNED.
                    <fa9999> += ls_list4-mlhsl.
                  ENDIF.
                  UNASSIGN <fa9999>.
                ENDIF.

              ENDIF.
            ENDIF.

            CLEAR ls_listl.
          ENDLOOP.

          LOOP AT lt_listl ASSIGNING <lf_listl>.
            " 차이귀속
            CLEAR: lv_chaim,
                   lv_chaia.
            LOOP AT lt_0060a INTO ls_0060 WHERE     werks = <lf_listl>-bwkey
                                               AND bklas = <lf_listl>-bklas.
              CONCATENATE '<lf_listl>-' ls_0060-zsfld 'M' INTO DATA(fcml).
              ASSIGN (fcml) TO FIELD-SYMBOL(<fecml>).
              IF <fecml> IS ASSIGNED.
                IF ls_0060-zsbgb = 'A' OR ls_0060-zsbgb = 'I'.
                  lv_chaim += <fecml>.
                ELSEIF ls_0060-zsbgb = 'E' OR ls_0060-zsbgb = 'O'.
                  lv_chaim -= <fecml>.
                ENDIF.
              ENDIF.

              CONCATENATE '<lf_listl>-' ls_0060-zsfld 'A' INTO DATA(fcal).
              ASSIGN (fcal) TO FIELD-SYMBOL(<fecal>).
              IF <fecal> IS ASSIGNED.
                IF ls_0060-zsbgb = 'A' OR ls_0060-zsbgb = 'I'.
                  lv_chaia += <fecal>.
                ELSEIF ls_0060-zsbgb = 'E' OR ls_0060-zsbgb = 'O'.
                  lv_chaia -= <fecal>.
                ENDIF.
              ENDIF.
              UNASSIGN : <fecml>, <fecal>.
            ENDLOOP.
            IF lv_chaim <> 0.
              READ TABLE lt_0060a INTO ls_0060 WITH KEY werks = <lf_listl>-bwkey
                                                       bklas = <lf_listl>-bklas
                                                       zdfgb = 'L'.
              IF sy-subrc = 0.
                CONCATENATE '<lf_listl>-' ls_0060-zsfld 'M' INTO DATA(fcmtl).
                ASSIGN (fcmtl) TO FIELD-SYMBOL(<fecmtl>).
                IF <fecmtl> IS ASSIGNED.
*                IF ls_0060-zsbgb = 'O'.
*                  <fecmt> -= lv_chaim.
*                ELSE.
                  <fecmtl> += lv_chaim.
*                ENDIF.
*                CLEAR ls_list4.
*                MOVE-CORRESPONDING <lf_listl> TO ls_list4.
*                ls_list4-mlptyp = 'ND'.
*                ls_list4-zsfld = ls_0060-zsfld.
*                ls_list4-mlmenge = lv_chaim.
*                COLLECT ls_list4 INTO lt_list4.

                ENDIF.
                UNASSIGN <fecmtl>.
              ENDIF.
            ENDIF.

            IF lv_chaia <> 0.
              READ TABLE lt_0060a INTO ls_0060 WITH KEY werks = <lf_listl>-bwkey
                                                       bklas = <lf_listl>-bklas
                                                       zdfgb = 'L'.
              IF sy-subrc = 0.
                CONCATENATE '<lf_listl>-' ls_0060-zsfld 'A' INTO DATA(fcatl).
                ASSIGN (fcatl) TO FIELD-SYMBOL(<fecatl>).
                IF <fecatl> IS ASSIGNED.
*                IF ls_0060-zsbgb = 'O'.
*                  <fecat> -= lv_chaia.
*                ELSE.
                  <fecatl> += lv_chaia.

*                CLEAR ls_list4.
*                MOVE-CORRESPONDING <lf_listl> TO ls_list4.
*                ls_list4-mlptyp = 'ND'.
*                ls_list4-zsfld = ls_0060-zsfld.
*                ls_list4-mlhsl = lv_chaia.
*                COLLECT ls_list4 INTO lt_list4.
*                ENDIF.
                ENDIF.
                UNASSIGN <fecatl>.
              ENDIF.
            ENDIF.

            " 합계처리
            LOOP AT lt_0060a INTO ls_0060 WHERE     werks = <lf_listl>-bwkey
                                               AND bklas = <lf_listl>-bklas
                                               AND zsbgb = 'T'.
              IF ls_0060-zsumc IS INITIAL.
                CONTINUE.
              ENDIF.

              SPLIT ls_0060-zsumc AT '+' INTO DATA(f01l) DATA(f02l) DATA(f03l)
                    DATA(f04l) DATA(f05l) DATA(f06l)
                    DATA(f07l) DATA(f08l) DATA(f09l)
                    DATA(f10l) DATA(f11l) DATA(f12l)
                    DATA(f13l) DATA(f14l) DATA(f15l)
                    DATA(f16l) DATA(f17l) DATA(f18l)
                    DATA(f19l) DATA(f20l) DATA(f21l)
                    DATA(f22l) DATA(f23l) DATA(f24l)
                    DATA(f25l) DATA(f26l) DATA(f27l)
                    DATA(f28l) DATA(f29l) DATA(f30l).

              CLEAR: lv_num,
                     lv_totm,
                     lv_tota.
              DO 30 TIMES.
                lv_num += 1.
                CONCATENATE 'F' lv_num 'L' INTO DATA(fnl).
                ASSIGN (fnl) TO FIELD-SYMBOL(<fenl>).
                IF <fenl> IS ASSIGNED.
                  IF <fenl> IS INITIAL.
                    CONTINUE.
                  ENDIF.
                ELSE.
                  CONTINUE.
                ENDIF.

                CONCATENATE '<lf_listl>-' <fenl> 'M' INTO DATA(ftml).
                ASSIGN (ftml) TO FIELD-SYMBOL(<fetml>).
                IF <fetml> IS ASSIGNED.
                  lv_totm += <fetml>.
                ENDIF.
                CONCATENATE '<lf_listl>-' <fenl> 'A' INTO DATA(ftal).
                ASSIGN (ftal) TO FIELD-SYMBOL(<fetal>).
                IF <fetal> IS ASSIGNED.
                  lv_tota += <fetal>.
                ENDIF.
                UNASSIGN : <fetml>, <fetal>, <fenl>.
              ENDDO.

              CONCATENATE '<lf_listl>-' ls_0060-zsfld 'M' INTO DATA(fieldtml).
              ASSIGN (fieldtml) TO FIELD-SYMBOL(<fietml>).
              IF <fietml> IS ASSIGNED.
                <fietml> = lv_totm.
              ENDIF.
              UNASSIGN <fietml>.
              CONCATENATE '<lf_listl>-' ls_0060-zsfld 'A' INTO DATA(fieldtal).
              ASSIGN (fieldtal) TO FIELD-SYMBOL(<fietal>).
              IF <fietal> IS ASSIGNED.
                <fietal> = lv_tota.
              ENDIF.
              UNASSIGN <fietal>.
            ENDLOOP.

            " 단가계산
            LOOP AT lt_0060a INTO ls_0060 WHERE     werks = <lf_listl>-bwkey
                                               AND bklas = <lf_listl>-bklas.
              CONCATENATE '<lf_listl>-' ls_0060-zsfld 'M' INTO DATA(fmdl).
              ASSIGN (fmdl) TO FIELD-SYMBOL(<femdl>).
              IF <femdl> IS NOT ASSIGNED.
                CONTINUE.
              ENDIF.
              CONCATENATE '<lf_listl>-' ls_0060-zsfld 'A' INTO DATA(fadl).
              ASSIGN (fadl) TO FIELD-SYMBOL(<feadl>).
              IF <feadl> IS NOT ASSIGNED.
                CONTINUE.
              ENDIF.
              CONCATENATE '<lf_listl>-' ls_0060-zsfld 'D' INTO DATA(fdl).
              ASSIGN (fdl) TO FIELD-SYMBOL(<fedl>).
              IF <fedl> IS NOT ASSIGNED.
                CONTINUE.
              ENDIF.
              IF <femdl> <> 0 AND <feadl> <> 0.
                <fedl> = <feadl> / <femdl>.
              ELSE.
                <fedl> = 0.
              ENDIF.
            ENDLOOP.
          ENDLOOP.
        ENDIF.

        "*******플랜트레벨 일수불 가공*******
        SORT lt_listd BY kalnr budat.
        LOOP AT lt_listd ASSIGNING <lf_listd>.
          "다음 데이터 기초에 삽입.
          IF <lf_listd>-budat+6(2) = '01'.
            CLEAR: lv_chaim,
                 lv_chaia,
                 fcm, fca.
          ELSE.
            READ TABLE lt_0060a INTO ls_0060 WITH KEY bklas = <lf_listd>-bklas
                                                   werks = <lf_listd>-bwkey
                                                   zsbgb = 'A'.
            IF ls_0060-zsfld IS NOT INITIAL.
              CLEAR: fieldm,
                     fielda.
              CONCATENATE '<lf_listd>-' ls_0060-zsfld 'M' INTO fieldm.
              ASSIGN (fieldm) TO FIELD-SYMBOL(<fmf>).
              IF <fmf> IS ASSIGNED AND <fmf> = 0.
                <fmf> += lv_chaim.
              ENDIF.
              UNASSIGN <fmf>.
              CONCATENATE '<lf_listd>-' ls_0060-zsfld 'A' INTO fielda.
              ASSIGN (fielda) TO FIELD-SYMBOL(<faf>).
              IF <faf> IS ASSIGNED AND <faf> = 0.
                <faf> += lv_chaia.
              ENDIF.
              UNASSIGN <faf>.
            ENDIF.
          ENDIF.
          " 일별 기말재고 계산.
          READ TABLE lt_edate INTO ls_edate WITH KEY edate = <lf_listd>-budat.
          IF sy-subrc <> 0.
            CLEAR: lv_chaim,
                 lv_chaia,
                 fcm, fca.
            LOOP AT lt_0060a INTO ls_0060 WHERE     werks = <lf_listd>-bwkey
                                             AND bklas = <lf_listd>-bklas.
              CONCATENATE '<lf_listd>-' ls_0060-zsfld 'M' INTO fcm.
              ASSIGN (fcm) TO FIELD-SYMBOL(<fecmd>).
              IF <fecmd> IS ASSIGNED.
                IF ls_0060-zsbgb = 'A' OR ls_0060-zsbgb = 'I'.
                  lv_chaim += <fecmd>.
                ELSEIF ls_0060-zsbgb = 'O'.
                  lv_chaim -= <fecmd>.
                ENDIF.
              ENDIF.
              UNASSIGN <fecmd>.
              CONCATENATE '<lf_listd>-' ls_0060-zsfld 'A' INTO fca.
              ASSIGN (fca) TO FIELD-SYMBOL(<fecad>).
              IF <fecad> IS ASSIGNED.
                IF ls_0060-zsbgb = 'A' OR ls_0060-zsbgb = 'I'.
                  lv_chaia += <fecad>.
                ELSEIF ls_0060-zsbgb = 'O'.
                  lv_chaia -= <fecad>.
                ENDIF.
              ENDIF.
              UNASSIGN <fecad>.

            ENDLOOP.

            READ TABLE lt_0060a INTO ls_0060 WITH KEY bklas = <lf_listd>-bklas
                                                   werks = <lf_listd>-bwkey
                                                   zsbgb = 'E'.
            IF ls_0060-zsfld IS NOT INITIAL.
              CLEAR: fieldm,
                     fielda.
              CONCATENATE '<lf_listd>-' ls_0060-zsfld 'M' INTO fieldm.
              ASSIGN (fieldm) TO FIELD-SYMBOL(<fme>).
              IF <fme> IS ASSIGNED.
                <fme> += lv_chaim.
              ENDIF.
              UNASSIGN <fme>.
              CONCATENATE '<lf_listd>-' ls_0060-zsfld 'A' INTO fielda.
              ASSIGN (fielda) TO FIELD-SYMBOL(<fae>).
              IF <fae> IS ASSIGNED.
                <fae> += lv_chaia.
              ENDIF.
              UNASSIGN <fae>.
            ENDIF.

          ELSE.
            " 차이귀속
            CLEAR: lv_chaim,
                   lv_chaia,
                   fcm, fca.
            LOOP AT lt_0060a INTO ls_0060 WHERE     werks = <lf_listd>-bwkey
                                               AND bklas = <lf_listd>-bklas.
              CONCATENATE '<lf_listd>-' ls_0060-zsfld 'M' INTO fcm.
              ASSIGN (fcm) TO FIELD-SYMBOL(<fecmdf>).
              IF <fecmdf> IS ASSIGNED.
                IF ls_0060-zsbgb = 'A' OR ls_0060-zsbgb = 'I'.
                  lv_chaim += <fecmdf>.
                ELSEIF ls_0060-zsbgb = 'E' OR ls_0060-zsbgb = 'O'.
                  lv_chaim -= <fecmdf>.
                ENDIF.
              ENDIF.

              CONCATENATE '<lf_listd>-' ls_0060-zsfld 'A' INTO fca.
              ASSIGN (fca) TO FIELD-SYMBOL(<fecadf>).
              IF <fecadf> IS ASSIGNED.
                IF ls_0060-zsbgb = 'A' OR ls_0060-zsbgb = 'I'.
                  lv_chaia += <fecadf>.
                ELSEIF ls_0060-zsbgb = 'E' OR ls_0060-zsbgb = 'O'.
                  lv_chaia -= <fecadf>.
                ENDIF.
              ENDIF.
              UNASSIGN : <fecmdf>, <fecadf>.
            ENDLOOP.

            IF lv_chaim <> 0.
              READ TABLE lt_0060a INTO ls_0060 WITH KEY werks = <lf_listd>-bwkey
                                                       bklas = <lf_listd>-bklas
                                                       zdfgb = 'O'.
              IF sy-subrc = 0.
                CONCATENATE '<lf_listd>-' ls_0060-zsfld 'M' INTO DATA(fcmtd).
                ASSIGN (fcmtd) TO FIELD-SYMBOL(<fecmtd>).
                IF <fecmtd> IS ASSIGNED.
                  <fecmtd> += lv_chaim.
                ENDIF.
                UNASSIGN <fecmtd>.
              ENDIF.
            ENDIF.

            IF lv_chaia <> 0.
              READ TABLE lt_0060a INTO ls_0060 WITH KEY werks = <lf_listd>-bwkey
                                                       bklas = <lf_listd>-bklas
                                                       zdfgb = 'O'.
              IF sy-subrc = 0.
                CONCATENATE '<lf_listd>-' ls_0060-zsfld 'A' INTO DATA(fcatd).
                ASSIGN (fcatd) TO FIELD-SYMBOL(<fecatd>).
                IF <fecatd> IS ASSIGNED.
                  <fecatd> += lv_chaia.
                ENDIF.
                UNASSIGN <fecatd>.
              ENDIF.
            ENDIF.
          ENDIF.

          " 합계처리
          LOOP AT lt_0060a INTO ls_0060 WHERE     werks = <lf_listd>-bwkey
                                             AND bklas = <lf_listd>-bklas
                                             AND zsbgb = 'T'.
            IF ls_0060-zsumc IS INITIAL.
              CONTINUE.
            ENDIF.

            SPLIT ls_0060-zsumc AT '+' INTO DATA(f01d) DATA(f02d) DATA(f03d)
                  DATA(f04d) DATA(f05d) DATA(f06d)
                  DATA(f07d) DATA(f08d) DATA(f09d)
                  DATA(f10d) DATA(f11d) DATA(f12d)
                  DATA(f13d) DATA(f14d) DATA(f15d)
                  DATA(f16d) DATA(f17d) DATA(f18d)
                  DATA(f19d) DATA(f20d) DATA(f21d)
                  DATA(f22d) DATA(f23d) DATA(f24d)
                  DATA(f25d) DATA(f26d) DATA(f27d)
                  DATA(f28d) DATA(f29d) DATA(f30d).

            CLEAR: lv_num,
                   lv_totm,
                   lv_tota.
            DO 30 TIMES.
              lv_num += 1.
              CONCATENATE 'F' lv_num 'D' INTO DATA(fnd).
              ASSIGN (fnd) TO FIELD-SYMBOL(<fend>).
              IF <fend> IS ASSIGNED.
                IF <fend> IS INITIAL.
                  CONTINUE.
                ENDIF.
              ELSE.
                CONTINUE.
              ENDIF.

              CONCATENATE '<lf_listd>-' <fend> 'M' INTO DATA(ftmd).
              ASSIGN (ftmd) TO FIELD-SYMBOL(<fetmd>).
              IF <fetmd> IS ASSIGNED.
                lv_totm += <fetmd>.
              ENDIF.
              CONCATENATE '<lf_listd>-' <fend> 'A' INTO DATA(ftad).
              ASSIGN (ftad) TO FIELD-SYMBOL(<fetad>).
              IF <fetad> IS ASSIGNED.
                lv_tota += <fetad>.
              ENDIF.

              UNASSIGN : <fetmd>, <fetad>, <fend>.
            ENDDO.

            CONCATENATE '<lf_listd>-' ls_0060-zsfld 'M' INTO DATA(fieldtmd).
            ASSIGN (fieldtmd) TO FIELD-SYMBOL(<fietmd>).
            IF <fietmd> IS ASSIGNED.
              <fietmd> = lv_totm.
            ENDIF.
            UNASSIGN <fietmd>.
            CONCATENATE '<lf_listd>-' ls_0060-zsfld 'A' INTO DATA(fieldtad).
            ASSIGN (fieldtad) TO FIELD-SYMBOL(<fietad>).
            IF <fietad> IS ASSIGNED.
              <fietad> = lv_tota.
            ENDIF.
            UNASSIGN <fietad>.
          ENDLOOP.

          " 단가계산
          LOOP AT lt_0060a INTO ls_0060 WHERE     werks = <lf_listd>-bwkey
                                             AND bklas = <lf_listd>-bklas.
            CONCATENATE '<lf_listd>-' ls_0060-zsfld 'M' INTO DATA(fmdd).
            ASSIGN (fmdd) TO FIELD-SYMBOL(<femdd>).
            IF <femdd> IS NOT ASSIGNED.
              CONTINUE.
            ENDIF.
            CONCATENATE '<lf_listd>-' ls_0060-zsfld 'A' INTO DATA(fadd).
            ASSIGN (fadd) TO FIELD-SYMBOL(<feadd>).
            IF <feadd> IS NOT ASSIGNED.
              CONTINUE.
            ENDIF.
            CONCATENATE '<lf_listd>-' ls_0060-zsfld 'D' INTO DATA(fdd).
            ASSIGN (fdd) TO FIELD-SYMBOL(<fedd>).
            IF <fedd> IS NOT ASSIGNED.
              CONTINUE.
            ENDIF.
            IF <femdd> <> 0 AND <feadd> <> 0.
              <fedd> = <feadd> / <femdd>.
            ELSE.
              <fedd> = 0.
            ENDIF.
          ENDLOOP.
        ENDLOOP.

        "*******재무기준 수불 가공*******
        "배부되지 않음
        DELETE lt_data8 WHERE dmbtr2 = 0.
        LOOP AT lt_data8 INTO ls_data8.
          MOVE-CORRESPONDING ls_data8 TO ls_lista.

          CLEAR ls_0060.
          READ TABLE lt_0060 INTO ls_0060 WITH KEY bklas = ls_lista-bklas
                                                   werks = ls_lista-bwkey
                                                   zdfgb = 'O'.
          IF sy-subrc = 0.
            ls_lista-zsfld = ls_0060-zsfld.
          ENDIF.

          ls_lista-spmon = key-%param-spmons.
          ls_lista-racct = '9999999999'.
          ls_lista-reftxt = '수불차이귀속'.
          ls_lista-ktosl = 'ND'.
          IF ls_lista-waers IS INITIAL.
            ls_lista-waers = 'KRW'.
          ENDIF.
          ls_lista-dmbtr1 = ls_data8-dmbtr2 * -1.
          ls_lista-dmbtr2 = ls_data8-dmbtr2 * -1.
          APPEND ls_lista TO lt_lista.
          CLEAR ls_lista.
        ENDLOOP.

*        LOOP AT lt_lista ASSIGNING FIELD-SYMBOL(<lf_lista1>) WHERE ktosl = 'AB' OR ktosl = 'ED'.
*          READ TABLE lt_acc INTO ls_acc WITH KEY werks = <lf_list1>-bwkey
*                                                 bklas = <lf_list1>-bklas.
*          IF sy-subrc = 0.
*            <lf_list1>-racct = ls_acc-racct.
*          ENDIF.
*        ENDLOOP.

        DELETE lt_lista WHERE menge = 0 AND dmbtr = 0 AND dmbtr1 = 0 AND dmbtr2 = 0 AND dmbtr3 = 0.

        DELETE lt_list WHERE f000m = 0 AND f000a = 0 AND
                             f001m = 0 AND f001a = 0 AND
                             f002m = 0 AND f002a = 0 AND
                             f003m = 0 AND f003a = 0 AND
                             f004m = 0 AND f004a = 0 AND
                             f005m = 0 AND f005a = 0 AND
                             f006m = 0 AND f006a = 0 AND
                             f007m = 0 AND f007a = 0 AND
                             f008m = 0 AND f008a = 0 AND
                             f009m = 0 AND f009a = 0 AND
                             f010m = 0 AND f010a = 0 AND
                             f011m = 0 AND f011a = 0 AND
                             f012m = 0 AND f012a = 0 AND
                             f013m = 0 AND f013a = 0 AND
                             f014m = 0 AND f014a = 0 AND
                             f015m = 0 AND f015a = 0 AND
                             f016m = 0 AND f016a = 0 AND
                             f017m = 0 AND f017a = 0 AND
                             f018m = 0 AND f018a = 0 AND
                             f019m = 0 AND f019a = 0 AND
                             f020m = 0 AND f020a = 0 AND
                             f021m = 0 AND f021a = 0 AND
                             f022m = 0 AND f022a = 0 AND
                             f023m = 0 AND f023a = 0 AND
                             f024m = 0 AND f024a = 0 AND
                             f025m = 0 AND f025a = 0 AND
                             f026m = 0 AND f026a = 0 AND
                             f027m = 0 AND f027a = 0 AND
                             f028m = 0 AND f028a = 0 AND
                             f029m = 0 AND f029a = 0 AND
                             f030m = 0 AND f030a = 0 AND
                             f031m = 0 AND f031a = 0 AND
                             f032m = 0 AND f032a = 0 AND
                             f033m = 0 AND f033a = 0 AND
                             f034m = 0 AND f034a = 0 AND
                             f035m = 0 AND f035a = 0 AND
                             f036m = 0 AND f036a = 0 AND
                             f037m = 0 AND f037a = 0 AND
                             f038m = 0 AND f038a = 0 AND
                             f039m = 0 AND f039a = 0 AND
                             f040m = 0 AND f040a = 0 AND
                             f041m = 0 AND f041a = 0 AND
                             f042m = 0 AND f042a = 0 AND
                             f043m = 0 AND f043a = 0 AND
                             f044m = 0 AND f044a = 0 AND
                             f045m = 0 AND f045a = 0 AND
                             f046m = 0 AND f046a = 0 AND
                             f047m = 0 AND f047a = 0 AND
                             f048m = 0 AND f048a = 0 AND
                             f049m = 0 AND f049a = 0 AND
                             f050m = 0 AND f050a = 0 AND
                             f099m = 0 AND f099a = 0 .

        DELETE lt_listd WHERE f000m = 0 AND f000a = 0 AND
                             f001m = 0 AND f001a = 0 AND
                             f002m = 0 AND f002a = 0 AND
                             f003m = 0 AND f003a = 0 AND
                             f004m = 0 AND f004a = 0 AND
                             f005m = 0 AND f005a = 0 AND
                             f006m = 0 AND f006a = 0 AND
                             f007m = 0 AND f007a = 0 AND
                             f008m = 0 AND f008a = 0 AND
                             f009m = 0 AND f009a = 0 AND
                             f010m = 0 AND f010a = 0 AND
                             f011m = 0 AND f011a = 0 AND
                             f012m = 0 AND f012a = 0 AND
                             f013m = 0 AND f013a = 0 AND
                             f014m = 0 AND f014a = 0 AND
                             f015m = 0 AND f015a = 0 AND
                             f016m = 0 AND f016a = 0 AND
                             f017m = 0 AND f017a = 0 AND
                             f018m = 0 AND f018a = 0 AND
                             f019m = 0 AND f019a = 0 AND
                             f020m = 0 AND f020a = 0 AND
                             f021m = 0 AND f021a = 0 AND
                             f022m = 0 AND f022a = 0 AND
                             f023m = 0 AND f023a = 0 AND
                             f024m = 0 AND f024a = 0 AND
                             f025m = 0 AND f025a = 0 AND
                             f026m = 0 AND f026a = 0 AND
                             f027m = 0 AND f027a = 0 AND
                             f028m = 0 AND f028a = 0 AND
                             f029m = 0 AND f029a = 0 AND
                             f030m = 0 AND f030a = 0 AND
                             f031m = 0 AND f031a = 0 AND
                             f032m = 0 AND f032a = 0 AND
                             f033m = 0 AND f033a = 0 AND
                             f034m = 0 AND f034a = 0 AND
                             f035m = 0 AND f035a = 0 AND
                             f036m = 0 AND f036a = 0 AND
                             f037m = 0 AND f037a = 0 AND
                             f038m = 0 AND f038a = 0 AND
                             f039m = 0 AND f039a = 0 AND
                             f040m = 0 AND f040a = 0 AND
                             f041m = 0 AND f041a = 0 AND
                             f042m = 0 AND f042a = 0 AND
                             f043m = 0 AND f043a = 0 AND
                             f044m = 0 AND f044a = 0 AND
                             f045m = 0 AND f045a = 0 AND
                             f046m = 0 AND f046a = 0 AND
                             f047m = 0 AND f047a = 0 AND
                             f048m = 0 AND f048a = 0 AND
                             f049m = 0 AND f049a = 0 AND
                             f050m = 0 AND f050a = 0 AND
                             f099m = 0 AND f099a = 0 .
        IF lv_ch2 = 'X'.
          DELETE lt_listl WHERE f000m = 0 AND f000a = 0 AND
                               f001m = 0 AND f001a = 0 AND
                               f002m = 0 AND f002a = 0 AND
                               f003m = 0 AND f003a = 0 AND
                               f004m = 0 AND f004a = 0 AND
                               f005m = 0 AND f005a = 0 AND
                               f006m = 0 AND f006a = 0 AND
                               f007m = 0 AND f007a = 0 AND
                               f008m = 0 AND f008a = 0 AND
                               f009m = 0 AND f009a = 0 AND
                               f010m = 0 AND f010a = 0 AND
                               f011m = 0 AND f011a = 0 AND
                               f012m = 0 AND f012a = 0 AND
                               f013m = 0 AND f013a = 0 AND
                               f014m = 0 AND f014a = 0 AND
                               f015m = 0 AND f015a = 0 AND
                               f016m = 0 AND f016a = 0 AND
                               f017m = 0 AND f017a = 0 AND
                               f018m = 0 AND f018a = 0 AND
                               f019m = 0 AND f019a = 0 AND
                               f020m = 0 AND f020a = 0 AND
                               f021m = 0 AND f021a = 0 AND
                               f022m = 0 AND f022a = 0 AND
                               f023m = 0 AND f023a = 0 AND
                               f024m = 0 AND f024a = 0 AND
                               f025m = 0 AND f025a = 0 AND
                               f026m = 0 AND f026a = 0 AND
                               f027m = 0 AND f027a = 0 AND
                               f028m = 0 AND f028a = 0 AND
                               f029m = 0 AND f029a = 0 AND
                               f030m = 0 AND f030a = 0 AND
                               f031m = 0 AND f031a = 0 AND
                               f032m = 0 AND f032a = 0 AND
                               f033m = 0 AND f033a = 0 AND
                               f034m = 0 AND f034a = 0 AND
                               f035m = 0 AND f035a = 0 AND
                               f036m = 0 AND f036a = 0 AND
                               f037m = 0 AND f037a = 0 AND
                               f038m = 0 AND f038a = 0 AND
                               f039m = 0 AND f039a = 0 AND
                               f040m = 0 AND f040a = 0 AND
                               f041m = 0 AND f041a = 0 AND
                               f042m = 0 AND f042a = 0 AND
                               f043m = 0 AND f043a = 0 AND
                               f044m = 0 AND f044a = 0 AND
                               f045m = 0 AND f045a = 0 AND
                               f046m = 0 AND f046a = 0 AND
                               f047m = 0 AND f047a = 0 AND
                               f048m = 0 AND f048a = 0 AND
                               f049m = 0 AND f049a = 0 AND
                               f050m = 0 AND f050a = 0 AND
                               f099m = 0 AND f099a = 0 .
        ENDIF.
        "--[수불데이터 테이블삭제 및 삽입]------------------------------------------------------------------------------------
        DATA system_uuid TYPE REF TO if_system_uuid.
        DATA uuid        TYPE sysuuid_x16.
        DATA ls_create   TYPE STRUCTURE FOR CREATE ZR_ASSB_0000.
        DATA lt_create   TYPE TABLE FOR CREATE ZR_ASSB_0000.
        DATA ls_delete   TYPE STRUCTURE FOR DELETE ZR_ASSB_0000.
        DATA lt_delete   TYPE TABLE FOR DELETE ZR_ASSB_0000.

        DATA ls_created   TYPE STRUCTURE FOR CREATE ZR_ASSB_0001.
        DATA lt_created   TYPE TABLE FOR CREATE ZR_ASSB_0001.
        DATA ls_deleted   TYPE STRUCTURE FOR DELETE ZR_ASSB_0001.
        DATA lt_deleted   TYPE TABLE FOR DELETE ZR_ASSB_0001.

        DATA ls_createl   TYPE STRUCTURE FOR CREATE ZR_ASSB_0005.
        DATA lt_createl   TYPE TABLE FOR CREATE ZR_ASSB_0005.
        DATA ls_deletel   TYPE STRUCTURE FOR DELETE ZR_ASSB_0005.
        DATA lt_deletel   TYPE TABLE FOR DELETE ZR_ASSB_0005.

        DATA ls_createa   TYPE STRUCTURE FOR CREATE ZR_ASSB_0002.
        DATA lt_createa   TYPE TABLE FOR CREATE ZR_ASSB_0002.
        DATA ls_deletea   TYPE STRUCTURE FOR DELETE ZR_ASSB_0002.
        DATA lt_deletea   TYPE TABLE FOR DELETE ZR_ASSB_0002.

        IF lt_list[] IS NOT INITIAL.
*          CLEAR: lt_delete,
*                 ls_delete.
*
*          SELECT uuid FROM zassbt0000
*            WHERE matnr IN @r_matnr
*            AND bwkey IN @r_werks
*            AND bklas IN @r_bklas
*            AND spmon = @key-%param-spmons
*            INTO TABLE @DATA(lt_del) .

          DELETE FROM zassbt0000 WHERE matnr IN @r_matnr
                                   AND bwkey IN @r_werks
                                   AND bklas IN @r_bklas
                                   AND spmon = @key-%param-spmons.
        ENDIF.

        IF lt_listd[] IS NOT INITIAL.
*          CLEAR: lt_deleted,
*                 ls_deleted.
*
*          SELECT uuid FROM zassbt0001
*            WHERE matnr IN @r_matnr
*            AND bwkey IN @r_werks
*            AND bklas IN @r_bklas
*            AND spmon = @key-%param-spmons
*            INTO TABLE @DATA(lt_deld).

          DELETE FROM zassbt0001 WHERE matnr IN @r_matnr
                                   AND bwkey IN @r_werks
                                   AND bklas IN @r_bklas
                                   AND spmon = @key-%param-spmons.
        ENDIF.

        IF lv_ch2 = 'X'.
          IF lt_listl[] IS NOT INITIAL.
*            CLEAR: lt_deletel,
*                   ls_deletel.
*
*            SELECT uuid FROM zassbt0005
*              WHERE matnr IN @r_matnr
*              AND bwkey IN @r_werks
*              AND bklas IN @r_bklas
*              AND spmon = @key-%param-spmons
*              INTO TABLE @DATA(lt_dell).

            DELETE FROM zassbt0005 WHERE matnr IN @r_matnr
                                   AND bwkey IN @r_werks
                                   AND bklas IN @r_bklas
                                   AND spmon = @key-%param-spmons.

          ENDIF.
        ENDIF.

        IF lt_lista[] IS NOT INITIAL.
*          CLEAR: lt_deletea,
*                 ls_deletea.
*          SELECT uuid FROM zassbt0002
*              WHERE matnr IN @r_matnr
*              AND bwkey IN @r_werks
*              AND bklas IN @r_bklas
*              AND spmon = @key-%param-spmons
*              INTO TABLE @DATA(lt_dela).

          DELETE FROM zassbt0002 WHERE matnr IN @r_matnr
                                   AND bwkey IN @r_werks
                                   AND bklas IN @r_bklas
                                   AND spmon = @key-%param-spmons.
        ENDIF.

*        CLEAR r_sb000[].
*        LOOP AT lt_del INTO DATA(ls_del).
*          ls_delete-uuid = ls_del-uuid.
*
*          r_sb000 = VALUE #( BASE r_sb000
*                             ( sign = 'I' option = 'EQ' low = ls_del-uuid high = '' ) ).
*
*          APPEND ls_delete TO lt_delete.
*          CLEAR ls_delete.
*        ENDLOOP.
*
*        IF r_sb000[] IS NOT INITIAL.
*          DELETE FROM zassbt0000 WHERE uuid IN @r_sb000.
*        ENDIF.

*        CLEAR r_sb001[].
*        LOOP AT lt_deld INTO DATA(ls_deld).
*          ls_deleted-uuid = ls_deld-uuid.
*
*          r_sb001 = VALUE #( BASE r_sb001
*                             ( sign = 'I' option = 'EQ' low = ls_deld-uuid high = '' ) ).
*
*          APPEND ls_deleted TO lt_deleted.
*          CLEAR ls_deleted.
*        ENDLOOP.
*
*        IF r_sb001[] IS NOT INITIAL.
*          DELETE FROM zassbt0001 WHERE uuid IN @r_sb001.
*        ENDIF.

*        IF lv_ch2 = 'X'.
*          CLEAR r_sb005[].
*          LOOP AT lt_dell INTO DATA(ls_dell).
*            ls_deletel-uuid = ls_dell-uuid.
*            "ls_deletel-%cid_ref = 'subul-delete' && sy-tabix.
*            r_sb005 = VALUE #( BASE r_sb005
*                               ( sign = 'I' option = 'EQ' low = ls_dell-uuid high = '' ) ).
*
*            APPEND ls_deletel TO lt_deletel.
*            CLEAR ls_deletel.
*          ENDLOOP.
*
*          IF r_sb005[] IS NOT INITIAL.
*            DELETE FROM zassbt0005 WHERE uuid IN @r_sb005.
*          ENDIF.
*        ENDIF.

*        CLEAR r_sb002[].
*        LOOP AT lt_dela INTO DATA(ls_dela).
*          ls_deletea-uuid = ls_dela-uuid.
*
*          r_sb002 = VALUE #( BASE r_sb002
*                             ( sign = 'I' option = 'EQ' low = ls_dela-uuid high = '' ) ).
*          APPEND ls_deletea TO lt_deletea.
*          CLEAR ls_deletea.
*        ENDLOOP.
*
*        IF r_sb002[] IS NOT INITIAL.
*          DELETE FROM zassbt0002 WHERE uuid IN @r_sb002.
*        ENDIF.

        LOOP AT lt_list ASSIGNING <lf_list>.
          ls_create = CORRESPONDING #( <lf_list> ).

          CLEAR uuid.
          system_uuid = cl_uuid_factory=>create_system_uuid( ).
          TRY.
              uuid = system_uuid->create_uuid_x16( ).
              ls_create-uuid = uuid.
            CATCH cx_uuid_error.
              ls_create-uuid = ''.
          ENDTRY.

          ls_create-%cid = 'subul' && sy-tabix.

          APPEND ls_create TO lt_create.
          CLEAR ls_create.

        ENDLOOP.

        LOOP AT lt_listd ASSIGNING <lf_listd>.
          ls_created = CORRESPONDING #( <lf_listd> ).

*          CLEAR uuid.
*          system_uuid = cl_uuid_factory=>create_system_uuid( ).
*          TRY.
*              uuid = system_uuid->create_uuid_x16( ).
*              ls_created-uuid = uuid.
*            CATCH cx_uuid_error.
*          ENDTRY.

          ls_created-%cid = 'subuld' && sy-tabix.

          APPEND ls_created TO lt_created.
          CLEAR ls_created.

        ENDLOOP.

        IF lv_ch2 = 'X'.
          LOOP AT lt_listl ASSIGNING <lf_listl>.
            ls_createl = CORRESPONDING #( <lf_listl> ).

*          CLEAR uuid.
*          system_uuid = cl_uuid_factory=>create_system_uuid( ).
*          TRY.
*              uuid = system_uuid->create_uuid_x16( ).
*              ls_createl-uuid = uuid.
*            CATCH cx_uuid_error.
*          ENDTRY.

            ls_createl-%cid = 'subull' && sy-tabix.

            APPEND ls_createl TO lt_createl.
            CLEAR ls_createl.

          ENDLOOP.
        ENDIF.

        LOOP AT lt_lista ASSIGNING <lf_lista>.
          ls_createa = CORRESPONDING #( <lf_lista> ).

*          CLEAR uuid.
*          system_uuid = cl_uuid_factory=>create_system_uuid( ).
*          TRY.
*              uuid = system_uuid->create_uuid_x16( ).
*              ls_createa-uuid = uuid.
*            CATCH cx_uuid_error.
*          ENDTRY.

          ls_createa-%cid = 'subula' && sy-tabix.

          APPEND ls_createa TO lt_createa.
          CLEAR ls_createa.

        ENDLOOP.

*        MODIFY ENTITIES OF ZR_ASSB_0000 IN LOCAL MODE
*               ENTITY subul DELETE FROM lt_delete
*               " TODO: variable is assigned but never used (ABAP cleaner)
*               FAILED   DATA(lt_failed_delete)
*               " TODO: variable is assigned but never used (ABAP cleaner)
*               REPORTED DATA(lt_reported_delete).

        MODIFY ENTITIES OF ZR_ASSB_0000 IN LOCAL MODE
               ENTITY subul CREATE SET FIELDS WITH lt_create
               " TODO: variable is assigned but never used (ABAP cleaner)
               MAPPED   DATA(ls_mapped_modify)
               " TODO: variable is assigned but never used (ABAP cleaner)
               FAILED   DATA(lt_failed_modify)
               " TODO: variable is assigned but never used (ABAP cleaner)
               REPORTED DATA(lt_reported_modify).

*        MODIFY ENTITIES OF ZR_ASSB_0001
*               ENTITY subuld DELETE FROM lt_deleted
*               " TODO: variable is assigned but never used (ABAP cleaner)
*               FAILED   DATA(lt_failed_deleted)
*               " TODO: variable is assigned but never used (ABAP cleaner)
*               REPORTED DATA(lt_reported_deleted).

        MODIFY ENTITIES OF ZR_ASSB_0001
               ENTITY subuld CREATE SET FIELDS WITH lt_created
               " TODO: variable is assigned but never used (ABAP cleaner)
               MAPPED   DATA(ls_mapped_modifyd)
               " TODO: variable is assigned but never used (ABAP cleaner)
               FAILED   DATA(lt_failed_modifyd)
               " TODO: variable is assigned but never used (ABAP cleaner)
               REPORTED DATA(lt_reported_modifyd).

*        MODIFY ENTITIES OF ZR_ASSB_0005
*               ENTITY subull DELETE FROM CORRESPONDING #( lt_deletel )
*               " TODO: variable is assigned but never used (ABAP cleaner)
*               FAILED   DATA(lt_failed_deletel)
*               " TODO: variable is assigned but never used (ABAP cleaner)
*               REPORTED DATA(lt_reported_deletel).
*
        IF lv_ch2 = 'X'.
          MODIFY ENTITIES OF ZR_ASSB_0005
                 ENTITY subull CREATE SET FIELDS WITH lt_createl
                 " TODO: variable is assigned but never used (ABAP cleaner)
                 MAPPED   DATA(ls_mapped_modifyl)
                 " TODO: variable is assigned but never used (ABAP cleaner)
                 FAILED   DATA(lt_failed_modifyl)
                 " TODO: variable is assigned but never used (ABAP cleaner)
                 REPORTED DATA(lt_reported_modifyl).
        ENDIF.

*        MODIFY ENTITIES OF ZR_ASSB_0002
*               ENTITY subula DELETE FROM lt_deletea
*               " TODO: variable is assigned but never used (ABAP cleaner)
*               FAILED   DATA(lt_failed_deletea)
*               " TODO: variable is assigned but never used (ABAP cleaner)
*               REPORTED DATA(lt_reported_deletea).

        MODIFY ENTITIES OF ZR_ASSB_0002
               ENTITY subula CREATE SET FIELDS WITH lt_createa
               " TODO: variable is assigned but never used (ABAP cleaner)
               MAPPED   DATA(ls_mapped_modifya)
               " TODO: variable is assigned but never used (ABAP cleaner)
               FAILED   DATA(lt_failed_modifya)
               " TODO: variable is assigned but never used (ABAP cleaner)
               REPORTED DATA(lt_reported_modifya).

    ENDMETHOD.
ENDCLASS.
