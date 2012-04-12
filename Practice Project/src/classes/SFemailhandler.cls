global class SFemailhandler implements Messaging.Inboundemailhandler
{
	//http://blog.jeffdouglas.com/2011/02/15/find-my-salesforce-users-by-role-hierarchy/
	// This Interface Messaging.InboundemailHandlar contain 
	// gloab Interface method
	 global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) 
	 {
          Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
          return result;
     }

}