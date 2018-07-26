//
//  WatUserInfoModel.h
//  wat
//
//  Created by 123 on 2018/6/15.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#define kUserInfoKey @"WATUSERKEY"

#import <Foundation/Foundation.h>
/***************************  用户信息 *******************/
//单例
static NSString *const MYUserID = @"MYUserID";
static NSString *const MYUserHead_pic = @"";
static NSString *const MYUserPhone = @"";
static NSString *const MYUserPassword = @"";
static NSString *const MYUserWX_Open_id = @"";
static NSString *const MYUserName = @"";



@interface WatUserInfoModel : NSObject

@property (nonatomic, strong)NSString *address; //id
@property (nonatomic, strong)NSString *birthday;
@property (nonatomic, strong)NSString *company;
@property (nonatomic, strong)NSString *company_address;
@property (nonatomic, strong)NSString *created_at;
@property (nonatomic, strong)NSString *email;
@property (nonatomic, strong)NSString *head_pic;
@property (nonatomic, strong)NSString *id;
@property (nonatomic, strong)NSString *invitation_code;
@property (nonatomic, strong)NSString *job;
@property (nonatomic, strong)NSString *last_login_ip;
@property (nonatomic, strong)NSString *no_card;
@property (nonatomic, strong)NSString *phone;
@property (nonatomic, strong)NSString *register_place;
@property (nonatomic, strong)NSString *sex; //1男 2女
@property (nonatomic, strong)NSString *sign_ip;
@property (nonatomic, strong)NSString *status;
@property (nonatomic, strong)NSString *tel;
@property (nonatomic, strong)NSString *token;
@property (nonatomic, strong)NSString *truename;
@property (nonatomic, strong)NSString *unionid;
@property (nonatomic, strong)NSString *updated_at;
@property (nonatomic, strong)NSString *username;
@property (nonatomic, strong)NSString *wx_open_id;
@property (nonatomic, strong)NSString *headimgurl;
@property (nonatomic, strong)NSString *nickname;


// 用户数据接口
+ (void)asyncPostUserInfoSuccessBlock:(void(^)(WatUserInfoModel *watUserInfoModel))successBlock errorBlock:(void(^)(NSError *errorResult))errorBlock paramDic:(NSMutableDictionary *)paramDic urlStr:(NSString *)urlStr;
//SetUserInfo  修改用户数据
+ (void)asyncPostSetUserInfoSuccessBlock:(void(^)(WatUserInfoModel *watUserInfoModel))successBlock errorBlock:(void(^)(NSError *errorResult))errorBlock paramDic:(NSMutableDictionary *)paramDic urlStr:(NSString *)urlStr;
@end

//@interface WatUserModel :WatUserInfoModel
//
//
//
//
//@end
