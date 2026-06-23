@AccessControl.authorizationCheck: #CHECK 
@EndUserText.label: 'Transactional for Trips'
@Metadata.ignorePropagatedAnnotations: true
@Search.searchable: true

define root view entity ZT_KLV_TRIP
  as select from ZI_KLV_TRIP
  composition [0..*] of ZT_KLV_TRIP_DAYS as _Days
  composition [0..*] of ZT_KLV_BOOKING   as _Book
{
  key Tripuuid,
      Tripid,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @Search.ranking: #HIGH
      TripName,
      DateFr,
      DateTo,
      SeatAvail,
      Difficulty,
      LocFr,
      LotTo,
      OnedayTrip,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      Price,
      //      @Semantics.imageUrl: true
      //      ImageUrl,
      //      ImageType,
      @Semantics.largeObject: { mimeType: 'MimeType', //case-sensitive
                               fileName: 'FileName', //case-sensitive
                    acceptableMimeTypes: ['image/png', 'image/jpeg'],
           contentDispositionPreference: #INLINE }
      ImageFile,
      @Semantics.mimeType: true
      MimeType,
      FileName,
      Currencycode,
      LastChangedAt,
      /* Associations */
      _Book,
      _Days
}
