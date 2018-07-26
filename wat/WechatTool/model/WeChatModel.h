//
//  WeChatModel.h
//  wat
//
//  Created by 123 on 2018/7/3.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeChatPayGetDetailModel.h"
@interface WeChatModel : NSObject

@property (nonatomic, strong)NSString *order_id;
@property (nonatomic, strong)WeChatPayGetDetailModel *weChatPayGetDetailModel;


///api/order/go-pay-class
+ (void)asyncPostkApiOrderGoPayClassSuccessBlock:(void(^)(WeChatModel *wechatModel))successBlock errorBlock:(void(^)(NSError *errorResult))errorBlock paramDic:(NSMutableDictionary *)paramDic urlStr:(NSString *)urlStr;


@end
