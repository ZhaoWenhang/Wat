//
//  learningHistoryClassModel.h
//  wat
//
//  Created by 123 on 2018/6/28.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "learningHistoryClassDetailModel.h"
@interface learningHistoryClassModel : NSObject
@property (nonatomic, strong) NSArray<learningHistoryClassDetailModel *> *list;
@property (nonatomic, strong) NSString *page;
@end
