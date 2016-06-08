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
    private var textureDic:[String:SKTexture]!;
    
    /**
     存储资源名称对应texture和媒体资源的NSData
     */
    private var resourceDataDic:[String:NSData]!;
    
    /**
     存储资源名称对照表
     */
    private var resourceTable:[String:[String]]!;
    
    /**
     存储资源名称对应配置文件
     */
    private var resourceConfitDic:[String:NSDictionary]!;
    
    
    private var zipTool:ZipArchive!;
    private var currentResourceKey:String!;//当前正在加载的资源包的KEY
    private var resourceIsLoading:Bool! = false;//是否正在加载一个资源
    
    /**
     等待加载的资源包
     */
    private var waitLoad:[[String:String]]!;
    
    
    private var completeSelectorTarget:AnyObject?;
    private var completeSelector:Selector?;
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
        resourceDataDic = [String:NSData]();
        resourceTable = [String:[String]]();
        resourceConfitDic = [String:NSDictionary]();
        waitLoad = [[String:String]]();
        zipTool = ZipArchive();
        zipTool.delegate = self;
    }
    
    /**
     资源包解压失败
     */
    func ErrorMessage(msg: String!) {
        GMLLogCenter.instance.trace(msg);
        waitLoad.removeAtIndex(0);
        loadResource();//判断是否还有 没被加载的资源包，并加载
    }
    
    /**
     资源包解压成功
     */
    func UnzipFileAsyncComplete(reusltDic: NSMutableDictionary!) {
        zipTool.CloseZipFile2();
        resourceTable[currentResourceKey] = [];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { 
            //解析resourceDic
            var keyStrNS:NSString;//key的NSString形式
            var extenName:String;//扩展名
            var keyStr:String;//key的String形式
            for key in reusltDic.allKeys
            {
                keyStrNS = key as! NSString;
                extenName = keyStrNS.pathExtension.lowercaseString;//获取扩展名
                keyStrNS = keyStrNS.stringByDeletingPathExtension.stringByReplacingOccurrencesOfString("/", withString: "_");//删除扩展名,同时将路径/  转换为_,最终获取文件名
                keyStr = keyStrNS as String;
                
                if(keyStr.containsString("__MACOSX") || extenName == "" || keyStr.containsString(".DS_Store"))
                {
                    //系统缓存文件或者没有扩展名的文件，不解析
                    continue;
                }else if(extenName == "plist")
                {
                    let filePath = GMLTool.documentPath() + "/\(key)";
                    //创建本地的临时配置文件，以供加载
                    if((reusltDic.valueForKey(key as! String) as! NSData).writeToFile(filePath, atomically: true))
                    {
                        if(key.containsString("Config."))
                        {
                            //主程序配置文件，一般情况下只有main资源包内才有两个这样的文件，分别是 AllMonsterConfig用于存储所有资源包内的monster的对照表。AllSceneConfig用于存储所有资源包内的scene的对照表
                        }else if(key.containsString("Scene."))
                        {
                            //场景配置文件
                        }else if(key.containsString("Monster.")){
                            //怪物配置文件
                        }
                        self.resourceConfitDic[keyStr] = NSDictionary(contentsOfFile: filePath);
                        //加载完毕后移除这个配置文件
                        do{
                            try NSFileManager.defaultManager().removeItemAtPath(filePath);
                            //配置文件,存储到资源名称对照表和配置集合中
                            self.resourceTable[self.currentResourceKey]!.append(keyStr);
                        }catch{
                            GMLLogCenter.instance.trace("[UnzipFileAsyncComplete]配置文件转换失败:\(key)");
                        }
                        
                    }
                }else if(extenName == "png" || extenName == "jpg")
                {
                    //texture资源,存储到资源名称对照表和资源集合中
                    self.resourceTable[self.currentResourceKey]!.append(keyStr);
                    self.resourceDataDic[keyStr] = reusltDic.valueForKey(key as! String) as! NSData;
                }else{
                    //媒体资源,存储到资源名称对照表和资源集合中
                    self.resourceTable[self.currentResourceKey]!.append(keyStr);
                    self.resourceDataDic[keyStr] = reusltDic.valueForKey(key as! String) as! NSData;
                }
            }
            
            dispatch_async(dispatch_get_main_queue(), {
                GMLLogCenter.instance.trace("[UnzipFileAsyncComplete]资源解压完毕:" + self.currentResourceKey);
                self.waitLoad.removeAtIndex(0);
                self.loadResource();//判断是否还有 没被加载的资源包，并加载
            })
        }
        
        
        
    }
    
    /**
     加载资源包
     */
    func loadResourcePick(key:String,resourcePath:String,completeSelector:Selector? = nil,completeSelectorTarget:AnyObject? = nil)
    {
        self.completeSelector = completeSelector;
        self.completeSelectorTarget = completeSelectorTarget;
        if(resourceTable.keys.contains(key))
        {
            //已经加载的资源包就不重复加载了
            GMLLogCenter.instance.trace("[loadResourcePick]不需要重复加载资源包:" + key);
            return;
        }
        waitLoad.append([key:resourcePath]);
        if(!resourceIsLoading)
        {
            //如果当前处于空闲状态，则直接开始加载资源。否则只能等待之前的资源加载完毕后，程序自动处理等待任务
            loadResource();
        }
    }
    
    private func loadResource()
    {
        if(waitLoad.count == 0)
        {
            resourceIsLoading = false;
            //执行加载完毕处理函数
            if(completeSelector != nil && completeSelectorTarget != nil)
            {
                if(completeSelectorTarget!.respondsToSelector(completeSelector!))
                {
                    completeSelectorTarget!.performSelector(completeSelector!);
                }
            }
            return;
        }
        resourceIsLoading = true;
        currentResourceKey = waitLoad[0].keys.first;
        if(zipTool.UnzipOpenFile(NSBundle.mainBundle().pathForResource(waitLoad[0].values.first, ofType: "zip"))){
            zipTool.UnzipFileToDictionary_Async()
        }else{
            GMLLogCenter.instance.trace("[loadResourcePick]资源包不存在 :"+currentResourceKey+"   "+waitLoad[0].values.first!);
            waitLoad.removeAtIndex(0);
            loadResource();
        }
    }
    
    /**
     根据纹理名称获得纹理
     */
    func textureByName(key:String)->SKTexture?
    {
        if(textureDic.keys.contains(key))
        {
            //遍历文理集合
            return textureDic[key];
        }
        else if(resourceDataDic.keys.contains(key)){
            //纹理集合中没有指定的纹理，则通过NSData创建一个纹理
            textureDic[key] = GMLTool.imageByData(resourceDataDic[key]! as NSData);
            return textureDic[key];
        }
        else{
            GMLLogCenter.instance.trace("[textureByName]请求的纹理资源不存在"+key);
            return nil;
        }
    }
    
    /**
     根据key获取配置文件
     */
    func configByName(key:String)->NSDictionary?{
        if(resourceConfitDic.keys.contains(key))
        {
            return resourceConfitDic[key];
        }else{
            return nil;
        }
    }
    
    
}