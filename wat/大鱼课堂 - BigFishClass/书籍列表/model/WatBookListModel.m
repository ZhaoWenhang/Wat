//
//  WatBookListModel.m
//  wat
//
//  Created by 123 on 2018/6/19.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "WatBookListModel.h"

@implementation WatBookListModel

+(void)asyncPostEducationBookListSuccessBlock:(void (^)(WatBookListModel *))successBlock errorBlock:(void (^)(NSError *))errorBlock paramDic:(NSMutableDictionary *)paramDic urlStr:(NSString *)urlStr{
    
    
    [Request POST:urlStr parameters:paramDic success:^(id responseObject) {
        
        WatBookListModel *watBookListModel = [WatBookListModel dataParsingByDic:responseObject[@"result"][@"data"]];
        if (successBlock) {
            successBlock(watBookListModel);
        }
    } failure:^(NSError *error) {
        
    }];
    
    
}
+ (WatBookListModel *)dataParsingByDic:(NSDictionary *)dic {
    WatBookListModel *watBookListModel = [WatBookListModel new];
   
    watBookListModel.bookList = [NSArray modelArrayWithClass:[WatBookDetailModel class] json:dic[@"list"]];
    
    return watBookListModel;
}




@end
