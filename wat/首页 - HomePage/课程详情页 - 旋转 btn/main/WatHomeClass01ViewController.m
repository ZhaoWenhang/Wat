//
//  WatHomeClass01ViewController.m
//  wat
//
//  Created by 123 on 2018/6/26.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "WatHomeClass01ViewController.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "MainTableView.h"
#import "WMPageController.h"
#import "MyWalletViewController.h"


//--------------- 弹出购买控制器---------------
#import "PayOnLineClassAleartViewController.h"
//--------------- model -------------------
#import "WatHomeClass01Model.h"
#import "applepayGetmycionModel.h"

#define scr_wid [UIScreen mainScreen].bounds.size.width
#define scr_hei [UIScreen mainScreen].bounds.size.height
@interface WatHomeClass01ViewController ()<scrollDelegate,WMPageControllerDelegate,UITableViewDataSource,UITableViewDelegate>
{
    CGFloat star_y;
}

@property (nonatomic, strong)NSString *onePageUrl;
@property (nonatomic, strong)NSString *thumb_path;
//@property (nonatomic, strong) NSString *title;

@property (nonatomic,strong)MainTableView *mainTableView;
@property(nonatomic,strong) UIScrollView  *parentScrollView;

@property (nonatomic,assign)BOOL mainScroll;
@property (nonatomic, strong) UIView *blackBgView;
@property (nonatomic, strong) UIView *buyBtnBGView;
@property (nonatomic, strong) UIButton *buyBtn;

//-------------- model -------------
@property (nonatomic, strong)WatHomeClass01Model *watHomeClass01Model;
@property (nonatomic, strong)WatHomeClassGoodsModel *watHomeClassGoodsModel;
@property (nonatomic, strong)WatHomeClassListModel *watHomeClassListModel;
@property (nonatomic, strong)NSArray<WatHomeClassListDetailModel *> *list;
@property (nonatomic, strong)applepayGetmycionModel *getmycionModel;


@property (nonatomic, strong) NSString *yigouNumStr;
@property (nonatomic, strong) NSString *goumaiBtnTitleStr;
@end

@implementation WatHomeClass01ViewController
-(applepayGetmycionModel *)getmycionModel{
    if (!_getmycionModel) {
        _getmycionModel = [applepayGetmycionModel new];
    }
    return _getmycionModel;
}
-(WatHomeClass01Model *)watHomeClass01Model{
    if (!_watHomeClass01Model) {
        _watHomeClass01Model = [WatHomeClass01Model new];
    }
    return _watHomeClass01Model;
}
-(WatHomeClassListModel *)watHomeClassListModel{
    if (!_watHomeClassListModel) {
        _watHomeClassListModel = [WatHomeClassListModel new];
    }
    return _watHomeClassListModel;
}
- (WatHomeClassGoodsModel *)watHomeClassGoodsModel{
    if (!_watHomeClassGoodsModel) {
        _watHomeClassGoodsModel = [WatHomeClassGoodsModel new];
    }
    return _watHomeClassGoodsModel;
}
-(NSArray<WatHomeClassListDetailModel *> *)list
{
    if (!_list) {
        _list = [NSArray new];
    }
    return _list;
}
-(UIView *)blackBgView{
    if (!_blackBgView) {
        _blackBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MyKScreenWidth, MyKScreenHeight)];
        UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0,CGRectGetWidth(_blackBgView.frame), CGRectGetHeight(_blackBgView.frame))];
        toolbar.barStyle = UIBarStyleBlackTranslucent;
        [_blackBgView addSubview:toolbar];
        _blackBgView.hidden = YES;
        [self.view addSubview:_blackBgView];
    }
    return _blackBgView;
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


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //self.view.backgroundColor = [UIColor whiteColor];
    self.navTitle = @"";
    //默认初始 主tv可滚动
    _mainScroll = YES;
    self.navBarView.alpha = 0;
    self.mainTableView.bounces = NO;
    self.rightTitles = @[@"分享"];
    [self setAFN];
    
    if (@available(iOS 11.0, *)) {
        self.mainTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
        
    [self.view addSubview:self.mainTableView];
    
    
// -------------------------- 购买弹窗 ------------------
    [self addBuyBtn];//购买按钮
    
    //支付成功,dismiss
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dissBlackBGVClick) name:@"dissBlackBGVClick" object:nil];
    //购买成功.返回界面
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySuccessDissBlackBGVClick) name:@"paySuccessDissBlackBGVClick" object:nil]; //jumpWalletVCClick
    //购买成功.返回界面
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jumpWalletVCClick) name:@"jumpWalletVCClick" object:nil]; //jumpWalletVCClick
    //点击课程 cell,如果没购买,发通知,购买页
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(buyBtnClick) name:WatOnlineClassesBuy object:nil];
    
    
}
- (void)dissBlackBGVClick{
    self.blackBgView.hidden = YES;
    self.isBackTitle = NO;
    self.rightTitles = @[@"分享"];
    self.navBarView.hidden = NO;
    self.navigationController.navigationBarHidden = NO;
}
- (void)paySuccessDissBlackBGVClick{
    self.blackBgView.hidden = YES;
    self.isBackTitle = NO;
    self.rightTitles = @[@"分享"];
    self.navBarView.hidden = NO;
    self.navigationController.navigationBarHidden = NO;
    [self setAFN];
    [self.mainTableView reloadData];
    [[ZWHHelper sharedHelper]addAlertViewControllerToView:self withClickBlock:^(int clickInt) {
        
    } title:@"提示" content:@"恭喜您购买成功!" cancleStr:@"" confirmStr:@"去学习~"];
}
- (void)jumpWalletVCClick{
    self.blackBgView.hidden = YES;
    self.isBackTitle = NO;
    self.rightTitles = @[@"分享"];
    self.navBarView.hidden = NO;
    self.navigationController.navigationBarHidden = NO;
    MyWalletViewController *watlletVC = [MyWalletViewController new];
    [self.navigationController pushViewController:watlletVC animated:YES];
}
- (void)setAFN{
    NSMutableDictionary *paramDic = [NSMutableDictionary new];
    [paramDic setObject:self.id forKey:@"id"];
    __weak typeof (self)weakSelf = self;
    [WatHomeClass01Model asyncPostkApiEducationDetailSuccessBlock:^(WatHomeClass01Model *watHomeClass01Model) {
        weakSelf.watHomeClassGoodsModel = watHomeClass01Model.goods;
        weakSelf.list = watHomeClass01Model.list;
        
        weakSelf.thumb_path = weakSelf.watHomeClassGoodsModel.thumb;
        weakSelf.onePageUrl = weakSelf.watHomeClassGoodsModel.conetent_url;
        weakSelf.is_buy = watHomeClass01Model.is_buy;
        weakSelf.yigouNumStr = [NSString stringWithFormat:@"已有%@人购买",self.watHomeClassGoodsModel.sale_num];
        weakSelf.goumaiBtnTitleStr = [NSString stringWithFormat:@"立即购买:%@元",self.watHomeClassGoodsModel.price];
       
        [weakSelf.mainTableView reloadData];
        //数据加载完,删除界面,从新加载界面
        [weakSelf.view removeAllSubviews];
        [weakSelf.view addSubview:self.mainTableView];
        [weakSelf addBuyBtn];
        if ( [self.is_buy isEqualToString:@"1"]) {
            self.buyBtn.hidden = YES;
        }
    } errorBlock:^(NSError *errorResult) {
        
    } paramDic:paramDic urlStr:kApiEducationDetail];
    
}


- (void)addBuyBtn {
    
    
    
    UIView *buyBtnBGView = [[UIView alloc]initWithFrame:CGRectMake(0, MyKScreenHeight - MyTabBarHeight, MyKScreenWidth, MyTabBarHeight)];
    self.buyBtnBGView = buyBtnBGView;
    buyBtnBGView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:buyBtnBGView];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0.5, MyKScreenWidth, 0.5)];
    lineView.backgroundColor = [UIColor grayColor];
    [buyBtnBGView addSubview:lineView];
    
    UILabel *yigouNumLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 4.5, 200, 40)];
    yigouNumLab.text = self.yigouNumStr;
    yigouNumLab.font = commenAppFont(14);
    yigouNumLab.textColor = [UIColor darkGrayColor];
    [buyBtnBGView addSubview:yigouNumLab];
    
    UIButton *buyBtn = [[UIButton alloc]initWithFrame:CGRectMake(MyKScreenWidth - MyKScreenWidth * 0.33 - 20, 9, MyKScreenWidth * 0.33, 30)];
    self.buyBtn = buyBtn;
    [buyBtn setTitle:self.goumaiBtnTitleStr forState:UIControlStateNormal];
    buyBtn.titleLabel.font = biaotiAppFont(14);
    [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buyBtn.backgroundColor = CommonAppColor;
    buyBtn.layer.cornerRadius = 4.0;
    buyBtn.clipsToBounds = YES;
    buyBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [buyBtn addTarget:self action:@selector(buyBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [buyBtnBGView addSubview:buyBtn];
    
    
    
}
- (void) buyBtnClick{
    
    if ([WatUserInfoManager isLoginUserID]) {
        PayOnLineClassAleartViewController *payOnlineVC = [PayOnLineClassAleartViewController new];
        payOnlineVC.watHomeClassGoodsModel = self.watHomeClassGoodsModel;
        //弹出视图,黑底色
        UIColor *color = [UIColor clearColor];
        payOnlineVC.view.backgroundColor = [color colorWithAlphaComponent:0.0];
        payOnlineVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        
        self.blackBgView.hidden = NO;
        self.isBackTitle = YES;
        self.rightTitles = @[@""];
        self.navBarView.hidden = YES;
        self.navigationController.navigationBarHidden = YES;
        [self.navigationController presentViewController:payOnlineVC animated:YES completion:nil];
    }else{
        [[ZWHHelper sharedHelper]addAlertViewControllerToView:self withClickBlock:^(int clickInt) {
            if (clickInt == 1) {
                WatLoginViewController *loginVC = [WatLoginViewController new];
                [self.navigationController pushViewController:loginVC animated:YES];
            }
        } title:@"提示" content:@"登陆后才可以购买哦~" cancleStr:@"取消" confirmStr:@"登陆"];
        
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
        return 227;
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
        CGRect rect = CGRectMake(0, 0, MyKScreenWidth,227);
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:rect];
        imgView.contentMode = 2;
        imgView.clipsToBounds = YES;
        NSURL *imageUrl = [NSURL URLWithString:self.thumb_path];
        [imgView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"pic00"]];
        [self.mainTableView addSubview:imgView];
        
//        UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0,CGRectGetWidth(imgView.frame), CGRectGetHeight(imgView.frame))];
//        toolbar.barStyle = 2;
//        [imgView addSubview:toolbar];
        
        UIView *titltBGView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(imgView.frame) - 44, MyKScreenWidth, 44)];
        titltBGView.backgroundColor = [UIColor blackColor];
        titltBGView.alpha = 0.4;
        [imgView addSubview:titltBGView];
        
        UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, MyKScreenWidth - 20, 44)];
        titleLab.textColor = [UIColor whiteColor];
        titleLab.font = biaotiAppFont(16);
        titleLab.text = self.watHomeClassGoodsModel.title;//
        titleLab.numberOfLines = 0;
        CGSize size = [titleLab.text boundingRectWithSize:CGSizeMake(MyKScreenWidth - 40, MAXFLOAT) options: NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:titleLab.font forKey:NSFontAttributeName] context:nil].size; //label 根据文字长度,设置高度
        titleLab.frame = CGRectMake(20, CGRectGetHeight(imgView.frame) - size.height - 10, size.width, size.height);
        titleLab.numberOfLines = 0;
        [imgView addSubview:titleLab];
        
        titltBGView.frame = CGRectMake(0, CGRectGetHeight(imgView.frame) - size.height - 20 , MyKScreenWidth, size.height + 20);
    }else{
        /* 添加pageView
         * 这里可以任意替换你喜欢的pageView
         *作者这里使用一款github较多人使用的 WMPageController 地址https://github.com/wangmchn/WMPageController
         */
        [cell.contentView addSubview:self.setPageViewControllers];
    }
    
    
   
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
    OneViewController * oneVc  = [OneViewController new];
    NSURL *url = [NSURL URLWithString:self.onePageUrl];
    oneVc.URLStr = url;
    oneVc.delegate = self;
    
    TwoViewController * twoVc  = [TwoViewController new];
    twoVc.delegate = self;
    twoVc.list = self.list;
    twoVc.is_buy = self.is_buy;
    NSArray *viewControllers = @[oneVc,twoVc];
    
    NSArray *titles = @[@"详情",@"目录"];
    WMPageController *pageVC = [[WMPageController alloc] initWithViewControllerClasses:viewControllers andTheirTitles:titles];
    [pageVC setViewFrame:CGRectMake(0, 0, scr_wid, scr_hei)];
    pageVC.delegate = self;
    pageVC.menuItemWidth = MyKScreenWidth / titles.count / 2 ;
    pageVC.menuHeight = 44;
    pageVC.postNotification = YES;
    pageVC.bounces = YES;
    
    return pageVC;
}

- (MainTableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[MainTableView alloc]initWithFrame:CGRectMake(0, 0, scr_wid, scr_hei) style:UITableViewStylePlain];
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
    CGFloat height;
    if (KIsiPhoneX) {
        height = 139;
    }else{
        height = 163;
    }
    
    
    
    CGFloat offset = scrollView.contentOffset.y;
    NSLog(@"滚动偏移量+++++++%lf  ++++++%lf",offset,MyTopHeight);
    //导航栏透明度
        if (offset <= height) {
    
            CGFloat alpha =offset / height;
            self.navBarView.alpha = alpha;
            
            if (self.navBarView.alpha > 0.3) {
                self.navTitle = self.watHomeClassGoodsModel.title;
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
    
}
- (void)rightBtnsAction:(UIButton *)button{
    DXShareView *shareView = [[DXShareView alloc] init];
    DXShareModel *shareModel = [[DXShareModel alloc] init];
    shareModel.title = self.watHomeClassGoodsModel.title;
    shareModel.descr = self.watHomeClassGoodsModel.subTitle;
    shareModel.url = [NSString stringWithFormat:@"%@",self.watHomeClassGoodsModel.share_url];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.watHomeClassGoodsModel.thumb]]];
    shareModel.thumbImage = image;
    [shareView showShareViewWithDXShareModel:shareModel shareContentType:DXShareContentTypeLink];
    
}
- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
@end
