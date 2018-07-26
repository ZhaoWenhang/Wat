//
//  learningYigouClassModel.h
//  wat
//
//  Created by 123 on 2018/6/28.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "learningYigouClassDetailModel.h"
@interface learningYigouClassModel : NSObject
@property (nonatomic, strong)NSArray<learningYigouClassDetailModel *> *list;
@property (nonatomic, strong) NSString *title;

@end
