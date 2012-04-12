@isTest
private class PopulatePCFields_Test {

    static testMethod void myUnitTest() {

		Account a = new Account(Name='Drew Test');
		insert a;
// , PersonEmail = 'drewtest@test.com', PersonHomePhone='123-456-7890'
		
		Contact c = new Contact(AccountId=a.Id, FirstName='Drew', LastName='Test', Business_Phone__c='123-123-1234');
		insert c;
		
    }
}