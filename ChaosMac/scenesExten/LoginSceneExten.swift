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
    
    override func mouseDown(with theEvent: NSEvent) {
        let p = theEvent.location(in: self.contextContainerLayer);
        if(btn_beginGame.frame.contains(p))
        {
            GMLLogCenter.instance.trace("登陆");
            NotificationCenter.default.post(name: Notification.Name(rawValue: "changeScene"), object: "SelectRoleScene");
        }
    }
}
