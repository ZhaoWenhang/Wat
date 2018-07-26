//
//  SettingSwitPhoneNumberViewController.m
//  wat
//
//  Created by 123 on 2018/7/23.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "SettingSwitPhoneNumberViewController.h"
#import "UIButton+YasinTimerCategory.h"
#import "WatWeiXinPhoneNumLoginViewController.h"

@interface SettingSwitPhoneNumberViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *yanzhenmaTextField;
@property (nonatomic, strong) UIButton *yanzhenmaBtn;
@property (nonatomic, strong) WatUserInfoModel *userModel;
@end

@implementation SettingSwitPhoneNumberViewController
-(WatUserInfoModel *)userModel{
    if (!_userModel) {
        _userModel = [WatUserInfoModel new];
    }
    return _userModel;
}
- (UIButton *)yanzhenmaBtn{
    if (!_yanzhenmaBtn) {
        _yanzhenmaBtn = [UIButton new];
    }
    return _yanzhenmaBtn;
}
- (UITextField *)yanzhenmaTextField{
    if (!_yanzhenmaTextField) {
        _yanzhenmaTextField = [UITextField new];
        _yanzhenmaTextField.delegate = self;
    }
    return _yanzhenmaTextField;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.userModel = [WatUserInfoManager getInfo];
    
    self.navTitle = @"验证身份";
    self.view.backgroundColor = WatBackColor;
    
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, MyKScreenWidth, 14)];
    lab1.center = Center(MyKScreenWidth / 2,MyTopHeight + 60);
    lab1.text = @"为保障账户安全";
    lab1.textAlignment = NSTextAlignmentCenter;
    lab1.font = commenAppFont(14);
    lab1.textColor = [UIColor grayColor];
    [self.view addSubview:lab1];
    
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, MyKScreenWidth, 22)];
    lab2.center = Center(MyKScreenWidth / 2, MyTopHeight + 100);
    lab2.text = @"我们需要验证您的身份";
    lab2.textAlignment = NSTextAlignmentCenter;
    lab2.font = commenAppFont(22);
    lab2.textColor = CommonAppColor;
    [self.view addSubview:lab2];
    
    UILabel *lab3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, MyKScreenWidth, 16)];
    lab3.center = Center(MyKScreenWidth / 2,MyTopHeight + 140);
    lab3.text = [[ZWHHelper sharedHelper]phoneNum:self.userModel.phone];
    lab3.textAlignment = NSTextAlignmentCenter;
    lab3.font = commenAppFont(16);
    lab3.textColor = [UIColor blackColor];
    [self.view addSubview:lab3];
    
    
    CGFloat yanzhenmaBtnWidth = 100;
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(25, CGRectGetMaxY(lab3.frame) + 40, MyKScreenWidth - 60, 44)];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.cornerRadius = 4;
    bgView.layer.masksToBounds = YES;
    [self.view addSubview:bgView];
    
    self.yanzhenmaTextField.frame = CGRectMake(0, 0, CGRectGetWidth(bgView.frame) - yanzhenmaBtnWidth, 44);
    self.yanzhenmaTextField.backgroundColor = [UIColor clearColor];
    self.yanzhenmaTextField.font = [UIFont systemFontOfSize:14];
    self.yanzhenmaTextField.textColor = [UIColor grayColor];
    self.yanzhenmaTextField.placeholder = @"请输入验证码";
    self.yanzhenmaTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.yanzhenmaTextField.keyboardType = UIKeyboardTypePhonePad;
    self.yanzhenmaTextField.layer.borderWidth = 0;
    self.yanzhenmaTextField.layer.cornerRadius = 4;
    self.yanzhenmaTextField.layer.masksToBounds = YES;
    self.yanzhenmaTextField.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:self.yanzhenmaTextField];
    
    UIView *shuLineView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.yanzhenmaTextField.frame) - 1, 10, 1, 24)];
    shuLineView.backgroundColor = [UIColor grayColor];
    [self.yanzhenmaTextField addSubview:shuLineView];
    
    self.yanzhenmaBtn.frame = CGRectMake(CGRectGetMaxX(self.yanzhenmaTextField.frame), 0, yanzhenmaBtnWidth, 44);
    [self.yanzhenmaBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.yanzhenmaBtn.backgroundColor = [UIColor clearColor];
    self.yanzhenmaBtn.titleLabel.font = commenAppFont(14);
    [self.yanzhenmaBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.yanzhenmaBtn.titleLabel adjustsFontSizeToFitWidth];
    [self.yanzhenmaBtn addTarget:self action:@selector(yanzhenmaBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:self.yanzhenmaBtn];
    
    UIButton *sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(25, CGRectGetMaxY(bgView.frame) + 20, MyKScreenWidth - 60, 44)];
    [sureBtn setTitle:@"下一步" forState:UIControlStateNormal];
    sureBtn.backgroundColor = CommonAppColor;
    sureBtn.titleLabel.font = commenAppFont(14);
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sureBtn.layer.cornerRadius = 4;
    sureBtn.layer.masksToBounds = YES;
    [sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureBtn];
    
}

- (void)yanzhenmaBtnClick{
    [self.yanzhenmaBtn startCountDownTime:60 withCountDownBlock:^{
        
        NSLog(@"开始倒计时");
        
        //此处发送验证码等操作
        //................
        
        
        NSMutableDictionary *parm = [NSMutableDictionary dictionary];
        [parm setObject:self.userModel.phone forKey:@"phone"];
        [parm setObject:@"changephone" forKey:@"type"];
        
        
        [Request GET:kApiPublicSendSms parameters:parm success:^(id responseObject) {
            [WATHud showSuccess:@"验证码发送成功!"];
        } failure:^(NSError *error) {
        }];
        
    }];
}

- (void) sureBtnClick {
    NSLog(@"sureBtnClick");
    if (ValidStr(self.yanzhenmaTextField.text)) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:self.yanzhenmaTextField.text forKey:@"code"];
        [dic setObject:self.userModel.phone forKey:@"phone"];
        
        [Request POST:kApiUserVerifyPhone parameters:dic success:^(id responseObject) {
            WatWeiXinPhoneNumLoginViewController *changePhoneVC = [WatWeiXinPhoneNumLoginViewController new];
            changePhoneVC.navTitle = @"设置新手机号";
            changePhoneVC.isChangePhoneNum = YES;
            [self.navigationController pushViewController:changePhoneVC animated:YES];
        } failure:^(NSError *error) {
        }];
    }else{
        [[ZWHHelper sharedHelper]addAlertViewControllerToView:self withClickBlock:^(int clickInt) {
            
        } title:@"请输入验证码" content:@"" cancleStr:@"确定" confirmStr:@""];
    }
    
    
    
}
@end
