//
//  WATHud.h
//  wat
//
//  Created by apple on 2018/6/14.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SVProgressHUD.h"

@interface WATHud : NSObject

/** 文字 */
+ (void)showMessage:(NSString *)message;
/** 菊花 */
+ (void)showLoading;
/** 菊花+文字 */
+ (void)showLoading:(NSString *)message;

+ (void)showInfo:(NSString *)message;
+ (void)showSuccess:(NSString *)message;
+ (void)showError:(NSString *)message;

+ (void)dismiss;

@end
