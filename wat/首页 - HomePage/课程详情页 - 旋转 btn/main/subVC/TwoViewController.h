//
//  TwoViewController.h
//  DoulScro
//
//  Created by wl on 2018/5/22.
//  Copyright © 2018年 https://github.com/orzzh. All rights reserved.
//

#import "ParentClassScrollViewController.h"
#import "WatHomeClassListDetailModel.h"
@interface TwoViewController : ParentClassScrollViewController
@property (nonatomic, strong)NSArray<WatHomeClassListDetailModel *> *list;
@property (nonatomic, strong) NSString *is_buy;
@end
