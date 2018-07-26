//
//  WatHomeBeginClassesModel.h
//  wat
//
//  Created by 123 on 2018/6/22.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WatHomeWillBeginClassModel.h"
@interface WatHomeBeginClassesModel : NSObject
@property (nonatomic, strong) NSArray<WatHomeWillBeginClassModel *> *list;

@property (nonatomic, copy) NSString *column_name;
@end
