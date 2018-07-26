//
//  FeedbackViewController.m
//  wat
//
//  Created by 123 on 2018/5/29.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "FeedbackViewController.h"
#import "UITextView+PlaceHolder.h"
@interface FeedbackViewController ()

@property (weak, nonatomic) UITextView *textView;

@property (weak, nonatomic) UILabel *wordLabel;



@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"反馈建议";
    self.rightTitles = @[@"确定"];
    self.view.backgroundColor =WatBackColor;
    UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(10, MyTopHeight + 10, MyKScreenWidth - 20, 100)];
    self.textView = textView;
    [self.view addSubview:textView];
    
    UILabel *wordLabel = [[UILabel alloc]initWithFrame:CGRectMake(textView.frame.size.width - 50, textView.frame.size.height - 20, 50, 20)];
    self.wordLabel = wordLabel;
    wordLabel.textAlignment = 2;
    wordLabel.textColor = [UIColor grayColor];
    wordLabel.font = commenAppFont(12);
    [textView addSubview:wordLabel];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewEditChanged:) name:UITextViewTextDidChangeNotification object:nil];
    
    self.textView.placeholder = @"说点什么吧!";
    self.wordLabel.text = @"250";
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bgViewclick)];
    [self.view addGestureRecognizer:tap];
    
    
    
    
}


- (void)bgViewclick{
    [self.textView resignFirstResponder];
}
- (void)rightBtnsAction:(UIButton *)button{
    if (ValidStr(self.textView.text)) {
        [[ZWHHelper sharedHelper]addAlertViewControllerToView:self withClickBlock:^(int clickInt) {
            if (clickInt == 1) {
                NSMutableDictionary *paramDic = [NSMutableDictionary new];
                [paramDic setObject:self.textView.text forKey:@"content"];
                [Request POST:kApiSiteProposal parameters:paramDic success:^(id responseObject) {
                    [WATHud showSuccess:@"发表成功!"];
                    [self.navigationController popViewControllerAnimated:YES];
                } failure:^(NSError *error) {
                    
                }];
            }
        } title:@"提示" content:@"内容无误并发送?" cancleStr:@"再改一下" confirmStr:@"无误并发送"];
        
    }else{
        [[ZWHHelper sharedHelper]addAlertViewControllerToView:self withClickBlock:^(int clickInt) {
            
        } title:@"提示" content:@"内容为空!" cancleStr:@"" confirmStr:@"确定"];
    }
}
- (void)textViewEditChanged:(NSNotification*)obj {
    UITextView *textView = self.textView;
    NSString *textStr = textView.text;
    NSInteger fontNum = 250 - textStr.length;
    fontNum = fontNum < 0 ? 0 : fontNum;
    self.wordLabel.text = [NSString stringWithFormat:@"%@",@(fontNum)];
    if (textStr.length > 250) {
        textView.text = [textStr substringToIndex:250];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
