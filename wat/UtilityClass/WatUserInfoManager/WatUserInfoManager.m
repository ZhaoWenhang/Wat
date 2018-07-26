//
//  WatUserInfoManager.m
//  wat
//
//  Created by 123 on 2018/6/15.
//  Copyright © 2018年 wat0801. All rights reserved.
//



#import "WatUserInfoManager.h"

@implementation WatUserInfoManager

+ (BOOL)isLogin {
    WatUserInfoModel *uDefault = [WatUserInfoManager getUserInfo];
    return ValidStr(uDefault.phone) ? YES : NO;
}

+ (BOOL)isLoginUserID {
    WatUserInfoModel *uDefault = [WatUserInfoManager getUserInfo];
    return ValidStr(uDefault.id) ? YES : NO;
}

+ (void)saveInfo:(WatUserInfoModel *)info {
    NSDictionary *infoDic = [info modelToJSONObject];
    if (infoDic.allKeys.count > 0) {
        NSUserDefaults *uDefault = [NSUserDefaults standardUserDefaults];
        [uDefault setObject:infoDic forKey:kUserInfoKey];
        [uDefault synchronize];
    }
}

+ (WatUserInfoModel *)getInfo {
    NSUserDefaults *uDefault = [NSUserDefaults standardUserDefaults];
    NSDictionary *infoDic = [uDefault objectForKey:kUserInfoKey];
    WatUserInfoModel *wat_userInfo = [WatUserInfoModel new];
    [wat_userInfo modelSetWithDictionary:infoDic];
    return wat_userInfo;
}

+ (WatUserInfoModel *)getUserInfo{
    NSUserDefaults *uDefault = [NSUserDefaults standardUserDefaults];
    NSDictionary *infoDic = [uDefault objectForKey:kUserInfoKey];
    WatUserInfoModel *wat_userInfo = [WatUserInfoModel new];
    [wat_userInfo modelSetWithDictionary:infoDic];
    return wat_userInfo;
    
}

+ (void)deleteInfo {
    NSUserDefaults *uDefault = [NSUserDefaults standardUserDefaults];
    [uDefault removeObjectForKey:kUserInfoKey];
}
@end
