//  EventsAPI.swift
//  Gumball Events
//
//  Created by Thomas Crowley [sc14talc] on 03/12/2016.
//  Copyright © 2016 Thomas Crowley [sc14talc]. All rights reserved.
//

import Foundation
let key = "2Qm4LQs466gpMpnV"

class EventsStream: CustomStringConvertible
{
    
//    TODO: fix the class so it actually works
    var city: String = ""
    var date: String = ""
    var keywords: String = ""
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
    
    var description: String
    {
      return "There are \(total_items) events near you"
    }

    func getURL()
    {
//        var baseURL = URL(string: "http://api.eventful.com/json/events/search?app_key=2Qm4LQs466gpMpnV&location=San+Diego&date=Futureo&q=music")!
        
        self.baseAddr = baseAddr + "location=\(city)&date=\(date)&q=\(keywords)"
        self.baseURL = URL(string: baseAddr)!
    }
  func getResponse()
  {
      let config = URLSessionConfiguration.default
      let session = URLSession(configuration: config)
    
      print("Set up session")

      let eventTask = session.dataTask(with: baseURL!, completionHandler: {
          (body, response, error) in

          print(response)
          if error != nil {

              print("Error: " + error!.localizedDescription)
          } else {

              do {

                  if let json = try JSONSerialization.jsonObject(with: body!, options: .allowFragments) as? [String: Any] {
//                      print(json)
                  }
              } catch {

                  print("error in JSONSerialization")
              }
          }
      })
      eventTask.resume()
  }



 func getTheHeader()
     {
         let config = URLSessionConfiguration.default
         let session = URLSession(configuration: config)
        
         print("Set up session")

         //        var total_items: Int = 123456789
         let eventTask = session.dataTask(with: baseURL!, completionHandler: {
             (body, response, error) in

             print(response)
             if error != nil {

                 print("Error: " + error!.localizedDescription)
             } else {

                 do {

                     if let json = try JSONSerialization.jsonObject(with: body!, options: .allowFragments) as? [String: Any] {
                                                 print(json)
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
//                        TODO: fix this so it runs properly
//                        let page_items_str = json["page_items"] as? String)!
//                        self.page_items = Int(page_items_str)!
//                        let first_item_str = (json["first_item"] as? String)!
//                        self.first_item = Int(first_item_str)!
//                        let last_item_str = (json["last_item"] as? String)!
//                        self.last_item = Int(last_item_str)!
//                        let search_time_str = (json["search_time"] as? String)!
//                        self.search_time = Float(search_time_str)!
                                               //                         self.last_item = (json["last_item"] as? Int)!
//                         self.search_time = (json["search_time"] as? Float)!

                        self.semaphore.signal()
                        
                    }
                 } catch {

                     print("error in JSONSerialization")
                 }
             }
         })
         eventTask.resume()
     }
    
    
    func populateEventArray()
    {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        print("Set up session")
        
        //        var total_items: Int = 123456789
        URLSession.shared.dataTask(with: baseURL!, completionHandler: {
            (body, response, error) in
            
            if error != nil {
                print("Error: " + error!.localizedDescription)
                
            } else {
                do {
                    let json = try JSONSerialization.jsonObject(with: body!, options: .allowFragments) as? NSDictionary
////                    print(json)
                    print("attempting to populate event array......")
                    var eventArr: [String: AnyObject] = json?["events"]! as! [String: AnyObject]
//                    eventArr = NSDictionary(eventArr)
//                        print(eventArr)
                    let jsonEventsArr = eventArr["event"]! //as! NSDictionary
                    let arraySize = jsonEventsArr.count - 1
                    print("looping through all the events....")
                    for i in 0...arraySize
                    {
                        let jsonEvent:NSDictionary = (jsonEventsArr[i]! as! NSDictionary)
//                        print(type(of: jsonEvent))
                   
                        let id: String = jsonEvent["id"]! as! String
                        let url: String = jsonEvent["url"]! as! String
                        let title: String = jsonEvent["title"]! as! String
//                        let event_description: String =  jsonEvent["description"]! as! String
                        let start_time: String = jsonEvent["start_time"]! as! String
//                        let stop_time: String = jsonEvent["stop_time"]! as! String
                        let venue_id: String = jsonEvent["venue_id"]! as! String
                        let venue_url: String = jsonEvent["venue_url"]! as! String
                        //    var venue_display: String = ""
                        let venue_address: String = jsonEvent["venue_address"]! as! String
                        let city_name: String = jsonEvent["city_name"]! as! String
                        let region_name: String = jsonEvent["region_name"]! as! String
                        let region_abbr: String = jsonEvent["region_abbr"]! as! String
                        let postal_code: String = jsonEvent["postal_code"]! as! String
                        let country_name: String = jsonEvent["country_name"]! as! String
//                        let all_day: Int = jsonEvent["all_day"]! as! Int
                        let latitude: Float = Float(jsonEvent["latitude"]! as! String)!
                        let longitude: Float = Float(jsonEvent["longitude"]! as! String)!

                        
                        
                        
//                        var geocode_type = jsonEvent["geocode_type"]!
//                        var trackback_count = jsonEvent["trackback_count"]!
//                        var calendar_count = jsonEvent["calendar_count"]!
//                        var comment_count = jsonEvent["comment_count"]!
//                        var link_count = jsonEvent["link_count"]!
//                        var created = jsonEvent["created"]!
//                        var owner = jsonEvent["owner"]!
//                        var modified = jsonEvent["modified"]!
                        let eventObj: Event = Event(eventID: id , URLAddress: url , eventTitle: title , eventStartTime: start_time , venueID: venue_id , venueURL: venue_url , venueAddress: venue_address , cityName: city_name , regionName: region_name , regionAbbr: region_abbr , postCode: postal_code , country: country_name , latitude: latitude , longitude: longitude )
//                        print("ding!!!\n")
                        self.events.append(eventObj)
                    }
                    
                    print("events array has been populated and there are \(self.events.count) events near you")
                    
//                    let jsonEvents:NSDictionary = jsonEventsArr[0]! as! NSDictionary
//                    print("the events are as follows.....")
//                    print(type(of:jsonEvents))
////                    print(jsonEventsArr.count)
//                    print(jsonEvents)
//                    print(".... end of the output")
//                    //print(json?["events"])
                } catch {
                    print("error in JSONSerialization")
                    
                }
            }
        }).resume()
    }
    


    init(Location: String, DateFilter: String, Keywords: String, Semaphore: inout DispatchSemaphore)
      {
        self.semaphore = Semaphore
//        self.getURL()
        self.city = Location
        self.date = DateFilter
        self.keywords = Keywords
        self.semaphore = Semaphore
//        getResponse()
        getURL()
        getTheHeader()
        populateEventArray()
      }

}


// let eventSt: EventsStream = EventsStream(Location: "somewhere", DateFilter: "Sometime", Keywords: "words")
// let num: Int = eventSt.getTotItems()
// print("this is the number of events")
// print(num)
