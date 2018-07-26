//
//  HorScorllView.m
//  CustomView
//
//  Created by Arthur on 2017/10/18.
//  Copyright © 2017年 Arthur. All rights reserved.
//

#import "HorScorllView.h"

#define ImageButtonWidth 99  //[UIScreen mainScreen].bounds.size.width / 3

@interface HorScorllView ()



@end

@implementation HorScorllView

- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
//        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.backgroundColor = [UIColor whiteColor];
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 20, [UIScreen mainScreen].bounds.size.width - 20, self.frame.size.height)];
    scrollView.showsHorizontalScrollIndicator = NO;
    
    [self addSubview:scrollView];
    for (int i = 0; i < _images.count; i++) {
        self.imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.imageButton.frame = CGRectMake(i * (ImageButtonWidth + 26), 0, ImageButtonWidth, 115);
        self.imageButton.layer.masksToBounds = YES;
        self.imageButton.layer.cornerRadius = 4.0;
        self.imageButton.contentMode = 2;
        [self.imageButton addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        self.imageButton.tag = i + 100;

        self.imageButton.transform = CGAffineTransformMakeScale(0.9, 1.0);
        [self.imageButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self.imageButton setBackgroundImage:[UIImage imageNamed:@"bowang"] forState:UIControlStateNormal];
        
        self.typeImgView = [[UIImageView alloc]initWithFrame:CGRectMake(i*26 + (i + 1)* ImageButtonWidth - 30 , CGRectGetMaxY(self.imageButton.frame) - 25, 20, 20)];
        self.typeImgView.contentMode = 1;
        self.typeImgView.tag = i + 400;
        
        
        //图片下面显示文字
        self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(i * (ImageButtonWidth + 26) + (i + 1) *3, CGRectGetMaxY(self.imageButton.frame) + 5, ImageButtonWidth, 28)];
        self.textLabel.tag = i + 200;
        self.textLabel.text = [NSString stringWithFormat:@"博网博网博网博网博网博网博网博网博网博网博网博网博网博网博网博网"];
        self.textLabel.font = commenAppFont(14);
        self.textLabel.textColor = [UIColor darkGrayColor];
        self.textLabel.numberOfLines = 2;
        self.textLabel.textAlignment = NSTextAlignmentLeft;
        [self.textLabel sizeToFit];
        

        
        
        self.moneylab = [[UILabel alloc] initWithFrame:CGRectMake(i * (ImageButtonWidth + 29), CGRectGetMaxY(self.textLabel.frame) + 5, ImageButtonWidth, 12)];
        self.moneylab.tag = i + 300;
        //价格文字
        //self.moneylab.text = [NSString stringWithFormat:@"定价:49.0"];
        self.moneylab.textColor = [UIColor redColor];
        self.moneylab.textAlignment = NSTextAlignmentLeft;
        self.moneylab.font = commenAppFont(12);
       
        [scrollView addSubview:self.imageButton];
        [scrollView addSubview:self.textLabel];
        [scrollView addSubview:self.moneylab];
        [scrollView addSubview:self.typeImgView];

    }
    scrollView.contentSize = CGSizeMake((ImageButtonWidth + 36) * _images.count, self.frame.size.height);
}

- (void)setImages:(NSArray *)images {
    _images = images;
    
    [self setupUI];
    
    
    for (int i = 0; i < _images.count; i ++) {
        UIButton *imageButton = (UIButton *)[self viewWithTag:i + 100];
        //[imageButton xr_setButtonImageWithUrl:_images[i]];
        //[imageButton sd_setImageWithURL:_images[i]]
        [imageButton sd_setImageWithURL:[NSURL URLWithString:_images[i]] forState:UIControlStateNormal];
    }
    
}
- (void)setTypeImgs:(NSArray *)typeImgs {
    _typeImgs = typeImgs;
    
    for (int i = 0; i < _typeImgs.count; i ++) {
        UIImageView *typeImgView = [self viewWithTag:i + 400];
        NSString *str = _typeImgs[i];
        if ([str isEqualToString:@"1"]) {//1音频  2视频
            typeImgView.image = [UIImage imageNamed:@"音频typeIcon"];
        }else if ([str isEqualToString:@"2"]){
            typeImgView.image = [UIImage imageNamed:@"视频typeIcon"];
        }else{
            typeImgView.hidden = YES;
        }
    }
    
}
- (void)setMoneys:(NSArray *)moneys {
     _moneys = moneys;
    
    for (int i = 0; i < _moneys.count; i ++) {
        UILabel *textLabel = [self viewWithTag:i + 300];
        NSString *str = _moneys[i];
        textLabel.text = [NSString stringWithFormat:@"定价:%@元",str];
    }
    
}
- (void)setTitles:(NSArray *) titles{
    _titles = titles;
    for (int i = 0; i < _titles.count; i ++) {
        UILabel *textLabel = [self viewWithTag:i + 200];
        textLabel.text = _titles[i];
    }
}


- (void)clickAction:(UIButton *)button {
    
    if ([self.delegate respondsToSelector:@selector(horImageClickAction:section:)]) {
        [self.delegate horImageClickAction:button.tag section:self.section];
    }
}




@end
