//
//  PayOnLineClassAleartViewController.m
//  wat
//
//  Created by 123 on 2018/7/6.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "PayOnLineClassAleartViewController.h"
#import "applepayGetmycionModel.h"

@interface PayOnLineClassAleartViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)applepayGetmycionModel *getmycionModel;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSString *sureBtnTitleStr;
@end

@implementation PayOnLineClassAleartViewController
- (WatHomeClassGoodsModel *)watHomeClassGoodsModel{
    if (!_watHomeClassGoodsModel) {
        _watHomeClassGoodsModel = [WatHomeClassGoodsModel new];
    }
    return _watHomeClassGoodsModel;
}
- (applepayGetmycionModel *)getmycionModel{
    if (!_getmycionModel) {
        _getmycionModel = [applepayGetmycionModel new];
    }
    return _getmycionModel;
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, MyKScreenHeight - 260, MyKScreenWidth, 260) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;
    self.navBarView.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.navigationController.navigationBarHidden = NO;
    self.navBarView.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setAFN];
    [self setUI];
    
    
    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(disMissViewController)];
    [self.view addGestureRecognizer:tapGesturRecognizer];
    
}
- (void)setAFN{
    __weak typeof (self)weakSelf = self;
    [applepayGetmycionModel asyncPostAppPayGetMyCionSuccessBlock:^(applepayGetmycionModel *getmycionModel) {
        weakSelf.getmycionModel = getmycionModel;
        
        if (weakSelf.getmycionModel.ios_coin.floatValue >= weakSelf.watHomeClassGoodsModel.price.floatValue) {
            weakSelf.sureBtnTitleStr = @"支付";
        }else{
            weakSelf.sureBtnTitleStr = @"余额不足/立即充值";
        }
        [weakSelf setUI];
        [weakSelf.tableView reloadData];
        
    } errorBlock:^(NSError *errorResult) {
        
    } paramDic:nil urlStr:KApiAppPayGetMyCion];
    
}
- (void) setUI {
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = NO; //隐藏分割线
    
    UIView *bgv = [[UIView alloc]initWithFrame:CGRectMake(0, MyKScreenHeight - 60, MyKScreenWidth, 60)];
    //bgv.backgroundColor = [UIColor redColor];
    [self.view addSubview:bgv];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, MyKScreenWidth * 0.5, CGRectGetHeight(bgv.frame))];
    btn.backgroundColor = WatBackColor;
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(disMissViewController) forControlEvents:UIControlEventTouchUpInside];
    [bgv addSubview:btn];
    
    
    UIButton *sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(MyKScreenWidth * 0.5, 0, MyKScreenWidth * 0.5, CGRectGetHeight(bgv.frame))];
    sureBtn.backgroundColor = CommonAppColor;
    [sureBtn setTitle:self.sureBtnTitleStr forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bgv addSubview:sureBtn];
    
}
- (void)disMissViewController{
    [[NSNotificationCenter  defaultCenter]postNotificationName:@"dissBlackBGVClick" object:nil];
    [self dismissModalViewControllerAnimated:YES];
}
- (void)sureBtnClick{
    if (self.getmycionModel.ios_coin.floatValue >= self.watHomeClassGoodsModel.price.floatValue) {
        NSMutableDictionary *paramDic = [NSMutableDictionary new];
        [paramDic setObject:self.watHomeClassGoodsModel.id forKey:@"gid"];
        __weak typeof (self)weakSelf = self;
        [applepayGetmycionModel asyncPostkApiAppPayBuySuccessBlock:^(applepayGetmycionModel *getmycionModel) {
            [weakSelf paySuccessAction];
        } errorBlock:^(NSError *errorResult) {
            [weakSelf payFailAction];
        } paramDic:paramDic urlStr:kApiAppPayBuy];
    }else{
        NSLog(@"去充值");
        [self jumpWalletVCClick];
    }
}

- (void)paySuccessAction{
    [[NSNotificationCenter  defaultCenter]postNotificationName:@"paySuccessDissBlackBGVClick" object:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)payFailAction{
    [[NSNotificationCenter  defaultCenter]postNotificationName:@"dissBlackBGVClick" object:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)jumpWalletVCClick{
    [[NSNotificationCenter  defaultCenter]postNotificationName:@"jumpWalletVCClick" object:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.backgroundColor = [UIColor whiteColor];
    }
    cell.textLabel.textColor = [UIColor darkGrayColor];
    cell.detailTextLabel.textColor = [UIColor darkGrayColor];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"购买产品为:";
        
        cell.textLabel.font = commenAppFont(18);
        cell.detailTextLabel.text = self.watHomeClassGoodsModel.title;
        cell.detailTextLabel.font = commenAppFont(18);
    }else if (indexPath.row == 1){
        cell.textLabel.text = @"需支付总额";
        cell.textLabel.font = commenAppFont(14);
        cell.detailTextLabel.text = self.watHomeClassGoodsModel.price;
    }else if (indexPath.row == 2){
        cell.textLabel.text = @"当前余额";
        cell.textLabel.font = commenAppFont(14);
        cell.detailTextLabel.text = self.getmycionModel.ios_coin;
        cell.detailTextLabel.textColor = [UIColor redColor];
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];// （这种是没有点击后的阴影效果)
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *bgv = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MyKScreenWidth, 60)];
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, MyKScreenWidth, 60)];
    titleLab.text = @"餐饮老板收银台";
    titleLab.textColor = [UIColor blackColor];
    titleLab.font = commenAppFont(22);
    titleLab.textAlignment = NSTextAlignmentCenter;
    [bgv addSubview:titleLab];
    return bgv;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
}

@end
