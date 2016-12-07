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

    var description: String
    {
      return "There are \(total_items) events near you"
    }

  func getResponse()
  {
      let config = URLSessionConfiguration.default
      let session = URLSession(configuration: config)
      let baseURL = URL(string: "http://api.eventful.com/json/events/search?app_key=2Qm4LQs466gpMpnV&location=San+Diego&date=Futureo&q=music")!
      print("Set up session")

      let eventTask = session.dataTask(with: baseURL, completionHandler: {
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


//    func getTotItems()->Int
//    {
////        var total_items: Int = 69696969
//        let config = URLSessionConfiguration.default
//        let session = URLSession(configuration: config)
//        let baseURL = URL(string: "http://api.eventful.com/json/events/search?app_key=2Qm4LQs466gpMpnV&location=San+Diego&date=Futureo&q=music")!
//        print("Set up session")
//
//        let eventTask = session.dataTask(with: baseURL, completionHandler:
//          {
//            (body, response, error) in
//
//            print(response)
//            if error != nil {
//
//                print("Error: " + error!.localizedDescription)
//            }
//            else
//            {
//
//                do
//                {
//
//                    if let json = try JSONSerialization.jsonObject(with: body!, options: .allowFragments) as? [String: Any]
//                    {
////                        print(json)
//                        let total_items_str = (json["total_items"] as? String)!
//                        print ("this is what you are looking for\n\n")
//                        print (total_items_str)
//                        self.total_items = Int(total_items_str)!
//                    }
//                }
//                catch
//                {
//
//                    print("error in JSONSerialization")
//                }
//            }
//        })
//        eventTask.resume()
//
//        return total_items
//    }


//
 func getTheHeader()
     {
         let config = URLSessionConfiguration.default
         let session = URLSession(configuration: config)
         let baseURL = URL(string: "http://api.eventful.com/json/events/search?app_key=2Qm4LQs466gpMpnV&location=San+Diego&date=Futureo&q=music")!
         print("Set up session")

         //        var total_items: Int = 123456789
         let eventTask = session.dataTask(with: baseURL, completionHandler: {
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
        let baseURL = URL(string: "http://api.eventful.com/json/events/search?app_key=2Qm4LQs466gpMpnV&location=San+Diego&date=Futureo&q=music")!
        print("Set up session")
        
        //        var total_items: Int = 123456789
        URLSession.shared.dataTask(with: baseURL, completionHandler: {
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
                    let jsonEvents:NSDictionary = jsonEventsArr[0]! as! NSDictionary
                    print("the events are as follows.....")
                    print(type(of:jsonEvents))
                    print(jsonEvents)
                    print(".... end of the output")
                    //print(json?["events"])
                } catch {
                    print("error in JSONSerialization")
                    
                }
            }
        }).resume()
    }
    


    init(Location: String, DateFilter: String, Keywords: String, Semaphore: inout DispatchSemaphore)
      {
        self.city = Location
        self.date = DateFilter
        self.keywords = Keywords
        self.semaphore = Semaphore
//        getResponse()
        getTheHeader()
        populateEventArray()
      }

}


// let eventSt: EventsStream = EventsStream(Location: "somewhere", DateFilter: "Sometime", Keywords: "words")
// let num: Int = eventSt.getTotItems()
// print("this is the number of events")
// print(num)
