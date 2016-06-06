//
//  LoginSceneExten.swift
//  Chaos
//
//  Created by guominglong on 16/6/6.
//  Copyright © 2016年 guominglong. All rights reserved.
//

import Foundation
import SpriteKit
class LoginSceneExten: LoginScene {
    
    static var instance:LoginSceneExten{
        get{
            struct LoginSceneExtenIns {
                static var _ins:LoginSceneExten = LoginSceneExten(fileNamed: "GameScene")!;
            }
            return LoginSceneExtenIns._ins;
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let p = (touches.first?.locationInNode(self))!;
        if(btn_beginGame.frame.contains(p))
        {
            GMLLogCenter.instance.trace("登陆");
        }
//        let mons = SKSpriteNode(texture: GMLResourceManager.instance.textureByName("Test1Monster_0")).autoScreen();
//        self.gmlAddChild(mons);
//        mons.position = p;
        
//        let mons = SKSpriteNode(texture: GMLResourceManager.instance.textureByName("Test1Monster_0"));
//        //mons.xScale = 0.1;
//        //mons.yScale = 0.1;
//        self.addChild(mons);
//        mons.position = p;
//        
//        let mons2 = SKSpriteNode(color: UIColor.redColor(), size: CGSize(width: 100, height: 100));
//                self.addChild(mons2);
//                mons2.position = p;
    }
}