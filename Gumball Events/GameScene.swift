//
//  GameScene.swift
//  Gumball Events
//
//  Created by Thomas Crowley [sc14talc] on 01/12/2016.
//  Copyright © 2016 Thomas Crowley [sc14talc]. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    var balls: [SKShapeNode] = []
    var touching: Bool = false
    var lastTouched: CGPoint? = nil
    var G: CGVector = CGVector(dx:0.0, dy:-5.0)
    var startTouchTime: Double = 0.0
    var endTouchTime: Double = 0.0
    
    override func didMove(to view: SKView) {
        
        self.physicsWorld.gravity = G // Apply gravity
        
        let frameCollider = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsBody = frameCollider // Create physics body
        
        let ball = SKShapeNode(circleOfRadius: CGFloat(150))
        balls.append(ball)
        
        let r: CGFloat = CGFloat(drand48())
        let g: CGFloat = CGFloat(drand48())
        let b: CGFloat = CGFloat(drand48())
        
        ball.strokeColor = UIColor(red:r, green:g, blue:b, alpha:1) // Random colours
        ball.lineWidth = 4
        ball.fillColor = UIColor(red:r, green:g, blue:b, alpha:1)
        
        let text = SKLabelNode(text: "Hey") // Task name on each circle
        text.fontSize = 18.0
        text.fontName = "AvenirNext-Bold"
        text.color = UIColor(red:0, green:0, blue:0, alpha:1)
        
        ball.addChild(text) // Add text to circle
        
        let canvasWidth: UInt32 = UInt32(self.view!.frame.size.width)
        let canvasHeight: UInt32 = UInt32(self.view!.frame.size.height)
        
        ball.position = CGPoint (x: CGFloat(arc4random()%(canvasWidth)), y: CGFloat(arc4random()%(canvasHeight)))
        
        self.addChild(ball)
        
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.frame.size.width/2)
        
        ball.physicsBody?.friction = 0.3
        ball.physicsBody?.restitution = 0.8
        ball.physicsBody?.mass = 0.5 // Configure physics
        print(balls.count)
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
    }
    
    func touchMoved(toPoint pos : CGPoint) {
    }
    
    func touchUp(atPoint pos : CGPoint) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            lastTouched = t.location(in: self)
            self.touchDown(atPoint: t.location(in: self))
            touching = true
            for b in balls {
                if (b .contains(t.location(in: self))) {
                    self.physicsWorld.gravity = CGVector(dx:0.0, dy:0.0)
                    b.position = t.location(in: self)
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            lastTouched = t.location(in: self)
            self.touchMoved(toPoint: t.location(in: self))
            touching = true
            for b in balls {
                if b.contains(t.location(in: self)) {
                    b.position = t.location(in: self)
                    self.physicsWorld.gravity = CGVector(dx:0.0, dy:0.0)
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            self.touchUp(atPoint: t.location(in: self))
            touching = false
            self.physicsWorld.gravity = G
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func update(_ currentTime: TimeInterval) {
        if touching == true {
            for b in balls {
                if b.contains(lastTouched!) {
                    b.position = lastTouched!
                }
            }
        }
    }
}
