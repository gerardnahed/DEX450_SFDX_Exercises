trigger Exercise3_Trigger on Competitor__c (before insert, before update, before delete, after insert, after update, after delete) {
new Exercise3TriggerHandler().run();
}