/* Helper class that removes unwanted string values from the input Account or Contact names*/

public class AccountContactNameCleanser {
	
	public static String clean(String pNameToClean){
		return pNameToClean.toLowerCase().replaceFirst(System.Label.AccountContact_Name_Cleanser_Regex, '');
	}
	
	public static String cleanSpecific(String pNameToClean, String pCsvStringToSearch){
		String strCleanName;
		List<String> SearchValueList;
		
		if(pCsvStringToSearch.contains(';')){
			SearchValueList = pCsvStringToSearch.split(';');
			for(String strSearchValue : SearchValueList){
				strCleanName = pNameToClean.toLowerCase().replaceFirst(strSearchValue, '');
			}
		}
		else if(pCsvStringToSearch.contains(',')){
			SearchValueList = pCsvStringToSearch.split(',');
			for(String strSearchValue : SearchValueList){
				strCleanName = pNameToClean.toLowerCase().replaceFirst(strSearchValue, '');
			}
		}	
		return strCleanName;
	}  

}//End