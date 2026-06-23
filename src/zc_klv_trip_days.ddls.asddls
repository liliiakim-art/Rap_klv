@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection Days'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZC_KLV_TRIP_DAYS
  as projection on ZT_KLV_TRIP_DAYS
{
  key Dayuuid,
  key Tripuuid,
      Tripid,
      Dayid,
      DayDesc,
      DateDay,
      Places,
      LastChangedAt,
      LocalLastChangedAt,
      /* Associations */
      _Trip : redirected to parent ZC_KLV_TRIP
}
