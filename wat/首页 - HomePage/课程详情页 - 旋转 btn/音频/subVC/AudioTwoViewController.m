//
//  AudioTwoViewController.m
//  wat
//
//  Created by 123 on 2018/6/27.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "AudioTwoViewController.h"
#import "HomeClassesListTableViewCell.h"

//cell跳转页面 音频视频
#import "HomeAudioClassViewController.h"
#import "HomeVideoClassViewController.h"


@interface AudioTwoViewController ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation AudioTwoViewController
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MyKScreenWidth, MyKScreenHeight - MyTopHeight - 44) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addTableView];
    
    
}
- (void) addTableView{
    [self.view addSubview:self.tableView];
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * ID = @"cell";
    
    HomeClassesListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"HomeClassesListTableViewCell" owner:self options:nil]firstObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // [cell reloadDataFor:self.newsListArray[indexPath.row]];
    cell.backgroundColor = [UIColor whiteColor];
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"测试测试测试111111111111");
    //发送通知,停止音频播放  先停止当前播放,然后再进入下一个
    NSNotification *notice = [NSNotification notificationWithName:WatDeallocAudioControllerNotification object:nil];
    [[NSNotificationCenter defaultCenter]postNotification:notice];
    
    if (indexPath.row == 0) {
        
        
        HomeAudioClassViewController *audioVC = [HomeAudioClassViewController new];
        audioVC.hk_iconImage = @"1234567890"; //需要传递 url
        [self.navigationController pushViewController:audioVC animated:YES];
        
    }else{
        
        HomeVideoClassViewController *videoVC = [HomeVideoClassViewController new];
        [self.navigationController pushViewController:videoVC animated:YES];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 84;
}








@end
