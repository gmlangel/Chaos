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
    private var tb_login:NSTextField!;
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
        tb_login.frame.origin.x = (CGRectGetWidth((self.view?.frame)!) - tb_login.frame.size.width)/2;
        tb_login.frame.origin.y = CGRectGetMidY((self.view?.frame)!) - 60;
        self.view?.addSubview(tb_login);
    }
    
    override func ginit() {
        super.ginit();
        self.backgroundColor = SKColor.blackColor();
        bgNode = SKSpriteNode(texture: GMLResourceManager.instance.textureByName("loginScene_bg")).autoScreen();
        self.addChild(bgNode);
        
        tb_login = NSTextField(frame: NSRect(x: 0, y: 0, width: 200, height: 30));
        tb_login.usesSingleLineMode = true;
        tb_login.font = NSFont.systemFontOfSize(14);
        tb_login.textColor = NSColor.blueColor();
        tb_login.backgroundColor = NSColor.whiteColor();
        tb_login.bordered = true;
    }
    
    override func didChangeSize(oldSize: CGSize) {
        if(isInited == true)
        {
            bgNode.position.x = CGRectGetMidX((self.view?.frame)!);
            bgNode.position.y = CGRectGetMidY((self.view?.frame)!);
            tb_login.frame.origin.x = (CGRectGetWidth((self.view?.frame)!) - tb_login.frame.size.width)/2;
            tb_login.frame.origin.y = CGRectGetMidY((self.view?.frame)!) - 60;
        }
    }
}