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
    
    
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view);

    }
    
    
    override func ginit() {
        super.ginit();
        self.backgroundColor = SKColor.blackColor();
        bgNode = SKSpriteNode(texture: GMLResourceManager.instance.textureByName("loginScene_bg")).autoScreen();
        self.bgLayer.addChild(bgNode);

        
        btn_beginGame = SKSpriteNode(color: SKColor.whiteColor(), size: CGSize(width: 120, height: 30)).autoScreen();
        let btn_beginGameLabel:SKLabelNode = SKLabelNode(text: "开始");
        btn_beginGameLabel.fontColor = SKColor.redColor();
        btn_beginGameLabel.verticalAlignmentMode = .Center;
        btn_beginGameLabel.horizontalAlignmentMode = .Center;
        btn_beginGame.addChild(btn_beginGameLabel);

        self.contextContainerLayer.addChild(btn_beginGame);

        
    }
    
    
    
    
    override func gresize(currentSize: CGSize) {
        bgNode.position.x = CGRectGetMidX(self.frame);
        bgNode.position.y = CGRectGetMidY(self.frame);
        btn_beginGame.position.x = bgNode.position.x;
        btn_beginGame.position.y = CGRectGetMidY(self.frame) / 2;
    }
}