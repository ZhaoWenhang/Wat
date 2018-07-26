//
//  HomeJingXuanClassTableViewCell.h
//  wat
//
//  Created by 123 on 2018/6/20.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WatHomeGoodsDetailsModel.h"
#import "learningYigouClassDetailModel.h"
@interface HomeJingXuanClassTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *compereLab;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *yigouLab;
@property (weak, nonatomic) IBOutlet UILabel *moneyLab;
@property (weak, nonatomic) IBOutlet UIImageView *typeImgView;


- (void)reloadDataFor:(WatHomeGoodsDetailsModel *)model;
- (void)reloadLearningYigouClassListDataFor:(learningYigouClassDetailModel *)model;
@end
