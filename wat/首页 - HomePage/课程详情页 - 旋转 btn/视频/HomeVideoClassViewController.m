//
//  HomeVideoClassViewController.m
//  wat
//
//  Created by 123 on 2018/6/27.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "HomeVideoClassViewController.h"
#import "WatHomeClass01ViewController.h"
#import "AppDelegate.h"//视频横屏
//功能控制器
#import "MainTableView.h"
#import "WMPageController.h"
#import "NSTimer+Pluto.h"
//-------------------- 视频播放器 ----------------
#import "XjAVPlayerSDK.h"

//--------------------- 子控制器 --------------
#import "VideoOneViewController.h"
#import "VideoTwoViewController.h"

//------------------- 音频播放器 ------------------
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

@interface HomeVideoClassViewController ()<scrollDelegate,WMPageControllerDelegate,UITableViewDataSource,UITableViewDelegate,XjAVPlayerSDKDelegate>
{
    CGFloat star_y;
    XjAVPlayerSDK *myPlayer;
}
@property (nonatomic,strong)MainTableView *mainTableView;
@property(nonatomic,strong) UIScrollView  *parentScrollView;
@property (nonatomic,assign)BOOL mainScroll;

//------------------- 播放器 ------------------
@property (nonatomic, strong) AVPlayer * player;
@property (nonatomic, strong) UIButton *zantingBtn;
@property (nonatomic, assign)BOOL selected;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) AVPlayerItem   *currentPlayerItem; //音频 item
@property (nonatomic, strong) NSTimer *avTimer; //监控进度
@property (nonatomic, strong) UISlider *jinduSlider; //进度条
@property (nonatomic, assign) CGFloat sumPlayOperation; //播放的总时长
@property (nonatomic, strong) NSString *audioOrVideoUrl; //视频或者音频的 url
@property (nonatomic, strong) NSString *VideoTitel;//视频播放标题
@property (nonatomic, strong) NSString *webUrl; //oneController url
@property (nonatomic, strong) UILabel *currentTimeLab; //音频当前播放时间
@property (nonatomic, strong) UILabel *durationLab;    //音频总长

@end

@implementation HomeVideoClassViewController

- (AVPlayer *)player{
    
    if (_player == nil) {
        
        _player = [[AVPlayer alloc] init];
        _player.volume = 1.0; // 默认最大音量
        
    }
    return _player;
}

- (MainTableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[MainTableView alloc]initWithFrame:CGRectMake(0, 0, scr_wid, scr_hei) style:UITableViewStylePlain];
        _mainTableView = [[MainTableView alloc]init];
        //_mainTableView.style = UITableViewStylePlain;
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.estimatedSectionHeaderHeight = 0;
        _mainTableView.estimatedSectionFooterHeight = 0;
        //_mainTableView.contentInset = UIEdgeInsetsMake(227, 0, 0, 0);
        _mainTableView.backgroundColor = [UIColor grayColor];
        _mainTableView.separatorStyle = NO; //隐藏分割线
        [self.view addSubview:_mainTableView];
        [_mainTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view.mas_left);
            make.right.mas_equalTo(self.view.mas_right);
            make.top.mas_equalTo(self.view.mas_top).offset(0);
            make.bottom.mas_equalTo(self.view.mas_bottom);
        }];
        
        
    }
    return _mainTableView;
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
    //NSLog(@"%@",NSStringFromClass([self.parentScrollView class]));
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    //记录main tv 起始偏移
    star_y = scrollView.contentOffset.y;
}

#pragma mark - Logic


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    //视频横屏
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.allowRotation = NO;//不让横屏的时候 appDelegate.allowRotation = NO;即可
    
    // [[UIApplication sharedApplication] setStatusBarHidden:NO];//隐藏状态栏
    
    [self setStatusBarBackgroundColor:[UIColor clearColor]];
    self.isBackTitle = NO;
    self.navBarView.hidden = NO;
    self.navigationController.navigationBar.hidden = NO;
    
    if ([self.typeName isEqualToString:@"音频"]) {
        //关闭定时器
        [self.avTimer setFireDate:[NSDate distantFuture]];
        [self.avTimer invalidate];
        self.avTimer = nil;
    }
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    if ([self.typeName isEqualToString:@"视频"]) {
        
        //        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];//将状态栏颜色改回白色
        [self setStatusBarBackgroundColor:[UIColor blackColor]];
        
        //[[UIApplication sharedApplication] setStatusBarHidden:YES];//隐藏状态栏
        
        //视频横屏
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        appDelegate.allowRotation = YES;//不让横屏的时候 appDelegate.allowRotation = NO;即可
        
        self.typeName = self.watHomeClassListDetailModel.goods_type_name;
        
        self.navTitle = @"";
        self.navBarView.hidden = YES;
        self.isBackTitle = YES;
        self.navigationController.navigationBar.hidden = YES;
    }else if ([self.typeName isEqualToString:@"音频"]) {
        
        self.isBackTitle = NO;
        self.navBarView.hidden = NO;
        self.navBarView.alpha = 0;
        self.navigationController.navigationBar.hidden = NO;
        [self addAudio];//添加 audio
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //默认初始 主tv可滚动
    _mainScroll = NO;
    self.mainTableView.bounces = NO;
    if ([self.typeName isEqualToString:@"视频"]) {
        
        [self setStatusBarBackgroundColor:[UIColor blackColor]];
        
        //[[UIApplication sharedApplication] setStatusBarHidden:YES];//隐藏状态栏
        
        //视频横屏
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        appDelegate.allowRotation = YES;//不让横屏的时候 appDelegate.allowRotation = NO;即可
        
        self.typeName = self.watHomeClassListDetailModel.goods_type_name;
        
        self.navTitle = @"";
        self.navBarView.hidden = YES;
        self.isBackTitle = YES;
        self.navigationController.navigationBar.hidden = YES;
    }else if ([self.typeName isEqualToString:@"音频"]) {
        NSLog(@"%@",self.tableViewCellRow);
        self.isBackTitle = NO;
        self.navBarView.hidden = NO;
        self.navBarView.alpha = 0;
        self.navigationController.navigationBar.hidden = NO;
        [self addAudio];//添加 audio
     
    }else if([self.typeName isEqualToString:@"专栏"] || [self.typeName isEqualToString:@"图文"]){
        self.navTitle = self.watHomeClassListDetailModel.goods_type_name;
        self.isBackTitle = NO;
        self.navBarView.hidden = NO;
        self.navBarView.alpha = 1;
        self.navigationController.navigationBar.hidden = NO;
    }
    
    NSNotificationCenter *notiCenter = [NSNotificationCenter defaultCenter];
    [notiCenter addObserver:self selector:@selector(receiveNotification:) name:WatRefeshAudioOrVideoDataNotification object:nil];
    if (@available(iOS 11.0, *)) {
        self.mainTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [notiCenter addObserver:self selector:@selector(WatVideoNotPlayPopControllerNotificationClick) name:WatVideoNotPlayPopControllerNotification object:nil];
    
}
- (void)receiveNotification:(NSNotification *)dic{
    [myPlayer xjStopPlayer];//关闭播放器
    [self.player pause];
    
    NSLog(@"接收传值,并作出相应的操作,刷新 tableView/webView");
    // NSNotification 有三个属性，name, object, userInfo，其中最关键的object就是从第三个界面传来的数据。name就是通知事件的名字， userInfo一般是事件的信息。
    NSMutableDictionary *dataDic = [NSMutableDictionary new];
    dataDic = dic.object;
    
    //self.audioOrVideoUrl = [[NSString alloc]init];
    
    self.typeName = [dataDic valueForKey:@"typeName"];
    self.audioOrVideoUrl = [dataDic valueForKey:@"url"];
    self.webUrl = [dataDic valueForKey:@"webUrl"];
    self.VideoTitel = [dataDic valueForKey:@"VideoTitel"];
    self.tableViewCellRow = [dataDic valueForKey:@"tableViewCellRow"];
    
    if ([self.typeName isEqualToString:@"视频"]) {
        [self setStatusBarBackgroundColor:[UIColor blackColor]];
        
        //[[UIApplication sharedApplication] setStatusBarHidden:YES];//隐藏状态栏
        
        //视频横屏
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        appDelegate.allowRotation = YES;//不让横屏的时候 appDelegate.allowRotation = NO;即可
        
        self.typeName = self.watHomeClassListDetailModel.goods_type_name;
        
        self.navTitle = @"";
        self.navBarView.hidden = YES;
        self.isBackTitle = YES;
        self.navigationController.navigationBar.hidden = YES;
    }else if ([self.typeName isEqualToString:@"音频"]){
        self.isBackTitle = NO;
        self.navBarView.hidden = NO;
        self.navBarView.alpha = 0;
        self.navigationController.navigationBar.hidden = NO;
        
        [self.avTimer invalidate];
        self.avTimer = nil;
        [self addAudio];
        
    }
    
    [self.mainTableView reloadData];
    

}

- (void)WatVideoNotPlayPopControllerNotificationClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addAudio{
    [self addAudioPlay];
    [self.player play]; //一进来就播放
    
    //注册通知
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(dellocAuido) name:WatDeallocAudioControllerNotification object:nil];
    
    //添加播放结束监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.player.currentItem];
}
- (void)dellocAuido{
    NSLog(@"结束音频生命周期");
    [self.player pause];
    self.player = nil;
}
- (void) playbackFinished:(AVPlayer *)player{
    [WATHud showMessage:@"音频播放结束"];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)addAudioPlay {
    if (ValidStr(self.audioOrVideoUrl)) {
        _player = [[AVPlayer alloc]initWithURL:[NSURL URLWithString:self.audioOrVideoUrl]];
    }else{
        _player = [[AVPlayer alloc]initWithURL:[NSURL URLWithString:self.watHomeClassListDetailModel.audio_path]];
    }
    self.avTimer = [NSTimer pltScheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timer) userInfo:nil];
    
    
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
//    NSLog(@" =============  %lf",CMTimeGetSeconds(self.player.currentItem.duration));
//    NSLog(@" +++++++++++++  %lf",CMTimeGetSeconds(self.player.currentItem.currentTime));
    if (CMTimeGetSeconds(self.player.currentItem.currentTime) >= 3600) {
        self.currentTimeLab.text = [[ZWHHelper sharedHelper]getMMSSFromSS:[NSString stringWithFormat:@"%lf",CMTimeGetSeconds(self.player.currentItem.currentTime)]];
    }else{
        self.currentTimeLab.text = [[ZWHHelper sharedHelper]getSectionMMSSFromSS:[NSString stringWithFormat:@"%lf",CMTimeGetSeconds(self.player.currentItem.currentTime)]];
    }
    if (CMTimeGetSeconds(self.player.currentItem.currentTime) >= 3600) {
        self.durationLab.text = [[ZWHHelper sharedHelper]getMMSSFromSS:[NSString stringWithFormat:@"%lf",CMTimeGetSeconds(self.player.currentItem.duration) - CMTimeGetSeconds(self.player.currentItem.currentTime)]];
    }else{
        self.durationLab.text = [[ZWHHelper sharedHelper]getSectionMMSSFromSS:[NSString stringWithFormat:@"%lf",CMTimeGetSeconds(self.player.currentItem.duration) - CMTimeGetSeconds(self.player.currentItem.currentTime)]];
    }
    if (CMTimeGetSeconds(self.player.currentItem.currentTime) < 1) {
        [WATHud showLoading:@"音频加载中..."];
    }else if (CMTimeGetSeconds(self.player.currentItem.currentTime) >= 1 && CMTimeGetSeconds(self.player.currentItem.currentTime) <= 1.5 ){
        [WATHud dismiss];
        NSLog(@"%lf",CMTimeGetSeconds(self.player.currentItem.currentTime));
        //后台播放控制
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        //设置歌曲题目
        [dict setObject:self.list[self.tableViewCellRow.integerValue].title forKey:MPMediaItemPropertyTitle];
        //设置歌手名
        [dict setObject:[NSString stringWithFormat:@"%@",self.list[self.tableViewCellRow.integerValue].author] forKey:MPMediaItemPropertyArtist];
        //设置专辑名
        [dict setObject:[NSString stringWithFormat:@"《%@》",self.list[self.tableViewCellRow.integerValue].zhuanji] forKey:MPMediaItemPropertyAlbumTitle];
        //设置显示的图片
        //UIImage *newImage = [UIImage imageNamed:@"headerPic00"];
        UIImageView *imgView = [[UIImageView alloc]init];
        [imgView sd_setImageWithURL:[NSURL URLWithString:self.watHomeClassListDetailModel.thumb]];
        [dict setObject:[[MPMediaItemArtwork alloc] initWithImage:imgView.image]
                 forKey:MPMediaItemPropertyArtwork];
        
        CGFloat finish_rate =  CMTimeGetSeconds(self.player.currentItem.duration);
        
        //设置歌曲时长
        [dict setObject:[NSNumber numberWithDouble:(int)finish_rate] forKey:MPMediaItemPropertyPlaybackDuration];
        //设置已经播放时长
        [dict setObject:[NSNumber numberWithDouble:1] forKey:MPNowPlayingInfoPropertyElapsedPlaybackTime];
        //更新字典
        [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:dict];
        
        // 3.让应用程序可以接受远程事件
        [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    }else{
        [WATHud dismiss];
    }
    
}



//设置状态栏颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        if ([self.typeName isEqualToString:@"音频"] || [self.typeName isEqualToString:@"视频"]) {
            return MyKScreenWidth * 0.5 + 30;
        }else{
            return MyTopHeight;
        }
        
    }else{
        return scr_hei-MyTopHeight;
    }
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
    
    if (indexPath.row == 0) {
        cell.backgroundColor = [UIColor yellowColor];
        if ([self.typeName isEqualToString:@"音频"]) {
            
            UIImageView *bgV= [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width * 0.5 + 30)];
            bgV.backgroundColor = CommonAppColor;
            NSURL *imageUrl = [NSURL URLWithString:self.watHomeClassListDetailModel.thumb];
            [bgV sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"pic00"]];
            [cell addSubview:bgV];
            
            UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0,CGRectGetWidth(bgV.frame), CGRectGetHeight(bgV.frame))];
            toolbar.barStyle = 2;
            [bgV addSubview:toolbar];
            
            CGFloat imageHeight = CGRectGetHeight(bgV.frame) - 90;
            //旋转 image
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, imageHeight, imageHeight)];
            if (KIsiPhoneX) {
                imageView.center = Center(MyKScreenWidth * 0.5, MyStatusBarHeight + imageHeight / 2 + 10);
            }else{
                imageView.center = Center(MyKScreenWidth * 0.5, MyStatusBarHeight + imageHeight / 2 + 20);
            }
            
            self.imageView = imageView;
            [imageView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"pic00"]];
            imageView.layer.cornerRadius = (imageHeight) * 0.5;
            imageView.contentMode = 2;
            imageView.clipsToBounds = YES;
            [self rotateView:imageView];
            [cell addSubview:imageView];
            //设置layer
            CALayer *layer=[imageView layer];
            //是否设置边框以及是否可见
            [layer setMasksToBounds:YES];
            //设置边框圆角的弧度
            //[layer setCornerRadius:10.0];
            //设置边框线的宽
            [layer setBorderWidth:2.5];
            //设置边框线的颜色
            [layer setBorderColor:[[UIColor whiteColor] CGColor]];
            
            //播放进度
            UILabel *currentTimeLab = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(bgV.frame) - 25, 40, 12)];
            self.currentTimeLab = currentTimeLab;
            self.currentTimeLab.textAlignment = NSTextAlignmentCenter;
            currentTimeLab.textColor = [UIColor grayColor];
            currentTimeLab.font = commenAppFont(12);
            currentTimeLab.adjustsFontSizeToFitWidth = YES;
            [bgV addSubview:currentTimeLab];
            
            UISlider *jinduSlider = [[UISlider alloc]initWithFrame:CGRectMake(CGRectGetMaxX(currentTimeLab.frame),CGRectGetMaxY(bgV.frame) - 25, MyKScreenWidth - 120, 12)];
            self.jinduSlider = jinduSlider;
            UIImage *image = [self OriginImage:[UIImage imageNamed:@"music_slider_circle"] scaleToSize:CGSizeMake(30, 30)];
            [jinduSlider setThumbImage:image forState:UIControlStateNormal];
            [jinduSlider addTarget:self action:@selector(changeProgress:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:jinduSlider];
            //07.minimumTrackTintColor : 小于滑块当前值滑块条的颜色，默认为蓝色
            jinduSlider.minimumTrackTintColor = CommonAppColor;
            //08.maximumTrackTintColor: 大于滑块当前值滑块条的颜色，默认为白色
            jinduSlider.maximumTrackTintColor = [UIColor whiteColor];
            
            //还剩多久
            UILabel *durationLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(jinduSlider.frame) + 10, CGRectGetMaxY(bgV.frame) - 25, 40, 12)];
            self.durationLab = durationLab;
            self.durationLab.textAlignment = NSTextAlignmentCenter;
            durationLab.textColor = [UIColor grayColor];
            durationLab.font = commenAppFont(12);
            durationLab.adjustsFontSizeToFitWidth = YES;
            [bgV addSubview:durationLab];
            
            UIButton *zantingBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 5, 40, 40)];
            zantingBtn.center = imageView.center;
            self.zantingBtn = zantingBtn;
            zantingBtn.imageView.contentMode = 0;
            [zantingBtn setImage:[UIImage imageNamed:@"big_pause_button"] forState:UIControlStateNormal];
            [zantingBtn setImage:[UIImage imageNamed:@"big_play_button"] forState:UIControlStateSelected];
            [zantingBtn setSelected:_selected];
            [cell addSubview:zantingBtn];
            [zantingBtn addTarget:self action:@selector(zantingClick) forControlEvents:UIControlEventTouchUpInside];
            
        }else if ([self.typeName isEqualToString:@"视频"]){
            myPlayer = [[XjAVPlayerSDK alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width * 0.5 + 30)];
            
            if (self.audioOrVideoUrl && self.audioOrVideoUrl.length != 0) {
                myPlayer.xjPlayerUrl = self.audioOrVideoUrl;//点击父列表进来的列表
            }else{
                myPlayer.xjPlayerUrl = self.watHomeClassListDetailModel.video_path;//点击父列表进来的列表
            }
            
            if (self.VideoTitel && self.VideoTitel.length != 0) {
                myPlayer.xjPlayerTitle = self.VideoTitel;
            }else{
                myPlayer.xjPlayerTitle = self.watHomeClassListDetailModel.title;
            }
            
            myPlayer.xjAutoOrient = YES;
            myPlayer.XjAVPlayerSDKDelegate = self;
            
            myPlayer.xjLastTime = self.watHomeClassListDetailModel.learning_time.floatValue;
            
            [cell addSubview:myPlayer];
        }
    }else{
        /* 添加pageView
         * 这里可以任意替换你喜欢的pageView
         *作者这里使用一款github较多人使用的 WMPageController 地址https://github.com/wangmchn/WMPageController
         */
        [cell.contentView addSubview:self.setPageViewControllers];
    }
    return cell;
    
}
- (void)xjGoBack{
    
    [myPlayer xjStopPlayer];//关闭播放器
    // WatHomeClass01ViewController *vc = [WatHomeClass01ViewController new];
    //[self.navigationController popViewControllerAnimated:YES];
    if ([WatUserInfoManager isLoginUserID]) {
        CGFloat playTimes = myPlayer.xjCurrentTime; //播放时长.wh 修改了SDk类里面的方法
        
        NSString *learnTimeStr = [NSString stringWithFormat:@"%lf",playTimes];
        CGFloat finish_rate = myPlayer.xjCurrentTime / myPlayer.xjTotalTime;
        NSString *finish_rateStr = [NSString stringWithFormat:@"%lf",finish_rate];
        NSMutableDictionary *paramDic = [NSMutableDictionary new];
        
        [paramDic setValue:learnTimeStr forKey:@"learning_time"];
        [paramDic setValue:finish_rateStr forKey:@"finish_rate"];
        [paramDic setValue:self.watHomeClassListDetailModel.id forKey:@"id"];
        
        [Request POST:kApiEducationWriteHistory parameters:paramDic success:^(id responseObject) {
            
            
            
        } failure:^(NSError *error) {
            
        }];
    }
    //   //跳转到指定控制器
    //    UIViewController *controller = self.navigationController.viewControllers[1];
    //    [self.navigationController popToViewController:controller animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
    
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
    if (self.webUrl.length != 0) {
        oneVc.URLStr = self.webUrl;
    }else{
        oneVc.URLStr = self.watHomeClassListDetailModel.url;
    }
    
    oneVc.delegate = self;
    
    VideoTwoViewController * twoVc  = [VideoTwoViewController new];
    twoVc.delegate = self;
    twoVc.list = self.list;
    twoVc.is_buy = self.is_buy;
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



- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if ([self.typeName isEqualToString:@"音频"]) {
        CGFloat height;
        if (KIsiPhoneX) {
            height = 50;
        }else{
            height = 60;
        }
        CGFloat offset = scrollView.contentOffset.y;
        //NSLog(@"滚动偏移量+++++++%lf  ++++++%lf",offset,MyTopHeight);
        //导航栏透明度
        if (offset <= height) {
            
            CGFloat alpha =offset / height;
            self.navBarView.alpha = alpha;
            
            if (self.navBarView.alpha > 0.3) {
                self.navTitle = @"课程";
            }else{
                self.navTitle = @"";
            }
            
        }
        
        //滚动逻辑
        
        //main tv目前处于未置顶状态 并且 可以滚动
        if (offset <  - MyTopHeight && _mainScroll) {
            
            //main tv滚动起始位置处于置顶和0点之间 并且 sub tv不是置顶状态
            if (star_y < 0 && star_y > 100 &&
                self.parentScrollView.contentOffset.y>0) {
                
                //一起滚动
                
            }else{
                
                //sub tv是置顶状态或者0点位置 限制sub滚动
                
                self.parentScrollView.contentOffset = CGPointMake(0, 100);
            }
        }else{
            //main tv滑动到顶 sub tv正在向下滑动
            //scrollView.contentOffset = CGPointMake(0, 0);
        }
        
        //main tv目前处于置顶状态 并且 可以滚动
        if (offset >= -MyTopHeight && _mainScroll) {
            
            //禁止滚动 固定位置
            _mainScroll = NO;
            //scrollView.contentOffset = CGPointMake(0, 0);
        }
    }else if ([self.typeName isEqualToString:@"视频"]){
        CGFloat offset = scrollView.contentOffset.y;
        //NSLog(@"滚动偏移量+++++++%lf  ++++++%lf",offset,star_y);
        
        //滚动逻辑
        
        //main tv目前处于未置顶状态 并且 可以滚动
        if (offset <  - MyTopHeight && _mainScroll) {
            
            //main tv滚动起始位置处于置顶和0点之间 并且 sub tv不是置顶状态
            if (star_y < - MyTopHeight && star_y > -227 + 100 &&
                self.parentScrollView.contentOffset.y>0) {
                
                //一起滚动
                
            }else{
                
                //sub tv是置顶状态或者0点位置 限制sub滚动
                
                self.parentScrollView.contentOffset = CGPointMake(0, 100);
            }
        }else{
            //main tv滑动到顶 sub tv正在向下滑动
            scrollView.contentOffset = CGPointMake(0, 0);
        }
        
        //main tv目前处于置顶状态 并且 可以滚动
        if (offset >= -MyTopHeight && _mainScroll) {
            
            //禁止滚动 固定位置
            //_mainScroll = NO;
            scrollView.contentOffset = CGPointMake(0, 0);
        }
    }else if ([self.typeName isEqualToString:@"图文"] || [self.typeName isEqualToString:@"专栏"]){
        CGFloat height;
        if (KIsiPhoneX) {
            height = 50;
        }else{
            height = 60;
        }
        CGFloat offset = scrollView.contentOffset.y;
        //NSLog(@"滚动偏移量+++++++%lf  ++++++%lf",offset,MyTopHeight);
        //导航栏透明度
        if (offset <= height) {
            
            CGFloat alpha =offset / height;
            self.navBarView.alpha = alpha;
            
            if (self.navBarView.alpha > 0.3) {
                self.navTitle = @"课程";
            }else{
                self.navTitle = @"";
            }
            
        }
        
        //滚动逻辑
        
        //main tv目前处于未置顶状态 并且 可以滚动
        if (offset <  - MyTopHeight && _mainScroll) {
            
            //main tv滚动起始位置处于置顶和0点之间 并且 sub tv不是置顶状态
            if (star_y < 0 && star_y > 100 &&
                self.parentScrollView.contentOffset.y>0) {
                
                //一起滚动
                
            }else{
                
                //sub tv是置顶状态或者0点位置 限制sub滚动
                
                self.parentScrollView.contentOffset = CGPointMake(0, 100);
            }
        }else{
            //main tv滑动到顶 sub tv正在向下滑动
            //scrollView.contentOffset = CGPointMake(0, 0);
        }
        
        //main tv目前处于置顶状态 并且 可以滚动
        if (offset >= -MyTopHeight && _mainScroll) {
            
            //禁止滚动 固定位置
            _mainScroll = NO;
            //scrollView.contentOffset = CGPointMake(0, 0);
        }
    }else if ([self.typeName isEqualToString:@"视频"]){
        CGFloat offset = scrollView.contentOffset.y;
        //NSLog(@"滚动偏移量+++++++%lf  ++++++%lf",offset,star_y);
        
        //滚动逻辑
        
        //main tv目前处于未置顶状态 并且 可以滚动
        if (offset <  - MyTopHeight && _mainScroll) {
            
            //main tv滚动起始位置处于置顶和0点之间 并且 sub tv不是置顶状态
            if (star_y < - MyTopHeight && star_y > -227 + 100 &&
                self.parentScrollView.contentOffset.y>0) {
                
                //一起滚动
                
            }else{
                
                //sub tv是置顶状态或者0点位置 限制sub滚动
                
                self.parentScrollView.contentOffset = CGPointMake(0, 100);
            }
        }else{
            //main tv滑动到顶 sub tv正在向下滑动
            scrollView.contentOffset = CGPointMake(0, 0);
        }
        
        //main tv目前处于置顶状态 并且 可以滚动
        if (offset >= -MyTopHeight && _mainScroll) {
            
            //禁止滚动 固定位置
            //_mainScroll = NO;
            scrollView.contentOffset = CGPointMake(0, 0);
        }
    }
}

- (void)backAction{
    //返回按钮,直接停掉, 只有侧滑才可以继续听.
    
    if ([WatUserInfoManager isLoginUserID]) {
        if ([self.typeName isEqualToString:@"音频"]) {
            
            NSString *learnTimeStr = [NSString stringWithFormat:@"%lf",CMTimeGetSeconds(self.player.currentItem.currentTime)];
            CGFloat finish_rate = CMTimeGetSeconds(self.player.currentItem.currentTime) / CMTimeGetSeconds(self.player.currentItem.duration);
            NSString *finish_rateStr = [NSString stringWithFormat:@"%lf",finish_rate];
            NSMutableDictionary *paramDic = [NSMutableDictionary new];
            
            [paramDic setValue:learnTimeStr forKey:@"learning_time"];
            [paramDic setValue:finish_rateStr forKey:@"finish_rate"];
            [paramDic setValue:self.watHomeClassListDetailModel.id forKey:@"id"];
            
            [Request POST:kApiEducationWriteHistory parameters:paramDic success:^(id responseObject) {
                
                
                
            } failure:^(NSError *error) {
                
            }];
        }
    }
    [self.player pause];
    self.player = nil;
    UIViewController *controller = self.navigationController.viewControllers[1];
    [self.navigationController popToViewController:controller animated:YES];
    
}
/** 监听远程事件 */
-(void)remoteControlReceivedWithEvent:(UIEvent *)event
{
    switch (event.subtype) {
        case UIEventSubtypeRemoteControlPlay: // 播放
            NSLog(@"播放按钮");
            [self.player play];
            [self resumeAnimation];
        
        
            break;
        case UIEventSubtypeRemoteControlPause: // 暂停
            NSLog(@"暂停"); // 控制播放与暂停
            [self.player pause];
            [self pauseAnimation];
            break;
        case UIEventSubtypeRemoteControlNextTrack: // 下一首
            NSLog(@"下一首"); // 控制播放下一首
            if (self.tableViewCellRow.integerValue < self.list.count - 1) {
                self.audioOrVideoUrl = self.list[self.tableViewCellRow.integerValue + 1].audio_path;
                self.webUrl = self.list[self.tableViewCellRow.integerValue + 1].url;
                self.tableViewCellRow = [NSString stringWithFormat:@"%ld",self.tableViewCellRow.integerValue + 1];
                
                [self.avTimer invalidate];
                self.avTimer = nil;
                [self addAudio];
                [self.mainTableView reloadData];
            }
            
            break;
        case UIEventSubtypeRemoteControlPreviousTrack: // 上一首
             NSLog(@"上一首"); // 控制播放上一首
            if (self.tableViewCellRow.integerValue > 0) {
                self.audioOrVideoUrl = self.list[self.tableViewCellRow.integerValue - 1].audio_path;
                self.webUrl = self.list[self.tableViewCellRow.integerValue - 1].url;
                self.tableViewCellRow = [NSString stringWithFormat:@"%ld",self.tableViewCellRow.integerValue - 1];
                
                [self.avTimer invalidate];
                self.avTimer = nil;
                [self addAudio];
                [self.mainTableView reloadData];
            }
            
            break;
        default:
            break;
            //        // available in iPhone OS 3.0
            //        UIEventSubtypeNone                              = 0,
            //        // for UIEventTypeMotion, available in iPhone OS 3.0
            //        UIEventSubtypeMotionShake                       = 1,
            //        //这之后的是我们需要关注的枚举信息
            //        // for UIEventTypeRemoteControl, available in iOS 4.0
            //        //点击播放按钮或者耳机线控中间那个按钮
            //        UIEventSubtypeRemoteControlPlay                 = 100,
            //        //点击暂停按钮
            //        UIEventSubtypeRemoteControlPause                = 101,
            //        //点击停止按钮
            //        UIEventSubtypeRemoteControlStop                 = 102,
            //        //点击播放与暂停开关按钮(iphone抽屉中使用这个)
            //        UIEventSubtypeRemoteControlTogglePlayPause      = 103,
            //        //点击下一曲按钮或者耳机中间按钮两下
            //        UIEventSubtypeRemoteControlNextTrack            = 104,
            //        //点击上一曲按钮或者耳机中间按钮三下
            //        UIEventSubtypeRemoteControlPreviousTrack        = 105,
            //        //快退开始 点击耳机中间按钮三下不放开
            //        UIEventSubtypeRemoteControlBeginSeekingBackward = 106,
            //        //快退结束 耳机快退控制松开后
            //        UIEventSubtypeRemoteControlEndSeekingBackward   = 107,
            //        //开始快进 耳机中间按钮两下不放开
            //        UIEventSubtypeRemoteControlBeginSeekingForward  = 108,
            //        //快进结束 耳机快进操作松开后
            //        UIEventSubtypeRemoteControlEndSeekingForward    = 109,
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];//移除通知
    [self.avTimer invalidate];
    self.avTimer = nil;
    //NSLog(@"%@ dealloc", self);
}


@end
