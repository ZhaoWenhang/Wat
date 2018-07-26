//
//  YigoumaiDetailModel.h
//  wat
//
//  Created by 123 on 2018/6/29.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YigoumaiDetailModel : NSObject
/**
"id":"17",
"uid":"1",
"order_no":"YX201806111140082151",
"goods_name":"这是一个电子课程这是一个电子课程这是一个电子课程这是一个电子课程这是一个电子课程这是一个电子课程",
"goods_price":"100.00",
"goods_pic":"http://admin.watcn.com/uploads/article/20180531/152773914837387243.jpg",
"goods_id":"52",
"shop_type":"2",
"num":"1",
"discounts_amount":"0.00",
"order_price":"100.00",
"total_price":"100.00",
"pay_type":"",
"pay_money":"",
"pay_time":"",
"pay_status":"2",
"pay_no":"",
"order_status":"2",
"mark":"",
"user_name":"",
"user_address":"",
"user_phone":"",
"create_time":"2018-06-11 11:40:08",
"dealer_id":"2",
"express_fee":"0",
"invite_code":"",
"shop_type_name":"线下活动"
*/
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *order_no;
@property (nonatomic, strong) NSString *goods_name;
@property (nonatomic, strong) NSString *goods_price;
@property (nonatomic, strong) NSString *goods_pic;
@property (nonatomic, strong) NSString *goods_id;
@property (nonatomic, strong) NSString *shop_type;
@property (nonatomic, strong) NSString *num;
@property (nonatomic, strong) NSString *discounts_amount;
@property (nonatomic, strong) NSString *order_price;
@property (nonatomic, strong) NSString *total_price;
@property (nonatomic, strong) NSString *pay_type;
@property (nonatomic, strong) NSString *pay_money;
@property (nonatomic, strong) NSString *pay_time;
@property (nonatomic, strong) NSString *pay_status;
@property (nonatomic, strong) NSString *pay_no;
@property (nonatomic, strong) NSString *order_status;
@property (nonatomic, strong) NSString *mark;
@property (nonatomic, strong) NSString *user_name;
@property (nonatomic, strong) NSString *user_address;
@property (nonatomic, strong) NSString *user_phone;
@property (nonatomic, strong) NSString *create_time;
@property (nonatomic, strong) NSString *dealer_id;
@property (nonatomic, strong) NSString *express_fee;
@property (nonatomic, strong) NSString *invite_code;
@property (nonatomic, strong) NSString *shop_type_name;
@property (nonatomic, strong) NSString *content_type;
@end
