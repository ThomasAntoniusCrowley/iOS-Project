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
        categories = ["months", "weeks", "hours", "minutes", "seconds"] // Data list for pickerview
        self.catField.isUserInteractionEnabled = true
        self.catPicker.delegate = self
        self.catPicker.dataSource = self;
        self.catPicker.isHidden = true
        
    // Do any additional setup after loading the view.

    }

    // The number of columns of data
    func numberOfComponents(in: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    

    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return categories[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        catField.text = categories[row]
        catPicker.isHidden = true
        catField.isUserInteractionEnabled = true
        self.view.endEditing(true)
    }
    
    @IBAction func didBeginEditing(_ sender: UITextField) {
        catPicker.isHidden = false
        catField.isUserInteractionEnabled = false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.catField {
            catPicker.isHidden = false
            catField.isUserInteractionEnabled = false
        }
    }
    
    @IBAction func onFieldSelected(_ sender: AnyObject) {
        catPicker.isHidden = false
        catField.isUserInteractionEnabled = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        UserDefaults.standard.set(forKey: "Location")
        UserDefaults.standard.set(categories[catPicker.selectedRow(inComponent: 0)], forKey: "Category")
        UserDefaults.standard.set(keywordsField.text, forKey: "Keywords")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.

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
