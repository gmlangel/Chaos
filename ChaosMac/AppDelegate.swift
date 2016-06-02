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
class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var skView: SKView!
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        /* Pick a size for the scene */
        if let scene = LogoScene(fileNamed:"GameScene") {
            /* Set the scale mode to scale to fit the window */
            
            self.skView!.presentScene(scene)
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            self.skView!.ignoresSiblingOrder = true
            
            self.skView!.showsFPS = true
            self.skView!.showsNodeCount = true
        }
        NSScreen.mainScreen()
        NSLog("\(NSScreen.mainScreen()!.backingScaleFactor)");
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(sender: NSApplication) -> Bool {
        return true
    }
}
