//
//  VideoTwoViewController.m
//  wat
//
//  Created by 123 on 2018/6/27.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "VideoTwoViewController.h"
#import "HomeClassesListTableViewCell.h"

//cell跳转页面 音频视频
#import "HomeAudioClassViewController.h"
#import "HomeVideoClassViewController.h"
#import "TwoTUWENViewController.h"

@interface VideoTwoViewController ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) WatHomeClassListDetailModel *watHomeClassListDetailModel;
@end

@implementation VideoTwoViewController
- (WatHomeClassListDetailModel *)watHomeClassListDetailModel{
    if (!_watHomeClassListDetailModel) {
        _watHomeClassListDetailModel = [WatHomeClassListDetailModel new];
    }
    return _watHomeClassListDetailModel;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MyKScreenWidth, MyKScreenHeight -  MyStatusBarHeight - 44 - MyKScreenWidth * 0.5) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    //self.navigationController.navigationBarHidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
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
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *rowStr = [NSString stringWithFormat:@"%ld",indexPath.row];
    NSLog(@"===============%ld",indexPath.row);
    if ([self.is_buy isEqualToString:@"1"]) {
        self.watHomeClassListDetailModel = self.list[indexPath.row];
        //需要的值:  web:url   视频音频 url  typeName :类型 1专栏 2图文 3音频 4 视频
        
        //发送通知,停止音频播放  先停止当前播放,然后再进入下一个
        NSNotification *notice = [NSNotification notificationWithName:WatDeallocAudioControllerNotification object:nil];
        [[NSNotificationCenter defaultCenter]postNotification:notice];
        
        //发送通知停止当前可能播放的音频视频
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        //发送通知 刷新播放器 数据源
        if ([self.watHomeClassListDetailModel.goods_type_name isEqualToString:@"视频"] || [self.watHomeClassListDetailModel.goods_type_name isEqualToString:@"音频"]) {
            
            NSString *webUrl = self.watHomeClassListDetailModel.url;
            NSString *typeNameStr = self.watHomeClassListDetailModel.goods_type_name;
            
            NSMutableDictionary *dataSouceDic = [NSMutableDictionary new];
            NSString *dataSourceUrl;
            if ([self.watHomeClassListDetailModel.goods_type_name isEqualToString:@"视频"]) {
                dataSourceUrl = self.watHomeClassListDetailModel.video_path;
            }else if ([self.watHomeClassListDetailModel.goods_type_name isEqualToString:@"音频"]){
                dataSourceUrl = self.watHomeClassListDetailModel.audio_path;
            }
            [dataSouceDic setObject:dataSourceUrl forKey:@"url"];
            [dataSouceDic setObject:typeNameStr forKey:@"typeName"];
            [dataSouceDic setObject:webUrl forKey:@"webUrl"];
            [dataSouceDic setObject:[NSString stringWithFormat:@"%ld",indexPath.row] forKey:@"tableViewCellRow"];
            [dataSouceDic setObject:self.watHomeClassListDetailModel.title forKey:@"VideoTitel"];
            
            [center postNotificationName:WatRefeshAudioOrVideoDataNotification object:dataSouceDic userInfo:nil];
        }else{
            TwoTUWENViewController *tuwenVC = [TwoTUWENViewController new];
            tuwenVC.watHomeClassListdetailModel = self.watHomeClassListDetailModel;
            [self.navigationController pushViewController:tuwenVC animated:YES];
        }
    }else{
        if ([self.list[indexPath.row].is_free isEqualToString:@"1"]) {
            self.watHomeClassListDetailModel = self.list[indexPath.row];
            //需要的值:  web:url   视频音频 url  typeName :类型 1专栏 2图文 3音频 4 视频
            
            //发送通知,停止音频播放  先停止当前播放,然后再进入下一个
            NSNotification *notice = [NSNotification notificationWithName:WatDeallocAudioControllerNotification object:nil];
            [[NSNotificationCenter defaultCenter]postNotification:notice];
            
            //发送通知停止当前可能播放的音频视频
            NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
            //发送通知 刷新播放器 数据源
            if ([self.watHomeClassListDetailModel.goods_type_name isEqualToString:@"视频"] || [self.watHomeClassListDetailModel.goods_type_name isEqualToString:@"音频"]) {
                
                NSString *webUrl = self.watHomeClassListDetailModel.url;
                NSString *typeNameStr = self.watHomeClassListDetailModel.goods_type_name;
                
                NSMutableDictionary *dataSouceDic = [NSMutableDictionary new];
                NSString *dataSourceUrl;
                if ([self.watHomeClassListDetailModel.goods_type_name isEqualToString:@"视频"]) {
                    dataSourceUrl = self.watHomeClassListDetailModel.video_path;
                }else if ([self.watHomeClassListDetailModel.goods_type_name isEqualToString:@"音频"]){
                    dataSourceUrl = self.watHomeClassListDetailModel.audio_path;
                }
                
                [dataSouceDic setObject:dataSourceUrl forKey:@"url"];
                [dataSouceDic setObject:typeNameStr forKey:@"typeName"];
                [dataSouceDic setObject:webUrl forKey:@"webUrl"];
                [dataSouceDic setObject:[NSString stringWithFormat:@"%ld",indexPath.row] forKey:@"tableViewCellRow"];
                [center postNotificationName:WatRefeshAudioOrVideoDataNotification object:dataSouceDic userInfo:nil];
            }else{
                TwoTUWENViewController *tuwenVC = [TwoTUWENViewController new];
                tuwenVC.watHomeClassListdetailModel = self.watHomeClassListDetailModel;
                [self.navigationController pushViewController:tuwenVC animated:YES];
            }
        }else{
            [WATHud showError:@"您还没有购买该课程!"];
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

