# linebreaks and spaces added to JSON for better readability
(
  appointment => {
    json => decode_json(
      q|{
  "@odata.etag" : "W/\"PP69QQCyjk6IVymj2Vn+fQAAf8wlhA==\"",
  "id" : "AQMkADAwATNiZmYAZC1kNWUyLTM3YWMtMDACLTAwCgBGAAADzP-6Ram7CE_Oe1kNz0jifwcAPP69QQCyjk6IVymj2Vn_fQAAAgENAAAAPP69QQCyjk6IVymj2Vn_fQAAAH-DJTkAAAA=",
  "createdDateTime" : "2017-02-06T19:20:46.1071979Z",
  "lastModifiedDateTime" : "2017-02-06T21:57:57.1384495Z",
  "changeKey" : "PP69QQCyjk6IVymj2Vn+fQAAf8wlhA==",
  "categories" : [],
  "originalStartTimeZone" : "Greenwich Standard Time",
  "originalEndTimeZone" : "Greenwich Standard Time",
  "iCalUId" : "040000008200E00074C5B7101A82E0080000000000000000000000000000000000000000540000007643616C2D55696401000000303430303030303038323030453030303734433542373130314138324530303830303030303030304530453746374141423236384338303130303030303030303030303030303000",
  "reminderMinutesBeforeStart" : 720,
  "isReminderOn" : true,
  "hasAttachments" : false,
  "subject" : "Doctor M\u00fcller's Appointment",
  "bodyPreview" : "",
  "importance" : "high",
  "sensitivity" : "private",
  "isAllDay" : false,
  "isCancelled" : false,
  "isOrganizer" : true,
  "responseRequested" : false,
  "seriesMasterId" : null,
  "showAs" : "oof",
  "type" : "singleInstance",
  "webLink" : "https://outlook.live.com/owa/?itemid=AQMkADAwATNiZmYAZC1kNWUyLTM3YWMtMDACLTAwCgBGAAADzP%2F6Ram7CE%2BOe1kNz0jifwcAPP69QQCyjk6IVymj2Vn%2BfQAAAgENAAAAPP69QQCyjk6IVymj2Vn%2BfQAAAH%2FDJTkAAAA%3D&exvsurl=1&path=/calendar/item",
  "onlineMeetingUrl" : null,
  "responseStatus" : {
    "response" : "organizer",
    "time" : "0001-01-01T00:00:00Z"
  },
  "body" : {
    "contentType" : "html",
    "content" : ""
  },
  "start" : {
    "dateTime" : "2017-06-16T15:00:00.0000000",
    "timeZone" : "UTC"
  },
  "end" : {
    "dateTime" : "2017-06-16T16:00:00.0000000",
    "timeZone" : "UTC"
  },
  "location" : {
    "displayName" : "4567 Main St., Buffalo, NY 98052"
  },
  "recurrence" : null,
  "attendees" : [],
  "organizer" : {
    "emailAddress" : {
      "name" : "Cubulon Switzerland",
      "address" : "outlook_4F37DDBBF21200A5@outlook.com"
    }
  }
}|
    ),
    vevent => q|BEGIN:VEVENT
CLASS:PRIVATE
CREATED:20170206T192046Z
DESCRIPTION:
DTEND:20170616T160000Z
DTSTAMP:20170206T215757Z
DTSTART:20170616T150000Z
LAST-MODIFIED:20170206T215757Z
LOCATION:4567 Main St.\, Buffalo\, NY 98052
ORGANIZER;CN=Cubulon Switzerland:mailto:outlook_4F37DDBBF21200A5@outlook.co
 m
PRIORITY:1
SEQUENCE:0
SUMMARY:Doctor Müller's Appointment
TRANSP:OPAQUE
UID:040000008200E00074C5B7101A82E008000000000000000000000000000000000000000
 0540000007643616C2D5569640100000030343030303030303832303045303030373443354
 23731303141383245303038303030303030303045304537463741414232363843383031303
 03030303030303030303030303000
X-MICROSOFT-CDO-BUSYSTATUS:OOF
X-MICROSOFT-CDO-IMPORTANCE:2
BEGIN:VALARM
ACTION:DISPLAY
DESCRIPTION:Reminder
TRIGGER:-PT720M
END:VALARM
END:VEVENT|,
  },
  meeting => {
    json => decode_json(
      q|{
  "@odata.etag" : "W/\"PP69QQCyjk6IVymj2Vn+fQAAf8wliA==\"",
  "id" : "AQMkADAwATNiZmYAZC1kNWUyLTM3YWMtMDACLTAwCgBGAAADzP-6Ram7CE_Oe1kNz0jifwcAPP69QQCyjk6IVymj2Vn_fQAAAgENAAAAPP69QQCyjk6IVymj2Vn_fQAAAH-DJTsAAAA=",
  "createdDateTime" : "2017-02-06T19:31:09.2009511Z",
  "lastModifiedDateTime" : "2017-04-21T08:03:06.5467642Z",
  "changeKey" : "PP69QQCyjk6IVymj2Vn+fQAAf8wliA==",
  "categories" : [],
  "originalStartTimeZone" : "Greenwich Standard Time",
  "originalEndTimeZone" : "Greenwich Standard Time",
  "iCalUId" : "040000008200E00074C5B7101A82E0080000000000000000000000000000000000000000540000007643616C2D55696401000000303430303030303038323030453030303734433542373130314138324530303830303030303030304230434638303133423436384338303130303030303030303030303030303000",
  "reminderMinutesBeforeStart" : 15,
  "isReminderOn" : true,
  "hasAttachments" : false,
  "subject" : "Fabrikam status meeting",
  "bodyPreview" : "",
  "importance" : "high",
  "sensitivity" : "normal",
  "isAllDay" : false,
  "isCancelled" : false,
  "isOrganizer" : false,
  "responseRequested" : true,
  "seriesMasterId" : null,
  "showAs" : "busy",
  "type" : "singleInstance",
  "webLink" : "https://outlook.live.com/owa/?itemid=AQMkADAwATNiZmYAZC1kNWUyLTM3YWMtMDACLTAwCgBGAAADzP%2F6Ram7CE%2BOe1kNz0jifwcAPP69QQCyjk6IVymj2Vn%2BfQAAAgENAAAAPP69QQCyjk6IVymj2Vn%2BfQAAAH%2FDJTsAAAA%3D&exvsurl=1&path=/calendar/item",
  "onlineMeetingUrl" : null,
  "responseStatus" : {
    "response" : "organizer",
    "time" : "0001-01-01T00:00:00Z"
  },
  "body" : {
    "contentType" : "html",
    "content" : ""
  },
  "start" : {
    "dateTime" : "2017-06-19T17:00:00.0000000",
    "timeZone" : "UTC"
  },
  "end" : {
    "dateTime" : "2017-06-19T18:00:00.0000000",
    "timeZone" : "UTC"
  },
  "location" : {
    "displayName" : "Conference Room 234"
  },
  "recurrence" : null,
  "attendees" : [ {
    "type" : "required",
    "status" : {
      "response" : "none",
      "time" : "0001-01-01T00:00:00Z"
    },
    "emailAddress" : {
      "name" : "S. Ito",
      "address" : "sito@contoso.com"
    }
  }, {
    "type" : "required",
    "status" : {
      "response" : "none",
      "time" : "0001-01-01T00:00:00Z"
    },
    "emailAddress" : {
      "name" : "P. Cook",
      "address" : "pcook@contoso.com"
    }
  }, {
    "type" : "required",
    "status" : {
      "response" : "none",
      "time" : "0001-01-01T00:00:00Z"
    },
    "emailAddress" : {
      "name" : "A. Weiler",
      "address" : "aweiler@contoso.com"
    }
  } ],
  "organizer" : {
    "emailAddress" : {
      "name" : "Elizabeth Andersen",
      "address" : "eandersen@contoso.com"
    }
  }
}|
    ),
    vevent => q|BEGIN:VEVENT
ATTENDEE;CN=S. Ito;RSVP=TRUE:mailto:sito@contoso.com
ATTENDEE;CN=P. Cook;RSVP=TRUE:mailto:pcook@contoso.com
ATTENDEE;CN=A. Weiler;RSVP=TRUE:mailto:aweiler@contoso.com
CLASS:PUBLIC
CREATED:20170206T193109Z
DESCRIPTION:
DTEND:20170619T180000Z
DTSTAMP:20170421T080306Z
DTSTART:20170619T170000Z
LAST-MODIFIED:20170421T080306Z
LOCATION:Conference Room 234
ORGANIZER;CN=Elizabeth Andersen:mailto:eandersen@contoso.com
PRIORITY:1
SEQUENCE:0
SUMMARY:Fabrikam status meeting
TRANSP:OPAQUE
UID:040000008200E00074C5B7101A82E008000000000000000000000000000000000000000
 0540000007643616C2D5569640100000030343030303030303832303045303030373443354
 23731303141383245303038303030303030303042304346383031334234363843383031303
 03030303030303030303030303000
X-MICROSOFT-CDO-BUSYSTATUS:BUSY
X-MICROSOFT-CDO-IMPORTANCE:2
BEGIN:VALARM
ACTION:DISPLAY
DESCRIPTION:Reminder
TRIGGER:-PT15M
END:VALARM
END:VEVENT|,
  },
  monthly => {
    json => decode_json(
      q|{
  "@odata.etag" : "W/\"PP69QQCyjk6IVymj2Vn+fQAAgO1vNQ==\"",
  "id" : "AQMkADAwATNiZmYAZC1kNWUyLTM3YWMtMDACLTAwCgBGAAADzP-6Ram7CE_Oe1kNz0jifwcAPP69QQCyjk6IVymj2Vn_fQAAAgENAAAAPP69QQCyjk6IVymj2Vn_fQAAAIDkUxEAAAA=",
  "createdDateTime" : "2017-04-22T14:25:55.0219286Z",
  "lastModifiedDateTime" : "2017-04-22T14:25:55.0839792Z",
  "changeKey" : "PP69QQCyjk6IVymj2Vn+fQAAgO1vNQ==",
  "categories" : [],
  "originalStartTimeZone" : "W. Europe Standard Time",
  "originalEndTimeZone" : "W. Europe Standard Time",
  "iCalUId" : "040000008200E00074C5B7101A82E008000000004282265A74BBD2010000000000000000100000005C290D58DA347947831984F2DEC67F97",
  "reminderMinutesBeforeStart" : 15,
  "isReminderOn" : true,
  "hasAttachments" : false,
  "subject" : "Monthly Meeting",
  "bodyPreview" : "",
  "importance" : "normal",
  "sensitivity" : "normal",
  "isAllDay" : false,
  "isCancelled" : false,
  "isOrganizer" : true,
  "responseRequested" : true,
  "seriesMasterId" : null,
  "showAs" : "busy",
  "type" : "seriesMaster",
  "webLink" : "https://outlook.live.com/owa/?itemid=AQMkADAwATNiZmYAZC1kNWUyLTM3YWMtMDACLTAwCgBGAAADzP%2F6Ram7CE%2BOe1kNz0jifwcAPP69QQCyjk6IVymj2Vn%2BfQAAAgENAAAAPP69QQCyjk6IVymj2Vn%2BfQAAAIDkUxEAAAA%3D&exvsurl=1&path=/calendar/item",
  "onlineMeetingUrl" : null,
  "responseStatus" : {
    "response" : "organizer",
    "time" : "0001-01-01T00:00:00Z"
  },
  "body" : {
    "contentType" : "html",
    "content" : "<html>\r\n<head>\r\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\r\n<meta content=\"text/html; charset=us-ascii\">\r\n<style type=\"text/css\" style=\"display:none\">\r\n<!--\r\np\r\n\t{margin-top:0;\r\n\tmargin-bottom:0}\r\n-->\r\n</style>\r\n</head>\r\n<body dir=\"ltr\">\r\n<div id=\"divtagdefaultwrapper\" dir=\"ltr\" style=\"font-size:12pt; color:#000000; font-family:Calibri,Arial,Helvetica,sans-serif\">\r\n<p><br>\r\n</p>\r\n</div>\r\n</body>\r\n</html>\r\n"
  },
  "start" : {
    "dateTime" : "2017-06-05T07:00:00.0000000",
    "timeZone" : "UTC"
  },
  "end" : {
    "dateTime" : "2017-06-05T07:30:00.0000000",
    "timeZone" : "UTC"
  },
  "location" : {
    "displayName" : "Meeting Room 488"
  },
  "recurrence" : {
    "pattern" : {
      "type" : "relativeMonthly",
      "interval" : 1,
      "month" : 0,
      "dayOfMonth" : 0,
      "daysOfWeek" : [ "monday" ],
      "firstDayOfWeek" : "sunday",
      "index" : "first"
    },
    "range" : {
      "type" : "endDate",
      "startDate" : "2017-06-05",
      "endDate" : "2017-12-31",
      "recurrenceTimeZone" : "W. Europe Standard Time",
      "numberOfOccurrences" : 0
    }
  },
  "attendees" : [],
  "organizer" : {
    "emailAddress" : {
      "name" : "Cubulon Switzerland",
      "address" : "outlook_4F37DDBBF21200A5@outlook.com"
    }
  }
}|
    ),
    vevent => q|BEGIN:VEVENT
CLASS:PUBLIC
CREATED:20170422T142555Z
DESCRIPTION:
DTEND:20170605T073000Z
DTSTAMP:20170422T142555Z
DTSTART:20170605T070000Z
LAST-MODIFIED:20170422T142555Z
LOCATION:Meeting Room 488
ORGANIZER;CN=Cubulon Switzerland:mailto:outlook_4F37DDBBF21200A5@outlook.co
 m
PRIORITY:1
RRULE:FREQ=MONTHLY;BYDAY=MO
SEQUENCE:0
SUMMARY:Monthly Meeting
TRANSP:OPAQUE
UID:040000008200E00074C5B7101A82E008000000004282265A74BBD201000000000000000
 0100000005C290D58DA347947831984F2DEC67F97
X-MICROSOFT-CDO-BUSYSTATUS:BUSY
X-MICROSOFT-CDO-IMPORTANCE:1
BEGIN:VALARM
ACTION:DISPLAY
DESCRIPTION:Reminder
TRIGGER:-PT15M
END:VALARM
END:VEVENT|,
  },
  weekly => {
    json => decode_json(
      q|{
  "@odata.etag" : "W/\"PP69QQCyjk6IVymj2Vn+fQAAf8wlgw==\"",
  "id" : "AQMkADAwATNiZmYAZC1kNWUyLTM3YWMtMDACLTAwCgBGAAADzP-6Ram7CE_Oe1kNz0jifwcAPP69QQCyjk6IVymj2Vn_fQAAAgENAAAAPP69QQCyjk6IVymj2Vn_fQAAAH-DJTgAAAA=",
  "createdDateTime" : "2017-02-06T19:19:19.013445Z",
  "lastModifiedDateTime" : "2017-02-06T21:57:57.0446964Z",
  "changeKey" : "PP69QQCyjk6IVymj2Vn+fQAAf8wlgw==",
  "categories" : [],
  "originalStartTimeZone" : "tzone://Microsoft/Custom",
  "originalEndTimeZone" : "tzone://Microsoft/Custom",
  "iCalUId" : "040000008200E00074C5B7101A82E0080000000000000000000000000000000000000000540000007643616C2D55696401000000303430303030303038323030453030303734433542373130314138324530303830303030303030304330464530433430423236384338303130303030303030303030303030303000",
  "reminderMinutesBeforeStart" : 0,
  "isReminderOn" : false,
  "hasAttachments" : false,
  "subject" : "Lunch",
  "bodyPreview" : "",
  "importance" : "normal",
  "sensitivity" : "normal",
  "isAllDay" : false,
  "isCancelled" : false,
  "isOrganizer" : true,
  "responseRequested" : false,
  "seriesMasterId" : null,
  "showAs" : "tentative",
  "type" : "seriesMaster",
  "webLink" : "https://outlook.live.com/owa/?itemid=AQMkADAwATNiZmYAZC1kNWUyLTM3YWMtMDACLTAwCgBGAAADzP%2F6Ram7CE%2BOe1kNz0jifwcAPP69QQCyjk6IVymj2Vn%2BfQAAAgENAAAAPP69QQCyjk6IVymj2Vn%2BfQAAAH%2FDJTgAAAA%3D&exvsurl=1&path=/calendar/item",
  "onlineMeetingUrl" : null,
  "responseStatus" : {
    "response" : "organizer",
    "time" : "0001-01-01T00:00:00Z"
  },
  "body" : {
    "contentType" : "html",
    "content" : ""
  },
  "start" : {
    "dateTime" : "2017-06-16T11:30:00.0000000",
    "timeZone" : "UTC"
  },
  "end" : {
    "dateTime" : "2017-06-16T13:00:00.0000000",
    "timeZone" : "UTC"
  },
  "location" : {
    "displayName" : "",
    "address" : {}
  },
  "recurrence" : {
    "pattern" : {
      "type" : "weekly",
      "interval" : 1,
      "month" : 0,
      "dayOfMonth" : 0,
      "daysOfWeek" : [ "monday", "tuesday", "wednesday", "thursday",
          "friday" ],
      "firstDayOfWeek" : "monday",
      "index" : "first"
    },
    "range" : {
      "type" : "numbered",
      "startDate" : "2017-06-16",
      "endDate" : "0001-01-01",
      "recurrenceTimeZone" : "",
      "numberOfOccurrences" : 5
    }
  },
  "attendees" : [],
  "organizer" : {
    "emailAddress" : {
      "name" : "Cubulon Switzerland",
      "address" : "outlook_4F37DDBBF21200A5@outlook.com"
    }
  }
}|
    ),
    vevent => q|BEGIN:VEVENT
CLASS:PUBLIC
CREATED:20170206T191919Z
DESCRIPTION:
DTEND:20170616T130000Z
DTSTAMP:20170206T215757Z
DTSTART:20170616T113000Z
LAST-MODIFIED:20170206T215757Z
ORGANIZER;CN=Cubulon Switzerland:mailto:outlook_4F37DDBBF21200A5@outlook.co
 m
PRIORITY:1
RRULE:FREQ=WEEKLY;COUNT=5;BYDAY=MO,TU,WE,TH,FR
SEQUENCE:0
SUMMARY:Lunch
TRANSP:OPAQUE
UID:040000008200E00074C5B7101A82E008000000000000000000000000000000000000000
 0540000007643616C2D5569640100000030343030303030303832303045303030373443354
 23731303141383245303038303030303030303043304645304334304232363843383031303
 03030303030303030303030303000
X-MICROSOFT-CDO-BUSYSTATUS:TENTATIVE
X-MICROSOFT-CDO-IMPORTANCE:1
END:VEVENT|,
  },
  yearly => {
    json => decode_json(
      q|{
  "@odata.etag" : "W/\"PP69QQCyjk6IVymj2Vn+fQAAgO1vNA==\"",
  "id" : "AQMkADAwATNiZmYAZC1kNWUyLTM3YWMtMDACLTAwCgBGAAADzP-6Ram7CE_Oe1kNz0jifwcAPP69QQCyjk6IVymj2Vn_fQAAAgENAAAAPP69QQCyjk6IVymj2Vn_fQAAAIDkUxAAAAA=",
  "createdDateTime" : "2017-04-22T14:21:10.1880165Z",
  "lastModifiedDateTime" : "2017-04-22T14:21:10.3851774Z",
  "changeKey" : "PP69QQCyjk6IVymj2Vn+fQAAgO1vNA==",
  "categories" : [],
  "originalStartTimeZone" : "UTC",
  "originalEndTimeZone" : "UTC",
  "iCalUId" : "040000008200E00074C5B7101A82E00800000000B17460B073BBD201000000000000000010000000350914BA43BF9046A2D2DBF621FD7125",
  "reminderMinutesBeforeStart" : 15,
  "isReminderOn" : false,
  "hasAttachments" : false,
  "subject" : "D-Day Memorial",
  "bodyPreview" : "",
  "importance" : "normal",
  "sensitivity" : "normal",
  "isAllDay" : true,
  "isCancelled" : false,
  "isOrganizer" : true,
  "responseRequested" : true,
  "seriesMasterId" : null,
  "showAs" : "free",
  "type" : "seriesMaster",
  "webLink" : "https://outlook.live.com/owa/?itemid=AQMkADAwATNiZmYAZC1kNWUyLTM3YWMtMDACLTAwCgBGAAADzP%2F6Ram7CE%2BOe1kNz0jifwcAPP69QQCyjk6IVymj2Vn%2BfQAAAgENAAAAPP69QQCyjk6IVymj2Vn%2BfQAAAIDkUxAAAAA%3D&exvsurl=1&path=/calendar/item",
  "onlineMeetingUrl" : null,
  "responseStatus" : {
    "response" : "organizer",
    "time" : "0001-01-01T00:00:00Z"
  },
  "body" : {
    "contentType" : "html",
    "content" : "<html>\r\n<head>\r\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\r\n<meta content=\"text/html; charset=us-ascii\">\r\n<style type=\"text/css\" style=\"display:none\">\r\n<!--\r\np\r\n\t{margin-top:0;\r\n\tmargin-bottom:0}\r\n-->\r\n</style>\r\n</head>\r\n<body dir=\"ltr\">\r\n<div id=\"divtagdefaultwrapper\" dir=\"ltr\" style=\"font-size:12pt; color:#000000; font-family:Calibri,Arial,Helvetica,sans-serif\">\r\n<p><br>\r\n</p>\r\n</div>\r\n</body>\r\n</html>\r\n"
  },
  "start" : {
    "dateTime" : "2016-06-06T00:00:00.0000000",
    "timeZone" : "UTC"
  },
  "end" : {
    "dateTime" : "2016-06-07T00:00:00.0000000",
    "timeZone" : "UTC"
  },
  "location" : {
    "displayName" : "",
    "address" : {}
  },
  "recurrence" : {
    "pattern" : {
      "type" : "absoluteYearly",
      "interval" : 1,
      "month" : 6,
      "dayOfMonth" : 6,
      "firstDayOfWeek" : "sunday",
      "index" : "first"
    },
    "range" : {
      "type" : "endDate",
      "startDate" : "2016-06-06",
      "endDate" : "2018-06-04",
      "recurrenceTimeZone" : "W. Europe Standard Time",
      "numberOfOccurrences" : 0
    }
  },
  "attendees" : [],
  "organizer" : {
    "emailAddress" : {
      "name" : "Cubulon Switzerland",
      "address" : "outlook_4F37DDBBF21200A5@outlook.com"
    }
  }
}|
    ),
    vevent => q|BEGIN:VEVENT
CLASS:PUBLIC
CREATED:20170422T142110Z
DESCRIPTION:
DTEND;VALUE=DATE:20160607
DTSTAMP:20170422T142110Z
DTSTART;VALUE=DATE:20160606
LAST-MODIFIED:20170422T142110Z
ORGANIZER;CN=Cubulon Switzerland:mailto:outlook_4F37DDBBF21200A5@outlook.co
 m
PRIORITY:1
RRULE:FREQ=YEARLY;BYMONTHDAY=6;BYMONTH=6
SEQUENCE:0
SUMMARY:D-Day Memorial
TRANSP:TRANSPARENT
UID:040000008200E00074C5B7101A82E00800000000B17460B073BBD201000000000000000
 010000000350914BA43BF9046A2D2DBF621FD7125
X-MICROSOFT-CDO-BUSYSTATUS:FREE
X-MICROSOFT-CDO-IMPORTANCE:1
END:VEVENT|,
  },
);
