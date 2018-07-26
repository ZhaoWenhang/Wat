//
//  WatHomeModel.h
//  wat
//
//  Created by apple on 2018/6/14.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WatHomeBannerModel.h"

#import "WatHomeNewsModel.h"

#import "WatHomeGoodsModel.h"

#import "WatHomeHotModel.h"

#import "WatHomeNewsDetailsModel.h"

#import "WatHomeBeginClassesModel.h"
@interface WatHomeModel : NSObject

@property (nonatomic, strong) WatHomeNewsModel *news;
@property (nonatomic, strong) WatHomeGoodsModel *goods;
@property (nonatomic, strong) WatHomeHotModel *hot;
@property (nonatomic, strong) WatHomeBeginClassesModel *goods_new;
@property (nonatomic, strong) NSArray *hot_search; //热门搜索

@property (nonatomic, strong) NSArray<WatHomeBannerModel *> *banner;

// 首页接口
+ (void)asyncPostSiteIndexSuccessBlock:(void(^)(WatHomeModel *watHomeModel))successBlock errorBlock:(void(^)(NSError *errorResult))errorBlock paramDic:(NSMutableDictionary *)paramDic urlStr:(NSString *)urlStr;

@end
