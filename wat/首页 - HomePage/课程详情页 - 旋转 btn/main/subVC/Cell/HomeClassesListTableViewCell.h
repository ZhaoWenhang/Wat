//
//  HomeClassesListTableViewCell.h
//  wat
//
//  Created by 123 on 2018/6/27.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WatHomeClassListDetailModel.h"

@interface HomeClassesListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *xuhaoBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *typeLab;
@property (weak, nonatomic) IBOutlet UIButton *type2Btn;

- (void)reloadDataFor:(WatHomeClassListDetailModel *)model;
@end
