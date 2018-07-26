//
//  DWPopView.m
//  DWslideViewDemo
//
//  Created by dangwc on 2018/1/10.
//  Copyright © 2018年 dangwc. All rights reserved.
//

#import "DWPopView.h"
#import "DWDirectionPanGestureRecognizer.h"

#define dw_screenWith  [UIScreen mainScreen].bounds.size.width
#define dw_screenHeight  [UIScreen mainScreen].bounds.size.height
#define dw_slideView_bottom  0    //默认是0,可以自定义(视图收起时保留的视图高度: 0表示视图全部移出界面,设置其他参数表示还有部分视图留在界面)


@interface DWPopView ()
@property (nonatomic, assign)CGFloat slideView_orginHeight;
@property (nonatomic, assign)CGFloat slideView_height;
@property (nonatomic, assign)CGRect slideView_frame;
@property (nonatomic, assign)CGFloat start;
@property (nonatomic, assign)CGFloat end;
@end


@implementation DWPopView
{




    
}


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {

        DWDirectionPanGestureRecognizer *pan = [[DWDirectionPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGes:)];
        pan.direction = DWDirectionPangestureRecognizerVertical;
        [self addGestureRecognizer:pan];
        self.slideView_height = CGRectGetMinY(self.frame);
        self.slideView_orginHeight = CGRectGetHeight(self.frame);
        self.slideView_frame = self.frame;
        
    }
    return self;
}



-(void)panGes:(DWDirectionPanGestureRecognizer *)pan{
    
    if (pan.direction == DWDirectionPangestureRecognizerVertical) {
        switch (pan.state) {
            case UIGestureRecognizerStateBegan:{
                self.start =  CGRectGetMinY(self.frame);
                break;
            }
                
            case UIGestureRecognizerStateChanged:{
                
                //可视范围的高
                CGFloat displayHeight = dw_screenHeight - CGRectGetMinY(self.frame);
                CGPoint point = [pan translationInView:self];
                if (CGRectGetMinY(self.frame)< self.start  && displayHeight > self.slideView_orginHeight) {
                    
                }else{
                    self.center = CGPointMake(self.center.x, self.center.y + point.y);
                    [pan setTranslation:CGPointZero inView:self];
                }
                
                break;
            }
                
                
            case UIGestureRecognizerStateEnded:{
                
                self.end =  CGRectGetMinY(self.frame);
                CGFloat height = (dw_screenHeight - self.slideView_height)/2;
                __weak typeof (self)weakSelf = self;
                if (((self.end - self.start) > height) && (self.end > self.start)) {
                    [UIView animateWithDuration:0.25 animations:^{
                        weakSelf.frame = CGRectMake(0, dw_screenHeight - dw_slideView_bottom, dw_screenWith,self.slideView_orginHeight);
                        [weakSelf layoutIfNeeded];
                    }];
                    
                }else{
                    
                    [UIView animateWithDuration:0.25 animations:^{
                        weakSelf.frame = CGRectMake(0, dw_screenHeight - self.slideView_orginHeight, dw_screenWith, self.slideView_orginHeight);
                        self.slideView_height = CGRectGetMinY(weakSelf.frame);
                        self.slideView_frame = weakSelf.frame;
                        [weakSelf layoutIfNeeded];
                    }];
                    
                }
                
                break;
            }
            default:
                break;
        }
    }
}



-(void)dw_popView{
    
        [UIView animateWithDuration:0.25 animations:^{
            self.frame = CGRectMake(0,dw_screenHeight - self.slideView_orginHeight, dw_screenWith, self.slideView_orginHeight);
            self.slideView_height = CGRectGetMinY(self.frame);
            self.slideView_frame = self.frame;
        [self layoutIfNeeded];
        }];
}

-(void)dw_dismissView{
    
        [UIView animateWithDuration:0.25 animations:^{
            self.frame = CGRectMake(0, dw_screenHeight - dw_slideView_bottom, dw_screenWith, self.slideView_orginHeight);
            [self layoutIfNeeded];
        }]; 
}


@end
