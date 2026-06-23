@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'VH for Difficulty'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@ObjectModel.resultSet.sizeCategory: #XS
define view entity ZC_KLV_DIFFICULTY_VH
as select from dd07t
{
 @EndUserText.label: 'Difficulty'
  key dd07t.domvalue_l as DomainValue, 
  @EndUserText.label: 'Difficulty Text'    
      dd07t.ddtext     as DomainText
}
where dd07t.as4vers = '0000'
  and dd07t.ddlanguage = $session.system_language
  and dd07t.domname = 'ZKLV_DIFFICULTY'
  and dd07t.as4local = 'A'
