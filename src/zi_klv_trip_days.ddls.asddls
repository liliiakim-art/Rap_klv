@AbapCatalog.sqlViewName: 'ZI_KLV_TRIP_D'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface for days'
@Metadata.ignorePropagatedAnnotations: true
define view ZI_KLV_TRIP_DAYS
  as select from zklv_trip_days
  association to parent ZI_KLV_TRIP as _Trip on $projection.Tripuuid = _Trip.Tripuuid
{
  key day_uuid              as Dayuuid,
  key trip_uuid             as Tripuuid,
      tripid                as Tripid,
      dayid                 as Dayid,
      day_desc              as DayDesc,
      date_day              as DateDay,
      places                as Places,
      last_changed_at       as LastChangedAt,
      local_last_changed_at as LocalLastChangedAt,
      _Trip
}
