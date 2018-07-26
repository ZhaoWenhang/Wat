//
//  BookDetailViewController.m
//  wat
//
//  Created by 123 on 2018/6/11.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "BookDetailViewController.h"
#import "ByClassViewController.h"
#import "FLCountDownView.h"//限时抢购倒计时
#import "ByClassJianyiViewController.h"

#define headerViewHeight 300
@interface BookDetailViewController ()<UIWebViewDelegate,UIGestureRecognizerDelegate>
@property (nonatomic, strong)UIWebView *classWebView;
@end

@implementation BookDetailViewController
- (UIWebView *)classWebView
{
    if (!_classWebView) {
        _classWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, MyTopHeight, MyKScreenWidth, MyKScreenHeight - MyTopHeight - 55)];
        _classWebView.delegate = self;
    }
    return  _classWebView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = WatBackColor;
    self.rightTitles = @[@"分享"];
    [self webViewre];
    [self addBuyBtn];
}


- (void)webViewre {
    //CGFloat phoneVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    //    if (phoneVersion >= 10.0) {
    //        content = [content stringByReplacingOccurrencesOfString:@"<video" withString:@"<video playsinline"];
    //    }else {
    //        content = [content stringByReplacingOccurrencesOfString:@"<video" withString:@"<video webkit-playsinline"];
    //    }
    
    
    
    // 1.创建webview，并设置大小，"20"为状态栏高度
    UIWebView *classWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, MyTopHeight, MyKScreenWidth, MyKScreenHeight - MyTopHeight - 44)];
    // 2.创建URL
    classWebView.backgroundColor = WatBackColor;
    [classWebView setBackgroundColor:[UIColor clearColor]];
    [classWebView setOpaque:NO];
    classWebView.scrollView.backgroundColor = [UIColor whiteColor];
    //classWebView.scrollView.contentInset = UIEdgeInsetsMake(headerViewHeight, 0, 0, 0);
    NSURL *url = [NSURL URLWithString:self.urlStr];
    // 3.创建Request
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    // 4.加载网页
    [classWebView loadRequest:request];
    // 5.最后将webView添加到界面
    [self.view addSubview:classWebView];
    self.classWebView = classWebView;
    classWebView.allowsInlineMediaPlayback = YES;
    
   // [self addHeaderView];
    
    if (@available(iOS 11.0, *)) {
        self.classWebView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}
//webView.scrollView.header
-(void)addHeaderView {
    UIImageView *headerImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, -headerViewHeight, MyKScreenWidth, 240)];
    headerImgView.image = [UIImage imageNamed:@"1234567893"];
    headerImgView.backgroundColor = [UIColor whiteColor];
    headerImgView.contentMode = 2;
    [self.classWebView.scrollView addSubview:headerImgView];
    
    UIView *titleBGView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(headerImgView.frame) - 60, CGRectGetWidth(headerImgView.frame), 60)];
    titleBGView.backgroundColor = [UIColor blackColor];
    titleBGView.alpha = 0.6;
    [headerImgView addSubview:titleBGView];
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 8, MyKScreenWidth - 30, 22)];
    titleLab.font = commenAppFont(22);
    titleLab.textColor = [UIColor whiteColor];
    titleLab.text = @"王牌店长特训营王牌店长特训营王牌店长特训营王牌店长特训营王牌店长特训营王牌店长特训营王牌店长特训营王牌店长特训营";
    titleLab.textAlignment = NSTextAlignmentLeft;
    titleLab.numberOfLines = 1;
    //[titleLab sizeToFit];
    [titleBGView addSubview:titleLab];

    UILabel *subTitleLab = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetHeight(titleLab.frame) + 16, MyKScreenWidth - 30, 15)];
    subTitleLab.font = commenAppFont(15);
    subTitleLab.alpha = 0.8;
    subTitleLab.textColor = [UIColor whiteColor];
    subTitleLab.text = @"稳中促业绩,轻松管员工,舒心做店长";
    subTitleLab.textAlignment = NSTextAlignmentLeft;
    subTitleLab.numberOfLines = 1;
    //[subTitleLab sizeToFit];
    [titleBGView addSubview:subTitleLab];
    
    UILabel *timeLab = [[UILabel alloc]initWithFrame:CGRectMake(15, headerImgView.frame.size.height + headerImgView.frame.origin.y + 10, 200, 1)];
    timeLab.font = commenAppFont(14);
    timeLab.textColor = [UIColor grayColor];
    timeLab.text = @"时间:6月7日-6月8日";
    timeLab.textAlignment = NSTextAlignmentLeft;
    timeLab.numberOfLines = 1;
    [timeLab sizeToFit];
    [self.classWebView.scrollView addSubview:timeLab];
    
    UILabel *addressLab = [[UILabel alloc]initWithFrame:CGRectMake(MyKScreenWidth - 200 - 15, timeLab.frame.origin.y, 200, 14)];
    addressLab.font = commenAppFont(14);
    addressLab.textColor = [UIColor grayColor];
    addressLab.text = @"地点:北京";
    addressLab.textAlignment = NSTextAlignmentRight;
    addressLab.numberOfLines = 1;
    //[addressLab sizeToFit];
    [self.classWebView.scrollView addSubview:addressLab];
    
    UILabel *daojishiLab = [[UILabel alloc]initWithFrame:CGRectMake(15, timeLab.frame.size.height + timeLab.frame.origin.y + 5, 200, 1)];
    daojishiLab.font = commenAppFont(14);
    daojishiLab.textColor = CommonAppColor;
    daojishiLab.text = @"距离开课还剩:";
    daojishiLab.textAlignment = NSTextAlignmentLeft;
    daojishiLab.numberOfLines = 1;
    [daojishiLab sizeToFit];
    [self.classWebView.scrollView addSubview:daojishiLab];
    
    //限时抢购 倒计时
    FLCountDownView *countDown      = [FLCountDownView fl_countDown];
    countDown.frame                 = CGRectMake(daojishiLab.frame.size.width + daojishiLab.frame.origin.x + 7, timeLab.frame.size.height + timeLab.frame.origin.y + 4, 100, 20);
    countDown.timestamp             = 864000;
    countDown.backgroundImageName   = @"search_k";
    countDown.timerStopBlock        = ^{
        NSLog(@"时间停止");
    };
    [self.classWebView.scrollView addSubview:countDown];
    
//    UILabel *buyNumLab = [[UILabel alloc]initWithFrame:CGRectMake(MyKScreenWidth - 115, daojishiLab.frame.origin.y, 100, 1)];
//    buyNumLab.font = commenAppFont(14);
//    buyNumLab.textColor = [UIColor grayColor];
//    buyNumLab.text = @"已有3000人次购买";
//    buyNumLab.textAlignment = NSTextAlignmentRight;
//    buyNumLab.numberOfLines = 1;
//    [buyNumLab sizeToFit];
//    buyNumLab.frame = CGRectMake(MyKScreenWidth - buyNumLab.frame.size.width - 15, daojishiLab.frame.origin.y, buyNumLab.frame.size.width, buyNumLab.frame.size.height);
//    [self.classWebView.scrollView addSubview:buyNumLab];
    
}
- (void)addBuyBtn {
    NSString *yigouNumStr = [NSString stringWithFormat:@"已有%@人购买",self.watHomeHotDetailsModel.sale_num];
    NSString *goumaiBtnTitleStr = [NSString stringWithFormat:@"立即购买:%@元",self.watHomeHotDetailsModel.price];
    
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, MyKScreenHeight - MyTabBarHeight, MyKScreenWidth, MyTabBarHeight)];
    v.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:v];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0.5, MyKScreenWidth, 0.5)];
    lineView.backgroundColor = [UIColor grayColor];
    [v addSubview:lineView];
    
    UILabel *yigouNumLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 4.5, 200, 40)];
    yigouNumLab.text = yigouNumStr;
    yigouNumLab.font = commenAppFont(14);
    yigouNumLab.textColor = [UIColor darkGrayColor];
    [v addSubview:yigouNumLab];
    
    UIButton *buyBtn = [[UIButton alloc]initWithFrame:CGRectMake(MyKScreenWidth - MyKScreenWidth * 0.33 - 20, 9, MyKScreenWidth * 0.33, 30)];
    [buyBtn setTitle:goumaiBtnTitleStr forState:UIControlStateNormal];
    buyBtn.titleLabel.font = biaotiAppFont(14);
    [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buyBtn.backgroundColor = CommonAppColor;
    buyBtn.layer.cornerRadius = 4.0;
    buyBtn.clipsToBounds = YES;
    buyBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [buyBtn addTarget:self action:@selector(buyBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [v addSubview:buyBtn];
    
    
    
}


- (void)buyBtnClick{
//    ByClassViewController *byVc = [ByClassViewController new];
//    byVc.navTitle = @"确认订单";
//    [self.navigationController pushViewController:byVc animated:YES];
   
    if ([WatUserInfoManager isLogin]) {
        ByClassJianyiViewController *byVc = [ByClassJianyiViewController new];
        byVc.navTitle = @"确认订单";
        byVc.watHomeHotDetailsModel = self.watHomeHotDetailsModel;
        [self.navigationController pushViewController:byVc animated:YES];
    }else{
        [[ZWHHelper sharedHelper]addAlertViewControllerToView:self withClickBlock:^(int clickInt) {
            if (clickInt == 1) {
                WatLoginViewController *loginVC = [WatLoginViewController new];
                [self.navigationController pushViewController:loginVC animated:YES];
            }
        } title:@"提示" content:@"登陆后才可以购买哦~" cancleStr:@"取消" confirmStr:@"登陆"];
        
    }
}
-(void)rightBtnsAction:(UIButton *)button{
    DXShareView *shareView = [[DXShareView alloc] init];
    DXShareModel *shareModel = [[DXShareModel alloc] init];
    shareModel.title = self.watHomeHotDetailsModel.title;
    shareModel.descr = self.watHomeHotDetailsModel.subTitle;
    shareModel.url = [NSString stringWithFormat:@"%@",self.watHomeHotDetailsModel.share_url];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.watHomeHotDetailsModel.thumb_path]]];
    shareModel.thumbImage = image;
    [shareView showShareViewWithDXShareModel:shareModel shareContentType:DXShareContentTypeLink];
}
@end
