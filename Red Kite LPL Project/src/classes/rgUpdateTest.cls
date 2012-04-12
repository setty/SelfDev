@isTest
private class rgUpdateTest {
    static testMethod void rgUpdateTestMethod(){
        households__HouseholdMember__c rgm = [SELECT id,households__Account__c,households__Household__c FROM households__HouseholdMember__c LIMIT 1];
        Contract oldContract = [SELECT id, RecordTypeId FROM CONTRACT LIMIT 1];
        Contract newContract = new Contract(Name = 'test', RecordTypeId = oldContract.RecordTypeId, AccountId = rgm.households__Account__c);
        insert newContract;
    }
}