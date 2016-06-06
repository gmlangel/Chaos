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
        GMLResourceManager.instance.loadResourcePick("main", resourcePath: "/MainAssets/main",completeSelector: NSSelectorFromString("onMainSorceLoadEnd"),completeSelectorTarget: self);
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: NSSelectorFromString("changeScene:"), name: "changeScene", object: nil);
    }
    
    /**
     当主资源包加载完毕，显示登录页面
     */
    func onMainSorceLoadEnd(){
        //添加一个计时器，确保logo场景动画播放完毕后再显示登陆场景
        HeartbeatManager.instance.addTask(NSSelectorFromString("canShowLoginScene"), ti: 1, tg: self, taskName: "canShowLoginScene",repeats: true);
    }
    
    func canShowLoginScene()
    {
        if(LogoScene.instance.isAniEnd == true)
        {
            HeartbeatManager.instance.removeTask("canShowLoginScene");
            //显示登陆页面
            mainGameView.presentScene(LoginSceneExten.instance, transition: SKTransition.fadeWithDuration(1));
        }
    }
    
    func changeScene(notify:NSNotification)
    {
        let sceneName = notify.object as! String;
        if("SelectRoleScene" == sceneName)
        {
            mainGameView.presentScene(SelectRoleSceneExten.instance, transition: SKTransition.fadeWithDuration(1));
        }
    }
}