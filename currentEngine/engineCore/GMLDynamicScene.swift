//  动态场景
//  GMLDynamicScene.swift
//  Chaos
//
//  Created by guominglong on 16/6/8.
//  Copyright © 2016年 guominglong. All rights reserved.
//

import Foundation
import SpriteKit
class GMLDynamicScene: GMLScene {
    private(set) var bgs:[SKSpriteNode]?;
    private(set) var mounsters:[GMLMonster]?;
    
    /**
     内容尺寸
     */
    private var contextSize:CGSize!;
    
    /**
     资源文件夹名称
     */
    private var folderName:String!;
    /**
     使用配置文件初始化场景
     */
    init(sceneConfig:NSDictionary) {
        //根据屏幕尺寸初始化场景
        super.init(size: GMLMain.instance.mainGameView.frame.size);
        
        //设置资源文件夹名称
        folderName = sceneConfig.valueForKey("folderName") as! String;
        //将图像位移到指定的入口坐标
        var dic = sceneConfig.valueForKey("enterPoint") as! NSDictionary;
        self.anchorPoint = CGPoint(x: -autoScreen(CGFloat(dic.valueForKey("x") as! NSNumber))/self.size.width, y: -autoScreen(CGFloat(dic.valueForKey("y") as! NSNumber))/self.size.height);
        //设置scene中呈现的内容尺寸
        dic = sceneConfig.valueForKey("contextSize") as! NSDictionary;
        contextSize = CGSize(width: autoScreen(CGFloat(dic.valueForKey("width") as! NSNumber)), height: autoScreen(CGFloat(dic.valueForKey("height") as! NSNumber)));
        
        if let bginfo = sceneConfig.valueForKey("bg") as? NSArray{
            let j = bginfo.count;
            var textureName:String;
            var obj:NSDictionary;
            bgs = [];
            for i:Int in 0..<j
            {
                obj = bginfo.objectAtIndex(i) as! NSDictionary;
                textureName = folderName + "_" + (obj.valueForKey("name") as! String);
                let bgNode = SKSpriteNode(texture: GMLResourceManager.instance.textureByName(textureName));
                bgs!.append(bgNode);
                bgNode.position = CGPoint(x: CGFloat(obj.valueForKey("x")! as! NSNumber), y: CGFloat(obj.valueForKey("y")! as! NSNumber));
            }
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view);
    }
    
    override func ginit() {
        super.ginit();
        self.backgroundColor = SKColor.redColor();
        if(bgs != nil)
        {
            let j = bgs!.count;
            for i:Int in 0..<j
            {
                self.bgLayer.addChild(bgs![i]);
            }
        }
        
        if(mounsters != nil)
        {
            let j = mounsters!.count;
            for i:Int in 0..<j
            {
                self.contextContainerLayer.addChild(mounsters![i]);
            }
        }

    }
    
    /**
     销毁
     */
    func gDestroy(){
        if(mounsters != nil)
        {
            for mon in mounsters!{
                mon.gDestroy();
                mon.removeFromParent();
            }
            mounsters!.removeAll();
        }
        
        self.bgLayer.removeAllChildren();
        if(bgs != nil)
        {
            bgs?.removeAll();
        }
    }
    
    
}