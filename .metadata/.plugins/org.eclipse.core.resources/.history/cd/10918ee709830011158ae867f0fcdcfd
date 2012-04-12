global with sharing class RamrodController 
{
	public RamrodController()
	{
		 Http http = new Http();
    	 HttpRequest req = new HttpRequest();
    	 req.setEndpoint('http://labs.adobe.com/technologies/spry/samples/data_region/JSONDataSetSample.html');
         req.setMethod('GET');
         Error.DebugLog('req.getBody =======>'+req.getBody());
         Error.DebugLog('req.getBodyDocument() =======>'+req.getBodyDocument());
         Error.DebugLog('req.getCompressed() =======>'+req.getCompressed());
         Error.DebugLog('req.getEndpoint() =======>'+req.getEndpoint());
         Error.DebugLog('req.getMethod() =======>'+req.getMethod());
         HttpResponse res = http.send(req);
         Error.DebugLog('res In String ===========>'+res.toString());
         Error.DebugLog('res.getHeaderKeys() ===========>'+res.getHeader('Content-Type'));
         for(String strVal : res.getHeaderKeys())
         {
         		Error.DebugLog('==========>'+strVal);
         }
         
	}
}