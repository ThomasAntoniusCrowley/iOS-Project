//
//  EventsStream.swift
//  Class for handling Eventful API connection & data retrieval
//
//  Gumball Events
//
//  Created by Thomas Crowley [sc14talc] on 03/12/2016.
//  Copyright © 2016 Thomas Crowley [sc14talc]. All rights reserved.
//

import Foundation
let key = "2Qm4LQs466gpMpnV"

class EventsStream: CustomStringConvertible
{
    var city: String = ""
    var date: String = ""
    var keywords: String = ""
    var category: String = ""
    var total_items: Int = 0
    var page_size: Int = 0
    var page_count: Int = 0
    var page_number: Int = 0
    var page_items: Int = 0
    var first_item: Int = 0
    var last_item: Int = 0
    var search_time: Float = 0
    var events: [Event] = []
    var semaphore: DispatchSemaphore
    var baseAddr: String = "http://api.eventful.com/json/events/search?app_key=2Qm4LQs466gpMpnV&"
    var baseURL: URL? // = URL(string: "")!
    
    //Returns number of local events
    var description: String{
      return "There are \(total_items) events near you"
    }

    //Returns event stream URL
    func getURL(){
        self.baseAddr = baseAddr + "location=\(city)&date=\(date)&q=\(keywords)&c=\(category)"
        self.baseURL = URL(string: baseAddr)!
    }

    func getTheHeader(){
        
        //Configure connection
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        print("Set up session")

        //create asynchronous task to pull JSON data
        let eventTask = session.dataTask(with: baseURL!, completionHandler: {
            (body, response, error) in

            print(response)
            if error != nil {
                print("Error: " + error!.localizedDescription)
            } else {
                do {

                    //Attempt to pull JSON event data stream
                    if let json = try JSONSerialization.jsonObject(with: body!, options: .allowFragments) as? [String: Any] {
                        
                        print(json)
                        
                        //Parse header data from JSON string
                        let total_items_str = (json["total_items"] as? String)!
                        print ("this is what you are looking for\n\n")
                        print (total_items_str)
                        self.total_items = Int(total_items_str)!
                        let page_size_str = (json["page_size"] as? String)!
                        self.page_size = Int(page_size_str)!
                        let page_count_str = (json["page_count"] as? String)!
                        self.page_count = Int(page_count_str)!
                        let page_number_str = (json["page_number"] as? String)!
                        self.page_number = Int(page_number_str)!

                        //Alert UI to continue
                        self.semaphore.signal()
                    }
                } catch {
                    print("error in JSONSerialization")
                }
            }
        })
        
        //Start asynchronous task
        eventTask.resume()
    }
    
    
    func populateEventArray() {
        //Configure connection
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        print("Set up session")
        
        //Create asynchronous task to pull JSON data
        URLSession.shared.dataTask(with: baseURL!, completionHandler: {
            (body, response, error) in
            
            if error != nil {
                print("Error: " + error!.localizedDescription)
                
            } else {
                do {
                    //Attempt to pull JSON event data
                    let json = try JSONSerialization.jsonObject(with: body!, options: .allowFragments) as? NSDictionary
                    print("attempting to populate event array......")
                    var eventArr: [String: AnyObject] = json?["events"]! as! [String: AnyObject]
                    let jsonEventsArr = eventArr["event"]!
                    let arraySize = jsonEventsArr.count - 1
                    print("looping through all the events....")
                    
                    //Loop through event array
                    for i in 0...arraySize
                    {
                        //Place data in dictionary object
                        let jsonEvent:NSDictionary = (jsonEventsArr[i]! as! NSDictionary)
                   
                        let id: String = jsonEvent["id"]! as! String
                        let url: String = jsonEvent["url"]! as! String
                        let title: String = jsonEvent["title"]! as! String
                        let start_time: String = jsonEvent["start_time"]! as! String
                        let venue_id: String = jsonEvent["venue_id"]! as! String
                        let venue_url: String = jsonEvent["venue_url"]! as! String
                        let venue_address: String = jsonEvent["venue_address"]! as! String
                        let city_name: String = jsonEvent["city_name"]! as! String
                        let region_name: String = jsonEvent["region_name"]! as! String
                        let region_abbr: String = jsonEvent["region_abbr"]! as! String
                        let country_name: String = jsonEvent["country_name"]! as! String
                        let latitude: Float = Float(jsonEvent["latitude"]! as! String)!
                        let longitude: Float = Float(jsonEvent["longitude"]! as! String)!
                        
                        //Create event object from parsed data
                        let eventObj: Event = Event(eventID: id , URLAddress: url , eventTitle: title , eventStartTime: start_time , venueID: venue_id , venueURL: venue_url , venueAddress: venue_address , cityName: city_name , regionName: region_name , regionAbbr: region_abbr, country: country_name , latitude: latitude , longitude: longitude )
                        self.events.append(eventObj)
                    }
                    
                    print("events array has been populated and there are \(self.events.count) events near you")
                } catch {
                    print("error in JSONSerialization")
                }
            }
        //Start asynchronous task
        }).resume()
    }
    
    //initialise class variables
    init(Location: String, DateFilter: String, Keywords: String, Category: String, Semaphore: inout DispatchSemaphore) {
        
        //Create semaphore to alert UI when asynchronous tasks have completedt
        self.semaphore = Semaphore
        
        //Set query data
        self.city = Location
        self.date = DateFilter
        self.keywords = Keywords
        self.category = Category
        
        //Get data
        getURL()
        getTheHeader()
        populateEventArray()
        print(events.count)
    }
}
