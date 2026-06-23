@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Transactional for Booking'
@Metadata.ignorePropagatedAnnotations: true

define view entity ZT_KLV_BOOKING
  as select from ZI_KLV_BOOKING
  association to parent ZT_KLV_TRIP as _Trip on $projection.Tripuuid = _Trip.Tripuuid
{
  key  Tripuuid,
  key  Bookuuid,
       Bookid,
       Tripid,
       PersonCnt,
       CustomerName,
       PhoneNumber,
       Status,
       CreatedBy,
       CreatedAt,
       LastChangedAt,
       /* Associations */
       _Trip
}
