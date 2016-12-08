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

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    var dataDict = [String: Any]()
    var location: CLLocation? = nil
    let region: CLLocationDistance = 1000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = dataDict["title"] as! String?
        urlLabel.text = dataDict["url"] as! String?
        
        location = CLLocation(latitude: dataDict["latitude"] as! CLLocationDegrees, longitude: dataDict["longitude"] as! CLLocationDegrees)
        setMapLocation(location: location!)
        print(dataDict)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setMapLocation(location: CLLocation) {
        let viewRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, region * 2.0, region * 2.0)
        mapView.setRegion(viewRegion, animated: true)
        
        let point: MKPointAnnotation = MKPointAnnotation()
        point.coordinate = location.coordinate
        mapView.addAnnotation(point)
    }
}
