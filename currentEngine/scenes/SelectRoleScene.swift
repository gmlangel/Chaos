//  人物选择界面
//  SelectRoleScene.swift
//  Chaos
//
//  Created by guominglong on 16/6/6.
//  Copyright © 2016年 guominglong. All rights reserved.
//

import Foundation
import SpriteKit
class SelectRoleScene: GMLScene {
    private var roleListPanel:SKSpriteNode!;
    private var roleSelectBg:SKSpriteNode!;
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view);
        
    }
    
    override func ginit() {
        super.ginit();
        self.backgroundColor = SKColor.blackColor();
        
        roleSelectBg = SKSpriteNode(color: SKColor.redColor(), size: CGSize(width: 150, height: 200));
        
        roleListPanel = SKSpriteNode(color: SKColor.clearColor(), size: CGSize(width: roleSelectBg.size.width * 4, height: roleSelectBg.size.height * 2));
        roleListPanel.xScale = autoScreen(1);
        roleListPanel.yScale = autoScreen(1);
        roleListPanel.addChild(roleSelectBg);
        self.contextContainerLayer.addChild(roleListPanel);
        
        //let lineHeight = roleSelectBg.size.height;
        var ty:CGFloat = 100;
        var tx:CGFloat = 0;
        for i:Int in 0..<8
        {
            if(i%4 == 0)
            {
                ty = ty + CGFloat(i/4) * roleSelectBg.size.height;
            }
            tx = CGFloat(i%4) * roleSelectBg.size.width + 50;
            let roleMc = SKSpriteNode(texture: GMLResourceManager.instance.textureByName("Test1Monster_0"));
            roleListPanel.addChild(roleMc);
            roleMc.position = CGPoint(x: tx, y: ty);
            if(i == 0)
            {//把角色选中背景 默认放置到第一个角色背后
                roleSelectBg.position = roleMc.position;
            }
        }
        
    }
    
    override func gresize(currentSize: CGSize) {
        roleListPanel.position.x = ((self.view?.frame.size.width)! -  roleListPanel.frame.size.width)/2;
        roleListPanel.position.y = ((self.view?.frame.size.height)! -  roleListPanel.frame.size.height)/2;
    }
    
    
}