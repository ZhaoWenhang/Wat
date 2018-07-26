//
//  WatWeiXinPhoneNumLoginViewController.m
//  wat
//
//  Created by 123 on 2018/6/19.
//  Copyright © 2018年 wat0801. All rights reserved.
//
//login / bind_wx

#import "WatWeiXinPhoneNumLoginViewController.h"
#import "MessageCordView.h"

@interface WatWeiXinPhoneNumLoginViewController ()<UIScrollViewDelegate>
@property (nonatomic ,strong) UIScrollView *scrollView;
@property (nonatomic, strong) UITextField *PhoneNBTF;//手机号输入框
@property (nonatomic, strong) MessageCordView *coreView;//验证码输入框
@property (nonatomic, strong) NSString *loginBtnNameStr;
//------------------- model -----------------
@property (nonatomic, strong) WatUserInfoModel *watUserInfoModel;

@end

@implementation WatWeiXinPhoneNumLoginViewController
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

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
//    self.navigationController.navigationBarHidden = YES;
//    self.navBarView.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
//    self.navigationController.navigationBarHidden = NO;
//    self.navBarView.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.isChangePhoneNum) {
        self.loginBtnNameStr = @"绑    定";
    }else{
        self.loginBtnNameStr = @"登    陆";
    }
    
    [self addScrollView];

    self.scrollView.backgroundColor = WatBackColor;
    
    //手机号输入框
    UIImageView *phoneImageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shurukuangBG"]];
    phoneImageV.frame = CGRectMake(37.5, MyTopHeight + 61, 300, 50);
    [self.scrollView addSubview:phoneImageV];
    
    //验证码输入框
    UIImageView *coreBGView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shurukuangBG"]];
    coreBGView.frame = CGRectMake(37.5, MyTopHeight + 131, 300, 50);
    [self.scrollView addSubview:coreBGView];
    
    UITextField *PhoneNBTF = [[UITextField alloc]initWithFrame:CGRectMake(40, MyTopHeight + 121, 295, 50)];//
    self.PhoneNBTF = PhoneNBTF;
    PhoneNBTF.backgroundColor = [UIColor whiteColor];
    PhoneNBTF.font = [UIFont systemFontOfSize:14];
    PhoneNBTF.textColor = [UIColor grayColor];
    PhoneNBTF.placeholder = @"请输入验证码";
    PhoneNBTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    PhoneNBTF.keyboardType = UIKeyboardTypePhonePad;
    PhoneNBTF.layer.borderWidth = 0;
    PhoneNBTF.layer.cornerRadius = 25;
    PhoneNBTF.layer.masksToBounds = YES;
    PhoneNBTF.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:PhoneNBTF];
    
    UIImageView *phoneNBImV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"suozi"]];
    phoneNBImV.frame = CGRectMake(0, 0, 17, 24);
    phoneNBImV.contentMode = UIViewContentModeScaleAspectFit;
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 47)];
    phoneNBImV.center = v.center;
    [v addSubview:phoneNBImV];
    PhoneNBTF.leftViewMode = UITextFieldViewModeAlways;
    PhoneNBTF.leftView = v;
    
    
    
    MessageCordView *coreView =[[MessageCordView alloc]initWithFrame:CGRectMake(40, MyTopHeight + 51, 295, 50)];
    self.coreView = coreView;
    if (ValidStr(self.weixinID)) {
        coreView.typeStr = @"bind_wx";
    }else if (self.isChangePhoneNum){
        coreView.typeStr = @"setphone";
    }
    else{
        coreView.typeStr = @"login";
    }
    
    [self.scrollView addSubview:coreView];
    
    //确定按钮
    UIImageView *loginBtnBGView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shurukuangBG"]];
    loginBtnBGView.frame = CGRectMake(37.5, MyTopHeight + 251, 300, 50);
    [self.scrollView addSubview:loginBtnBGView];
    
    UIButton *loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(40, MyTopHeight + 241, 295, 50)];
    [loginBtn setBackgroundColor:CommonAppColor];
    loginBtn.layer.borderWidth = 0;
    loginBtn.layer.cornerRadius = 25;
    loginBtn.layer.masksToBounds = YES;
    [loginBtn setTitle:self.loginBtnNameStr forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor yellowColor] forState:UIControlStateHighlighted];
    [loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:loginBtn];
    
    //提示按钮
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"温馨提示：未注册的手机号，登录时将自动注册，且代表您已同意《用户服务协议》"];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0,29)];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-BoldItalicMT" size:12] range:NSMakeRange(0, 7)];
    [str addAttribute:NSForegroundColorAttributeName value:ColorWithRGB(3, 106, 233) range:NSMakeRange(29,str.length-29)];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-BoldItalicMT" size:12] range:NSMakeRange(7,str.length-7)];
    
    UIButton *tishiBtn = [[UIButton alloc]initWithFrame:CGRectMake(40, MyTopHeight + 291, 295, 20)];
    [tishiBtn setAttributedTitle:str forState:UIControlStateNormal];
    tishiBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    tishiBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
   // [self.scrollView addSubview:tishiBtn];
    
    //tishiBtn添加手势，进入用户协议界面
    UITapGestureRecognizer *tishiTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickTishiLab)];
    [tishiBtn addGestureRecognizer:tishiTap];
    
    //view添加手势，取消第一响应者
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickView)];
    [self.scrollView addGestureRecognizer:tap];
}

- (void)addScrollView {
    [self.view addSubview:self.scrollView];
    
}
- (void)loginBtnClick{
    if (ValidStr(self.weixinID)) {
        NSString *pNumStr = self.coreView.rechargeField.text;
        NSString * coreNum = self.PhoneNBTF.text;
        if ([[ZWHHelper sharedHelper]isPhoneByMobileNum:pNumStr] && ValidStr(coreNum)) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setObject:self.coreView.rechargeField.text forKey:@"phone"];
            [dic setObject:self.PhoneNBTF.text forKey:@"code"];
            [dic setObject:self.weixinID forKey:@"id"];
            [WatUserInfoModel asyncPostUserInfoSuccessBlock:^(WatUserInfoModel *watUserInfoModel) {
                
                [WatUserInfoManager deleteInfo];
                [WatUserInfoManager saveInfo:watUserInfoModel];//数据存入本地
                [self.navigationController popToRootViewControllerAnimated:YES];
                
            } errorBlock:^(NSError *errorResult) {
                
            } paramDic:dic urlStr:kApiWxLoginBindPhone];
            
        }else{
            [[ZWHHelper sharedHelper]addAlertViewControllerToView:[ZWHHelper rootTabbarViewController] withClickBlock:^(int clickInt) {
                
            } title:@"提示" content:@"填写信息有误" cancleStr:@"" confirmStr:@"确定"];
        }
    }else if (self.isChangePhoneNum){ //修改手机号  绑定手机号
        NSString *pNumStr = self.coreView.rechargeField.text;
        NSString * coreNum = self.PhoneNBTF.text;
        if ([[ZWHHelper sharedHelper]isPhoneByMobileNum:pNumStr] && ValidStr(coreNum)) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setObject:self.coreView.rechargeField.text forKey:@"phone"];
            [dic setObject:self.PhoneNBTF.text forKey:@"code"];
            [Request POST:kApiUserChangePhone parameters:dic success:^(id responseObject) {
                [WATHud showSuccess:@"设置成功"];
                WatUserInfoModel *userModel = [WatUserInfoManager getInfo];
                userModel.phone = self.coreView.rechargeField.text;
                [WatUserInfoManager saveInfo:userModel];//数据存入本地
                [self.navigationController popToRootViewControllerAnimated:YES];
            } failure:^(NSError *error) {
                
            }];
        }else{
            [[ZWHHelper sharedHelper]addAlertViewControllerToView:[ZWHHelper rootTabbarViewController] withClickBlock:^(int clickInt) {
                
            } title:@"提示" content:@"填写信息有误" cancleStr:@"" confirmStr:@"确定"];
        }
    }else{
        NSString *pNumStr = self.coreView.rechargeField.text;
        NSString * coreNum = self.PhoneNBTF.text;
        if ([[ZWHHelper sharedHelper]isPhoneByMobileNum:pNumStr] && ValidStr(coreNum)) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setObject:self.coreView.rechargeField.text forKey:@"phone"];
            [dic setObject:self.PhoneNBTF.text forKey:@"code"];
            
            [WatUserInfoModel asyncPostUserInfoSuccessBlock:^(WatUserInfoModel *watUserInfoModel) {
                [WatUserInfoManager deleteInfo];//先清空再存入
                [WatUserInfoManager saveInfo:watUserInfoModel];//数据存入本地
                [self.navigationController popToRootViewControllerAnimated:YES];
            } errorBlock:^(NSError *errorResult) {
                
            } paramDic:dic urlStr:kApiSitelogin];
            
        }else{
            [[ZWHHelper sharedHelper]addAlertViewControllerToView:[ZWHHelper rootTabbarViewController] withClickBlock:^(int clickInt) {
                
            } title:@"提示" content:@"填写信息有误" cancleStr:@"" confirmStr:@"确定"];
        }
    }
    NSLog(@"手机号:%@\n 验证码:%@",self.coreView.rechargeField.text,self.PhoneNBTF.text);
    NSLog(@"点击了确定登陆按钮");
    
}

- (void) clickView {
    [self.PhoneNBTF resignFirstResponder];
    [self.coreView.rechargeField resignFirstResponder];
    NSLog(@"点击屏幕，取消第一响应者");
}
- (void)clickTishiLab {
    NSLog(@"点击了用户协议按钮");
    
}

- (void)backAction {
    if (!self.isChangePhoneNum) {
        [WatUserInfoManager deleteInfo];
    }
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}


@end
