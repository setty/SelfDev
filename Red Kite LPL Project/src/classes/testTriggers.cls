public class testTriggers {
	static testMethod void createFundAuditWhenInvestmentOptionAddedDeleted() {
		
		Investment_Option__c idea = new Investment_Option__c(Plan__c='80070000000PkVx');
		insert idea;
		
		Investment_Option__c idea2 = new Investment_Option__c(id=idea.id);
		delete idea;	
	}
}