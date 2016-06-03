//
//  GMLExtensions.m
//  Chaos
//
//  Created by guominglong on 16/6/3.
//  Copyright © 2016年 guominglong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GMLGameConfig.h"
#import <SpriteKit/SpriteKit.h>

@implementation SKSpriteNode (GMLEngineCore)

-(SKSpriteNode *)autoScreen{
    self.xScale = GMLGameConfig.sourceScale;
    self.yScale = GMLGameConfig.sourceScale;
    return self;
}

@end