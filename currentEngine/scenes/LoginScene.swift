//
//  LoginScene.swift
//  Chaos
//
//  Created by guominglong on 16/6/5.
//  Copyright © 2016年 guominglong. All rights reserved.
//

import Foundation
class LoginScene: GMLScene {
    
    var bgNode:SKSpriteNode!;
    var btn_beginGame:SKSpriteNode!;
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
        gresize(self.size);
    }
    
    override func ginit() {
        super.ginit();
        self.backgroundColor = SKColor.blackColor();
        bgNode = SKSpriteNode(texture: GMLResourceManager.instance.textureByName("loginScene_bg")).autoScreen();
        self.addChild(bgNode);
        
        
        btn_beginGame = SKSpriteNode(color: NSColor.whiteColor(), size: CGSize(width: 120, height: 30));
        let btn_beginGameLabel:SKLabelNode = SKLabelNode(text: "开始");
        btn_beginGameLabel.verticalAlignmentMode = .Center;
        btn_beginGameLabel.horizontalAlignmentMode = .Center;
        btn_beginGame.addChild(btn_beginGameLabel);
        
        self.addChild(btn_beginGame);
        
    }
    
    override func didChangeSize(oldSize: CGSize) {
        if(isInited == true)
        {
            gresize((self.view?.frame.size)!);
        }
    }
    
    override func gresize(currentSize: CGSize) {
        bgNode.position.x = CGRectGetMidX((self.view?.frame)!);
        bgNode.position.y = CGRectGetMidY((self.view?.frame)!);
        btn_beginGame.position.x = bgNode.position.x;
        btn_beginGame.position.y = bgNode.position.y;
    }
}