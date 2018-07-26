//
//  HomeClassTableViewCell.m
//  wat
//
//  Created by 123 on 2018/6/7.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "HomeClassTableViewCell.h"

@implementation HomeClassTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    

    
}

- (void)reloadDataFor:(WatHomeWillBeginClassModel *)model{
    
    [self.imgView sd_setImageWithURL:model.thumb_path placeholderImage:[UIImage imageNamed:@"pic00"]];
    self.titleLab.text = model.title;
    self.subTitleLab.text = model.subTitle;
    NSString *yigouStr = [NSString stringWithFormat:@"%@人已购买",model.sale_num];
    self.yigouLab.text =  yigouStr;
    NSString *moneyStr = [NSString stringWithFormat:@"%@元",model.price];
    self.moneyLab.text = moneyStr;
    
    self.imgView.clipsToBounds = YES;
    self.imgView.contentMode = 0;
    
    
    self.bgView.layer.cornerRadius = 4;
    
    self.bgView.clipsToBounds = YES;
    // UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:self.bgView.bounds];
    self.bgView.layer.masksToBounds = NO;
    self.bgView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.bgView.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    self.bgView.layer.shadowOpacity = 0.3f;
    
    //self.bgView.layer.shadowPath = shadowPath.CGPath;
    
    
    
    self.titleLab.font = commenAppFont(15);
    
    self.subTitleLab.font = commenAppFont(13);
    
    
    self.yigouLab.frame = CGRectMake(8, CGRectGetMaxY(self.subTitleLab.frame) + 10 , 100, 10);
    self.yigouLab.numberOfLines = 1;
    self.yigouLab.font = commenAppFont(11);
    [self.yigouLab sizeToFit];
    
    self.moneyLab.frame = CGRectMake(CGRectGetMaxX(self.yigouLab.frame) + 5, CGRectGetMinY(self.yigouLab.frame), 100, 10);
    self.moneyLab.numberOfLines = 1;
    self.moneyLab.textColor = [UIColor redColor];
    self.moneyLab.font = commenAppFont(11);
    [self.moneyLab sizeToFit];
    
    self.goBtn.frame = CGRectMake(MyKScreenWidth - 53 - 10 - 30, CGRectGetMaxY(self.bgView.frame) - 41, 53, 21);
    self.goBtn.backgroundColor = [UIColor clearColor];
    self.goBtn.textColor = CommonAppColor;
    self.goBtn.font = commenAppFont(12);
    self.goBtn.layer.cornerRadius = 5;
    self.goBtn.layer.masksToBounds = YES;
    
    [self.goBtn.layer setMasksToBounds:YES];
    [self.goBtn.layer setCornerRadius:4.0]; //设置矩圆角半径
    [self.goBtn.layer setBorderWidth:1.0];   //边框宽度
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 215/255.0, 0/255.0, 15/255.0, 255/255.0 });//237, 240, 244
    [self.goBtn.layer setBorderColor:CommonAppColor.CGColor];//边框颜色
    
}

- (void)reloadYigouDataFor:(learningYigouClassDetailModel *)model{
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.thumb_path] placeholderImage:[UIImage imageNamed:@"pic00"]];
    self.titleLab.text = model.title;
    self.subTitleLab.text = model.subTitle;
    NSString *yigouStr = [NSString stringWithFormat:@"%@人已购买",model.sale_num];
    self.yigouLab.text =  yigouStr;
    NSString *moneyStr = [NSString stringWithFormat:@"%@元",model.price];
    self.moneyLab.text = moneyStr;
    
    self.imgView.clipsToBounds = YES;
    self.imgView.contentMode = 0;
    self.bgView.layer.cornerRadius = 4;
    
    self.bgView.clipsToBounds = YES;
    // UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:self.bgView.bounds];
    self.bgView.layer.masksToBounds = NO;
    self.bgView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.bgView.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    self.bgView.layer.shadowOpacity = 0.3f;
    
    //self.bgView.layer.shadowPath = shadowPath.CGPath;
    
    
    
    self.titleLab.font = commenAppFont(15);
    
    self.subTitleLab.font = commenAppFont(13);
    
    
    self.yigouLab.frame = CGRectMake(8, CGRectGetMaxY(self.subTitleLab.frame) + 10 , 100, 10);
    self.yigouLab.numberOfLines = 1;
    self.yigouLab.font = commenAppFont(11);
    [self.yigouLab sizeToFit];
    
    self.moneyLab.frame = CGRectMake(CGRectGetMaxX(self.yigouLab.frame) + 5, CGRectGetMinY(self.yigouLab.frame), 100, 10);
    self.moneyLab.numberOfLines = 1;
    self.moneyLab.textColor = [UIColor redColor];
    self.moneyLab.font = commenAppFont(11);
    [self.moneyLab sizeToFit];
    
    self.goBtn.frame = CGRectMake(MyKScreenWidth - 53 - 10 - 30, CGRectGetMaxY(self.bgView.frame) - 41, 53, 21);
    self.goBtn.backgroundColor = [UIColor clearColor];
    self.goBtn.textColor = CommonAppColor;
    self.goBtn.font = commenAppFont(12);
    self.goBtn.layer.cornerRadius = 5;
    self.goBtn.layer.masksToBounds = YES;
    
    [self.goBtn.layer setMasksToBounds:YES];
    [self.goBtn.layer setCornerRadius:4.0]; //设置矩圆角半径
    [self.goBtn.layer setBorderWidth:1.0];   //边框宽度
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 215/255.0, 0/255.0, 15/255.0, 255/255.0 });//237, 240, 244 //黄色 213, 172, 116
    [self.goBtn.layer setBorderColor:CommonAppColor.CGColor];//边框颜色
}
@end
