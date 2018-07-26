//
//  YigoumaiClassModel.h
//  wat
//
//  Created by 123 on 2018/6/29.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YigoumaiDetailModel.h"
@interface YigoumaiClassModel : NSObject
@property (nonatomic, strong) NSArray<YigoumaiDetailModel *> *list;
@property (nonatomic, strong) NSString *title;
@end
