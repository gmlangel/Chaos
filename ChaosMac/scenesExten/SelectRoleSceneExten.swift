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
                static var _ins:SelectRoleSceneExten = SelectRoleSceneExten(fileNamed: "GameScene")!;
            }
            return SelectRoleSceneExtenExtenIns._ins;
        }
    }
}