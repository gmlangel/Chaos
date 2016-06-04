//  引擎主入口
//  GMLMain.swift
//  Chaos
//
//  Created by guominglong on 16/6/3.
//  Copyright © 2016年 guominglong. All rights reserved.
//

import Foundation
class GMLMain:NSObject {
    /**
     主游戏视图,唯一
     */
    private(set) var mainGameView:SKView!;
    static var instance:GMLMain{
        get{
            struct gmlMainIns {
                static var _ins:GMLMain = GMLMain();
            }
            return gmlMainIns._ins;
        }
    }
    
    /**
     游戏开始
     */
    func start(_mainView:SKView){
        //设置主视图
        mainGameView = _mainView;
        mainGameView.showsFPS = true;//显示fps
        mainGameView.showsNodeCount = true//显示当前屏幕中被渲染的节点数
        mainGameView.ignoresSiblingOrder = true;//启用外优化，增加渲染性能
        
        
        //启动log系统
        GMLLogCenter.instance.start();
        
        //呈现log页面 同时加载登录界面和引导界面的资源
        mainGameView.presentScene(LogoScene.instance);
        GMLResourceManager.instance.loadResourcePick("main", resourcePath: "/MainAssets/main")
    }
}