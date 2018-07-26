//
//  WatHomeMoreListModel.m
//  wat
//
//  Created by 123 on 2018/6/22.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "WatHomeMoreListModel.h"

@implementation WatHomeMoreListModel
+ (void)asyncPostkApiArticleListSuccessBlock:(void (^)(WatHomeMoreListModel *))successBlock errorBlock:(void (^)(NSError *))errorBlock paramDic:(NSMutableDictionary *)paramDic urlStr:(NSString *)urlStr{
    @synchronized(self) {
        
        [Request POST:urlStr parameters:paramDic success:^(id responseObject) {
            
            WatHomeMoreListModel *watHomeMoreListModel = [WatHomeMoreListModel dataParsingByDic:responseObject[@"result"][@"data"]];
            
            if (successBlock) {
                successBlock(watHomeMoreListModel);
            }
        } failure:^(NSError *error) {
            
        }];
    }
}
// 数据解析
+ (WatHomeMoreListModel *)dataParsingByDic:(NSDictionary *)dic {
    WatHomeMoreListModel *watHomeMoreListModel = [WatHomeMoreListModel new];
    //[watHomeNewsDetailsModel modelSetWithDictionary:dic];
   
    //watHomeMoreListModel.newsListArr = [NSArray arrayWithObject:dic[@"list"]].firstObject;
    watHomeMoreListModel.newsListArr = [NSArray modelArrayWithClass:[WatHomeNewsDetailsModel class] json:dic[@"list"]];
    
    watHomeMoreListModel.beginClassListArr = [NSArray modelArrayWithClass:[WatHomeWillBeginClassModel class] json:dic[@"list"]];
    
    watHomeMoreListModel.goodsListArr = [NSArray modelArrayWithClass:[WatHomeGoodsDetailsModel class] json:dic[@"list"]];
    
    watHomeMoreListModel.hotListArr = [NSArray modelArrayWithClass:[WatHomeHotDetailsModel class] json:dic[@"list"]];
    
    watHomeMoreListModel.page = dic[@"page"];
    
    return watHomeMoreListModel;
    
    
    
}
@end
