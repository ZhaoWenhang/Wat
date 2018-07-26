//
//  WATHud.m
//  wat
//
//  Created by apple on 2018/6/14.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "WATHud.h"

@implementation WATHud

+ (void)initialize
{
    if (self == [WATHud class]) {
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone]; //用户不可以做其他操作
        [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
        [SVProgressHUD setMaximumDismissTimeInterval:1.5f];
        [SVProgressHUD setBackgroundColor:RGBACOLOR(0, 0, 0, 0.6)];
        [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    }
}

+ (void)config
{
    [SVProgressHUD setMinimumSize:CGSizeMake(100, 100)];
}

+ (void)showMessage:(NSString *)message
{
    [SVProgressHUD setMinimumSize:CGSizeZero];
    [SVProgressHUD showImage:nil status:message];
}

+ (void)showLoading
{
    [self config];
    
    [SVProgressHUD show];
}

+ (void)showLoading:(NSString *)message
{
    [self config];
    [SVProgressHUD showWithStatus:message];
}

+ (void)showInfo:(NSString *)message
{
    [self config];
    [SVProgressHUD showInfoWithStatus:message];
}

+ (void)showSuccess:(NSString *)message
{
    [self config];
    [SVProgressHUD showSuccessWithStatus:message];
}

+ (void)showError:(NSString *)message
{
    [self config];
    [SVProgressHUD showErrorWithStatus:message];
}

+ (void)dismiss
{
    [SVProgressHUD dismiss];
}


@end
