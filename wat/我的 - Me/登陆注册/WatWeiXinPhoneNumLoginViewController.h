//
//  WatWeiXinPhoneNumLoginViewController.h
//  wat
//
//  Created by 123 on 2018/6/19.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WatWeiXinPhoneNumLoginViewController : ViewController
@property (nonatomic, strong) NSString *weixinID;//微信临时传来的 id
@property (nonatomic, assign) BOOL isChangePhoneNum; //修改或绑定手机号
@end
