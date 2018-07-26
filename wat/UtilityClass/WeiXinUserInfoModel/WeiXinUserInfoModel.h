//
//  WeiXinUserInfoModel.h
//  wat
//
//  Created by 123 on 2018/6/19.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeiXinUserInfoModel : NSObject
@property (nonatomic, strong)NSString *openid;
@property (nonatomic, strong)NSString *nickname;
@property (nonatomic, strong)NSString *sex;
@property (nonatomic, strong)NSString *province;
@property (nonatomic, strong)NSString *city;
@property (nonatomic, strong)NSString *country;
@property (nonatomic, strong)NSString *headimgurl;
@property (nonatomic, strong)NSArray *privilege;
@property (nonatomic, strong)NSString *unionid;

// 用户数据接口
+ (void)asyncPostWeiChatUserInfoSuccessBlock:(void(^)(WeiXinUserInfoModel *weiXinUserInfoModel))successBlock errorBlock:(void(^)(NSError *errorResult))errorBlock paramDic:(NSMutableDictionary *)paramDic urlStr:(NSString *)urlStr;

@end
