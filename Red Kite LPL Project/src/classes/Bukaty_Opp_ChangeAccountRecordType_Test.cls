@isTest
private class Bukaty_Opp_ChangeAccountRecordType_Test {

    static testMethod void Bukaty_Opp_ChangeAccountRecordType_Test() {

	RecordType rtNew = [select Id from RecordType where DeveloperName = 'PlanSponsorClientBukatyCompanies' and SobjectType = 'Account' and IsActive = true limit 1];
	RecordType rtOld = [select Id from RecordType where DeveloperName = 'Prospect_Bukaty_Companies' and SobjectType = 'Account' and IsActive = true limit 1];
	RecordType rtOpp = [select Id from RecordType where DeveloperName = 'OpportunityBukatyCompanies' and SobjectType = 'Opportunity' and IsActive = true limit 1];

 	Account a = new Account(Name = 'Drew Test', RecordTypeId = rtOld.Id);
 		insert a;

	Opportunity  o = new Opportunity(Name = 'Drew Test', AccountId = a.Id, CloseDate = Date.today(), StageName = 'Prospecting');
		insert o;
		
	Account reta1 = [select RecordTypeId from Account where Id = :a.Id];
	system.assertEquals(reta1.RecordTypeId, rtOld.Id);
	
	o.StageName = 'Closed Lost';
		update o;

	Account reta2 = [select RecordTypeId from Account where Id = :a.Id];
	system.assertEquals(reta2.RecordTypeId, rtOld.Id);

	o.StageName = 'Closed Won';
		update o;

	Account reta3 = [select RecordTypeId from Account where Id = :a.Id];
	system.assertEquals(reta3.RecordTypeId, rtOld.Id);
	
	o.StageName = 'Prospecting';
	o.RecordTypeId = rtOpp.Id;
		update o;

	Account reta4 = [select RecordTypeId from Account where Id = :a.Id];
	system.assertEquals(reta4.RecordTypeId, rtOld.Id);

	o.StageName = 'Closed Won';
		update o;

	Account reta5 = [select RecordTypeId from Account where Id = :a.Id];
	system.assertEquals(reta5.RecordTypeId, rtNew.Id);
    }
}