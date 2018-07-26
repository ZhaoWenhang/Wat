//
//  WatLearningViewController.m
//  wat
//
//  Created by 123 on 2018/6/21.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "WatLearningViewController.h"
#import "HorScorllView.h"//书籍轮播图

//------------------ controller ---------------
#import "myClassListViewController.h"
#import "WatLoginViewController.h"
#import "WatHomeClass01ViewController.h"
#import "WatAlreadyBoughtCourseViewController.h"
//------------------ cell --------------------
#import "latelyClassTableViewCell.h"
#import "myclassTableViewCell.h"

//--------------- model -------------------
#import "WatLearningHomeModel.h"

@interface WatLearningViewController ()<UITableViewDelegate,UITableViewDataSource,HorScorllViewImageClickDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *loginBGVIew;
@property (nonatomic, strong) HorScorllView *horScorllView;
@property (nonatomic, strong) UIView *checkMoreDataBGVIew;


//------------- model ---------------
@property (nonatomic, strong) WatLearningHomeModel *watLearningHomeModel;
@property (nonatomic, strong) learningHistoryClassModel *learningHistoryClassModel;
@property (nonatomic, strong) learningYigouClassDetailModel *learningYigouClassDetailModel;
@property (nonatomic, strong) learningHistoryClassDetailModel *learningHistoryClassDetailModel;

@property (nonatomic, strong) NSArray<learningYigouClassDetailModel *> *yigouClassModelArr;
@property (nonatomic, strong) NSArray<learningHistoryClassDetailModel *> *historyClassModelArr;

@end

@implementation WatLearningViewController
- (WatLearningHomeModel *)watLearningHomeModel{
    if (!_watLearningHomeModel) {
        _watLearningHomeModel = [WatLearningHomeModel new];
    }
    return _watLearningHomeModel;
}
-(learningHistoryClassModel *)learningHistoryClassModel{
    if (!_learningHistoryClassModel) {
        _learningHistoryClassModel = [learningHistoryClassModel new];
    }
    return _learningHistoryClassModel;
}
- (NSArray<learningYigouClassDetailModel *> *)yigouClassModelArr{
    if (!_yigouClassModelArr) {
        _yigouClassModelArr = [NSArray new];
    }
    return _yigouClassModelArr;
}
-(NSArray<learningHistoryClassDetailModel *> *)historyClassModelArr{
    if (!_historyClassModelArr) {
        _historyClassModelArr = [NSArray new];
    }
    return _historyClassModelArr;
}
-(UIView *)loginBGVIew{
    if (!_loginBGVIew) {
        _loginBGVIew =  [[UIView alloc]initWithFrame:CGRectMake(0, 0, MyKScreenWidth, MyKScreenHeight)];
    }
    return _loginBGVIew;
}
- (UIView *)checkMoreDataBGVIew{
    if (!_checkMoreDataBGVIew) {
        _checkMoreDataBGVIew = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MyKScreenWidth, MyKScreenHeight)];
    }
    return _checkMoreDataBGVIew;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, MyTopHeight, MyKScreenWidth, MyKScreenHeight - MyTopHeight - MyTabBarHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = NO; //隐藏分割线
        
    }
    return _tableView;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    if ([WatUserInfoManager isLoginUserID]) {
        
        self.loginBGVIew.hidden = YES;
        self.tableView.hidden = NO;
        if (self.yigouClassModelArr.count == 0) {
            self.checkMoreDataBGVIew.hidden = NO;
        }else{
            self.checkMoreDataBGVIew.hidden = YES;
            
        }
    }else{
        self.tableView.hidden = YES;
        self.loginBGVIew.hidden = NO;
        self.checkMoreDataBGVIew.hidden = YES;
        
        WatLoginViewController *loginVC = [WatLoginViewController new];
        loginVC.pushType = @"present";
        [self presentViewController:loginVC animated:YES completion:nil];
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navTitle = @"学习";
    self.isBackTitle = YES;
    
    [self addtableView];
    [self addNODataView];
    [self addGoLoginView];
}
- (void)setAFN{
    if ([WatUserInfoManager isLoginUserID]) {
        NSMutableDictionary *paramDic = [NSMutableDictionary new];
        
        __weak typeof (self)wself = self;
        [WatLearningHomeModel asyncPostWatLearningHomeModelSuccessBlock:^(WatLearningHomeModel *watLearningHomeModel) {
            
            __strong typeof (wself)sself = wself;
            sself.yigouClassModelArr = watLearningHomeModel.yigouClass.list;
            sself.historyClassModelArr = watLearningHomeModel.historyClass.list;
            sself.learningHistoryClassModel.page = watLearningHomeModel.historyClass.page;
            [self.tableView.mj_footer beginRefreshing]; //因为走了endRefreshingWithNoMoreData ,所以需要重新刷新
            [self.tableView.mj_header endRefreshing];
            [self.tableView reloadData];
            
            if ([WatUserInfoManager isLoginUserID]) {
                
                self.loginBGVIew.hidden = YES;
                self.tableView.hidden = NO;
                if (self.yigouClassModelArr.count == 0) {
                    self.checkMoreDataBGVIew.hidden = NO;
                }else{
                    self.checkMoreDataBGVIew.hidden = YES;
                    
                }
            }else{
                self.tableView.hidden = YES;
                self.loginBGVIew.hidden = NO;
                self.checkMoreDataBGVIew.hidden = YES;
            }
            
        } errorBlock:^(NSError *errorResult) {
            
            [self.tableView.mj_header endRefreshing];
            
        } paramDic:paramDic urlStr:kApiOrderMyClass];
    }
}

- (void)loadMoreHistoryData{
    NSMutableDictionary *paramDic = [NSMutableDictionary new];
    if (self.learningHistoryClassModel.page != nil) {
        [paramDic setObject:self.learningHistoryClassModel.page forKey:@"page"];
    }
    __weak typeof (self)wself = self;
    [WatLearningHomeModel asyncPostWatLearningHomeModelSuccessBlock:^(WatLearningHomeModel *watLearningHomeModel) {
        
        __strong typeof (wself)sself = wself;
        
        if ([sself.learningHistoryClassModel.page isEqualToString:@"1"]) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            NSMutableArray *historyClassModelMurableArr = [NSMutableArray new];
            for (int i = 0 ; i < sself.historyClassModelArr.count; i ++) {
                [historyClassModelMurableArr addObject:sself.historyClassModelArr[i]];
            }
            for (int a = 0; a < watLearningHomeModel.historyClass.list.count; a ++) {
                [historyClassModelMurableArr addObject:watLearningHomeModel.historyClass.list[a]];
            }
            
            sself.historyClassModelArr  = historyClassModelMurableArr;
            sself.learningHistoryClassModel.page = watLearningHomeModel.historyClass.page;
             [self.tableView.mj_footer endRefreshing];
        }
        
        [self.tableView reloadData];
        
    } errorBlock:^(NSError *errorResult) {
        
        [self.tableView.mj_footer endRefreshing];
        
    } paramDic:paramDic urlStr:kApiOrderMyHistory];
    
}

- (void)addGoLoginView{
    UIView *loginBGVIew = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MyKScreenWidth, MyKScreenHeight)];
    self.loginBGVIew = loginBGVIew;
    [self.view addSubview:loginBGVIew];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, MyKScreenWidth, 300)];
    imageView.image = [UIImage imageNamed:@"空空如也"];
    imageView.contentMode = 1;
    imageView.center =Center(MyKScreenWidth * 0.5, MyTopHeight + 30 + CGRectGetHeight(imageView.frame) * 0.5);
    [loginBGVIew addSubview:imageView];
    
    UIButton *loginbtn= [[UIButton alloc]initWithFrame:CGRectMake(0, 0, MyKScreenWidth * 0.3, 40)];
    loginbtn.center = Center(MyKScreenWidth * 0.5, CGRectGetMaxY(imageView.frame));
    [loginbtn setTitle:@"登陆" forState: UIControlStateNormal];
    loginbtn.titleLabel.font = commenAppFont(12);
    [loginbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginbtn.backgroundColor = CommonAppColor;
    loginbtn.layer.cornerRadius = 10;
    loginbtn.clipsToBounds = YES;
    [self.loginBGVIew addSubview:loginbtn];
    [loginbtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
}
- (void)addNODataView{
    [self.tableView addSubview:self.checkMoreDataBGVIew];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 200, 100)];
    imageView.image = [UIImage imageNamed:@"暂无内容"];
    imageView.contentMode = 2;
    imageView.center =Center(MyKScreenWidth * 0.5, MyTopHeight + 50 + 100 / 2);
    [self.checkMoreDataBGVIew addSubview:imageView];
    
    UIButton *checkMoreDataBtn= [[UIButton alloc]initWithFrame:CGRectMake(0, 0, MyKScreenWidth * 0.3, 40)];
    checkMoreDataBtn.center = Center(MyKScreenWidth * 0.5, CGRectGetMaxY(imageView.frame) + 100);
    [checkMoreDataBtn setTitle:@"查看更多精彩内容" forState: UIControlStateNormal];
    checkMoreDataBtn.titleLabel.font = commenAppFont(12);
    [checkMoreDataBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    checkMoreDataBtn.backgroundColor = CommonAppColor;
    checkMoreDataBtn.layer.cornerRadius = 10;
    checkMoreDataBtn.clipsToBounds = YES;
    [self.checkMoreDataBGVIew addSubview:checkMoreDataBtn];
    [checkMoreDataBtn addTarget:self action:@selector(checkMoreDataBtnClick) forControlEvents:UIControlEventTouchUpInside];
}
- (void)addtableView{
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = WatBackColor;
    
    //刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(setAFN)];
    if ([WatUserInfoManager isLoginUserID]) {
        [self.tableView.mj_header beginRefreshing];
    }
    __weak typeof (self) weakSelf = self;
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreHistoryData];
    }];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (self.historyClassModelArr.count == 0) {
        return 1;
    }else{
        return 2;
    }
    
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        if (self.yigouClassModelArr.count == 0) {
            return 0;
        }else{
           return 1; //因为是 一个 cell 的滚动图,所以是 1
        }
    }else{
        return self.historyClassModelArr.count;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * ID = @"cell";
    if (indexPath.section == 0) {
        myclassTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"myclassTableViewCell" owner:self options:nil]firstObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        
        //cell.contentView.backgroundColor = [UIColor whiteColor];

            NSMutableArray *imagesArr = [[NSMutableArray alloc]init];
            NSMutableArray *titleArr = [[NSMutableArray alloc]init];
            NSMutableArray *priceArr = [[NSMutableArray alloc]init];
            NSMutableArray *typeImgArr = [[NSMutableArray alloc]init];
            for (int i = 0; i < self.yigouClassModelArr.count; i ++) {
                learningYigouClassDetailModel *learningYigouClassDetailModel = self.yigouClassModelArr[i];
                [imagesArr addObject:learningYigouClassDetailModel.thumb_path];
                [titleArr addObject:learningYigouClassDetailModel.title];
                [priceArr addObject:learningYigouClassDetailModel.price];
                [typeImgArr addObject:learningYigouClassDetailModel.content_type];
            }
            
            _horScorllView = [[HorScorllView alloc] initWithFrame:CGRectMake(0, 0, MyKScreenWidth, 200)];
            _horScorllView.section = 0;
            _horScorllView.images = imagesArr;
            _horScorllView.titles = titleArr;
            _horScorllView.typeImgs = typeImgArr;
            _horScorllView.moneylab.hidden = YES;
            _horScorllView.delegate = self;
            [cell addSubview:_horScorllView];
        return cell;
    }else{
        latelyClassTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"latelyClassTableViewCell" owner:self options:nil]firstObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell reloadDataFor:self.historyClassModelArr[indexPath.row]];
        
        
        
        return cell;
        
    }
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (self.yigouClassModelArr.count == 0) {
            return 0;
        }else{
            return 200;
        }
    }else{
        if (self.historyClassModelArr.count == 0) {
            return 0;
        }else{
            return 89;
        }
    }
    
}
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        // 添加一个删除按钮
        UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"查看更多课程"handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
            WatAlreadyBoughtCourseViewController *classDetailVC = [[WatAlreadyBoughtCourseViewController alloc]init];
            //self.navigationController.navigationBarHidden = NO;
            [classDetailVC setHidesBottomBarWhenPushed:YES];
            classDetailVC.navigationController.navigationBarHidden = NO;
            [self.navigationController pushViewController: classDetailVC animated:YES];
            
        }];
        deleteRowAction.backgroundColor = CommonAppColor;
        
        //deleteRowAction.backgroundEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        
        
        
        // 将设置好的按钮放到数组中返回 有几个 就添加几个，但是要注意添加顺序
        return @[deleteRowAction];
    }else{
        // 添加一个删除按钮
        UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除"handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
            if ([WatUserInfoManager isLoginUserID]) {
                NSString *str;
                str = [NSString stringWithFormat:@"确认删除该条听课记录?"];
                [[ZWHHelper sharedHelper]addAlertViewControllerToView:[ZWHHelper rootTabbarViewController] withClickBlock:^(int clickInt) {
                    if (clickInt == 0) {
                        
                    }else{
                        //执行删除操作
                        NSMutableDictionary *paramDic = [NSMutableDictionary new];
                        NSString *listStr = self.historyClassModelArr[indexPath.row].id;
                        [paramDic setObject:listStr forKey:@"list"];
                        [WatLearningHomeModel asyncPostDeleteHistorySuccessBlock:^(WatLearningHomeModel *watLearningHomeModel) {
                            
                        } errorBlock:^(NSError *errorResult) {
                            
                        } paramDic:paramDic urlStr:kApiOrderDeleteHistory];
                        
                        [self.tableView.mj_header beginRefreshing];
                        
                        //[self.tableView reloadData];
                    }
                    
                } title:@"提示" content:str cancleStr:@"取消" confirmStr:@"确认"];
            }
            
            
        }];
        deleteRowAction.backgroundColor = CommonAppColor;
        
        //deleteRowAction.backgroundEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        
        
        
        // 将设置好的按钮放到数组中返回 有几个 就添加几个，但是要注意添加顺序
        return @[deleteRowAction];
    }
    
}
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.section == 1) {
//        if ([WatUserInfoManager isLogin]) {
//            NSString *str;
//            str = [NSString stringWithFormat:@"确认删除该条听课记录?"];
//            [[ZWHHelper sharedHelper]addAlertViewControllerToView:[ZWHHelper rootTabbarViewController] withClickBlock:^(int clickInt) {
//                if (clickInt == 0) {
//
//                }else{
//                    //执行删除操作
//                    NSMutableDictionary *paramDic = [NSMutableDictionary new];
//                    NSString *listStr = self.historyClassModelArr[indexPath.row].id;
//                    [paramDic setObject:listStr forKey:@"list"];
//                    [WatLearningHomeModel asyncPostDeleteHistorySuccessBlock:^(WatLearningHomeModel *watLearningHomeModel) {
//
//                    } errorBlock:^(NSError *errorResult) {
//
//                    } paramDic:paramDic urlStr:kApiOrderDeleteHistory];
//
//                    [self.tableView.mj_header beginRefreshing];
//
//                    //[self.tableView reloadData];
//                }
//
//            } title:@"提示" content:str cancleStr:@"取消" confirmStr:@"确认"];
//        }
//    }else{
//
//    }
//}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSString *btnName ;
    NSString *editBtnName;
    if (section == 0) {
        btnName = @"我的课程";
        editBtnName = @"查看全部";        
    }else{
        btnName = @"最近听课";
        editBtnName = @"清空记录";
    }
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MyKScreenWidth, 64)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UIView *fenggeLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MyKScreenWidth, 8)];
    fenggeLine.backgroundColor = WatBackColor;
    
    
    UILabel *headerTitleLab = [[UILabel alloc]initWithFrame:CGRectMake(14, 30, 100, 24)];
    headerTitleLab.text = btnName;
    headerTitleLab.font = biaotiAppFont(24);
    headerTitleLab.textColor = [UIColor blackColor];
    headerTitleLab.textAlignment = NSTextAlignmentLeft;
    
    
    UIButton *moreBtn = [[UIButton alloc]initWithFrame:CGRectMake(MyKScreenWidth - 71, 30 + 13, 60, 14)];
    [moreBtn setTitle:editBtnName forState: UIControlStateNormal];
    [moreBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    moreBtn.titleLabel.font = zhengwenAppFont(14);
    moreBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    moreBtn.tag = section;
    [moreBtn addTarget:self action:@selector(addMoreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    if (section == 0) {
        if (self.yigouClassModelArr.count != 0) {
            [headerView addSubview:fenggeLine];
            [headerView addSubview:headerTitleLab];
            [headerView addSubview:moreBtn];
        }
    }else{
        if (self.historyClassModelArr.count != 0) {
            [headerView addSubview:fenggeLine];
            [headerView addSubview:headerTitleLab];
        }
    }
    return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        if (self.yigouClassModelArr.count == 0) {
            return 0.01;
        }else{
            return 40 + 10 + 20;
        }
    }else{
        if (self.historyClassModelArr.count == 0) {
            return 0.01;
        }else{
            return 40 + 10 + 20;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ( indexPath.section == 1) {
        WatHomeClass01ViewController *class01VC = [WatHomeClass01ViewController new];
        [class01VC setHidesBottomBarWhenPushed:YES];
        class01VC.id = self.historyClassModelArr[indexPath.row].pid;
        [self.navigationController pushViewController:class01VC animated:YES];
    }
}
- (void) addMoreBtnClick:(UIButton *)sender {
    NSLog(@"%ld",sender.tag);
    if (sender.tag == 0) {
        myClassListViewController *vc = [myClassListViewController new];
        vc.typeName = @"0";
        [vc setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [[ZWHHelper sharedHelper]addAlertViewControllerToView:[ZWHHelper rootTabbarViewController] withClickBlock:^(int clickInt) {
            if (clickInt == 0) {
                
            }else{
                NSMutableDictionary *paramDic = [NSMutableDictionary new];
                [paramDic setObject:@"*" forKey:@"list"];
                [WatLearningHomeModel asyncPostDeleteHistorySuccessBlock:^(WatLearningHomeModel *watLearningHomeModel) {
                    
                } errorBlock:^(NSError *errorResult) {
                    
                } paramDic:paramDic urlStr:kApiOrderDeleteHistory];
                
                [self.tableView.mj_header beginRefreshing];
            }
        } title:@"清空历史记录" content:@"确认删除听课记录?" cancleStr:@"取消" confirmStr:@"确认"];
        
    }
    
}

//点击书籍滚动图的代理点击方法 delegate
- (void)horImageClickAction:(NSInteger)tag section:(NSInteger)section {
    NSLog(@"你点击的按钮tag值为：%ld",tag);
    
    WatHomeClass01ViewController *class01VC = [WatHomeClass01ViewController new];
    [class01VC setHidesBottomBarWhenPushed:YES];
    class01VC.id = self.yigouClassModelArr[tag - 100].id;
    [self.navigationController pushViewController:class01VC animated:YES];
    
}

- (void)loginBtnClick{

//present 后,无法 push 的解决办法  加一个 nav
//    WatLoginViewController *login = [[WatLoginViewController alloc]init];
//    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:login];
//    [self.navigationController presentViewController:nav animated:YES completion:nil];
    
    WatLoginViewController *login = [[WatLoginViewController alloc]init];
    [login setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:login animated:YES];
}
- (void)checkMoreDataBtnClick{
    WatAlreadyBoughtCourseViewController *classDetailVC = [[WatAlreadyBoughtCourseViewController alloc]init];
    //self.navigationController.navigationBarHidden = NO;
    [classDetailVC setHidesBottomBarWhenPushed:YES];
    classDetailVC.navigationController.navigationBarHidden = NO;
    [self.navigationController pushViewController: classDetailVC animated:YES];
}
@end
