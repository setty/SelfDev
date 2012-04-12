/**
* RKRSSNFR_Article class stores various attributes for the RSS News Feed articles retreived from Google News. 
*
* Author:  Jigar Shah
*
* Revision History:
*   Version     Version Author     Date        Comments
*   1.0         Jigar Shah         04-27-2011  Initial Draft
*
*/

public with sharing class RKRSSNFR_Article {
	
	//Constructor
	public RKRSSNFR_Article(String pTitle, String pLink, String pGuid, String pPublishedDateTime, String pSummary){
		this.Title = pTitle;
		this.Link = pLink;
		this.Guid = pGuid;
		this.PublishedDateTime = pPublishedDateTime;
		this.Summary = pSummary;
	}
	
	public String Title {get; set;}					//Title of the Google News article
	public String Link {get; set;}					//Url of the Google News article
	public String Guid {get; set;}					//Guid, unique identifier
	public String PublishedDateTime {get; set;}		//Date and time when the Google News article was published
	public String Summary {get; set;}				//Summary of the Google News article
	public String ImageUrl {get; set;}				//Url of the Image for the Google News article
	public String Domain {get; set;}				//Domain
	public String SourceName {get; set;}			//Source of news
	
}