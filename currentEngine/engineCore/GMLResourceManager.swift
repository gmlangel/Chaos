//  资源管理器
//  GMLResourceManager.swift
//  Chaos
//
//  Created by guominglong on 16/6/3.
//  Copyright © 2016年 guominglong. All rights reserved.
//

import Foundation
class GMLResourceManager:NSObject,ZipArchiveDelegate {
    /**
     文理集合
     */
    private(set) var textureDic:[String:SKTexture]!;
    
    
    private var resourcePicDic:[String:NSDictionary]!;
    
    
    private var zipTool:ZipArchive!;
    /**
     当前资源包的KEY
     */
    private var currentResourceKey:String!;
    
    static var instance:GMLResourceManager{
        get{
            struct gmlResourceIns {
                static var _ins:GMLResourceManager = GMLResourceManager();
            }
            return gmlResourceIns._ins;
        }
    }
    
    override init(){
        super.init();
        textureDic = [String:SKTexture]();
        resourcePicDic = [String:NSDictionary]();
        zipTool = ZipArchive();
        zipTool.delegate = self;
    }
    
    /**
     资源包解压失败
     */
    func ErrorMessage(msg: String!) {
        GMLLogCenter.instance.trace(msg);
    }
    
    /**
     资源包解压成功
     */
    func UnzipFileAsyncComplete(reusltDic: NSMutableDictionary!) {
        zipTool.CloseZipFile2();
        resourcePicDic[currentResourceKey] = reusltDic;
        GMLLogCenter.instance.trace("[UnzipFileAsyncComplete]资源解压完毕:" + currentResourceKey);
        
        //填充texture集合
        for key in reusltDic.allKeys
        {
            textureDic[key as! String] = GMLTool.imageByData(reusltDic.valueForKey(key as! String) as! NSData);
        }
    }
    
    /**
     加载资源包
     */
    func loadResourcePick(key:String,resourcePath:String)
    {//"/MainAssets/logo/test"
        currentResourceKey = key
        if(zipTool.UnzipOpenFile(NSBundle.mainBundle().pathForResource(resourcePath, ofType: "zip"))){
            zipTool.UnzipFileToDictionary_Async()
        }
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