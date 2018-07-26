//
//  OrderModel.m
//  wat
//
//  Created by 123 on 2018/7/4.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "OrderModel.h"

@implementation OrderModel
+(void)asyncPostkApiOrderDetailSuccessBlock:(void (^)(OrderModel *))successBlock errorBlock:(void (^)(NSError *))errorBlock paramDic:(NSMutableDictionary *)paramDic urlStr:(NSString *)urlStr{
    [Request POST:urlStr parameters:paramDic success:^(id responseObject) {
        OrderModel *orderModel = [OrderModel dataParsingByDic:responseObject[@"result"][@"data"]];
        if (successBlock) {
            successBlock(orderModel);
        }
    } failure:^(NSError *error) {
        
    }];
    
}

+ (OrderModel *)dataParsingByDic:(NSDictionary *)dic{
    OrderModel *orderModel = [OrderModel new];
    
    OrderDetailModel *orderDetailModel = [OrderDetailModel modelWithDictionary:dic[@"detail"]];
    orderModel.orderDetailModel = orderDetailModel;
    
    
    
    return orderModel;
}
@end
