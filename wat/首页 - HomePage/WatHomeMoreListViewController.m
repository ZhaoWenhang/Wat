//
//  WatHomeMoreListViewController.m
//  wat
//
//  Created by 123 on 2018/6/22.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "WatHomeMoreListViewController.h"
//--------------------- cell -----------------
#import "HomeNewsDetailTableViewCell.h"
#import "HomeClassTableViewCell.h"
#import "HomeJingXuanClassTableViewCell.h"

#import "WatHomeMoreListModel.h"
#import "WatHomeNewsDetailsModel.h"//每日必读 书籍
#import "WatHomeWillBeginClassModel.h"//即将开课
#import "WatHomeGoodsDetailsModel.h"//精选课程
#import "WatHomeHotDetailsModel.h"//书籍

// ---------------- controller -------------
#import "NewsDetailPageViewController.h"
#import "ClassDetailViewController.h"
#import "WatHomeClass01ViewController.h"
#import "BookDetailViewController.h"

@interface WatHomeMoreListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSString *page;
//-------------------- Model ----------------------
@property (nonatomic, strong) WatHomeMoreListModel *watHomeMoreListModel;
@property (nonatomic, strong) WatHomeNewsDetailsModel *watHomeNewsDetailsModel;
@property (nonatomic, strong) NSArray<WatHomeNewsDetailsModel *> *newsListArr;
@property (nonatomic, strong) NSArray<WatHomeWillBeginClassModel *> *beginClassListArr;
@property (nonatomic, strong) NSArray<WatHomeGoodsDetailsModel *> *goodsListArr;
@property (nonatomic, strong) NSArray<WatHomeHotDetailsModel *> *hotListArr;

@end

@implementation WatHomeMoreListViewController
-(WatHomeMoreListModel *)watHomeMoreListModel{
    if (!_watHomeMoreListModel) {
        _watHomeMoreListModel = [WatHomeMoreListModel new];
    }
    return _watHomeMoreListModel;
}
-(WatHomeNewsDetailsModel *)watHomeNewsDetailsModel{
    if (!_watHomeNewsDetailsModel) {
        _watHomeNewsDetailsModel = [WatHomeNewsDetailsModel new];
    }
    return _watHomeNewsDetailsModel;
}
- (NSArray<WatHomeNewsDetailsModel *> *)newsListArr {
    if (!_newsListArr) {
        _newsListArr = [NSArray new];
    }
    return _newsListArr;
}
- (NSArray<WatHomeWillBeginClassModel *> *)beginClassListArr{
    if (!_beginClassListArr) {
        _beginClassListArr = [NSArray new];
    }
    return _beginClassListArr;
}
- (NSArray<WatHomeGoodsDetailsModel *> *)goodsListArr{
    if (!_goodsListArr) {
        _goodsListArr = [NSArray new];
    }
    return _goodsListArr;
}
-(NSArray<WatHomeHotDetailsModel *> *)hotListArr{
    if (!_hotListArr) {
        _hotListArr = [NSArray new];
    }
    return _hotListArr;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, MyTopHeight, MyKScreenWidth, MyKScreenHeight - 6-MyStatusBarHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self setAFN];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = self.cellType;
    
    [self.view addSubview:self.tableView];
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MyKScreenWidth, 6)];
    self.tableView.tableHeaderView = headerView;
    
    __weak typeof (self) weakSelf = self;
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf setAFN];
    }];
    
}
- (void) setAFN {
    __weak typeof (self)wself = self;
    
    NSString *urlStr;
    if ([self.cellType isEqualToString:@"每日必读"]) {
        urlStr = kApiArticleList;
    }else if ([self.cellType isEqualToString:@"即将开课"]) {
        urlStr = kApiEducationActiveList;
    }else if ([self.cellType isEqualToString:@"精选课程"]){
        urlStr = kApiEducationLineList;
    }else if([self.cellType isEqualToString:@"内参出版"]){
        urlStr = kApiEducationBookList;
    }
    NSMutableDictionary *paramDic = [NSMutableDictionary new];
    [paramDic setValue:self.watHomeMoreListModel.page forKey:@"page"];
    [WatHomeMoreListModel asyncPostkApiArticleListSuccessBlock:^(WatHomeMoreListModel *watHomeMoreListModel) {
        __strong typeof (wself)sself = wself;
        if ([wself.watHomeMoreListModel.page isEqualToString:@"1"]) {
            [sself.tableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            
            NSMutableArray *listArr = [NSMutableArray new];
            if ([self.cellType isEqualToString:@"每日必读"]) {
                for (int i = 0 ; i < sself.newsListArr.count; i ++) {
                    [listArr addObject:sself.newsListArr[i]];
                }
                for (int a = 0; a < watHomeMoreListModel.newsListArr.count; a ++) {
                    [listArr addObject:watHomeMoreListModel.newsListArr[a]];
                }
                sself.newsListArr = listArr;
            }else if ([self.cellType isEqualToString:@"即将开课"]) {
                for (int i = 0 ; i < sself.beginClassListArr.count; i ++) {
                    [listArr addObject:sself.beginClassListArr[i]];
                }
                for (int a = 0; a < watHomeMoreListModel.beginClassListArr.count; a ++) {
                    [listArr addObject:watHomeMoreListModel.beginClassListArr[a]];
                }
                sself.beginClassListArr = listArr;
            }else if ([self.cellType isEqualToString:@"精选课程"]){
                for (int i = 0 ; i < sself.goodsListArr.count; i ++) {
                    [listArr addObject:sself.goodsListArr[i]];
                }
                for (int a = 0; a < watHomeMoreListModel.goodsListArr.count; a ++) {
                    [listArr addObject:watHomeMoreListModel.goodsListArr[a]];
                }
                sself.goodsListArr = listArr;
            }else if([self.cellType isEqualToString:@"内参出版"]){
                for (int i = 0 ; i < sself.hotListArr.count; i ++) {
                    [listArr addObject:sself.hotListArr[i]];
                }
                for (int a = 0; a < watHomeMoreListModel.hotListArr.count; a ++) {
                    [listArr addObject:watHomeMoreListModel.hotListArr[a]];
                }
                sself.hotListArr = listArr;
            }
            
            //NSLog(@"%@",watHomeMoreListModel.newsListArr);
            sself.watHomeMoreListModel = watHomeMoreListModel;
            sself.watHomeMoreListModel.page = watHomeMoreListModel.page;
            
            [sself.tableView.mj_footer endRefreshing];
            [sself.tableView reloadData];
        }
    } errorBlock:^(NSError *errorResult) {
        [self.tableView.mj_footer endRefreshing];
    } paramDic:paramDic urlStr:urlStr];
    

    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ([self.cellType isEqualToString:@"每日必读"]) {
        return self.newsListArr.count;
    }else if ([self.cellType isEqualToString:@"即将开课"]) {
        return self.beginClassListArr.count;
    }else if ([self.cellType isEqualToString:@"精选课程"]){
        return self.goodsListArr.count;
    }else{
        return self.hotListArr.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"Cell";
    
    if ([self.cellType isEqualToString:@"每日必读"]) {
        HomeNewsDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"HomeNewsDetailTableViewCell" owner:self options:nil]firstObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell reloadDataFor:self.newsListArr[indexPath.row]];
        cell.backgroundColor = WatBackColor;
        
        return cell;
    }else if ([self.cellType isEqualToString:@"即将开课"]){
        HomeClassTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"HomeClassTableViewCell" owner:self options:nil]firstObject];
        }
        [cell reloadDataFor:self.beginClassListArr[indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    }else if ([self.cellType isEqualToString:@"精选课程"]){
        HomeJingXuanClassTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"HomeJingXuanClassTableViewCell" owner:self options:nil]firstObject];
        }
        [cell reloadDataFor:self.goodsListArr[indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    }else{//if ([self.cellType isEqualToString:@"内参出版"])
        HomeJingXuanClassTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"HomeJingXuanClassTableViewCell" owner:self options:nil]firstObject];
        }
       // [cell reloadDataFor:self.hotListArr[indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    }
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.cellType isEqualToString:@"每日必读"]) {
        return 116;
    }else if ([self.cellType isEqualToString:@"即将开课"]) {
        return 250;
    }else if ([self.cellType isEqualToString:@"精选课程"]){
        return 145;
    }else{
        return 145;
    }
}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.cellType isEqualToString:@"每日必读"]) {
        NewsDetailPageViewController *vc = [[NewsDetailPageViewController alloc]init];
        vc.navTitle = self.newsListArr[indexPath.row].title;
        vc.URLStr = self.newsListArr[indexPath.row].url;
        vc.watHomeNewsDetailsModel = self.newsListArr[indexPath.row];
        [vc setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([self.cellType isEqualToString:@"即将开课"]) {
        ClassDetailViewController *bookVC = [ClassDetailViewController new];
        bookVC.urlStr = self.beginClassListArr[indexPath.row].url;
        bookVC.watHomeWillBeginClassModel = self.beginClassListArr[indexPath.row];
        bookVC.navTitle = self.beginClassListArr[indexPath.row].title;
        [bookVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:bookVC animated:YES];
    }else if ([self.cellType isEqualToString:@"精选课程"]){
        WatHomeClass01ViewController *class01VC = [WatHomeClass01ViewController new];
        [class01VC setHidesBottomBarWhenPushed:YES];
        class01VC.id = self.goodsListArr[indexPath.row].goods_id;
        class01VC.navTitle = self.goodsListArr[indexPath.row].title;
        [self.navigationController pushViewController:class01VC animated:YES];
    }else{
        BookDetailViewController *bookVC = [BookDetailViewController new];
        bookVC.urlStr = self.hotListArr[indexPath.row].url;
        bookVC.hk_iconImage = self.hotListArr[indexPath.row].thumb_path;
        bookVC.navTitle = self.hotListArr[indexPath.row].title;
        [bookVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:bookVC animated:YES];
    }
    
}
@end
