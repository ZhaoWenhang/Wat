//
//  addByClassUserInfoViewController.h
//  wat
//
//  Created by 123 on 2018/7/3.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ByClassUserModel.h"

@interface addByClassUserInfoViewController : ViewController
@property (nonatomic, copy)void(^returnByClassUserModel)(ByClassUserModel *byClassUserModel);

@end
