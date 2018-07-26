//
//  YigouTwoViewController.m
//  wat
//
//  Created by 123 on 2018/5/30.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "YigouTwoViewController.h"
#import "YigouTableViewCell.h"
#import "ClassDetailViewController.h"

#import "HomeClassTableViewCell.h"

//-------------------- model ------------------------
#import "WatHomeMoreListModel.h"
#import "WatHomeWillBeginClassModel.h"
@interface YigouTwoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) WatHomeMoreListModel *watHomeMoreListModel;
@property (nonatomic, strong) NSArray<WatHomeWillBeginClassModel *> *beginClassListArr;
@end

@implementation YigouTwoViewController
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MyKScreenWidth, MyKScreenHeight - MyTopHeight - 44 - 5)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    }
    
    return _tableView;
}
-(WatHomeMoreListModel *)watHomeMoreListModel {
    if (!_watHomeMoreListModel) {
        _watHomeMoreListModel = [WatHomeMoreListModel new];
    }
    return _watHomeMoreListModel;
}
- (NSArray<WatHomeWillBeginClassModel *> *)beginClassListArr{
    if (!_beginClassListArr) {
    _beginClassListArr = [NSArray new];
    }
    return _beginClassListArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    
    [self setAFN];
    
    [self addTableView];
    //在iOS 11上运行tableView向下偏移64px或者20px，因为iOS 11废弃了automaticallyAdjustsScrollViewInsets，而是给UIScrollView增加了contentInsetAdjustmentBehavior属性。避免这个坑的方法是要判断
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
}

- (void) setAFN{
    NSMutableDictionary *paramDic = [NSMutableDictionary new];
    [paramDic setValue:self.watHomeMoreListModel.page forKey:@"page"];
    __weak typeof (self)wself = self;
    [WatHomeMoreListModel asyncPostkApiArticleListSuccessBlock:^(WatHomeMoreListModel *watHomeMoreListModel) {
        __strong typeof (wself)sself = wself;
        if ([wself.watHomeMoreListModel.page isEqualToString:@"1"]) {
            [sself.tableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            
            NSMutableArray *listArr = [NSMutableArray new];
            
            for (int i = 0 ; i < sself.beginClassListArr.count; i ++) {
                [listArr addObject:sself.beginClassListArr[i]];
            }
            for (int a = 0; a < watHomeMoreListModel.beginClassListArr.count; a ++) {
                [listArr addObject:watHomeMoreListModel.beginClassListArr[a]];
            }
            sself.beginClassListArr = listArr;
            
            
            sself.watHomeMoreListModel = watHomeMoreListModel;
            sself.watHomeMoreListModel.page = watHomeMoreListModel.page;
            
            [sself.tableView.mj_footer endRefreshing];
            [sself.tableView reloadData];
        }
        
    } errorBlock:^(NSError *errorResult) {
        [self.tableView.mj_footer endRefreshing];
    } paramDic:paramDic urlStr:kApiEducationActiveList];
}
- (void)addTableView {
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = WatBackColor;
    self.tableView.separatorStyle = NO; //隐藏分割线
    [self.view addSubview:self.tableView];
    
    __weak typeof (self) weakSelf = self;
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf setAFN];
    }];
    
}
#pragma UITableView 三问一答
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.beginClassListArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"Cell";
    HomeClassTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"HomeClassTableViewCell" owner:self options:nil]firstObject];
    }
    [cell reloadDataFor:self.beginClassListArr[indexPath.row]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];// （这种是没有点击后的阴影效果)
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ClassDetailViewController *bookVC = [ClassDetailViewController new];
    bookVC.ios_mark_id = self.beginClassListArr[indexPath.row].class_id;
    bookVC.navTitle = self.beginClassListArr[indexPath.row].title;
    [self.navigationController pushViewController:bookVC animated:YES];
    
}
- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 250;
}

@end
