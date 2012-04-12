public class TestIncomingEmailAttachment {

	static testMethod void TestEA() {

		// Create a new email, envelope object and Attachment
		Messaging.InboundEmail email = new Messaging.InboundEmail();
		Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
		Messaging.InboundEmail.TextAttachment inAtt = new Messaging.InboundEmail.TextAttachment();
		email.subject = '80070000000PkVx';
		env.fromAddress = 'drew@junk.com';
	
		// set the body of the attachment
		inAtt.body = 'test';
		inAtt.fileName = 'junktextattachment.txt';
		inAtt.mimeTypeSubType = 'plain/txt';
		email.textAttachments = new Messaging.inboundEmail.TextAttachment[] {inAtt };
	
		// call the class and test it with the data in the testMethod
		IncomingEmailAttachment emailServiceObj = new IncomingEmailAttachment();
		emailServiceObj.handleInboundEmail(email, env );    


		// Create a new email, envelope object and Attachment
		Messaging.InboundEmail email2 = new Messaging.InboundEmail();
		Messaging.InboundEnvelope env2 = new Messaging.InboundEnvelope();
		Messaging.InboundEmail.BinaryAttachment inAtt2 = new Messaging.InboundEmail.BinaryAttachment();
		email2.subject = '80070000000PkVx';
		env2.fromAddress = 'drew@junk.com';
	
		// set the body of the attachment
		inAtt2.body = blob.valueOf('test');
		inAtt2.fileName = 'junkbinaryattachment.exe';
		inAtt2.mimeTypeSubType = 'application/octet-stream';
		email2.binaryAttachments = new Messaging.inboundEmail.BinaryAttachment[] {inAtt2 };
	
		// call the class and test it with the data in the testMethod
		IncomingEmailAttachment emailServiceObj2 = new IncomingEmailAttachment();
		emailServiceObj2.handleInboundEmail(email2, env2 );    

	}
}