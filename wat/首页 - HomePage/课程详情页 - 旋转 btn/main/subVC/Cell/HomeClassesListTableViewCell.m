//
//  HomeClassesListTableViewCell.m
//  wat
//
//  Created by 123 on 2018/6/27.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "HomeClassesListTableViewCell.h"

@implementation HomeClassesListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.xuhaoBtn.frame = CGRectMake(15, 15, 35, 35);
    self.xuhaoBtn.center = Center(32.5, 85 * 0.5);
 
    
    self.titleLab.frame = CGRectMake(CGRectGetMaxX(self.xuhaoBtn.frame) + 20, 25, MyKScreenWidth - 120, 18);
    self.titleLab.font = commenAppFont(18);
    self.titleLab.textColor = [UIColor darkGrayColor];
    
    self.timeLab.frame = CGRectMake(CGRectGetMinX(self.titleLab.frame), CGRectGetMaxY(self.titleLab.frame) + 5, 0, 14);
    self.timeLab.textColor = [UIColor grayColor];
    self.timeLab.font = commenAppFont(14);
    self.timeLab.numberOfLines = 1;
    [self.timeLab sizeToFit];
    
    self.typeLab.frame = CGRectMake(CGRectGetMaxX(self.timeLab.frame) + 10, CGRectGetMinY(self.timeLab.frame), 20, 14);
    self.typeLab.textColor = [UIColor orangeColor];
    self.typeLab.font = commenAppFont(14);
    self.typeLab.numberOfLines = 1;
    [self.typeLab sizeToFit];
    
    self.type2Btn.frame = CGRectMake(MyKScreenWidth - 50, CGRectGetMinY(self.xuhaoBtn.frame), 35, 35);
    [self.type2Btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.type2Btn.titleLabel.font = commenAppFont(14);
    
}
- (void)reloadDataFor:(WatHomeClassListDetailModel *)model{
    
    if ([model.goods_type_name isEqualToString:@"视频"] || [model.goods_type_name isEqualToString:@"音频"]) {
        [self.xuhaoBtn setImage:[UIImage imageNamed:@"playNo"] forState:UIControlStateNormal];
    }else{
        [self.xuhaoBtn setImage:[UIImage imageNamed:@"文章"] forState:UIControlStateNormal];
    }
    
    self.titleLab.text = model.title;
    NSString *timeStr;
    if (model.duration.intValue >= 3600) {
        timeStr = [[ZWHHelper sharedHelper]getMMSSFromSS:model.duration];
    }else{
        timeStr = [[ZWHHelper sharedHelper]getSectionMMSSFromSS:model.duration];
    }
    self.timeLab.text = [NSString stringWithFormat:@"播放时长:%@",timeStr];
    
    self.xuhaoBtn.frame = CGRectMake(15, 15, 35, 35);
    self.xuhaoBtn.imageView.contentMode = 1;
    self.xuhaoBtn.center = Center(32.5, 85 * 0.5);
    
    self.titleLab.frame = CGRectMake(CGRectGetMaxX(self.xuhaoBtn.frame) + 20, 25, MyKScreenWidth - 120, 18);
    self.titleLab.font = commenAppFont(18);
    self.titleLab.textColor = [UIColor darkGrayColor];
    
    self.timeLab.frame = CGRectMake(CGRectGetMinX(self.titleLab.frame), CGRectGetMaxY(self.titleLab.frame) + 5, 0, 14);
    self.timeLab.textColor = [UIColor grayColor];
    self.timeLab.font = commenAppFont(14);
    self.timeLab.numberOfLines = 1;
    [self.timeLab sizeToFit];
    
    //免费试听
    self.typeLab.frame = CGRectMake(CGRectGetMaxX(self.timeLab.frame) + 10, CGRectGetMinY(self.timeLab.frame), 20, 14);
    self.typeLab.textColor = [UIColor orangeColor];
    self.typeLab.font = commenAppFont(14);
    self.typeLab.numberOfLines = 1;
    [self.typeLab sizeToFit];

    
    //标签2
    self.type2Btn.frame = CGRectMake(MyKScreenWidth - 40, CGRectGetMinY(self.xuhaoBtn.frame), 20, 20);
    self.type2Btn.imageView.contentMode = 1;
    [self.type2Btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.type2Btn.titleLabel.font = commenAppFont(14);
    
    if ([model.is_free isEqualToString:@"0"]) {//0 是不免费
        self.typeLab.hidden = YES;
        [self.type2Btn setImage:[UIImage imageNamed:@"锁"] forState:UIControlStateNormal];
    }else{
        self.type2Btn.hidden = YES;
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
