//
//  NSTimer+Pluto.h
//  TimerDemo
//
//  Created by 马德茂 on 16/5/4.
//  Copyright © 2016年 马德茂. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (Pluto)
/**
 *  创建一个不会造成循环引用的循环执行的Timer
 */
+ (instancetype)pltScheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo;

@end




//使用方法
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    
//    self.timer = [NSTimer pltScheduledTimerWithTimeInterval:2.0 target:self selector:@selector(timerAction:) userInfo:@"userInfo"];
//    
//    
//    
//    //这样创建的timer，target的dealloc方法不会执行，因为timer会持有target，进而造成循环引用
//    //    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(timerAction:) userInfo:@"userInfo" repeats:YES];
//    
//}
//
//- (void)timerAction:(NSTimer *)timer
//{
//    NSLog(@"%@", timer.userInfo);
//}
//
//- (void)dealloc
//{
//    [self.timer invalidate];
//    self.timer = nil;
//    NSLog(@"%@ dealloc", self);
//}
