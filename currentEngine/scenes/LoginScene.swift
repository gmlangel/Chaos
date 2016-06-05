//
//  LoginScene.swift
//  Chaos
//
//  Created by guominglong on 16/6/5.
//  Copyright © 2016年 guominglong. All rights reserved.
//

import Foundation
class LoginScene: GMLScene {
    
    private var bgNode:SKSpriteNode!;
    static var instance:LoginScene{
        get{
            struct LoginSceneIns {
                static var _ins:LoginScene = LoginScene(fileNamed: "GameScene")!;
            }
            return LoginSceneIns._ins;
        }
    }
    
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view);
        bgNode.position = CGPoint(x: CGRectGetMidX((self.view?.frame)!), y: CGRectGetMidY((self.view?.frame)!));//居中显示
    }
    
    override func ginit() {
        super.ginit();
        self.backgroundColor = SKColor.blackColor();
        bgNode = SKSpriteNode(texture: GMLResourceManager.instance.textureByName("loginScene_bg")).autoScreen();
        self.addChild(bgNode);
    }
    
    override func didChangeSize(oldSize: CGSize) {
        if(isInited == true)
        {
            bgNode.position.x = CGRectGetMidX((self.view?.frame)!);
            bgNode.position.y = CGRectGetMidY((self.view?.frame)!);
        }
    }
}