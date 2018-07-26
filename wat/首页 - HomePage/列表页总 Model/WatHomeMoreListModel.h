//
//  WatHomeMoreListModel.h
//  wat
//
//  Created by 123 on 2018/6/22.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WatHomeNewsDetailsModel.h"//每日必读 书籍
#import "WatHomeWillBeginClassModel.h"//即将开课
#import "WatHomeGoodsDetailsModel.h"//精选课程
#import "WatHomeHotDetailsModel.h"//书籍

@interface WatHomeMoreListModel : NSObject
@property (nonatomic, strong) NSArray<WatHomeNewsDetailsModel *> *newsListArr;
@property (nonatomic, strong) NSArray<WatHomeWillBeginClassModel *> *beginClassListArr;
@property (nonatomic, strong) NSArray<WatHomeGoodsDetailsModel *> *goodsListArr;
@property (nonatomic, strong) NSArray<WatHomeHotDetailsModel *> *hotListArr;
@property (nonatomic, strong) NSString *page;


// 文章列表 kApiArticleList
+ (void)asyncPostkApiArticleListSuccessBlock:(void(^)(WatHomeMoreListModel *watHomeMoreListModel))successBlock errorBlock:(void(^)(NSError *errorResult))errorBlock paramDic:(NSMutableDictionary *)paramDic urlStr:(NSString *)urlStr;



@end
