//
//  yigoumaiTableViewCell.m
//  wat
//
//  Created by 123 on 2018/6/21.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "yigoumaiTableViewCell.h"

@implementation yigoumaiTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MyKScreenWidth, 1)];
    lineView.backgroundColor = WatBackColor;
    [self addSubview:lineView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
