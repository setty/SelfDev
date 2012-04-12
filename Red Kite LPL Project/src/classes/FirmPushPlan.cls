global class FirmPushPlan {
    static String endpoint1 = 'http://services.fiduciarymanagement.com/webservices/v1/SecurityService.asmx';
    //NRP Sales Force Service
    static String endpoint2 = 'http://services.fiduciarymanagement.com/webservices/nrp/NrpSalesForceWebService.asmx';
    
    static String ERROR_MESSAGE1 = 'Error :No Investment Options found.';
    static String ERROR_MESSAGE2 = 'Error :Ticker symbol or Custom Fund name not found for Investment Option. Please put atleast one of them and try again.';
    static String ERROR_MESSAGE3 = 'Error :Salesforce clientId not present.';
    static String ERROR_MESSAGE4 = 'Error :Unable to Push Plan.';
    static String ERROR_MESSAGE5 = 'Error :Communication timed out.  Please try again';
    static String ERROR_MESSAGE6 = 'Error :Unable to Login.  Please try again';
    static String ERROR_MESSAGE7 = 'Error :Fund Status field is not in the form ABC(x).';
    
    webService static String login(string username, string password) {
        try {
        Http h = new Http();
        HTTPResponse res = null;
        String xml = '<?xml version="1.0" encoding="utf-8"?>';
        xml += '<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">';
        xml += '<soap12:Body>';
        xml += '<GetSessionTokenForBroker xmlns="http://services.fiduciarymanagement.com/webservices/v1/">';
        xml += '<Username>' + username + '</Username>';
        xml += '<Password>' + password + '</Password>';
        xml += '</GetSessionTokenForBroker>';
        xml += '</soap12:Body>';
        xml += '</soap12:Envelope>';
        String req = EncodingUtil.urlEncode(xml,'UTF-8');
        req = xml;

        system.debug('FIRM Login Request XML:' + req);
        res = h.send(postRequest(req, endpoint1));
        system.debug('FIRM Login Response XML:' + res.getBody());
        
        if(res.getBody().contains('timeout')){
            return ERROR_MESSAGE5;
        } 

        String sessionId = '';
        XmlStreamReader xsr = new XmlStreamReader(res.getBody());
        while(xsr.hasNext()) 
        {   
            if (xsr.getEventType() == XmlTag.START_ELEMENT) {
            if ('GetSessionTokenForBrokerResult' == xsr.getLocalName()) {
                sessionId = parse(xsr);
                break;
            }
            }
            xsr.next();
        }
        return sessionId;
        } catch (Exception e){
            return ERROR_MESSAGE6;
        }
    }
    
    
    webService static String pushPlan(string contractId, string sessionId) {
        String result;
        try {

        //system.debug('inside pushPlan contractId:' + contractId + ', sessionId' + sessionId);

        Contract c = [Select Id, Account.Name, Number_of_Eligible_Participants__c, Number_of_Participants__c, Provider__r.Name, 
                Account.Industry, Employer_Contacts__r.FirstName, Employer_Contacts__r.LastName, 
                Employer_Contacts__r.MailingStreet, Employer_Contacts__r.MailingCity, 
                Employer_Contacts__r.MailingState, Employer_Contacts__r.MailingPostalCode, 
                Employer_Contacts__r.Phone, Employer_Contacts__r.Fax, Employer_Contacts__r.Email 
                from Contract where Id = :contractId];
        Http h = new Http();
        HTTPResponse res = null;
        if(c.Id != null) {
            result = c.Id; 
            String xml = '<?xml version="1.0" encoding="utf-8"?> <soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope"><soap12:Body>';
            xml += '<PushNrpClient xmlns="http://services.fiduciarymanagement.com/webservices/nrp/">';
            xml += '<SessionToken>'+sessionId+'</SessionToken>';
            xml += '<NrpClientRecord>';
                xml += '<SalesForceClientId>'+c.Id+'</SalesForceClientId>';

                if(c.Account.Name !=null)
                    xml += '<CompanyName>'+cleanString(c.Account.Name)+'</CompanyName>';
                if(c.Number_of_Participants__c != null)
                    xml += '<ParticipantsActual>'+c.Number_of_Participants__c+'</ParticipantsActual>';
                if(c.Number_of_Eligible_Participants__c != null)    
                    xml += '<ParticipantsEligible>'+c.Number_of_Eligible_Participants__c+'</ParticipantsEligible>'; // Need to change
                if(c.Provider__r.Name !=null)
                    xml += '<ProviderName>'+cleanString(c.Provider__r.Name)+'</ProviderName>';
                if(c.Account.Industry !=null)
                    xml += '<IndustryName>'+cleanString(c.Account.Industry)+'</IndustryName>';

                xml += '<SponsorContact>';
                    if(c.Employer_Contacts__r.FirstName !=null)
                        xml += '<FirstName>'+cleanString(c.Employer_Contacts__r.FirstName)+'</FirstName>';
                    if(c.Employer_Contacts__r.LastName !=null)
                        xml += '<LastName>'+cleanString(c.Employer_Contacts__r.LastName)+'</LastName>';
                    if(c.Employer_Contacts__r.MailingStreet !=null)
                        xml += '<Address1>'+cleanString(c.Employer_Contacts__r.MailingStreet)+'</Address1>';
                    //if(c.Employer_Contacts__r.MailingStreet !=null)
                        //xml += '<Address2>'+c.Employer_Contacts__r.MailingStreet+'</Address2>';
                    if(c.Employer_Contacts__r.MailingCity !=null)
                        xml += '<City>'+c.Employer_Contacts__r.MailingCity+'</City>';
                    if(c.Employer_Contacts__r.MailingState !=null)
                        xml += '<StateCode>'+c.Employer_Contacts__r.MailingState+'</StateCode>';
                    if(c.Employer_Contacts__r.MailingPostalCode !=null)
                        xml += '<ZipCode>'+c.Employer_Contacts__r.MailingPostalCode+'</ZipCode>';
                    if(c.Employer_Contacts__r.Phone !=null)
                        xml += '<Phone>'+c.Employer_Contacts__r.Phone+'</Phone>';
                    if(c.Employer_Contacts__r.Fax !=null)
                        xml += '<Fax>'+c.Employer_Contacts__r.Fax+'</Fax>';
                    if(c.Employer_Contacts__r.Email !=null)
                        xml += '<Email>'+c.Employer_Contacts__r.Email+'</Email>';
                xml += '</SponsorContact>';

                xml += '<FundsList>';       
                Investment_Option__c[] invOpt = 
                [Select Investment_Option_Ticker_Symbol__c, Custom_Fund_Name__c, Product__r.Id, Product__r.Name, Product__r.Current_Quarter_Return__c,
                    Product__r.X1_Yr_Annualized_Return__c, Product__r.X3_Yr_Annualized_Return__c, Product__r.X5_Yr_Annualized_Return__c,
                    Product__r.Since_Inception__c, Product__r.Year_To_Date_Return__c, Product__r.Expense_Ratio__c, Product__r.Gross_Expense_Ratio__c, 
                    of_Assets_in_Fund_AUM__c, Fund_Status__c from Investment_Option__c where Plan__c = :contractId ];

                if(invOpt==null || invOpt.size() <= 0) {
                return ERROR_MESSAGE1;
                }

                String PortfolioStatus;
                for(integer i=0; i<invOpt.size(); i++) {
                    PortfolioStatus = null;              
                    if (invOpt[i].Fund_Status__c != null) {
                        try {
                            PortfolioStatus = invOpt[i].Fund_Status__c.substring(invOpt[i].Fund_Status__c.indexOf('(')+1,invOpt[i].Fund_Status__c.indexOf('(')+2);
                        } catch (Exception e) {
                            return ERROR_MESSAGE7 + ' ' + e.getMessage();
                        }
                    }
                    xml += '<NrpPlanFund>';
                        if(invOpt[i].Investment_Option_Ticker_Symbol__c != null)
                            xml += '<Ticker>'+cleanString(invOpt[i].Investment_Option_Ticker_Symbol__c)+'</Ticker>';
                        else if(invOpt[i].Custom_Fund_Name__c != null)
                            xml += '<Ticker>'+cleanString(invOpt[i].Custom_Fund_Name__c)+'</Ticker>';
                        else 
                            return ERROR_MESSAGE2;
                        //else if(invOpt[i].Product__r.Id != null)
                            //xml += '<Ticker>'+cleanString(invOpt[i].Product__r.Id)+'</Ticker>';                       

                        //mentioned as n/a in document
                        //xml += '<LegalType>string</LegalType>'; 
                        if(invOpt[i].Product__r.Name != null) {
                            xml += '<FundName>'+cleanString(invOpt[i].Product__r.Name)+'</FundName>';
                        }
                        if(invOpt[i].Product__r.Current_Quarter_Return__c !=null)
                            xml += '<Return1QtrAgo>'+invOpt[i].Product__r.Current_Quarter_Return__c+'</Return1QtrAgo>';
                        if(invOpt[i].Product__r.X1_Yr_Annualized_Return__c != null)
                            xml += '<YearReturn1>'+invOpt[i].Product__r.X1_Yr_Annualized_Return__c+'</YearReturn1>';
                        if(invOpt[i].Product__r.X3_Yr_Annualized_Return__c != null)
                            xml += '<YearReturn3>'+invOpt[i].Product__r.X3_Yr_Annualized_Return__c+'</YearReturn3>';
                        if(invOpt[i].Product__r.X5_Yr_Annualized_Return__c != null)
                            xml += '<YearReturn5>'+invOpt[i].Product__r.X5_Yr_Annualized_Return__c+'</YearReturn5>';
                        //mentioned as n/a in document
                        //xml += '<YearReturn10>decimal</YearReturn10>';
                        if(invOpt[i].Product__r.Since_Inception__c != null)
                            xml += '<YearReturnInception>'+invOpt[i].Product__r.Since_Inception__c+'</YearReturnInception>';// Need to change
                        if(invOpt[i].Product__r.Year_To_Date_Return__c != null)
                            xml += '<YearReturnTD>'+invOpt[i].Product__r.Year_To_Date_Return__c+'</YearReturnTD>';
                        if(invOpt[i].Product__r.Expense_Ratio__c != null)
                            xml += '<NetExpenseRatio>'+invOpt[i].Product__r.Expense_Ratio__c+'</NetExpenseRatio>';
                        if(invOpt[i].Product__r.Gross_Expense_Ratio__c != null)
                            xml += '<GrossExpenseRatio>'+invOpt[i].Product__r.Gross_Expense_Ratio__c+'</GrossExpenseRatio>';
                        //mentioned as n/a in document
                        //xml += '<ExpenseDisclosure>string</ExpenseDisclosure>';
                        if(invOpt[i].of_Assets_in_Fund_AUM__c != null)
                            xml += '<ExistingAmount>'+invOpt[i].of_Assets_in_Fund_AUM__c+'</ExistingAmount>';
                        if(PortfolioStatus != null)
                            xml += '<PortfolioStatus>'+PortfolioStatus+'</PortfolioStatus>';
                    xml += '</NrpPlanFund>';
                }
                xml += '</FundsList>';          
            xml += '</NrpClientRecord>';
            xml += '</PushNrpClient>';
            xml += '</soap12:Body> </soap12:Envelope>';

            system.debug('FIRM PushPlan Request XML' + xml);
            string req = EncodingUtil.urlEncode(xml,'UTF-8');
            req = xml;
            res = h.send(postRequest(req, endpoint2));
            string response = res.getBody();
            system.debug('FIRM PushPlan Response XML : '+response);

            if(response.contains('Fault') || response.contains('fault')){
                result = 'Error :'+ response +'.';
            }           
        } else {
            result = ERROR_MESSAGE3;
        }
        
    } catch(Exception e) {
        result = ERROR_MESSAGE4 + ' ' + e.getMessage();
    }
    return result;
    }

    private static String parse(XMLStreamReader r) {
        String ret='';
        if(r!=null) {
        while(r.hasNext()) {
            if (r.getEventType() == XmlTag.END_ELEMENT) 
               break;
            else if (r.getEventType() == XmlTag.CHARACTERS) {
               ret=r.getText();
            }
            r.next();
        }
    }
        return ret;
    }

    private static HttpRequest postRequest(string request, string endpoint) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpoint);
        req.setMethod('POST');
        req.setBody(request);
        req.setHeader('Content-Length', String.valueOf(request.length()));
        req.setHeader('Content-type', 'text/xml');
        return req;
    }
    
    private static String cleanString(String str){
        if(str == null){
            return '';
        }       
        if(str.contains('&')){                              
            str = str.replace('&','&amp;');
        }
        if(str.contains('%')){                              
            str = str.replace('%','&#37;');
        }
        if(str.contains('<')){                              
            str = str.replace('<','&lt;');
        }
        if(str.contains('>')){                              
            str = str.replace('>','&gt;');
        }
        return str;
    }

    public static testMethod void FirmPushLoginTest() {

        System.assertEquals('',FirmPushPlan.cleanString(null)); 
            Contract c = [Select Id, Account.Name, Number_of_Eligible_Participants__c, Number_of_Participants__c, Provider__r.Name, 
                Account.Industry, Employer_Contacts__r.FirstName, Employer_Contacts__r.LastName, 
                Employer_Contacts__r.MailingStreet, Employer_Contacts__r.MailingCity, 
                Employer_Contacts__r.MailingState, Employer_Contacts__r.MailingPostalCode, 
                Employer_Contacts__r.Phone, Employer_Contacts__r.Fax, Employer_Contacts__r.Email 
                from Contract where Id = '80070000000PiQ3'];        

        System.assertEquals('80070000000PiQ3', c.Id);
        Investment_Option__c[] invOpt = 
            [Select Investment_Option_Ticker_Symbol__c, Custom_Fund_Name__c, Product__r.Id, Product__r.Name, Product__r.Current_Quarter_Return__c,
                Product__r.X1_Yr_Annualized_Return__c, Product__r.X3_Yr_Annualized_Return__c, Product__r.X5_Yr_Annualized_Return__c,
                Product__r.Since_Inception__c, Product__r.Year_To_Date_Return__c, Product__r.Expense_Ratio__c, Product__r.Gross_Expense_Ratio__c, of_Assets_in_Fund_AUM__c
             from Investment_Option__c where Plan__c = :c.Id ];     
        
        System.assert((invOpt.size()>0));
        

        String result4 = FirmPushPlan.pushPlan(c.Id, '1234567890');
//DAF        System.assert(result4.contains('Testmethods do not support webservice callouts'));  
        
        XmlStreamReader xsr1 = new XmlStreamReader('<test1>testa</test1><test2>testb</test2>');
        System.assertEquals('testa', parse(xsr1));
        
        String postReq = postRequest('',endpoint1).toString();
        System.assert(postReq.contains('POST'));
        
        
        String result2 = FirmPushPlan.pushPlan('80070000000PiQ3', '1234567890');
        System.assert(result2.contains('Error'));   
        System.assert(!result2.contains('Success'));    
        
        
        string result3 = FirmPushPlan.login('foo', 'abc');
        System.assert(result3.contains('Error'));   
        System.assert(!result3.contains('Success'));    
        
        System.assertEquals('Test',FirmPushPlan.cleanString('Test'));
        System.assertEquals('Test&amp;',FirmPushPlan.cleanString('Test&'));
        System.assertEquals('Test&#37;',FirmPushPlan.cleanString('Test%'));
        System.assertEquals('Test&lt;',FirmPushPlan.cleanString('Test<'));  
        
        
    }    
    
}