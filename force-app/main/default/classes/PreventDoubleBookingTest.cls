@IsTest
private class PreventDoubleBookingTest {
    @IsTest
    static void preventsSameVenueSameDate() {
        Venue__c venue = new Venue__c(
            Name = 'Booked Venue',
            Capacity__c = 200,
            Availability_Status__c = 'Available'
        );
        insert venue;

        Date eventDate = Date.today().addDays(20);

        insert new Event__c(
            Name = 'First Event',
            Event_Date__c = eventDate,
            Event_Type__c = 'Corporate',
            Event_Status__c = 'Planned',
            Venue__c = venue.Id
        );

        Test.startTest();
        try {
            insert new Event__c(
                Name = 'Second Event',
                Event_Date__c = eventDate,
                Event_Type__c = 'Birthday',
                Event_Status__c = 'Planned',
                Venue__c = venue.Id
            );
            System.assert(false, 'Expected duplicate venue booking to fail.');
        } catch (DmlException e) {
            System.assert(e.getMessage().contains('This Venue is already booked on this date.'));
        }
        Test.stopTest();
    }
}
