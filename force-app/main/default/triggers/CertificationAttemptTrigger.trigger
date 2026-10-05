trigger CertificationAttemptTrigger on Certification_Attempt__c (before insert, after insert, after update) 
{
    switch on Trigger.OperationType {

        when BEFORE_INSERT {
            CertificationAttempTriggerHandler.validateCertificationAttempt(Trigger.new);
        }
        when AFTER_UPDATE, AFTER_INSERT {
            CertificationAttempTriggerHandler.grantInstructorSharingAccess(Trigger.new, Trigger.oldMap, Trigger.isInsert, Trigger.isUpdate);
            CertificationAttempTriggerHandler.createCertificationHeld(Trigger.new, Trigger.oldMap);
        }
    }
}