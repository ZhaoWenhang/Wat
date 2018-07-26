//
//  YigoumaiHomeModel.m
//  wat
//
//  Created by 123 on 2018/6/29.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "YigoumaiHomeModel.h"

@implementation YigoumaiHomeModel
+(void)asyncPostkApiOrderListPageSuccessBlock:(void (^)(YigoumaiHomeModel *))successBlock errorBlock:(void (^)(NSError *))errorBlock paramDic:(NSMutableDictionary *)paramDic urlStr:(NSString *)urlStr{
    [Request POST:urlStr parameters:paramDic success:^(id responseObject) {
        YigoumaiHomeModel *yigoumaiHomeModel = [YigoumaiHomeModel dataParsingByDic:responseObject[@"result"][@"data"]];
        if (successBlock) {
            successBlock(yigoumaiHomeModel);
        }
    } failure:^(NSError *error) {
        
    }];
    
}

+ (YigoumaiHomeModel *)dataParsingByDic:(NSDictionary *)dic {
    YigoumaiHomeModel *yigoumaiHomeModel = [YigoumaiHomeModel new];
    
    YigoumaiActiveModel *yigoumaiActive = [YigoumaiActiveModel modelWithDictionary:dic[@"active"]];
    yigoumaiActive.list = [NSArray modelArrayWithClass:[YigoumaiDetailModel class] json:dic[@"active"][@"list"]];
    yigoumaiHomeModel.active = yigoumaiActive;
    
    YigoumaiClassModel *yigoumaiClasses = [YigoumaiClassModel modelWithDictionary:dic[@"class"]];
    yigoumaiClasses.list = [NSArray modelArrayWithClass:[YigoumaiDetailModel class] json:dic[@"class"][@"list"]];
    yigoumaiHomeModel.classes = yigoumaiClasses;
    
    YigoumaiBookModel *yigoumaiBook = [YigoumaiBookModel modelWithDictionary:dic[@"book"]];
    yigoumaiBook.list = [NSArray modelArrayWithClass:[YigoumaiDetailModel class] json:dic[@"book"][@"list"]];
    yigoumaiHomeModel.book = yigoumaiBook;
    
    return yigoumaiHomeModel;
    
}
@end
