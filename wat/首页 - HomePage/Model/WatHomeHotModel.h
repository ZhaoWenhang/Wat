//
//  WatHomeHotModel.h
//  wat
//
//  Created by apple on 2018/6/14.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WatHomeHotDetailsModel.h"

@interface WatHomeHotModel : NSObject

@property (nonatomic, strong) NSArray<WatHomeHotDetailsModel *> *list;

@property (nonatomic, copy) NSString *column_name;

@end
