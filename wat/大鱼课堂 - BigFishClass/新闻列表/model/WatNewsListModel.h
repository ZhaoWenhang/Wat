//
//  WatNewsListModel.h
//  wat
//
//  Created by 123 on 2018/6/19.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WatNewsDetailModel.h"
@interface WatNewsListModel : NSObject
@property (nonatomic, strong)NSArray<WatNewsDetailModel *> *newsList;



@end
