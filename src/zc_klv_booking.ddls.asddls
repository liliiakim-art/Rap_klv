@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection Booking'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZC_KLV_BOOKING
  as projection on ZT_KLV_BOOKING
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
       _Trip : redirected to parent ZC_KLV_TRIP
}
