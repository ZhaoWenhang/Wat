//
//  WatHomeWillBeginClassModel.m
//  wat
//
//  Created by 123 on 2018/6/22.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "WatHomeWillBeginClassModel.h"

@implementation WatHomeWillBeginClassModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"class_id" : @"id",
             @"subTitle" : @"description"
             };
}
@end
