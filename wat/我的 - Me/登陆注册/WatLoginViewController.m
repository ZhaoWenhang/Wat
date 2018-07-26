//
//  WatLoginViewController.m
//  wat
//
//  Created by 123 on 2018/5/22.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "WatLoginViewController.h"
#import "MessageCordView.h"
#import "WatWeiXinPhoneNumLoginViewController.h"
#import "WatHomePageViewController.h"
#pragma mark model
#import "WeiXinUserInfoModel.h"

@interface WatLoginViewController ()<UIScrollViewDelegate>
@property (nonatomic ,strong) UIScrollView *scrollView;
@property (nonatomic, strong) UITextField *PhoneNBTF;//手机号输入框
@property (nonatomic, strong) MessageCordView *coreView;//验证码输入框

//------------------- model -----------------
@property (nonatomic, strong) WatUserInfoModel *watUserInfoModel;
@property (nonatomic, strong) WeiXinUserInfoModel *weixinUserInforModel;
@end

@implementation WatLoginViewController
- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, MyKScreenWidth, MyKScreenHeight)];
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(MyKScreenWidth, MyKScreenHeight + 1);
    }
    return _scrollView;
}
-(WatUserInfoModel *)watUserInfoModel{
    if (!_watUserInfoModel) {
        _watUserInfoModel = [WatUserInfoModel new];
    }
    return _watUserInfoModel;
}
-(WeiXinUserInfoModel *)weixinUserInforModel{
    if (!_weixinUserInforModel) {
        _weixinUserInforModel = [WeiXinUserInfoModel new];
    }
    return _weixinUserInforModel;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    self.navigationController.navigationBarHidden = YES;
    self.navBarView.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.navigationController.navigationBarHidden = NO;
    self.navBarView.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.navBarView.hidden = YES;
    
    
    UIImageView *BGImageView = [[UIImageView alloc]initWithFrame:CGRectMake(-2, 0, MyKScreenWidth + 2, MyKScreenHeight)];
    BGImageView.image = [UIImage imageNamed:@"loginBGImage"];
    BGImageView.alpha = 1;
    [self.view addSubview:BGImageView];
    
//    UIButton *closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(MyKScreenWidth - 100, MyStatusBarHeight + 30, 90, 10)];
//    [closeBtn setTitle:@"随便看一下 >" forState:UIControlStateNormal];
//    [closeBtn setTitleColor:CommonAppColor forState:UIControlStateNormal];
//    closeBtn.titleLabel.font = commenAppFont(10);
//    [closeBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:closeBtn];
    
    UIImageView *logoImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 77, 77)];
    logoImgView.center = Center(MyKScreenWidth * 0.5, 77 * 1.5);
    logoImgView.image = [UIImage imageNamed:@"logoIcon"];
    logoImgView.layer.cornerRadius = 5;
    logoImgView.clipsToBounds = YES;
    [self.view addSubview:logoImgView];
    
    //微信朋友圈  检测是否安装微信
    if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatTimeLine]) {
        NSLog(@"安装了微信");
        [self setUIWechat];
        
    }else{
        NSLog(@"未安装微信");
        [self setUINOWechat];
    }
    
}



- (void)setUIWechat{
    UIButton *wechatLoginBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, MyKScreenWidth - 110, 39)];
    wechatLoginBtn.center = Center(MyKScreenWidth / 2, MyKScreenHeight - 187);
    [wechatLoginBtn setTitle:@"微信账号登陆" forState:UIControlStateNormal];
    [wechatLoginBtn setImage:[UIImage imageNamed:@"WeChatIcon"] forState:UIControlStateNormal];
    [wechatLoginBtn setTitleColor:CommonAppColor forState:UIControlStateNormal];
    wechatLoginBtn.titleLabel.font = commenAppFont(13);
    wechatLoginBtn.imageView.contentMode = 1;
    wechatLoginBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 20, 10, 20);
    wechatLoginBtn.layer.cornerRadius = 39/2;
    wechatLoginBtn.layer.borderColor = [CommonAppColor CGColor];
    wechatLoginBtn.layer.borderWidth = 1.0f;
    wechatLoginBtn.layer.masksToBounds = YES;// 这个属性很重要，把超出边框的部分去除
    [wechatLoginBtn addTarget:self action:@selector(wechatLoginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:wechatLoginBtn];
    
    
    UIButton *youkeLoginBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, MyKScreenWidth - 110, 39)];
    youkeLoginBtn.center = Center(MyKScreenWidth / 2, MyKScreenHeight - 137);
    [youkeLoginBtn setTitle:@"游客登录" forState:UIControlStateNormal];
    [youkeLoginBtn setTitleColor:CommonAppColor forState:UIControlStateNormal];
    youkeLoginBtn.titleLabel.font = commenAppFont(13);
    youkeLoginBtn.imageView.contentMode = 1;
    youkeLoginBtn.layer.cornerRadius = 39/2;
    youkeLoginBtn.layer.borderColor = [CommonAppColor CGColor];
    youkeLoginBtn.layer.borderWidth = 1.0f;
    youkeLoginBtn.layer.masksToBounds = YES;// 这个属性很重要，把超出边框的部分去除
    [youkeLoginBtn addTarget:self action:@selector(youkeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:youkeLoginBtn];
    
}
- (void)setUINOWechat{
    UIButton *wechatLoginBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, MyKScreenWidth - 110, 39)];
    wechatLoginBtn.center = Center(MyKScreenWidth / 2, MyKScreenHeight - 187);
    [wechatLoginBtn setTitle:@"手机号登陆" forState:UIControlStateNormal];
    [wechatLoginBtn setTitleColor:CommonAppColor forState:UIControlStateNormal];
    wechatLoginBtn.titleLabel.font = commenAppFont(13);
    wechatLoginBtn.imageView.contentMode = 1;
    wechatLoginBtn.layer.cornerRadius = 39/2;
    wechatLoginBtn.layer.borderColor = [CommonAppColor CGColor];
    wechatLoginBtn.layer.borderWidth = 1.0f;
    wechatLoginBtn.layer.masksToBounds = YES;// 这个属性很重要，把超出边框的部分去除
    [wechatLoginBtn addTarget:self action:@selector(jumpToPhoneLoginView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:wechatLoginBtn];
    
    UIButton *youkeLoginBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, MyKScreenWidth - 110, 39)];
    youkeLoginBtn.center = Center(MyKScreenWidth / 2, MyKScreenHeight - 137);
    [youkeLoginBtn setTitle:@"游客登录" forState:UIControlStateNormal];
    [youkeLoginBtn setTitleColor:CommonAppColor forState:UIControlStateNormal];
    youkeLoginBtn.titleLabel.font = commenAppFont(13);
    youkeLoginBtn.imageView.contentMode = 1;
    youkeLoginBtn.layer.cornerRadius = 39/2;
    youkeLoginBtn.layer.borderColor = [CommonAppColor CGColor];
    youkeLoginBtn.layer.borderWidth = 1.0f;
    youkeLoginBtn.layer.masksToBounds = YES;// 这个属性很重要，把超出边框的部分去除
    [youkeLoginBtn addTarget:self action:@selector(youkeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:youkeLoginBtn];
    
}
//游客登录
- (void)youkeBtnClick{
    [Request POST:kApiSiteGuestLogin parameters:nil success:^(id responseObject) {
        NSDictionary *dic = responseObject[@"result"][@"data"];
        NSString *msg = dic[@"msg"];
        if (ValidStr(msg)) {
            [[ZWHHelper sharedHelper]addAlertViewControllerToView:self withClickBlock:^(int clickInt) {
                if (clickInt == 0) {
                    
                }else{
                    //        NSString *weixinID = [dic valueForKey:@"id"];
                    //        NSString *phone = [dic valueForKey:@"phone"];
                    
                    WatUserInfoModel *watUserInfoModel = [WatUserInfoModel new];//字典转模型
                    [watUserInfoModel modelSetWithDictionary:dic[@"info"]];
                    [WatUserInfoManager deleteInfo];
                    [WatUserInfoManager saveInfo:watUserInfoModel];//数据存入本地
                    
                    if ([self.pushType isEqualToString:@"present"]) {
                        [self dismissViewControllerAnimated:YES completion:nil];
                    }else{
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                }
            } title:@"提示" content:msg cancleStr:@"取消" confirmStr:@"确定"];
        }else{
            //        NSString *weixinID = [dic valueForKey:@"id"];
            //        NSString *phone = [dic valueForKey:@"phone"];
            
            WatUserInfoModel *watUserInfoModel = [WatUserInfoModel new];//字典转模型
            [watUserInfoModel modelSetWithDictionary:dic[@"info"]];
            [WatUserInfoManager deleteInfo];
            [WatUserInfoManager saveInfo:watUserInfoModel];//数据存入本地
            
            if ([self.pushType isEqualToString:@"present"]) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }else{
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
        
    } failure:^(NSError *error) {
        
    }];
    
    
}

//点击微信登陆
- (void) wechatLoginBtnClick {

    NSLog(@"点击了三方登陆，微信");
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            
        } else {
            UMSocialUserInfoResponse *resp = result;
            // 授权信息
            NSLog(@"Wechat uid: %@", resp.uid);
            NSLog(@"Wechat openid: %@", resp.openid);
            NSLog(@"Wechat accessToken: %@", resp.accessToken);
            NSLog(@"Wechat refreshToken: %@", resp.refreshToken);
            NSLog(@"Wechat expiration: %@", resp.expiration);
            // 用户信息
            NSLog(@"Wechat name: %@", resp.name);
            NSLog(@"Wechat iconurl: %@", resp.iconurl);
            NSLog(@"Wechat gender: %@", resp.gender);
            // 第三方平台SDK源数据
            NSLog(@"Wechat originalResponse: %@", resp.originalResponse);
            
            NSDictionary *dic = resp.originalResponse;
            NSMutableDictionary *paramDic = [NSMutableDictionary new];
            [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                if ([key isEqualToString:@"city"] || [key isEqualToString:@"country"] || [key isEqualToString:@"headimgurl"] || [key isEqualToString:@"language"] || [key isEqualToString:@"nickname"] || [key isEqualToString:@"openid"] || [key isEqualToString:@"province"] || [key isEqualToString:@"sex"] || [key isEqualToString:@"unionid"]) {
                    [paramDic setObject:obj forKey:key];
                }
            }];
            
            //微信登陆1
            [Request POST:KApiWxLoginLogin parameters:paramDic success:^(id responseObject) {
                
                //WatHomeModel *watHomeModel = [WatHomeModel dataParsingByDic:responseObject[@"result"][@"data"]];
                
                NSDictionary *dic = responseObject[@"result"][@"data"];
                
                NSString *weixinID = [dic valueForKey:@"id"];
                NSString *phone = [dic valueForKey:@"phone"];
                
                if (ValidStr(phone)) {
                    
                    WatUserInfoModel *watUserInfoModel = [WatUserInfoModel new];//字典转模型
                    [watUserInfoModel modelSetWithDictionary:dic];
                    [WatUserInfoManager deleteInfo];
                    [WatUserInfoManager saveInfo:watUserInfoModel];//数据存入本地
                    [self dismissViewControllerAnimated:YES completion:nil];
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }else{
                    
                    NSMutableDictionary *dataSouceDic = [NSMutableDictionary new];
                    [dataSouceDic setObject:weixinID forKey:@"weixinID"];
                    [[NSNotificationCenter defaultCenter] postNotificationName:WechatLoginAddPhoneNotification object:dataSouceDic userInfo:nil];
                    
                    [self dismissViewControllerAnimated:YES completion:nil];
                    [self.navigationController popToRootViewControllerAnimated:YES];
                    
                    
                }
            } failure:^(NSError *error) {
                NSLog(@"失败了");
            }];
        }
    }];

}
- (void) jumpToPhoneLoginView{
//    LoginViewController *login = [[LoginViewController alloc]init];
//    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:login];
//    [self.navigationController presentModalViewController:nav animated:YES];

    
    WatWeiXinPhoneNumLoginViewController *vc = [WatWeiXinPhoneNumLoginViewController new];
    vc.navTitle = @"登陆/注册";
    [self.navigationController pushViewController:vc animated:YES];
}

@end
