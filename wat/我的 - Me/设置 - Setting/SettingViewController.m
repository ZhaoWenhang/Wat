//
//  SettingViewController.m
//  wat
//
//  Created by 123 on 2018/5/29.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "SettingViewController.h"
#import "AboutUsViewController.h"
#import "WatLoginViewController.h"
#import "SettingSwitPhoneNumberViewController.h"
#import "WatWeiXinPhoneNumLoginViewController.h"
@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *messageArr;//cell数据源

@property (nonatomic, strong)NSString *moneyStr;
@end

@implementation SettingViewController
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, MyTopHeight, MyKScreenWidth, MyKScreenHeight - MyTopHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = NO; //隐藏分割线
        //_tableView.contentInset = UIEdgeInsetsMake(160, 0, 0, 0);
    }
    return _tableView;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WatBackColor;
    self.navTitle = @"设置";
    
    
    
    //界面加载数据
    NSString *path= [[NSBundle mainBundle]pathForResource:@"set" ofType:@"plist"];
    _messageArr = [NSArray arrayWithContentsOfFile:path];
    
    
    [self addTableView];
    
    
}

- (void) addTableView {
    [self.view addSubview:self.tableView];
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 8.0;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    
}
#pragma 三问一答
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _messageArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray *arr;
    for (int i = 0; i < _messageArr.count; i++) {
        if (section == i) {
            arr = _messageArr[i];
        }
    }
    //NSLog(@"--------%ld",arr.count);
    return arr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.backgroundColor = [UIColor whiteColor];
        
    }
    
    
        NSArray *arr = _messageArr[indexPath.section];
        NSDictionary *dic = arr[indexPath.row];
    
    
    if (indexPath.section == _messageArr.count - 1 && indexPath.row == arr.count - 1) { //单独把退出按钮拉出来
        UILabel *logoutLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, MyKScreenWidth, CGRectGetHeight(cell.frame))];
        logoutLab.text = [dic valueForKey:@"cellName"];
        logoutLab.font = commenAppFont(18);
        logoutLab.textColor = [UIColor redColor];
        logoutLab.textAlignment  = NSTextAlignmentCenter;
        [cell addSubview:logoutLab];
    }else{
        UIView *fengeLineView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(cell.frame) - 1, MyKScreenWidth, 1)];
        fengeLineView.backgroundColor = WatBackColor;
        [cell addSubview:fengeLineView];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
        cell.textLabel.text = [dic valueForKey:@"cellName"];
        cell.textLabel.font = commenAppFont(16);
        cell.textLabel.textColor = [UIColor darkGrayColor];
        
        
        if (indexPath.section == 0 && indexPath.row == 0) {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%0.2lfM",self.folderSize];
        }
        if (indexPath.section == 0 && indexPath.row == 2) {
            if ([WatUserInfoManager isLogin]) {
                cell.textLabel.text = @"变更手机号";
            }
            
        }
    }
    
    
    
    
    
    
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        NSLog(@"%ld++++%ld",indexPath.section,indexPath.row);
        [[ZWHHelper sharedHelper]addAlertViewControllerToView:self withClickBlock:^(int clickInt) {
            if (clickInt == 1) {
                [self removeCache];
            }
        } title:@"提示" content:@"确认清除缓存?" cancleStr:@"取消" confirmStr:@"确认"];
    
    }else if (indexPath.section == 0 && indexPath.row == 1){
        NSLog(@"%ld++++%ld",indexPath.section,indexPath.row);
        AboutUsViewController *aboutUsVC = [[AboutUsViewController alloc]init];
        [self.navigationController pushViewController:aboutUsVC animated:YES];
    }else if (indexPath.section == 0 && indexPath.row == 2){
        if ([WatUserInfoManager isLogin]) {
            //绑定手机号
            SettingSwitPhoneNumberViewController *switchPhoneNumberVC = [SettingSwitPhoneNumberViewController new];
            [self.navigationController pushViewController:switchPhoneNumberVC animated:YES];
        }else{
            WatWeiXinPhoneNumLoginViewController *changePhoneVC = [WatWeiXinPhoneNumLoginViewController new];
            changePhoneVC.navTitle = @"绑定手机号";
            changePhoneVC.isChangePhoneNum = YES;
            [self.navigationController pushViewController:changePhoneVC animated:YES];
        }
        
        
    }else if (indexPath.section == 1 && indexPath.row == 0){
        [[ZWHHelper sharedHelper]addAlertViewControllerToView:[ZWHHelper rootTabbarViewController] withClickBlock:^(int clickInt) {
            if (clickInt == 1) {
                [WatUserInfoManager deleteInfo];
                
                WatLoginViewController *loginVC = [WatLoginViewController new];
                loginVC.pushType = @"present";
                [self presentViewController:loginVC animated:YES completion:nil];
            }
        } title:@"确定退出?" content:@"" cancleStr:@"取消" confirmStr:@"确定"];
        
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
}
// 缓存大小
- (CGFloat)folderSize{
    CGFloat folderSize;
    
    //获取路径
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES)firstObject];
    
    //获取所有文件的数组
    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachePath];
    
    NSLog(@"文件数：%ld",files.count);
    
    for(NSString *path in files) {
        
        NSString*filePath = [cachePath stringByAppendingString:[NSString stringWithFormat:@"/%@",path]];
        
        //累加
        folderSize += [[NSFileManager defaultManager]attributesOfItemAtPath:filePath error:nil].fileSize;
    }
    //转换为M为单位
    CGFloat sizeM = folderSize /1024.0/1024.0;
    
    return sizeM;
}
- (void)removeCache{
    //===============清除缓存==============
    //获取路径
    NSString*cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES)objectAtIndex:0];
    
    //返回路径中的文件数组
    NSArray*files = [[NSFileManager defaultManager]subpathsAtPath:cachePath];
    
    NSLog(@"文件数：%ld",[files count]);
    for(NSString *p in files){
        NSError*error;
        
        NSString*path = [cachePath stringByAppendingString:[NSString stringWithFormat:@"/%@",p]];
        
        if([[NSFileManager defaultManager]fileExistsAtPath:path])
        {
            BOOL isRemove = [[NSFileManager defaultManager]removeItemAtPath:path error:&error];
            if(isRemove) {
                //这里发送一个通知给外界，外界接收通知，可以做一些操作（比如UIAlertViewController）
                [WATHud showSuccess:@"清除成功!"];
                [self.tableView reloadData];
            }else{
                [WATHud showSuccess:@"清除失败!"];
                
            }
        }
    }
}

@end


