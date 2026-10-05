public with sharing class GetGovernorLimits {
    public GetGovernorLimits() {
    }
    public class LimitsResults{
        @InvocableVariable(label='Limit Usage') public Integer limitUsage;
        @InvocableVariable(label='Limit Value') public Integer limitValue;
        
         @InvocableMethod(label='Get Governor Limit Usage')
    public static List<LimitsResult> getLimit(List<String> limitNames) {
        
        List<LimitsResult> results = new List<LimitsResult>();
        
        for (String limitName : limitNames) {
            
            LimitsResult result = new LimitsResult();
            
            switch on limitName.toUpperCase() {
                when 'QUERYROWS' {
                    result.limitUsage = Limits.getQueryRows();
                    result.limitValue = Limits.getLimitQueryRows();
                }
                /*TODO#3
                * Add additional statements for QUERIES, DMLROWS and DMLSTATEMENTS making 
                * appropriate calls to the Limits class methods for the number of queries, 
                * number of DML rows and number of DML statements respectively.
                */
                
                when else {
                    result.limitUsage = -1;
                    result.limitValue = -1;
                }
            }
            results.add(result);
        }
        
        return results;
    }
    
        
    }
    /*TODO#2:
    * Define the getLimit method as an invocable method with the label 'Get Governor Limit Usage'
    */

   
    
    
}

