//
//  GameViewController.swift
//  Class for handling GameScene and UI components in view
//
//  Gumball Events
//
//  Created by Thomas Crowley [sc14talc] on 01/12/2016.
//  Copyright © 2016 Thomas Crowley [sc14talc]. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit
import GameplayKit

//Objective-C protocol for passing data between classes via NotificationCenter
@objc protocol performSegueFromScene {
    
    //Objective-C function for performing segue transition from SKScene
    @objc optional func goToEventDetails()
}

//Class extension
extension GameViewController {
    
    //Objective-C function declaration - gets dictionary of event data 
    //from touched gumball via NSNotification & performs segue
    @objc func goToEventDetails(notification: NSNotification) {
        let dict = notification.object as! NSDictionary
        self.dataDict = dict as! [String : Any]
        self.performSegue(withIdentifier: "eventSegue", sender: self)
    }
}

class GameViewController: UIViewController, performSegueFromScene {
    
    @IBOutlet weak var weatherImg: UIImageView!
    @IBOutlet weak var ballsButton: UIButton!
    var dataDict = [String: Any]()
    var image:UIImage!
    
    //Called once view has loaded - used for variable initialisation
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ballsButton = UIButton(type: .custom)
        let cogImage = UIImage(named: "gumball.png")
        ballsButton.setImage(cogImage, for: .normal)
        
        if let view = self.view as! SKView? {
            
            //Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                
                //Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                //Create observer for calling methods via NotificationCenter & present scene
                NotificationCenter.default.addObserver(self, selector: #selector(goToEventDetails) , name: NSNotification.Name("eventSegue"), object: nil)
                view.presentScene(scene)
                
                //Acquire startup data
                dispatchForData()
            }
            view.ignoresSiblingOrder = true
        }
    }
    
    /**
     This function acquires weather data from a remote web service. First, it acquires general weather data, and then uses part of
     the returned JSON as an icon code. This code is injected into a URL, which returns a small weather image.
     */
    func dispatchForData() {
        let baseURL = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=Leeds,UK&APPID=a225644333c3c9caf0e647bb3385a4cc")!
        
        //ready dispatch queue for handling data acquisition
        DispatchQueue.global(qos: .userInitiated).async {
            
            //Semaphore for notifying UI when async task has finished
            let semaphore = DispatchSemaphore(value: 0)
            var iconCode: String = ""
            
            //Begin asynchronous process
            DispatchQueue.main.async {
                do {
                    //Spawn asynchronous task from within queue to acquire weather data
                    URLSession.shared.dataTask(with: baseURL, completionHandler: {
                        (body, response, error) in
                        
                        if error != nil {
                            print("Error: " + error!.localizedDescription)
                        } else {
                            do {
                                //Serialize JSON string form URL
                                let json = try JSONSerialization.jsonObject(with: body!, options: .allowFragments) as? NSDictionary
                                print(json)
                                
                                //Acquire weather object from JSON string
                                let weather = (json?["weather"]! as! NSArray).dictionaryWithValues(forKeys: ["description", "icon", "id", "main"]) as NSDictionary
                                print(weather)
                                
                                //Parse icon code from weather object
                                let icon = String(describing: weather["icon"]!)
                                let iconArr: [String] = icon.components(separatedBy: "\n")[1].components(separatedBy: "    ")
                                iconCode = iconArr[1].components(separatedBy: ",")[0]
                                
                                //Signal semaphore to alert 2nd async task that icon code has been acquired
                                semaphore.signal()
                                print(iconCode)
                            } catch {
                                print("error in JSONSerialization")
                                
                            }
                        }
                    }).resume()
                }
            }
            
            //Semaphore waits for icon code to have been acquired before continuing
            semaphore.wait(timeout: .distantFuture)
            
            //Start another async task
            DispatchQueue.global(qos: .userInitiated).async {
                
                //Get image from icon code and URL
                let imgUrl = URL(string: "http://openweathermap.org/img/w/" + iconCode + ".png")
                print(imgUrl)
                
                //Parse image data and create UIImageView object
                let imageData:NSData = NSData(contentsOf: imgUrl!)!
                let imageView = UIImageView(frame: CGRect(x:0, y:0, width:200, height:200))
                imageView.center = self.view.center
                
                //Update UI on main dispatch queue
                DispatchQueue.main.async {
                    
                    //Feed image data into UIImage object and add to view
                    let image = UIImage(data: imageData as Data)
                    imageView.image = image
                    imageView.contentMode = UIViewContentMode.scaleAspectFit
                    self.view.addSubview(imageView)
                }
            }
        }
    }
    
    //Called before performing segue transition
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "eventSegue" {
            
            //Send dictionary to destination view controller
            let destinationVC = segue.destination as! EventDetailsViewController
            destinationVC.dataDict = self.dataDict
        }
    }
    
    //Posts call to acquire gumballs to GameScene
    @IBAction func getBalls(_ sender: AnyObject) {
        NotificationCenter.default.post(name: NSNotification.Name("getBalls"), object: nil)
    }
    
    //Invokes objective-C selector for moving performing segue via GameScene
    func selectSegue() {
        performSelector(inBackground: #selector(goToEventDetails), with: nil)
    }
    
    //Should not rotate
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
