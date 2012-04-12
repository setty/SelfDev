trigger updateRelationshipGroup on Contract (before insert, before update) {
    List<Id> AccountIdList = new List<Id>();
    Map<Id, Id> rgMap = new Map<Id, Id>();
    for(Contract c : Trigger.new){
        AccountIdList.add(c.AccountId);
    }
    for (Account a : [SELECT id, name, (SELECT id, households__Household__c FROM households__Tests__r limit 1) FROM account WHERE id IN :AccountIdList]) {
          try{rgMap.put(a.id, (a.households__Tests__r).households__Household__c);}catch(Exception e){}
    }
    for(Contract c : Trigger.new){
        if(rgMap.containsKey(c.AccountId)){
            c.Relationship_Group__c = rgMap.get(c.AccountId);
        }
    }
}