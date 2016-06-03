//
//  AppDelegate.swift
//  ChaosMac
//
//  Created by guominglong on 16/6/2.
//  Copyright (c) 2016年 guominglong. All rights reserved.
//


import Cocoa
import SpriteKit

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate,ZipArchiveDelegate {
    
    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var skView: SKView!
    let zipTool = ZipArchive();
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        /* Pick a size for the scene */
        
        
        //启动游戏
        let arr = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true);
        GMLGameConfig.setLogPaths([arr[0]]);
        GMLGameConfig.setSourceScale(1);
        GMLMain.instance.start(skView);
        
        
        
        zipTool.delegate = self;
        if(zipTool.UnzipOpenFile(NSBundle.mainBundle().pathForResource("/MainAssets/logo/test", ofType: "zip"))){
            zipTool.UnzipFileToDictionary_Async()
        }
        
    }
    
    func ErrorMessage(msg: String!) {
        GMLLogCenter.instance.trace(msg);
    }
    
    func UnzipFileAsyncComplete(reusltDic: NSMutableDictionary!) {
        NSLog("\(reusltDic.count)");
        zipTool.CloseZipFile2();
        (reusltDic.valueForKey(reusltDic.allKeys[0] as! String) as! NSData).writeToFile(GMLGameConfig.logPaths()[0] + "/bbb.png", atomically: true)
        
    }
    
    
    func applicationShouldTerminateAfterLastWindowClosed(sender: NSApplication) -> Bool {
        return true
    }
}
