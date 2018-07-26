//
//  WatUserInfoModel.m
//  wat
//
//  Created by 123 on 2018/6/15.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "WatUserInfoModel.h"

@implementation WatUserInfoModel
+ (void)asyncPostUserInfoSuccessBlock:(void(^)(WatUserInfoModel *watUserInfoModel))successBlock errorBlock:(void(^)(NSError *errorResult))errorBlock paramDic:(NSMutableDictionary *)paramDic urlStr:(NSString *)urlStr{
    @synchronized(self) {
                
        [Request POST:urlStr parameters:paramDic success:^(id responseObject) {
            
            WatUserInfoModel *watUserInfoModel = [WatUserInfoModel dataParsingByDic:responseObject[@"result"][@"data"]];
            
            if (successBlock) {
                successBlock(watUserInfoModel);
            }
        } failure:^(NSError *error) {
            
        }];
    }
}

// 数据解析
+ (WatUserInfoModel *)dataParsingByDic:(NSDictionary *)dic {
    WatUserInfoModel *watUserInfoModel = [WatUserInfoModel new];
    [watUserInfoModel modelSetWithDictionary:dic];
    NSLog(@"%@",watUserInfoModel.phone);
    return watUserInfoModel;
}

+(void)asyncPostSetUserInfoSuccessBlock:(void (^)(WatUserInfoModel *))successBlock errorBlock:(void (^)(NSError *))errorBlock paramDic:(NSMutableDictionary *)paramDic urlStr:(NSString *)urlStr{
    [Request POST:urlStr parameters:paramDic success:^(id responseObject) {
        WatUserInfoModel *watUserInfoModel = [WatUserInfoModel dataParsingByDic:responseObject[@"result"][@"data"]];
        
        if (successBlock) {
            successBlock(watUserInfoModel);
        }
    } failure:^(NSError *error) {
        
    }];
    
    
}

@end
