@isTest
private class Exercise3_Test {

    @testSetup
    static void setupTestData() {
        // Create standard Account for the Opportunity
        Account oppAcc = new Account(Name = 'Test Opp Account');
        insert oppAcc;

        // Create Competitor Accounts
        List<Account> competitorAccounts = new List<Account>{
            new Account(Name = 'Competitor Alpha'),
            new Account(Name = 'Competitor Beta')
        };
        insert competitorAccounts;

        // Create an Opportunity
        Opportunity opp = new Opportunity(
            Name = 'Test Opportunity',
            StageName = 'Prospecting',
            CloseDate = Date.today().addDays(30),
            AccountId = oppAcc.Id
        );
        insert opp;

        // Create a Quote linked to the Opportunity
        Quote q = new Quote(
            Name = 'Test Quote',
            OpportunityId = opp.Id
        );
        insert q;
    }

    @isTest
    static void testRule2_AutoCreateOppCompetitor() {
        // Retrieve setup data
        Quote q = [SELECT Id FROM Quote LIMIT 1];
        Account compAcc = [SELECT Id FROM Account WHERE Name = 'Competitor Alpha' LIMIT 1];
        Opportunity opp = [SELECT Id FROM Opportunity LIMIT 1];

        // Verify no competitors exist yet on the Opportunity
        List<Competitor__c> preOppComps = [SELECT Id FROM Competitor__c WHERE Opportunity__c = :opp.Id];
        Assert.areEqual(0, preOppComps.size(), 'Opportunity should not have competitors initially.');

        // Test Action: Insert a competitor linked to the Quote
        Competitor__c quoteComp = new Competitor__c(
            Quote__c = q.Id,
            Account__c = compAcc.Id
        );

        Test.startTest();
        insert quoteComp;
        Test.stopTest();

        // Verification: Rule 2 should automatically create a corresponding competitor on the Opportunity
        List<Competitor__c> postOppComps = [SELECT Id, Account__c FROM Competitor__c WHERE Opportunity__c = :opp.Id];
        Assert.areEqual(1, postOppComps.size(), 'Rule 2 failed: An Opportunity competitor should have been auto-created.');
        Assert.areEqual(compAcc.Id, postOppComps[0].Account__c, 'The auto-created competitor should match the Quote competitor account.');
    }

    @isTest
    static void testRule1_BlockDuplicateOnQuote() {
        Quote q = [SELECT Id FROM Quote LIMIT 1];
        Account compAcc = [SELECT Id FROM Account WHERE Name = 'Competitor Alpha' LIMIT 1];

        // Insert first competitor on the Quote safely
        Competitor__c firstComp = new Competitor__c(Quote__c = q.Id, Account__c = compAcc.Id);
        insert firstComp;

        // Test Action: Try to insert the EXACT SAME account on the same Quote again
        Competitor__c duplicateComp = new Competitor__c(Quote__c = q.Id, Account__c = compAcc.Id);

        Test.startTest();
        try {
            insert duplicateComp;
            Assert.fail('Rule 1 failed: The system allowed a duplicate account on the same Quote.');
        } catch (DmlException e) {
            // Verify that the trigger threw the custom validation error
            Assert.isTrue(e.getMessage().contains('already related to this specific quote'), 
                'Expected unique quote validation error message, but got: ' + e.getMessage());
        }
        Test.stopTest();
    }

    @isTest
    static void testRule1_BlockDuplicateOnOpportunity() {
        Opportunity opp = [SELECT Id FROM Opportunity LIMIT 1];
        Account compAcc = [SELECT Id FROM Account WHERE Name = 'Competitor Alpha' LIMIT 1];

        // Insert first competitor directly onto the Opportunity safely
        Competitor__c firstComp = new Competitor__c(Opportunity__c = opp.Id, Account__c = compAcc.Id);
        insert firstComp;

        // Test Action: Try to insert the EXACT SAME account on the same Opportunity again
        Competitor__c duplicateComp = new Competitor__c(Opportunity__c = opp.Id, Account__c = compAcc.Id);

        Test.startTest();
        try {
            insert duplicateComp;
            Assert.fail('Rule 1 failed: The system allowed a duplicate account on the same Opportunity.');
        } catch (DmlException e) {
            // Verify that the trigger threw the custom validation error
            Assert.isTrue(e.getMessage().contains('already related to this specific opportunity'), 
                'Expected unique opportunity validation error message, but got: ' + e.getMessage());
        }
        Test.stopTest();
    }

    @isTest
    static void testRule2_DoesNotDuplicateIfAlreadyExists() {
        Quote q = [SELECT Id FROM Quote LIMIT 1];
        Opportunity opp = [SELECT Id FROM Opportunity LIMIT 1];
        Account compAcc = [SELECT Id FROM Account WHERE Name = 'Competitor Alpha' LIMIT 1];

        // Pre-create the competitor directly on the Opportunity
        Competitor__c existingOppComp = new Competitor__c(Opportunity__c = opp.Id, Account__c = compAcc.Id);
        insert existingOppComp;

        // Test Action: Add the same competitor to the Quote. 
        // Rule 2 should try to sync it, but our guardrail should bypass it since it already exists on the Opp.
        Competitor__c quoteComp = new Competitor__c(Quote__c = q.Id, Account__c = compAcc.Id);

        Test.startTest();
        // This should pass cleanly without throwing a duplicate error because of our check in Rule 2
        insert quoteComp; 
        Test.stopTest();

        // Verification: Ensure there is still only exactly 1 competitor record on the Opportunity
        List<Competitor__c> finalOppComps = [SELECT Id FROM Competitor__c WHERE Opportunity__c = :opp.Id];
        Assert.areEqual(1, finalOppComps.size(), 'Rule 2 should have bypassed creation to avoid creating a duplicate on the Opportunity.');
    }
}
