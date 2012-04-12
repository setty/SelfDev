trigger createFundAuditWhenInvestmentOptionAddedDeleted on Investment_Option__c (after insert, before delete) {
	List<Fund_Audit_Trail__c> fundAuditTrailList = new List<Fund_Audit_Trail__c>();// build list in memory	
	if (Trigger.isDelete){
		// after investment options are added are deleted
	  	for (Investment_Option__c investmentOption : System.Trigger.old) {
	  		Fund_Audit_Trail__c fundAuditTrail = new Fund_Audit_Trail__c(
			  Notes__c = investmentOption.Reason_for_Change__c, 
			  Action__c = 'Removed Investment Option', 
			  Plan__c = investmentOption.Plan__c, 
			  Fund_Name__c = investmentOption.Fund_Name_Hidden__c, 
			  Ticker_Symbol__c = investmentOption.Investment_Option_Ticker_Symbol__c);
			
			fundAuditTrailList.add(fundAuditTrail);  // add to list
	  	}	
	} else if (Trigger.isInsert){
		// after investment options are added are inserted
	  	for (Investment_Option__c investmentOption : System.Trigger.new) {
	  		Fund_Audit_Trail__c fundAuditTrail = new Fund_Audit_Trail__c(
			  Notes__c = investmentOption.Reason_for_Change__c, 
			  Action__c = 'Added Investment Option', 
			  Plan__c = investmentOption.Plan__c, 
			  Fund_Name__c = investmentOption.Fund_Name_Hidden__c, 
			  Ticker_Symbol__c = investmentOption.Investment_Option_Ticker_Symbol__c);
			
			fundAuditTrailList.add(fundAuditTrail);  // add to list
	  	}		
	}
    // insert the entire list
  	insert fundAuditTrailList;
}