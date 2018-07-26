//
//  BookListViewController.m
//  wat
//
//  Created by 123 on 2018/6/11.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "BookListViewController.h"
#import "HomeNewsDetailTableViewCell.h"
#import "BookDetailViewController.h"
#import "BookListTableViewCell.h"
#import "WatBookListModel.h"
#import "WatBookDetailModel.h"
@interface BookListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) WatBookDetailModel *watBookDetailModel;

@property (nonatomic, strong) NSArray<WatBookDetailModel *> *bookListArr;
@end

@implementation BookListViewController
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, MyTopHeight, MyKScreenWidth, MyKScreenHeight - 6-MyStatusBarHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//隐藏分割线
    }
    return _tableView;
}
-(WatBookDetailModel *)watBookDetailModel{
    if (!_watBookDetailModel) {
        _watBookDetailModel = [WatBookDetailModel new];
    }
    return _watBookDetailModel;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAFN];
    [self.view addSubview:self.tableView];
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MyKScreenWidth, 6)];
    self.tableView.tableHeaderView = headerView;
    
}
- (void) setAFN{
    __weak typeof (self)wself = self;
    
    [WatBookListModel asyncPostEducationBookListSuccessBlock:^(WatBookListModel *watBookList) {
        wself.bookListArr = watBookList.bookList;
        [self.tableView reloadData];
    } errorBlock:^(NSError *errorResult) {
        
    } paramDic:nil urlStr:kApiEducationBookList];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.bookListArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifer = @"Cell";
    BookListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"BookListTableViewCell" owner:self options:nil]firstObject];
        
        
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BookDetailViewController *vc = [BookDetailViewController new];
    vc.navTitle = @"书籍详情";
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return  200;
}

@end
