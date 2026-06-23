@EndUserText.label: 'Abstract entity for booking'
@Metadata.allowExtensions: true
define abstract entity ZA_KLV_BOOKING 
{
    @EndUserText.label    : 'Persons'
    PersonCnt: abap.int4;
    @EndUserText.label    : 'Customer Name'
    CustomerName: abap.char(100);
    @EndUserText.label    : 'Phone Number'
    PhoneNumber: abap.char(20);
}
