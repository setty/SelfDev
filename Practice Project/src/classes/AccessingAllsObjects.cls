/*
        Use the Schema getGlobalDescribe method to return a map that represents the relationship between all sObject names
        (keys) to sObject tokens (values).
*/


public with sharing class AccessingAllsObjects 
{
        /*              MapOfAllSobject
                • It is dynamic, that is, it is generated at runtime on the sObjects currently available for the organization, based on permissions
                • The sObject names are case insensitive
                • The keys use namespaces as required
                • The keys reflect whether the sObject is a custom object
        */
        
        Map<String,Schema.Sobjecttype> MapOfAllSobject;
        Map<String,Schema.Sobjectfield> MapOfAllSobjectFields;
        List<DescribeDataCategoryGroupResult> describeCategoryResult;
        
        public AccessingAllsObjects ()
        {
                MapOfAllSobject = Schema.getGlobalDescribe();
                Error.DebugLog('Size of MapOfAllSobject ==>'+MapOfAllSobject.size());
                Error.DebugLog('MapOfAllSobject ==>'+MapOfAllSobject);
                
                MapOfAllSobjectFields = Schema.Sobjecttype.Account.fields.getMap();
                Error.DebugLog('Fields of the Account Object ==>'+MapOfAllSobjectFields);
                describeCategoryResult = describeDataCategoryGroupSample();
                //Error.DebugLog('describeCategoryResult ========>'+describeCategoryResult);
        }
        
        public List<DescribeDataCategoryGroupResult> describeDataCategoryGroupSample()
        {
                List<DescribeDataCategoryGroupResult> describeCategoryResult;
                try {
                                //Creating the list of sobjects to use for the describe
                                //call
                                List<String> objType = new List<String>();
                                objType.add('KnowledgeArticleVersion');
                                objType.add('Question');
                                //Describe Call
                                describeCategoryResult = Schema.describeDataCategoryGroups(objType);
                                Error.DebugLog('Schema.describeDataCategoryGroups describeCategoryResult ========>'+describeCategoryResult);
                                //Using the results and retrieving the information
                                for(DescribeDataCategoryGroupResult singleResult : describeCategoryResult)
                                {
                                        //Getting the name of the category
                                        singleResult.getName();
                                        //Getting the name of label
                                        singleResult.getLabel();
                                        //Getting description
                                        singleResult.getDescription();
                                        //Getting the sobject
                                        singleResult.getSobject();
                                }
                        } catch(Exception e){
                                
                        }
                        return describeCategoryResult;
                }
}