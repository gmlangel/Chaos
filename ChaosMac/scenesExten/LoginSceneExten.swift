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
                static var _ins:LoginSceneExten = LoginSceneExten(size: GMLMain.instance.mainGameView.frame.size);
            }
            return LoginSceneExtenIns._ins;
        }
    }
    
    override func mouseDown(theEvent: NSEvent) {
        let p = theEvent.locationInNode(self.contextContainerLayer);
        if(btn_beginGame.frame.contains(p))
        {
            GMLLogCenter.instance.trace("登陆");
            NSNotificationCenter.defaultCenter().postNotificationName("changeScene", object: "SelectRoleScene");
        }
    }
}