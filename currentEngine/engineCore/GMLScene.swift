//  场景基类
//  GMLScene.swift
//  Chaos
//
//  Created by guominglong on 16/6/2.
//  Copyright © 2016年 guominglong. All rights reserved.
//

import Foundation
import SpriteKit
class GMLScene:SKScene {
    /**
     是否初始化成功
     */
    private(set) var isInited:Bool! = false;
    
    
    /**
     初始化函数
     */
    func ginit()
    {
        isInited = true;
        self.scaleMode = .ResizeFill;
    }
}