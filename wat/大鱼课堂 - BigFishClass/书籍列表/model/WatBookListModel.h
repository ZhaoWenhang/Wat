//
//  WatBookListModel.h
//  wat
//
//  Created by 123 on 2018/6/19.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WatBookDetailModel.h"
@interface WatBookListModel : NSObject

@property (nonatomic, strong) NSArray<WatBookDetailModel *> *bookList;

// 用户数据接口
+ (void)asyncPostEducationBookListSuccessBlock:(void(^)(WatBookListModel *watBookList))successBlock errorBlock:(void(^)(NSError *errorResult))errorBlock paramDic:(NSMutableDictionary *)paramDic urlStr:(NSString *)urlStr;



@end
