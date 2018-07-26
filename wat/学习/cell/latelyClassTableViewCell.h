//
//  latelyClassTableViewCell.h
//  wat
//
//  Created by 123 on 2018/6/21.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "learningHistoryClassDetailModel.h"
@interface latelyClassTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *durationLab;
@property (weak, nonatomic) IBOutlet UILabel *alreadyLearningLab;

- (void)reloadDataFor:(learningHistoryClassDetailModel *)model;

@end
