//
//  FilterViewController.swift
//  View controller handling event query filters
//
//  Gumball Events
//
//  Created by Thomas Crowley [sc14talc] on 08/12/2016.
//  Copyright © 2016 Thomas Crowley [sc14talc]. All rights reserved.
//
import UIKit
class FilterViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var keywordsField: UITextField!
    @IBOutlet weak var catPicker: UIPickerView!
    @IBOutlet weak var catField: UITextField!
    @IBOutlet weak var locationField: UITextField!
    
    var switchArr: [String] = []
    var categories: [String] = []
    
    //Called once view has loaded. Used for initial setup.
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //Data list for picker
        categories = ["music", "comedy", "family", "sports", "education"]
        
        //Configure UI components
        self.catField.isUserInteractionEnabled = true
        self.catPicker.delegate = self
        self.catPicker.dataSource = self;
        self.catPicker.isHidden = true
    }
    
    //Set picker column count
    func numberOfComponents(in: UIPickerView) -> Int {
        return 1
    }
    
    //Set picker row count
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    //Data to return from picker
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    }
    
    //Set up UI components so only picker can be used to set textfield data
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        catField.text = categories[row]
        catPicker.isHidden = true
        catField.isUserInteractionEnabled = true
        self.view.endEditing(true)
    }
    
    //Shows picker when textfield selected
    @IBAction func didBeginEditing(_ sender: UITextField) {
        catPicker.isHidden = false
        catField.isUserInteractionEnabled = false
    }
    
    //Called before transition to different view controller - used to send data over segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (locationField.text != nil) {
            if (catField.text != nil) {
                if (keywordsField.text != nil) {
                    UserDefaults.standard.set(locationField.text, forKey: "Location")
                    UserDefaults.standard.set(catField.text, forKey: "Category")
                    UserDefaults.standard.set(keywordsField.text, forKey: "Keywords")
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
