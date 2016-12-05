//
//  EventsAPI.swift
//  Gumball Events
//
//  Created by Thomas Crowley [sc14talc] on 03/12/2016.
//  Copyright © 2016 Thomas Crowley [sc14talc]. All rights reserved.
//

import Foundation

let key = "2Qm4LQs466gpMpnV"


func postKey(){
    


var request = URLRequest(url: URL(string: "http://api.eventful.com/json/events/search?app_key=2Qm4LQs466gpMpnV&keywords=books&location=San+Diego&date=Futureo")!)
//request.httpMethod = "POST"
//let postString = key
//request.httpBody = postString.data(using: .utf8)
let task = URLSession.shared.dataTask(with: request) { data, response, error in
    guard let data = data, error == nil else {                                                 // check for fundamental networking error
        print("error=\(error)")
        return
    }
    
    if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
        print("statusCode should be 200, but is \(httpStatus.statusCode)")
        print("response = \(response)")
    }
    
    let responseString = String(data: data, encoding: .utf8)
    print("responseString = \(responseString)")
}
task.resume()
}

//class EventsStream: NSObject
//{
//    var total_items: Int = 0
//    var page_size: Int = 0
//    var page_count: Int = 0
//    var page_number: Int = 0
//    var page_items: Int = 0
//    var first_item: Int = 0
//    var last_item: Int = 0
//    var search_time: Float = 0
//    var events: [Event] = []
//    
//    
//func getResponse()
//{
//    let config = URLSessionConfiguration.default
//    let session = URLSession(configuration: config)
//    let baseURL = URL(string: "http://api.eventful.com/json/events/search?app_key=2Qm4LQs466gpMpnV&location=San+Diego&date=Futureo&q=music")!
//    print("Set up session")
//    
//    let eventTask = session.dataTask(with: baseURL, completionHandler: {
//        (body, response, error) in
//        
//        print(response)
//        if error != nil {
//            
//            print("Error: " + error!.localizedDescription)
//        } else {
//            
//            do {
//                
//                if let json = try JSONSerialization.jsonObject(with: body!, options: .allowFragments) as? [String: Any] {
//                    print(json)
//                }
//            } catch {
//                
//                print("error in JSONSerialization")
//            }
//        }
//    })
//    eventTask.resume()
//}
//    
//    
//    func getTotItems()->Int
//    {
//        let config = URLSessionConfiguration.default
//        let session = URLSession(configuration: config)
//        let baseURL = URL(string: "http://api.eventful.com/json/events/search?app_key=2Qm4LQs466gpMpnV&location=San+Diego&date=Futureo&q=music")!
//        print("Set up session")
//
//        
//        let eventTask = session.dataTask(with: baseURL, completionHandler: {
//            (body, response, error) in
//            
//            print(response)
//            if error != nil {
//                
//                print("Error: " + error!.localizedDescription)
//            } else {
//                
//                do {
//                    
//                    if let json = try JSONSerialization.jsonObject(with: body!, options: .allowFragments) as? [String: Any] {
////                        print(json)
//                        let total_items_str = (json["total_items"] as? String)!
//                        print ("this is what you are looking for\n\n")
//                        print (total_items_str)
//                        self.total_items = Int(total_items_str)!
////                        }
//
//                    }
//                } catch {
//                    
//                    print("error in JSONSerialization")
//                }
//            }
//        })
//        eventTask.resume()
//        
//        return total_items
//
//    }
//    
//}
