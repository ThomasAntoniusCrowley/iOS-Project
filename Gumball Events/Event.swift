//
//  Event.swift
//  Event object class for storing & retrieving event information
//
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
    var start_time: String = ""
    var venue_id: String = ""
    var venue_url: String = ""
    var venue_address: String = ""
    var city_name: String = ""
    var country_name: String = ""
    var latitude: Double = 0
    var longitude: Double = 0
    
    //Returns string description of event
    var description: String
    {
        return "\(id)/\(title) is occuring at \(venue_address)"
    }
    
    //Returns tuple in the form of (lat,long)
    func getLatLong()->(Double, Double)
    {
        return (latitude, longitude)
    }
    
    //Returns string containing venue information
    func getVenueInfo()->String
    {
        return "The Venue information: \nID: \(id) \nWeb Address: \(venue_url) \nEvent Address: \(venue_address)"
    }
    
    //Returns class variables as dictionary
    func getDict() -> [String: Any]
    {
        var eventDict = [String: Any]()
        
        eventDict["id"] = id
        eventDict["url"] = url
        eventDict["title"] = title
        eventDict["start_time"] = start_time
        eventDict["venue_id"] = venue_id
        eventDict["venue_url"] = venue_url
        eventDict["venue_address"] = venue_address
        eventDict["city_name"] = city_name
        eventDict["country_name"] = country_name
        eventDict["latitude"] = latitude
        eventDict["longitude"] = longitude
        
        return eventDict
    }

    //Initialiser for stored variables
    init(eventID: String, URLAddress: String, eventTitle: String, eventStartTime: String,
         venueID: String, venueURL: String, venueAddress: String, cityName: String, country: String,
         latitude: Double, longitude: Double)
    {
        self.id = eventID
        self.url = URLAddress
        self.title = eventTitle
        self.start_time = eventStartTime
        self.venue_id = venueID
        self.venue_url = venueURL
        self.venue_address = venueAddress
        self.city_name = cityName
        self.country_name = country
        self.latitude = latitude
        self.longitude = longitude
    }
}
