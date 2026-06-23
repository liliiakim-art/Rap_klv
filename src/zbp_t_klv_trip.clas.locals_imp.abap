CLASS lhc_Trip DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Trip RESULT result.
*    METHODS get_instance_features FOR INSTANCE FEATURES
*      IMPORTING keys REQUEST requested_features FOR Trip RESULT result.
    METHODS book FOR MODIFY
      IMPORTING keys FOR ACTION Trip~book RESULT result.
    METHODS get_global_features FOR GLOBAL FEATURES
      IMPORTING REQUEST requested_features FOR Trip RESULT result.
    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Trip RESULT result.

ENDCLASS.

CLASS lhc_Trip IMPLEMENTATION.

  METHOD get_instance_authorizations.

  ENDMETHOD.

  METHOD get_global_features.
*    " Check if user has agent role for create/update/delete operations
*    AUTHORITY-CHECK OBJECT 'ZKLV_ROLE'
*      ID 'ZKLV_ROLE' FIELD 'A' "
*      ID 'ACTVT'     FIELD '01'.
*
*    IF sy-subrc <> 0.
*      result-%create = if_abap_behv=>auth-unauthorized.
*      result-%update = if_abap_behv=>auth-unauthorized.
*      result-%delete = if_abap_behv=>auth-unauthorized.
*    ELSE.
*      result-%create = if_abap_behv=>auth-allowed.
*      result-%update = if_abap_behv=>auth-allowed.
*      result-%delete = if_abap_behv=>auth-allowed.
*    ENDIF.

  ENDMETHOD.



  " Controls UI features (actions availability) for each product instance.
*  METHOD get_instance_features.
*
*  ENDMETHOD.

  METHOD book.
    DATA: lt_create_request TYPE TABLE FOR CREATE zt_klv_trip\_book.

    LOOP AT keys ASSIGNING FIELD-SYMBOL(<ls_key>).
      " Checking Quantity
      " Quantity in the request <= Quantity in the product
      READ ENTITIES OF zt_klv_trip IN LOCAL MODE
            ENTITY trip
            FIELDS ( Tripid Tripuuid )
            WITH VALUE #( ( %tky = <ls_key>-%tky ) )
            RESULT DATA(lt_trip_check).

*      READ TABLE lt_product_check INTO DATA(ls_product_check) INDEX 1.
*
*      " Ensure requested quantity does not exceed available stock
*      IF <ls_key>-%param-reqquantity > ls_product_check-quantity.
*
*        APPEND VALUE #( %tky = <ls_key>-%tky ) TO failed-product.
*
*        APPEND VALUE #( %tky = <ls_key>-%tky
*                        %msg = new_message( id       = 'Z_RAP_KNOWLEDGE'
*                                            number   = '005'
*                                            v1       = ls_product_check-quantity
*                                            severity = if_abap_behv_message=>severity-error ) ) TO reported-product.
*        CONTINUE.
*      ENDIF.

      " Prepare request creation payload
      APPEND INITIAL LINE TO lt_create_request ASSIGNING FIELD-SYMBOL(<ls_req_line>).

      <ls_req_line>-%tky      = <ls_key>-%tky.
      <ls_req_line>-%is_draft = <ls_key>-%is_draft.

      APPEND INITIAL LINE TO <ls_req_line>-%target ASSIGNING FIELD-SYMBOL(<ls_target>).

      " Normalize phone number (keep digits only)
      DATA(lv_phone) = <ls_key>-%param-phonenumber.
      REPLACE ALL OCCURRENCES OF REGEX '[^0-9]' IN lv_phone WITH ''.

      <ls_target>-%cid                  = |REQ{ sy-tabix }|.
      <ls_target>-PersonCnt = <ls_key>-%param-PersonCnt.
      <ls_target>-customername          = <ls_key>-%param-customername.
      <ls_target>-phonenumber           = lv_phone.
      <ls_target>-status                = 'C'.

      <ls_target>-%control-PersonCnt             = if_abap_behv=>mk-on.
      <ls_target>-%control-customername          = if_abap_behv=>mk-on.
      <ls_target>-%control-phonenumber           = if_abap_behv=>mk-on.
      <ls_target>-%control-status                = if_abap_behv=>mk-on.
    ENDLOOP.

    " Create request via composition
    MODIFY ENTITIES OF zt_klv_trip IN LOCAL MODE
        ENTITY trip
          CREATE BY \_book
          FROM lt_create_request
          MAPPED   DATA(lt_mapped)
          FAILED   DATA(lt_failed)
          REPORTED DATA(lt_reported).

    IF lt_failed IS NOT INITIAL.
      APPEND LINES OF lt_failed-trip        TO failed-trip.
      APPEND LINES OF lt_reported-trip      TO reported-trip.
      APPEND LINES OF lt_reported-book      TO reported-book.
      RETURN.
    ENDIF.

    " Update product quantity after successful request creation
    " Changing Quantity
    READ ENTITIES OF zt_klv_trip  IN LOCAL MODE
      ENTITY trip
      FIELDS ( SeatAvail )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_trip).

    LOOP AT lt_trip INTO DATA(ls_trip).

      READ TABLE keys ASSIGNING FIELD-SYMBOL(<ls_key_trip>)
        WITH KEY %tky = ls_trip-%tky.

      DATA(lv_new_qty) = ls_trip-SeatAvail - <ls_key_trip>-%param-PersonCnt.

      MODIFY ENTITIES OF zt_klv_trip IN LOCAL MODE
          ENTITY trip
          UPDATE FROM VALUE #( ( Tripuuid           = ls_trip-Tripuuid
                                 Tripid             = ls_trip-Tripid
                                 SeatAvail          = lv_new_qty
                                 %control-SeatAvail = if_abap_behv=>mk-on ) ).

    ENDLOOP.

    " Return updated product data
    READ ENTITIES OF zt_klv_trip IN LOCAL MODE
      ENTITY trip
        ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lt_trip_res).

    result = VALUE #( FOR ls_trip_res IN lt_trip_res ( %tky   = ls_trip_res-%tky
                                                       %param = ls_trip_res ) ).
  ENDMETHOD.

  METHOD get_global_authorizations.
    " Check if user has Seller role for create operation
    AUTHORITY-CHECK OBJECT 'ZKLV_ROLE'
      ID 'ZKLV_ROLE' FIELD 'A' "
      ID 'ACTVT'     FIELD '01'.

    IF sy-subrc <> 0.
      result-%create = if_abap_behv=>auth-unauthorized.
    ELSE.
      result-%create = if_abap_behv=>auth-allowed.
    ENDIF.

    result-%update = if_abap_behv=>auth-allowed.
    result-%delete = if_abap_behv=>auth-allowed.
  ENDMETHOD.

ENDCLASS.
