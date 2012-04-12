/* 
*   This class extends the standard Account controller to fetch values for Name, Id and Crunchbase_Permalink__c 
*	and provides them to the CrunchbaseAccountDetailPage to make API calls to Crunchbase.
* 
*   Revision History:
*
*   Version         Author          Date            Description
*   1.0             Eternus			05/09/2011      Initial Draft
*    
*/

global class CrunchbaseAccountDetailCtl {
	
	//Constructor
	global CrunchbaseAccountDetailCtl(ApexPages.standardController stdController){
		cbAccount = (Account)stdController.getRecord();
		system.debug('cbAccount ==>'+cbAccount);
	}
	
	//Properties
	public String cbAccountName{get; set;}	/* Account Name */
	public String cbAccountId{get; set;}	/* Account Id   */
	public String cbPermalink{get; set;}	/* Permalink    */
	public Account cbAccount{get; set;}
	
	//Methods
	/* Intializes the Id, name and permalink values for the Account record, on completion of page load. */
	public void init(){
		cbAccountName = cbAccount.Name;
		cbAccountId = cbAccount.Id;
		cbPermalink = (cbAccount.Crunchbase_Permalink__c != NULL && cbAccount.Crunchbase_Permalink__c.trim() != '') ? 
				cbAccount.Crunchbase_Permalink__c.trim() : ''; 
	}

	/* Updates the selected Company's permalink value using Javascript Remoting, on the Account record whose Id is provided. */
	@RemoteAction
    global static void updateAccount(String accountId, String permalink){
	    update new Account(Id = accountId, Crunchbase_Permalink__c = permalink);
    }
    
    //Test Methods
	public static testMethod void testThisClass(){
		Account testCompany  = new Account(name='CompanyName & Sons, LLC');
		insert testCompany;

		ApexPages.StandardController testAcctController = new ApexPages.StandardController(testCompany);
		CrunchbaseAccountDetailCtl testController = new CrunchbaseAccountDetailCtl(testAcctController);

		testController.init();
		String getPermalink = testController.cbPermalink;
		Account getAcct = testController.cbAccount;
		String getAccountId = testController.cbAccount.Id;
	}	
}