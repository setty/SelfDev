public class RKCB_AccountCBController {
	
	//Constructor
	public RKCB_AccountCBController(ApexPages.standardController stdController){
		currAccount = (Account)stdController.getRecord();
	}
	
	//Properties
	public Account currAccount{get; set;}
	public String currPermalink{get; set;}
	
	public void init(){
		currPermalink = (currAccount.Crunchbase_Permalink__c.trim() <> NULL && currAccount.Crunchbase_Permalink__c.trim() <> '') ? 
				currAccount.Crunchbase_Permalink__c.trim() : ''; 
	}

}//End