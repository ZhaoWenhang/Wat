//
//  WatAlreadyBoughtCourseViewController.m
//  wat
//
//  Created by 123 on 2018/5/22.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "WatAlreadyBoughtCourseViewController.h"
#import "WMPageController.h"
#import "YigouOneViewController.h"
#import "YigouTwoViewController.h"
@interface WatAlreadyBoughtCourseViewController ()<WMPageControllerDelegate,scrollDelegate>
@property(nonatomic,strong) UIScrollView  *parentScrollView;

@end

@implementation WatAlreadyBoughtCourseViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navBarView.hidden = NO;
    self.navBarView.alpha = 1;
    self.isBackTitle = NO;
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.navTitle = @"大鱼餐饮学院";
    self.view.backgroundColor = WatBackColor;
    
    [self.view addSubview:self.setPageViewControllers];
}

-(UIView *)setPageViewControllers
{
    WMPageController *pageController = [self p_defaultController];
    pageController.title = @"Line";
    pageController.menuViewStyle = WMMenuViewStyleLine;
    pageController.titleSizeSelected = 15;
    
    [self addChildViewController:pageController];
    [pageController didMoveToParentViewController:self];
    return pageController.view;
}
- (WMPageController *)p_defaultController {
    
    YigouOneViewController * oneVc  = [YigouOneViewController new];
    oneVc.delegate = self;
    
    YigouTwoViewController * twoVc  = [YigouTwoViewController new];
    twoVc.delegate = self;
    
    NSArray *viewControllers = @[oneVc,twoVc];
    
    NSArray *titles = @[@"精选课程",@"线下课程"];
    WMPageController *pageVC = [[WMPageController alloc] initWithViewControllerClasses:viewControllers andTheirTitles:titles];
    
    [pageVC setViewFrame:CGRectMake(0, MyTopHeight + 5, MyKScreenWidth, MyKScreenHeight - 5)];
    pageVC.delegate = self;
    pageVC.titleFontName = @"Sinhala Sangam MN";
    pageVC.menuItemWidth = MyKScreenWidth * 0.5;
    pageVC.menuHeight = 44;
    pageVC.postNotification = YES;
    pageVC.bounces = YES;
    
    return pageVC;
}

- (void)scrollViewLeaveAtTheTop:(UIScrollView *)scrollView{
    self.parentScrollView = scrollView;
    
    //main tv滑动到顶 sub tv向下滑动到顶,main tv可以滚动
    //_mainScroll = YES;
    
}
- (void)scrollViewChangeTab:(UIScrollView *)scrollView{
    
    //刷新滚动表格
    self.parentScrollView = scrollView;
    NSLog(@"%@",NSStringFromClass([self.parentScrollView class]));
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    //记录main tv 起始偏移
    //star_y = scrollView.contentOffset.y;
}



@end
