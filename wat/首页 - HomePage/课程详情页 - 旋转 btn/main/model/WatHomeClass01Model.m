//
//  WatHomeClass01Model.m
//  wat
//
//  Created by 123 on 2018/7/2.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "WatHomeClass01Model.h"

@implementation WatHomeClass01Model
+ (void)asyncPostkApiEducationDetailSuccessBlock:(void (^)(WatHomeClass01Model *))successBlock errorBlock:(void (^)(NSError *))errorBlock paramDic:(NSMutableDictionary *)paramDic urlStr:(NSString *)urlStr{
    [Request POST:urlStr parameters:paramDic success:^(id responseObject) {
        WatHomeClass01Model *watHomeClass01Model = [WatHomeClass01Model dataParsingByDic:responseObject[@"result"][@"data"]];
        if (successBlock) {
            successBlock(watHomeClass01Model);
        }
    } failure:^(NSError *error) {
        
    }];
    
}

+ (WatHomeClass01Model *)dataParsingByDic:(NSDictionary *)dic{
    WatHomeClass01Model *watHomeClass01Model = [WatHomeClass01Model new];
    
    WatHomeClassGoodsModel *watHomeClassGoodsModel = [WatHomeClassGoodsModel modelWithDictionary:dic[@"goods"]];
    watHomeClass01Model.goods = watHomeClassGoodsModel;
   
    watHomeClass01Model.list = [NSArray modelArrayWithClass:[WatHomeClassListDetailModel class] json:dic[@"list"]];
    
    
    watHomeClass01Model.is_buy = [dic objectForKey:@"is_buy"];
    watHomeClass01Model.yongjin = [dic objectForKey:@"yongjin"];
    
    return watHomeClass01Model;
}

@end
