//
//  BookDetailViewController.h
//  wat
//
//  Created by 123 on 2018/6/11.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WatHomeHotDetailsModel.h"
@interface BookDetailViewController : ViewController
@property (nonatomic, strong)NSString *urlStr;
@property (nonatomic, strong)NSString *hk_iconImage;
@property (nonatomic, strong)WatHomeHotDetailsModel *watHomeHotDetailsModel;

@end
