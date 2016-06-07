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
        mainLogo = SKSpriteNode(imageNamed: "MainAssets/logo/mainLog").autoScreen();
        mainLogo.alpha = 0;
        mainLogo.normalTexture = mainLogo.texture?.textureByGeneratingNormalMap();
        mainLogo.position = CGPoint(x:CGRectGetMidX(self.frame),y:CGRectGetMidY(self.frame));
        self.addChild(mainLogo);
        
        
        logoAction = SKAction.sequence([SKAction.performSelector(NSSelectorFromString("logoReset"), onTarget: self),SKAction.waitForDuration(0.5),SKAction.group([SKAction.fadeInWithDuration(0.3),SKAction.scaleTo(autoScreen(1), duration: 0.5)]),SKAction.waitForDuration(1),SKAction.performSelector(NSSelectorFromString("aniEnd"), onTarget: self)]);
        
        
       // NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: #selector(test), userInfo: nil, repeats: false);
    }
    
//    func test()
//    {
//        let sk = SKSpriteNode(texture: GMLResourceManager.instance.textureByName("monst1_1")).autoScreen();
//        addChild(sk);
//    }
    
    
    func logoReset()
    {
        mainLogo.alpha = 0;
        mainLogo.xScale = autoScreen(0.3);
        mainLogo.yScale = autoScreen(0.3);
    }
    
    /**
     动画执行完毕
     */
    func aniEnd()
    {
        isAniEnd = true;
    }
    
    
    override func update(currentTime: NSTimeInterval) {
        //NSLog("\(self.frame)");
        
        
    }
    
    override func gresize(currentSize: CGSize) {
        mainLogo.position.x = CGRectGetMidX(self.frame);
        mainLogo.position.y = CGRectGetMidY(self.frame);
    }
}