//
//  WatHomeClass01Model.h
//  wat
//
//  Created by 123 on 2018/7/2.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WatHomeClassListModel.h"
#import "WatHomeClassGoodsModel.h"
@interface WatHomeClass01Model : NSObject
@property (nonatomic, strong) NSString *is_buy;
@property (nonatomic, strong) NSString *yongjin;
@property (nonatomic, strong) NSArray<WatHomeClassListDetailModel *> *list;
@property (nonatomic, strong) WatHomeClassGoodsModel *goods;



//课程或商品详情 kApiEducationDetail
+ (void)asyncPostkApiEducationDetailSuccessBlock:(void(^)(WatHomeClass01Model *watHomeClass01Model))successBlock errorBlock:(void(^)(NSError *errorResult))errorBlock paramDic:(NSMutableDictionary *)paramDic urlStr:(NSString *)urlStr;

@end
