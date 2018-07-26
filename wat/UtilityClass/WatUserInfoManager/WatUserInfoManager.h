//
//  WatUserInfoManager.h
//  wat
//
//  Created by 123 on 2018/6/15.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WatUserInfoModel.h"
@interface WatUserInfoManager : NSObject

// 是否登录 手机号 正式登陆
+ (BOOL)isLogin;

// 是否登录 手机号 游客登陆
+ (BOOL)isLoginUserID;

// 保存信息
+ (void)saveInfo:(WatUserInfoModel *)info;

// 获取信息
+ (WatUserInfoModel *)getInfo;

// 删除信息
+ (void)deleteInfo;
@end


//--------------------------------- 示例 ----------------------------------
///* 网络请求返回模型 */
//KMUserInfo *uInfo = [[KMUserInfo alloc] init];
//uInfo.name = @"贱发的名字";
//uInfo.height = @"1.50mm";
//uInfo.width = @"2.5mm";
//
///* 保存模型 */
//[KMUserInfoManager saveInfo:uInfo];
//
//NSLog(@"%@", uInfo.name);
//
///* 修改模型 */
//KMUserInfo *uInfo2 = [KMUserInfoManager getInfo];
//uInfo2.name = @"我改名字了";
//uInfo2.height = @"我改高度了2.50mm";
//uInfo2.width = @"我改宽度了3.50mm";
//[KMUserInfoManager saveInfo:uInfo2]; // 修改了模型的属性就要调用保存一下
//
///* 获取模型 */
//KMUserInfo *uInfo3 = [KMUserInfoManager getInfo];
