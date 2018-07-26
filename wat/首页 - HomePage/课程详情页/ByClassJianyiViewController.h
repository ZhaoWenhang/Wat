//
//  ByClassJianyiViewController.h
//  wat
//
//  Created by 123 on 2018/7/3.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WatHomeWillBeginClassModel.h"
#import "WatHomeHotDetailsModel.h"
#import "OrderDetailModel.h"
#import "WatHomeClassGoodsModel.h"
@interface ByClassJianyiViewController : ViewController
@property (nonatomic, strong) WatHomeWillBeginClassModel *watHomeWillBeginClassModel;
@property (nonatomic, strong) WatHomeHotDetailsModel *watHomeHotDetailsModel;
@property (nonatomic, strong) OrderDetailModel *orderDetailModel;
@property (nonatomic, strong) WatHomeClassGoodsModel *watHomeClassGoodsModel;
@end
