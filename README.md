# myDid Status Page - Creating issue files
This documentation is for internal Communication and IT Teams.
Its goal is to help to quickly create an issue and update the status page at https://mydidstatus.com

## Auto-update
The machine at mydidstatus.com will automagically pull this repository, build site with Hugo and update the status page every one or two minutes.
So all modifications here are automated, for better and quicker communication when there are issues or maintenance planned.

## Issue file names and location

Issue files must be created in the `content/issue` folder in this repository.

You **must** name issues with filenames like `YYYY-MM-DD-NMBR.md`.

`NMBR` being the number of the issue in the day.

Example:
`2023-07-10-0001.md` refers to the first (`0001`) issue on July, 10th 2023.

## Declared systems (things that are referenced in cState page)

```yaml
affected:
  - Main APIs
  - Demo
  - Blockchain synchronization
  - Discord bot
  - Nostr relay
  - Android application
  - iOS application
  - Issuer dashboard
  - Website
  - Helpdesk
  - Support
  - Automated email server
  - Main email server
```

## Template: notice (when doing maintenance for example)

This is an example for declaring a maintenance on the status page.

```
---
title: Test - Planned maintenance
date: 2023-07-12 9:00:00
resolved: false
resolvedWhen: 2023-07-12 10:00:00
severity: notice
affected:
  - Main APIs
  - Demo
  - Blockchain synchronization
  - Discord bot
  - Nostr relay
  - Android application
  - iOS application
  - Issuer dashboard
  - Website
  - Helpdesk
  - Support
  - Automated email server
  - Main email server
section: issue
---

*Maintenance* - We planned a small maintenance for some services. {{< track "2023-07-10 12:00:00" >}}

```


## Template: disrupted (maybe some issues for users)
This is an example for declaring an small/medium incident on the status page.

```
---
title: Test - Disruption in Nostr relay
date: 2023-07-12 9:00:00
resolved: false
resolvedWhen: 2023-07-12 10:00:00
severity: disrupted
affected:
  - Nostr relay
section: issue
---

*Investigating* - This is a demo issue, for us to test. {{< track "2023-07-10 12:00:00" >}}
```

## Template: down (service mostly or completely unavailable)
This is an example for declaring an small/medium incident on the status page.

```
---
title: Test - Support down
date: 2023-07-12 9:00:00
resolved: false
resolvedWhen: 2023-07-12 10:00:00
severity: down
affected:
  - Support
section: issue
---

*Investigating* - This is a demo issue, for us to test the status page. {{< track "2023-07-10 12:00:00" >}}
```


## Issue in details - Doc from cState

```
---
title: Major outage in East US
date: 2017-02-30 14:30:00
resolved: true
resolvedWhen: 2017-02-30 16:00:00
severity: down
affected:
  - API
section: post
---

*Monitoring* - After hitting the ole reboot button Example Chat App is now recovering. We’re going to continue to monitor as everyone reconnects. {{< track "2018-04-13 16:50:00" >}}

*Investigating* - We’re aware of users experiencing unavailable guilds and issues when attempting to connect. We’re currently investigating. {{< track "2018-04-13 15:54:00" >}}
```
Time to break that down.

- `title`: This is the one of the most important parts of an incident. **(required)**
- `date`: An ISO-8601 formatted date. Does not include time zone. This is when you first discovered the issue. **(required)**
- `resolved`: Whether issue should affect overall status. Either true or false. **(boolean, required)**
- `resolvedWhen`: An ISO-8601 formatted date. Does not include time zone. This is when downtime stopped. You may set the time that downtime ended without completely resolving the issue (thus leaving time for monitoring).
- `severity`: If an issue is not resolved, it will have an applied severity. There are 3 levels of severity: `notice`, `disrupted`, and `down`. If there are multiple issues, the status page will take the appearance of the more drastic issue (such as disrupted instead of notice). **(required)**
- `affected`: Add the items that were present in the config file which should alter the status of each individual system (component). **(array, required)**
- `section`. This must be issue, so that Hugo treats it as one. **(required)**
- `informational`: Makes issue look more like a blog post and removes any references to downtime length. (boolean, v4 onwards)

You may have also noticed that all this data is encapsulated within the bounds of three dashes `---`. Underneath that is some space for Markdown-formatted text. This is where you can detail the issue at hand and update your users on the status of the issue.

Apart from obvious Markdown formatting (like `*italic*`, `**bold**`), you can also embed dates using this shortcode: `{{< track "2018-04-13 15:54:00" >}}`. That is an ISO 8601 date. Keep in mind that you must define seconds.
