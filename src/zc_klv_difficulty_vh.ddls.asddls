@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'VH for Difficulty'
@Metadata.ignorePropagatedAnnotations: true
@Search.searchable: true // Enable search capability for the filter criteria match

define view entity ZC_KLV_DIFFICULTY_VH
  as select from dd07t
{
      @Search.defaultSearchElement: true  // Allows the framework to find the text when evaluating search filters
      @ObjectModel.text.element: ['DomainText'] // Map the key directly to its description text
  key dd07t.domvalue_l as DomainValue,


      @Search.fuzzinessThreshold: 0.8
      dd07t.ddtext     as DomainText
}
where
      dd07t.as4vers    = '0000'
  and dd07t.ddlanguage = $session.system_language
  and dd07t.domname    = 'ZKLV_DIFFICULTY'
  and dd07t.as4local   = 'A'
