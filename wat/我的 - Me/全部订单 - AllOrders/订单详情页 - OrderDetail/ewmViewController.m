//
//  ewmViewController.m
//  wat
//
//  Created by 123 on 2018/7/4.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "ewmViewController.h"

@interface ewmViewController ()

@end

@implementation ewmViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(40, MyTopHeight + 80, MyKScreenWidth - 80, MyKScreenWidth - 80)];
    [imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.imgUrl]] placeholderImage:[UIImage imageNamed:@"pic00"]];
    imgView.contentMode = 2;
    [self.view addSubview:imgView];
    
    
    

    UIButton *closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(MyKScreenWidth - 70, MyTopHeight + 40, 40, 20)];
    [closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
    closeBtn.titleLabel.font = commenAppFont(18);
    [closeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:closeBtn];
    [closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
}


- (void)closeBtnClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
