@IsTest
private class BatchCompleteEventsTest {
    @IsTest
    static void marksPastEventsCompleted() {
        Event__c oldEvent = new Event__c(
            Name = 'Past Event',
            Event_Date__c = Date.today().addDays(-5),
            Event_Type__c = 'Other',
            Event_Status__c = 'Planned'
        );
        insert oldEvent;

        Test.startTest();
        Database.executeBatch(new BatchCompleteEvents(), 200);
        Test.stopTest();

        oldEvent = [
            SELECT Event_Status__c
            FROM Event__c
            WHERE Id = :oldEvent.Id
        ];
        System.assertEquals('Completed', oldEvent.Event_Status__c);
    }

    @IsTest
    static void schedulableRunsBatch() {
        Test.startTest();
        String jobId = System.schedule(
            'EventForce Test Schedule',
            '0 0 20 * * ?',
            new ScheduleCompleteEvents()
        );
        Test.stopTest();

        System.assertNotEquals(null, jobId);
    }
}
