//
//  WatHomeHotDetailsModel.m
//  wat
//
//  Created by apple on 2018/6/14.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "WatHomeHotDetailsModel.h"

@implementation WatHomeHotDetailsModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"goods_id" : @"id",@"subTitle":@"description"};
}

@end
