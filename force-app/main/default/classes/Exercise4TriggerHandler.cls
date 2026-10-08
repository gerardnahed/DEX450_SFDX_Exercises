public with sharing class Exercise5TriggerHandler extends TriggerHandler implements ITriggerHandler{

    private Map<Id, Payment__c> newMap;
    private Map<Id, Payment__c> oldMap;
    private List<Payment__c> TriggerNew;
    private List<Payment__c> TriggerOld;
    
    public Exercise4TriggerHandler(){
        this.newMap = (Map<Id, Payment__c>) Trigger.newMap;
        this.oldMap = (Map<Id, Payment__c>) Trigger.oldMap;
        this.TriggerNew= (List<Payment__c>) Trigger.New;
        this.TriggerOld= (List<Payment__c>) Trigger.Old;
    }
    
    
    //Use this variable to disable this trigger from transaction
    public static Boolean TriggerDisabled = false;
    
    //check if the trigger is disabled from transaction
    public Boolean isDisabled(){
        return TriggerDisabled;
    }
    
    public override void beforeInsert() {
        Exercise4.generateIdentifierOnInsert(TriggerNew);
    }
    public override void afterInsert() {
    }
    public  override void beforeUpdate() {
        Exercise4.generateIdentifiersOnUpdate(TriggerNew, oldMap);
        
    }
    public override void afterUpdate() {
    }
    
    public override void beforeDelete() {
        
    }
    
    public override void afterDelete() {
        
    }
    
    public override void afterUnDelete() {
        
    }
}