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
                dispatchForData()
                //weatherObj.getResponse()
                //let img: UIImage? = weatherObj.getWeatherImage()
//                if (img != nil) {
//                    weatherImg.image = img
//                    view.addSubview(weatherImg)
//                }
                
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
            
            let eventStr: EventsStream = EventsStream()
            let num: Int = eventStr.getTotItems()
            print("total number of events \(num)")
            
        }
    }
    
    func dispatchForData() {
        let baseURL = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=Leeds,UK&APPID=a225644333c3c9caf0e647bb3385a4cc")!
        
        DispatchQueue.global(qos: .userInitiated).async {
            let semaphore = DispatchSemaphore(value: 0)
            var iconCode: String = ""
            
            DispatchQueue.main.async {
                do {
                    URLSession.shared.dataTask(with: baseURL, completionHandler: {
                        (body, response, error) in
                        
                        if error != nil {
                            print("Error: " + error!.localizedDescription)
                            
                        } else {
                            do {
                                let json = try JSONSerialization.jsonObject(with: body!, options: .allowFragments) as? NSDictionary
                                print(json)
                                let weather = (json?["weather"]! as! NSArray).dictionaryWithValues(forKeys: ["description", "icon", "id", "main"]) as NSDictionary
                                print(weather)
                                let icon = String(describing: weather["icon"]!)
                                let iconArr: [String] = icon.components(separatedBy: "\n")[1].components(separatedBy: "    ")
                                iconCode = iconArr[1].components(separatedBy: ",")[0]
                                semaphore.signal()
                                print(iconCode)
                            } catch {
                                print("error in JSONSerialization")
                                
                            }
                        }
                    }).resume()
                }
            }
            semaphore.wait(timeout: .distantFuture)
            DispatchQueue.global(qos: .userInitiated).async {
                let imgUrl = URL(string: "http://openweathermap.org/img/w/" + iconCode + ".png")
                print(imgUrl)
                let imageData:NSData = NSData(contentsOf: imgUrl!)!
                let imageView = UIImageView(frame: CGRect(x:0, y:0, width:200, height:200))
                imageView.center = self.view.center
                
                // When from background thread, UI needs to be updated on main_queue
                DispatchQueue.main.async {
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
