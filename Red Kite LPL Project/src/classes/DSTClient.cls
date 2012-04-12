global class DSTClient {

    static string endpoint = 'https://www3.financialtrans.com/tf/Vision/VSSSignon';
    static string forwardUrl = '';
    static string tx = '';
    static string tidx = '';
    static string cz = '';
    static string attr = '';

    webService static string login(string username, string password) {
        Http h = new Http();
        HTTPResponse res = null;
        string req = 'tx=VisStartup&cz=6210818081413&sms_info=';
        string xml = '<?xml version="1.0"?><Envelope><Body><Message><Request><Signon>';
        xml += '<User>' + username + '</User>';
        xml += '<Password>' + password + '</Password>';
        xml += '<BrowserHeaderInfo/><PrivateLabelName>nrp</PrivateLabelName></Signon>';
        xml += '</Request></Message></Body></Envelope>';
        
        req += EncodingUtil.urlEncode(xml,'UTF-8');
        res = h.send(postRequest(req));
        String[] keys = res.getHeaderKeys();
        for (Integer i=0; i<keys.size(); i++) {}
        
        Integer paramCount = 0;
        XmlStreamReader xsr = new XmlStreamReader(res.getBody());
        /*
        while(xsr.hasNext()) 
        {
            if (xsr.getEventType() == XmlTag.START_ELEMENT) 
            {
                if ('Forward_URL' == xsr.getLocalName())
                    attr = 'Forward_URL';
                parse(xsr);
            }
            xsr.next();
        }
        */
        return res.getBody();
    }
    
    /*
    private static void parse(XMLStreamReader r) {
        while(r.hasNext()) 
        {
            if (r.getEventType() == XmlTag.ATTRIBUTE) 
            {
                if (r.getAttributeCount()>0)
                    attr = r.getAttributeValueAt(0);
            }
            if (r.getEventType() == XmlTag.END_ELEMENT) 
            {
               break;
            }
            else if (r.getEventType() == XmlTag.CHARACTERS) 
            {
               //if ('Forward_URL' == attr)
               //     forwardUrl = r.getText();
               //else if ('cz' == attr)
               //    cz = r.getText();
               //else if ('tx' == attr)
               //    tx = r.getText();
               if ('tidx' == attr)
                   tidx = r.getText();
               //break;
            }
            r.next();
        }
    }
    */

    private static HttpRequest postRequest(string request) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpoint);
        req.setMethod('POST');
        req.setBody(request);
        req.setHeader('Content-Length', String.valueOf(request.length()));
        req.setHeader('User-Agent', 'VSSAccountSearchTester');
        req.setHeader('Content-type', 'application/x-www-form-urlencoded');
        return req;
    }
}