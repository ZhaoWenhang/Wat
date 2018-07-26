//
//  OrderDetailViewController.m
//  wat
//
//  Created by 123 on 2018/5/30.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "myClassListViewController.h"
#import "OrderModel.h"
#import "HomeBookChubanTableViewCell.h"
#import "ewmViewController.h"
#import "ClassDetailViewController.h"
#import "ByClassJianyiViewController.h"
@interface OrderDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *bottomBtn;//底部按钮
@property (nonatomic, strong) OrderDetailModel *orderDetailModel;
@end

@implementation OrderDetailViewController
- (OrderDetailModel *)orderDetailModel{
    if (!_orderDetailModel) {
        _orderDetailModel = [OrderDetailModel new];
    }
    return _orderDetailModel;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, MyTopHeight, MyKScreenWidth, MyKScreenHeight - MyTopHeight) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    }
    
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"订单详情";
    
    [self setAFN];
    
    [self addTableView];
    
//    UIButton *bottomBtn = [[UIButton alloc]initWithFrame:CGRectMake(13, MyKScreenHeight - MyTabBarHeight, MyKScreenWidth - 26, 42)];
//    [bottomBtn setTitle:@"再次购买" forState: UIControlStateNormal];
//    bottomBtn.backgroundColor = CommonAppColor;
//    [bottomBtn addTarget:self action:@selector(bottomBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:bottomBtn];
    
}
- (void)setAFN{
    NSMutableDictionary *paramDic = [NSMutableDictionary new];
    [paramDic setObject:self.order_id forKey:@"order_id"];
    __weak typeof (self)weakSelf = self;
    [OrderModel asyncPostkApiOrderDetailSuccessBlock:^(OrderModel *orderModel) {
        weakSelf.orderDetailModel = orderModel.orderDetailModel;
        [weakSelf.tableView reloadData];
    } errorBlock:^(NSError *errorResult) {
        
    } paramDic:paramDic urlStr:kApiOrderOrderDetail];
}
- (void)bottomBtnClick{
    
    ByClassJianyiViewController *byVc = [ByClassJianyiViewController new];
    byVc.navTitle = @"确认订单";
   // byVc.watHomeWillBeginClassModel = self.watHomeWillBeginClassModel;
    [self.navigationController pushViewController:byVc animated:YES];
    
}
- (void)addTableView {
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = WatBackColor;
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 8.0;
    [self.view addSubview:self.tableView];
    
    //在iOS 11上运行tableView向下偏移64px或者20px，因为iOS 11废弃了automaticallyAdjustsScrollViewInsets，而是给UIScrollView增加了contentInsetAdjustmentBehavior属性。避免这个坑的方法是要判断
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
}
#pragma UITableView 三问一答
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger sectionNum;
    if (section == 0) {
        sectionNum = 2;
    }else if (section == 1){
        sectionNum = 3;
    }else{
        sectionNum = 1;
    }
    return sectionNum;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * ID = @"cell";
    
    HomeBookChubanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"HomeBookChubanTableViewCell" owner:self options:nil]firstObject];
    }
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            UILabel *classNameLab = [[UILabel alloc]initWithFrame:CGRectMake(13, 15, MyKScreenWidth - 80, 15)];
            classNameLab.font = commenAppFont(15);
            classNameLab.text = self.orderDetailModel.title;
            [cell addSubview:classNameLab];
        }else{
            //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
            
            UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(13, 12, 76, 59)];
            imgView.contentMode = 1;
            NSURL *urlStr = [NSURL URLWithString:[NSString stringWithFormat:@"%@",self.orderDetailModel.thumb_path]];
            [imgView sd_setImageWithURL:urlStr placeholderImage:[UIImage imageNamed:@"pic00"]];
            [cell addSubview:imgView];
            
            UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imgView.frame) + 22, CGRectGetMinY(imgView.frame), MyKScreenWidth - CGRectGetWidth(imgView.frame) - 100, 20)];
            titleLab.text = self.orderDetailModel.subTitle;
            titleLab.font = commenAppFont(13);
            titleLab.textColor = [UIColor blackColor];
            [cell addSubview:titleLab];
            
            UILabel *timeLab = [[UILabel alloc]initWithFrame:CGRectMake(titleLab.frame.origin.x, titleLab.frame.size.height + titleLab.frame.origin.y + 7, titleLab.frame.size.width, 9)];
            timeLab.font = commenAppFont(9);
            timeLab.textColor = [UIColor grayColor];
            timeLab.text = [NSString stringWithFormat:@"开课时间:   %@",self.orderDetailModel.online_start];
            [cell addSubview:timeLab];
            
            UILabel *moneyLab = [[UILabel alloc]initWithFrame:CGRectMake(timeLab.frame.origin.x, timeLab.frame.origin.y + timeLab.frame.size.height + 10, 100, 12)];
            moneyLab.text = [NSString stringWithFormat:@"¥ %@",self.orderDetailModel.price ];
            moneyLab.font = commenAppFont(12);
            moneyLab.textColor = [UIColor blackColor];
            [cell addSubview:moneyLab];
        }
        
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            
            UILabel *tingkemaLab = [[UILabel alloc]initWithFrame:CGRectMake(13, 0, MyKScreenWidth - 13, cell.frame.size.height)];
            if ([self.orderDetailModel.shop_type_name isEqualToString:@"线下活动"]) {
                tingkemaLab.text = [NSString stringWithFormat:@"听课码:     (点击查看听课二维码)"];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//显示箭头
            }else{
                tingkemaLab.text = [NSString stringWithFormat:@"订单属性"];
            }
            
            tingkemaLab.textColor = CommonAppColor;
            tingkemaLab.font = commenAppFont(12);
            
            [cell addSubview:tingkemaLab];
        }else if (indexPath.row == 1) {
            UILabel *orderNumLab = [[UILabel alloc]initWithFrame:CGRectMake(13, 5, MyKScreenWidth - 13, cell.frame.size.height * 0.5)];
            orderNumLab.text = [NSString stringWithFormat:@"订单编号:  %@",self.orderDetailModel.order_no];
            orderNumLab.font = commenAppFont(12);
            [cell addSubview:orderNumLab];
            
            UILabel *orderTimeLab = [[UILabel alloc]initWithFrame:CGRectMake(13, cell.frame.size.height/2 + 5, MyKScreenWidth - 13, cell.frame.size.height * 0.5)];
            orderTimeLab.text = [NSString stringWithFormat:@"下单时间:  %@",self.orderDetailModel.create_time];
            orderTimeLab.font = commenAppFont(12);
            [cell addSubview:orderTimeLab];
            
        }else {
            UILabel * payTypeLab = [[UILabel alloc]initWithFrame:CGRectMake(13, 5, MyKScreenWidth - 13, cell.frame.size.height * 0.5)];
            NSString *paytypeStr;
            if ([self.orderDetailModel.shop_type_name isEqualToString:@"在线课程"]) {
                paytypeStr = @"余额支付";
            }else{
                paytypeStr = @"微信支付";
            }
            payTypeLab.text = [NSString stringWithFormat:@"支付方式:  %@",paytypeStr];
            payTypeLab.font = commenAppFont(12);
            [cell addSubview:payTypeLab];
            
            UILabel *payTimeLab = [[UILabel alloc]initWithFrame:CGRectMake(13, cell.frame.size.height/2 + 5, MyKScreenWidth - 13, cell.frame.size.height * 0.5)];
            payTimeLab.text = [NSString stringWithFormat:@"支付时间:  %@",self.orderDetailModel.create_time];
            payTimeLab.font = commenAppFont(12);
            [cell addSubview:payTimeLab];
        }
    }else{
        cell.backgroundColor = [UIColor clearColor];
        UIImageView *bgImgView = [[UIImageView alloc]initWithFrame:CGRectMake(-13, 0, MyKScreenWidth + 26, 170)];
        bgImgView.image = [UIImage imageNamed:@"多边形1094"];
        //bgImgView.contentMode = 3;
        [cell addSubview:bgImgView];
        
        UILabel *nameLab = [[UILabel alloc]initWithFrame:CGRectMake(13, 15, 200, 11)];
        nameLab.text = @"商品总额";
        nameLab.font = commenAppFont(12);
        [cell addSubview:nameLab];
        
        UILabel *numLab = [[UILabel alloc]initWithFrame:CGRectMake(13, 15 + 11 + 15, 200, 11)];
        numLab.text = @"购买数量";
        numLab.font = commenAppFont(12);
        [cell addSubview:numLab];
        
//        UILabel *yunfeiLab = [[UILabel alloc]initWithFrame:CGRectMake(13, 15 + 11 + 15 +11 + 15, 200, 11)];
//        yunfeiLab.text = @"运费";
//        yunfeiLab.font = commenAppFont(12);
//        [cell addSubview:yunfeiLab];
        
        UILabel *name2Lab = [[UILabel alloc]initWithFrame:CGRectMake(MyKScreenWidth - 200 - 13, nameLab.frame.origin.y, 200, 11)];
        name2Lab.text = [NSString stringWithFormat:@"¥ %@",self.orderDetailModel.price];
        name2Lab.font = commenAppFont(12);
        name2Lab.textAlignment = NSTextAlignmentRight;
        [cell addSubview:name2Lab];
        
        UILabel *num2Lab = [[UILabel alloc]initWithFrame:CGRectMake(MyKScreenWidth - 200 - 13, numLab.frame.origin.y,200, 11)];
        num2Lab.text = [NSString stringWithFormat:@"%@个",self.orderDetailModel.num];
        num2Lab.font = commenAppFont(12);
        num2Lab.textAlignment = NSTextAlignmentRight;
        [cell addSubview:num2Lab];
        
//        UILabel *yunfei2Lab = [[UILabel alloc]initWithFrame:CGRectMake(MyKScreenWidth - 200 - 13, yunfeiLab.frame.origin.y, 200, 11)];
//        yunfei2Lab.text = @"¥0.00";
//        yunfei2Lab.font = commenAppFont(12);
//        yunfei2Lab.textAlignment = NSTextAlignmentRight;
//        [cell addSubview:yunfei2Lab];
        
        UILabel *fengexianLab = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(numLab.frame) + 15, MyKScreenWidth, 0.2)];
        fengexianLab.backgroundColor = [UIColor grayColor];
        fengexianLab.alpha = 0.3;
        [cell addSubview:fengexianLab];
        
        UILabel *shijiMoney = [[UILabel alloc]initWithFrame:CGRectMake(13, fengexianLab.frame.origin.y + fengexianLab.frame.size.height + 15, 200, 16)];
        shijiMoney.text = @"实际付款";
        shijiMoney.font = commenAppFont(16);
        [cell addSubview:shijiMoney];
        
        UILabel *shijiMoney2 = [[UILabel alloc]initWithFrame:CGRectMake(MyKScreenWidth - 200 - 13, shijiMoney.frame.origin.y, 200, 16)];
        CGFloat money;
        money = self.orderDetailModel.price.floatValue * self.orderDetailModel.num.intValue;
        shijiMoney2.text = [NSString stringWithFormat:@"¥ %@",self.orderDetailModel.price];
        shijiMoney2.textAlignment = NSTextAlignmentRight;
        shijiMoney2.textColor = CommonAppColor;
        shijiMoney2.font = commenAppFont(16);
        [cell addSubview:shijiMoney2];
        
        UIImageView *shuiyingImgV = [[UIImageView alloc]initWithFrame:CGRectMake(100, 40, 88, 88)];
        shuiyingImgV.contentMode = 2;
        shuiyingImgV.image = [UIImage imageNamed:@"已使用"];
        //[cell addSubview:shuiyingImgV];
        
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];// （这种是没有点击后的阴影效果)

    ///<4.>设置单元格上显示的文字信息
   
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 && indexPath.row == 1) {
//        ClassDetailViewController *bookVC = [ClassDetailViewController new];
//        bookVC.urlStr = self.orderDetailModel.url;
//       // bookVC.is_sale = YES;
//        bookVC.urlStr = self.orderDetailModel.url;
//        bookVC.orderDetailModel = self.orderDetailModel;
//        bookVC.navTitle = @"课程详情页";
//        [self.navigationController pushViewController:bookVC animated:YES];
        
    }else if(indexPath.section == 1 && indexPath.row == 0){
        
        if ([self.orderDetailModel.shop_type_name isEqualToString:@"线下活动"]) {
            ewmViewController *vc = [[ewmViewController alloc]init];
            vc.imgUrl = self.orderDetailModel.ewm;
            //弹出控制器
            self.definesPresentationContext = YES;
            UIColor *color = [UIColor blackColor];
            vc.view.backgroundColor = [color colorWithAlphaComponent:0.7];
            vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            [self.navigationController presentViewController:vc animated:YES completion:nil];
        }
    }
}
- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat heightNum;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            heightNum = 45;
        }else{
            heightNum = 81;
        }
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            heightNum = 44;
        }else if (indexPath.row == 1) {
            heightNum = 50;
        }else {
            heightNum = 60;
        }
    }else{
        heightNum = 145;
    }
    
    return heightNum;
}
- (  CGFloat )tableView:(  UITableView *)tableView heightForHeaderInSection:( NSInteger )section
{
    return 0.01 ;
}
@end
