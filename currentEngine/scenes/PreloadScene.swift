//
//  PreloadScene.swift
//  Chaos
//
//  Created by guominglong on 16/6/8.
//  Copyright © 2016年 guominglong. All rights reserved.
//

import Foundation
import SpriteKit
class PreloadScene: GMLScene {
    
    //循环动画的资源
    private var textues:[SKTexture]!;//loading人物的资源
    private var loadtool:SKSpriteNode!;//loading条
    private var loadMaskMC:SKSpriteNode!;
    private var loadtoolAK:SKAction!;//loading条动画
    
    private var loadingNode:SKSpriteNode!;//loading人物
    private var loadingAk:SKAction!;
    private var loadingInterval:Double = 1/12;//loading动画的间隔
    private var tsize:CGSize!;
    public var loadingTime:NSTimeInterval! = 5;//loading动画的完整执行时间
    
    private var stopAc:SKAction!;
    private var wanttogoSceneName:String!;//将要去的下一个场景
    static var instance:PreloadScene{
        get{
            struct PreloadSceneIns{
                static var _ins:PreloadScene = PreloadScene(size: GMLMain.instance.mainGameView.frame.size);
            }
            return PreloadSceneIns._ins;
        }
    }
    
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view);
        loadMaskMC.size.width = tsize.width;
        loadMaskMC.runAction(loadtoolAK, withKey: "loadingtiao");
        loadingNode.runAction(loadingAk, withKey: "renwuloading");
    }
    
    override func ginit() {
        super.ginit();
        self.backgroundColor = SKColor.blackColor();
        textues = [];
        for i:Int in 0..<4
        {
            textues.append(SKTexture(imageNamed:"MainAssets1/preload/\(i)"));
        }
        //loading条
        loadtool = SKSpriteNode();
        tsize = CGSize(width:(self.frame.size.width - 80)/self.contextContainerLayer.xScale,height:20);
        let loadbg = SKShapeNode(rect: CGRect(x:-tsize.width/2,y:-tsize.height/2,width:tsize.width,height:tsize.height), cornerRadius: 10)
        loadbg.fillColor = SKColor.blueColor();
        loadbg.lineWidth = 0;
        loadtool.addChild(loadbg);
        
        loadMaskMC = SKSpriteNode(color: SKColor.blackColor(), size: tsize);
        loadMaskMC.anchorPoint.x = 1;
        loadMaskMC.position.x = tsize.width/2;
        loadtool.addChild(loadMaskMC);
        self.contextContainerLayer.addChild(loadtool);
        
        //loading人物
        loadingNode = SKSpriteNode(texture: textues[0]);
        self.contextContainerLayer.addChild(loadingNode);
        
        //loading动作
        loadingAk = SKAction.repeatActionForever(SKAction.animateWithTextures(textues, timePerFrame: loadingInterval,resize: true,restore: true));
        
        loadtoolAK = SKAction.resizeToWidth(0, duration: loadingTime);
        loadtoolAK.timingFunction = onloadtoolAKFuncUpdaet;
        
        stopAc = SKAction.sequence([SKAction.waitForDuration(1),SKAction.performSelector(NSSelectorFromString("onstopAni"), onTarget: self)]);
    }
    
    func onloadtoolAKFuncUpdaet(a:Float)->Float
    {
        loadingNode.position.x = loadMaskMC.position.x - loadMaskMC.size.width + loadtool.position.x;
        return a;
    }
    
    /**
     停止加载动画
     */
    func stopLoading(_wanttogoSceneName:String = ""){
        self.wanttogoSceneName = _wanttogoSceneName;
        loadMaskMC.removeAllActions();
        loadMaskMC.size.width = 0;
        loadingNode.position.x = loadMaskMC.position.x - loadMaskMC.size.width + loadtool.position.x;
        self.runAction(stopAc, withKey: "stopAc")
    }
    
    func onstopAni(){
        loadingNode.removeAllActions();
        self.removeAllActions();
        //如果wanttogoSceneName不为空字符串，则跳转至指定的场景
        if(wanttogoSceneName != "")
        {
            NSNotificationCenter.defaultCenter().postNotificationName("changeScene", object: wanttogoSceneName);
        }
    }
    
    override func gresize(currentSize: CGSize) {
        loadtool.position.x = self.size.width / self.contextContainerLayer.xScale / 2;
        loadingNode.position.y = self.size.height / self.contextContainerLayer.yScale / 2;
        loadtool.position.y = loadingNode.position.y - loadingNode.size.height / 2 - 40;
        loadingNode.position.x = loadMaskMC.position.x - loadMaskMC.size.width + loadtool.position.x;
        
    }
}