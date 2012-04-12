/*--------------------------------------------------------------------------------------------------
	Name	    : SampleApiController
	Created Date: 18/01/2011
	Created By  : Jigar Shah
	Description : This Apex controller class retreives the metadata information for all existing 
				  Sobjects on the org using Dynamic Apex.
				        
	Revision History:
	Sr. No		Modified On			Modified By							Description
		1		18/01/2011			Jigar Shah			Created the Apex Controller class.
					
--------------------------------------------------------------------------------------------------*/

public class SampleApiController 
{
	 private String SelectedObjectName = 'none';
	 private String SelectedFieldCategory = 'all';
	 private static List<FieldType> FieldTypeList = new List<FieldType>();
	 private static List<Selectoption> SFDCFldCategoryLblList = new List<Selectoption>();
	 private static List<Selectoption> SFDCObjectsList = new List<Selectoption>();	
	 
	 //Default Constructor
	 public SampleApiController()
	 {}
	 
	 //Custom Type - Holds the describe details of every field retreived for the selected Sobject.
	 public class FieldType
	 {
	 	public FieldType(Integer pIndex, String pLabel, String pName, String pDataType, String pFieldDetails)
	 	{
	 		Index = pIndex;
	 		FieldLabel = pLabel;
	 		FieldName = pName;
	 		FieldDataType = pDataType;
	 		FieldDetails = pFieldDetails;
	 	}
	 	
	 	public Integer Index{get; private set;}	//Sr. No.
	 	public String FieldLabel {get; set;}	//Field Label
	 	public String FieldName {get; set;}		//Field API name
	 	public String FieldDataType {get; set;}	//Field Datatype
	 	public String FieldDetails {get; set;}	//Field Details (Picklist values)
	 	
	 }//FieldType
	 	 
	 //PROPERTIES
	 //Returns a list of all fields with their attributes
	 public List<FieldType> getFieldTypeList()
	 { 
	 	if(FieldTypeList.isEmpty())
	 	{
	 		Apexpages.addMessage(new Apexpages.Message(ApexPages.Severity.INFO, 'No Custom Fields exist.'));
	 		return NULL;
	 	}
	 	return FieldTypeList; 
	 }
	 
	 public List<SelectOption> getSFDCObjectsList()
	 { 
	 	//Check for new objects if object list is populated
	 	if(!SFDCObjectsList.isEmpty())
	 		this.getAllSFDCObjects();
	 	return SFDCObjectsList;
	 }
	 
	 //Selected Object's Label
	 public String SelectedObjectLabel {get; set;}
	 
	 //Selected Object's Name
	 public String getSelectedObjectName()
	 { return SelectedObjectName; }
	 
	 public void setSelectedObjectName(String pSelectedObjName)
	 { 
	 	List<String> SelectedStringList = pSelectedObjName.split('#');
	 	this.SelectedObjectName = SelectedStringList[0].toLowerCase();
	 	this.SelectedObjectLabel = SelectedStringList[1];
	 }
	 	 
	 //Selected Category of Fields
	 public String getSelectedFieldCategory()
	 { return SelectedFieldCategory; }	 	

	 public void setSelectedFieldCategory(String pSelectedFldCategory)
	 { SelectedFieldCategory = pSelectedFldCategory;}
	 
	 //Get the labels to be displayed for Radio Buttons 
	 public List<Selectoption> getFieldCategoryLabels()
	 {
	 	if(SFDCFldCategoryLblList.isEmpty())
	 	{
		 	SFDCFldCategoryLblList.add(new Selectoption('all', 'All Fields'));
		 	SFDCFldCategoryLblList.add(new Selectoption('standard', 'Standard Fields'));
		 	SFDCFldCategoryLblList.add(new Selectoption('custom', 'Custom Fields'));
	 	}
	 	return SFDCFldCategoryLblList;
	 }
	 
	 //METHODS
	 public void getAllSFDCObjects()
	 {
	   Schema.Sobjecttype objSFDCObject;
	   
	   //Retreive a Map of all SFDC Object Tokens and SFDC Objects from the Org
	   Map<String, Schema.Sobjecttype> GlobalDescribeMap = Schema.getGlobalDescribe();
	   
	   //Check if new objects are created or Object list is requested for the first time
	   if(GlobalDescribeMap.size() > SFDCObjectsList.size() || SFDCObjectsList.isEmpty())
	   {
		   List<String> KeyList = new List<String>();
		   KeyList.addAll(GlobalDescribeMap.keySet());
		   KeyList.sort();	//Sort the Objects according to their API names
		   
		   if(!SFDCObjectsList.isEmpty())	//clear the list, if elements exist
		   		SFDCObjectsList.clear();
		   
		   for(String strKey : KeyList)
		   {
		   		if(GlobalDescribeMap.containsKey(strKey))	//check whether the key exists
		   			objSFDCObject = GlobalDescribeMap.get(strKey);
		   		
		   		//Add the Label and API Name values to be displayed in the picklist in the following format: API Name(Label)
			   	 SFDCObjectsList.add(new Selectoption(
			   	 	objSFDCObject.getDescribe().getName()+ '#' + objSFDCObject.getDescribe().getLabel(), 
			   	 	objSFDCObject.getDescribe().getName() + ' (' + objSFDCObject.getDescribe().getLabel()  + ')'));
		   }//for
	   }
	 }
	 
	 public void getAllFields()
	 {
 		Integer intIndex = 0;
	 	String strCategory;
	 	String strPicklistCSV;
 		//Retreive a Map of all SFDC Object Tokens and SFDC Objects from the Org
	 	Map<String, Schema.Sobjecttype> SobjectMap = Schema.getGlobalDescribe();
	 	
	 	//Retreive the describe result for the Object selected by the user and then retreive the all fields for the selected object 
	 	Schema.Describesobjectresult result = SobjectMap.get(SelectedObjectName).getDescribe();
	 	Map<String, Schema.SObjectField> FieldMap = result.fields.getMap();
	 	
	 	List<String> KeyList = new List<String>();
	   	KeyList.addAll(FieldMap.keySet());
	   	KeyList.sort();	//Sort the fields according to their names
	 	
	 	//Clear the FieldType list if it contains any existing elements
	 	if(FieldTypeList.size() > 0)
	 		FieldTypeList.clear();
	 		
	 	for(String strField : KeyList)
	 	{
	 		//Check whether the selected key exists
	 		if(FieldMap.containsKey(strField))
	 		{	 			
	 			Schema.SObjectField objField = FieldMap.get(strField);
		 		Schema.Describefieldresult fieldResult = objField.getDescribe();
		 		
		 		if(this.SelectedFieldCategory == 'all')
		 		{
			 		//Add the newly created FieldType instance to a List
			 		FieldTypeList.add(new FieldType(
			 			++intIndex,
			 			fieldResult.getLabel(), 
			 			fieldResult.getLocalName(), 
			 			fieldResult.getType().name().toLowerCase(),
			 			strPicklistCSV = 
			 				fieldResult.getType().name().toLowerCase().contains('picklist') ? createPicklistValueCSV(fieldResult.getPicklistValues()) : 'NA'));
		 		}
		 		else if(this.SelectedFieldCategory == 'standard')
		 		{
		 			if(!fieldResult.isCustom())		//Populate list of custom fields for the selected Sobject
		 			{
		 				//Add the newly created FieldType instance to a List
				 		FieldTypeList.add(new FieldType(
				 			++intIndex,
				 			fieldResult.getLabel(), 
				 			fieldResult.getLocalName(), 
				 			fieldResult.getType().name().toLowerCase(),
				 			strPicklistCSV = 
			 					fieldResult.getType().name().toLowerCase().contains('picklist') ? 
			 					createPicklistValueCSV(fieldResult.getPicklistValues()) : 'NA'));
		 			}
		 		}
		 		else if(this.SelectedFieldCategory == 'custom')
		 		{
		 			if(fieldResult.isCustom())		//Populate list of custom fields for the selected Sobject
		 			{
		 				//Add the newly created FieldType instance to a List
				 		FieldTypeList.add(new FieldType(
				 			++intIndex,
				 			fieldResult.getLabel(), 
				 			fieldResult.getLocalName(), 
				 			fieldResult.getType().name().toLowerCase(),
				 			strPicklistCSV = 
			 					fieldResult.getType().name().toLowerCase().contains('picklist') ? 
			 					createPicklistValueCSV(fieldResult.getPicklistValues()) : 'NA'));
		 			}
		 		}
	 		}
	 	}//for
	 }
	 
	 //Resets the object selection and refreshes the page
	 public Pagereference ResetAll()
	 {
	 	Pagereference pgReset = Page.SampleApiCall;
	 	pgReset.setRedirect(true);
	 	return pgReset;
	 }
	 
	 //STATIC METHODS
	 //Creates a comma separated string containing all the entries of a field having datatype as picklist.
	 public static String createPicklistValueCSV(List<Schema.Picklistentry> pPicklistEntries)
	 {
	 	String strCSV = 'Picklist Values: ';
	 	for(Schema.Picklistentry pEntry : pPicklistEntries)
	 	{
	 		//Append the picklist values in a comma separated string format  e.g.: a,b,c,d
	 		if(pEntry.getValue() <> NULL)
	 			strCSV = pEntry.isDefaultValue() ? strCSV + pEntry.getValue() + '*' + ', ' : strCSV + pEntry.getValue() + ', ';
	 	}
	 	
	 	//Remove the extra comma and space appended at the end
	 	strCSV  = strCSV.contains(',') ? strCSV.substring(0, strCSV.length() - 2) : 'No Values';
	 	return strCSV;	
	 }	 
	 
}//SampleApiController