//
//  GMLTool.m
//  Chaos
//
//  Created by guominglong on 16/6/4.
//  Copyright © 2016年 guominglong. All rights reserved.
//

#import "GMLTool.h"
#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#elif (TARGET_OS_MAC && !TARGET_OS_SIMULATOR)
#import <AppKit/AppKit.h>
#elif(TARGET_OS_IOS || (TARGET_OS_MAC && TARGET_OS_SIMULATOR))
#import <UIKit/UIKit.h>
#endif


@implementation GMLTool
//NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSAllDomainsMask, true);
+(SKTexture * __nullable)imageByData:(NSData * __nonnull)fileData{
#if TARGET_OS_IPHONE
return [SKTexture textureWithImage:[UIImage imageWithData:fileData]];
#elif (TARGET_OS_MAC && !TARGET_OS_SIMULATOR)
return [SKTexture textureWithImage:[[NSImage alloc] initWithData:fileData]];
#elif(TARGET_OS_IOS || (TARGET_OS_MAC && TARGET_OS_SIMULATOR))
return [SKTexture textureWithImage:[UIImage imageWithData:fileData]];
#endif

}



+(NSString * __nonnull)documentPath{
    NSArray * arr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSAllDomainsMask, true);
    return [arr objectAtIndex:0];
}
@end
