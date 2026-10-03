trigger PreventDoubleBooking on Event__c (before insert, before update) {
    Set<Id> venueIds = new Set<Id>();

    for (Event__c ev : Trigger.new) {
        if (ev.Venue__c != null) {
            venueIds.add(ev.Venue__c);
        }
    }

    if (venueIds.isEmpty()) {
        return;
    }

    Map<Id, List<Event__c>> venueEventMap = new Map<Id, List<Event__c>>();

    for (Event__c existing : [
        SELECT Id, Venue__c, Event_Date__c
        FROM Event__c
        WHERE Venue__c IN :venueIds
    ]) {
        if (!venueEventMap.containsKey(existing.Venue__c)) {
            venueEventMap.put(existing.Venue__c, new List<Event__c>());
        }
        venueEventMap.get(existing.Venue__c).add(existing);
    }

    for (Event__c ev : Trigger.new) {
        if (ev.Venue__c == null || ev.Event_Date__c == null) {
            continue;
        }

        if (venueEventMap.containsKey(ev.Venue__c)) {
            for (Event__c existing : venueEventMap.get(ev.Venue__c)) {
                if (
                    existing.Id != ev.Id &&
                    existing.Event_Date__c == ev.Event_Date__c
                ) {
                    ev.addError('This Venue is already booked on this date.');
                }
            }
        }
    }
}
