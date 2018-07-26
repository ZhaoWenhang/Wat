//
//  yigoumaiViewController.m
//  wat
//
//  Created by 123 on 2018/6/21.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "yigoumaiViewController.h"
#import "yigoumaiTableViewCell.h"
#import "HorScorllView.h"
//----------------------- controller ----------------
#import "myClassListViewController.h" //查看全部,课程列表页
#import "OrderDetailViewController.h"
#import "WatAlreadyBoughtCourseViewController.h"
//------------------------ model -------------------
#import "YigoumaiHomeModel.h"

@interface yigoumaiViewController ()<UITableViewDelegate,UITableViewDataSource,HorScorllViewImageClickDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) HorScorllView *horScorllView;
@property (nonatomic, strong) HorScorllView *horScorllViewSection0;
@property (nonatomic, strong) HorScorllView *horScorllViewSection1;
@property (nonatomic, strong) HorScorllView *horScorllViewSection2;
@property (nonatomic, strong) UIView *loginBGVIew;
@property (nonatomic, strong) UIView *checkMoreDataBGVIew;

//----------------------- model --------------------
@property (nonatomic, strong) YigoumaiHomeModel *yigoumaiHomeModel;
@property (nonatomic, strong) YigoumaiActiveModel *yigoumaiActiveModel;
@property (nonatomic, strong) YigoumaiClassModel *yigoumaiClassModel;
@property (nonatomic, strong) YigoumaiBookModel *yigoumaiBookModel;
@property (nonatomic, strong) NSArray<YigoumaiDetailModel *> *activeArr;
@property (nonatomic, strong) NSString *activeHeaderNameStr;
@property (nonatomic, strong) NSArray<YigoumaiDetailModel *> *classArr;
@property (nonatomic, strong) NSString *classHeaderNameStr;
@property (nonatomic, strong) NSArray<YigoumaiDetailModel *> *bookArr;
@property (nonatomic, strong) NSString *bookHeaderNameStr;

@end

@implementation yigoumaiViewController
- (YigoumaiHomeModel *)yigoumaiHomeModel{
    if (!_yigoumaiHomeModel) {
        _yigoumaiHomeModel = [YigoumaiHomeModel new];
    }
    return _yigoumaiHomeModel;
}
-(NSArray<YigoumaiDetailModel *> *)activeArr{
    if (!_activeArr) {
        _activeArr = [NSArray new];
    }
    return _activeArr;
}
-(NSArray<YigoumaiDetailModel *> *)classArr{
    if (!_classArr) {
        _classArr = [NSArray new];
    }
    return _classArr;
}
-(NSArray<YigoumaiDetailModel *> *)bookArr{
    if (!_bookArr) {
        _bookArr = [NSArray new];
    }
    return _bookArr;
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
        if (self.activeArr.count == 0 && self.classArr.count == 0 && self.bookArr.count == 0) {
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
    self.navTitle = @"已购";
    self.isBackTitle = YES;
    
    
    
    
    [self addtableView];
    [self addNODataView];
    [self addGoLoginView];
    
}

- (void) setAFN{
    if ([WatUserInfoManager isLoginUserID]) {
        NSMutableDictionary *paramDic = [NSMutableDictionary new];
        __weak typeof (self) weakSelf = self;
        [YigoumaiHomeModel asyncPostkApiOrderListPageSuccessBlock:^(YigoumaiHomeModel *yigoumaiHomeModel) {
            weakSelf.activeArr = yigoumaiHomeModel.active.list;
            weakSelf.classArr = yigoumaiHomeModel.classes.list;
            weakSelf.bookArr = yigoumaiHomeModel.book.list;
            weakSelf.activeHeaderNameStr = yigoumaiHomeModel.active.title;
            weakSelf.classHeaderNameStr = yigoumaiHomeModel.classes.title;
            weakSelf.bookHeaderNameStr = yigoumaiHomeModel.book.title;
            [weakSelf.tableView reloadData];
            [weakSelf.tableView.mj_header endRefreshing];
            
            if ([WatUserInfoManager isLoginUserID]) {
                
                weakSelf.loginBGVIew.hidden = YES;
                weakSelf.tableView.hidden = NO;
                if (weakSelf.activeArr.count == 0 && weakSelf.classArr.count == 0 && weakSelf.bookArr.count == 0) {
                    weakSelf.checkMoreDataBGVIew.hidden = NO;
                }else{
                    weakSelf.checkMoreDataBGVIew.hidden = YES;
                    
                }
            }else{
                weakSelf.tableView.hidden = YES;
                weakSelf.loginBGVIew.hidden = NO;
                weakSelf.checkMoreDataBGVIew.hidden = YES;
            }
            
        } errorBlock:^(NSError *errorResult) {
            [weakSelf.tableView.mj_header endRefreshing];
        } paramDic:paramDic urlStr:kApiOrderListPage];
        
    }
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
- (void)addGoLoginView{
    
    [self.view addSubview:self.loginBGVIew];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, MyKScreenWidth, 300)];
    imageView.image = [UIImage imageNamed:@"空空如也"];
    imageView.contentMode = 1;
    imageView.center =Center(MyKScreenWidth * 0.5, MyTopHeight + 30 + CGRectGetHeight(imageView.frame) * 0.5);
    [self.loginBGVIew addSubview:imageView];
    
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
- (void)addtableView{
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = WatBackColor;

        __weak typeof (self) weakSelf = self;
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf setAFN];
        }];
        if ([WatUserInfoManager isLoginUserID]) {
            [self.tableView.mj_header beginRefreshing];
        }
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        if (self.activeArr.count == 0) {
            return 0;
        }else{
            return 1;
        }
        
    }else if (section == 1){
        if (self.classArr.count == 0) {
            return 0;
        }else{
            return 1;
        }
    }else{
        if (self.bookArr.count == 0) {
            return 0;
        }else{
            return 1;
        }
    }
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * ID = @"cell";
    
    yigoumaiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"yigoumaiTableViewCell" owner:self options:nil]firstObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    if (indexPath.section == 0) {
        NSMutableArray *imagesArr = [[NSMutableArray alloc]init];
        NSMutableArray *titleArr = [[NSMutableArray alloc]init];
        for (int i = 0; i < self.activeArr.count; i ++) {
            YigoumaiDetailModel *yigoumaiDetailModel = self.activeArr[i];
            [imagesArr addObject:yigoumaiDetailModel.goods_pic];
            [titleArr addObject:yigoumaiDetailModel.goods_name];
        }
        _horScorllView = [[HorScorllView alloc] initWithFrame:CGRectMake(0, 0, MyKScreenWidth, 200)];
        _horScorllView.section = 0;
        _horScorllView.images = imagesArr;
        _horScorllView.titles = titleArr;
        //_horScorllView.moneys = @[@"12",@"91",@"89",@"90",@"781"];
        _horScorllView.moneylab.hidden = YES;
        _horScorllView.delegate = self;
        [cell addSubview:_horScorllView];
    }else if (indexPath.section == 1){
        NSMutableArray *imagesArr = [[NSMutableArray alloc]init];
        NSMutableArray *titleArr = [[NSMutableArray alloc]init];
        NSMutableArray *typeImgArr = [[NSMutableArray alloc]init];
        for (int i = 0; i < self.classArr.count; i ++) {
            YigoumaiDetailModel *yigoumaiDetailModel = self.classArr[i];
            [imagesArr addObject:yigoumaiDetailModel.goods_pic];
            [titleArr addObject:yigoumaiDetailModel.goods_name];
            [typeImgArr addObject:yigoumaiDetailModel.content_type];
        }
        _horScorllView = [[HorScorllView alloc] initWithFrame:CGRectMake(0, 0, MyKScreenWidth, 200)];
        _horScorllView.section = 1;
        _horScorllView.images = imagesArr;
        _horScorllView.titles = titleArr;
        //_horScorllView.moneys = @[@"12",@"91",@"89",@"90",@"781"];
        _horScorllView.typeImgs = typeImgArr;
        _horScorllView.moneylab.hidden = YES;
        _horScorllView.delegate = self;
        [cell addSubview:_horScorllView];
    }else{
        NSMutableArray *imagesArr = [[NSMutableArray alloc]init];
        NSMutableArray *titleArr = [[NSMutableArray alloc]init];
        for (int i = 0; i < self.bookArr.count; i ++) {
            YigoumaiDetailModel *yigoumaiDetailModel = self.bookArr[i];
            [imagesArr addObject:yigoumaiDetailModel.goods_pic];
            [titleArr addObject:yigoumaiDetailModel.goods_name];
        }
        _horScorllView = [[HorScorllView alloc] initWithFrame:CGRectMake(0, 0, MyKScreenWidth, 200)];
        _horScorllView.section = 2;
        _horScorllView.images = imagesArr;
        _horScorllView.titles = titleArr;
        //_horScorllView.moneys = @[@"12",@"91",@"89",@"90",@"781"];
        _horScorllView.moneylab.hidden = YES;
        _horScorllView.delegate = self;
        [cell addSubview:_horScorllView];
    }
    return cell;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSString *btnName ;
    NSString *editBtnName;
    if (section == 0) {
        btnName = self.activeHeaderNameStr;
        editBtnName = @"查看全部";
    }else if (section == 1){
        btnName = self.classHeaderNameStr;
        editBtnName = @"查看全部";
    }
    else{
        btnName = self.bookHeaderNameStr;
        editBtnName = @"查看全部";
    }
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MyKScreenWidth, 64)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UIView *fenggeLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MyKScreenWidth, 8)];
    fenggeLine.backgroundColor = WatBackColor;
    
    
    UILabel *headerTitleLab = [[UILabel alloc]initWithFrame:CGRectMake(14, 30, MyKScreenWidth - 30, 24)];
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
        if (self.activeArr.count != 0) {
            [headerView addSubview:fenggeLine];
            [headerView addSubview:headerTitleLab];
            [headerView addSubview:moreBtn];
        }
    }else if (section == 1){
        if (self.classArr.count != 0) {
            [headerView addSubview:fenggeLine];
            [headerView addSubview:headerTitleLab];
            [headerView addSubview:moreBtn];
        }
    }else{
        if (self.bookArr.count != 0) {
            [headerView addSubview:fenggeLine];
            [headerView addSubview:headerTitleLab];
            //[headerView addSubview:moreBtn];//书籍暂时不需要更多,一共没几本书籍
        }
    }
    
    return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        if (self.activeArr.count == 0) {
            return 0.01;
        }else{
            return 70;//40 + 10 + 20
        }
    }else if (section == 1){
        if (self.classArr.count == 0) {
            return 0.01;
        }else{
            return 70;//40 + 10 + 20
        }
    }else{
        if (self.bookArr.count == 0) {
            return 0.01;
        }else{
            return 70;//40 + 10 + 20
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (self.activeArr.count == 0) {
            return 0;
        }else{
            return 200;
        }
    }else if (indexPath.section == 1){
        if (self.classArr.count == 0) {
            return 0;
        }else{
            return 200;
        }
    }else{
        if (self.bookArr.count == 0) {
            return 0;
        }else{
            return 200;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (void) addMoreBtnClick:(UIButton *)sender {
    NSLog(@"%ld",sender.tag);
    if (sender.tag == 0) {
        myClassListViewController *classListVC = [myClassListViewController new];
        classListVC.typeName = @"2";
        [classListVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:classListVC animated:YES];
    }else if (sender.tag == 1){
        myClassListViewController *classListVC = [myClassListViewController new];
        classListVC.typeName = @"0";
        [classListVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:classListVC animated:YES];
        
    }else if (sender.tag == 2){
        
        
    }
    
    
    
}


- (void)horImageClickAction:(NSInteger)tag section:(NSInteger)section{
    NSLog(@"你点击的按钮tag值为：%ld section:%ld",tag,section);
    
    
    if (section == 0) {
        OrderDetailViewController *orderClassVC = [OrderDetailViewController new];
        [orderClassVC setHidesBottomBarWhenPushed:YES];
        orderClassVC.order_id = self.activeArr[tag - 100].id;
        [self.navigationController pushViewController:orderClassVC animated:YES];
    }else if (section == 1){
        OrderDetailViewController *orderClassVC = [OrderDetailViewController new];
        [orderClassVC setHidesBottomBarWhenPushed:YES];
        orderClassVC.order_id = self.classArr[tag - 100].id;
        [self.navigationController pushViewController:orderClassVC animated:YES];
    }else if (section == 2){
        OrderDetailViewController *orderClassVC = [OrderDetailViewController new];
        [orderClassVC setHidesBottomBarWhenPushed:YES];
        orderClassVC.order_id = self.bookArr[tag - 100].id;
        [self.navigationController pushViewController:orderClassVC animated:YES];
    }
    
    
}
- (void)loginBtnClick{
    WatLoginViewController *loginVC = [WatLoginViewController new];
    [loginVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:loginVC animated:YES];
}
- (void)checkMoreDataBtnClick{
    WatAlreadyBoughtCourseViewController *classDetailVC = [[WatAlreadyBoughtCourseViewController alloc]init];
    //self.navigationController.navigationBarHidden = NO;
    [classDetailVC setHidesBottomBarWhenPushed:YES];
    classDetailVC.navigationController.navigationBarHidden = NO;
    [self.navigationController pushViewController: classDetailVC animated:YES];
}
@end
