//
//  WalletDetailViewController.m
//  wat
//
//  Created by 123 on 2018/6/8.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "WalletDetailViewController.h"
#import "WalletDetailTableViewCell.h"
#import "apppayRecordsListModel.h"
@interface WalletDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<apppayRecordsModel *> *list;
@property (nonatomic, strong) apppayRecordsListModel *apppayRecordsListmodel;
@end

@implementation WalletDetailViewController
-(NSArray<apppayRecordsModel *> *)list{
    if (!_list) {
        _list = [NSArray new];
    }
    return _list;
}
-(apppayRecordsListModel *)apppayRecordsListmodel{
    if (!_apppayRecordsListmodel) {
        _apppayRecordsListmodel = [apppayRecordsListModel new];
    }
    return _apppayRecordsListmodel;
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, MyTopHeight, MyKScreenWidth, MyKScreenHeight - 6 - MyStatusBarHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"全部明细";

    [self setAFN];
    
    [self.view addSubview:self.tableView];
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MyKScreenWidth, 6)];
    self.tableView.tableHeaderView = headerView;
    
//    //刷新
//    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(setAFN)];
//    [self.tableView.mj_header beginRefreshing];
    __weak typeof (self) weakSelf = self;
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf setAFNMoreData];
    }];
    
}
-(void)setAFN {
    
    NSMutableDictionary *paramDic = [NSMutableDictionary new];
    //[paramDic setValue:self.apppayRecordsListmodel.page forKey:@"page"];
    
    __weak typeof (self)weakSelf = self;
    [apppayRecordsListModel asyncPostkApiAppPayUseListSuccessBlock:^(apppayRecordsListModel *apppayRecordsListModel) {
        weakSelf.list = apppayRecordsListModel.list;
        weakSelf.apppayRecordsListmodel.page = apppayRecordsListModel.page;
        
        //[self.tableView.mj_header endRefreshing];
        [weakSelf.tableView reloadData];
    } errorBlock:^(NSError *errorResult) {
        //[self.tableView.mj_header endRefreshing];
    } paramDic:paramDic urlStr:kApiAppPayUseList];
}

- (void) setAFNMoreData {
    

        NSMutableDictionary *paramDic = [NSMutableDictionary new];
        [paramDic setValue:self.apppayRecordsListmodel.page forKey:@"page"];
        
        __weak typeof (self)weakSelf = self;
        [apppayRecordsListModel asyncPostkApiAppPayUseListSuccessBlock:^(apppayRecordsListModel *apppayRecordsListModel) {
            
            
            //<= 1 就没有数据了
                    if ([weakSelf.apppayRecordsListmodel.page isEqualToString:@"1"]) {
                        [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
                    }else{
                        NSMutableArray *historyClassModelMurableArr = [NSMutableArray new];
                        for (int i = 0 ; i < weakSelf.list.count; i ++) {
                            [historyClassModelMurableArr addObject:weakSelf.list[i]];
                        }
                        for (int a = 0; a < apppayRecordsListModel.list.count; a ++) {
                            [historyClassModelMurableArr addObject:apppayRecordsListModel.list[a]];
                        }
                        
                        weakSelf.list  = historyClassModelMurableArr;
                        weakSelf.apppayRecordsListmodel.page = apppayRecordsListModel.page;
                        
                        
                        [weakSelf.tableView.mj_footer endRefreshing];
                        [weakSelf.tableView reloadData];
                    }
        } errorBlock:^(NSError *errorResult) {
            [self.tableView.mj_footer endRefreshing];
        } paramDic:paramDic urlStr:kApiAppPayUseList];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.list.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifer = @"Cell";
    WalletDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"WalletDetailTableViewCell" owner:self options:nil]firstObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell reloadDataFor:self.list[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return  60;
}

@end
