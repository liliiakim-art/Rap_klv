@AccessControl.authorizationCheck: #CHECK 
@EndUserText.label: 'Interface for Trips'
@Metadata.ignorePropagatedAnnotations: true
@Search.searchable: true

define root view entity ZI_KLV_TRIP
  as select from zklv_trip
  composition [0..*] of ZI_KLV_TRIP_DAYS as _Days
  composition [0..*] of ZI_KLV_BOOKING   as _Book

{
  key trip_uuid       as Tripuuid,
      tripid          as Tripid,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @Search.ranking: #HIGH
      trip_name       as TripName,
      date_fr         as DateFr,
      date_to         as DateTo,
      seat_avail      as SeatAvail,
      difficulty      as Difficulty,
      loc_fr          as LocFr,
      lot_to          as LotTo,
      oneday_trip     as OnedayTrip,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      price           as Price,
      //      @Semantics.imageUrl: true
      //      image_url       as ImageUrl,
      //      image_type      as ImageType,
//      @Semantics.largeObject: { mimeType: 'MimeType', //case-sensitive
//                                fileName: 'FileName', //case-sensitive
//                     acceptableMimeTypes: ['image/png', 'image/jpeg'],
//            contentDispositionPreference: #ATTACHMENT }
      image_file      as ImageFile,
//      @Semantics.mimeType: true
      mime_type       as MimeType,
      file_name       as FileName,
      currencycode    as Currencycode,
      last_changed_at as LastChangedAt,

      _Days,
      _Book
}
