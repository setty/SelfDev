global class RemotingSampleCtl {
    
    private static Account account = new Account();
    //private String accountId;
    //private String accountPermalink;
    
    //Constructor
    global RemotingSampleCtl(ApexPages.standardController stdController){
    	account = (Account)stdController.getRecord();
    	accountId = account.Id;
    	accountPermalink = account.Crunchbase_Permalink__c;
    	//System.debug('*********Controller Account ID: ' + account.Id);
    }
    
    //Property
    public String accountId{get; set;}
    public String accountPermalink{get;set;}

	//Methods
	@RemoteAction
    global static void updateAccount(String paccountId, String ppermalink){
	    update new Account(Id = paccountId, Crunchbase_Permalink__c = ppermalink);
    }
    
}