//
//  ZWHTextFildViewController.m
//  wat
//
//  Created by 123 on 2018/7/3.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "ZWHTextFildViewController.h"

@interface ZWHTextFildViewController ()

@end

@implementation ZWHTextFildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.rightTitles = @[@"保存"];
    self.view.backgroundColor = WatBackColor;
    self.navTitle = self.navTitleStr;

    
    UIView *v1 = [[UIView alloc]initWithFrame:CGRectMake(0, MyTopHeight + 10, MyKScreenWidth, 44)];
    v1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:v1];
    UITextField *textFiled = [[UITextField alloc]initWithFrame:CGRectMake(20, 0, MyKScreenWidth - 20, 44)];
    self.textField = textFiled;
    textFiled.placeholder = @"请输入要填写的信息";
    if (_placeholderText.length) {
        textFiled.text = _placeholderText;
    }
    //textFiled.delegate = self;
    textFiled.clearButtonMode = UITextFieldViewModeAlways;
    textFiled.keyboardType = UIKeyboardTypeNumberPad;
    textFiled.backgroundColor = [UIColor whiteColor];
    textFiled.textColor = [UIColor grayColor];
    [v1 addSubview:textFiled];
    
}
- (void)rightBtnsAction:(UIButton *)button{
    if (self.textField.text.length == 0) {
        [[ZWHHelper sharedHelper]addAlertViewControllerToView:self withClickBlock:^(int clickInt) {
            
        } title:@"请输入要保存的信息" content:@"" cancleStr:@"" confirmStr:@"确定"];
    }else{
        if (self.returnByClassUserInfoText) {
            self.returnByClassUserInfoText(self.textField.text);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
