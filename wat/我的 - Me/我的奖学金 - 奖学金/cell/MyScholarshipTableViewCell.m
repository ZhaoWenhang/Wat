//
//  MyScholarshipTableViewCell.m
//  wat
//
//  Created by 123 on 2018/6/21.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "MyScholarshipTableViewCell.h"

@implementation MyScholarshipTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MyKScreenWidth, 1)];
    lineView.backgroundColor = WatBackColor;
    [self addSubview:lineView];
    
    self.imgView.frame = CGRectMake(13, 20, 87, 109);
    self.imgView.layer.cornerRadius = 4;
    self.imgView.clipsToBounds = YES;
    
    self.titleLab.frame = CGRectMake(CGRectGetMaxX(self.imgView.frame) + 20, CGRectGetMinY(self.imgView.frame) + 3, MyKScreenWidth - CGRectGetMaxX(self.imgView.frame) - 20 - 13, 15);
    self.titleLab.font = commenAppFont(15);
    
    self.moneyLab.frame = CGRectMake(CGRectGetMinX(self.titleLab.frame), CGRectGetMaxY(self.imgView.frame)  -  12, CGRectGetWidth(self.titleLab.frame), 12);
    self.moneyLab.font = commenAppFont(12);
    self.moneyLab.textColor = CommonAppColor;
    
    self.goBtnLab.frame = CGRectMake(MyKScreenWidth - 100, CGRectGetMinY(self.moneyLab.frame) - 28 + 12, 71, 28);
    self.goBtnLab.textAlignment = NSTextAlignmentCenter;
    self.goBtnLab.font = commenAppFont(12);
    self.goBtnLab.textColor = CommonAppColor;
    //self.goBtnLab.backgroundColor = CommonAppColor;
    self.goBtnLab.layer.cornerRadius = 4;
    self.goBtnLab.clipsToBounds = YES;
    
    [self.goBtnLab.layer setMasksToBounds:YES];
    [self.goBtnLab.layer setCornerRadius:4.0]; //设置矩圆角半径
    [self.goBtnLab.layer setBorderWidth:1.0];   //边框宽度
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 215/255.0, 0/255.0, 15/255.0, 255/255.0 });//237, 240, 244
    [self.goBtnLab.layer setBorderColor:colorref];//边框颜色
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
