public with sharing class countOccurances {
    public countOccurances() {

    }
    public static Map<String,Integer> Occurances(List<String> values){
        Map<String,Integer> occurance = new Map<String,Integer>();
        for(String val : values){
            if(occurance.containsKey(val)){
                occurance.put(val,occurance.get(val)+1);
            }else {
                occurance.put(val,1);
            }
        }
        return occurance;
    }
   
    
}