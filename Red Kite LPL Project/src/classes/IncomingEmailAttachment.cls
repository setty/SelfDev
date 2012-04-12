global class IncomingEmailAttachment implements Messaging.InboundEmailHandler {
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
    Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();

    Integer i;
    Attachment[] newAtt = new Attachment[0];
    try {
        Contract con = [Select Id, OwnerId From Contract Where Id = :email.subject Limit 1];
  
        if (email.binaryAttachments!=null && email.binaryAttachments.size() > 0) {
            for (i = 0 ; i < email.binaryAttachments.size() ; i++) {
                try {
                    if (email.binaryAttachments[i].filename != null) { 
                        Attachment newAttachment = new Attachment(ParentId = con.Id,
                        Name = email.binaryAttachments[i].filename,
                        OwnerId = con.OwnerId, 
                        IsPrivate = true,
                        Body = email.binaryAttachments[i].body);
                        insert newAttachment;
                    }
                }
                catch (QueryException e) {
                System.debug('Query Issue: ' + e);
                }
            }
        }
        if (email.textAttachments!=null && email.textAttachments.size() > 0) {
            for (i = 0 ; i < email.textAttachments.size() ; i++) {
                try {
                    if (email.textAttachments[i].filename != null) { 
                        Attachment newAttachment = new Attachment(ParentId = con.Id,
                        Name = email.textAttachments[i].filename,
                        OwnerId = con.OwnerId, 
                        IsPrivate = true,
                        Body = Blob.valueOf(email.textAttachments[i].body) );
                        insert newAttachment;
                    }
                }
                catch (QueryException e) {
                System.debug('Query Issue: ' + e);
                }
            }
        } 
    } 
    catch (QueryException e) {
    System.debug('Query Issue: ' + e);
    }
 
    result.success = true;
    return result;
    }
}