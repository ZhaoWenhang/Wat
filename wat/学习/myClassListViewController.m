//
//  myClassListViewController.m
//  wat
//
//  Created by 123 on 2018/6/21.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "myClassListViewController.h"
#import "WatHomeClass01ViewController.h"
#import "OrderDetailViewController.h"
//---------------- cell -----------------
#import "HomeJingXuanClassTableViewCell.h"
#import "HomeClassTableViewCell.h"
//----------------- model -----------
#import "learningYigouClassListMode.h"

@interface myClassListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
//------------ model ------------
@property (nonatomic, strong) NSArray<learningYigouClassDetailModel *> *list;
@property (nonatomic, strong) learningYigouClassListMode *learningYigouClassListM;
@end

@implementation myClassListViewController
- (learningYigouClassListMode *)learningYigouClassListM{
    if (!_learningYigouClassListM) {
        _learningYigouClassListM = [learningYigouClassListMode new];
    }
    return _learningYigouClassListM;
}
- (NSArray<learningYigouClassDetailModel *> *)list{
    if (!_list) {
        _list = [NSArray new];
    }
    return _list;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, MyTopHeight, MyKScreenWidth, MyKScreenHeight - MyTopHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = NO; //隐藏分割线
        
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navTitle = @"学习";
    [self setAFN];
    [self addtableView];
}

- (void) setAFN{

    NSMutableDictionary *paramDic = [NSMutableDictionary new];
    [paramDic setValue:self.typeName forKey:@"type"];
    [paramDic setValue:self.learningYigouClassListM.page forKey:@"page"];
    
    __weak typeof (self) weakSelf = self;
    [learningYigouClassListMode asyncPostSuccessBlock:^(learningYigouClassListMode *learningYigouClassListMode) {
        if ([weakSelf.learningYigouClassListM.page isEqualToString:@"1"]) {
            [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            NSMutableArray *listArr = [NSMutableArray new];
            for (int i = 0 ; i < weakSelf.list.count; i ++) {
                [listArr addObject:weakSelf.list[i]];
            }
            for (int a = 0; a < learningYigouClassListMode.list.count; a ++) {
                [listArr addObject:learningYigouClassListMode.list[a]];
            }
            weakSelf.list = listArr;
            weakSelf.learningYigouClassListM.page = learningYigouClassListMode.page;
            [weakSelf.tableView.mj_footer endRefreshing];
            [weakSelf.tableView reloadData];
        }
        
    } errorBlock:^(NSError *errorResult) {
        [weakSelf.tableView.mj_footer endRefreshing];
    } paramDic:paramDic urlStr:kApiOrderTypePage];
    
}

- (void)addtableView{
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = WatBackColor;
    __weak typeof (self) weakSelf = self;
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf setAFN];
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.list.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * ID = @"cell";
   
    if ([self.typeName isEqualToString:@"0"]) { // 线上
        HomeJingXuanClassTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"HomeJingXuanClassTableViewCell" owner:self options:nil]firstObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell reloadLearningYigouClassListDataFor:self.list[indexPath.row]];
        
        
        
        return cell;
    }else{
        //HomeClassTableViewCell
        HomeClassTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"HomeClassTableViewCell" owner:self options:nil]firstObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell reloadYigouDataFor:self.list[indexPath.row]];
        cell.goBtn.hidden = YES;
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.typeName isEqualToString:@"0"]) {
        
        OrderDetailViewController *orderClassVC = [OrderDetailViewController new];
        [orderClassVC setHidesBottomBarWhenPushed:YES];
        orderClassVC.order_id = self.list[indexPath.row].oid;
        [self.navigationController pushViewController:orderClassVC animated:YES];
    }else{
        OrderDetailViewController *orderClassVC = [OrderDetailViewController new];
        [orderClassVC setHidesBottomBarWhenPushed:YES];
        orderClassVC.order_id = self.list[indexPath.row].oid;
        [self.navigationController pushViewController:orderClassVC animated:YES];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.typeName isEqualToString:@"0"]) {
        return 145;
    }else{
        return 250;
    }
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}





@end
