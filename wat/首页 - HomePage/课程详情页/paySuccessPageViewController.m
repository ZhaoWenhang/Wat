//
//  paySuccessPageViewController.m
//  wat
//
//  Created by 123 on 2018/7/4.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "paySuccessPageViewController.h"
#import "OrderDetailViewController.h" //订单详情
@interface paySuccessPageViewController ()

@end

@implementation paySuccessPageViewController
- (WatHomeWillBeginClassModel *)watHomeWillBeginClassModel{
    if (!_watHomeWillBeginClassModel) {
        _watHomeWillBeginClassModel = [WatHomeWillBeginClassModel new];
    }
    return _watHomeWillBeginClassModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(40, MyTopHeight + 40, MyKScreenWidth - 80, 375)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 70, 70)];
    imgView.center = Center(CGRectGetWidth(bgView.frame) * 0.5 , 57);
    imgView.image = [UIImage imageNamed:@"成功"];
    imgView.contentMode = 2;
    [bgView addSubview:imgView];
    
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imgView.frame) + 18, CGRectGetWidth(bgView.frame), 16)];
    lab1.text = @"支付成功";
    lab1.font = commenAppFont(15);
    lab1.textAlignment = NSTextAlignmentCenter;
    lab1.textColor = [UIColor blackColor];
    [bgView addSubview:lab1];
    
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(lab1.frame) + 30, CGRectGetWidth(bgView.frame), 9)];
    if (ValidStr(self.orderDetailModel.id)) {
        lab2.text = self.orderDetailModel.add_time;
    }else if (ValidStr(self.watHomeClassGoodsModel.thumb)){
        lab2.text = self.watHomeClassGoodsModel.online_end;
    }else if (ValidStr(self.watHomeHotDetailsModel.goods_id)) {
        lab2.text = self.watHomeHotDetailsModel.add_time;
    }else{
        lab2.text = self.watHomeWillBeginClassModel.add_time;
    }
    
    lab2.font = commenAppFont(9);
    lab2.textAlignment = NSTextAlignmentCenter;
    lab2.textColor = [UIColor grayColor];
    [bgView addSubview:lab2];
    
    UILabel *lab3 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(lab2.frame) + 22, CGRectGetWidth(bgView.frame), 24)];
    
    if (ValidStr(self.orderDetailModel.id)) {
        lab3.text = [NSString stringWithFormat:@"¥%@",self.orderDetailModel.price];
    }else if (ValidStr(self.watHomeClassGoodsModel.thumb)){
        lab3.text = [NSString stringWithFormat:@"¥%@",self.watHomeClassGoodsModel.price];
    }else if (ValidStr(self.watHomeHotDetailsModel.goods_id)) {
        lab3.text = [NSString stringWithFormat:@"¥%@",self.watHomeHotDetailsModel.price];
    }else{
        lab3.text = [NSString stringWithFormat:@"¥%@",self.watHomeWillBeginClassModel.price];
    }
    
    lab3.font = commenAppFont(24);
    lab3.textAlignment = NSTextAlignmentCenter;
    lab3.textColor = [UIColor blackColor];
    [bgView addSubview:lab3];
    
    UILabel *lab4 = [[UILabel alloc]initWithFrame:CGRectMake(40, CGRectGetMaxY(lab3.frame) + 23, CGRectGetWidth(bgView.frame) - 80, 12)];
    if (ValidStr(self.orderDetailModel.id)) {
         lab4.text = [NSString stringWithFormat:@"%@",self.orderDetailModel.title];
    }else if (ValidStr(self.watHomeClassGoodsModel.thumb)){
        lab4.text = [NSString stringWithFormat:@"%@",self.watHomeClassGoodsModel.title];
    }else if (ValidStr(self.watHomeHotDetailsModel.goods_id)) {
        lab4.text = [NSString stringWithFormat:@"%@",self.watHomeHotDetailsModel.title];
    }else{
        lab4.text = [NSString stringWithFormat:@"%@",self.watHomeWillBeginClassModel.title];
    }
    
    lab4.numberOfLines = 1;
    lab4.font = commenAppFont(12);
    lab4.textAlignment = NSTextAlignmentCenter;
    lab4.textColor = [UIColor grayColor];
    [bgView addSubview:lab4];
    
    
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(23, CGRectGetHeight(bgView.frame) - 106, CGRectGetWidth(bgView.frame) - 46, 30)];
    btn.backgroundColor = CommonAppColor;
    [btn setTitle:@"查看详情" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.clipsToBounds = YES;
    btn.layer.cornerRadius = 4;
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:btn];
    
    UIButton *MoreBtn = [[UIButton alloc]initWithFrame:CGRectMake(23, CGRectGetHeight(bgView.frame) - 66, CGRectGetWidth(bgView.frame) - 46, 30)];
    MoreBtn.backgroundColor = CommonAppColor;
    [MoreBtn setTitle:@"更多产品" forState:UIControlStateNormal];
    [MoreBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    MoreBtn.clipsToBounds = YES;
    MoreBtn.layer.cornerRadius = 4;
    [MoreBtn addTarget:self action:@selector(MoreBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:MoreBtn];
    
}
- (void)btnClick{
   [self dismissViewControllerAnimated:YES completion:nil];
    [[NSNotificationCenter  defaultCenter]postNotificationName:@"backback" object:nil];  
}
- (void)MoreBtnClick{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [[NSNotificationCenter  defaultCenter]postNotificationName:@"backHome" object:nil];
}


@end
