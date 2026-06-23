@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Transactional for Days'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZT_KLV_TRIP_DAYS
  as select from ZI_KLV_TRIP_DAYS
  association to parent ZT_KLV_TRIP as _Trip on $projection.Tripuuid = _Trip.Tripuuid
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
      _Trip
}
