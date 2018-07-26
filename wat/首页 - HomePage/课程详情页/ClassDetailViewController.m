//
//  ClassDetailViewController.m
//  wat
//
//  Created by 123 on 2018/6/7.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "ClassDetailViewController.h"
#import <WebKit/WebKit.h> //WKWebView 需要导入的头文件

#import "ByClassViewController.h"
#import "ByClassJianyiViewController.h"
#import "WatHomeClass01Model.h"

@interface ClassDetailViewController ()<WKScriptMessageHandler,WKNavigationDelegate,WKUIDelegate>
@property (nonatomic, strong)WKWebView *webView;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) WatHomeClass01Model *watHomeClass01Model;
@property (nonatomic, strong) WatHomeClassGoodsModel *watHomeClassGoodsModel;
//------------------ 分享
@property (nonatomic, strong) NSString *share_url;
@property (nonatomic, strong) NSString *share_title;
@property (nonatomic, strong) NSString *share_sunTitle;
@property (nonatomic, strong) UIImageView *share_imgView;

@end

@implementation ClassDetailViewController
- (WatHomeClassGoodsModel *)watHomeClassGoodsModel{
    if (!_watHomeClassGoodsModel) {
        _watHomeClassGoodsModel = [WatHomeClassGoodsModel new];
    }
    return _watHomeClassGoodsModel;
}
- (WatHomeClass01Model *)watHomeClass01Model{
    if (!_watHomeClass01Model) {
        _watHomeClass01Model = [WatHomeClass01Model new];
    }
    return _watHomeClass01Model;
}

- (WKWebView *)webView{
    if (!_webView) {
        _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, MyTopHeight, MyKScreenWidth, MyKScreenHeight - MyTopHeight - MyTabBarHeight)] ;
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
    }
    return _webView;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
//    if (self.ios_mark_id) {
//        [self setAFN];
//    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.rightTitles = @[@"分享"];
    
    self.share_imgView = [UIImageView new];
    
    if (ValidStr(self.watHomeWillBeginClassModel.price)) {
        self.price = self.watHomeWillBeginClassModel.price;
        self.sale_num = self.watHomeWillBeginClassModel.sale_num;
    }else if (ValidStr(self.orderDetailModel.price)){
        self.price = self.orderDetailModel.price;
        self.sale_num = self.orderDetailModel.sale_num;
    }
    [self MKWebViewre];
    [self addBuyBtn];
    if (ValidStr(self.ios_mark_id)) {
        [self setAFN];
    }else{
        self.share_url = self.watHomeWillBeginClassModel.share_url;
        self.share_title = self.watHomeWillBeginClassModel.title;
        self.share_sunTitle = self.watHomeWillBeginClassModel.subTitle;
        [self.share_imgView sd_setImageWithURL:self.watHomeWillBeginClassModel.thumb_path placeholderImage:[UIImage imageNamed:@"pic00"]];
    }
    
    
    
    //进度条初始化
    self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, MyTopHeight, [[UIScreen mainScreen] bounds].size.width, 2)];
    self.progressView.progressTintColor=[UIColor grayColor];
    self.progressView.trackTintColor=[UIColor clearColor];
    //设置进度条的高度，下面这句代码表示进度条的宽度变为原来的1倍，高度变为原来的1.5倍.
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 0.8f);
    [self.view addSubview:self.progressView];
    //3.添加KVO，WKWebView有一个属性estimatedProgress，就是当前网页加载的进度，所以监听这个属性。
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
}
- (void) setAFN{
    NSMutableDictionary *paramDic = [NSMutableDictionary new];
    [paramDic setObject:self.ios_mark_id forKey:@"id"];
    [WatHomeClass01Model asyncPostkApiEducationDetailSuccessBlock:^(WatHomeClass01Model *watHomeClass01Model) {
        self.watHomeClass01Model = watHomeClass01Model;
        self.is_sale = watHomeClass01Model.is_buy.intValue;
        self.watHomeClassGoodsModel = watHomeClass01Model.goods;
        self.urlStr = self.watHomeClassGoodsModel.conetent_url;
        self.sale_num = self.watHomeClassGoodsModel.sale_num;
        self.price = self.watHomeClassGoodsModel.price;
        
        self.share_url = self.watHomeClassGoodsModel.share_url;
        self.share_title = self.watHomeClassGoodsModel.title;
        self.share_sunTitle = self.watHomeClassGoodsModel.subTitle;
        [self.share_imgView sd_setImageWithURL:[NSURL URLWithString:self.watHomeClassGoodsModel.thumb] placeholderImage:[UIImage imageNamed:self.watHomeClassGoodsModel.thumb]];
        if (ValidStr(self.ios_mark_id)) {
            [self MKWebViewre];
            [self addBuyBtn];
            
        }
        
    } errorBlock:^(NSError *errorResult) {
        
    } paramDic:paramDic urlStr:kApiEducationDetail];
    
}

- (void)addBuyBtn {
    NSString *yigouNumStr = [NSString stringWithFormat:@"已有%@人购买",self.sale_num];
    
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
    NSString *goumaiBtnTitleStr;
    
    if (self.orderDetailModel.online_end.intValue <= 0 && self.orderDetailModel.online_end) {
        goumaiBtnTitleStr = @"活动已结束";
        buyBtn.userInteractionEnabled = NO;
    }else if (self.watHomeClassGoodsModel.online_end.intValue <= 0 && self.watHomeClassGoodsModel.online_end){
        goumaiBtnTitleStr = @"活动已结束";
        buyBtn.userInteractionEnabled = NO;
    }else if (self.watHomeWillBeginClassModel.online_end.intValue <= 0 && self.watHomeWillBeginClassModel.online_end){
        goumaiBtnTitleStr = @"活动已结束";
        buyBtn.userInteractionEnabled = NO;
    }else{
        if (self.is_sale) {
            goumaiBtnTitleStr = [NSString stringWithFormat:@"再次购买:%@元",self.price];
        }else{
            goumaiBtnTitleStr = [NSString stringWithFormat:@"立即购买:%@元",self.price];
        }
    }
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
- (void)MKWebViewre {
    //CGFloat phoneVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    //    if (phoneVersion >= 10.0) {
    //        content = [content stringByReplacingOccurrencesOfString:@"<video" withString:@"<video playsinline"];
    //    }else {
    //        content = [content stringByReplacingOccurrencesOfString:@"<video" withString:@"<video webkit-playsinline"];
    //    }
    
    // 2.创建URL
    self.webView.backgroundColor = WatBackColor;
    // 3.创建Request
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]];
    // 4.加载网页
    [self.webView loadRequest:request];
    // 5.最后将webView添加到界面
    [self.view addSubview:self.webView];
    //self.webView.allowsInlineMediaPlayback = YES;
    
}

//4.在监听方法中获取网页加载的进度，并将进度赋给progressView.progress
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progressView.progress = self.webView.estimatedProgress;
        if (self.progressView.progress == 1) {
            /*
             *添加一个简单的动画，将progressView的Height变为1.4倍，在开始加载网页的代理中会恢复为1.5倍
             *动画时长0.25s，延时0.3s后开始动画
             *动画结束后将progressView隐藏
             */
            __weak typeof (self)weakSelf = self;
            [UIView animateWithDuration:0.25f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                weakSelf.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.4f);
            } completion:^(BOOL finished) {
                weakSelf.progressView.hidden = YES;
                
            }];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
//5.在WKWebViewd的代理中展示进度条，加载完成后隐藏进度条
//开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"开始加载网页");
    //开始加载网页时展示出progressView
    self.progressView.hidden = NO;
    //开始加载网页的时候将progressView的Height恢复为1.5倍
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 0.8f);
    //防止progressView被网页挡住
    [self.view bringSubviewToFront:self.progressView];
}

//加载完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"加载完成");
    //加载完成后隐藏progressView
    //self.progressView.hidden = YES;
}

//加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"加载失败");
    //加载失败同样需要隐藏progressView
    //self.progressView.hidden = YES;
}
//6.在dealloc中取消监听
- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}


- (void)buyBtnClick{
    
    
   
        if ([WatUserInfoManager isLoginUserID]) {
            ByClassJianyiViewController *byVc = [ByClassJianyiViewController new];
            byVc.navTitle = @"确认订单";
            byVc.orderDetailModel =  self.orderDetailModel;
            byVc.watHomeWillBeginClassModel = self.watHomeWillBeginClassModel;
            byVc.watHomeClassGoodsModel = self.watHomeClassGoodsModel;
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

- (void)rightBtnsAction:(UIButton *)button{
    DXShareView *shareView = [[DXShareView alloc] init];
    DXShareModel *shareModel = [[DXShareModel alloc] init];
    shareModel.title = self.share_title;
    shareModel.descr = self.share_sunTitle;
    shareModel.url = [NSString stringWithFormat:@"%@",self.share_url];
    //UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.share_img]]];
    shareModel.thumbImage = self.share_imgView.image;
    [shareView showShareViewWithDXShareModel:shareModel shareContentType:DXShareContentTypeLink];
    
}

@end
