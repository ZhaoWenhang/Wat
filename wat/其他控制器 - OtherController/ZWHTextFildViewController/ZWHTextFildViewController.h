//
//  ZWHTextFildViewController.h
//  wat
//
//  Created by 123 on 2018/7/3.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZWHTextFildViewController : ViewController
@property (nonatomic, strong)UITextField *textField; //输入框
@property (nonatomic, strong)NSString *navTitleStr;
@property (nonatomic, strong)NSString *placeholderText;

@property (nonatomic, copy)void(^returnByClassUserInfoText)(NSString *text);


@end
