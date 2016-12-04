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

class WeatherAPI {
   
    init() {
        getResponse()
    }
    
    func getResponse() -> UIImage? {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let baseURL = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=Leeds,UK&APPID=a225644333c3c9caf0e647bb3385a4cc")!
        var iconCode: String = ""
        var img: UIImage?
        print("Set up session")
        
        var request = URLRequest(url: NSURL(string: "http://api.openweathermap.org/data/2.5/weather?q=Leeds,UK&APPID=a225644333c3c9caf0e647bb3385a4cc") as! URL)
        let semaphore = DispatchSemaphore(value: 0)
        var error: NSErrorPointer = nil
        var data: NSData
        
        URLSession.shared.dataTask(with: baseURL {
            (body, response, error) -> UIImage in
            //data = body
            
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
                    let iconCode = iconArr[1]
                    print(iconCode)
                    img = self.getWeatherImage(icon: iconCode)
                    return img!
                    semaphore.signal()
                } catch {
                    print("error in JSONSerialization")
                    
                }
                semaphore.wait(timeout: .distantFuture)
            }
        }).resume
    }
    
    
    func getWeatherImage(icon: String) -> UIImage? {
        //let config = URLSessionConfiguration.default
        //let session = URLSession(configuration: config)
        var img: UIImage? = nil
        print("ICONCODE")
        print(iconCode)
        if let imgUrl = NSURL(string: "http://openweathermap.org/img/w/" + iconCode) {
            print(imgUrl)
            if let imgData = NSData(contentsOf: imgUrl as URL) {
                print("Getting image data")
                img = UIImage(data: imgData as Data)!
            }
        }
        return img
        
        //        _ = session.dataTask(with: imgUrl!, completionHandler: {
//            (image, response, error) in
//            print("Starting async task")
//            print(response?.suggestedFilename ?? imgUrl?.lastPathComponent)
//            
//            DispatchQueue.main.async() { () -> Void in
//                print("Preparing UI image")
//                imageView.image = UIImage(data: image!)
//            }
//        })
    }
}


