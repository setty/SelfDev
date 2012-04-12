/*
	This Class illustrate the data structure of Apex with Iterator
	To use custom iterators, you must create an Apex class that implements the Iterator interface.
*/

global with sharing class IteratorConceptApex implements Iterator<Account>
{
	List<Account> lstAccount {get;set;}
	Integer i {get;set;}
	
	// Constructor
	
	public IteratorConceptApex()
	{
		lstAccount = new List<Account>();
		lstAccount = [select Name,Id from Account];
		Error.DebugLog('Inside the IteratorConceptApex constructor which Implements Iterator ');
	}
	
	//
	global boolean hasNext(){
		
		if(i >= lstAccount.size())
			return false;
		else
			return true;		
	}
	
	global Account next(){
		if(i == 8){return null;}
			i++;
		return lstAccount[i-1];
	}
}