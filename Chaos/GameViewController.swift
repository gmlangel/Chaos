//
//  GameViewController.swift
//  Chaos
//
//  Created by guominglong on 16/6/2.
//  Copyright (c) 2016年 guominglong. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.prefersStatusBarHidden = true;
//        self.supportedInterfaceOrientations = .landscape;
//        self.shouldAutorotate = true;
        let chatV:ChatView = ChatView(frame: CGRect(x: self.view.frame.size.width - 50, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height));
        self.view.addSubview(chatV);
        //启动游戏
        let arr = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true);
        GMLGameConfig.setLogPaths([arr[0]]);
        GMLGameConfig.setSourceScale(1.0/UIScreen.main.scale);
        GMLMain.instance.start(self.view as! SKView,_chatView: chatV);
    }
    
    



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

   
}
