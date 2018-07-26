//
//  apppayRecordsListModel.h
//  wat
//
//  Created by 123 on 2018/7/9.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "apppayRecordsModel.h"
@interface apppayRecordsListModel : NSObject
@property (nonatomic, strong)NSArray<apppayRecordsModel *> *list;
@property (nonatomic, strong)NSString *page;

//kApiAppPayUseList
+ (void)asyncPostkApiAppPayUseListSuccessBlock:(void(^)(apppayRecordsListModel *apppayRecordsListModel))successBlock errorBlock:(void(^)(NSError *errorResult))errorBlock paramDic:(NSMutableDictionary *)paramDic urlStr:(NSString *)urlStr;
@end
