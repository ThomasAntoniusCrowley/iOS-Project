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
    // var events: [Event] = []

    var description: String
    {
      return "this is the description"
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
                      print(json)
                  }
              } catch {

                  print("error in JSONSerialization")
              }
          }
      })
      eventTask.resume()
  }


    func getTotItems()->Int
    {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let baseURL = URL(string: "http://api.eventful.com/json/events/search?app_key=2Qm4LQs466gpMpnV&location=San+Diego&date=Futureo&q=music")!
        print("Set up session")

        let eventTask = session.dataTask(with: baseURL, completionHandler:
          {
            (body, response, error) in

            print(response)
            if error != nil {

                print("Error: " + error!.localizedDescription)
            }
            else
            {

                do
                {

                    if let json = try JSONSerialization.jsonObject(with: body!, options: .allowFragments) as? [String: Any]
                    {
//                        print(json)
                        let total_items_str = (json["total_items"] as? String)!
                        print ("this is what you are looking for\n\n")
                        print (total_items_str)
                        self.total_items = Int(total_items_str)!
                    }
                }
                catch
                {

                    print("error in JSONSerialization")
                }
            }
        })
        eventTask.resume()

        return total_items
    }


//
// func getTheHeader()
//     {
//         let config = URLSessionConfiguration.default
//         let session = URLSession(configuration: config)
//         let baseURL = URL(string: "http://api.eventful.com/json/events/search?app_key=2Qm4LQs466gpMpnV&location=San+Diego&date=Futureo&q=music")!
//         print("Set up session")
//
//         //        var total_items: Int = 123456789
//         let eventTask = session.dataTask(with: baseURL, completionHandler: {
//             (body, response, error) in
//
//             print(response)
//             if error != nil {
//
//                 print("Error: " + error!.localizedDescription)
//             } else {
//
//                 do {
//
//                     if let json = try JSONSerialization.jsonObject(with: body!, options: .allowFragments) as? [String: Any] {
//                         //                        print(json)
//                         self.total_items = (json["total_items"] as? Int)!
//                         self.page_size = (json["page_size"] as? Int)!
//                         self.page_count = (json["page_count"] as? Int)!
//                         self.page_number = (json["page_number"] as? Int)!
//                         self.page_items = (json["page_items"] as? Int)!
//                         self.first_item = (json["first_item"] as? Int)!
//                         self.last_item = (json["last_item"] as? Int)!
//                         self.search_time = (json["search_time"] as? Float)!
//
//                     }
//                 } catch {
//
//                     print("error in JSONSerialization")
//                 }
//             }
//         })
//         eventTask.resume()
//     }
//
//
// }

  init(Location: String, DateFilter: String, Keywords: String)
      {
        self.city = Location
        self.date = DateFilter
        self.keywords = Keywords
      }

}


// let eventSt: EventsStream = EventsStream(Location: "somewhere", DateFilter: "Sometime", Keywords: "words")
// let num: Int = eventSt.getTotItems()
// print("this is the number of events")
// print(num)
