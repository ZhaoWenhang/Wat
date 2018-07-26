//
//  applepayGetmycionModel.h
//  wat
//
//  Created by 123 on 2018/7/6.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface applepayGetmycionModel : NSObject
@property (nonatomic, strong)NSString *ios_coin;
@property (nonatomic, strong)NSString *uid;
@property (nonatomic, strong)NSString *tishi;


//     查询余额:KApiAppPayGetMyCion
+ (void)asyncPostAppPayGetMyCionSuccessBlock:(void(^)(applepayGetmycionModel *getmycionModel))successBlock errorBlock:(void(^)(NSError *errorResult))errorBlock paramDic:(NSMutableDictionary *)paramDic urlStr:(NSString *)urlStr;
//余额支付:kApiAppPayBuy
+ (void)asyncPostkApiAppPayBuySuccessBlock:(void(^)(applepayGetmycionModel *getmycionModel))successBlock errorBlock:(void(^)(NSError *errorResult))errorBlock paramDic:(NSMutableDictionary *)paramDic urlStr:(NSString *)urlStr;
@end
