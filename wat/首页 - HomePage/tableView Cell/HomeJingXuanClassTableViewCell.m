//
//  HomeJingXuanClassTableViewCell.m
//  wat
//
//  Created by 123 on 2018/6/20.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "HomeJingXuanClassTableViewCell.h"

@implementation HomeJingXuanClassTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    

    

}
- (void)reloadLearningYigouClassListDataFor:(learningYigouClassDetailModel *)model{
//    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 1, MyKScreenWidth, 1)];
//    lineView.backgroundColor = WatBackColor;
//    [self addSubview:lineView];
    
    NSURL *url = [NSURL URLWithString:model.thumb_path];
    [self.imgView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"pic00"]];
    self.titleLab.text = model.title;
    self.compereLab.text = model.author;
    self.subTitleLab.text = model.subTitle;
    NSString *yigouLabStr = [NSString stringWithFormat:@"已有%@人购买",model.sale_num];
    self.yigouLab.text =  yigouLabStr;
    NSString *moneyLabStr = [NSString stringWithFormat:@"%@内参币",model.price];
    self.moneyLab.text =  moneyLabStr;
    
    
    self.imgView.frame = CGRectMake(13, 20, 87, 109);
    self.imgView.layer.cornerRadius = 4;
    self.imgView.clipsToBounds = YES;
    
    self.typeImgView.frame = CGRectMake(13 + CGRectGetWidth(self.imgView.frame) - 25, 20 + CGRectGetHeight(self.imgView.frame) - 25, 20, 20);
    if ([model.content_type isEqualToString:@"2"]) {
        self.typeImgView.image = [UIImage imageNamed:@"视频typeIcon"];
    }else if ([model.content_type isEqualToString:@"1"]){
        self.typeImgView.image = [UIImage imageNamed:@"音频typeIcon"];
    }
    
    self.titleLab.frame = CGRectMake(CGRectGetMaxX(self.imgView.frame) + 20, CGRectGetMinY(self.imgView.frame) + 3, MyKScreenWidth - CGRectGetMaxX(self.imgView.frame) - 20 - 13, 15);
    self.titleLab.font = commenAppFont(15);
    
    self.compereLab.frame = CGRectMake(CGRectGetMinX(self.titleLab.frame), CGRectGetMaxY(self.titleLab.frame)+ 13, CGRectGetWidth(self.titleLab.frame), 12);
    self.compereLab.font = commenAppFont(12);
    self.compereLab.textColor = [UIColor darkGrayColor];
    
    self.subTitleLab.frame = CGRectMake(CGRectGetMinX(self.titleLab.frame), CGRectGetMaxY(self.compereLab.frame)+ 12, CGRectGetWidth(self.titleLab.frame), 24);
    self.subTitleLab.font = commenAppFont(12);
    self.subTitleLab.textColor = [UIColor darkGrayColor];
    [self.subTitleLab setLineBreakMode:NSLineBreakByTruncatingTail];
    self.subTitleLab.numberOfLines = 2;
    CGSize maximumLabelSize = CGSizeMake(MyKScreenWidth - CGRectGetWidth(self.imgView.frame) - CGRectGetMinX(self.imgView.frame) * 3, 24);
    //关键语句
    CGSize expectSize = [self.subTitleLab sizeThatFits:maximumLabelSize];
    //别忘了把frame给回label，如果用xib加了约束的话可以只改一个约束的值
    self.subTitleLab.frame = CGRectMake(CGRectGetMinX(self.titleLab.frame), CGRectGetMaxY(self.compereLab.frame)+ 12, expectSize.width, expectSize.height);
    
    self.yigouLab.frame = CGRectMake(CGRectGetMinX(self.titleLab.frame), CGRectGetMaxY(self.imgView.frame)  -  12, CGRectGetWidth(self.titleLab.frame), 12);
    self.yigouLab.font = commenAppFont(12);
    self.yigouLab.textColor = [UIColor darkGrayColor];
    
    self.moneyLab.frame = CGRectMake(MyKScreenWidth - 100, CGRectGetMinY(self.yigouLab.frame), 80, 12);
    self.moneyLab.textAlignment = NSTextAlignmentRight;
    self.moneyLab.font = commenAppFont(12);
    self.moneyLab.textColor = CommonAppColor;
    
}
- (void)reloadDataFor:(WatHomeGoodsDetailsModel *)model{
    
    [self.imgView sd_setImageWithURL:model.thumb_path placeholderImage:[UIImage imageNamed:@"pic00"]];
    self.titleLab.text = model.title;
    self.compereLab.text = model.author;
    self.subTitleLab.text = model.subTitle;
    NSString *yigouLabStr = [NSString stringWithFormat:@"已有%@人购买",model.sale_num];
    self.yigouLab.text =  yigouLabStr;
    NSString *moneyLabStr = [NSString stringWithFormat:@"%@内参币",model.price];
    self.moneyLab.text =  moneyLabStr;
    
    
    self.imgView.frame = CGRectMake(13, 20, 87, 109);
    self.imgView.layer.cornerRadius = 4;
    self.imgView.clipsToBounds = YES;
    
    self.typeImgView.frame = CGRectMake(13 + CGRectGetWidth(self.imgView.frame) - 25, 20 + CGRectGetHeight(self.imgView.frame) - 25, 20, 20);
    if ([model.content_type isEqualToString:@"2"]) {
        self.typeImgView.image = [UIImage imageNamed:@"视频typeIcon"];
    }else if ([model.content_type isEqualToString:@"1"]){
        self.typeImgView.image = [UIImage imageNamed:@"音频typeIcon"];
    }
    
    self.titleLab.frame = CGRectMake(CGRectGetMaxX(self.imgView.frame) + 20, CGRectGetMinY(self.imgView.frame) + 3, MyKScreenWidth - CGRectGetMaxX(self.imgView.frame) - 20 - 13, 15);
    self.titleLab.font = commenAppFont(15);
    
    self.compereLab.frame = CGRectMake(CGRectGetMinX(self.titleLab.frame), CGRectGetMaxY(self.titleLab.frame)+ 13, CGRectGetWidth(self.titleLab.frame), 12);
    self.compereLab.font = commenAppFont(12);
    self.compereLab.textColor = [UIColor darkGrayColor];
    
    self.subTitleLab.frame = CGRectMake(CGRectGetMinX(self.titleLab.frame), CGRectGetMaxY(self.compereLab.frame)+ 12, CGRectGetWidth(self.titleLab.frame), 24);
    self.subTitleLab.font = commenAppFont(12);
    self.subTitleLab.textColor = [UIColor darkGrayColor];
    [self.subTitleLab setLineBreakMode:NSLineBreakByTruncatingTail];
    self.subTitleLab.numberOfLines = 2;
    CGSize maximumLabelSize = CGSizeMake(MyKScreenWidth - CGRectGetWidth(self.imgView.frame) - CGRectGetMinX(self.imgView.frame) * 3, 24);
    //关键语句
    CGSize expectSize = [self.subTitleLab sizeThatFits:maximumLabelSize];
    //别忘了把frame给回label，如果用xib加了约束的话可以只改一个约束的值
    self.subTitleLab.frame = CGRectMake(CGRectGetMinX(self.titleLab.frame), CGRectGetMaxY(self.compereLab.frame)+ 12, expectSize.width, expectSize.height);
    
    self.yigouLab.frame = CGRectMake(CGRectGetMinX(self.titleLab.frame), CGRectGetMaxY(self.imgView.frame)  -  12, CGRectGetWidth(self.titleLab.frame), 12);
    self.yigouLab.font = commenAppFont(12);
    self.yigouLab.textColor = [UIColor darkGrayColor];
    
    self.moneyLab.frame = CGRectMake(MyKScreenWidth - 100, CGRectGetMinY(self.yigouLab.frame), 80, 12);
    self.moneyLab.textAlignment = NSTextAlignmentRight;
    self.moneyLab.font = commenAppFont(12);
    self.moneyLab.textColor = CommonAppColor;
    
}
@end
