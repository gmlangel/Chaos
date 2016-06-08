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
        
        //写scene mapbg消息
        //mainsceneMap
//        let str = GMLTool.documentPath()+"/DiqiuScene.plist";
//        let config = NSMutableDictionary(contentsOfFile: str);
//        let tarr:NSMutableArray = NSMutableArray();
//        
//        var i = 13;
//        var j = 13;
//        var tcount = j*13;
//        while(i>0){
//            tarr.addObject(["name":"mainsceneMap_\(tcount-i+1)","x":(13-i)*512+256,"y":(13-j)*512+256]);
//            if(i == 1)
//            {
//                j--;
//                tcount = j * 13;
//            }
//            i--;
//            if(j>0 && i == 0)
//            {
//                i = 13;
//            }
//        }
//        
//        config?.setValue(tarr, forKey: "bg");
//        
//        NSFileManager.defaultManager().createFileAtPath(GMLTool.documentPath()+"/DiqiuScene2.plist", contents: nil, attributes: nil);
//        config?.writeToFile(GMLTool.documentPath()+"/DiqiuScene2.plist", atomically: false);

        
        
        
        //启动游戏
        let arr = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true);
        GMLGameConfig.setLogPaths([arr[0]]);
        GMLGameConfig.setSourceScale(1);
        GMLMain.instance.start(self.skView);
        
        
    }
    
    
    
    
    func applicationShouldTerminateAfterLastWindowClosed(sender: NSApplication) -> Bool {
        return true
    }
}
