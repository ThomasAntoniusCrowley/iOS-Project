//
//  FilterViewController.swift
//  Gumball Events
//
//  Created by Thomas Crowley [sc14talc] on 08/12/2016.
//  Copyright © 2016 Thomas Crowley [sc14talc]. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
//    var musicFlg: Bool
//    var charityFlg: Bool
//    var sportFlg: Bool
//    var familyFlg: Bool
//    var techFlg: Bool
//    var artsFlg: Bool
//    var retailFlg: Bool
    var categories: [String] = []
//    
    @IBOutlet weak var keywordsField: UITextField!
    @IBOutlet weak var catPicker: UIPickerView!
    @IBOutlet weak var catField: UITextField!
    
    
//    @IBOutlet weak var musicSwitch: UISwitch!
//    @IBOutlet weak var charitySwitch: UISwitch!
//    @IBOutlet weak var sportSwitch: UISwitch!
//    @IBOutlet weak var familySwitch: UISwitch!
//    @IBOutlet weak var techSwitch: UISwitch!
//    @IBOutlet weak var retailSwitch: UISwitch!
//    @IBOutlet weak var artsSwitch: UISwitch!
    
    var switchArr: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    // The number of columns of data
    func numberOfComponents(in: UIPickerView) -> Int {
        return 1
    }
    
    
    
    
//    @IBAction func musicPresd(_ sender: AnyObject) {
//        UserDefaults.standard.set(musicSwitch.isOn, forKey: "switchState")
//    }
//
//    @IBAction func charityPresd(_ sender: AnyObject) {
//        UserDefaults.standard.set(charitySwitch.isOn, forKey: "switchState")
//    }
//    
//    
//    @IBAction func sportPresd(_ sender: AnyObject) {
//        UserDefaults.standard.set(sportSwitch.isOn, forKey: "switchState")
//    }
//    
//    @IBAction func famPresd(_ sender: AnyObject) {
//        UserDefaults.standard.set(familySwitch.isOn, forKey: "switchState")
//    }
//    
//    @IBAction func techPresd(_ sender: AnyObject) {
//        UserDefaults.standard.set(techSwitch.isOn, forKey: "switchState")
//    }
//    
//   
//    @IBAction func artsPresd(_ sender: AnyObject) {
//        UserDefaults.standard.set(artsSwitch.isOn, forKey: "switchState")
//    }
//   
//    @IBAction func retailPresd(_ sender: AnyObject) {
//         UserDefaults.standard.set(retailSwitch.isOn, forKey: "switchState")
//    }
    
    
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
