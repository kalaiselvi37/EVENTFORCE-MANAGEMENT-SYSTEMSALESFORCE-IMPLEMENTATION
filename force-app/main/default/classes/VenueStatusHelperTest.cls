@IsTest
private class VenueStatusHelperTest {
    @IsTest
    static void confirmedEventReservesVenue() {
        Venue__c venue = new Venue__c(
            Name = 'Test Venue',
            Capacity__c = 100,
            Availability_Status__c = 'Available'
        );
        insert venue;

        Client__c client = new Client__c(
            Name = 'Test Client',
            Email__c = 'client@example.com'
        );
        insert client;

        Event__c eventRecord = new Event__c(
            Name = 'Test Event',
            Event_Date__c = Date.today().addDays(10),
            Event_Type__c = 'Wedding',
            Event_Status__c = 'Confirmed',
            Client__c = client.Id,
            Venue__c = venue.Id
        );
        insert eventRecord;

        venue = [SELECT Availability_Status__c FROM Venue__c WHERE Id = :venue.Id];
        System.assertEquals('Reserved', venue.Availability_Status__c);
    }

    @IsTest
    static void canceledEventReleasesVenue() {
        Venue__c venue = new Venue__c(
            Name = 'Test Venue 2',
            Capacity__c = 100,
            Availability_Status__c = 'Reserved'
        );
        insert venue;

        Event__c eventRecord = new Event__c(
            Name = 'Canceled Event',
            Event_Date__c = Date.today().addDays(10),
            Event_Type__c = 'Birthday',
            Event_Status__c = 'Canceled',
            Venue__c = venue.Id
        );
        insert eventRecord;

        venue = [SELECT Availability_Status__c FROM Venue__c WHERE Id = :venue.Id];
        System.assertEquals('Available', venue.Availability_Status__c);
    }
}
