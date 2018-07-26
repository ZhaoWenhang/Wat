//
//  OrderDetailModel.m
//  wat
//
//  Created by 123 on 2018/7/4.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "OrderDetailModel.h"

@implementation OrderDetailModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"subTitle" : @"description"};
}
@end
