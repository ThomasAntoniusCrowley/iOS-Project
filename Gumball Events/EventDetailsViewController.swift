//
//  EventDetailsViewController.swift
//  Gumball Events
//
//  Created by Joshua Crinall [sc14jrc] on 08/12/2016.
//  Copyright © 2016 Thomas Crowley [sc14talc]. All rights reserved.
//

import UIKit
import MapKit

class EventDetailsViewController: UIViewController {

    var dataDict = [String: Any]()
    var location: CLLocation? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        location = CLLocation(latitude: dataDict["latitude"] as! CLLocationDegrees, longitude: dataDict["longitude"] as! CLLocationDegrees)
        
        
        print(dataDict)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
