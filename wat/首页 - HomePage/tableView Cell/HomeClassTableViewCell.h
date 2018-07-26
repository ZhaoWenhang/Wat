//
//  HomeClassTableViewCell.h
//  wat
//
//  Created by 123 on 2018/6/7.
//  Copyright © 2018年 wat0801. All rights reserved.
//


//线下课程

#import <UIKit/UIKit.h>
#import "WatHomeWillBeginClassModel.h"
#import "learningYigouClassDetailModel.h"
@interface HomeClassTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *yigouLab;
@property (weak, nonatomic) IBOutlet UILabel *moneyLab;
@property (weak, nonatomic) IBOutlet UILabel *goBtn;


- (void)reloadDataFor:(WatHomeWillBeginClassModel *)model;
- (void)reloadYigouDataFor:(learningYigouClassDetailModel *)model;
@end
