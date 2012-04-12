trigger Bukaty_Opportunity_ChangeAccountRecordType on Opportunity (before update) {
	
	RecordType rt = [select Id from RecordType where DeveloperName = 'PlanSponsorClientBukatyCompanies' and SobjectType = 'Account' and IsActive = true limit 1];
	RecordType rtOpp = [select Id from RecordType where DeveloperName = 'OpportunityBukatyCompanies' and SobjectType = 'Opportunity' and IsActive = true limit 1];
	List<Account> acct = new List<Account>();

	for(Opportunity o: Trigger.New) {
	
system.debug('DAF: o.RecordTypeId=' + o.RecordTypeId + '   rtOpp.Id=' + rtOpp.Id + '   rt.ID=' + rt.Id + '  o.IsClosed=' + o.IsClosed + '   o.IsWon=' + o.IsWon + '   Trigger.oldMap(IsClosed)=' + !Trigger.oldMap.get(o.Id).IsClosed + '   Trigger.oldMap(IsWon)=' + !Trigger.oldMap.get(o.Id).IsWon);

		if ((o.RecordTypeId == rtOpp.Id) && (rt.Id != null) && (rtOpp.Id != null) && (o.IsClosed) && (o.IsWon) && (!(Trigger.oldMap.get(o.Id).IsClosed) || !(Trigger.oldMap.get(o.Id).IsWon))) {
			acct.add(new Account(Id = o.AccountId, RecordTypeId = rt.Id));
		}
	}
	if (acct.size() > 0) {
		update acct;
	}

}