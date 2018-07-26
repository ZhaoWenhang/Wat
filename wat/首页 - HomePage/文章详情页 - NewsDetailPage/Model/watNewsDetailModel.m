//
//  watNewsDetailModel.m
//  wat
//
//  Created by 123 on 2018/7/14.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "watNewsDetailModel.h"

@implementation watNewsDetailModel
+ (void)asyncPostkApiArticleDetailSuccessBlock:(void (^)(watNewsDetailModel *))successBlock errorBlock:(void (^)(NSError *))errorBlock paramDic:(NSMutableDictionary *)paramDic urlStr:(NSString *)urlStr{
    [Request POST:urlStr parameters:paramDic success:^(id responseObject) {
        watNewsDetailModel *watNewsDetail = [watNewsDetailModel dataParsingByDic:responseObject[@"result"][@"data"]];
        if (successBlock) {
            successBlock(watNewsDetail);
        }
    } failure:^(NSError *error) {
        
    }];
    
}

+ (watNewsDetailModel *)dataParsingByDic:(NSDictionary *)dic{
    watNewsDetailModel *watNewsDetail = [watNewsDetailModel new];

    watNewsDetail.title = [dic objectForKey:@"title"];
    watNewsDetail.thumb = [dic objectForKey:@"thumb"];
    watNewsDetail.desc = [dic objectForKey:@"desc"];
    watNewsDetail.url = [dic objectForKey:@"url"];
    
    return watNewsDetail;
}
@end
