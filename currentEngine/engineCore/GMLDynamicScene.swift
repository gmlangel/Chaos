//  动态场景
//  GMLDynamicScene.swift
//  Chaos
//
//  Created by guominglong on 16/6/8.
//  Copyright © 2016年 guominglong. All rights reserved.
//

import Foundation
import SpriteKit
class GMLDynamicScene: GMLScene {
    var bgs:[SKSpriteNode]?;
    var mounsters:[GMLMonster]?;
    
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view);
    }
    
    override func ginit() {
        super.ginit();
        if(bgs != nil)
        {
            let j = bgs!.count;
            for i:Int in 0..<j
            {
                self.bgLayer.addChild(bgs![i]);
            }
        }
        
        if(mounsters != nil)
        {
            let j = mounsters!.count;
            for i:Int in 0..<j
            {
                self.contextContainerLayer.addChild(mounsters![i]);
            }
        }
    }
    
    /**
     销毁
     */
    func gDestroy(){
        if(mounsters != nil)
        {
            for mon in mounsters!{
                mon.gDestroy();
                mon.removeFromParent();
            }
            mounsters!.removeAll();
        }
        
        self.bgLayer.removeAllChildren();
        if(bgs != nil)
        {
            bgs?.removeAll();
        }
    }
    
    
}