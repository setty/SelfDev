public class testDST {
	    
	static testMethod void DSTLogin() {
		string result = DSTClient.login('vs262238', 'n6r6p7');
		System.assertNotEquals('1234567890', result);
	}
}