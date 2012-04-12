public with sharing class nestedqueryexample 
{
	public  List<Contact> contacts{get;set;}
	 public List<Account> getaccsandtmember()
	  {
	  	Set<Id> setAccountId = new Set<Id>();
	     List<Account> accounts = [Select a.Website, a.UpsellOpportunity__c, a.Type, a.TickerSymbol, a.SystemModstamp, a.Site, a.Sic, a.ShippingStreet, a.ShippingState, a.ShippingPostalCode, a.ShippingCountry, a.ShippingCity, a.SLA__c, a.SLASerialNumber__c, a.SLAExpirationDate__c, a.Rating, a.Phone, a.ParentId, a.Ownership, a.OwnerId, a.NumberofLocations__c, a.NumberOfEmployees, a.Name, a.MasterRecordId, a.LastModifiedDate, a.LastModifiedById, a.LastActivityDate, a.IsDeleted, a.Industry, a.Id, a.Fax, a.Description, a.CustomerPriority__c, a.CreatedDate, a.CreatedById, a.BillingStreet, a.BillingState, a.BillingPostalCode, a.BillingCountry, a.BillingCity, a.AnnualRevenue, a.Active__c, a.AccountNumber From Account a];
	     for(Account objAcc : accounts)
	     {
	     	setAccountId.add(objAcc.Id);
	     }
	     Error.DebugLog('=======Limit of Query ==== '+Limits.getLimitQueries());
	     Error.DebugLog('=======Limit of Query ==== '+Limits.getAggregateQueries());
	     Error.DebugLog('=======Limit of Query ==== '+Limits.getCallouts());
	     Error.DebugLog('=======Limit of Query ==== '+Limits.getChildRelationshipsDescribes());
	     Error.DebugLog('=======Limit of Query ==== '+Limits.getCpuTime());
	     Error.DebugLog('=======Limit of Query ==== '+Limits.getDmlRows());
	     Error.DebugLog('=======Limit of Query ==== '+Limits.getDmlStatements());
	     Error.DebugLog('=======Limit of Query ==== '+Limits.getEmailInvocations());
	     Error.DebugLog('=======Limit of Query ==== '+Limits.getFieldsDescribes());
	     Error.DebugLog('=======Limit of Query ==== '+Limits.getFindSimilarCalls());
	     contacts = [Select c.LastName, c.FirstName, c.AssistantName, c.AccountId From Contact c Where c.AccountId =: setAccountId];
	     return accounts;
	  }
}