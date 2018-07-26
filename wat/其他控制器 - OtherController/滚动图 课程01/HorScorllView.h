//
//  HorScorllView.h
//  CustomView
//
//  Created by Arthur on 2017/10/18.
//  Copyright © 2017年 Arthur. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HorScorllViewImageClickDelegate <NSObject>

- (void)horImageClickAction:(NSInteger)tag section:(NSInteger)section;

@end

@interface HorScorllView : UIView

@property (nonatomic, strong) UIButton *imageButton;
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UILabel *moneylab;
@property (nonatomic, strong) UIImageView *typeImgView;

@property (nonatomic, strong) NSArray *images;  /**图片*/

@property (nonatomic, strong) NSArray *typeImgs; /**视频音频 type*/

@property (nonatomic, strong) NSArray *titles;  /**标题*/

@property (nonatomic, strong) NSArray *moneys;   /**价格*/

@property (nonatomic, assign) NSInteger section; //如果到多个 section 的时候,用来判断

@property (nonatomic, weak) __weak id<HorScorllViewImageClickDelegate> delegate;


@end
