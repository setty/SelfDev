trigger GetTickerSymbol on Investment_Option__c (before insert) {

  try
  {
    for (Investment_Option__c i: Trigger.new) {
      if (i.Product__c != null) {
        Product2 p = [select Ticker_Symbol__c from Product2 where Id = :i.Product__c]; 
        i.Investment_Option_Ticker_Symbol__c = p.Ticker_Symbol__c;
      }
    }
  }
  catch (System.DmlException e) {
    System.debug(e.getDmlMessage(0));
  }
}