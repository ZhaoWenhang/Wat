//
//  ZWHHelper.m
//  wat
//
//  Created by 123 on 2018/6/6.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "ZWHHelper.h"
#import "WatLoginViewController.h"
#import <YYKit/YYKit.h>
#import "UIImageView+WebCache.h"
#import<CommonCrypto/CommonDigest.h>
//使用前需要导入头文件 - 图片模糊处理vImage
#import <Accelerate/Accelerate.h>



@interface ZWHHelper()
@property (nonatomic, strong) UIButton *blurView;
@property (nonatomic, strong) UIView *alertView;
@property (nonatomic, strong) UIButton *clearView;
@property (nonatomic, strong)UIButton *deleateText;
@property (nonatomic, strong) UIButton *handerView;

@property (nonatomic, strong)UIButton *buttonSelect;
@property (nonatomic, strong)UIButton *endbutton;
@end
@implementation ZWHHelper{
    UIButton *_fireButton;
    int _timerTarget;
    int _timerCount;
    NSString *_vCode;
    int _vCodeTimeOut;
    NSTimer *_verfityEnableTimer;
    
    UIButton *_csrzNoneButton;
    UILabel *_csrzNoneLable;
}
- (UIButton *)deleateText
{
    if (!_deleateText) {
        _deleateText = [[UIButton alloc]init];
    }
    return _deleateText;
}
- (NSMutableDictionary *)assectDic
{
    if (!_assectDic) {
        _assectDic = [NSMutableDictionary dictionary];
    }
    return _assectDic;
}
- (NSMutableArray *)danbaoInfos
{
    if (!_danbaoInfos) {
        _danbaoInfos = [NSMutableArray array];
    }
    return _danbaoInfos;
}
+ (instancetype)sharedHelper{
    static ZWHHelper *_sessionManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sessionManager = [[self alloc]init];
        _sessionManager.blurEnable = YES;
    });
    return _sessionManager;
}
- (void)hideClearView{
    [_clearView removeFromSuperview];
    _clearView = nil;
}


//- (void)addAlertViewControllerToView:(UIView *)toView withClickBlock:(alertClickBlock)clickBlock title:(NSString *)title content:(NSString *)content cancleStr:(NSString *)cancleStr confirmStr:(NSString *)confirmStr animated:(BOOL)animated blurEnable:(BOOL)enable{
//    _blurEnable = enable;
//    [self addAlertViewControllerToView:toView withClickBlock:clickBlock title:title content:content cancleStr:cancleStr confirmStr:confirmStr];
//}
- (void)addAlertViewControllerToView:(UIViewController *)toView withClickBlock:(alertClickBlock)clickBlock title:(NSString *)title content:(NSString *)content cancleStr:(NSString *)cancleStr confirmStr:(NSString *)confirmStr{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:content preferredStyle:UIAlertControllerStyleAlert];
    
   
    
    if (ValidStr(cancleStr)) {
        UIAlertAction *alert1 = [UIAlertAction actionWithTitle:cancleStr style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [alert1 setValue:CommonAppColor forKey:@"_titleTextColor"];
            if (clickBlock) {
                clickBlock(0);
            }
        }];
        [alert addAction:alert1];
    }
    UIAlertAction *alert2 = [UIAlertAction actionWithTitle:confirmStr style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alert2 setValue:CommonAppColor forKey:@"_titleTextColor"];
        if (clickBlock) {
            clickBlock(1);
        }
    }];
    [alert addAction:alert2];
    [toView presentViewController:alert animated:YES completion:nil];
    
    return;
    
    //@weakify(self)
    //    [self addBlurViewToView:toView frame:CGRectZero withHideBlock:^{
    //        [weak_self hideBlurAnimated:YES];
    //    } ];
    //    _alertView = [UIView new];
    //    _alertView.backgroundColor = [UIColor whiteColor];
    //    _alertView.layer.cornerRadius = 10;
    //    _alertView.clipsToBounds = YES;
    //    [_blurView addSubview:_alertView];
    //
    //    [_alertView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.equalTo(weak_self.blurView).with.offset(25);
    //        make.right.equalTo(weak_self.blurView).with.offset(-25);
    //        make.height.mas_equalTo(107);
    //        make.centerY.equalTo(weak_self.blurView);
    //    }];
    //
    //    if (ValidStr(title)) {
    //        UILabel *titleLable = [UILabel new];
    //        titleLable.textAlignment = NSTextAlignmentCenter;
    //        titleLable.font = [UIFont systemFontOfSize:16];
    //        titleLable.textColor = ZWYAlertTextColor;
    //        titleLable.text = title;
    //        titleLable.adjustsFontSizeToFitWidth = YES;//设置字体大小随字体数量变化
    //
    //        [_alertView addSubview:titleLable];
    //
    //        [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
    //            make.left.right.equalTo(_alertView);
    //            make.top.equalTo(_alertView).with.offset(20);
    //            make.height.mas_equalTo(20);
    //        }];
    //
    //        if (ValidStr(content)) {
    //            UILabel *contentLable = [UILabel new];
    //            contentLable.textColor = ZWYAlertTextColor;
    //            contentLable.textAlignment = NSTextAlignmentCenter;
    //            contentLable.text = content;
    //            contentLable.font = [UIFont systemFontOfSize:13];
    //            contentLable.adjustsFontSizeToFitWidth = YES;//设置字体大小随字体数量变化
    //            [_alertView addSubview:contentLable];
    //
    //            [contentLable mas_makeConstraints:^(MASConstraintMaker *make) {
    //                make.left.equalTo(_alertView).with.offset(16);
    //                make.right.equalTo(_alertView).with.offset(-16);
    //                make.bottom.equalTo(_alertView).with.offset(-55);
    //                make.top.equalTo(titleLable.mas_bottom).with.offset(5);
    //            }];
    //        }
    //    }else{
    //        if (ValidStr(content)) {
    //            UILabel *contentLable = [UILabel new];
    //            contentLable.numberOfLines = 0;
    //            contentLable.textColor = ZWYAlertTextColor;
    //            contentLable.textAlignment = NSTextAlignmentCenter;
    //            contentLable.text = content;
    //            contentLable.font = [UIFont systemFontOfSize:15];
    //            [_alertView addSubview:contentLable];
    //
    //            [contentLable mas_makeConstraints:^(MASConstraintMaker *make) {
    //                make.left.equalTo(_alertView).with.offset(16);
    //                make.right.equalTo(_alertView).with.offset(-16);
    //                make.bottom.equalTo(_alertView).with.offset(-44.5);
    //                make.top.equalTo(_alertView);
    //            }];
    //        }
    //    }
    //
    //
    //
    //
    //    UIView *horizLineView = [UIView new];
    //    horizLineView.backgroundColor = ColorWithRGB(238, 238, 238);
    //    [_alertView addSubview:horizLineView];
    //    [horizLineView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.right.equalTo(_alertView);
    //        make.bottom.equalTo(_alertView).with.offset(-44);
    //        make.height.mas_equalTo(0.5);
    //    }];
    //
    //
    //    UIButton *confirmButton = [UIButton new];
    //    [confirmButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
    //        if (clickBlock) {
    //            clickBlock(1);
    //        }
    //        if (_blurEnable) {
    //            [weak_self hideBlurAnimated:YES];
    //        }
    //
    //    }];
    //    confirmButton.backgroundColor = CommonAppColor;
    //    confirmButton.titleLabel.font = [UIFont systemFontOfSize:15];
    //    [confirmButton setTitle:confirmStr forState:UIControlStateNormal];
    //    [confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    [_alertView addSubview:confirmButton];
    //
    //    if (ValidStr(cancleStr)) {
    //        UIButton *cancleButton = [UIButton new];
    //        [cancleButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
    //            if (clickBlock) {
    //                clickBlock(0);
    //            }
    //            if (_blurEnable) {
    //                [weak_self hideBlurAnimated:YES];
    //            }
    //
    //        }];
    //        cancleButton.backgroundColor = [UIColor whiteColor];
    //        cancleButton.titleLabel.font = [UIFont systemFontOfSize:15];
    //        [cancleButton setTitle:cancleStr forState:UIControlStateNormal];
    //        [cancleButton setTitleColor:ZWYAlertTextColor forState:UIControlStateNormal];
    //        [_alertView addSubview:cancleButton];
    //
    //        [cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
    //            make.left.bottom.equalTo(_alertView);
    //            make.size.mas_equalTo(CGSizeMake((MyKScreenWidth - 50) / 2, 44));
    //        }];
    //        [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
    //            make.right.bottom.equalTo(_alertView);
    //            make.size.mas_equalTo(cancleButton);
    //        }];
    //
    //    }else{
    //
    //        [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
    //            make.right.bottom.equalTo(_alertView);
    //            make.size.mas_equalTo(CGSizeMake(MyKScreenWidth - 50, 44));
    //        }];
    //
    //    }
    
    
    
    
}
- (void)addClearViewToView:(UIView *)toView{
    
    if (!_clearView) {
        _clearView = [UIButton new];
        _clearView.backgroundColor = [UIColor clearColor];
        _clearView.frame = toView.bounds;
        [toView addSubview:_clearView];
    }
    
}

- (void)addBlurViewToView:(UIView *)toView frame:(CGRect)blurFrame withHideBlock:(blurHideBlockBlock)hide animated:(BOOL)animated{
    if (CGRectEqualToRect(blurFrame, CGRectZero)) {
        
        _blurView = [[UIButton alloc]initWithFrame:toView.bounds];
    }else{
        
        _blurView = [[UIButton alloc]initWithFrame:blurFrame];
    }
    _blurView.alpha = 0.5f;
    [_blurView setImage:[[toView snapshotImageAfterScreenUpdates:NO]imageByBlurDark] forState:UIControlStateNormal];
    [_blurView setImage:[[toView snapshotImageAfterScreenUpdates:NO]imageByBlurDark] forState:UIControlStateHighlighted];
    @weakify(self)
    [_blurView addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
        @strongify(self)
        if (self.blurEnable) {
            if (hide) {
                hide();
            }
        }
        
    }];
    [toView addSubview:_blurView];
    
    if (animated) {
        [UIView animateWithDuration:0.25f delay:0.0f options:UIViewAnimationOptionCurveLinear animations:^{
            _blurView.alpha = 0.9f;
        } completion:^(BOOL finished) {
        }];
    }else{
        
        _blurView.alpha = 0.9f;
    }
    
    
}
- (void)hideBlurAnimated:(BOOL)animated{
    if (animated) {
        [UIView animateWithDuration:0.25f delay:0.0f options:UIViewAnimationOptionCurveLinear animations:^{
            _blurView.alpha = 0.f;
        } completion:^(BOOL finished) {
            [_blurView removeFromSuperview];
            _blurView = nil;
        }];
    }else{
        _blurView.alpha = 0.0f;
        [_blurView removeFromSuperview];
        _blurView = nil;
    }
    
}
+ (WatTabBarController *)rootTabbarViewController{
    WatTabBarController *rootVC = (WatTabBarController *)[UIApplication sharedApplication].delegate.window.rootViewController;
    return rootVC;
}

+ (NSString *)getStringReplaceColonWithSpace:(NSString *)originalStr{//获取navTitle
    return [originalStr stringByReplacingOccurrencesOfString:@"：" withString:@""];
}
-(void)startCountWithButton:(UIButton *)btn{
    btn.userInteractionEnabled = NO;
    [self fireTimeWithButton:btn];
    _fireButton = btn;
    _fireButton.backgroundColor = [UIColor lightGrayColor];
}
- (void)fireTimeWithButton:(UIButton*)btn
{
    _timerTarget = 120;
    _timerCount = 0;
    
    _vCodeTimeOut = 0;
    _vCode = nil;
    
    NSString *str = [NSString stringWithFormat:@"%d秒后重试", _timerTarget];
    
    btn.enabled = NO;
    [btn setTitle:str forState:UIControlStateDisabled];
    
    [self scheduleProcessTimer];
}
- (void)stopTime
{
    [_verfityEnableTimer invalidate];
}
- (void)scheduleProcessTimer{
    [_verfityEnableTimer invalidate];
    _verfityEnableTimer = [NSTimer scheduledTimerWithTimeInterval:1.f
                                                           target:self
                                                         selector:@selector(processTimerDidFire:)
                                                         userInfo:nil
                                                          repeats:YES];
}
- (void)processTimerDidFire:(id)sender {
    
    _timerCount++;
    if(_timerCount == _timerTarget)
    {
        _timerCount = 0;
        [_verfityEnableTimer invalidate];
        
        _fireButton.enabled = YES;
        _fireButton.userInteractionEnabled = YES;
        [_fireButton setTitle:@"点击重试" forState:UIControlStateNormal];
        _fireButton.backgroundColor = CommonAppColor;
    }
    else
    {
        NSString *lab = [NSString stringWithFormat:@"%d秒后重试", _timerTarget - _timerCount];
        _fireButton.titleLabel.text = lab;
        [_fireButton setTitle:lab forState:UIControlStateDisabled];
    }
}
- (void)loginUser
{
    WatLoginViewController *vc = [[WatLoginViewController alloc]init];
    [vc setHidesBottomBarWhenPushed:YES];
    [[ZWHHelper rootTabbarViewController].selectedViewController pushViewController:vc animated:YES];
}
//- (BOOL)isLogin//判断用户是否已登录
//{
//   return ValidStr([[NSUserDefaults standardUserDefaults] valueForKey:KZWYUserID]);
//}
- (void)textFileDeleate:(UITextField *)textFiled
{
    
    self.deleateText.frame = CGRectMake(textFiled.frame.size.width-30, 12, 20, 20);
    [self.deleateText setTitle:@"X" forState:UIControlStateNormal];
    [self.deleateText setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.deleateText addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        textFiled.text = @"";
    }];
    [textFiled addSubview:self.deleateText];
    if (textFiled.left>0) {
        self.deleateText.hidden = NO;
    }else
    {
        self.deleateText.hidden = YES;
    }
}


//实现 btn 图片在上文字在下的方法
-(void)initButton:(UIButton*)btn{
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(btn.imageView.frame.size.height ,-btn.imageView.frame.size.width, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
    //[btn setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0,0.0, 0)];//图片距离右边框距离减少图片的宽度，其它不边
    [btn setImageEdgeInsets:UIEdgeInsetsMake(-30, 15, 0, 0)];
}
- (void)alertActionSheet:(NSArray *)messages withClickBlock:(alertActionSheetClickBlock)clickBlock
{
    //NSString *alertmessage;
    //__typeof(alertmessage) weakSelf = alertmessage;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    for (int i = 0  ; i<messages.count ;i++) {
        UIAlertAction *alert1 = [UIAlertAction actionWithTitle:messages[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (clickBlock) {
                clickBlock(i,messages[i]);
            }
            
        }];
        [alert addAction:alert1];
    }
    UIAlertAction *alert1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:alert1];
    [[ZWHHelper rootTabbarViewController].selectedViewController presentViewController:alert animated:YES completion:nil];
}
- (void)alertActionSheet:(NSArray *)messages AndView:(UIViewController *)view withClickBlock:(alertActionSheetClickBlock)clickBlock
{
    //NSString *alertmessage;
    //__typeof(alertmessage) weakSelf = alertmessage;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    for (int i = 0  ; i<messages.count ;i++) {
        UIAlertAction *alert1 = [UIAlertAction actionWithTitle:messages[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (clickBlock) {
                clickBlock(i,messages[i]);
            }
            
        }];
        [alert addAction:alert1];
    }
    UIAlertAction *alert1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:alert1];
    [[ZWHHelper rootTabbarViewController].selectedViewController presentViewController:alert animated:YES completion:nil];
}


////wat 注释掉
//- (void)addCsrzNoneViewToView:(UIView *)view message:(NSString *)message{
//    //    @weakify(self)
//    _csrzNoneButton = [UIButton new];
//    [_csrzNoneButton setImage:[UIImage imageNamed:@"zwy_csrz_none"] forState:UIControlStateNormal];
//    [view addSubview:_csrzNoneButton];
//    [_csrzNoneButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(view);
//        make.top.equalTo(view).with.offset(164);
//        make.size.mas_equalTo(CGSizeMake(60, 60));
//    }];
//
//    _csrzNoneLable = [UILabel new];
//    _csrzNoneLable.font = [UIFont systemFontOfSize:14];
//    _csrzNoneLable.textColor = [UIColor lightGrayColor];
//    _csrzNoneLable.text = message;
//    [view addSubview:_csrzNoneLable];
//    [_csrzNoneLable mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(view);
//        make.top.equalTo(_csrzNoneButton.mas_bottom).with.offset(20);
//    }];
//}
- (void)removeNoneView{
    [_csrzNoneButton removeFromSuperview];
    _csrzNoneButton = nil;
    [_csrzNoneLable removeFromSuperview];
    _csrzNoneLable = nil;
}


- (BOOL )intervalFromLastDate:(NSString *) dateString2//时间差
{
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY/MM/dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    //dateString = dateString;
    
    NSArray *timeArray1=[dateString componentsSeparatedByString:@"."];
    dateString=[timeArray1 objectAtIndex:0];
    
    
    NSArray *timeArray2=[dateString2 componentsSeparatedByString:@"."];
    dateString2=[timeArray2 objectAtIndex:0];
    
    NSLog(@"%@.....%@",dateString,dateString2);
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    
    NSDate *d1=[date dateFromString:dateString];
    
    NSTimeInterval late1=[d1 timeIntervalSince1970]*1;
    
    
    
    NSDate *d2=[date dateFromString:dateString2];
    
    NSTimeInterval late2=[d2 timeIntervalSince1970]*1;
    
    
    
    NSTimeInterval cha=late2-late1;
    NSString *timeString=@"";
    NSString *house=@"";
    NSString *min=@"";
    NSString *sen=@"";
    
    sen = [NSString stringWithFormat:@"%d", (int)cha%60];
    //        min = [min substringToIndex:min.length-7];
    //    秒
    sen=[NSString stringWithFormat:@"%@", sen];
    
    
    
    min = [NSString stringWithFormat:@"%d", (int)cha/60%60];
    //        min = [min substringToIndex:min.length-7];
    //    分
    min=[NSString stringWithFormat:@"%@", min];
    
    
    //    小时
    house = [NSString stringWithFormat:@"%d", (int)cha/3600];
    //        house = [house substringToIndex:house.length-7];
    house=[NSString stringWithFormat:@"%@", house];
    
    
    timeString=[NSString stringWithFormat:@"%@:%@:%@",house,min,sen];
    
    
    NSArray *array = [timeString componentsSeparatedByString:@":"];
    BOOL istime ;
    if (abs([array[0] intValue]) >0 ) {//暂定验证码时差为10分钟
        istime = YES;
    }else if ( abs([array[1] intValue]) >10) {//暂定验证码时差为10分钟
        istime = YES;
    }else
    {
        istime = NO;
    }
    
    return istime;
}
- (void)Message:(NSString *)message
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(30, MyKScreenHeight/2-30, MyKScreenWidth-60, 60)];
    label.backgroundColor = [UIColor blackColor];
    label.text = message;
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    label.alpha = 0.7;
    label.font = [UIFont systemFontOfSize:14.0];
    label.textColor = [UIColor whiteColor];
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:label];
    
    
    [UIView animateWithDuration:1 animations:^{
        label.alpha = 0.5;
        
    } completion:^(BOOL finished) {
        [label removeFromSuperview];
    }];
}
+ (NSString *)timeStampWithString:(NSString *)dateStr format:(NSString *)format{
    
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    
    NSDate *date = [NSDate dateWithString:dateStr format:format timeZone:timeZone locale:[NSLocale currentLocale]];
    ;
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    
    NSInteger interval = [zone secondsFromGMTForDate: date];
    
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    
    return @(localeDate.timeIntervalSince1970 * 1000).stringValue;
}


- (BOOL)isPhoneByMobileNum:(NSString *)mobileNum
{
    if (mobileNum.length != 11)
    {
        return NO;
    }
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[6, 7, 8], 18[0-9], 170[0-9]
     * 移动号段: 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     * 联通号段: 130,131,132,155,156,185,186,145,176,1709
     * 电信号段: 133,153,180,181,189,177,1700
     */
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0678])\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     */
    NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";
    /**
     * 中国联通：China Unicom
     * 130,131,132,155,156,185,186,145,176,1709
     */
    NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)";
    /**
     * 中国电信：China Telecom
     * 133,153,180,181,189,177,1700
     */
    NSString *CT = @"(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)";
    
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

//身份证号
- (BOOL) isIdentityCard: (NSString *)identityCard
{
    if (identityCard.length <= 0) {
        return NO;
    }
    NSString *identityRegex = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",identityRegex];
    return [identityCardPredicate evaluateWithObject:identityCard];
}
#pragma mark - 计算文字所占宽度
- (CGSize)getSizeByString:(NSString*)string AndFontSize:(CGFloat)font
{
    CGSize size = [string boundingRectWithSize:CGSizeMake(999, 25) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    size.width += 5;
    return size;
}
#pragma mark - 计算文字所占高度
- (CGSize)getHeightByString:(NSString*)string AndFontSize:(CGFloat)font AndWidth:(CGFloat)width
{
    CGSize sizeToFit = [string sizeWithFont:[UIFont systemFontOfSize:font] constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap];//此处的换行类型（lineBreakMode）可根据自己的实际情况进行设置
    return sizeToFit;
}
//拨打电话
- (void)callUpByphone:(NSString *)phone
{
    NSString *allString = [NSString stringWithFormat:@"tel:%@",phone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:allString]];
}



-(void)sethanderView
{
    //handerView
    self.handerView = [UIButton buttonWithType:UIButtonTypeCustom];
    self.handerView.backgroundColor=[UIColor colorWithWhite:0/255.0 alpha:0.5];
    [_handerView setFrame:[UIScreen mainScreen].bounds];
    //[_handerView setBackgroundColor:[UIColor clearColor]];
    [_handerView addTarget:self action:@selector(remove) forControlEvents:UIControlEventTouchUpInside];
    //    [_handerView addSubview:self];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    [window addSubview:_handerView];
}
- (void)remove
{
    [_handerView removeFromSuperview];
}
#pragma mark - //图片点击事件
-(void)tapimageByImage:(NSString *)imageURL
{
    
    [self sethanderView];
    self.handerView.backgroundColor=[UIColor blackColor];
    self.handerView.alpha=1;
    //    if([imageURL rangeOfString:@"http"].location ==NSNotFound)
    //    {
    //        imageURL = [NSString stringWithFormat:@"http://www.zhaiwuyo.com/file/web/download/%@.jpg", imageURL];
    //    }
    UIImageView *imageView=[[UIImageView alloc]init];
    [imageView setFrame:[UIScreen mainScreen].bounds];
    [self.handerView addSubview:imageView];
    imageView.contentMode=UIViewContentModeScaleAspectFit;//图片宽高比显示
    [imageView sd_setImageWithURL:[NSURL URLWithString:imageURL] completed:nil];
    imageView.userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(proofOnClickImage)];
    
    [imageView addGestureRecognizer:singleTap];
    
}
- (void)proofOnClickImage
{
    [self.handerView removeFromSuperview];
}

/**
 对字典(Key-Value)排序 不区分大小写
 

 */
-(NSString *)getNeedSignStrFrom:(id)obj{
    NSMutableDictionary *dict = obj;
    NSArray *arrPrimary = dict.allKeys;
    
    NSArray *arrKey = [arrPrimary sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
        NSComparisonResult result = [obj1 compare:obj2];
        return result==NSOrderedAscending;//NSOrderedDescending 正序
    }];
    
    NSString*str =@"";
    
    for (NSString *s in arrKey) {
        id value = dict[s];
        if([value isKindOfClass:[NSMutableDictionary class]]) {
            value = [self getNeedSignStrFrom:value];
        }
        //        if([str length] !=0) {
        //
        //            str = [str stringByAppendingString:@","];
        //
        //        }
        
        //        str = [str stringByAppendingFormat:@"%@:%@",s,value];
        str = [str stringByAppendingFormat:@"%@",value];
        
    }
    NSLog(@"str:%@",str);
    
    return str;
}

- (NSString *)getTimeStringWithTimeStamp:(long long)stamp{
    return [[NSDate dateWithTimeIntervalSince1970: stamp / 1000] stringWithFormat:@"yyyy-MM-dd"];
}

- (void )rimeDifferenceByTime:(NSString *)time and:(UILabel *)label AndisZiChanBao:(BOOL)isZip;
{
    //逾期时间
    //把字符串转为NSdate
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *paymentTime = [[ZWHHelper sharedHelper]getTimeStringWithTimeStamp:[label.text longLongValue]];
    
    NSDate *timeDate = [dateFormatter dateFromString:paymentTime];
    
    //得到与当前时间差
    
    NSTimeInterval timeInterval = [timeDate timeIntervalSinceNow];//单位为 秒
    
    timeInterval = -timeInterval;
    
    long temp = 0;
    
    NSString *result;
    if (timeInterval < 60) {
        label.text = @"刚刚";
    }
    
    else if((temp = timeInterval/60) <60){
        
        NSString *str = @"分钟前";
        
        label.attributedText = [self getAttrOutTimeStr:[NSString stringWithFormat:@"%ld",temp] :str];
        
    }
    
    else if((temp = timeInterval/3600) <24){
        NSString *str = @"小时前";
        label.attributedText = [self getAttrOutTimeStr:[NSString stringWithFormat:@"%ld",temp] :str];
        
    }
    
    else if((temp = timeInterval/3600/24) <30){
        
        NSString *str = @"天前";
        label.attributedText = [self getAttrOutTimeStr:[NSString stringWithFormat:@"%ld",temp] :str];
        
        
    }
    
    else if((temp = timeInterval/3600/24/30) <12){
        
        NSString *str = @"月前";
        label.attributedText = [self getAttrOutTimeStr:[NSString stringWithFormat:@"%ld",temp] :str];
        
    }
    
    else{
        
        temp = timeInterval/3600/24/30/12;
        
        NSString *str = @"年前";
        label.attributedText = [self getAttrOutTimeStr:[NSString stringWithFormat:@"%ld",temp] :str];
    }
    if (isZip)//资产包
    {
        label.attributedText = [self getAttrOutTimeStr:[NSString stringWithFormat:@""] :@"暂无"];
    }
    
}
//逾期时间
- (NSMutableAttributedString *)getAttrOutTimeStr:(NSString *)str :(NSString *)timeType{
    NSMutableAttributedString *outTimeText = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@",str,timeType]];
    
    outTimeText.font = [UIFont systemFontOfSize:12];
    [outTimeText setColor:[UIColor colorWithRed:255/255.0 green:163/255.0 blue:0/255.0 alpha:1.0]];
    NSRange searchRange = NSMakeRange(0, str.length);
    [outTimeText setColor:[UIColor colorWithRed:255/255.0 green:163/255.0 blue:0/255.0 alpha:1.0] range:searchRange];
    [outTimeText setFont:[UIFont systemFontOfSize:26] range:searchRange];
    
    
    
    return outTimeText;
}





- (void)buttonSelectBy:(UIViewController *)Controller AndButton:(UIButton *)button;
{
    self.buttonSelect = button;
    button.enabled = NO;
    [self performSelector:@selector(changeButtonStatus) withObject:nil afterDelay:1.0f];//防止用户重复点击
}
-(void)changeButtonStatus{
    self.buttonSelect.enabled = YES;
}

//md5加密
+ (NSString *) md5:(NSString *) input {
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}

- (NSString *) sha1:(NSString *)input
{
    //const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
    //NSData *data = [NSData dataWithBytes:cstr length:input.length];
    
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}



- (UIButton *)textEndView
{
    self.endbutton = [[UIButton alloc]initWithFrame:CGRectMake(0, MyKScreenHeight, MyKScreenWidth, 44)];self.endbutton.backgroundColor = [UIColor lightGrayColor];
    [self.endbutton setTitle:@"完成\t\t" forState:UIControlStateNormal];
    self.endbutton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.endbutton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    
    self.endbutton.titleLabel.font = [UIFont systemFontOfSize:13.0];
    return self.endbutton;
}

- (void) popNavigationController:(UINavigationController *)selfNavigationController :(UINavigationController *)popToNav{
    
    
    NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
    
    //    遍历导航控制器中的控制器
    
    for (UIViewController *vc in selfNavigationController.viewControllers) {
        
        [viewControllers addObject:vc];
        
        //        CourseTableController就是你需要返回到指定的控制器名称，这里我需要跳转到CourseTableController这个控制器
        
        if ([vc isKindOfClass:[popToNav class]]) {
            
            break;
            
        }
        
    }
    //    把控制器重新添加到导航控制器
    
    [popToNav setViewControllers:viewControllers animated:YES];
    
    
    
    [popToNav popViewControllerAnimated:YES];
}
//时间格式转换
-(NSString *)getMMSSFromSS:(NSString *)totalTime{//传入秒,得到 xx:xx:xx
    
    NSInteger seconds = [totalTime integerValue];
    
    //format of hour
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",seconds/3600];
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(seconds%3600)/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02ld",seconds%60];
    //format of time
    NSString *format_time = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
    
    return format_time;
}
-(NSString *)getSectionMMSSFromSS:(NSString *)totalTime{ //传入秒,得到 xx分xx秒
    
    NSInteger seconds = [totalTime integerValue];
    
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",seconds/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02ld",seconds%60];
    //format of time
    NSString *format_time = [NSString stringWithFormat:@"%@:%@",str_minute,str_second];
    
    //NSLog(@"format_time : %@",format_time);
    
    return format_time;
}
//图片模糊处理
//加模糊效果，image是图片，blur是模糊度
- (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur {
    //模糊度,
    if ((blur < 0.1f) || (blur > 2.0f)) {
        blur = 0.5f;
    }
    
    //boxSize必须大于0
    int boxSize = (int)(blur * 100);
    boxSize -= (boxSize % 2) + 1;
    NSLog(@"boxSize:%i",boxSize);
    //图像处理
    CGImageRef img = image.CGImage;
    //需要引入
    /*
     This document describes the Accelerate Framework, which contains C APIs for vector and matrix math, digital signal processing, large number handling, and image processing.
     本文档介绍了Accelerate Framework，其中包含C语言应用程序接口（API）的向量和矩阵数学，数字信号处理，大量处理和图像处理。
     */
    
    //图像缓存,输入缓存，输出缓存
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    //像素缓存
    void *pixelBuffer;
    
    //数据源提供者，Defines an opaque type that supplies Quartz with data.
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    // provider’s data.
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    //宽，高，字节/行，data
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    //像数缓存，字节行*图片高
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    
    // 第三个中间的缓存区,抗锯齿的效果
    void *pixelBuffer2 = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    vImage_Buffer outBuffer2;
    outBuffer2.data = pixelBuffer2;
    outBuffer2.width = CGImageGetWidth(img);
    outBuffer2.height = CGImageGetHeight(img);
    outBuffer2.rowBytes = CGImageGetBytesPerRow(img);
    
    //Convolves a region of interest within an ARGB8888 source image by an implicit M x N kernel that has the effect of a box filter.
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer2, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    error = vImageBoxConvolve_ARGB8888(&outBuffer2, &inBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    
    
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    
    //    NSLog(@"字节组成部分：%zu",CGImageGetBitsPerComponent(img));
    //颜色空间DeviceRGB
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //用图片创建上下文,CGImageGetBitsPerComponent(img),7,8
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             CGImageGetBitmapInfo(image.CGImage));
    
    //根据上下文，处理过的图片，重新组件
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    free(pixelBuffer2);
    CFRelease(inBitmapData);
    
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    
    return returnImage;
}
- (NSString *)phoneNum:(NSString *)telePhoneNum{
    NSString *phoneNumber = [telePhoneNum stringByReplacingCharactersInRange:NSMakeRange(3, 5)  withString:@"*****"];
    return phoneNumber;
}

@end