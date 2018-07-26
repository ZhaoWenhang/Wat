//
//  addByClassUserInfoViewController.m
//  wat
//
//  Created by 123 on 2018/7/3.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "addByClassUserInfoViewController.h"
@interface addByClassUserInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ByClassUserModel *byClassUserModel;
@property (nonatomic, strong) WatUserInfoModel *watUserInfoModel;
@end

@implementation addByClassUserInfoViewController
-(ByClassUserModel *)byClassUserModel{
    if (!_byClassUserModel) {
        _byClassUserModel = [ByClassUserModel new];
    }
    return _byClassUserModel;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, MyTopHeight, MyKScreenWidth, MyKScreenHeight - MyTopHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.rightTitles = @[@"保存"];
    

    [self addTableView];
    
    [self addUserInfo];
    
}
- (void) addUserInfo {
    WatUserInfoModel *watUserInfoModel = [WatUserInfoManager getInfo];
    self.watUserInfoModel = watUserInfoModel;
    self.byClassUserModel.name = watUserInfoModel.username;
    self.byClassUserModel.telephone = watUserInfoModel.phone;
    [self.tableView reloadData];
    NSLog(@"%@",self.byClassUserModel.name);
}

- (void)addTableView{
    [self.view addSubview:self.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    
    
    if (indexPath.section == 0) {
        cell.textLabel.text = @"姓名";
        cell.detailTextLabel.text = @"必填";
        
        if (ValidStr(self.byClassUserModel.name)) {
            cell.detailTextLabel.text = self.byClassUserModel.name;
        }
        
    }else if (indexPath.section == 1){
        cell.textLabel.text = @"电话";
        cell.detailTextLabel.text = @"必填";
        if (ValidStr(self.byClassUserModel.telephone)) {
            cell.detailTextLabel.text = self.byClassUserModel.telephone;
        }
    }else if (indexPath.section == 2){
        cell.textLabel.text = @"公司";
        cell.detailTextLabel.text = @"非必填";
        if (ValidStr(self.byClassUserModel.company)) {
            cell.detailTextLabel.text = self.byClassUserModel.company;
        }
    }else{
        cell.textLabel.text = @"职位";
        cell.detailTextLabel.text = @"非必填";
        if (ValidStr(self.byClassUserModel.job)) {
            cell.detailTextLabel.text = self.byClassUserModel.job;
        }
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//显示箭头
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];// （这种是没有点击后的阴影效果)
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 0.01;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    __weak typeof (self)weakSelf = self;
    if (indexPath.section == 0) {
        ZWHTextFildViewController *textFieldVC01 = [ZWHTextFildViewController new];
        textFieldVC01.navTitleStr = @"请输入购买人姓名";
        textFieldVC01.returnByClassUserInfoText = ^(NSString *text) {
            self.byClassUserModel.name = text;
            [weakSelf.tableView reloadData];
        };
        [self.navigationController pushViewController:textFieldVC01 animated:YES];
    }else if (indexPath.section == 1){
        ZWHTextFildViewController *textFieldVC02 = [ZWHTextFildViewController new];
        textFieldVC02.navTitleStr = @"请输入购买人电话";
        textFieldVC02.returnByClassUserInfoText = ^(NSString *text) {
            self.byClassUserModel.telephone = text;
            [weakSelf.tableView reloadData];
        };
        [self.navigationController pushViewController:textFieldVC02 animated:YES];
    }else if (indexPath.section == 2){
        ZWHTextFildViewController *textFieldVC03 = [ZWHTextFildViewController new];
        textFieldVC03.navTitleStr = @"请输入购买人公司";
        textFieldVC03.returnByClassUserInfoText = ^(NSString *text) {
            self.byClassUserModel.company = text;
            [weakSelf.tableView reloadData];
        };
        [self.navigationController pushViewController:textFieldVC03 animated:YES];
    }else if (indexPath.section == 3){
        ZWHTextFildViewController *textFieldVC04 = [ZWHTextFildViewController new];
        textFieldVC04.navTitleStr = @"请输入购买人职位";
        textFieldVC04.returnByClassUserInfoText = ^(NSString *text) {
            self.byClassUserModel.job = text;
            [weakSelf.tableView reloadData];
        };
        [self.navigationController pushViewController:textFieldVC04 animated:YES];
    }
    
    
}


- (void)rightBtnsAction:(UIButton *)button{
    if (ValidStr(self.byClassUserModel.name) && ValidStr(self.byClassUserModel.telephone)) {
        
        if (self.returnByClassUserModel) {
            self.returnByClassUserModel(self.byClassUserModel);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [[ZWHHelper sharedHelper]addAlertViewControllerToView:self withClickBlock:^(int clickInt) {
            
        } title:@"提示" content:@"请输入必填信息" cancleStr:@"" confirmStr:@"确定"];
    }
    
    
}

@end
