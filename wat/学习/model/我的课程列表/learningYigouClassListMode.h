//
//  learningYigouClassListMode.h
//  wat
//
//  Created by 123 on 2018/6/29.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "learningYigouClassDetailModel.h"
@interface learningYigouClassListMode : NSObject
@property (nonatomic, strong) NSArray<learningYigouClassDetailModel *> *list;
@property (nonatomic, strong) NSString *page;
+ (void)asyncPostSuccessBlock:(void(^)(learningYigouClassListMode *learningYigouClassListMode))successBlock errorBlock:(void(^)(NSError *errorResult))errorBlock paramDic:(NSMutableDictionary *)paramDic urlStr:(NSString *)urlStr;
@end
