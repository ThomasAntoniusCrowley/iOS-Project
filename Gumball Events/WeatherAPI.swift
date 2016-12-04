//
//  Weather.swift
//  Gumball Events
//
//  Created by Joshua Crinall [sc14jrc] on 02/12/2016.
//  Copyright © 2016 Thomas Crowley [sc14talc]. All rights reserved.
//  pls work
// is it working yet?

import Foundation
import UIKit

typealias ServiceResponse = (String, NSError?) -> Void

class WeatherAPI: NSObject {
    //var imageView: UIImageView
    
    func getResponse() {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let baseURL = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=Leeds,UK&APPID=a225644333c3c9caf0e647bb3385a4cc")!
        var iconCode: String = ""
        print("Set up session")
        
        let weather = session.dataTask(with: baseURL, completionHandler: {
            (body, response, error) in
            print(response)
            
            if error != nil {
                print("Error: " + error!.localizedDescription)
                
            } else {
                do {
                    let json = try JSONSerialization.jsonObject(with: body!, options: .allowFragments) as? NSDictionary
                    print(json)
                    let weather = (json?["weather"]! as! NSArray).dictionaryWithValues(forKeys: ["description", "icon", "id", "main"]) as NSDictionary
                    print(weather)
                    let icon = String(describing: weather["icon"]!)
                    let iconArr: [String] = icon.components(separatedBy: "\n")[1].components(separatedBy: "    ")
                    iconCode = iconArr[1]
                    print(iconCode)
                } catch {
                    print("error in JSONSerialization")
                    
                }
            }
        })
        
        weather.resume()
    }
    
    
    func getWeatherImage(iconCode: String) {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        var imageView: UIImageView? = nil
        
        let imgUrl = URL(string: "http://openweathermap.org/img/w/" + iconCode)
        
        let img = session.dataTask(with: imgUrl!, completionHandler: {
            (image, response, error) in
            print(response?.suggestedFilename ?? imgUrl?.lastPathComponent)
            
            DispatchQueue.main.async() { () -> Void in
                imageView?.image = UIImage(data: image!)
            }
        })
    }
}

