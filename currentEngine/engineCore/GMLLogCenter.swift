//  日志中心
//  GMLLogCenter.swift
//  Chaos
//
//  Created by guominglong on 16/6/3.
//  Copyright © 2016年 guominglong. All rights reserved.
//

import Foundation
class GMLLogCenter:NSObject {
    /**
     程序运行打点数据的日志路径
     */
    private var runningLogPath:String!;
    private var runningFileHandler:NSFileHandle?;
    private var dateFormat:NSDateFormatter!;
    private var fileNameDateFormat:NSDateFormatter!;
    static var instance:GMLLogCenter{
        get{
            struct gmllgoIns {
                static var _ins:GMLLogCenter = GMLLogCenter();
            }
            return gmllgoIns._ins;
        }
        
        
    }
    
    
    /**
     启动日志系统
     */
    func start()
    {
        dateFormat = NSDateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss.fff";
        
        fileNameDateFormat = NSDateFormatter();
        fileNameDateFormat.dateFormat = "yyyy-MM-dd_HH_mm_ss";
        runningLogPath = String(format:"%@/game_current%@.log",GMLGameConfig.logPaths()[0],fileNameDateFormat.stringFromDate(NSDate()));

        
        if(!NSFileManager.defaultManager().fileExistsAtPath(runningLogPath))
        {
            //如果日志不存在，则手动创建日志
            do{
                try "".writeToFile(runningLogPath, atomically: true, encoding: NSUTF8StringEncoding);
                runningFileHandler = NSFileHandle(forUpdatingAtPath: runningLogPath);
            }catch{
                NSLog("创建日志路径失败:\(runningLogPath)");
            }
        }
        
    }
    
    /**
     输出日志(Debug模式)
     */
    public func trace(msg:String?,_needTrace:Bool = true,_needWriteToFile:Bool = true){
        if(msg == nil)
        {
            return ;
        }
        
        if(_needTrace)
        {
            NSLog(msg!);
        }
        if(_needWriteToFile)
        {
            runningFileHandler?.seekToEndOfFile();
            runningFileHandler?.writeData(msgAppendDateTime(msg!).dataUsingEncoding(NSUTF8StringEncoding)!);
        }
    }
    
    /**
     追加日志时间
     */
    private func msgAppendDateTime(msg:String)->String
    {
        return String(format: "[%@]%@", dateFormat.stringFromDate(NSDate()),msg);
    }
    
//    
//    /**
//     输出日志(release模式)
//     */
//    private func traceFuncRelease(msg:String?,_needTrace:Bool = true,_needWriteToFile:Bool = true){
//        if(msg == nil)
//        {
//            return ;
//        }
//        runningFileHandler?.seekToEndOfFile();
//        runningFileHandler?.writeData(msg!.dataUsingEncoding(NSUTF8StringEncoding)!);
//        
//    }
    
}