//
//  WatLearningHomeModel.m
//  wat
//
//  Created by 123 on 2018/6/28.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "WatLearningHomeModel.h"

@implementation WatLearningHomeModel
+ (void)asyncPostWatLearningHomeModelSuccessBlock:(void (^)(WatLearningHomeModel *))successBlock errorBlock:(void (^)(NSError *))errorBlock paramDic:(NSMutableDictionary *)paramDic urlStr:(NSString *)urlStr{
    [Request POST:urlStr parameters:paramDic success:^(id responseObject) {
        WatLearningHomeModel *watLearningHomeModel = [WatLearningHomeModel dataParsingByDic:responseObject[@"result"][@"data"]];
        if (successBlock) {
            successBlock(watLearningHomeModel);
        }
    } failure:^(NSError *error) {
        
    }];
    
}

// 数据解析
+ (WatLearningHomeModel *)dataParsingByDic:(NSDictionary *)dic {
    WatLearningHomeModel *watLearningHomeModel = [WatLearningHomeModel new];
    
    learningYigouClassModel *yigouClass = [learningYigouClassModel modelWithDictionary:dic[@"my_buy"]];
    yigouClass.list = [NSArray modelArrayWithClass:[learningYigouClassDetailModel class] json:dic[@"my_buy"][@"list"]];
    watLearningHomeModel.yigouClass = yigouClass;
    
    learningHistoryClassModel *historyClass = [learningHistoryClassModel modelWithDictionary:dic[@"history"]];
    historyClass.list = [NSArray modelArrayWithClass:[learningHistoryClassDetailModel class] json:dic[@"history"][@"list"]];
    watLearningHomeModel.historyClass = historyClass;
    
    return watLearningHomeModel;
}


+ (void)asyncPostDeleteHistorySuccessBlock:(void (^)(WatLearningHomeModel *))successBlock errorBlock:(void (^)(NSError *))errorBlock paramDic:(NSMutableDictionary *)paramDic urlStr:(NSString *)urlStr{
    [Request POST:urlStr parameters:paramDic success:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];
    
}

@end
