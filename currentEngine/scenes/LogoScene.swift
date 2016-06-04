//  程序第一次启动的第一个页面
//  LogoScene.swift
//  Chaos
//
//  Created by guominglong on 16/6/2.
//  Copyright © 2016年 guominglong. All rights reserved.
//

import Foundation
import SpriteKit
class LogoScene: GMLScene {
    
    private var mainLogo:SKSpriteNode!;
    private var logoAction:SKAction!;
    
    static var instance:GMLScene{
        get{
            if(SceneManager.instance.sceneDic.keys.contains("logoScene") == false)
            {
                SceneManager.instance.sceneDic["logoScene"] = LogoScene(fileNamed: "GameScene");
            }
            return SceneManager.instance.sceneDic["logoScene"]!;
        }
    }
    
    override func didMoveToView(view: SKView) {
        if(!isInited)
        {
            ginit();
        }
        
        mainLogo.removeActionForKey("chuchang");
        mainLogo.runAction(logoAction, withKey: "chuchang")
    }
    
    override func ginit() {
        super.ginit();
        self.backgroundColor = SKColor.whiteColor();
        mainLogo = SKSpriteNode(imageNamed: "MainAssets/logo/mainLog").autoScreen();
        mainLogo.alpha = 0;
        mainLogo.normalTexture = mainLogo.texture?.textureByGeneratingNormalMap();
        mainLogo.position = CGPoint(x:CGRectGetMidX(self.frame),y:CGRectGetMidY(self.frame));
        self.addChild(mainLogo);
        
        
        logoAction = SKAction.sequence([SKAction.performSelector(NSSelectorFromString("logoReset"), onTarget: self),SKAction.waitForDuration(0.5),SKAction.group([SKAction.fadeInWithDuration(0.3),SKAction.scaleTo(autoScreen(1), duration: 0.5)])]);
        
    }
    
    func logoReset()
    {
        mainLogo.alpha = 0;
        mainLogo.xScale = autoScreen(0.3);
        mainLogo.yScale = autoScreen(0.3);
    }
    
    override func didChangeSize(oldSize: CGSize) {
        if(isInited == true)
        {
            mainLogo.position.x = CGRectGetMidX(self.frame);
            mainLogo.position.y = CGRectGetMidY(self.frame);
        }
    }
    
    override func update(currentTime: NSTimeInterval) {
        //NSLog("\(self.frame)");
        
        
    }
}