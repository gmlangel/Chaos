//
//  GMLTool.m
//  Chaos
//
//  Created by guominglong on 16/6/4.
//  Copyright © 2016年 guominglong. All rights reserved.
//

#import "GMLTool.h"
#if (TARGET_OS_MAC && !TARGET_OS_SIMULATOR)
#import <AppKit/AppKit.h>
#elif(TARGET_OS_IOS || (TARGET_OS_MAC && TARGET_OS_SIMULATOR))
#import <UIKit/UIKit.h>
#endif
@implementation GMLTool

+(SKTexture * __nullable)imageByData:(NSData * __nonnull)fileData{
#if (TARGET_OS_MAC && !TARGET_OS_SIMULATOR)
    return [SKTexture textureWithImage:[[NSImage alloc] initWithData:fileData]];
#elif(TARGET_OS_IOS || (TARGET_OS_MAC && TARGET_OS_SIMULATOR))
    return [SKTexture textureWithImage:[UIImage imageWithData:fileData]];
#else
    return nil;
#endif
}
@end
