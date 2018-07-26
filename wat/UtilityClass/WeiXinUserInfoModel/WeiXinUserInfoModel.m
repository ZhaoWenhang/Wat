//
//  WeiXinUserInfoModel.m
//  wat
//
//  Created by 123 on 2018/6/19.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "WeiXinUserInfoModel.h"

@implementation WeiXinUserInfoModel
+ (void)asyncPostWeiChatUserInfoSuccessBlock:(void (^)(WeiXinUserInfoModel *))successBlock errorBlock:(void (^)(NSError *))errorBlock paramDic:(NSMutableDictionary *)paramDic urlStr:(NSString *)urlStr{
    
    [Request POST:urlStr parameters:paramDic success:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];
    
}

@end
