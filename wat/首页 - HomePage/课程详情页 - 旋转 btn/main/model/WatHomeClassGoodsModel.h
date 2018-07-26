//
//  WatHomeClassGoodsModel.h
//  wat
//
//  Created by 123 on 2018/7/2.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WatHomeClassGoodsModel : NSObject
//"title":"如何经营门店日流水3万+",
//"tags":[
//        "知识付费",
//        "餐饮"
//        ],
//"price":"0.01",
//"description":"从外卖常见误区、流量策略、竞价规划、活动设置、数据分析等外卖老板们最在意的8个痛",
//"sale_num":"328",
//"thumb":"http://admin.watcn.com/uploads/article/20180621/152956620495238688.jpg",
//"d_id":"2",
//"id":"54",
//"online_end":"5150466",
//"shop_type":"0",
//"shop_type_name":"在线课程",
//"conetent_url":"http://h5.watcn.com/education/content?id=54"

@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSString *tags;
@property (nonatomic, strong)NSString *price;
@property (nonatomic, strong)NSString *subTitle;
@property (nonatomic, strong)NSString *sale_num;
@property (nonatomic, strong)NSString *thumb;
@property (nonatomic, strong)NSString *d_id;
@property (nonatomic, strong)NSString *id;
@property (nonatomic, strong)NSString *online_end;
@property (nonatomic, strong)NSString *shop_type;
@property (nonatomic, strong)NSString *shop_type_name;
@property (nonatomic, strong)NSString *conetent_url;
@property (nonatomic, strong) NSString *share_url;

@end
