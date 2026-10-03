# EventForce Management System – Salesforce

Salesforce DX project based on the **EVENTFORCE MANAGEMENT SYSTEM – SALESFORCE IMPLEMENTATION** document.

## Included

- Event, Client, Vendor, Venue, Feedback and EventVendor custom objects
- Event/Venue/Client relationships
- Venue status automation
- Venue double-booking prevention
- Batch Apex to mark past events as Completed
- Schedulable Apex
- Apex test classes
- Event budget formula
- Client email validation rule
- Basic object tabs and metadata

## Main Apex Components

- `VenueStatusHelper`
- `EventTrigger13`
- `PreventDoubleBooking`
- `BatchCompleteEvents`
- `ScheduleCompleteEvents`

## Deploy

Authenticate to a Salesforce org:

```bash
sf org login web --alias EventForce
```

Deploy:

```bash
sf project deploy start --source-dir force-app/main/default --target-org EventForce
```

Run tests:

```bash
sf apex run test --target-org EventForce --test-level RunLocalTests --wait 10
```

## Notes

The source document also describes Flow, Approval Process, Profiles/Roles/Permission Sets, Sharing Rules, Reports, Dashboard and Lightning App configuration. Those Salesforce configuration items are represented only where practical as source metadata in this starter Git repository; some are normally created/managed directly in Setup.
