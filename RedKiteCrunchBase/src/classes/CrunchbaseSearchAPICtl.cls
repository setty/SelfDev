public class CrunchbaseSearchAPICtl {
	
	private List<Selectoption> accountNameList = new List<Selectoption>();
	private static Integer cnt = 0;
	
	//Constructor
	public CrunchbaseSearchAPICtl(){
		cnt++;
		System.debug('****** Count: ' + cnt);
	}
	
	//Properties
	public String selectedPermalink{get;set;}
	
	public List<Selectoption> getaccountNameList(){
		
		/* Clear the elements before re-populating the list */
		if(accountNameList.size() > 0)
		{ accountNameList.clear(); }
		
		/* Populate a list of account names to display on UI */ 
		for(Account oAccount : [SELECT Id, Name, Crunchbase_Permalink__c FROM Account]){
			accountNameList.add(new Selectoption(oAccount.Name + '#' + oAccount.Crunchbase_Permalink__c, oAccount.Name));
		} 
		return accountNameList;
	}
	
	public Pagereference assignSelectedValue(){
		selectedPermalink = Apexpages.currentPage().getParameters().get('p');
		return NULL;
	}
	
}