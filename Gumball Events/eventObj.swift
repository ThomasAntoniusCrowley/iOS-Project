//
//  eventObj.swift
//  Gumball Events
//
//  Created by Thomas Crowley [sc14talc] on 04/12/2016.
//  Copyright © 2016 Thomas Crowley [sc14talc]. All rights reserved.
//
import Foundation
class Event: CustomStringConvertible
{
    var id: String = ""
    var url: String = ""
    var title: String = ""
//    var event_description: String = ""
    var start_time: String = ""
//    var stop_time: String = ""
    var venue_id: String = ""
    var venue_url: String = ""
//    var venue_display: String = ""
    var venue_address: String = ""
    var city_name: String = ""
    var region_name: String = ""
    var region_abbr: String = ""
    var postal_code: String = ""
    var country_name: String = ""
//    var all_day: Int = 0
    var latitude: Float = 0
    var longitude: Float = 0
//    var geocode_type: String = ""
//    var trackback_count: Int = 0
//    var calendar_count: Int = 0
//    var comment_count: Int = 0
//    var link_count: Int = 0
//    var created: String = ""
//    var owner: String = ""
//    var modified: String = ""
    
    var description: String
    {
        return "\(id)/\(title) is occuring at \(venue_address)"
    }
    func getLatLong()->(Float, Float)
    {
        /**
         this returns a tuple with in the form (lat,long)
         */
        return (latitude, longitude)
    }
    func getVenueInfo()->String
    {
        /**
         this returns a string containing information about the venue
         */
        return "The Venue information: \nID: \(id) \nWeb Address: \(venue_url) \nEvent Address: \(venue_address)"
    }
    init(eventID: String, URLAddress: String, eventTitle: String, eventStartTime: String,
         venueID: String, venueURL: String, venueAddress: String, cityName: String,
         regionName: String, regionAbbr: String, postCode: String, country: String,
         latitude: Float, longitude: Float)
    {
        self.id = eventID
        self.url = URLAddress
        self.title = eventTitle
//        self.event_description = eventDescription
        self.start_time = eventStartTime
//        self.stop_time = eventEndTime
        self.venue_id = venueID
        self.venue_url = venueURL
//        self.venue_display = venueDisplay
        self.venue_address = venueAddress
        self.city_name = cityName
        self.region_name = regionName
        self.region_abbr = regionAbbr
        self.postal_code = postCode
        self.country_name = country
//        self.all_day = allDayFlag
        self.latitude = latitude
        self.longitude = longitude
//        self.geocode_type = geocodeType
//        self.trackback_count = trackbackCount
//        self.calendar_count = calendarCount
//        self.comment_count = commentCount
//        self.link_count = linkCount
//        self.created = creationDate
//        self.owner = eventOwner
//        self.modified = modified
    }
}
// let testEvent: Event = Event(eventID: "the ID", URLAddress: "web address", eventTitle: "The Big Event",
//         eventDescription: "something is happening somewhere", eventStartTime: "starts when it starts", eventEndTime: "ends when it ends",
//       venueID: "the venue has an idea too", venueURL: "venue web address", venueDisplay: "venue display",
//     venueAddress: "the venue address", cityName: "Leeds", regionName: "yorkshire", regionAbbr: "LDS",
//   postCode: "LS3", country: "UK", allDayFlag: 1, latitude: 53.800755, longitude: -1.549077,
// geocodeType: "geocode", trackbackCount: 42, calendarCount: 134, commentCount: 12,
// linkCount: 14, creationDate: "it was made on this date", eventOwner: "it's my event", modified: "never modified")
// 
// 
// print(testEvent.description)
// let latLong = testEvent.getLatLong()
// let eventString = testEvent.getVenueInfo()
// 
// print(latLong)
// print(eventString)
