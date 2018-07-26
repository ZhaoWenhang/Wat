//
//  WatMeViewController.m
//  wat
//
//  Created by 123 on 2018/5/22.
//  Copyright © 2018年 wat0801. All rights reserved.
//
#define  kHeaderHeight 260.0 //headerView 高度

#import "WatMeViewController.h"
#import "WHWaterWaveView.h"
#import "WatLoginViewController.h"
#import "MeSettingViewController.h"
/**
 自控制器
 */
#import "MyWalletViewController.h"
#import "AllOrdersViewController.h"
#import "GeneralizeCenterViewController.h"
#import "FeedbackViewController.h"
#import "AboutUsViewController.h"
#import "SettingViewController.h"
#import "MyScholarshipViewController.h"
#import "WatWeiXinPhoneNumLoginViewController.h"
@interface WatMeViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headerView;//tableViewHeaderView
@property (nonatomic, strong) UIButton *userHeadBtn;//用户头像
@property (nonatomic ,strong) UIButton *nameBtn;//用户姓名
@property (nonatomic, strong) NSArray *messageArr; //数据数组

@property (nonatomic, strong) NSString *nameBtnStr; //登陆按钮的名字

//---------------------- model ----------------
@property (nonatomic, strong) WatUserInfoModel *watUserInfoModel;

// 毛玻璃
@property (strong, nonatomic) UIVisualEffectView *effectView;

@end

@implementation WatMeViewController
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MyKScreenWidth, MyKScreenHeight - MyTabBarHeight) style:UITableViewStyleGrouped];
        self.tableView.backgroundColor = WatBackColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        //_tableView.contentInset = UIEdgeInsetsMake(kHeaderHeight + 20, 0, 0, 0);
        
    }
    return  _tableView;
}
- (WatUserInfoModel *)watUserInfoModel{
    if (!_watUserInfoModel) {
        _watUserInfoModel = [WatUserInfoModel new];
    }
    return _watUserInfoModel;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.watUserInfoModel = [WatUserInfoManager getInfo];
    NSLog(@"%@",self.watUserInfoModel.id);
    if ([WatUserInfoManager isLoginUserID]) {
        if (ValidStr(self.watUserInfoModel.nickname)) {
            self.nameBtnStr = self.watUserInfoModel.nickname;
        }else{
            
            if (ValidStr(self.watUserInfoModel.phone)) {
                self.watUserInfoModel.phone = [self.watUserInfoModel.phone stringByReplacingCharactersInRange:NSMakeRange(3, 5)  withString:@"*****"];//手机号星号
                self.nameBtnStr = self.watUserInfoModel.phone;
            }else{
                
            }
            
            
        }
        [self.tableView reloadData];
    }else{
        
        WatLoginViewController *loginVC = [WatLoginViewController new];
        loginVC.pushType = @"present";
        [loginVC setHidesBottomBarWhenPushed:YES];
        [self presentViewController:loginVC animated:YES completion:nil];
    }
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.rightImages = @[@"personSettingIco"];
    self.rightTitles = @[@"编辑"];
    [self addNavigationBar];
    [self addTableView];
    
    
    //界面加载数据
    NSString *path= [[NSBundle mainBundle]pathForResource:@"MEPropertyList" ofType:@"plist"];
    _messageArr = [NSArray arrayWithContentsOfFile:path];
    NSLog(@"%ld",_messageArr.count);
    
    
#pragma 通知
    NSNotificationCenter *notiCenter = [NSNotificationCenter defaultCenter];
    [notiCenter addObserver:self selector:@selector(receiveNotification:) name:WechatLoginAddPhoneNotification object:nil];
    
    
}
- (void)receiveNotification:(NSNotification *)dic{
    NSLog(@"接收传值,并作出相应的操作,刷新 tableView/webView");
    // NSNotification 有三个属性，name, object, userInfo，其中最关键的object就是从第三个界面传来的数据。name就是通知事件的名字， userInfo一般是事件的信息。
    NSMutableDictionary *dataDic = [NSMutableDictionary new];
    dataDic = dic.object;
    
    WatWeiXinPhoneNumLoginViewController *vc = [WatWeiXinPhoneNumLoginViewController new];
    vc.weixinID = dataDic[@"weixinID"];
    vc.navTitle = @"绑定手机号";
    [vc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void) addTableView {
    
    [self.view addSubview:self.tableView];
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 8.0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.separatorStyle = NO; //隐藏分割线
    
    //在iOS 11上运行tableView向下偏移64px或者20px，因为iOS 11废弃了automaticallyAdjustsScrollViewInsets，而是给UIScrollView增加了contentInsetAdjustmentBehavior属性。避免这个坑的方法是要判断
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    
    
    
}
- (void)rightBtnsAction:(UIButton *)button{
    if ([WatUserInfoManager isLoginUserID]) {
        MeSettingViewController *vc = [MeSettingViewController new];
        vc.navTitle = @"个人信息";
        [vc setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        WatLoginViewController *loginVC = [[WatLoginViewController alloc]init];
        [loginVC setHidesBottomBarWhenPushed:YES];
        loginVC.isBackTitle = NO;
        [self.navigationController pushViewController:loginVC animated:YES];
    }
}
- (void) loginBtnClick {
    
    if ([WatUserInfoManager isLoginUserID]) {
        MeSettingViewController *vc = [MeSettingViewController new];
        vc.navTitle = @"个人信息";
        [vc setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        WatLoginViewController *loginVC = [[WatLoginViewController alloc]init];
        [loginVC setHidesBottomBarWhenPushed:YES];
        loginVC.isBackTitle = NO;
        [self.navigationController pushViewController:loginVC animated:YES];
    }
}



#pragma tableView 三问一答
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _messageArr.count;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    NSArray *arr;
    for (int i = 0; i < _messageArr.count; i++) {
        if (section == i) {
            arr = _messageArr[i];
        }
    }
    //NSLog(@"--------%ld",arr.count);
    return arr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.backgroundColor = [UIColor whiteColor];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];// （这种是没有点击后的阴影效果)
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0,  0, MyKScreenWidth, kHeaderHeight)];
        headerView.backgroundColor = [UIColor clearColor];
        headerView.clipsToBounds = YES;//超出部分,裁剪掉
        [cell addSubview:headerView];
        
        //水波滚动
        WHWaterWaveView *waveView2 = [[WHWaterWaveView alloc] initWithFrame:CGRectMake(0, 0, MyKScreenWidth, kHeaderHeight - 45)];
        [headerView addSubview:waveView2];
        
        //判断登陆与否,填数据
        
        
        CGFloat btnWidth = 80;
        UIButton *userHeadBtn = [[UIButton alloc]initWithFrame:CGRectMake(MyKScreenWidth * 0.5 - btnWidth/2 , MyStatusBarHeight + 40, btnWidth, btnWidth)];
        self.userHeadBtn = userHeadBtn;
        userHeadBtn.imageView.contentMode = 2;
        userHeadBtn.layer.cornerRadius = btnWidth/2;
        userHeadBtn.layer.borderColor = [[UIColor whiteColor]CGColor];
        userHeadBtn.layer.borderWidth = 1.0f;
        userHeadBtn.layer.masksToBounds = YES;// 这个属性很重要，把超出边框的部分去除
        
        if (ValidStr(self.watUserInfoModel.head_pic)) {
            [self.userHeadBtn sd_setImageWithURL:[NSURL URLWithString:self.watUserInfoModel.head_pic] forState:UIControlStateNormal];
        }else{
            [userHeadBtn setImage:[UIImage imageNamed:@"headerPic00"] forState:UIControlStateNormal];
        }
        [userHeadBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:userHeadBtn];
        
        
        UIButton *nameBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, MyKScreenWidth, 40)];
        self.nameBtn = nameBtn;
        nameBtn.center = Center(MyKScreenWidth / 2, CGRectGetMaxY(self.userHeadBtn.frame) + 20);
        [nameBtn setTitle:self.nameBtnStr forState: UIControlStateNormal];
        [nameBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:nameBtn];
    }else{
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
        
        
        NSString *imgName;
        NSArray *arr = _messageArr[indexPath.section];
        NSDictionary *dic = arr[indexPath.row];
        imgName = [dic valueForKey:@"cellIconName"];
        UIImage *image = [UIImage imageNamed:imgName];
        cell.imageView.image = image;
        
        cell.textLabel.text = [dic valueForKey:@"cellName"];
        cell.textLabel.font = commenAppFont(16);
        cell.textLabel.textColor = [UIColor grayColor];
        
        CGSize itemSize = CGSizeMake(20, 20);
        UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
        CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
        [cell.imageView.image drawInRect:imageRect];
        cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        cell.imageView.contentMode = 2;
        
        UIView *fengeView = [[UIView alloc]initWithFrame:CGRectMake(0, cell.frame.size.height - 0.5, MyKScreenWidth, 0.5)];
        fengeView.backgroundColor = [UIColor grayColor];
        fengeView.alpha = 0.2;
        [cell addSubview:fengeView];
    }
    
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSLog(@"点击了登录注册");
    if (indexPath.section == 1 && indexPath.row == 0) {
        if ([WatUserInfoManager isLoginUserID]) {
            MyWalletViewController *walletVC = [[MyWalletViewController alloc]init];
            [walletVC setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:walletVC animated:YES];
        }else{
            WatLoginViewController *loginVC = [WatLoginViewController new];
            [loginVC setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:loginVC animated:YES];
            
        }
        
    }else if (indexPath.section == 1 && indexPath.row == 1) {
        MyScholarshipViewController *walletVC = [[MyScholarshipViewController alloc]init];
        [walletVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:walletVC animated:YES];
    }else if (indexPath.section == 1 && indexPath.row == 1) {
        GeneralizeCenterViewController *genralizeVC = [[GeneralizeCenterViewController alloc]init];
        [genralizeVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:genralizeVC animated:YES];
    }else if (indexPath.section == 2 && indexPath.row == 0) {
        FeedbackViewController *feedVC = [[FeedbackViewController alloc]init];
        [feedVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:feedVC animated:YES];
    }else if (indexPath.section == 2 && indexPath.row == 1) {
        AboutUsViewController *aboutUsVC = [[AboutUsViewController alloc]init];
        [aboutUsVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:aboutUsVC animated:YES];
    }else if (indexPath.section == 2 && indexPath.row == 2) {
        SettingViewController *settingVC = [[SettingViewController alloc]init];
        [settingVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:settingVC animated:YES];
        
    }
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return kHeaderHeight;
    }else{
        
        return 44;
    }
    
}
- (CGFloat )tableView:(  UITableView *)tableView heightForHeaderInSection:( NSInteger )section
{
    return 0.01 ;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    NSLog(@"%lf",offsetY);
    
    if (offsetY > 0) {
        self.navBarView.alpha = (offsetY)/MyTopHeight;
        self.navTitle = @"个人中心";
    }else if (offsetY < 0){
        self.navTitle = @"个人中心";
        self.navBarView.alpha = -(offsetY)/MyTopHeight;
    }else {
        
        self.navBarView.alpha = 0;
        self.navTitle = @"";
    }
    
    
}
- (void)addNavigationBar{
    self.isBackTitle = YES;
    self.navBarView.alpha = 0;
    self.navTitle = @"";
    
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];//移除通知
    
}
@end
