//
//  latelyClassTableViewCell.m
//  wat
//
//  Created by 123 on 2018/6/21.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "latelyClassTableViewCell.h"

@implementation latelyClassTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = [UIColor whiteColor];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MyKScreenWidth, 1)];
    lineView.backgroundColor = WatBackColor;
    [self addSubview:lineView];
    
    
    
}

- (void)reloadDataFor:(learningHistoryClassDetailModel *)model{
    
    self.titleLab.text = model.title;
    if ([model.content_type isEqualToString:@"1"]) {
        self.imgView.image = [UIImage imageNamed:@"音频zuijinTypeIcon"];
    }else if([model.content_type isEqualToString:@"2"]){
       self.imgView.image = [UIImage imageNamed:@"视频zuijinTypeIcon"];
    }else{
        [self.imgView sd_setImageWithURL:model.thumb];
    }
    NSString *durationStr;
    if (model.learning_time.intValue >= 3600) {
        durationStr = [[ZWHHelper sharedHelper]getMMSSFromSS:model.learning_time];
    }else{
        durationStr = [[ZWHHelper sharedHelper]getSectionMMSSFromSS:model.learning_time];
    }
    NSString *durationLabStr = [NSString stringWithFormat:@"时长%@",durationStr];
    self.durationLab.text = durationLabStr;
    
    NSString *alreadyLearningStr = [NSString stringWithFormat:@"已学%0.0lf%@",model.finish_rate.floatValue,@"%"];
    self.alreadyLearningLab.text = alreadyLearningStr;
    
    self.imgView.frame = CGRectMake(14, 18, 40, 40);
    self.imgView.center = Center(14 + 20, CGRectGetHeight(self.frame) * 0.5);
    self.imgView.contentMode = 1;
    
    self.titleLab.frame = CGRectMake(CGRectGetMaxX(self.imgView.frame) + 19, CGRectGetMinY(self.imgView.frame) + 3, MyKScreenWidth - CGRectGetWidth(self.imgView.frame) - 14 - 19 - 20, 15);
    self.titleLab.font = commenAppFont(15);
    self.titleLab.textColor = [UIColor blackColor];
    
    self.durationLab.frame = CGRectMake(CGRectGetMinX(self.titleLab.frame), CGRectGetMaxY(self.imgView.frame) - 12 - 3, 61, 12);
    self.durationLab.font = commenAppFont(12);
    self.durationLab.textColor = [UIColor darkGrayColor];
    self.durationLab.numberOfLines = 1;
    [self.durationLab sizeToFit];
    
    self.alreadyLearningLab.frame = CGRectMake(CGRectGetMaxX(self.durationLab.frame) + 10, CGRectGetMinY(self.durationLab.frame), 47, 12);
    self.alreadyLearningLab.font = commenAppFont(12);
    self.alreadyLearningLab.textColor = CommonAppColor;
    self.alreadyLearningLab.numberOfLines = 1;
    [self.alreadyLearningLab sizeToFit];
    
}




@end
