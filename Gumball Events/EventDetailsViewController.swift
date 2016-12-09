//
//  EventDetailsViewController.swift
//  View controller handling the event details view. Presents user with
//  event title, event url and map info.
//  Gumball Events
//
//  Created by Joshua Crinall [sc14jrc] on 08/12/2016.
//  Copyright © 2016 Thomas Crowley [sc14talc]. All rights reserved.
//

import UIKit
import MapKit

class EventDetailsViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var URLButton: UIButton!
    
    var dataDict = [String: Any]()
    var location: CLLocation? = nil
    let region: CLLocationDistance = 1000
    
    //Called once view has loaded. Used to initialise view components.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if dataDict != nil {
            
            //Set title
            titleLabel.text = dataDict["title"] as! String?
            
            //Set map data
            location = CLLocation(latitude: dataDict["latitude"] as! CLLocationDegrees, longitude: dataDict["longitude"] as! CLLocationDegrees)
            setMapLocation(location: location!)
            print(dataDict)
        } else {
            titleLabel.text = "Error: cannot retrieve event data dictionary"
        }
    }

    @IBAction func openInBrowser(_ sender: AnyObject) {
        if let url = NSURL(string: dataDict["url"] as! String) {
            UIApplication.shared.openURL(url as URL)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setMapLocation(location: CLLocation) {
        
        //Set map view region
        let viewRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, region * 2.0, region * 2.0)
        mapView.setRegion(viewRegion, animated: true)
        
        //Add marker to map
        let point: MKPointAnnotation = MKPointAnnotation()
        point.coordinate = location.coordinate
        mapView.addAnnotation(point)
    }
}
