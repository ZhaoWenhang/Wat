//
//  HomeAudioClassViewController.m
//  wat
//
//  Created by 123 on 2018/6/27.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "HomeAudioClassViewController.h"
//功能控制器
#import "MainTableView.h"
#import "WMPageController.h"
//--------------------- 子控制器 --------------
#import "VideoOneViewController.h"
#import "VideoTwoViewController.h"


//------------------- 播放器 ------------------
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

#import "HKFloatManager.h"//浮球控制器

@interface HomeAudioClassViewController ()<scrollDelegate,WMPageControllerDelegate,UITableViewDataSource,UITableViewDelegate>
{
    CGFloat star_y;
    
}
@property (nonatomic,strong)MainTableView *mainTableView;
@property(nonatomic,strong) UIScrollView  *parentScrollView;

@property (nonatomic,assign)BOOL mainScroll;
@property (nonatomic, assign)BOOL selected;

//------------------- 播放器 ------------------
@property (nonatomic, strong) AVPlayer * player;
@property (nonatomic, strong) UIButton *zantingBtn;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) AVPlayerItem   *currentPlayerItem; //音频 item
@property (nonatomic, strong) NSTimer *avTimer; //监控进度
@property (nonatomic, strong) UISlider *jinduSlider; //进度条
@property (nonatomic, assign) CGFloat sumPlayOperation; //播放的总时长

@property (nonatomic, strong) HKFloatManager *HKFloatManager;
@end

@implementation HomeAudioClassViewController
- (AVPlayer *)player{
    
    if (_player == nil) {
        
        _player = [[AVPlayer alloc] init];
        _player.volume = 1.0; // 默认最大音量

    }
    return _player;
}
- (HKFloatManager *)HKFloatManager{
    if (!_HKFloatManager) {
        _HKFloatManager = [HKFloatManager new];
    }
    return _HKFloatManager;
}


#pragma mark - scrollDelegate
- (void)scrollViewLeaveAtTheTop:(UIScrollView *)scrollView{
    self.parentScrollView = scrollView;
    
    //main tv滑动到顶 sub tv向下滑动到顶,main tv可以滚动
    _mainScroll = YES;
    
}
- (void)scrollViewChangeTab:(UIScrollView *)scrollView{
    
    //刷新滚动表格
    self.parentScrollView = scrollView;
    NSLog(@"%@",NSStringFromClass([self.parentScrollView class]));
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    //记录main tv 起始偏移
    star_y = scrollView.contentOffset.y;
}

#pragma mark - Logic




- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"音频课程";
    //默认初始 主tv可滚动
    _mainScroll = YES;
    
    self.mainTableView.bounces = NO;
    
    if (@available(iOS 11.0, *)) {
        self.mainTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self.view addSubview:self.mainTableView];
    
    [self addAudioPlay];
    [self.player play]; //一进来就播放
    [self setAudioUI];
    
    
//    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(100, 300, 50, 50)];
//    v.backgroundColor = [UIColor blueColor];
//    v.userInteractionEnabled = YES;
//    [self.view addSubview:v];
    
   
    
    //注册通知
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(dellocAuido) name:WatDeallocAudioControllerNotification object:nil];
    
    //添加播放结束监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.player.currentItem];
    
}


- (void)dellocAuido{
    NSLog(@"结束音频生命周期");
    //[self.player pause];
    [self.player pause];
    self.player = nil;
    

}
- (void) playbackFinished:(AVPlayer *)player{
    [WATHud showInfo:@"音频播放结束"];
}
- (void)addAudioPlay {
    //NSString * path = [[NSBundle mainBundle] pathForResource:@"" ofType:@"mp3"];
    //NSString *path = @"http://m2.music.126.net/dUZxbXIsRXpltSFtE7Xphg==/1375489050352559.mp3";
    //        _player = [[AVPlayer alloc] initWithURL:[[NSURL fileURLWithPath:path]]];
    _player = [[AVPlayer alloc]initWithURL:[NSURL URLWithString:@"http://m2.music.126.net/dUZxbXIsRXpltSFtE7Xphg==/1375489050352559.mp3"]];
    
    self.avTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timer) userInfo:nil repeats:YES];
    
}

- (void)setAudioUI{
    
    CGFloat imageHeight = 49;
    
    UIView *bgV= [[UIView alloc]initWithFrame:CGRectMake(0, MyKScreenHeight - MyTabBarHeight - 10, MyKScreenWidth, MyTabBarHeight + 10)];
    bgV.backgroundColor = CommonAppColor;
    [self.view addSubview:bgV];
    
    //旋转 image
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, imageHeight, imageHeight)];
    self.imageView = imageView;
    imageView.image = [UIImage imageNamed:@"1234567890"];
    imageView.layer.cornerRadius = (imageHeight) * 0.5;
    imageView.contentMode = 2;
    imageView.clipsToBounds = YES;
    [self rotateView:imageView];
    [bgV addSubview:imageView];
    //设置layer
    CALayer *layer=[imageView layer];
    //是否设置边框以及是否可见
    [layer setMasksToBounds:YES];
    //设置边框圆角的弧度
    //[layer setCornerRadius:10.0];
    //设置边框线的宽
    //
    [layer setBorderWidth:2.5];
    //设置边框线的颜色
    [layer setBorderColor:[[UIColor whiteColor] CGColor]];
    
    UISlider *jinduSlider = [[UISlider alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame) + 10,CGRectGetMinY(imageView.frame), MyKScreenWidth - CGRectGetMaxX(imageView.frame) - 10 - 15, 10)];
    self.jinduSlider = jinduSlider;
    UIImage *image = [self OriginImage:[UIImage imageNamed:@"music_slider_circle"] scaleToSize:CGSizeMake(30, 30)];
    [jinduSlider setThumbImage:image forState:UIControlStateNormal];
    [jinduSlider addTarget:self action:@selector(changeProgress:) forControlEvents:UIControlEventTouchUpInside];
    [bgV addSubview:jinduSlider];
    
    
    //07.minimumTrackTintColor : 小于滑块当前值滑块条的颜色，默认为蓝色
    jinduSlider.minimumTrackTintColor = [UIColor yellowColor];
    //08.maximumTrackTintColor: 大于滑块当前值滑块条的颜色，默认为白色
    jinduSlider.maximumTrackTintColor = [UIColor whiteColor];
    
    
//    UILabel *jinduLab = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(jinduSlider.frame), 40, 9)];
//    jinduLab.textColor = [UIColor grayColor];
//    jinduLab.font = commenAppFont(9);
//    [bgV addSubview:jinduLab];
//    jinduLab.text = [NSString stringWithFormat:@"%0.2lf",self.player.currentItem.duration.value];
    
    
    UIButton *zantingBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 5, imageHeight, imageHeight)];
    self.zantingBtn = zantingBtn;
    [zantingBtn setTitle:@"zant" forState:UIControlStateNormal];
    [zantingBtn setImage:[UIImage imageNamed:@"big_pause_button"] forState:UIControlStateNormal];
    [zantingBtn setImage:[UIImage imageNamed:@"big_play_button"] forState:UIControlStateSelected];
    [zantingBtn setSelected:_selected];
    [bgV addSubview:zantingBtn];
    [zantingBtn addTarget:self action:@selector(zantingClick) forControlEvents:UIControlEventTouchUpInside];
}
- (void)rotateView:(UIImageView *)view //imageView旋转

{
    
    CABasicAnimation *rotationAnimation;
    
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI*2.0];
    
    rotationAnimation.duration = 4;
    
    rotationAnimation.repeatCount = HUGE_VALF;
    
    rotationAnimation.removedOnCompletion = NO;//防止退到后台后,停止动画
    
    [view.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    //[self.playStatusImageView.layer removeAllAnimations];//停止动画  在哪用在哪调用, 暂时放这,别忘记了
    
    
}
//暂停动画

- (void)pauseAnimation {
    
    
    
    //（0-5）
    
    //开始时间：0
    
    //    myView.layer.beginTime
    
    //1.取出当前时间，转成动画暂停的时间
    
    CFTimeInterval pauseTime = [self.imageView.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    
    
    
    //2.设置动画的时间偏移量，指定时间偏移量的目的是让动画定格在该时间点的位置
    
    self.imageView.layer.timeOffset = pauseTime;
    
    
    
    //3.将动画的运行速度设置为0， 默认的运行速度是1.0
    
    self.imageView.layer.speed = 0;
    
    
    
}



//恢复动画

- (void)resumeAnimation {
    
    
    
    //1.将动画的时间偏移量作为暂停的时间点
    
    CFTimeInterval pauseTime = self.imageView.layer.timeOffset;
    
    
    
    //2.计算出开始时间
    
    CFTimeInterval begin = CACurrentMediaTime() - pauseTime;
    
    
    
    [self.imageView.layer setTimeOffset:0];
    
    [self.imageView.layer setBeginTime:begin];
    
    
    
    self.imageView.layer.speed = 1;
    
}
-(UIImage *)OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0,0, size.width, size.height)];
    UIImage *scaleImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaleImage;
}
- (void)zantingClick {
    _selected = !_selected;
    if (_selected) {
        self.zantingBtn.selected = YES;
        [_player pause];
        [self pauseAnimation];
    }else{
        [_player play];
        self.zantingBtn.selected = NO;
        
        [self resumeAnimation];
        
    }
    
    
    
}
//拖动手势
- (void)changeProgress:(UIButton *)slider{
    self.sumPlayOperation = self.player.currentItem.duration.value/self.player.currentItem.duration.timescale;
    //CMTimeMake(a,b) a表示当前时间，b表示每秒钟有多少帧
    [self.player seekToTime:CMTimeMakeWithSeconds(self.jinduSlider.value*self.sumPlayOperation, self.player.currentItem.duration.timescale) completionHandler:^(BOOL finished) {
        [self.player play];
    }];
}
//监控播放进度方法

- (void)timer

{
    
    self.jinduSlider.value = CMTimeGetSeconds(self.player.currentItem.currentTime) / CMTimeGetSeconds(self.player.currentItem.duration);
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return scr_hei-MyTopHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    /* 添加pageView
     * 这里可以任意替换你喜欢的pageView
     *作者这里使用一款github较多人使用的 WMPageController 地址https://github.com/wangmchn/WMPageController
     */
    [cell.contentView addSubview:self.setPageViewControllers];
    return cell;
    
}



#pragma mark -- setter/getter

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
    VideoOneViewController * oneVc  = [VideoOneViewController new];
    //oneVc.URLStr = self.onePageUrl;
    oneVc.delegate = self;
    
    VideoTwoViewController * twoVc  = [VideoTwoViewController new];
    twoVc.delegate = self;
    
    NSArray *viewControllers = @[oneVc,twoVc];
    
    NSArray *titles = @[@"详情",@"目录"];
    WMPageController *pageVC = [[WMPageController alloc] initWithViewControllerClasses:viewControllers andTheirTitles:titles];
    [pageVC setViewFrame:CGRectMake(0, 0, scr_wid, scr_hei)];
    pageVC.delegate = self;
    pageVC.menuItemWidth = MyKScreenWidth / titles.count;
    pageVC.menuHeight = 44;
    pageVC.postNotification = YES;
    pageVC.bounces = YES;
    
    return pageVC;
}

- (MainTableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[MainTableView alloc]initWithFrame:CGRectMake(0, MyTopHeight, scr_wid, MyKScreenHeight - MyTopHeight) style:UITableViewStylePlain];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.estimatedSectionHeaderHeight = 0;
        _mainTableView.estimatedSectionFooterHeight = 0;
        //_mainTableView.contentInset = UIEdgeInsetsMake(227, 0, 0, 0);
        _mainTableView.backgroundColor = [UIColor grayColor];
        
    }
    return _mainTableView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat height = MyTopHeight;
    
    CGFloat offset = scrollView.contentOffset.y;
    NSLog(@"滚动偏移量+++++++%lf  ++++++%lf",offset,MyTopHeight);
    //导航栏透明度
    if (offset<=-MyTopHeight) {
        
        CGFloat alpha =(182 + offset) / 100;
        self.navBarView.alpha = alpha;
        
        if (self.navBarView.alpha > 0.3) {
            self.navTitle = @"音频";
        }else{
            self.navTitle = @"";
        }
        
    }
    
    //滚动逻辑
    
    //main tv目前处于未置顶状态 并且 可以滚动
    if (offset <  - MyTopHeight && _mainScroll) {
        
        //main tv滚动起始位置处于置顶和0点之间 并且 sub tv不是置顶状态
        if (star_y < - MyTopHeight && star_y > -227 + 100 &&
            self.parentScrollView.contentOffset.y>0) {
            
            //一起滚动
            
        }else{
            
            //sub tv是置顶状态或者0点位置 限制sub滚动
            
            self.parentScrollView.contentOffset = CGPointMake(0, 0);
        }
    }else{
        //main tv滑动到顶 sub tv正在向下滑动
        scrollView.contentOffset = CGPointMake(0, -MyTopHeight);
    }
    
    //main tv目前处于置顶状态 并且 可以滚动
    if (offset >= -MyTopHeight && _mainScroll) {
        
        //禁止滚动 固定位置
        _mainScroll = NO;
        scrollView.contentOffset = CGPointMake(0, -MyTopHeight);
    }
    
}

//移除通知
-(void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
- (void)backAction{
    //返回按钮,直接停掉, 只有侧滑才可以继续听.
    [self.player pause];
    self.player = nil;
    //[self.navigationController popViewControllerAnimated:YES];
    
    UIViewController *controller = self.navigationController.viewControllers[1];
    
    [self.navigationController popToViewController:controller animated:YES];
    
    
}
@end
