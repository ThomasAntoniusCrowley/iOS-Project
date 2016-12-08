//
//  FilterViewController.swift
//  Gumball Events
//
//  Created by Thomas Crowley [sc14talc] on 08/12/2016.
//  Copyright © 2016 Thomas Crowley [sc14talc]. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {
    
//    var musicFlg: Bool
//    var charityFlg: Bool
//    var sportFlg: Bool
//    var familyFlg: Bool
//    var techFlg: Bool
//    var artsFlg: Bool
//    var retailFlg: Bool
//    
    
    
    @IBOutlet weak var musicSwitch: UISwitch!
    @IBOutlet weak var charitySwitch: UISwitch!
    @IBOutlet weak var sportSwitch: UISwitch!
    @IBOutlet weak var familySwitch: UISwitch!
    @IBOutlet weak var techSwitch: UISwitch!
    @IBOutlet weak var artsSwitch: UISwitch!
    @IBOutlet weak var retailSwitch: UISwitch!
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        musicSwitch.isOn =  UserDefaults.standard.bool(forKey: "switchState")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func musicSwitchPressed(_ sender: AnyObject) {
         UserDefaults.standard.set(musicSwitch.isOn, forKey: "switchState")
    }
    
    
//    let defaults = UserDefaults.standard
//    
//    if let currentRecord = defaults.string(forKey: defaultsKeys.keyOne) {
//        
//        defaults.setValue(newRecord, forKey: defaultsKeys.keyOne)
//    }
//    else
//    {
//    print ("there are currently no records")
//    let newRecord = recordString
//    print ("the new record is \(newRecord)")
//    defaults.setValue(newRecord, forKey: defaultsKeys.keyOne)
//    }
//    
//    defaults.synchronize()
//}


    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
