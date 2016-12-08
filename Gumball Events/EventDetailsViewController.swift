//
//  EventDetailsViewController.swift
//  Gumball Events
//
//  Created by Joshua Crinall [sc14jrc] on 08/12/2016.
//  Copyright © 2016 Thomas Crowley [sc14talc]. All rights reserved.
//

import UIKit

class EventDetailsViewController: UIViewController {

    var dataDict = [String: Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(dataDict)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

       /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
