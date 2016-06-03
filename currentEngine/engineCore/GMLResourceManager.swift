//  资源管理器
//  GMLResourceManager.swift
//  Chaos
//
//  Created by guominglong on 16/6/3.
//  Copyright © 2016年 guominglong. All rights reserved.
//

import Foundation
class GMLResourceManager:NSObject {
    /**
     文理集合
     */
    private(set) var textureDic:[String:SKTexture]!;
    
    static var instance:GMLResourceManager{
        get{
            struct gmlResourceIns {
                static var _ins:GMLResourceManager = GMLResourceManager();
            }
            return gmlResourceIns._ins;
        }
    }
    
    override init(){
        textureDic = [String:SKTexture]();
    }
    
    
    
    /**
     根据纹理名称获得纹理
     */
    func textureByName(key:String)->SKTexture?
    {
        if(textureDic.keys.contains(key))
        {
            return textureDic[key];
        }else{
            GMLLogCenter.instance.trace("[textureByName]请求的纹理资源不存在"+key);
            return nil;
        }
    }
    
    
}