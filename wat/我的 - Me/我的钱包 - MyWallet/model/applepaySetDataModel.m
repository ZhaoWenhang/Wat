//
//  applepaySetDataModel.m
//  wat
//
//  Created by 123 on 2018/7/6.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "applepaySetDataModel.h"

@implementation applepaySetDataModel
+ (void)asyncPostkApiAppPayPaySettingSuccessBlock:(void (^)(applepaySetDataModel *))successBlock errorBlock:(void (^)(NSError *))errorBlock paramDic:(NSMutableDictionary *)paramDic urlStr:(NSString *)urlStr{
    [Request POST:urlStr parameters:paramDic success:^(id responseObject) {
        applepaySetDataModel *app = [applepaySetDataModel dataParsingByDic:responseObject[@"result"][@"data"]];
        if (successBlock) {
            successBlock(app);
        }
    } failure:^(NSError *error) {
        
    }];
}
// 数据解析
+ (applepaySetDataModel *)dataParsingByDic:(NSDictionary *)dic {
    applepaySetDataModel *app = [applepaySetDataModel new];
    
   // applepaySetDetailModel *applepaySetDetailModel =[applepaySetDetailModel modelWithDictionary:dic[@"list"]];
    app.list = [NSArray modelArrayWithClass:[applepaySetDetailModel class] json:dic[@"list"]];
    app.ios_coin = [dic objectForKey:@"ios_coin"];
    app.tishi = [dic objectForKey:@"tishi"];
    
    return app;
}
@end
