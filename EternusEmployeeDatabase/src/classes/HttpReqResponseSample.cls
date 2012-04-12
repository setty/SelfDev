public with sharing class HttpReqResponseSample {
	
	//Google News Search Parameters
	private static String qry;
	private static String ned = 'in';
	private static String hl = 'en';
	private static String lr = 'en';
	private static String start = String.valueOf(0);
	private static String num = String.valueOf(10);
	private static String output = 'rss';
	private static String ie = 'UTF-8';
	private static String oe = 'UTF-8';
	private static String scoring = 'r';
	private static Pattern oHtmlTagPattern;				//General Html Tags
	private static Pattern oOtherTagPattern1;		//Tags having format as &nbsp;
	private static Pattern oOtherTagPattern2;	//Tags having format as &#389;
	private List<GoogleNewsFeedItem> GoogleNewsFeedItemList = new List<GoogleNewsFeedItem>();

	//Constructor	
	public HttpReqResponseSample(String pSearchValue){
		//HttpReqResponseSample.generateRegex();
		qry = pSearchValue.toLowerCase();
	}
	
	//GoogleNewsFeedItem
	public class GoogleNewsFeedItem{ 
		
		public GoogleNewsFeedItem(String pTitle, String pDescription, String pPublishedDateTime, String pUrl, String pImageUrl){
			Title = pTitle;
			Description = pDescription;
			PublishedDateTime = pPublishedDateTime;
			Url = pUrl;
			ImageUrl = pImageUrl;
		}
				
		public String Title {get; set;}
		public String Description {get; set;}
		public String PublishedDateTime {get; set;}
		public String Url {get; set;}
		public String ImageUrl {get; set;}
		public String SourceName {get; set;}
		public String Domain {get; set;}
	}
	
	public String GoogleNewsFeedUrl{get; set;}	//Final Google News Feed Url
	
	public List<GoogleNewsFeedItem> getGoogleNewsFeedItemList(){
		return GoogleNewsFeedItemList;
	}
	
	//HTTP Request Response Methods
	public void getHttpReponse(){
		try{
			Httprequest oRequest = new Httprequest();		//create a Http req and set the endpoint Url and the method type as GET
			oRequest.setEndpoint(googleNewsFeedUrlGenerator());
			oRequest.setMethod('GET');
			
			Http oHttp = new Http();
			Httpresponse oResponse = oHttp.send(oRequest);	//send the created Http req using Http to get the response
			
			this.parseRssFeed(oResponse.getBodyDocument());	//Parse the retreived Http response
			
			//Cleanse article decsriptions
			for(GoogleNewsFeedItem oNewsFeedItem : GoogleNewsFeedItemList){
				oNewsFeedItem.SourceName = parseSourceName(oNewsFeedItem.Title);
				oNewsFeedItem.Title = removeSourceName(oNewsFeedItem.Title);
				oNewsFeedItem.Description = HttpReqResponseSample.cleanGarbageHtml(oNewsFeedItem.Description.trim(), oNewsFeedItem.Title.trim());
			}
			
			//Display Articles
			System.debug('**** Google News Feed Articles ****');
			for(GoogleNewsFeedItem oNewsFeedItem : GoogleNewsFeedItemList){
				System.debug('**** Title: ' + oNewsFeedItem.Title);
				System.debug('**** Description: ' + oNewsFeedItem.Description);
				System.debug('**** PublishedDateTime: ' + String.valueOf(oNewsFeedItem.PublishedDateTime));
				System.debug('**** Url: ' + oNewsFeedItem.Url);
				System.debug('**** ImageUrl: ' + oNewsFeedItem.ImageUrl);
				System.debug('**** SourceName: ' + oNewsFeedItem.SourceName);
			}
		}
		catch(Exception ex){
			System.debug('$#$#$#$#$#Exception: ' + ex.getMessage());
		}
	}
	
	//XML Parsing Methods for RSS
	public void parseRssFeed(Dom.Document pDomDocument){
		
		try{
			//Clear any existing items in GoogleNewsFeedItemList
			if(!GoogleNewsFeedItemList.isEmpty())
				GoogleNewsFeedItemList.clear();
				
			//Get the Root Element i.e. rss
			Dom.Xmlnode oRootNode = pDomDocument.getRootElement();
			
			if(oRootNode.getName() == 'rss' && oRootNode.getNodeType() == Dom.Xmlnodetype.ELEMENT){
				Dom.Xmlnode oChannelNode = 	oRootNode.getChildElements().get(0);
				
				for(Dom.Xmlnode oItemNode : oChannelNode.getChildElements()){
					if(oItemNode.getName() == 'item' && oItemNode.getNodeType() == Dom.Xmlnodetype.ELEMENT){
						
						String strTitle;
						String strLink;
						String strPublishedDateTime;
						String strDescription;
						String strGuid;
						
						//Title
						Dom.Xmlnode oTitleNode =  oItemNode.getChildElement('title', null);
						strTitle = oTitleNode.getText();
						
						//Link
						Dom.Xmlnode oLinkNode =  oItemNode.getChildElement('link', null);
						strLink = oLinkNode.getText();
						
						//Guid
						Dom.Xmlnode oGuidNode =  oItemNode.getChildElement('guid', null);
						strGuid = oGuidNode.getText();
						
						//Description
						Dom.Xmlnode oDescNode =  oItemNode.getChildElement('description', null);
						strDescription = oDescNode.getText();	
						
						//Publishes Datetime
						Dom.Xmlnode oPubDateNode =  oItemNode.getChildElement('pubDate', null);
						strPublishedDateTime = oPubDateNode.getText();		
						
						String strImageUrl = parseImageUrl(strDescription);
						GoogleNewsFeedItemList.add(new GoogleNewsFeedItem(strTitle, strDescription, strPublishedDateTime, strLink, strImageUrl));			
				
					}//check for item node	
				}
			}//check for rss node
		}
		catch(Exception ex){
			System.debug('$#$#$#$#$#Exception: ' + ex.getMessage());
		}
	}
	
	//STATIC METHODS
	private static String googleNewsFeedUrlGenerator(){
		
		//Generate google news feed Url - e.g. http://news.google.com/news/search?aq=f&pz=1&cf=all&ned=in&hl=en&q=oracle
		String strGoogleNewsURL = 'http://news.google.com/news/search?';
		strGoogleNewsURL = strGoogleNewsURL + 'q=' + qry + '&hl=' + hl + '&lr=' + lr + '&start=' + start + '&num=' + num + '&output=' + output;
		strGoogleNewsURL = strGoogleNewsURL + '&ie=' + ie + '&oe=' + oe + '&scoring=' + scoring;
		return strGoogleNewsURL;
	}
	
	/*private static void generateRegex(){
		oHtmlTagPattern = Pattern.compile('<.*?>');				//General Html Tags
		oOtherTagPattern1 = Pattern.compile('&\\w.*?;');		//Tags having format as &nbsp;
		oOtherTagPattern2 = Pattern.compile('&#.*?\\w.*?;');	//Tags having format as &#389;
	}*/
	
	private static String cleanGarbageHtml(String pDirtyHtmlString, String pTitleToRemove){
		
		String strHtmlStringToCleanse = pDirtyHtmlString;
		
		/*strHtmlStringToCleanse.replace('<br/>', '\n');
		strHtmlStringToCleanse = strHtmlStringToCleanse.replaceAll(oHtmlTagPattern.pattern(), '');	//Match and clean garbage Html tags
		strHtmlStringToCleanse = strHtmlStringToCleanse.replaceAll(oOtherTagPattern1.pattern(), '');	//Remove tags like &nbsp; &raquo;
		strHtmlStringToCleanse = strHtmlStringToCleanse.replaceAll(oOtherTagPattern2.pattern(), '');	//Remove tags like &#39;
		*/
		strHtmlStringToCleanse = strHtmlStringToCleanse.replaceAll(System.Label.HtmlCleanserRegex, ' ').trim();
		strHtmlStringToCleanse = strHtmlStringToCleanse.replaceAll('&nbsp;', ' ').trim();
		strHtmlStringToCleanse = strHtmlStringToCleanse.replaceAll('&raquo;', ' ').trim();
		strHtmlStringToCleanse = strHtmlStringToCleanse.replaceAll('&#39;', ' ').trim();
		
		//Remove all articles
		if(strHtmlStringToCleanse.contains('all') && strHtmlStringToCleanse.contains('articles')){
			if(strHtmlStringToCleanse.lastIndexOf('all') > -1 && strHtmlStringToCleanse.lastIndexOf('articles') > -1){
				strHtmlStringToCleanse = strHtmlStringToCleanse.replaceFirst(strHtmlStringToCleanse.substring(strHtmlStringToCleanse.lastIndexOf('all'), strHtmlStringToCleanse.lastIndexOf('articles')), '');				
			}
		}
		
		//Remove and more
		if(strHtmlStringToCleanse.contains('and') && strHtmlStringToCleanse.contains('more')){
			if(strHtmlStringToCleanse.lastIndexOf('and') > -1 && strHtmlStringToCleanse.lastIndexOf('more') > -1){
				strHtmlStringToCleanse = strHtmlStringToCleanse.replaceFirst(strHtmlStringToCleanse.substring(strHtmlStringToCleanse.lastIndexOf('and'), strHtmlStringToCleanse.lastIndexOf('more')), '');				
			}
		}
		
		//Remove the title string from the description
		if(strHtmlStringToCleanse.contains(pTitleToRemove)){
			strHtmlStringToCleanse = strHtmlStringToCleanse.replaceFirst(pTitleToRemove, '');
		}

		return strHtmlStringToCleanse;
	}
	
	public static String parseImageUrl(String pDescription){
		if(pDescription.contains('<img src="')){
			String strImageUrl = pDescription.split('<img src="').get(1); 
			return strImageUrl.substring(0, strImageUrl.indexOf('"'));
		}
		return '';
	}
	
	public static String parseSourceName(String pTitle){
		return pTitle.substring(pTitle.lastIndexOf('-') + 2, pTitle.length());	
	}
	
	public static String removeSourceName(String pTitle){
		return pTitle.replaceFirst(pTitle.substring(pTitle.lastIndexOf('-'), pTitle.length()), '')  ;	
	}

}//HttpReqResponseSample End