//
//  apppayRecordsListModel.m
//  wat
//
//  Created by 123 on 2018/7/9.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "apppayRecordsListModel.h"

@implementation apppayRecordsListModel
+ (void)asyncPostkApiAppPayUseListSuccessBlock:(void (^)(apppayRecordsListModel *))successBlock errorBlock:(void (^)(NSError *))errorBlock paramDic:(NSMutableDictionary *)paramDic urlStr:(NSString *)urlStr{
    [Request POST:urlStr parameters:paramDic success:^(id responseObject) {
        apppayRecordsListModel *listModel = [apppayRecordsListModel dataParsingByDic:responseObject[@"result"][@"data"]];
        if (successBlock) {
            successBlock(listModel);
        }
    } failure:^(NSError *error) {
        
    }];
    
}
// 数据解析
+ (apppayRecordsListModel *)dataParsingByDic:(NSDictionary *)dic {
    apppayRecordsListModel *listModel = [apppayRecordsListModel new];
    
    listModel.page = [dic valueForKey:@"page"];
    
    
    listModel.list = [NSArray modelArrayWithClass:[apppayRecordsModel class] json:dic[@"list"]];
    
    
    return listModel;
}

@end
