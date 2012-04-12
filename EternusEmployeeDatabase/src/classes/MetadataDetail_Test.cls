/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
 /*--------------------------------------------------------------------------------------------------
	Name	    : MetadataDetail_Test
	Created Date: 09/05/2011
	Created By  : Eternus Solutions Pvt. Ltd.
	Description : This Apex class is associated with the SnapItMetadataXplorerView page and contains the 
				  implementation logic for retreiving the metadata information for all existing 
				  objects on the org. It allows the retreieved metadata information to be displayed 
				  on screen to the user or export it to an Excel spreadsheet or PDF format.
				        
	Revision History:
	Sr. No		Modified On			Modified By							Description
		1		09/05/2011			Siddharth Birari			Test Class for Metadata Detail.
					
--------------------------------------------------------------------------------------------------*/
@isTest
private class MetadataDetail_Test {
    	public static testMethod void SFDCObjectListTest()
    	{
    		SnapItMetadataXplorerCtl snapObj = new SnapItMetadataXplorerCtl();
    		snapObj.getAllSFDCObjects();
    		
    		if(snapObj.getSFDCObjectList().isEmpty())			//Objects being populated for the first time or not
    		{
    			System.assert(snapObj.getSFDCObjectList().Size() != 0);
    		}
    	}
    
}	//MetadataDetail_Test
//this is my test class