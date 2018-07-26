//
//  OrderDetailModel.h
//  wat
//
//  Created by 123 on 2018/7/4.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderDetailModel : NSObject

//"thumb_path":"http://admin.watcn.com/uploads/article/20180621/152957234410827950.jpg",
//"title":"外卖致胜的8大基本功",
//"price":"0.10",
//"online_start":"2018-05-24 00:00:00",
//"online_end":"2018-08-31 00:00:00",
//"shop_type":"2",
//"sort":"1000",
//"sale_num":"203",
//"is_sale":"1",
//"description":"补贴减少、市场下沉，曾经顺风顺水不费吹灰之力的外卖运营已经成为过去，一些隐藏了近两年的痛点，开始显现，吞噬老板们的利润。",
//"tags":[
//        "知识付费",
//        "餐饮"
//        ],
//"add_time":"2018-05-31 15:12:57",
//"author":"小二哥",
//"goods_type":"1",
//"id":"53",
//"oid":"384",
//"total_price":"1.00",
//"num":"1",
//"create_time":"2018-07-03 16:26:00",
//"ticket_no":"5b3adc5761111",
//"url":"http://h5.watcn.com/education/content?id=53",
//"shop_type_name":"线下活动",
//"ewm":"http://api.watcn.com/api/public/get-ewm?url=5b3adc5761111"
@property (nonatomic, strong)NSString *thumb_path;
@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSString *price;
@property (nonatomic, strong)NSString *online_start;
@property (nonatomic, strong)NSString *online_end;
@property (nonatomic, strong)NSString *shop_type;
@property (nonatomic, strong)NSString *sort;
@property (nonatomic, strong)NSString *sale_num;
@property (nonatomic, strong)NSString *is_sale;
@property (nonatomic, strong)NSString *subTitle;
@property (nonatomic, strong)NSString *tags;
@property (nonatomic, strong)NSString *add_time;
@property (nonatomic, strong)NSString *author;
@property (nonatomic, strong)NSString *goods_type;
@property (nonatomic, strong)NSString *id;
@property (nonatomic, strong)NSString *oid;
@property (nonatomic, strong)NSString *total_price;
@property (nonatomic, strong)NSString *num;
@property (nonatomic, strong)NSString *create_time;
@property (nonatomic, strong)NSString *ticket_no;
@property (nonatomic, strong)NSString *url;
@property (nonatomic, strong)NSString *shop_type_name;
@property (nonatomic, strong)NSString *ewm;
@property (nonatomic, strong) NSString *share_url;
@property (nonatomic, strong) NSString *pay_type; //1: 微信 2: 余额
@property (nonatomic, strong) NSString *order_no; //订单编号

@end
