//
//  ClassDetailViewController.h
//  wat
//
//  Created by 123 on 2018/6/7.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WatHomeWillBeginClassModel.h"
#import "OrderDetailModel.h"
@interface ClassDetailViewController : ViewController
@property (nonatomic, strong)NSString *ios_mark_id; //goodsid
@property (nonatomic, strong)NSString *urlStr;
@property (nonatomic, assign)BOOL is_sale; //已购标识,影藏购买 btn 0 fou 1 shi
@property (nonatomic, strong)WatHomeWillBeginClassModel *watHomeWillBeginClassModel;
@property (nonatomic, strong)OrderDetailModel *orderDetailModel;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *sale_num;

@end
