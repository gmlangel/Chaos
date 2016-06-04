//  场景管理器
//  SceneManager.swift
//  Chaos
//
//  Created by guominglong on 16/6/4.
//  Copyright © 2016年 guominglong. All rights reserved.
//

import Foundation
class SceneManager: NSObject {
    static var instance:SceneManager{
        get{
            struct sceneStruct{
                static var _ins:SceneManager = SceneManager();
            }
            return sceneStruct._ins;
        }
    }
    /**
     场景集合
     */
    var sceneDic:[String:GMLScene]!;
    
    override init()
    {
        super.init();
        sceneDic = [String:GMLScene]();
    }
    
    
}