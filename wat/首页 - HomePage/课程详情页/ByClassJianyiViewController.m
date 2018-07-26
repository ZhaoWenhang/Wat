//
//  ByClassJianyiViewController.m
//  wat
//
//  Created by 123 on 2018/7/3.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "ByClassJianyiViewController.h"
#import "ByClassUserModel.h"
#import "WeChatModel.h"//微信
#import "paySuccessPageViewController.h"
#import "OrderDetailViewController.h"
#import "ZmjPickView.h"//地址选择

@interface ByClassJianyiViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSArray *titleArr;
@property (nonatomic, strong)UITextField *textField0; //姓名
@property (nonatomic, strong)UITextField *textField1;   //电话
@property (nonatomic, strong)UITextField *textField2;   //公司
@property (nonatomic, strong)UITextField *textField3;   //职位
@property (nonatomic, strong) UITextField *textField4; //详细地址

@property (nonatomic, strong) ZmjPickView *zmjPickView;//三级地址选择
@property (nonatomic, strong) NSString *addressSanjiStr; //三级名称

//----------- model ------------
@property (nonatomic, strong) ByClassUserModel *byClassUserModel;
@property (nonatomic, strong) WatUserInfoModel *watUserInfoModel;
@property (nonatomic, strong) WeChatModel *wechatModel;
@property (nonatomic, strong) NSString *order_id;
@end

@implementation ByClassJianyiViewController
- (WatHomeClassGoodsModel *)watHomeClassGoodsModel{
    if (!_watHomeClassGoodsModel) {
        _watHomeClassGoodsModel = [WatHomeClassGoodsModel new];
    }
    return _watHomeClassGoodsModel;
}
- (WatHomeWillBeginClassModel *)watHomeWillBeginClassModel{
    if (!_watHomeWillBeginClassModel) {
        _watHomeWillBeginClassModel = [WatHomeWillBeginClassModel new];
    }
    return _watHomeWillBeginClassModel;
}

-(WeChatModel *)wechatModel{
    if (_wechatModel) {
        _wechatModel = [WeChatModel new];
    }
    return _wechatModel;
}
-(ByClassUserModel *)byClassUserModel{
    if (!_byClassUserModel) {
        _byClassUserModel = [ByClassUserModel new];
    }
    return _byClassUserModel;
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, MyTopHeight, MyKScreenWidth, MyKScreenHeight - MyTopHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = NO; //隐藏分割线
        _tableView.backgroundColor = WatBackColor;
    }
    return _tableView;
}
- (ZmjPickView *)zmjPickView {
    if (!_zmjPickView) {
        _zmjPickView = [[ZmjPickView alloc]init];
    }
    return _zmjPickView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navTitle = @"确认订单";
    self.view.backgroundColor = WatBackColor;
    self.titleArr = @[@"姓       名:",@"电       话:",@"地       址:",@"详细地址:",@"公       司:",@"职       位:"];
    
    [self addTableView];
    [self addUserInfo];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(wechatPaySuccess:) name:WechatPaySuccessNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(wechatPayFail:) name:WechatPayFailNotification object:nil];
    //支付成功,dismiss 后,再 push
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backback) name:@"backback" object:nil];
    //支付成功后,返回首页
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backHome) name:@"backHome" object:nil];
}
- (void)backHome{
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
-(void)backback
{
    OrderDetailViewController *orderDetailVC = [OrderDetailViewController new];
    orderDetailVC.order_id = self.order_id;
    [self.navigationController pushViewController:orderDetailVC animated:YES];
}

- (void)wechatPaySuccess:(NSNotification *)dic{
    NSLog(@"%@",dic.userInfo[@"errCode"]);  //errCode
    
    paySuccessPageViewController *paySuccessVC = [[paySuccessPageViewController alloc]init];
    
    
    if (ValidStr(self.orderDetailModel.id)) {
        paySuccessVC.orderDetailModel = self.orderDetailModel;
    }else if (ValidStr(self.watHomeHotDetailsModel.goods_id)) {
        paySuccessVC.watHomeHotDetailsModel = self.watHomeHotDetailsModel;
    }else if (ValidStr(self.watHomeClassGoodsModel.id)) {
        paySuccessVC.watHomeClassGoodsModel = self.watHomeClassGoodsModel;
    }else{
        paySuccessVC.watHomeWillBeginClassModel = self.watHomeWillBeginClassModel;
    }
    
    
    self.definesPresentationContext = YES;
    UIColor *color = [UIColor blackColor];
    paySuccessVC.view.backgroundColor = [color colorWithAlphaComponent:0.5];
    paySuccessVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self.navigationController presentViewController:paySuccessVC animated:YES completion:nil];
}

- (void)wechatPayFail:(NSNotification *)dic{
    NSLog(@"%@",dic.userInfo[@"errCode"]);  //errCode  errStr
    [WATHud showMessage:@"支付失败"];
}

- (void) addUserInfo {
    WatUserInfoModel *watUserInfoModel = [WatUserInfoManager getInfo];
    self.watUserInfoModel = watUserInfoModel;
    self.byClassUserModel.name = watUserInfoModel.truename;
    self.byClassUserModel.telephone = watUserInfoModel.tel;
    [self.tableView reloadData];
    NSLog(@"%@",self.byClassUserModel.name);
}
- (void)addTableView{
    
    [self.view addSubview:self.tableView];
    
    UIButton *bottomBtn = [[UIButton alloc]initWithFrame:CGRectMake(13, CGRectGetHeight(self.tableView.frame) - 144, MyKScreenWidth - 26, 44)];
    [bottomBtn setTitle:@"确认报名并支付" forState: UIControlStateNormal];
    bottomBtn.backgroundColor = CommonAppColor;
    [bottomBtn addTarget:self action:@selector(bottomBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomBtn.layer setMasksToBounds:YES];
    [bottomBtn.layer setCornerRadius:4.0]; //设置矩圆角半径
    // [bottomBtn.layer setBorderWidth:1.0];   //边框宽度
    [self.tableView addSubview:bottomBtn];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return self.titleArr.count;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat cellHeight;
    if (indexPath.section == 0) {
        cellHeight = 100;
    }else{
        cellHeight = 44;
    }
    return cellHeight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.backgroundColor = [UIColor whiteColor];
        
        
        if (indexPath.section == 0) {
    
            UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(13, 12,98, 76)];
            imgView.contentMode = 1;
            if (ValidStr(self.orderDetailModel.price)) {
                [imgView sd_setImageWithURL:[NSURL URLWithString:self.orderDetailModel.thumb_path] placeholderImage:[UIImage imageNamed:@"pic00"]];
            }else if (ValidStr(self.watHomeClassGoodsModel.thumb)){
                [imgView sd_setImageWithURL:[NSURL URLWithString:self.watHomeClassGoodsModel.thumb] placeholderImage:[UIImage imageNamed:@"pic00"]];
            }else{
                if (ValidStr(self.watHomeHotDetailsModel.thumb_path)) {
                    [imgView sd_setImageWithURL:[NSURL URLWithString:self.watHomeHotDetailsModel.thumb_path] placeholderImage:[UIImage imageNamed:@"pic00"]];
                }else{
                    [imgView sd_setImageWithURL:self.watHomeWillBeginClassModel.thumb_path placeholderImage:[UIImage imageNamed:@"pic00"]];
                }
            }
            
            
            [imgView.layer setMasksToBounds:YES];
            [imgView.layer setCornerRadius:4.0]; //设置矩圆角半径
            //[imgView.layer setBorderWidth:1.0];
            [cell addSubview:imgView];
            
            UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(imgView.frame.origin.x + imgView.frame.size.width + 22, CGRectGetMinY(imgView.frame), MyKScreenWidth - CGRectGetMaxX(imgView.frame) - 22 - 30, 20)];
            if (ValidStr(self.orderDetailModel.price)) {
                titleLab.text = self.orderDetailModel.title;
            }else if (ValidStr(self.watHomeClassGoodsModel.thumb)){
                titleLab.text = self.watHomeClassGoodsModel.title;
            }else{
                if (ValidStr(self.watHomeHotDetailsModel.title)) {
                    titleLab.text = self.watHomeHotDetailsModel.title;
                }else{
                    titleLab.text = self.watHomeWillBeginClassModel.title;
                }
            }
            
            titleLab.font = commenAppFont(13);
            titleLab.textColor = [UIColor blackColor];
            [cell addSubview:titleLab];
            
            UILabel *timeLab = [[UILabel alloc]initWithFrame:CGRectMake(titleLab.frame.origin.x, titleLab.frame.size.height + titleLab.frame.origin.y + 7, titleLab.frame.size.width, 9)];
            timeLab.font = commenAppFont(9);
            timeLab.textColor = [UIColor grayColor];
            if (ValidStr(self.orderDetailModel.price)) {
                timeLab.text = [NSString stringWithFormat:@"已售:%@",self.orderDetailModel.sale_num];
            }else if (ValidStr(self.watHomeClassGoodsModel.thumb)){
                timeLab.text = [NSString stringWithFormat:@"已售:%@",self.watHomeClassGoodsModel.sale_num];
            }else{
                if (ValidStr(self.watHomeHotDetailsModel.sale_num)) {
                    timeLab.text = [NSString stringWithFormat:@"已售:%@",self.watHomeHotDetailsModel.sale_num];
                }else{
                    timeLab.text = [NSString stringWithFormat:@"已售:%@",self.watHomeWillBeginClassModel.sale_num];
                }
            }
            
            
            [cell addSubview:timeLab];
            
            UILabel *moneyLab = [[UILabel alloc]initWithFrame:CGRectMake(timeLab.frame.origin.x, CGRectGetMaxY(imgView.frame) - 12, 100, 12)];
            if (ValidStr(self.orderDetailModel.price)) {
                moneyLab.text = [NSString stringWithFormat:@"¥%@",self.orderDetailModel.price];
            }else if (ValidStr(self.watHomeClassGoodsModel.thumb)){
                moneyLab.text = [NSString stringWithFormat:@"¥%@",self.watHomeClassGoodsModel.price];
            }else{
                if (ValidStr(self.watHomeHotDetailsModel.price)) {
                    moneyLab.text = [NSString stringWithFormat:@"¥%@",self.watHomeHotDetailsModel.price];
                }else{
                    moneyLab.text = [NSString stringWithFormat:@"¥%@",self.watHomeWillBeginClassModel.price];
                }
            }
            
            
            moneyLab.font = commenAppFont(12);
            moneyLab.textColor = [UIColor redColor];
            [cell addSubview:moneyLab];
        }else{
            cell.textLabel.text = self.titleArr[indexPath.row];
            if (indexPath.row == 0) {
                UITextField *textField0 = [[UITextField alloc]initWithFrame:CGRectMake(100, 4, MyKScreenWidth - CGRectGetWidth(cell.textLabel.frame) - 120, 36)];
                self.textField0 = textField0;
                textField0.delegate = self;
                [cell addSubview:textField0];
                textField0.borderStyle = UITextBorderStyleRoundedRect;
                textField0.placeholder = @"";
                textField0.textAlignment = NSTextAlignmentLeft;
                textField0.clearButtonMode=UITextFieldViewModeWhileEditing;
                textField0.font = commenAppFont(14);
                
                if (ValidStr(self.byClassUserModel.name)) {
                    self.textField0.text = self.byClassUserModel.name;
                }
                
            }else if (indexPath.row == 1){
                UITextField *textField1 = [[UITextField alloc]initWithFrame:CGRectMake(100, 4, MyKScreenWidth - CGRectGetWidth(cell.textLabel.frame) - 120, 36)];
                self.textField1 = textField1;
                textField1.delegate = self;
                [cell addSubview:textField1];
                textField1.borderStyle = UITextBorderStyleRoundedRect;
                textField1.placeholder = @"";
                textField1.textAlignment = NSTextAlignmentLeft;
                textField1.clearButtonMode=UITextFieldViewModeWhileEditing;
                textField1.font = commenAppFont(14);

                if (ValidStr(self.byClassUserModel.telephone)) {
                    self.textField1.text = self.byClassUserModel.telephone;
                }
                
            }else if (indexPath.row == 2){
                UILabel *adressLab = [[UILabel alloc]initWithFrame:CGRectMake(100, 4, MyKScreenWidth - CGRectGetWidth(cell.textLabel.frame) - 120, 36)];
                [cell addSubview:adressLab];
                if (ValidStr(self.byClassUserModel.address)) {
                    adressLab.text = [NSString stringWithFormat:@"  %@",self.byClassUserModel.address];
                }
                adressLab.textAlignment = NSTextAlignmentLeft;
                adressLab.font = commenAppFont(14)
                adressLab.layer.borderColor = [ColorWithRGB(230, 230, 230)CGColor];  //边框的颜色
                adressLab.layer.borderWidth = 0.5; //边框的宽度
                //给label的边框设置圆角
                adressLab.layer.masksToBounds = YES;
                adressLab.layer.cornerRadius = 4;  //设置圆角大小
            }
            else if (indexPath.row == 3){
                UITextField *textField4 = [[UITextField alloc]initWithFrame:CGRectMake(100, 4, MyKScreenWidth - CGRectGetWidth(cell.textLabel.frame) - 120, 36)];
                self.textField4 = textField4;
                textField4.delegate = self;
                [cell addSubview:textField4];
                textField4.borderStyle = UITextBorderStyleRoundedRect;
                textField4.placeholder = @"";
                textField4.textAlignment = NSTextAlignmentLeft;
                textField4.clearButtonMode=UITextFieldViewModeWhileEditing;
                textField4.font = commenAppFont(14);
                
                if (ValidStr(self.byClassUserModel.detailAddress)) {
                    self.textField4.text = self.byClassUserModel.detailAddress;
                }
                
            }else if (indexPath.row == 4){
                UITextField *textField2 = [[UITextField alloc]initWithFrame:CGRectMake(100, 4, MyKScreenWidth - CGRectGetWidth(cell.textLabel.frame) - 120, 36)];
                self.textField2 = textField2;
                textField2.delegate = self;
                [cell addSubview:textField2];
                textField2.borderStyle = UITextBorderStyleRoundedRect;
                textField2.placeholder = @"";
                textField2.textAlignment = NSTextAlignmentLeft;
                textField2.clearButtonMode=UITextFieldViewModeWhileEditing;
                textField2.font = commenAppFont(14);

                if (ValidStr(self.byClassUserModel.company)) {
                    self.textField2.text = self.byClassUserModel.company;
                }
                
            }else if (indexPath.row == 5){
                UITextField *textField3 = [[UITextField alloc]initWithFrame:CGRectMake(100, 4, MyKScreenWidth - CGRectGetWidth(cell.textLabel.frame) - 120, 36)];
                self.textField3 = textField3;
                textField3.delegate = self;
                [cell addSubview:textField3];
                textField3.borderStyle = UITextBorderStyleRoundedRect;
                textField3.placeholder = @"";
                textField3.textAlignment = NSTextAlignmentLeft;
                textField3.clearButtonMode=UITextFieldViewModeWhileEditing;
                textField3.font = commenAppFont(14);

                if (ValidStr(self.byClassUserModel.job)) {
                    self.textField3.text = self.byClassUserModel.job;
                }
                
            }
            
        }
        
        
        
    }
    
    
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//显示箭头
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];// （这种是没有点击后的阴影效果)
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1 && indexPath.row == 2) {
        [self zmjPickView];
        
        [_zmjPickView show];
        
        __weak typeof(self) weakSelf = self;
        _zmjPickView.determineBtnBlock = ^(NSInteger shengId, NSInteger shiId, NSInteger xianId, NSString *shengName, NSString *shiName, NSString *xianName){
            __strong typeof(weakSelf)strongSelf = weakSelf;
            [strongSelf ShengId:shengId ShiId:shiId XianId:xianId];
            [strongSelf ShengName:shengName ShiName:shiName XianName:xianName];
        };
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    if (section == 0) {
//        return 10;
//    }else{
//        return 30;
//    }
    return 10;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    if (section == 0) {
//        UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MyKScreenWidth, 35)];
//        v.backgroundColor = CommonAppColor;
//
//        UIView *shuLineView = [[UIView alloc]initWithFrame:CGRectMake(17, 9, 3, 20)];
//        shuLineView.backgroundColor = [UIColor whiteColor];
//        [v addSubview:shuLineView];
//
//        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(shuLineView.frame) + 5, 0, 100, 35)];
//        lab.text = @"订单商品";
//        lab.font = biaotiAppFont(20);
//        lab.textColor = [UIColor whiteColor];
//        [v addSubview:lab];
//        return v;
        return nil;
    }else{
//        UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 10, MyKScreenWidth, 20)];
//        v.backgroundColor = [UIColor whiteColor];
//
//        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MyKScreenWidth, 30)];
//        [headerView addSubview:v];

//        UIView *shuLineView = [[UIView alloc]initWithFrame:CGRectMake(16, 9, 3, 20)];
//        shuLineView.backgroundColor = [UIColor whiteColor];
//        [v addSubview:shuLineView];
//
//        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(shuLineView.frame) + 5, 0, 100, 35)];
//        lab.text = @"用户信息";
//        lab.font = biaotiAppFont(20);
//        lab.textColor = [UIColor whiteColor];
//        [v addSubview:lab];

        return nil;
        
    }

}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//
//    if (section == 1) {
//
//        UIView *footerV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MyKScreenWidth, 84)];
//
//        UIView *v1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MyKScreenWidth, 20)];
//        v1.backgroundColor = [UIColor whiteColor];
//        [footerV addSubview:v1];
//
//
//
//        return footerV;
//
//    }else{
//
//    }
    return nil;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    self.byClassUserModel.name = self.textField0.text;
    self.byClassUserModel.telephone = self.textField1.text;
    self.byClassUserModel.detailAddress = self.textField4.text;
    self.byClassUserModel.company = self.textField2.text;
    self.byClassUserModel.job = self.textField3.text;
    
}

//三级地址选择
- (void)ShengId:(NSInteger)shengId ShiId:(NSInteger)shiId XianId:(NSInteger)xianId{
    
    NSLog(@"%ld,%ld,%ld",shengId,shiId,xianId);
}

- (void)ShengName:(NSString *)shengName ShiName:(NSString *)shiName XianName:(NSString *)xianName{
    
    NSLog(@"%@,%@,%@",shengName,shiName,xianName);
    self.byClassUserModel.address = [NSString stringWithFormat:@"%@%@%@",shengName,shiName,xianName];
    [self.tableView reloadData];
}

- (void) bottomBtnClick{
    NSLog(@"点击了购买课程按钮");
    
    if (ValidStr(self.textField0.text) && ValidStr(self.textField1.text) && ValidStr(self.textField4.text) && ValidStr(self.byClassUserModel.address)) {
        
        if ([[ZWHHelper sharedHelper]isPhoneByMobileNum:self.textField1.text]) {
            NSLog(@"%@%@%@%@",self.textField0.text,self.textField1.text,self.textField2.text,self.textField3.text);
            
            NSArray *chooses = @[@"微信支付"];;
            
            [[ZWHHelper sharedHelper]alertActionSheet:chooses AndView:self withClickBlock:^(int clickInt, NSString *message) {
                if (clickInt == 0)
                {
                    //[MXWechatPayHandler jumpToWxPay];
                    
                    NSMutableDictionary *paramDic = [NSMutableDictionary new];
                    [paramDic setObject:self.byClassUserModel.name forKey:@"truename"];
                    [paramDic setObject:self.byClassUserModel.telephone forKey:@"tel"];
                    [paramDic setObject:@"1" forKey:@"num"];
                    if (ValidStr(self.orderDetailModel.price)) {
                        [paramDic setObject:self.orderDetailModel.id forKey:@"goods_id"];
                    }else if (ValidStr(self.watHomeClassGoodsModel.thumb)){
                        [paramDic setObject:self.watHomeClassGoodsModel.id forKey:@"goods_id"];
                    }else{
                        if (ValidStr(self.watHomeHotDetailsModel.goods_id)) {
                            NSLog(@"1");
                            [paramDic setObject:self.watHomeHotDetailsModel.goods_id forKey:@"goods_id"];
                        }else if (ValidStr(self.watHomeWillBeginClassModel.class_id)){
                            NSLog(@"2");
                            [paramDic setObject:self.watHomeWillBeginClassModel.class_id forKey:@"goods_id"];
                        }
                    }
                    
                    
                    [paramDic setObject:self.byClassUserModel.job forKey:@"job"];
                    [paramDic setObject:self.byClassUserModel.company forKey:@"company"];
                    NSString *addressStr = [NSString stringWithFormat:@"%@%@",self.byClassUserModel.address,self.byClassUserModel.detailAddress];
                    [paramDic setObject:addressStr forKey:@"address"];
                    
                    [WeChatModel asyncPostkApiOrderGoPayClassSuccessBlock:^(WeChatModel *wechatModel) {
                        self.wechatModel.weChatPayGetDetailModel = wechatModel.weChatPayGetDetailModel;
                        self.order_id = wechatModel.order_id;
                       // [MXWechatPayHandler jumpToWxPayBackDic:wechatModel.weChatPayGetDetailModel];
                        
                        
                        
                        PayReq *request = [[PayReq alloc] init];
                        request.openID = wechatModel.weChatPayGetDetailModel.appid;
                        request.partnerId = wechatModel.weChatPayGetDetailModel.partnerid;
                        request.prepayId = wechatModel.weChatPayGetDetailModel.prepayid;
                        request.package = wechatModel.weChatPayGetDetailModel.package;
                        request.nonceStr = wechatModel.weChatPayGetDetailModel.noncestr;
                        request.timeStamp = wechatModel.weChatPayGetDetailModel.timestamp;
                        request.sign = wechatModel.weChatPayGetDetailModel.sign;
                        
                        
//                        // 签名加密
//                        MXWechatSignAdaptor *md5 = [[MXWechatSignAdaptor alloc] init];
//
//                        request.sign=[md5 createMD5SingForPay:request.openID
//                                                    partnerid:request.partnerId
//                                                     prepayid:request.prepayId
//                                                      package:request.package
//                                                     noncestr:request.nonceStr
//                                                    timestamp:request.timeStamp];
                        
                        // 调用微信
                        [WXApi sendReq:request];
                        
                        
                    } errorBlock:^(NSError *errorResult) {
                        
                    } paramDic:paramDic urlStr:kApiOrderGoPayClass];
                    
                    
                }if (clickInt == 1)
                {
                    
                    
                }
                
            }];
        }else{
            [[ZWHHelper sharedHelper]addAlertViewControllerToView:self withClickBlock:^(int clickInt) {
                
            } title:@"提示" content:@"请输入正确的手机号码" cancleStr:@"" confirmStr:@"确定"];
        }
       
    }else{
        [[ZWHHelper sharedHelper]addAlertViewControllerToView:self withClickBlock:^(int clickInt) {
            
        } title:@"提示" content:@"请完善购买信息" cancleStr:@"" confirmStr:@"确定"];
    }
    
}


- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}
@end
