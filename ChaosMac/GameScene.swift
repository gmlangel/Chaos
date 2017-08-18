//
//  GameScene.swift
//  ChaosMac
//
//  Created by guominglong on 16/6/2.
//  Copyright (c) 2016年 guominglong. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    override func didMove(to view: SKView) {
        /* Setup your scene here */
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "Hello, World!"
        myLabel.fontSize = 45
        myLabel.position = CGPoint(x:self.frame.midX, y:self.frame.midY)
        myLabel.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(M_PI), duration: 0.5)));
        self.addChild(myLabel)
        
    }
    
    override func mouseDown(with theEvent: NSEvent) {
        /* Called when a mouse click occurs */
        
        let location = theEvent.location(in: self);
        
        let sprite = SKSpriteNode(imageNamed:"Spaceship")
        sprite.position = location;
        sprite.setScale(0.5)
        
        let action = SKAction.rotate(byAngle: CGFloat(M_PI), duration:1)
        sprite.run(SKAction.repeatForever(action))
        
        self.addChild(sprite)
    }
    
    override func update(_ currentTime: TimeInterval) {
        /* Called before each frame is rendered */
    }
}
