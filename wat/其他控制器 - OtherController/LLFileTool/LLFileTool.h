//
//  LLFileTool.h
//  wat
//
//  Created by 123 on 2018/7/5.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLFileTool : NSObject
/**
 删除文件夹所有文件
 
 @param directoryPath 文件夹路径
 */
+ (void)removeDirectoryPath:(NSString *)directoryPath;

/**
 获取文件夹尺寸
 
 @param directoryPath 文件夹路径
 @param completion 文件夹尺寸
 */
+ (void)getFileSize:(NSString *)directoryPath completion:(void(^)(NSInteger totalSize))completion;
@end
