//
//  MeSettingViewController.m
//  wat
//
//  Created by 123 on 2018/6/11.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "MeSettingViewController.h"
#import "MeSettingTableViewCell.h"
#import "JHUploadImage.h"
#import "ZmjPickView.h"



@interface MeSettingViewController ()<UITableViewDelegate,UITableViewDataSource,JHUploadImageDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *messageArr;//cell数据源
@property (nonatomic, strong) UIImage *headerViewImg;
@property (nonatomic, strong) ZmjPickView *zmjPickView;//三级地址选择
@property (nonatomic, strong) NSString *addressSanjiStr; //三级名称
@property (nonatomic, strong) WatUserInfoModel *userModel;

@property (nonatomic, strong) NSString *uploadImgUrlStr; //上传给后台的 head_pic
@property (nonatomic, strong) NSString *head_pic;   //存本地的  head_pic
@end

@implementation MeSettingViewController
-(WatUserInfoModel *)userModel{
    if (!_userModel) {
        _userModel = [WatUserInfoModel new];
    }
    return _userModel;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, MyTopHeight, MyKScreenWidth, MyKScreenHeight - MyTopHeight)style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        //_tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
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
    [self setAFN];
    self.rightTitles = @[@"保存"];
    //页面数据
    //界面加载数据
    NSString *path= [[NSBundle mainBundle]pathForResource:@"meSet" ofType:@"plist"];
    _messageArr = [NSArray arrayWithContentsOfFile:path];
    
    

    [self addTableView];
    //在iOS 11上运行tableView向下偏移64px或者20px，因为iOS 11废弃了automaticallyAdjustsScrollViewInsets，而是给UIScrollView增加了contentInsetAdjustmentBehavior属性。避免这个坑的方法是要判断
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
}

- (void) setAFN{
    
    __weak typeof (self)weakSelf = self;
    [WatUserInfoModel asyncPostUserInfoSuccessBlock:^(WatUserInfoModel *watUserInfoModel) {
        self.userModel = watUserInfoModel;
        [weakSelf.tableView reloadData];
    } errorBlock:^(NSError *errorResult) {
        
    } paramDic:nil urlStr:kApiUserUserInfo];
    
    
}

- (void)addTableView {
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = WatBackColor;
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 8.0;
    [self.view addSubview:self.tableView];
    
}
#pragma UITableView 三问一答
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _messageArr.count;
}
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray *arr;
    for (int i = 0; i < _messageArr.count; i++) {
        if (section == i) {
            arr = _messageArr[i];
        }
    }
    //NSLog(@"--------%ld",arr.count);
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"Cell";
    MeSettingTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MeSettingTableViewCell" owner:self options:nil]firstObject];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone]; //（这种是没有点击后的阴影效果)
    
    
    NSArray *arr = _messageArr[indexPath.section];
    NSDictionary *dic = arr[indexPath.row];
    
    cell.cellNameLab.text = [dic valueForKey:@"cellName"];
    cell.CellRightLab.text = @"";
    cell.cellRightTextField.delegate = self;
    if (indexPath.section == 0) {
        if ([self.navTitle isEqualToString:@"购买信息"]) {
            
        }else{
            cell.cellNameLab.hidden = NO;
            cell.cellrightBtn.hidden = NO;

            cell.cellNameLab.frame = CGRectMake(15, 0, MyKScreenWidth, 73);
            cell.cellrightBtn.frame = CGRectMake(MyKScreenWidth - 50, (73 - 40) / 2, 40, 40);
            if (!ValidStr(self.userModel.head_pic)) {
                [cell.cellrightBtn setImage:[UIImage imageNamed:@"headerPic00"] forState:UIControlStateNormal];
            }else{

               // [cell.cellrightBtn setImage:self.headerViewImg forState:UIControlStateNormal];
                [cell.cellrightBtn sd_setImageWithURL:[NSURL URLWithString:self.userModel.head_pic] forState:UIControlStateNormal];
            }
        }
        
        
    }else if (indexPath.section == 1){
        cell.cellNameLab.hidden = NO;
        cell.CellRightLab.hidden = NO;
        cell.cellRightTextField.hidden = NO;
        if (indexPath.row == 0) {
            cell.cellRightTextField.hidden = YES;
            cell.CellRightLab.text = self.userModel.address;
        }else if (indexPath.row == 1){
            cell.cellRightTextField.text = self.userModel.truename;
            cell.cellRightTextField.tag = 0;
        }else if (indexPath.row == 2){
            cell.cellRightTextField.hidden = YES;
            NSString *sexStr;
            if ([self.userModel.sex isEqualToString:@"1"]) {
                sexStr = @"男";
            }else if ([self.userModel.sex isEqualToString:@"2"]){
                sexStr = @"女";
            }
            cell.CellRightLab.text = sexStr;
        }else if (indexPath.row == 3){
            cell.cellRightTextField.tag = 1;
            cell.cellRightTextField.text = self.userModel.phone;
        }
    }
    else{
        cell.cellNameLab.hidden = NO;
        cell.cellRightTextField.hidden = NO;
        cell.CellRightLab.hidden = YES;
        if (indexPath.row == 0) {
            cell.cellRightTextField.tag = 2;
            cell.cellRightTextField.text = self.userModel.company;
        }else{
            cell.cellRightTextField.tag = 3;
            cell.cellRightTextField.text = self.userModel.job;
        }
        
    }
    

    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        [JHUPLOAD_IMAGE showActionSheetInFatherViewController:self delegate:self];
    }else if (indexPath.section == 1 && indexPath.row == 0){
        [self zmjPickView];
        
        [_zmjPickView show];
        
        __weak typeof(self) weakSelf = self;
        _zmjPickView.determineBtnBlock = ^(NSInteger shengId, NSInteger shiId, NSInteger xianId, NSString *shengName, NSString *shiName, NSString *xianName){
            __strong typeof(weakSelf)strongSelf = weakSelf;
            [strongSelf ShengId:shengId ShiId:shiId XianId:xianId];
            [strongSelf ShengName:shengName ShiName:shiName XianName:xianName];
        };
        
    }else if (indexPath.section == 1 && indexPath.row == 2){
        NSArray *chooseArr = @[@"男",@"女"];
        [[ZWHHelper sharedHelper]alertActionSheet:chooseArr withClickBlock:^(int clickInt, NSString *message) {
            if (clickInt == 0) {
                self.userModel.sex = @"1";
            }else if (clickInt == 1){
                self.userModel.sex = @"2";
            }
                [self.tableView reloadData];
        }];
    }
    
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if ([self.navTitle isEqualToString:@"购买信息"]) {
            return 0;
        }else{
            return 60;
        }
    }else{
        return 44;
        
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if ([self.navTitle isEqualToString:@"购买信息"]) {
        if (section==0) {
            return 0.01;
        }else{
            return 60;
        }
    }else{
        if (section==0) {
            return 0.01;
        }else{
            return 10;
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
}

#pragma UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField{
switch (textField.tag) {
        
    case 0:
        
    {
        
        self.userModel.truename = textField.text;
        
    }
        
        break;
        
    case 1:
        
    {
        
        self.userModel.phone= textField.text;
        
    }
        
        break;
        
    case 2:
        
    {
        
        self.userModel.company= textField.text;
        
    }
        
        break;
        
    case 3:
        
    {
        
        self.userModel.job= textField.text;
        
    }
        
    default:
        break;
        
}
    
}




//三级地址选择
- (void)ShengId:(NSInteger)shengId ShiId:(NSInteger)shiId XianId:(NSInteger)xianId{
    
    NSLog(@"%ld,%ld,%ld",shengId,shiId,xianId);
}

- (void)ShengName:(NSString *)shengName ShiName:(NSString *)shiName XianName:(NSString *)xianName{
    
    NSLog(@"%@,%@,%@",shengName,shiName,xianName);
    self.userModel.address = [NSString stringWithFormat:@"%@%@%@",shengName,shiName,xianName];
    [self.tableView reloadData];
}


-(void)rightBtnsAction:(UIButton *)button{
    [self.view endEditing:YES];//这样为了防止键盘在一个textField的时候，点击提交的时候，textField的数据没有保存到model中
   
    NSMutableDictionary *paramDic = [NSMutableDictionary new];
    [paramDic setObject:self.userModel.head_pic forKey:@"head_pic"];
    [paramDic setObject:self.userModel.address forKey:@"address"];
    [paramDic setObject:self.userModel.truename forKey:@"truename"];
    [paramDic setObject:self.userModel.sex forKey:@"sex"];
    [paramDic setObject:self.userModel.phone forKey:@"phone"];
    [paramDic setObject:self.userModel.company forKey:@"company"];
    [paramDic setObject:self.userModel.job forKey:@"job"];
    
    
    [WatUserInfoModel asyncPostSetUserInfoSuccessBlock:^(WatUserInfoModel *watUserInfoModel) {
        
        [WatUserInfoManager saveInfo:watUserInfoModel];//存入本地
        [WATHud showSuccess:@"保存成功"];
        [self.navigationController popViewControllerAnimated:YES];
        
    } errorBlock:^(NSError *errorResult) {
        
    } paramDic:paramDic urlStr:kApiUserSetUserInfo];
    
}



/**
 头像选取
 
 @param image 剪裁后的图片
 @param originImage 原图
 */
-(void)uploadImageToServerWithImage:(UIImage *)image OriginImage:(UIImage *)originImage
{
    NSLog(@"%@\n%@",originImage,image);
    

    NSData *imageData = nil;
    NSString *mimeType = nil;
    if ([self imageHasAlpha:image]) {
        imageData = UIImagePNGRepresentation(image);
        mimeType = @"image/png";
    } else {
        imageData = UIImageJPEGRepresentation(image, 0.1f);
        mimeType = @"image/jpeg";
    }

    NSData *base64Data = [imageData base64EncodedDataWithOptions:0];
    NSString *baseString = [[NSString alloc]initWithData:base64Data encoding:NSUTF8StringEncoding];

    NSString *encodedImageStr = [NSString stringWithFormat:@"data:%@;base64,%@",mimeType,baseString];
    
    NSString *paramStrBase64 = [encodedImageStr base64EncodedString];
    
    NSLog(@"encodedImageStr== %@",encodedImageStr);

    [Request POSTImageData:KapiPublicUploadPicTagHeaderPic parameters:paramStrBase64 image:image success:^(id responseObject) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSDictionary *dataDic = dic[@"result"][@"data"];
        self.uploadImgUrlStr = dataDic[@"path"];
        self.userModel.head_pic = dataDic[@"ab_path"];
        [self.tableView reloadData];
    } failure:^(NSError *error) {

    }];
    
    

}

- (BOOL)imageHasAlpha:(UIImage *)image
{
    CGImageAlphaInfo alpha = CGImageGetAlphaInfo(image.CGImage);
    return (alpha == kCGImageAlphaFirst ||
            alpha == kCGImageAlphaLast ||
            alpha == kCGImageAlphaPremultipliedFirst ||
            alpha == kCGImageAlphaPremultipliedLast);
}




@end
