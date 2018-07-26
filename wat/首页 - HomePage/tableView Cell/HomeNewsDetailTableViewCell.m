//
//  HomeNewsDetailTableViewCell.m
//  wat
//
//  Created by 123 on 2018/5/24.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "HomeNewsDetailTableViewCell.h"

@implementation HomeNewsDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor whiteColor];

    self.detailLabel.hidden = YES;
    self.timeLabel.hidden = YES;
    self.timeImgView.hidden = YES;
    self.likeImg.hidden = YES;
    self.checkImg.hidden = YES;
    
    self.cellBackgroundView.frame = CGRectMake(0, 0, MyKScreenWidth, 116); //背景
    
    self.imgView.frame = CGRectMake(MyKScreenWidth - 13 - 116, 20, 116, 77);
    self.imgView.contentMode = 2;
    self.imgView.layer.cornerRadius = 4;
    self.imgView.clipsToBounds = YES;
    
    
}

- (void)reloadDataFor:(WatHomeNewsDetailsModel *)model {
   
    self.titleLabel.text = model.title;
    [self.imgView sd_setImageWithURL:model.thumb];
    
    self.checkLabel.textColor = [UIColor grayColor];
    NSMutableAttributedString *colorText = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@浏览",model.pviews]];
    NSRange rangel = [[colorText string] rangeOfString:[model.pviews substringFromIndex:0]];
    [colorText addAttribute:NSForegroundColorAttributeName value:CommonAppColor range:rangel];
    //[colorText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:rangel];
    [self.checkLabel setAttributedText:colorText];
//    NSString *checkStr = [NSString stringWithFormat:@"%@浏览",model.pviews];
//    self.checkLabel.text = checkStr;
    
    self.likeLabel.text = [NSString stringWithFormat:@"作者: %@",model.author];
    NSString *writeStr = [NSString stringWithFormat:@"#%@#",model.type];
    self.writerLabel.text = writeStr;
    

    self.titleLabel.frame = CGRectMake( 14, 20, MyKScreenWidth - self.imgView.frame.size.width - 14 - 13 - 20 , 40);
    self.titleLabel.font = commenAppFont(15);
    [self.titleLabel setLineBreakMode:NSLineBreakByTruncatingTail];
    self.titleLabel.numberOfLines = 2;
    CGSize maximumLabelSize = CGSizeMake(MyKScreenWidth - self.imgView.frame.size.width - 14 - 13 - 20, 40);//labelsize的最大值
    //关键语句
    
    CGSize expectSize = [self.titleLabel sizeThatFits:maximumLabelSize];
    
    //别忘了把frame给回label，如果用xib加了约束的话可以只改一个约束的值
    
    self.titleLabel.frame = CGRectMake(14, 20, expectSize.width, expectSize.height);
    
    
    //[self.titleLabel sizeToFit];
    //self.titleLabel.textAlignment = NSTextAlignmentLeft;
    
    
    //    self.checkImg.frame = CGRectMake(self.imgView.frame.size.width + self.imgView.frame.origin.x + 15, self.imgView.frame.origin.y + self.imgView.frame.size.height - 9, 12, 9);
    //    self.checkImg.contentMode = 2;
    self.checkLabel.frame = CGRectMake(14, self.imgView.frame.origin.y + self.imgView.frame.size.height - 11, 35, 10);
    self.checkLabel.font = commenAppFont(10);
    self.checkLabel.numberOfLines = 1;
    [self.checkLabel sizeToFit];
    self.checkLabel.textAlignment = NSTextAlignmentLeft;
    self.checkLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;//换行方式
    
    //    self.likeImg.frame = CGRectMake(self.checkLabel.frame.origin.x + self.checkLabel.frame.size.width + 5, self.checkLabel.frame.origin.y, 10, 10);
    self.likeLabel.frame = CGRectMake(CGRectGetMaxX(self.checkLabel.frame) + 4, self.checkLabel.frame.origin.y, 70, 10);
    self.likeLabel.textColor = [UIColor grayColor];
    self.likeLabel.font = commenAppFont(10);
    self.likeLabel.numberOfLines = 1;
    [self.likeLabel sizeToFit];
    self.likeLabel.textAlignment = NSTextAlignmentLeft;
    
    self.writerLabel.frame = CGRectMake(MyKScreenWidth - self.imgView.frame.size.width - 14 - 13 - 20 - 20, self.checkLabel.frame.origin.y, 10, 10);
    self.writerLabel.textAlignment = NSTextAlignmentRight;
    self.writerLabel.textColor = CommonAppColor;
    self.writerLabel.font = commenAppFont(10);
    [self.writerLabel sizeToFit];
    self.writerLabel.frame = CGRectMake(MyKScreenWidth - self.imgView.frame.size.width - 14 - 13 - 20  - self.writerLabel.frame.size.width, self.checkLabel.frame.origin.y + 2, self.writerLabel.frame.size.width, 10);
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
