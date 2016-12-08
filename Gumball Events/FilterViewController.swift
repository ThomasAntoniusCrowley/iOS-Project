//
//  FilterViewController.swift
//  Gumball Events
//
//  Created by Thomas Crowley [sc14talc] on 08/12/2016.
//  Copyright © 2016 Thomas Crowley [sc14talc]. All rights reserved.
//

import UIKit

@objc protocol sendDataToScene {
    @objc optional func sendToGameScene()
}

extension GameViewController {
    @objc func sendTogameScene(notification: NSNotification) {
        let dict = notification.object as! NSDictionary
        self.dataDict = dict as! [String : Any]
        self.performSegue(withIdentifier: "eventSegue", sender: self)
    }
}


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
    @IBOutlet weak var retailSwitch: UISwitch!
    @IBOutlet weak var artsSwitch: UISwitch!
    
    var switchArr: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        musicSwitch.isOn =  UserDefaults.standard.bool(forKey: "musicState")
        charitySwitch.isOn =  UserDefaults.standard.bool(forKey: "charityState")
        sportSwitch.isOn =  UserDefaults.standard.bool(forKey: "sportState")
        familySwitch.isOn =  UserDefaults.standard.bool(forKey: "familyState")
        techSwitch.isOn =  UserDefaults.standard.bool(forKey: "techState")
        artsSwitch.isOn =  UserDefaults.standard.bool(forKey: "artsState")
        retailSwitch.isOn =  UserDefaults.standard.bool(forKey: "retailState")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func musicPresd(_ sender: AnyObject) {
        UserDefaults.standard.set(musicSwitch.isOn, forKey: "musicState")
        
        if musicSwitch.isOn == true {
            switchArr.append("music")
        } else {
            for i in 0...switchArr.count {
                if switchArr[i] == "music" {
                    switchArr.remove(at: i)
                }
            }
        }
    }

    @IBAction func charityPresd(_ sender: AnyObject) {
        UserDefaults.standard.set(charitySwitch.isOn, forKey: "charityState")
        
        if charitySwitch.isOn == true {
            switchArr.append("charity")
        } else {
            for i in 0...switchArr.count {
                if switchArr[i] == "charity" {
                    switchArr.remove(at: i)
                }
            }
        }
    }
    
    
    @IBAction func sportPresd(_ sender: AnyObject) {
        UserDefaults.standard.set(sportSwitch.isOn, forKey: "sportState")
        
        if sportSwitch.isOn == true {
            switchArr.append("sport")
        } else {
            for i in 0...switchArr.count {
                if switchArr[i] == "sport" {
                    switchArr.remove(at: i)
                }
            }
        }
    }
    
    @IBAction func famPresd(_ sender: AnyObject) {
        UserDefaults.standard.set(familySwitch.isOn, forKey: "familyState")
        
        if familySwitch.isOn == true {
            switchArr.append("family")
        } else {
            for i in 0...switchArr.count {
                if switchArr[i] == "family" {
                    switchArr.remove(at: i)
                }
            }
        }
    }
    
    @IBAction func techPresd(_ sender: AnyObject) {
        UserDefaults.standard.set(techSwitch.isOn, forKey: "techState")
        
        if techSwitch.isOn == true {
            switchArr.append("tech")
        } else {
            for i in 0...switchArr.count {
                if switchArr[i] == "tech" {
                    switchArr.remove(at: i)
                }
            }
        }
    }
    
   
    @IBAction func artsPresd(_ sender: AnyObject) {
        UserDefaults.standard.set(artsSwitch.isOn, forKey: "artsState")
        
        if artsSwitch.isOn == true {
            switchArr.append("arts")
        } else {
            for i in 0...switchArr.count {
                if switchArr[i] == "arts" {
                    switchArr.remove(at: i)
                }
            }
        }
    }
   
    @IBAction func retailPresd(_ sender: AnyObject) {
         UserDefaults.standard.set(retailSwitch.isOn, forKey: "retailState")
        
        if retailSwitch.isOn == true {
            switchArr.append("retail")
        } else {
            for i in 0...switchArr.count {
                if switchArr[i] == "retail" {
                    switchArr.remove(at: i)
                }
            }
        }
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
