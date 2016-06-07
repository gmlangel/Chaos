//
//  SelectRoleSceneExten.swift
//  Chaos
//
//  Created by guominglong on 16/6/6.
//  Copyright © 2016年 guominglong. All rights reserved.
//

import Foundation
import SpriteKit
class SelectRoleSceneExten: SelectRoleScene {
    static var instance:SelectRoleSceneExten{
        get{
            struct SelectRoleSceneExtenExtenIns {
                static var _ins:SelectRoleSceneExten = SelectRoleSceneExten(size: GMLMain.instance.mainGameView.frame.size);
            }
            return SelectRoleSceneExtenExtenIns._ins;
        }
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        var p = (touches.first?.locationInNode(self))!;
        if(self.btn_in.frame.contains(p))
        {
            self.onBtn_inClick();
        }else if(self.btn_out.frame.contains(p))
        {
            self.onBtn_outClick();
        }
        p = (touches.first?.locationInNode(self.roleListPanel))!;
        self.roleListPanel.enumerateChildNodesWithName("role_[0-\(self.roleListPanel.children.count)]") { (sn, nm) in
            if(sn.containsPoint(p))
            {
                self.selectRoleNode(sn);
            }
        }
    }
}