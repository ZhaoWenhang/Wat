//
//  ZWHHeader.h
//  wat
//
//  Created by 123 on 2018/6/3.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#ifndef ZWHHeader_h
#define ZWHHeader_h

#import "ZWHHelper.h"
#import "Request.h"


#import "CommonConstantsDefine.h"
#import "Tools.h"
#import "WATHud.h"

//--------------------- userModel ------------------
#import "WatUserInfoModel.h"
#import "WatUserInfoManager.h"
//------------------------ controller -----------------
#import "WatLoginViewController.h"                              //登陆界面
#import "ZWHTextFildViewController.h"                           //输入信息界面
#import "DXShareView.h"
#import "IDFVTools.h"                                           //获取 IDFV 设备唯一标识
//分享封装
//底部弹窗自定义
#import "DWDirectionPanGestureRecognizer.h"
#import "DWPopView.h"
#import "WatHomePageViewController.h"                           //首页


//--------------------- sanfang --------------------------
#import <NSObject+YYModel.h>
#import <YYKit/YYKit.h>
#import <IQKeyboardManager.h>
#import <SDWebImageManager.h>
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import <UMSocialCore/UMSocialCore.h>
#import <Masonry.h>
#import <MJRefresh.h>
#import "MXWechatConfig.h"// 微信支付

//--------------------- SDK 配置 --------------------------
#define UMAppKey        @"5b2896bca40fa37560000028"


// ----------------------  微信支付 -----------------------
#define WX_AppID        @"wx48892c078c752b89"//开户邮件中的（公众账号APPID或者应用APPID
#define WX_AppSecret    @"c649daca07eb57b985a2678629bf9e46" ///获取用户openid，可使用APPID对应的公众平台登录http://mp.weixin.qq.com 的开发者中心获取AppSecret。
#define MCH_ID  @"1505665971" //微信支付商户号
#define WX_PartnerKey @"29d94b7a6fa05299598b3e44ad587082" //安全校验码（MD5）密钥，商户平台登录账户和密码登录http://pay.weixin.qq.com 平台设置的“API密钥”，为了安全，请设置为以数字和字母组成的32字符串。




#endif /* ZWHHeader_h */
