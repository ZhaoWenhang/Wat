//
//  MyWalletViewController.m
//  wat
//
//  Created by 123 on 2018/5/29.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "MyWalletViewController.h"
#import "ZWHCountingLabel.h"//label 数字滚动
#import "WalletDetailViewController.h"
#import "WalletChongzhiTixianViewController.h"

#import "applePay.h"
#import "applepaySetDataModel.h"

@interface MyWalletViewController ()<UITableViewDelegate,UITableViewDataSource,applePayDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *messageArr;//cell数据源

@property (nonatomic, strong)NSString *moneyStr;

@property (nonatomic, strong) UIButton *sureBtn;
@property (nonatomic, strong) UIButton *selectedBtn;


// -------------- 内购 -------------
@property (nonatomic, strong) NSArray *chongzhiArr;//内购充值价格 button 名称
@property (nonatomic, strong) NSArray *appPayArr; //内购 id
@property (nonatomic, strong) applePay *iapManager;//内购
@property (nonatomic, strong) NSMutableDictionary *paramDic;


//-------------- model -------------
@property (nonatomic, strong)applepaySetDetailModel *applepaySetDetailmodel;
@property (nonatomic, strong)applepaySetDataModel *applepaySetDatamodel;
@property (nonatomic, strong)NSArray<applepaySetDetailModel *> *list;
@end

@implementation MyWalletViewController
-(NSArray<applepaySetDetailModel *> *)list{
    if (!_list) {
        _list = [NSArray new];
    }
    return _list;
}
- (applepaySetDetailModel *)applepaySetDetailmodel{
    if (!_applepaySetDetailmodel) {
        _applepaySetDetailmodel = [applepaySetDetailModel new];
    }
    return _applepaySetDetailmodel;
}
- (applepaySetDataModel *)applepaySetDatamodel{
    if (!_applepaySetDatamodel) {
        _applepaySetDatamodel = [applepaySetDataModel new];
    }
    return _applepaySetDatamodel;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, MyTopHeight, MyKScreenWidth, MyKScreenHeight - MyTopHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        //_tableView.contentInset = UIEdgeInsetsMake(200, 0, 0, 0);
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WatBackColor;
    self.navTitle = @"我的钱包";
    self.rightTitles = @[@"明细"];
    [self setAFN];
    //界面加载数据
    NSString *path= [[NSBundle mainBundle]pathForResource:@"MEWalletList" ofType:@"plist"];
    _messageArr = [NSArray arrayWithContentsOfFile:path];
    
    
    //NSDictionary *dic = @[@"];
    NSArray *chongzhiArr =  [NSArray arrayWithObjects:@"6",@"68",@"208",@"298",@"618",@"998", nil];
    self.chongzhiArr = chongzhiArr;
    
    self.appPayArr = [NSArray arrayWithObjects:@"com.watcn.wat6",@"com.watcn.wat68",@"com.watcn.wat208",@"com.watcn.wat298",@"com.watcn.wat618",@"com.watcn.wat998", nil];
    
    [self addTableView];
}
- (void)setAFN{
    
    __weak typeof (self)weakSelf = self;
    [applepaySetDataModel asyncPostkApiAppPayPaySettingSuccessBlock:^(applepaySetDataModel *applepaySetDataModel) {
        weakSelf.list = applepaySetDataModel.list;
        weakSelf.applepaySetDatamodel.ios_coin = applepaySetDataModel.ios_coin;
        weakSelf.applepaySetDatamodel.tishi = applepaySetDataModel.tishi;
        [weakSelf.tableView reloadData];
    } errorBlock:^(NSError *errorResult) {
    } paramDic:nil urlStr:kApiAppPayPaySetting];
    
}
- (void) addTableView {
    [self.view addSubview:self.tableView];
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MyKScreenWidth, 0.1)];
    self.tableView.tableHeaderView = headerView;
    self.tableView.backgroundColor = WatBackColor;
    
    
    
}
#pragma 三问一答
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
//    NSArray *arr;
//    for (int i = 0; i < _messageArr.count; i++) {
//        if (section == i) {
//            arr = _messageArr[i];
//        }
//    }
//    //NSLog(@"--------%ld",arr.count);
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.backgroundColor = [UIColor whiteColor];
        //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//显示箭头
    }
    
//    NSString *imgName;
//    NSArray *arr = _messageArr[indexPath.section];
//    NSDictionary *dic = arr[indexPath.row];
//    imgName = [dic valueForKey:@"cellIconName"];
//    UIImage *image = [UIImage imageNamed:imgName];
//    cell.imageView.image = image;
//
//    cell.textLabel.text = [dic valueForKey:@"cellName"];
//    cell.textLabel.font = commenAppFont(16);
//    cell.textLabel.textColor = [UIColor grayColor];
//
//    CGSize itemSize = CGSizeMake(20, 20);
//    UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
//    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
//    [cell.imageView.image drawInRect:imageRect];
//    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    cell.imageView.contentMode = 2;
//
//    UIView *fengeView = [[UIView alloc]initWithFrame:CGRectMake(0, cell.frame.size.height - 0.5, MyKScreenWidth, 0.5)];
//    fengeView.backgroundColor = [UIColor grayColor];
//    fengeView.alpha = 0.2;
//    [cell addSubview:fengeView];
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, MyKScreenWidth, 160)];
    // imgView.image = [UIImage imageNamed:@"钱包背景图"];
    imgView.backgroundColor = CommonAppColor;
    imgView.contentMode = 3;
    [cell addSubview:imgView];
    
    UIImageView *jinbiImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
    jinbiImgView.image = [UIImage imageNamed:@"64-金币-2"];
    jinbiImgView.center = Center(imgView.center.x, 60);
    //[imgView addSubview:jinbiImgView];
    
    
    /**
     数字滚动
     */
    //_moneyStr
    
    ZWHCountingLabel *myLabel = [[ZWHCountingLabel alloc] initWithFrame:CGRectMake(40, 50, imgView.frame.size.width - 80, 40)];
    myLabel.font = [UIFont fontWithName:@"Avenir Next" size:38];
    myLabel.textColor = [UIColor whiteColor];
    myLabel.textAlignment = NSTextAlignmentCenter;
    [imgView addSubview:myLabel];
    //设置文本样式
    //整数
    myLabel.format = @"%d";
    //浮点数样式数字
    myLabel.format = @"%.2f";
    //设置变化范围及动画时间
    //整数
    [myLabel countFrom:0 to:100 withDuration:3.0f];
    //浮点数
    [myLabel countFrom:0.00 to:self.applepaySetDatamodel.ios_coin.floatValue withDuration:3.0f];
    myLabel.positiveFormat = @"###,##0.00";
    myLabel.adjustsFontSizeToFitWidth=YES;
    
    UILabel *miaoshuLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, MyKScreenWidth, 12)];
    miaoshuLab.center = Center(imgView.center.x, myLabel.frame.size.height + myLabel.frame.origin.y + 10);
    miaoshuLab.textAlignment = NSTextAlignmentCenter;
    miaoshuLab.text = @"钱包余额(内参币)";
    miaoshuLab.textColor = [UIColor whiteColor];
    miaoshuLab.font = commenAppFont(12);
    miaoshuLab.adjustsFontSizeToFitWidth = YES;
    [imgView addSubview:miaoshuLab];
    
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(imgView.frame) + 20, 100, 22)];
    titleLab.text = @"在线支付";
    titleLab.font = commenAppFont(15);
    titleLab.textColor = [UIColor blackColor];
    titleLab.textAlignment = NSTextAlignmentLeft;
    [cell addSubview:titleLab];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(titleLab.frame) + 4, MyKScreenWidth - 40, 1)];
    lineView.backgroundColor = WatBackColor;
    [cell addSubview:lineView];
    
    UIView *btnBGView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(lineView.frame), MyKScreenWidth, (self.list.count / 3 + 1) * 70)];
    btnBGView.backgroundColor = [UIColor clearColor];
    [cell addSubview:btnBGView];
    
    CGFloat btnWidth = 85;
    CGFloat btnHeight = 59;
    for (int i = 0; i < self.list.count; i++) {
        UIButton *btn = [[UIButton alloc]init];
        btn.frame = CGRectMake((i % 3) * btnWidth + (i % 3 + 1) * 30,  (i / 3) * btnHeight + (i / 3 + 1) * 11, btnWidth, btnHeight);
        btn.tag = i;
      
        NSString *str1 = [NSString stringWithFormat:@"%@内参币\n%@元",self.list[i].dao,self.list[i].dao];
        btn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [btn setTitle:str1 forState:UIControlStateNormal];
        btn.titleLabel.font = commenAppFont(12);
        btn.titleLabel.adjustsFontSizeToFitWidth = YES;
        
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn.layer setMasksToBounds:YES];
        [btn.layer setCornerRadius:4.0]; //设置矩圆角半径
        [btn.layer setBorderWidth:1.0];   //边框宽度
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 200/255.0, 200/255.0, 200/255.0, 255/255.0 });//237, 240, 244
        [btn.layer setBorderColor:colorref];//边框颜色
        
        // 默认选中第一个
        if (btn.tag == 0) {
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.backgroundColor = CommonAppColor;
            self.selectedBtn=btn;
            
        }else{
            
            btn.backgroundColor = [UIColor whiteColor];
            
        }
        [btn addTarget:self action:@selector(moneyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btnBGView addSubview:btn];
        
//        UILabel *lab01 = [[UILabel alloc]init];
//        lab01.frame = CGRectMake(0, 0, btnWidth, btnHeight * 0.6);
//        lab01.text = [NSString stringWithFormat:@"%d内参币",i];
//        lab01.textColor = [UIColor blackColor];
//        lab01.font = biaotiAppFont(13);
//        lab01.textAlignment = NSTextAlignmentCenter;
//        lab01.adjustsFontSizeToFitWidth = YES;
//        [btn addSubview:lab01];
//
//        UILabel *lab02 = [[UILabel alloc]init];
//        lab02.frame = CGRectMake(0, btnHeight * 0.5, btnWidth, btnHeight * 0.4);
//        lab02.text = [NSString stringWithFormat:@"%d元",i];
//        lab02.textColor = [UIColor darkGrayColor];
//        lab02.font = commenAppFont(12);
//        lab02.textAlignment = NSTextAlignmentCenter;
//        lab02.adjustsFontSizeToFitWidth = YES;
//        [btn addSubview:lab02];
        
    }
    
    UIButton *sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(12, CGRectGetMaxY(btnBGView.frame) + 30, MyKScreenWidth - 24, 40)];
    self.sureBtn = sureBtn;
    sureBtn.backgroundColor = CommonAppColor;
    [sureBtn setTitle:@"确认支付" forState: UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sureBtn.layer.cornerRadius = 4;
    sureBtn.clipsToBounds = YES;
    [sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    sureBtn.userInteractionEnabled=NO;//交互关闭
//    sureBtn.alpha=0.4;//透明度
    [cell addSubview:sureBtn];
    
    UILabel *tishiLab = [[UILabel alloc]initWithFrame:CGRectMake(12, CGRectGetMaxY(sureBtn.frame) + 30, MyKScreenWidth - 24, 100)];
    tishiLab.text = self.applepaySetDatamodel.tishi;
    tishiLab.font = commenAppFont(12);
    tishiLab.textColor = [UIColor grayColor];
    tishiLab.numberOfLines = 0;
    [tishiLab sizeToFit];
    [cell addSubview:tishiLab];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    WalletChongzhiTixianViewController *vc = [WalletChongzhiTixianViewController new];
//    [self.navigationController pushViewController:vc animated:YES];
//    if (indexPath.row == 0) {
//        vc.type = @"0";
//        vc.navTitle = @"充值";
//    }else{
//        vc.type = @"1";
//        vc.navTitle = @"提现";
//
//    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return MyKScreenHeight - MyTopHeight - 140 + (self.list.count / 3 * 70 + 70);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.01;
}
- (void)moneyBtnClick:(UIButton *)sender{
    
    NSLog(@"点击的是第几个按钮%ld",sender.tag);
//    //确定按钮变为可点击状态
//    self.sureBtn.userInteractionEnabled = YES;
//    self.sureBtn.alpha = 1.0;
    
    //选中变红色 其他按钮变为白色
    if (self.selectedBtn) {
        
        self.selectedBtn.backgroundColor = [UIColor whiteColor];
        [self.selectedBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    
    self.selectedBtn = sender;
    [self.selectedBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.selectedBtn.backgroundColor = CommonAppColor;
}

- (void) sureBtnClick{
    NSLog(@"点击了确认按钮%ld",self.selectedBtn.tag);
    //[WATHud showLoading];
    NSString *appPayIDStr = self.list[self.selectedBtn.tag].ncb;
    if (!_iapManager) {
        _iapManager = [[applePay alloc] init];
        
    }
   
    
    [[applePay SharePurchases] requestProductData:appPayIDStr];
    [applePay SharePurchases].delegate = self;
    
    
    
    
    // iTunesConnect 苹果后台配置的产品ID
//    [_iapManager startPurchWithID:appPayIDStr completeHandle:^(IAPPurchType type,NSData *data) {
//
//        if (data) {
//            NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//            NSDictionary *receipt = [jsonResponse valueForKey:@"receipt"];
//
//            NSData *base64Data = [data base64EncodedDataWithOptions:0];
//            NSString *baseString = [[NSString alloc]initWithData:base64Data encoding:NSUTF8StringEncoding];
//            NSString *encodingReceipt = [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
//            NSLog(@"++++++++++++%u%@",type,encodingReceipt);
//
//            NSMutableDictionary *paramDic = [NSMutableDictionary new];
//            [paramDic setValue:baseString forKey:@"receipt"];
//            [paramDic setValue:@"1" forKey:@"is_test"];
//
//            if (ValidStr(paramDic[@"receipt"])) {
//                __weak typeof (self)weakSelf = self;
//                [Request POST:kApiAppPayCheckPay parameters:paramDic success:^(id responseObject) {
//                    [weakSelf setAFN];
//                    [weakSelf.tableView reloadData];
//                } failure:^(NSError *error) {
//
//                }];
//            }
//
//        }
//
//    }];
}
- (void)payseccuss{
    [self setAFN];
    [self.tableView reloadData];
    
}

- (void)rightBtnsAction:(UIButton *)button{
    WalletDetailViewController *vc = [WalletDetailViewController new];
    [self.navigationController pushViewController:vc animated:YES];
    
}

+ (NSDictionary*)returnDictionaryWithDataPath:(NSData*)data
 {
     //NSData* data = [[NSMutableData alloc]initWithContentsOfFile:path]; 拿路径文件
     NSKeyedUnarchiver* unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
     NSDictionary* myDictionary = [unarchiver decodeObjectForKey:@"talkData"];
     [unarchiver finishDecoding];
     return myDictionary;
}


@end
