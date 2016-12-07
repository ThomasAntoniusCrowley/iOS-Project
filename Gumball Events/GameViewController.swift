//
//  GameViewController.swift
//  Gumball Events
//
//  Created by Thomas Crowley [sc14talc] on 01/12/2016.
//  Copyright © 2016 Thomas Crowley [sc14talc]. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var weatherImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
                
                //Acquire startup data
                dispatchForData()
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
            
            let eventStr: EventsStream = EventsStream()
            let num: Int = eventStr.getTotItems()
            print("total number of events \(num)")
            
        }
    }
    
    /**
     This function acquires weather data from a remote web service. First, it acquires general weather data, and then uses part of 
     the returned JSON as an icon code. This code is injected into a URL, which returns a small weather image.
     */
    func dispatchForData() {
        let baseURL = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=Leeds,UK&APPID=a225644333c3c9caf0e647bb3385a4cc")!
        
        DispatchQueue.global(qos: .userInitiated).async {
            let semaphore = DispatchSemaphore(value: 0) //Semaphore for notifying UI when async task has finished
            var iconCode: String = ""
            
            //Begin asynchronous process
            DispatchQueue.main.async {
                do {
                    //Spawn another asynchronous task from within to acquire icon code
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

    override var shouldAutorotate: Bool {
        return true
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
