//
//  WatHomeModel.m
//  wat
//
//  Created by apple on 2018/6/14.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "WatHomeModel.h"

@implementation WatHomeModel

+ (void)asyncPostSiteIndexSuccessBlock:(void(^)(WatHomeModel *watHomeModel))successBlock errorBlock:(void(^)(NSError *errorResult))errorBlock paramDic:(NSMutableDictionary *)paramDic urlStr:(NSString *)urlStr{
    @synchronized(self) {
        
        [Request POST:urlStr parameters:paramDic success:^(id responseObject) {
            
            WatHomeModel *watHomeModel = [WatHomeModel dataParsingByDic:responseObject[@"result"][@"data"]];
            if (successBlock) {
                successBlock(watHomeModel);
            }
        } failure:^(NSError *error) {
            
        }];
    }
}

// 数据解析
+ (WatHomeModel *)dataParsingByDic:(NSDictionary *)dic {
    WatHomeModel *watHomeModel = [WatHomeModel new];
    
    
    
    WatHomeNewsModel *news = [WatHomeNewsModel modelWithDictionary:dic[@"news"]];
    news.list = [NSArray modelArrayWithClass:[WatHomeNewsDetailsModel class] json:dic[@"news"][@"list"]];
    watHomeModel.news = news;
    
    WatHomeBeginClassesModel *goods_new = [WatHomeBeginClassesModel modelWithDictionary:dic[@"goods_new"]];
    goods_new.list = [NSArray modelArrayWithClass:[WatHomeWillBeginClassModel class] json:dic[@"goods_new"][@"list"]];
    watHomeModel.goods_new = goods_new;
    
    WatHomeGoodsModel *goods = [WatHomeGoodsModel modelWithDictionary:dic[@"goods"]];
    goods.list = [NSArray modelArrayWithClass:[WatHomeGoodsDetailsModel class] json:dic[@"goods"][@"list"]];
    watHomeModel.goods = goods;
    
    
    WatHomeHotModel *hot = [WatHomeHotModel modelWithDictionary:dic[@"hot"]];
    hot.list = [NSArray modelArrayWithClass:[WatHomeHotDetailsModel class] json:dic[@"hot"][@"list"]];
    watHomeModel.hot = hot;
    
    watHomeModel.hot_search = [[NSArray arrayWithObject:dic[@"hot_search"]]firstObject];
    
    watHomeModel.banner = [NSArray modelArrayWithClass:[WatHomeBannerModel class] json:dic[@"banner"]];
    

    
    
    return watHomeModel;
}




@end
