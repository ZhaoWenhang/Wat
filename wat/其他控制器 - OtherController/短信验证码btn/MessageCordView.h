//
//  MessageCordView.h
//  wat
//
//  Created by 123 on 2018/5/23.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageCordView : UIView

@property (nonatomic, strong) UITextField *rechargeField;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSString *typeStr;//验证码类型  login / bind_wx  /(验证旧手机号)changephone  / (游客绑定手机号)setphone

@end
