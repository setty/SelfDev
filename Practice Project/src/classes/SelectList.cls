public class SelectList {
        String[] countries = new String[]{};
            
        public PageReference test() {
        	
        	Error.DebugLog('countries==>'+countries);
            return null;
        }
            
        public List<SelectOption> getItems() {
            List<SelectOption> options = new List<SelectOption>();
            options.add(new SelectOption('US','US'));
            options.add(new SelectOption('CANADA','Canada'));
            options.add(new SelectOption('MEXICO','Mexico'));
            return options;
        }
        
        public void ActionSupport()
        {
        	Error.DebugLog('countries ==>'+countries);
        
        }
            
        public String[] getCountries() {
            return countries;
        }
            
        public void setCountries(String[] countries) {
            this.countries = countries;
        }
    }