trigger Exercise2 on Contact (before insert, before update,before delete, after insert, after update,after delete) {
new Exercise2TriggerHandler().run();


}