//
//  applepaySetDataModel.h
//  wat
//
//  Created by 123 on 2018/7/6.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "applepaySetDetailModel.h"
@interface applepaySetDataModel : NSObject
@property (nonatomic, strong)NSArray<applepaySetDetailModel *> *list;
@property (nonatomic, strong) NSString *ios_coin;
@property (nonatomic, strong) NSString *tishi;


//苹果支付接口 支付金额对照设置   /api/app-pay/pay-setting?id=1
+ (void)asyncPostkApiAppPayPaySettingSuccessBlock:(void(^)(applepaySetDataModel *applepaySetDataModel))successBlock errorBlock:(void(^)(NSError *errorResult))errorBlock paramDic:(NSMutableDictionary *)paramDic urlStr:(NSString *)urlStr;

@end
