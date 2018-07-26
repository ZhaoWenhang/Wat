//
//  WeChatModel.m
//  wat
//
//  Created by 123 on 2018/7/3.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "WeChatModel.h"

@implementation WeChatModel

+(void)asyncPostkApiOrderGoPayClassSuccessBlock:(void (^)(WeChatModel *))successBlock errorBlock:(void (^)(NSError *))errorBlock paramDic:(NSMutableDictionary *)paramDic urlStr:(NSString *)urlStr{
    [Request POST:urlStr parameters:paramDic success:^(id responseObject) {
        WeChatModel *wechatModel = [WeChatModel dataParsingByDic:responseObject[@"result"][@"data"]];
        if (successBlock) {
            successBlock(wechatModel);
        }
    } failure:^(NSError *error) {
        
    }];
    
}

+ (WeChatModel *)dataParsingByDic:(NSDictionary *)dic{
    WeChatModel *wechatModel = [WeChatModel new];
    
    WeChatPayGetDetailModel *wechatPayGetDetailModel = [WeChatPayGetDetailModel modelWithDictionary:dic[@"pay"]];
    wechatModel.weChatPayGetDetailModel = wechatPayGetDetailModel;
    
    wechatModel.order_id = [dic objectForKey:@"order_id"];

    return wechatModel;
}

@end
