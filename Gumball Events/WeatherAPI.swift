//
//  Weather.swift
//  Gumball Events
//
//  Created by Joshua Crinall [sc14jrc] on 02/12/2016.
//  Copyright © 2016 Thomas Crowley [sc14talc]. All rights reserved.
//  pls work

import Foundation

typealias ServiceResponse = (String, NSError?) -> Void

class WeatherAPI: NSObject {
    
    func getResponse() {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let baseURL = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=Leeds,UK&APPID=a225644333c3c9caf0e647bb3385a4cc")!
        print("Set up session")
        
        let weather = session.dataTask(with: baseURL, completionHandler: {
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
        weather.resume()
    }
}
