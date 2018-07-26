//
//  WatLearningHomeModel.h
//  wat
//
//  Created by 123 on 2018/6/28.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "learningYigouClassModel.h"
#import "learningHistoryClassModel.h"
@interface WatLearningHomeModel : NSObject

@property (nonatomic, strong) learningYigouClassModel *yigouClass;
@property (nonatomic, strong) learningHistoryClassModel *historyClass;

// 学习接口  kApiOrderMyClass
+ (void)asyncPostWatLearningHomeModelSuccessBlock:(void(^)(WatLearningHomeModel *watLearningHomeModel))successBlock errorBlock:(void(^)(NSError *errorResult))errorBlock paramDic:(NSMutableDictionary *)paramDic urlStr:(NSString *)urlStr;

+ (void)asyncPostDeleteHistorySuccessBlock:(void(^)(WatLearningHomeModel *watLearningHomeModel))successBlock errorBlock:(void(^)(NSError *errorResult))errorBlock paramDic:(NSMutableDictionary *)paramDic urlStr:(NSString *)urlStr;


@end
