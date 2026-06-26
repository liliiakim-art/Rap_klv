@AccessControl.authorizationCheck: #CHECK 
@EndUserText.label: 'Projection Trip'
@Metadata.allowExtensions: true
@Search.searchable: true
define root view entity ZC_KLV_TRIP
  provider contract transactional_query
  as projection on ZT_KLV_TRIP
{
  key Tripuuid,
      Tripid,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @Search.ranking: #HIGH
      @EndUserText.label: 'Trip name'
      TripName,
      @EndUserText.label: 'Date from'
      DateFr,
      @EndUserText.label: 'Date till'
      DateTo,
      @EndUserText.label: 'Seats available'
      SeatAvail,
      @EndUserText.label: 'Difficulty'
      @ObjectModel.text.element: ['Difficulty']
      @Consumption.valueHelpDefinition:  [{ entity: { name: 'ZC_KLV_DIFFICULTY_VH', element: 'DomainValue' } }] 
      Difficulty,
      @EndUserText.label: 'From location'
      LocFr,
      @EndUserText.label: 'Destination'
      LotTo,
      @EndUserText.label: 'One day trip'
      OnedayTrip,
      @EndUserText.label: 'Price'
      @Semantics.amount.currencyCode: 'CurrencyCode'
      Price,
//      @Semantics.imageUrl: true
//      ImageUrl,
//      ImageType,
//      @Semantics.largeObject: { mimeType: 'MimeType',
//                                fileName: 'FileName' }
      @EndUserText.label: 'Image File'
      ImageFile,
      @EndUserText.label: 'Mime Type'
      MimeType,
      @EndUserText.label: 'File name'
      FileName,
      Currencycode,
      LastChangedAt,
      
      /* Associations */
      _Book : redirected to composition child ZC_KLV_BOOKING,
      _Days : redirected to composition child ZC_KLV_TRIP_DAYS
}
