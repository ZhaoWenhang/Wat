//
//  learningYigouClassListMode.m
//  wat
//
//  Created by 123 on 2018/6/29.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "learningYigouClassListMode.h"

@implementation learningYigouClassListMode

+ (void)asyncPostSuccessBlock:(void (^)(learningYigouClassListMode *))successBlock errorBlock:(void (^)(NSError *))errorBlock paramDic:(NSMutableDictionary *)paramDic urlStr:(NSString *)urlStr{
    
    [Request POST:urlStr parameters:paramDic success:^(id responseObject) {
        learningYigouClassListMode *learningYigouClassListModel = [learningYigouClassListMode dataParsingByDic:responseObject[@"result"][@"data"]];
        if (successBlock) {
            successBlock(learningYigouClassListModel);
        }
    } failure:^(NSError *error) {
        
    }];
    
}

+ (learningYigouClassListMode *)dataParsingByDic:(NSDictionary *)dic {
    learningYigouClassListMode *learningYigouClassList = [learningYigouClassListMode new];
    
    learningYigouClassList.list = [NSArray modelArrayWithClass:[learningYigouClassDetailModel class] json:dic[@"list"]];
    learningYigouClassList.page = dic[@"page"];
    return learningYigouClassList;
}

@end
