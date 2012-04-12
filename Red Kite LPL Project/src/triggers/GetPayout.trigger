trigger GetPayout on Contract(before update, before insert) {

 Map<Id, Decimal> UserMap = new Map<Id, Decimal>();
 Map<Id, String> TaxIDMap = new Map<Id, String>();

 Restricted_User_Info__c[] R = [select User__c, Broker_Dealer_Payout__c, Tax_ID__c from Restricted_User_Info__c];
 
  if (R.size() > 0) {
    for (Integer i = 0; i < R.size(); i++)
    {
      UserMap.put(R[i].User__c, R[i].Broker_Dealer_Payout__c);
      TaxIDMap.put(R[i].User__c, R[i].Tax_ID__c);
    }

    for(Contract c : Trigger.new) {
      if (UserMap.containsKey(c.OwnerId)) {
        c.BD_Payout__c = UserMap.get(c.OwnerId);
        c.Tax_ID__c = TaxIDMap.get(c.OwnerId); }
    }
  }
}