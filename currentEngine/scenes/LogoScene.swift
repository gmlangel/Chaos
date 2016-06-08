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
    var isAniEnd:Bool! = false;
    static var instance:LogoScene{
        get{
            struct LogoSceneIns {
                static var _ins:LogoScene = LogoScene(size: GMLMain.instance.mainGameView.frame.size);
            }
            return LogoSceneIns._ins;
        }
    }
    
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
        isAniEnd = false;
        mainLogo.removeActionForKey("chuchang");
        mainLogo.runAction(logoAction, withKey: "chuchang")
    }
    
    override func ginit() {
        super.ginit();
        self.backgroundColor = SKColor.whiteColor();
        mainLogo = SKSpriteNode(imageNamed: "MainAssets1/logo/mainLog");
        mainLogo.alpha = 0;
        mainLogo.normalTexture = mainLogo.texture?.textureByGeneratingNormalMap();
        self.bgLayer.addChild(mainLogo);
        
        
        logoAction = SKAction.sequence([SKAction.performSelector(NSSelectorFromString("logoReset"), onTarget: self),SKAction.waitForDuration(0.5),SKAction.group([SKAction.fadeInWithDuration(0.3),SKAction.scaleTo(1, duration: 0.5)]),SKAction.waitForDuration(1),SKAction.performSelector(NSSelectorFromString("aniEnd"), onTarget: self)]);
        
        
    }
    

    
    func logoReset()
    {
        mainLogo.alpha = 0;
        mainLogo.xScale = 0.3;
        mainLogo.yScale = 0.3;
    }
    
    /**
     动画执行完毕
     */
    func aniEnd()
    {
        isAniEnd = true;
        NSNotificationCenter.defaultCenter().postNotificationName("changeScene", object: "PrelaodScene");
    }
    
    
    override func update(currentTime: NSTimeInterval) {
        //NSLog("\(self.frame)");
        
        
    }
    
    override func gresize(currentSize: CGSize) {
        mainLogo.position.x = CGRectGetMidX(self.frame)/self.bgLayer.xScale;
        mainLogo.position.y = CGRectGetMidY(self.frame)/self.bgLayer.yScale;
    }
}