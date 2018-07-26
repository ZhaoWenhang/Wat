//
//  TwoViewController.m
//  DoulScro
//
//  Created by wl on 2018/5/22.
//  Copyright © 2018年 https://github.com/orzzh. All rights reserved.
//

#import "TwoViewController.h"

#import "HomeClassesListTableViewCell.h"

//cell跳转页面 音频视频
#import "HomeAudioClassViewController.h"
#import "HomeVideoClassViewController.h"

#import "TwoTUWENViewController.h"

@interface TwoViewController ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) WatHomeClassListDetailModel *watHomeClassListdetailModel;
@end

@implementation TwoViewController
- (WatHomeClassListDetailModel *)watHomeClassListdetailModel{
    if (!_watHomeClassListdetailModel) {
        _watHomeClassListdetailModel = [WatHomeClassListDetailModel new];
    }
    return _watHomeClassListdetailModel;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MyKScreenWidth, MyKScreenHeight - MyTopHeight - 44 - MyTabBarHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
 

- (void)viewDidLoad {
    [super viewDidLoad];

    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self addTableView]; 
    
    
}
- (void) addTableView{
    [self.view addSubview:self.tableView];
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MyKScreenWidth, 0.01)];
    self.tableView.tableHeaderView = headerView;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.list.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * ID = @"cell";

    HomeClassesListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"HomeClassesListTableViewCell" owner:self options:nil]firstObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    [cell reloadDataFor:self.list[indexPath.row]];
    
    if ([self.is_buy isEqualToString:@"1"]) {
        cell.type2Btn.hidden = YES;
        cell.typeLab.hidden = YES;
    }
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.is_buy isEqualToString:@"1"]) {
        
        
        
        //发送通知,停止音频播放  先停止当前播放,然后再进入下一个
        NSNotification *notice = [NSNotification notificationWithName:WatDeallocAudioControllerNotification object:nil];
        [[NSNotificationCenter defaultCenter]postNotification:notice];
        
        self.watHomeClassListdetailModel = self.list[indexPath.row];
        
        if ([self.watHomeClassListdetailModel.goods_type_name isEqualToString:@"图文"] || [self.watHomeClassListdetailModel.goods_type_name isEqualToString:@"专栏"]) {
            
            TwoTUWENViewController *tuwenVC = [TwoTUWENViewController new];
            tuwenVC.watHomeClassListdetailModel = self.watHomeClassListdetailModel;
            [self.navigationController pushViewController:tuwenVC animated:YES];
            
        }else{
            HomeVideoClassViewController *videoVC = [HomeVideoClassViewController new];
            videoVC.typeName = self.watHomeClassListdetailModel.goods_type_name;;
            videoVC.list = self.list;
            videoVC.is_buy = self.is_buy;
            videoVC.watHomeClassListDetailModel = self.list[indexPath.row];
            videoVC.tableViewCellRow = [NSString stringWithFormat:@"%ld",indexPath.row];
            [self.navigationController pushViewController:videoVC animated:YES];
        }
        
    }else{
        if ([self.list[indexPath.row].is_free isEqualToString:@"1"]) {
            //发送通知,停止音频播放  先停止当前播放,然后再进入下一个
            NSNotification *notice = [NSNotification notificationWithName:WatDeallocAudioControllerNotification object:nil];
            [[NSNotificationCenter defaultCenter]postNotification:notice];
            
            self.watHomeClassListdetailModel = self.list[indexPath.row];
            
            if ([self.watHomeClassListdetailModel.goods_type_name isEqualToString:@"图文"] || [self.watHomeClassListdetailModel.goods_type_name isEqualToString:@"专栏"]) {
                
                TwoTUWENViewController *tuwenVC = [TwoTUWENViewController new];
                tuwenVC.watHomeClassListdetailModel = self.watHomeClassListdetailModel;
                [self.navigationController pushViewController:tuwenVC animated:YES];
                
            }else{
                HomeVideoClassViewController *videoVC = [HomeVideoClassViewController new];
                videoVC.typeName = self.watHomeClassListdetailModel.goods_type_name;;
                videoVC.list = self.list;
                videoVC.is_buy = self.is_buy;
                videoVC.watHomeClassListDetailModel = self.list[indexPath.row];
                videoVC.tableViewCellRow = [NSString stringWithFormat:@"%ld",indexPath.row];
                [self.navigationController pushViewController:videoVC animated:YES];
            }
        }else{
            [[ZWHHelper sharedHelper]addAlertViewControllerToView:self withClickBlock:^(int clickInt) {
                if (clickInt == 1) {
                    [[NSNotificationCenter  defaultCenter]postNotificationName:WatOnlineClassesBuy object:nil]; //WatOnlineClassesBuy
                }
            } title:@"提示" content:@"您还没有购买该课程!" cancleStr:@"取消" confirmStr:@"购买"];
        }
    }
    
    
    
    
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 84;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}









@end
