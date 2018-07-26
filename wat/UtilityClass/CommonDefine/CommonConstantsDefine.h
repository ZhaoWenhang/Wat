//
//  CommonConstantsDefine.h
//  wat
//
//  Created by apple on 2018/6/14.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#ifndef CommonConstantsDefine_h
#define CommonConstantsDefine_h

// 域名
#define kRealmNameForAppStore  @"http://api.watcn.com"
#define BundleIdentifier @"com.watcn.wat"

//微信二次请求,获取 unionid 等详细信息
#define kApiWeiChatUserInforUrl                     @"https://api.weixin.qq.com/sns/userinfo?access_token=ACCESS_TOKEN&openid=OPENID"
//-------------------------- 首页 ----------------------------
//短信接口 // type: (验证旧手机号)changephone  / (游客绑定手机号)setphone   login / bind_wx
#define kApiPublicSendSms                           @"/api/public/send-sms"
// 首页接口
#define kApiSiteIndex                               @"/api/site/index"
//书籍列表
#define kApiEducationBookList                       @"/api/education/book-list"
//线下活动列表
#define kApiEducationActiveList                     @"/api/education/active-list"
//线上课程列表 /api/education/line-list
#define kApiEducationLineList                       @"/api/education/line-list"
// 文章列表 /api/article/list
#define kApiArticleList                             @"/api/article/list"
//课程或商品详情 /api/education/detail
#define kApiEducationDetail                         @"/api/education/detail"
//线下课 书籍购买 /api/order/go-pay-class
#define kApiOrderGoPayClass                         @"/api/order/go-pay-class"
//学习结束时 记录学习进度 /api/education/write-history
#define kApiEducationWriteHistory                   @"/api/education/write-history"
// 新闻详情页
#define kApiArticleDetail                           @"/api/article/detail"


//---------------------------- 学习 ---------------------------
//学习页接口
#define kApiOrderMyClass                            @"/api/order/my-class"
//最近课程
#define kApiOrderMyHistory                          @"/api/order/my-history"
//删除历史记录
#define kApiOrderDeleteHistory                      @"/api/order/delete-history"
//我的课程
#define kApiOrderTypePage                           @"/api/order/type-page"



//--------------------------- 已购买 --------------------------
//已购页面
#define kApiOrderListPage                           @"/api/order/list-page"
//订单支付成功详情 /api/order/order-detail
#define kApiOrderOrderDetail                        @"/api/order/order-detail"

// ****************************** 我的 **************************
//登陆接口
#define kApiSitelogin                               @"/api/site/login"
//游客登录接口 /api/site/guest-login
#define kApiSiteGuestLogin                          @"/api/site/guest-login"
//获取用户信息
#define kApiUserUserInfo                            @"/api/user/user-info"
//更改用户信息
#define kApiUserSetUserInfo                         @"/api/user/set-user-info"
//投诉建议
#define kApiSiteProposal                            @"/api/site/proposal"
//微信登陆1
#define KApiWxLoginLogin                            @"/api/wx-login/login"
/**
 微信登录后绑定手机
 @return 微信登录后绑定手机
 */
#define kApiWxLoginBindPhone                        @"/api/wx-login/bind-phone"
//图片上传 /api/public/upload-pic?tag=header_pic
#define KapiPublicUploadPicTagHeaderPic             @"/api/public/upload-pic?tag=header_pic"
//我的余额币 /api/app-pay/get-my-cion
#define KApiAppPayGetMyCion                         @"/api/app-pay/get-my-cion"
//余额购买 /api/app-pay/buy
#define kApiAppPayBuy                               @"/api/app-pay/buy"
//ios 充值内参币  /api/app-pay/check-pay
#define kApiAppPayCheckPay                          @"/api/app-pay/check-pay"
//苹果支付接口 支付金额对照设置 /api/app-pay/pay-setting?id=1
#define kApiAppPayPaySetting                        @"/api/app-pay/pay-setting"
// 充值消费记录(内购明细)  /api/app-pay/use-list
#define kApiAppPayUseList                           @"/api/app-pay/use-list"
// 验证旧手机号 /api/site/user/verify-phone
#define kApiUserVerifyPhone                          @"/api/user/verify-phone"
//用户设置手机号 /api/user/change-phone
#define kApiUserChangePhone                          @"/api/user/change-phone"

// ------------------ 通知 ----------------
static NSString *const WatDeallocAudioControllerNotification = @"WatDeallocAudioControllerNotification"; //销毁音频控制器,发送的通知
static NSString *const WatRefeshAudioOrVideoDataNotification = @"WatRefeshAudioOrVideoDataNotification"; //刷新视图 音频或者视频的数据源

static NSString *const WechatPaySuccessNotification = @"WechatPaySuccessNotification"; //微信支付成功回调
static NSString *const WechatPayFailNotification = @"WechatPayFailNotification"; //微信支付失败回调
static NSString *const WechatLoginAddPhoneNotification = @"WechatLoginAddPhoneNotification"; //微信登陆成功,跳转绑定手机号页面
static NSString *const WatVideoNotPlayPopControllerNotification = @"WatVideoNotPlayPopControllerNotification"; //视频播放,在移动信号下停止播放,返回前一控制器
static NSString *const WatOnlineClassesBuy = @"WatOnlineClassesBuy"; //点击课程 cell,如果没购买,发通知,购买页面

#endif /* CommonConstantsDefine_h */
