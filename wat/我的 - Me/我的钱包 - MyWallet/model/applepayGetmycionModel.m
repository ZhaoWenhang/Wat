//
//  applepayGetmycionModel.m
//  wat
//
//  Created by 123 on 2018/7/6.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "applepayGetmycionModel.h"

@implementation applepayGetmycionModel
+ (void)asyncPostAppPayGetMyCionSuccessBlock:(void (^)(applepayGetmycionModel *))successBlock errorBlock:(void (^)(NSError *))errorBlock paramDic:(NSMutableDictionary *)paramDic urlStr:(NSString *)urlStr{
    [Request POST:urlStr parameters:paramDic success:^(id responseObject) {
        applepayGetmycionModel *getmycionModel = [applepayGetmycionModel dataParsingByDic:responseObject[@"result"][@"data"]];
        if (successBlock) {
            successBlock(getmycionModel);
        }
    } failure:^(NSError *error) {
        
    }];
    
}

// 数据解析
+ (applepayGetmycionModel *)dataParsingByDic:(NSDictionary *)dic {
    applepayGetmycionModel *getmycionModel = [applepayGetmycionModel new];
    
    getmycionModel.ios_coin = [dic objectForKey:@"ios_coin"];
    getmycionModel.uid = [dic objectForKey:@"uid"];
    getmycionModel.tishi = [dic objectForKey:@"tishi"];
    
    
    return getmycionModel;
}


+(void)asyncPostkApiAppPayBuySuccessBlock:(void (^)(applepayGetmycionModel *))successBlock errorBlock:(void (^)(NSError *))errorBlock paramDic:(NSMutableDictionary *)paramDic urlStr:(NSString *)urlStr{
    [Request POST:urlStr parameters:paramDic success:^(id responseObject) {
        applepayGetmycionModel *getmycionModel = [applepayGetmycionModel datasParsingByDic:responseObject[@"result"][@"data"]];
        if (successBlock) {
            successBlock(getmycionModel);
        }
    } failure:^(NSError *error) {
        
    }];
}
// 数据解析
+ (applepayGetmycionModel *)datasParsingByDic:(NSDictionary *)dic {
    applepayGetmycionModel *getmycionModel = [applepayGetmycionModel new];
    
    
    
    
    return getmycionModel;
}
@end
