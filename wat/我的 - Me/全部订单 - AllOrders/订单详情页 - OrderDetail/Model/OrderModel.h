//
//  OrderModel.h
//  wat
//
//  Created by 123 on 2018/7/4.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderDetailModel.h"

@interface OrderModel : NSObject
@property (nonatomic, strong)OrderDetailModel *orderDetailModel;


//订单支付成功详情 /api/order/order-detail
+ (void)asyncPostkApiOrderDetailSuccessBlock:(void(^)(OrderModel *orderModel))successBlock errorBlock:(void(^)(NSError *errorResult))errorBlock paramDic:(NSMutableDictionary *)paramDic urlStr:(NSString *)urlStr;


@end
