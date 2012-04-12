public with sharing class AdvancedDev_DataTypes 
{
	public Boolean bBoolean {get;set;}
	public Decimal decDecimal{get;set;}
	public Double dbDouble{get;set;}
	
	private List<Account> lstAccount {get;set;}
	private List<Contact> lstContact {get;set;}
	private List<Lead> lstLead {get;set;}
	private List<List<Set<String>>> lstMasterCollection{get;set;}
	public enum Season {WINTER, SPRING, SUMMER, FALL}
	
	public AdvancedDev_DataTypes()
	{
		lstAccount = new List<Account>();
		lstContact = new List<Contact>();
		lstLead    = new List<Lead>();
		lstMasterCollection = new List<List<Set<String>>>();
		
		decDecimal = 1;
		dbDouble = 1;
		Error.DebugLog('Default value of Boolean ==>'+bBoolean);
		Error.DebugLog('Default value of Decimal ==>'+decDecimal.setScale(6));
		Error.DebugLog('Default value of Double ==>'+dbDouble);
		Error.DebugLog('Cutom Label ==>'+System.label.lblUserAdminName);
		GetGenePoint();
		Error.DebugLog('lstAccount ===>'+lstAccount);
		Error.DebugLog('lstContact ===>'+lstContact);
		Error.DebugLog('lstLead ===>'+lstLead);
		
		// CollectionFrameWork
		CollectionFramework();
		
		// Enum practice
		EnumPractice();	
		
		//Soql for Loop
		SOQLforLoop();	
		
		// Query All and For Update Keyword Function 
		QueryAll_and_ForUpdate();
		
		// Function calling Iterator Class 
		CallIteratorMethod();
		
		
	}
	
	private void CallIteratorMethod()
	{
		IterratorUsingClass objIterratorUsingClass = new IterratorUsingClass();
		objIterratorUsingClass.Iterator();
	}
	
	
	private void QueryAll_and_ForUpdate()
	{
		try
		{
			List<Contact> lstContact = [select name,id from Contact all rows];
			Error.DebugLog('lstContact =====>'+lstContact);
			Account [] accts = [select id from Account limit 2 for update];
		//	Database.update(accts);
		}
		catch(Exception ex)
		{
			
		}
	}
	
	private void SOQLforLoop()
	{
		Integer jCount = 0;
		Integer iCount = 0;
		for(Account objAcc : [select name,id from Account]){
			iCount++;}
		Error.DebugLog('iCount==>'+iCount);
		
		for(List<Account> lstAccount : [select name,id from Account]){
			jCount ++;}
		Error.DebugLog('jCount==>'+jCount);
		
		//Count can not be used in Query and QueryMore
		// Count always returns the number
		Integer Count = [select count() from Account];
		Error.DebugLog('Count ==>'+Count);
	}
	
	// SOSL Query Example
	private void GetGenePoint()
	{
		List<List<sObject>> lstSObject = [find 'GenePoint' in Name fields returning Contact(id,Name,FirstName,LastName),
											Lead(id,Name,FirstName,LastName),Account(id,Name)];
		for(Integer iCount = 0; iCount < lstSObject.size() ;iCount++)
		{
			for(sObject objSobject :lstSObject[iCount])
			{
				Error.DebugLog('objSobject ===>'+objSobject.getSObjectType());
				if(String.valueOf(objSobject.getSObjectType()) == 'Account')
				{lstAccount = lstSObject[iCount];}
				else if(String.valueOf(objSobject.getSObjectType()) == 'Contact')
				{lstContact = lstSObject[iCount];}
				else if(String.valueOf(objSobject.getSObjectType()) == 'Lead')
				{ lstLead = lstSObject[iCount];}
			}
		}
	}
	
	public Pagereference AccessingsObjectFieldsThroughRelationships()
	{
		Account objAccount =  new Account(Name ='Niket');
		insert objAccount;
		
		Error.DebugLog('Account inserted With name ==>'+objAccount.Name);
		
		Contact objContact = new Contact(LastName ='Test 1',AccountId = objAccount.Id);
		insert objContact;
		
		Error.DebugLog('Contact Inserted with LastName =>'+objContact.LastName+':: Contact Id ::'+objContact.Id);
		
		objContact = [Select LastName,account.Name from Contact where id =: objContact.Id];
		
		objContact.LastName ='Test';
		objContact.account.name ='Force.com';
		
		update objContact;			 // This only update the contact not account.
		update objContact.account; 	 //This update account as well.
		Error.DebugLog('Account Name Updated ==> '+objContact.account);
		return null;
	}
	
	public void CollectionFramework()
	{
		Set<String> SetStringClr = new Set<String>{'Black','White','Pink'};
		Set<String> SetStringfriends = new Set<String>{'Ganu','Bapu','raju'};
		List<set<String>> lstSetCollectionClr = new List<Set<String>>();
		List<set<String>> lstSetCollectionFriends = new List<Set<String>>();
		
		lstSetCollectionClr.add(SetStringClr);
		lstSetCollectionFriends.add(SetStringfriends);
		
		lstMasterCollection.add(lstSetCollectionClr);
		lstMasterCollection.add(lstSetCollectionFriends);
		lstMasterCollection.add(null); 						// You can add null value in to the list
		
		Error.DebugLog('lstMasterCollection=======>'+lstMasterCollection);
		
		// Set Collection
		Set<String> SetFirst = new Set<String>{'a','b + c'};
		
		// Automaticaly all the values are allocated by adding set value as passing value t the set constructor
		Set<String> SetSec   = new Set<String>(SetFirst);
		Error.DebugLog('Set Collection ========>'+SetSec);
		
		Map<ID, Contact> mapOfContact = new Map<ID, Contact>([select id, lastname from contact]);
		Error.DebugLog('mapOfContact ==>'+mapOfContact);
	}
	
	public void EnumPractice()
	{
		Season eSeason = Season.WINTER;
		Error.DebugLog('eSeason ===>'+eSeason);
		
		// Enum Methods
		
		Integer i = Season.WINTER.ordinal();
		Error.DebugLog('Enum Ordinal give Interger value as a position ==>'+i);
		String s = Season.WINTER.name();
		Error.DebugLog('Enum name give String name as  ==>'+s);
		List<Season> values = Season.values();
		Error.DebugLog('Enum values give String name as  ==>'+values);
	}
}