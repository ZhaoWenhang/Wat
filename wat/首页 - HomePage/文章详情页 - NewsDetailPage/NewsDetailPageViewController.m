//
//  NewsDetailPageViewController.m
//  wat
//
//  Created by 123 on 2018/5/25.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "NewsDetailPageViewController.h"
#import <WebKit/WebKit.h> //WKWebView 需要导入的头文件
#import "WatNewsDetailModel.h"
@interface NewsDetailPageViewController ()<WKScriptMessageHandler,WKNavigationDelegate,WKUIDelegate>
@property (nonatomic, strong)WKWebView *webView;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) watNewsDetailModel *watNewsDetail;
@end

@implementation NewsDetailPageViewController
-(watNewsDetailModel *)watNewsDetail{
    if (!_watNewsDetail) {
        _watNewsDetail = [watNewsDetailModel new];
    }
    return _watNewsDetail;
}
- (WatHomeNewsDetailsModel *)watHomeNewsDetailsModel{
    if (!_watHomeNewsDetailsModel) {
        _watHomeNewsDetailsModel = [WatHomeNewsDetailsModel new];
    }
    return _watHomeNewsDetailsModel;
}

- (WKWebView *)webView{
    if (!_webView) {
        _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, MyTopHeight, MyKScreenWidth, MyKScreenHeight - MyTopHeight)] ;
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
    }
    return _webView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([self.navTitle isEqualToString:@"蝌蚪餐服"] || [self.navTitle isEqualToString:@"海螺餐创"]) {
        
    }else{
        self.rightTitles = @[@"分享"];
    }
    
    
    [self MKWebViewre];
    if (self.ios_mark_id) {
        [self setAFN];
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
    //kApiArticleDetail
    NSMutableDictionary *paramDic = [NSMutableDictionary new];
    [paramDic setObject:self.ios_mark_id forKey:@"id"];
    __weak typeof (self)weakSelf = self;
    [watNewsDetailModel asyncPostkApiArticleDetailSuccessBlock:^(watNewsDetailModel *watNewsDetail) {
        weakSelf.watNewsDetail = watNewsDetail;
    } errorBlock:^(NSError *errorResult) {
        
    } paramDic:paramDic urlStr:kApiArticleDetail];
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
    NSURLRequest *request =[NSURLRequest requestWithURL:self.URLStr];
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
- (void)rightBtnsAction:(UIButton *)button{
    DXShareView *shareView = [[DXShareView alloc] init];
    DXShareModel *shareModel = [[DXShareModel alloc] init];
    
    if (ValidStr(self.ios_mark_id)) {
        shareModel.title = self.watNewsDetail.title;
        shareModel.descr = self.watNewsDetail.desc;
        shareModel.url = [NSString stringWithFormat:@"%@",self.watNewsDetail.url];
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.watNewsDetail.thumb]]];
        shareModel.thumbImage = image;
    }else{
        shareModel.title = self.watHomeNewsDetailsModel.title;
        shareModel.descr = self.watHomeNewsDetailsModel.desc;
        shareModel.url = [NSString stringWithFormat:@"%@",self.watHomeNewsDetailsModel.share_url];
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:self.watHomeNewsDetailsModel.thumb]];
        shareModel.thumbImage = image;
    }
    [shareView showShareViewWithDXShareModel:shareModel shareContentType:DXShareContentTypeLink];
    
}
@end
