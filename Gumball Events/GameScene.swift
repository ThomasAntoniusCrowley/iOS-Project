//
//  GameScene.swift
//  Gumball Events
//
//  Created by Thomas Crowley [sc14talc] on 01/12/2016.
//  Copyright © 2016 Thomas Crowley [sc14talc]. All rights reserved.
//

import SpriteKit
import GameplayKit

//Create Objective-C protocol for performing action from view controller
@objc protocol performActionFromController {
    @objc optional func getBalls()
}

//Class extension
extension GameScene {
    
    //Declaration of Objective-C function for acquiring query data from FilterViewController
    @objc func getBalls() {
        
        //Get data via user defaults - data persists
        guard let location: String = UserDefaults.standard.string(forKey: "Location") else {
            print("Error: Unable to access filter data")
            return
        }
        guard let category: String = UserDefaults.standard.string(forKey: "Category") else {
            print("Error: Unable to access filter data")
            return
        }
        guard let keywords: String = UserDefaults.standard.string(forKey: "Keywords") else {
            print("Error: Unable to access filter data")
            return
        }
        
        //Reset events stream
        eventsStream = nil
        
        //Create new dispatch semaphore
        var semaphore: DispatchSemaphore = DispatchSemaphore(value: 0)
        
        //Create new events stream with acquired data
        eventsStream = EventsStream(Location: location, DateFilter: "Futureo", Keywords: keywords, Category: category, Semaphore: &semaphore)
        
        //Wait for data to be acquired before continuing
        semaphore.wait(timeout: .distantFuture)
        
        if eventsStream != nil {
            self.getEvents(eventsStream: eventsStream!)
        } else {
            print("Error instantiating EventsStream object")
        }
    }
}

class GameScene: SKScene, performActionFromController {
    
    var viewController: UIViewController?
    var balls: [SKShapeNode] = []
    var touching: Bool = false
    var touchFlag: Bool = false
    var lastTouched: CGPoint? = nil
    var G: CGVector = CGVector(dx:0.0, dy:-5.0)
    var startTouchTime: DispatchTime = DispatchTime.now()
    var endTouchTime: DispatchTime = DispatchTime.now()
    var touchTime: UInt64 = 0
    var eventsStream: EventsStream? = nil
    var eventsArr: [Event] = []
    
    //Called when SKScene is loaded
    override func didMove(to view: SKView) {
        
        //Create observer to handle methods invoked form view controller
        NotificationCenter.default.addObserver(self, selector: #selector(getBalls), name: NSNotification.Name("getBalls"), object: nil)
        
        //Apply gravity
        self.physicsWorld.gravity = G
        
        //Set screen edges as physics body
        let frameCollider = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsBody = frameCollider
    }
    
    /**
     This function places event data into workable array, counts through each event and creates a corresponding gumball.
     Gumball indeces reflect event indices, allowing us to access event information from gumball interaction.
     */
    func getEvents(eventsStream: EventsStream) {
        
        //Get event data into array
        eventsArr = eventsStream.events
        print("Event count: " + String(eventsStream.events.count))
        
        //Count through event array as long as it's not empty
        if eventsArr.count > 0 {
            for i in 0...eventsArr.count - 1 {
                
                //Create gumball and append to gumball array
                let ball = SKShapeNode(circleOfRadius: CGFloat(115))
                balls.append(ball)
                
                //Random colours
                let r: CGFloat = CGFloat(drand48())
                let g: CGFloat = CGFloat(drand48())
                let b: CGFloat = CGFloat(drand48())
                ball.strokeColor = UIColor(red:r, green:g, blue:b, alpha:1) // Random colours
                ball.lineWidth = 4
                ball.fillColor = UIColor(red:r, green:g, blue:b, alpha:1)
                
                //Place event data into dictionary
                let eventDict: Dictionary = eventsArr[i].getDict()
                
                //Place event title as label onto gumball
                let text = SKLabelNode(text: eventDict["title"] as? String) // Task name on each circle
                text.fontSize = 18.0
                text.fontName = "AvenirNext-Bold"
                text.color = UIColor(red:0, green:0, blue:0, alpha:1)
                ball.addChild(text)
                
                //Set canvas width/height
                let canvasWidth: UInt32 = UInt32(self.view!.frame.size.width)
                let canvasHeight: UInt32 = UInt32(self.view!.frame.size.height)
                
                //Random spawn point
                ball.position = CGPoint (x: CGFloat(arc4random()%(canvasWidth)), y: CGFloat(arc4random()%(canvasHeight)))
                
                //Add ball to scene
                self.addChild(ball)
                
                //Add physics to ball
                ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.frame.size.width/2)
                ball.physicsBody?.friction = 0.3
                ball.physicsBody?.restitution = 0.8
                ball.physicsBody?.mass = 0.5 // Configure physics
            }
            print(balls.count)
        } else {
            print("Error: unable to populate event array")
        }
    }
    
    //invoked form view controller using notificationCenter - performs segue to details view
    func goToDetails() {
        self.viewController?.performSegue(withIdentifier: "eventSegue", sender: viewController)
    }
    
    func touchDown(atPoint pos : CGPoint) {
    }
    
    func touchMoved(toPoint pos : CGPoint) {
    }
    
    func touchUp(atPoint pos : CGPoint) {
    }
    
    //Handles when touch begins
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            
            //Record touch coordinates
            lastTouched = t.location(in: self)
            self.touchDown(atPoint: t.location(in: self))
            
            //Set flag to indicate if screen is being touched
            touching = true
            
            //Record time for calculating touch length in nanoseconds
            startTouchTime = DispatchTime.now()
            
            //Count through gumballs
            for b in balls {
                
                //If touch coordinates are within sprite boundaries
                if (b.contains(t.location(in: self))) {
                    
                    //Set touch flag to indicate if gumball is being touched
                    touchFlag = true
                    
                    //Temporarily disable gravity
                    self.physicsWorld.gravity = CGVector(dx:0.0, dy:0.0)
                    
                    //Set ball location to touch location for dragging
                    b.position = t.location(in: self)
                }
            }
        }
    }
    
    //Handles when touch moves
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            
            //Record touch coordinates
            lastTouched = t.location(in: self)
            self.touchMoved(toPoint: t.location(in: self))
            
            //Set flag to indicate if screen is being touched
            touching = true
            
            //Count through gumballs
            for b in balls {
                
                //If touch coordinates are within sprite boundaries
                if b.contains(t.location(in: self)) {
                    
                    //Set flag to indicate if gumball is being touched
                    touchFlag = true
                    
                    //Temporarily disable gravity
                    self.physicsWorld.gravity = CGVector(dx:0.0, dy:0.0)
                    
                    //Set umball position to touch location for dragging
                    b.position = t.location(in: self)
                    
                }
            }
        }
    }
    
    //Handles when touch ends
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            
            //Get last touch location
            self.touchUp(atPoint: t.location(in: self))
            
            //Record time in nanoseconds and calculate touch length
            endTouchTime = DispatchTime.now()
            touchTime = endTouchTime.uptimeNanoseconds - startTouchTime.uptimeNanoseconds
            
            //Set flag for indicating whether or not screen is being touched
            touching = false
            
            //Apply gravity
            self.physicsWorld.gravity = G
            print(touchTime)
            
            //If touch is very short (< 0.3 seconds)
            if touchTime < 300000000 {
                
                //If umball was touched
                if touchFlag == true {
                    
                    //Loop through gumball array
                    for i in 0...balls.count - 1 {
                        
                        //If previous touch location was within gumball boundaries
                        if balls[i].contains(t.previousLocation(in: self)) {
                            print("Balls: " + String(balls.count) + ", events: " + String(eventsArr.count))
                            
                            //Get data dictionary from corresponding event object
                            let dict: Dictionary = eventsArr[i].getDict()
                            
                            //Post notification to GameViewController to perform segue, sending data dictionary with it
                            NotificationCenter.default.post(name: NSNotification.Name("eventSegue"), object: dict)
                        }
                    }
                }
            }
            //Ball no longer being touched
            touchFlag = false
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        //If screen is being touched
        if touching == true {
            
            //Loop through gumballs
            for b in balls {
                
                //If last touched coordinate was within gumball sprite boundary
                if b.contains(lastTouched!) {
                    
                    //Gumball position = touch location
                    b.position = lastTouched!
                }
            }
        }
    }
}
