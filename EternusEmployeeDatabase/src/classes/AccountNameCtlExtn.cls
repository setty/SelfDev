public with sharing class AccountNameCtlExtn {
	
	private Account oAccount;
	
	public AccountNameCtlExtn(Apexpages.Standardcontroller pAccController){
		if(pAccController <> NULL)
			oAccount = [SELECT Name from Account WHERE Id = :pAccController.getId()];
	}
	
	public String AccountName{
		get{ 
			return oAccount.Name; 
		}
	}
	
	public String CleanedAccountName{
		get{ 
			return AccountContactNameCleanser.clean(oAccount.Name) ; 
		}
	}
	
}