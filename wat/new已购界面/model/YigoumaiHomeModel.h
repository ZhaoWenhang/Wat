//
//  YigoumaiHomeModel.h
//  wat
//
//  Created by 123 on 2018/6/29.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YigoumaiClassModel.h"
#import "YigoumaiActiveModel.h"
#import "YigoumaiBookModel.h"
@interface YigoumaiHomeModel : NSObject

@property (nonatomic, strong) YigoumaiClassModel *classes;
@property (nonatomic, strong) YigoumaiBookModel *book;;
@property (nonatomic, strong) YigoumaiActiveModel *active;

//已购页面
+ (void)asyncPostkApiOrderListPageSuccessBlock:(void(^)(YigoumaiHomeModel *yigoumaiHomeModel))successBlock errorBlock:(void(^)(NSError *errorResult))errorBlock paramDic:(NSMutableDictionary *)paramDic urlStr:(NSString *)urlStr;

@end
