@AccessControl.authorizationCheck: #NOT_REQUIRED
@AbapCatalog.sqlViewName: 'ZI_KLV_BOOK'
@Metadata.ignorePropagatedAnnotations: true

define view ZI_KLV_BOOKING
  as select from zklv_booking
  association to parent ZI_KLV_TRIP as _Trip on $projection.Tripuuid = _Trip.Tripuuid
{
  key book_uuid       as Bookuuid,
  key trip_uuid       as Tripuuid,
      bookid          as Bookid,
      tripid          as Tripid,
      person_cnt      as PersonCnt,
      customer_name   as CustomerName,
      phone_number    as PhoneNumber,
      status          as Status,
      created_by      as CreatedBy,
      created_at      as CreatedAt,
      last_changed_at as LastChangedAt,

      _Trip
}
