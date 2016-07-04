//
//  ChatView.swift
//  Chaos
//
//  Created by guominglong on 16/6/20.
//  Copyright © 2016年 guominglong. All rights reserved.
//

import Foundation
class ChatView:SKView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.userInteractionEnabled = true;
        self.multipleTouchEnabled = true;
        self.backgroundColor = UIColor.redColor();
        let myScene = SKScene(size: CGSize(width: self.frame.size.width, height: self.frame.size.height))
        myScene.backgroundColor = SKColor.redColor();
        self.presentScene(myScene);
        
        //添加手势显示，隐藏
        let res2 = UISwipeGestureRecognizer(target: self, action: NSSelectorFromString("showPanel:"));
        res2.direction = .Left
        res2.numberOfTouchesRequired = 1;
        addGestureRecognizer(res2);
        
        let res3 = UISwipeGestureRecognizer(target: self, action: NSSelectorFromString("hidePanel:"));
        res3.direction = .Right
        res3.numberOfTouchesRequired = 1;
        addGestureRecognizer(res3);
    }
    
    func showPanel(e:UIGestureRecognizer)
    {
        UIView.beginAnimations("heihei", context: nil);
        UIView.setAnimationDuration(0.3);
        UIView.setAnimationCurve(.EaseInOut);
        self.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height);
        UIView.commitAnimations();
    }
    
    func hidePanel(e:UIGestureRecognizer)
    {
        UIView.beginAnimations("xixi", context: nil);
        UIView.setAnimationDuration(0.3);
        UIView.setAnimationCurve(.EaseInOut);
        self.frame = CGRect(x: self.frame.size.width - 50, y: 0, width: self.frame.size.width, height: self.frame.size.height);
        UIView.commitAnimations();
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
}