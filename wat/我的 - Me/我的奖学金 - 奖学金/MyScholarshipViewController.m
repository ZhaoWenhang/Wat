//
//  MyScholarshipViewController.m
//  wat
//
//  Created by 123 on 2018/6/21.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#define headerViewHeight 240

#import "MyScholarshipViewController.h"
#import "MyScholarshipTableViewCell.h"
#import "ZWHCountingLabel.h"
@interface MyScholarshipViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
    
}
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation MyScholarshipViewController
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, MyTopHeight, MyKScreenWidth, MyKScreenHeight - MyTopHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navTitle = @"我的奖学金";
    [self addTableView];
}
- (void)addTableView{
    
    [self.view addSubview:self.tableView];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"cell";
    MyScholarshipTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MyScholarshipTableViewCell" owner:self options:nil]firstObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 145;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MyKScreenWidth, headerViewHeight)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    /**
     数字滚动
     */
    //_moneyStr
    
    ZWHCountingLabel *myLabel = [[ZWHCountingLabel alloc] initWithFrame:CGRectMake(40, 50, headerView.frame.size.width - 80, 40)];
    myLabel.font = [UIFont fontWithName:@"Avenir Next" size:38];
    myLabel.textColor = [UIColor blackColor];
    myLabel.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:myLabel];
    //设置文本样式
    //整数
    myLabel.format = @"%d";
    //浮点数样式数字
    myLabel.format = @"%.2f";
    //设置变化范围及动画时间
    //整数
    [myLabel countFrom:0 to:100 withDuration:3.0f];
    //浮点数
    [myLabel countFrom:0.00 to:4324.12 withDuration:3.0f];
    myLabel.positiveFormat = @"###,##0.00";
    myLabel.adjustsFontSizeToFitWidth=YES;
    
    UILabel *miaoshuLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, MyKScreenWidth, 12)];
    miaoshuLab.center = Center(headerView.center.x, myLabel.frame.size.height + myLabel.frame.origin.y + 10);
    miaoshuLab.textAlignment = NSTextAlignmentCenter;
    NSString *money02Str = [NSString stringWithFormat:@"今天收益:%@元",@"200"];
    miaoshuLab.text =  money02Str;
    miaoshuLab.textColor = [UIColor redColor];
    miaoshuLab.font = commenAppFont(12);
    miaoshuLab.adjustsFontSizeToFitWidth = YES;
    [headerView addSubview:miaoshuLab];
    
    UIButton *tixianBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, MyKScreenWidth *0.33, 40)];
    tixianBtn.center = Center(MyKScreenWidth * 0.5, CGRectGetMaxY(miaoshuLab.frame)+ 55);
    tixianBtn.backgroundColor = CommonAppColor;
    [tixianBtn setTitle:@"提现" forState: UIControlStateNormal];
    [tixianBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    tixianBtn.layer.cornerRadius = 4;
    tixianBtn.clipsToBounds = YES;
    [tixianBtn addTarget:self action:@selector(tixianBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:tixianBtn];
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(13, CGRectGetMaxY(headerView.frame) - 25, 200, 16)];
    titleLab.text = @"邀请好友赚学费";
    titleLab.font = commenAppFont(16);
    [headerView addSubview:titleLab];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(13, CGRectGetMaxY(headerView.frame) - 1, MyKScreenWidth - 13, 1)];
    lineView.backgroundColor = WatBackColor;
    [headerView addSubview:lineView];
    
    return headerView;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return headerViewHeight;
}
- (void)tixianBtnClick{
    NSLog(@"点击了提现按钮");
    
}
@end
