//
//  WatHomePageViewController.m
//  wat
//
//  Created by 123 on 2018/5/22.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#define tableViewContentInsetHeight 228 + 75

#import "WatHomePageViewController.h"
#import "WatLoginViewController.h"//测试登陆页面

#import "PYSearch.h"

#pragma mark - Controller
#import "WatBigFishClassViewController.h"
#import "WatAlreadyBoughtCourseViewController.h"
#import "AdvertScrollViewDetailViewController.h"
#import "NewsDetailPageViewController.h"//文章详情页
#import "ClassDetailViewController.h"//课程详情页
#import "WatHomeClass01ViewController.h"//课程页面 01
#import "BookDetailViewController.h"//书籍详情页
#import "HomeNewsDetailTableViewCell.h"
#import "HomeClassTableViewCell.h"
#import "WatWeiXinPhoneNumLoginViewController.h"
//--------------------- 列表 -----------------
#import "BookListViewController.h"//书籍列表
#import "ClassListViewController.h"
#import "NewsListViewController.h"
#import "WatHomeMoreListViewController.h"  //更多列表
//--------------------- cell --------------------
#import "HomeJingXuanClassTableViewCell.h"
#import "HomeBookChubanTableViewCell.h"

#pragma mark - View
#import "HorScorllView.h"//轮播图,书籍02
#import "WHScrollView.h"
#import "JKBannarView.h"
#pragma mark - Model
#import "WatHomeModel.h"
#import "WatHomeNewsDetailsModel.h"
#import "WatHomeGoodsDetailsModel.h"
#import "WatHomeWillBeginClassModel.h"

#import <NSObject+YYModel.h>

@interface WatHomePageViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,PYSearchViewControllerDelegate,HorScorllViewImageClickDelegate>{
    
    HorScorllView *_horScorllView;
}
@property (nonatomic, strong)UIButton *loginBtn;//登陆测试按钮
@property (nonatomic, strong) UIView *navigationBarView;//自定义导航栏
@property (nonatomic, strong) UISearchBar *searchBar;//搜索栏
@property (nonatomic, assign) CGFloat oldOffset;
@property (nonatomic, assign) CGFloat backNavAlpha;
@property (nonatomic, assign) CGFloat historyY;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *classBtn; //分类btn
@property (nonatomic, strong) NSArray *btnNameArr;

@property (nonatomic, strong) NSMutableArray *imageArray;//测试 书籍更多 图片数组
//--------------------- model ---------------------
@property (nonatomic, copy) NSArray<WatHomeNewsDetailsModel *> *newsListArray; // 最新文章数据
@property (nonatomic, copy) NSArray<WatHomeBannerModel *> *bannerArr;//banner 数组
@property (nonatomic, strong) WatHomeBannerModel *watHomeBannerModel;
@property (nonatomic, strong) WatHomeModel *watHomeModel;
@property (nonatomic, strong) NSArray *hot_searchArr; //热搜数组
@property (nonatomic, copy) NSArray<WatHomeHotDetailsModel *> *homeHotListArray; //内参出版
@property (nonatomic, copy) NSArray<WatHomeGoodsDetailsModel *> *goodsListArray; // 精选课程
@property (nonatomic, copy) NSArray<WatHomeWillBeginClassModel *> *classListArray; //即将开课
@end

static CGFloat headerScrollViewHeight; //滚动视图的高度 227
@implementation WatHomePageViewController
#pragma 懒加载
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MyKScreenWidth, MyKScreenHeight - MyTabBarHeight)style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        //_tableView.contentInset = UIEdgeInsetsMake(tableViewContentInsetHeight, 0, 0, 0);
    }
    return _tableView;
}

- (NSArray<WatHomeNewsDetailsModel *> *)newsListArray {
    if (!_newsListArray) {
        _newsListArray = [NSArray new];
    }
    return _newsListArray;
}
-(NSArray<WatHomeBannerModel *> *)bannerArr{
    if (!_bannerArr) {
        _bannerArr = [NSArray new];
    }
    return _bannerArr;
}
- (WatHomeModel *)watHomeModel {
    if (!_watHomeModel) {
        _watHomeModel = [WatHomeModel new];
    }
    return _watHomeModel;
}
-(WatHomeBannerModel *)watHomeBannerModel{
    if (!_watHomeBannerModel) {
        _watHomeBannerModel = [WatHomeBannerModel new];
    }
    return _watHomeBannerModel;
}
- (NSArray<WatHomeHotDetailsModel *> *)homeHotListArray {
    if (!_homeHotListArray) {
        _homeHotListArray = [NSArray new];
    }
    return _homeHotListArray;
}
-(NSArray<WatHomeGoodsDetailsModel *> *)goodsListArray{
    if (!_goodsListArray) {
        _goodsListArray = [NSArray new];
    }
    return _goodsListArray;
}
- (NSArray<WatHomeWillBeginClassModel *> *)classListArray{
    if (!_classListArray) {
        _classListArray = [NSArray new];
    }
    return _classListArray;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;
    
    if (![WatUserInfoManager isLoginUserID]) {
        WatLoginViewController *loginVC = [WatLoginViewController new];
        loginVC.pushType = @"present";
        [self presentViewController:loginVC animated:YES completion:nil];
    }
    
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    if ([WatUserInfoManager isLoginUserID]) {
        self.navBarView.hidden = YES;
        //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];//将状态栏颜色改回白色
        [self addNavigationBar];
        self.view.backgroundColor = WatBackColor;
        
        [self callApiData];//请求数据
        [self addTableView];
        //[self addNavigationBarView]; //与下面的方法互斥
        [self addStatesBarView]; //与上面的方法互斥
        //[self addSearchView];
    }else{
        self.navBarView.hidden = YES;
        //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];//将状态栏颜色改回白色
        [self addNavigationBar];
        self.view.backgroundColor = WatBackColor;
        
        [self callApiData];//请求数据
        [self addTableView];
        //[self addNavigationBarView]; //与下面的方法互斥
        [self addStatesBarView]; //与上面的方法互斥
        //[self addSearchView];
    }
    
    

    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
#pragma 通知
    NSNotificationCenter *notiCenter = [NSNotificationCenter defaultCenter];
    [notiCenter addObserver:self selector:@selector(receiveNotification:) name:WechatLoginAddPhoneNotification object:nil];
    
    
}
- (void)receiveNotification:(NSNotification *)dic{
    NSLog(@"接收传值,并作出相应的操作,刷新 tableView/webView");
    // NSNotification 有三个属性，name, object, userInfo，其中最关键的object就是从第三个界面传来的数据。name就是通知事件的名字， userInfo一般是事件的信息。
    NSMutableDictionary *dataDic = [NSMutableDictionary new];
    dataDic = dic.object;
    
    WatWeiXinPhoneNumLoginViewController *vc = [WatWeiXinPhoneNumLoginViewController new];
    vc.weixinID = dataDic[@"weixinID"];
    vc.navTitle = @"绑定手机号";
    [vc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - 数据请求
- (void) callApiData {
    
    __strong typeof (self)weakSelf = self;
    [WatHomeModel asyncPostSiteIndexSuccessBlock:^(WatHomeModel *watHomeModel) {
        weakSelf.newsListArray = watHomeModel.news.list;
        weakSelf.bannerArr = watHomeModel.banner;
        weakSelf.hot_searchArr = watHomeModel.hot_search;
        weakSelf.homeHotListArray = watHomeModel.hot.list;
        weakSelf.goodsListArray = watHomeModel.goods.list;
        weakSelf.classListArray = watHomeModel.goods_new.list;
        weakSelf.watHomeModel = watHomeModel;
        
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
    } errorBlock:^(NSError *errorResult) {
        [weakSelf.tableView.mj_header endRefreshing];
    } paramDic:nil urlStr:kApiSiteIndex];
    
    
    
}

- (void) addSearchView {
//    UIButton *logoBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, MyStatusBarHeight + 5, 30, 30)];
//    [logoBtn setImage:[UIImage imageNamed:@"logo-big"] forState:UIControlStateNormal];
//    logoBtn.imageView.contentMode = 2;
//    //logoBtn.backgroundColor = CommonAppColor;
//    [self.view addSubview:logoBtn];
    
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, MyStatusBarHeight, MyKScreenWidth, 40)];
    self.searchBar = searchBar;
    [self.view addSubview:searchBar]; //注释搜索框
    searchBar.placeholder = @"搜索最新最热文章";
    searchBar.delegate = self;
    searchBar.searchBarStyle = 1;
    searchBar.barTintColor = [UIColor redColor];
    searchBar.tintColor = [UIColor whiteColor];
    //一下代码为修改placeholder字体的颜色和大小
    UITextField * searchField = [_searchBar valueForKey:@"_searchField"];
    [searchField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    [searchBar setBackgroundImage:[UIImage new]];
 
   
}
- (void)addStatesBarView{
    UIView *navigationBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MyKScreenWidth, MyStatusBarHeight)];
    self.navigationBarView = navigationBarView;
    navigationBarView.backgroundColor = CommonAppColor;
    self.navigationBarView.hidden = YES;
    [self.view addSubview:navigationBarView];
}
- (void)addNavigationBarView{
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    // 设置导航栏左边的按钮
    //self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:nil];
    // 设置背景色
    UIView *navigationBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MyKScreenWidth, MyTopHeight)];
    self.navigationBarView = navigationBarView;
    navigationBarView.backgroundColor = CommonAppColor;
    self.navigationBarView.hidden = YES;
    [self.view addSubview:navigationBarView];
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, navigationBarView.frame.size.height - 0.5, MyKScreenWidth, 0.5)];
    lineView.backgroundColor = [UIColor grayColor];
    lineView.alpha = 0.2;
    [navigationBarView addSubview:lineView];

}
- (void)addTableView{
    
    self.tableView.separatorStyle = NO; //隐藏分割线
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
    __weak typeof (self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf callApiData];
    }];
//    [self.tableView.mj_header beginRefreshing];
}

#pragma tableView 三问一达
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    
    
    if (section == 1) {
        return self.newsListArray.count;
    }else if(section == 0){
        return 1;
    }else if(section == 2){
        return self.classListArray.count;
    }else if(section == 3){
        return self.goodsListArray.count;
    }else if(section == 4){
        return 1;
    }else{
        return 3;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString * ID = @"cell";
    
    if (indexPath.section == 0) {
        HomeBookChubanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"HomeBookChubanTableViewCell" owner:self options:nil]firstObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSMutableArray *bannerPicArr = [[NSMutableArray alloc]init];
        for (int i = 0; i < self.bannerArr.count; i ++) {
            self.watHomeBannerModel = self.bannerArr[i];
            [bannerPicArr addObject:self.watHomeBannerModel.pic];
        }
        
        //轮播图
        CGRect rect = CGRectMake(0, 0, MyKScreenWidth, 228);
        NSMutableArray *imageViews = [[NSMutableArray alloc]init];
        [imageViews addObjectsFromArray:@[@"http://show.watcn.com/watcn/watcn/2018/07/13/5b48a74bb5031.jpg"]]; //因为没有图片会崩, 所以加一个数组,防止崩
        JKBannarView *bannerView = [[JKBannarView alloc]initWithFrame:rect viewSize:CGSizeMake(CGRectGetWidth(self.view.bounds),228)];
        if (bannerPicArr.count == 0) {
            bannerView.items = imageViews;
        }else{
            bannerView.items = bannerPicArr;
        }
        [cell addSubview:bannerView];
        __weak typeof (self)weakSelf = self;
        [bannerView imageViewClick:^(JKBannarView * _Nonnull barnerview, NSInteger index) {
            NSLog(@"点击图片%ld",index);
            [weakSelf clickBanner:index];
        }];
        
        
        //分类btn
        UIView *classBtnView = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(bannerView.frame) + 15, MyKScreenWidth, 75)];
        classBtnView.backgroundColor = [UIColor whiteColor];
        [cell addSubview:classBtnView];
    
        _btnNameArr = @[@"老板内参",@"大鱼学院",@"严选加盟",@"严选供应商"];
        NSArray *btnImgArr = @[@"老板内参",@"大鱼学院",@"严选加盟",@"严选供应商"];
        for (int i = 0; i < _btnNameArr.count; i++) {
            UIButton *classBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            classBtn.tag = i;
            
            [classBtn addTarget:self action:@selector(classBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [classBtnView addSubview:classBtn];
            classBtn.frame = CGRectMake(i * MyKScreenWidth / 4 , 0, MyKScreenWidth / 4, classBtnView.frame.size.height);
            
            UIImageView *btnImageView = [[UIImageView alloc]initWithFrame:CGRectMake((classBtn.frame.size.width - 33)/2, 7, 33, 33)];
            btnImageView.image = [UIImage imageNamed:btnImgArr[i]];
            [classBtn addSubview:btnImageView];
            
            UILabel *btnTitleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(btnImageView.frame) + 5, classBtn.frame.size.width, 20)];
            btnTitleLab.textColor = ColorWithRGB(51, 51, 51);
            btnTitleLab.font = commenAppFont(12);
            btnTitleLab.textAlignment = NSTextAlignmentCenter;
            btnTitleLab.text = _btnNameArr[i];
            [classBtn addSubview:btnTitleLab];
            
            
        }
        return cell;
    }else if (indexPath.section == 1) {
        HomeNewsDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"HomeNewsDetailTableViewCell" owner:self options:nil]firstObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell reloadDataFor:self.newsListArray[indexPath.row]];
        cell.backgroundColor = WatBackColor;
        
        return cell;
    }else if (indexPath.section == 2){
        HomeClassTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"HomeClassTableViewCell" owner:self options:nil]firstObject];
        }
        [cell reloadDataFor:self.classListArray[indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        return cell;
    }else if (indexPath.section == 3){
        HomeJingXuanClassTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"HomeJingXuanClassTableViewCell" owner:self options:nil]firstObject];
        }
        [cell reloadDataFor:self.goodsListArray[indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;

    }else{
        
        
        
        NSMutableArray *imagesArr = [[NSMutableArray alloc]init];
        NSMutableArray *titleArr = [[NSMutableArray alloc]init];
        NSMutableArray *priceArr = [[NSMutableArray alloc]init];
        for (int i = 0; i < self.homeHotListArray.count; i ++) {
            WatHomeHotDetailsModel *watHomeHotDetailsModel = self.homeHotListArray[i];
            [imagesArr addObject:watHomeHotDetailsModel.thumb_path];
            [titleArr addObject:watHomeHotDetailsModel.title];
            [priceArr addObject:watHomeHotDetailsModel.price];
        }
        
        HomeBookChubanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"HomeBookChubanTableViewCell" owner:self options:nil]firstObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
            _horScorllView = [[HorScorllView alloc] initWithFrame:CGRectMake(0, 0, MyKScreenWidth, 200)];
            _horScorllView.images = imagesArr;
            _horScorllView.titles = titleArr;
            _horScorllView.moneys = priceArr;
            _horScorllView.delegate = self;
            [cell addSubview:_horScorllView];
        
        
        
        
        return cell;
    }
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return tableViewContentInsetHeight;
    }else if (indexPath.section == 1) {
        return 116;
    }else if (indexPath.section == 2){
        
        return 250;
    }else if (indexPath.section == 3){
        return 145;
    }else{
        return 200;
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld----%ld",indexPath.row,indexPath.section);
    if (indexPath.section == 1) {
        NewsDetailPageViewController *vc = [[NewsDetailPageViewController alloc]init];
        vc.navTitle = self.newsListArray[indexPath.row].title;
        vc.URLStr = self.newsListArray[indexPath.row].url;
        vc.watHomeNewsDetailsModel = self.newsListArray[indexPath.row];
        [vc setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.section == 2){
        ClassDetailViewController *bookVC = [ClassDetailViewController new];
        bookVC.urlStr = self.classListArray[indexPath.row].url;
        bookVC.watHomeWillBeginClassModel = self.classListArray[indexPath.row];
        bookVC.navTitle = self.classListArray[indexPath.row].title;
        [bookVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:bookVC animated:YES];
    }else if (indexPath.section == 3){
//        BookDetailViewController *bookVC = [BookDetailViewController new];
//        bookVC.urlStr = self.goodsListArray[indexPath.row].url;
//        bookVC.navTitle = @"课程详情页";
//        [bookVC setHidesBottomBarWhenPushed:YES];
//        [self.navigationController pushViewController:bookVC animated:YES];
        
        WatHomeClass01ViewController *class01VC = [WatHomeClass01ViewController new];
        [class01VC setHidesBottomBarWhenPushed:YES];        
        class01VC.id = self.goodsListArray[indexPath.row].goods_id;
        class01VC.navTitle = self.goodsListArray[indexPath.row].title;
        [self.navigationController pushViewController:class01VC animated:YES];
        
    }

}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSString *btnName ;
    if (section == 1) {
        btnName = @"每日必读";
    }else if(section == 2){
        btnName = @"即将开课";
    }else if (section == 3){
        btnName = @"精选课程";
    }else if (section == 4) {
        btnName = @"内参出版";
        
    }
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MyKScreenWidth, 64)];
    //headerView.backgroundColor = CommonAppColor;
    UILabel *headerTitleLab = [[UILabel alloc]initWithFrame:CGRectMake(14, 30, 100, 24)];
    headerTitleLab.text = btnName;
    headerTitleLab.font = biaotiAppFont(24);
    headerTitleLab.textColor = [UIColor blackColor];
    headerTitleLab.textAlignment = NSTextAlignmentLeft;
    [headerView addSubview:headerTitleLab];

    UIButton *moreBtn = [[UIButton alloc]initWithFrame:CGRectMake(MyKScreenWidth - 71, 30 + 13, 60, 14)];
    [moreBtn setTitle:@"查看全部" forState: UIControlStateNormal];
    [moreBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    moreBtn.titleLabel.font = zhengwenAppFont(14);
    moreBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    moreBtn.tag = section;
    [moreBtn addTarget:self action:@selector(addMoreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    if (section != 0 && section !=4) {//为了防止 section = 0 && 4 的时候,显示
        [headerView addSubview:moreBtn];
    }
    if (section != 0) {
        UIView *fenggeLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MyKScreenWidth, 8)];
        fenggeLine.backgroundColor = WatBackColor;
        [headerView addSubview:fenggeLine];
    }
   
    
//    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, headerView.frame.size.height - 1, MyKScreenWidth, 1)];
//    lineView.backgroundColor = WatBackColor;
//    [headerView addSubview:lineView];

    return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.01;
    }
    return 40 + 10 + 20;
}
/**
 分类 btn 点击事件
 
 @param sender 点击额 tag 值
 */
- (void)classBtnClick:(UIButton *)sender {
    
    UIButton *classBtn = sender;
    NSLog(@"您点击的btn.tag ====== %ld",classBtn.tag);
    if (sender.tag == 1) {
        WatAlreadyBoughtCourseViewController *classDetailVC = [[WatAlreadyBoughtCourseViewController alloc]init];
        //self.navigationController.navigationBarHidden = NO;
        [classDetailVC setHidesBottomBarWhenPushed:YES];
        classDetailVC.navigationController.navigationBarHidden = NO;
        [self.navigationController pushViewController: classDetailVC animated:YES];
        
        
    }else if (sender.tag ==0){
        WatHomeMoreListViewController *vc = [WatHomeMoreListViewController new];
        vc.cellType = @"每日必读";
        [vc setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (sender.tag == 3){
        NewsDetailPageViewController *vc = [NewsDetailPageViewController new];
        [vc setHidesBottomBarWhenPushed:YES];
        vc.URLStr = [NSURL URLWithString:@"http://h5.watcn.com/supplier/kedou"];
        vc.navTitle = @"蝌蚪餐服";
        [self.navigationController pushViewController:vc animated:YES];
        
    } else if (sender.tag == 2){
        NewsDetailPageViewController *vc = [NewsDetailPageViewController new];
        [vc setHidesBottomBarWhenPushed:YES];
        vc.URLStr = [NSURL URLWithString:@"http://h5.watcn.com/supplier/hailuo"];
        vc.navTitle = @"海螺餐创";
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}
//点击书籍滚动图的代理点击方法 delegate

- (void)horImageClickAction:(NSInteger)tag section:(NSInteger)section{
    NSLog(@"你点击的按钮tag值为：%ld",tag);
    
    BookDetailViewController *bookVC = [BookDetailViewController new];
    bookVC.urlStr = self.homeHotListArray[tag - 100].url;
    bookVC.hk_iconImage = self.homeHotListArray[tag - 100].thumb_path;
    bookVC.watHomeHotDetailsModel = self.homeHotListArray[tag - 100];
    bookVC.navTitle = self.homeHotListArray[tag - 100].title;
    [bookVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:bookVC animated:YES];
}

- (void)classDetailsBtnClick:(UIButton *)sender{
    NSLog(@"点击的是第%ld个课程按钮",sender.tag);
    NSString *str = [NSString stringWithFormat:@"点击的是第%ld个按钮",sender.tag];
    ClassDetailViewController *classDetailVC = [ClassDetailViewController new];
    classDetailVC.navTitle = str;
    [classDetailVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:classDetailVC animated:YES];
}
- (void)addMoreBookClick{
    
    NSLog(@"点击了更多书籍");
    BookListViewController *bookListVC = [BookListViewController new];
    [bookListVC setHidesBottomBarWhenPushed:YES];
    bookListVC.navTitle = @"书籍报告";
    [self.navigationController pushViewController:bookListVC animated:YES];
    
}


- (void) addMoreBtnClick:(UIButton *)sender {
    NSLog(@"%ld",sender.tag);
    //list
    WatHomeMoreListViewController *vc = [WatHomeMoreListViewController new];
    [vc setHidesBottomBarWhenPushed:YES];
    if (sender.tag == 1) {
        vc.cellType = @"每日必读";
    }else if (sender.tag == 2){
        vc.cellType = @"即将开课";
    }else if (sender.tag == 3){
        vc.cellType = @"精选课程";
    }else if (sender.tag == 4){
        vc.cellType = @"内参出版";
    }
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

- (void)addNavigationBar{
    //设置导航栏背景色以及title颜色
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:CommonAppColor}];
    //self.navigationController.navigationBarHidden = YES;
    self.isBackTitle = YES;
    self.navigationBarView.hidden = YES;
    
}

#pragma moreBook
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)clickBanner:(NSInteger)sender{
    //link_type 1文章 直接跳转h5 2.课程 跳转在线视频 3 线下书籍 4是线下活动
    NSString *link_type;
    link_type = self.bannerArr[sender].link_type;
    
    if ([link_type isEqualToString:@"1"]) {
        NewsDetailPageViewController *vc = [[NewsDetailPageViewController alloc]init];
        vc.navTitle = self.bannerArr[sender].b_name;
        vc.URLStr = [NSURL URLWithString:self.bannerArr[sender].link];
        vc.ios_mark_id = self.bannerArr[sender].ios_mark_id;
        [vc setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if ([link_type isEqualToString:@"2"]){
        WatHomeClass01ViewController *class01VC = [WatHomeClass01ViewController new];
        [class01VC setHidesBottomBarWhenPushed:YES];
        class01VC.id = self.bannerArr[sender].ios_mark_id;
        [self.navigationController pushViewController:class01VC animated:YES];
    }else if ([link_type isEqualToString:@"3"]){
        ClassDetailViewController *bookVC = [ClassDetailViewController new];
        bookVC.ios_mark_id = self.bannerArr[sender].ios_mark_id;
        bookVC.navTitle = self.bannerArr[sender].b_name;
        [bookVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:bookVC animated:YES];
        

    }else if ([link_type isEqualToString:@"4"]){
        ClassDetailViewController *bookVC = [ClassDetailViewController new];
        bookVC.ios_mark_id = self.bannerArr[sender].ios_mark_id;
        bookVC.navTitle = self.bannerArr[sender].b_name;
        [bookVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:bookVC animated:YES];
    }
    
}


#pragma - mark 监听 scrollView 滑动
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    ///NSLog(@"%lf",scrollView.contentOffset.y);
    headerScrollViewHeight = 0;//如果需要 banner 滑动完,在出现,那就加 banner 的高
//#pragma navigationBar 影藏显示
    if (scrollView.contentOffset.y > _oldOffset) {//如果当前位移大于缓存位移，说明scrollView向上滑动
        if (scrollView.contentOffset.y > - ( MyStatusBarHeight)) { //184
            self.navigationBarView.hidden = NO;
            self.backNavAlpha = (scrollView.contentOffset.y) / 100.0;
            self.navigationBarView.alpha = self.backNavAlpha;
            if (self.backNavAlpha == 0) {
                self.navigationBarView.hidden = YES;
            }else{
                self.navigationBarView.hidden = NO;
            }
        }
    }else {

        if (scrollView.contentOffset.y < 0) {
            self.navigationBarView.hidden = YES;
            self.navigationBarView.alpha = self.backNavAlpha;
        }else{
            self.navigationBarView.hidden = NO;
            self.backNavAlpha = (scrollView.contentOffset.y ) / 100.0;
            self.navigationBarView.alpha = self.backNavAlpha;
            if (self.backNavAlpha == 0) {
                self.navigationBarView.hidden = YES;
            }else{
                self.navigationBarView.hidden = NO;
            }
        }
    }
//---------------------- 搜索框样式 --------------------
//    if (self.backNavAlpha >= 1.0) {
//        self.searchBar.searchBarStyle = 2;
//    }else{
//        self.searchBar.searchBarStyle = 1;
//    }
    
    _oldOffset = scrollView.contentOffset.y;//将当前位移变成缓存位移

#pragma searchView
    if (scrollView.contentOffset.y < - ( MyStatusBarHeight)) {
        
        self.searchBar.hidden = YES;
//        if (scrollView.contentOffset.y < _historyY) { //下滑
//            self.searchBar.frame = CGRectMake(0, MyStatusBarHeight - scrollView.contentOffset.y, MyKScreenWidth, 44);
//        }
//        if (scrollView.contentOffset.y > _historyY) { //上滑
//            self.searchBar.frame = CGRectMake(0, MyStatusBarHeight - scrollView.contentOffset.y, MyKScreenWidth, 44);
//        }

    }else{
        self.searchBar.hidden = NO;
    }


    _historyY=scrollView.contentOffset.y;
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    // 1.创建热门搜索
    
    // 2. 创建控制器
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:self.watHomeModel.hot_search searchBarPlaceholder:@"搜索便民信息" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        // 开始搜索执行以下代码
        // 如：跳转到指定控制器
//        ZWHConvenienceDetailViewController *detailVC = [ZWHConvenienceDetailViewController new];
//        detailVC.navTitle = [NSString stringWithFormat:@"搜索:“%@”",searchText];
//        [searchViewController.navigationController pushViewController:detailVC animated:YES];//搜索注销
    }];
    //    // 3. 设置风格
    //    if (indexPath.section == 0) { // 选择热门搜索
    //        searchViewController.hotSearchStyle = (NSInteger)indexPath.row; // 热门搜索风格根据选择
    //        searchViewController.searchHistoryStyle = PYHotSearchStyleDefault; // 搜索历史风格为default
    //    } else { // 选择搜索历史
    //        searchViewController.hotSearchStyle = PYHotSearchStyleDefault; // 热门搜索风格为默认
    //        searchViewController.searchHistoryStyle = (NSInteger)indexPath.row; // 搜索历史风格根据选择
    //    }
    searchViewController.hotSearchStyle = PYHotSearchStyleBorderTag; // 热门搜索风格根据选择
    searchViewController.searchHistoryStyle = PYHotSearchStyleDefault; // 搜索历史风格为default
    // 4. 设置代理
    searchViewController.delegate = self;
    // 5. 跳转到搜索控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];

    [self presentViewController:nav  animated:YES completion:nil];
    
}
#pragma mark - PYSearchViewControllerDelegate
- (void)searchViewController:(PYSearchViewController *)searchViewController searchTextDidChange:(UISearchBar *)seachBar searchText:(NSString *)searchText
{
    if (searchText.length) { // 与搜索条件再搜索
        // 根据条件发送查询（这里模拟搜索）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ // 搜素完毕
            // 显示建议搜索结果
            NSMutableArray *searchSuggestionsM = [NSMutableArray array];
            for (int i = 0; i < arc4random_uniform(5) + 10; i++) {
                NSString *searchSuggestion = [NSString stringWithFormat:@"搜索建议 %d", i];
                [searchSuggestionsM addObject:searchSuggestion];
            }
            // 返回
            searchViewController.searchSuggestions = searchSuggestionsM;
        });
    }
}


#pragma mark --懒加载
- (NSMutableArray *)imageArray {
    if (_imageArray == nil) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];//移除通知
    
}

@end
