//
//  WatHomeNewsModel.h
//  wat
//
//  Created by apple on 2018/6/14.
//  Copyright © 2018年 wat0801. All rights reserved.
//  最新文章

#import <Foundation/Foundation.h>

#import "WatHomeNewsDetailsModel.h"

@interface WatHomeNewsModel : NSObject

@property (nonatomic, strong) NSArray<WatHomeNewsDetailsModel *> *list;

@property (nonatomic, copy) NSString *column_name;

@property (nonatomic, copy) NSString *page;

@end
