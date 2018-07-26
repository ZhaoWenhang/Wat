//
//  AppDelegate.m
//  wat
//
//  Created by 123 on 2018/5/22.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "AppDelegate.h"
#import "WatTabBarController.h"
#import "HKFloatManager.h"//浮动旋转球
#import <AVFoundation/AVFoundation.h>
#import "WXApi.h"
@interface AppDelegate ()<WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //延长启动页面
    [NSThread sleepForTimeInterval:2.0];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[WatTabBarController alloc]init];
    [self.window makeKeyAndVisible];
    
    [IQKeyboardManager sharedManager].enable = YES;
    
    //设置AppKey，是在友盟注册之后给到的key
    [[UMSocialManager defaultManager] setUmSocialAppkey:UMAppKey];
    
    [self registerUMKey];
    
    //　先调用友盟，然后调用微信清册信息
    /****************       注册微信支付信息    *****************/
    [WXApi registerApp:WX_AppID];
    
    //浮动旋转球
    //[HKFloatManager addFloatVcs:@[@"HomeVideoClassViewController"]];
    
    //后台支持播放音频
    [self AudioBackGround];
    //监听网络状态
    [self wangluozhuangtai];
    
    return YES;
}
/** 注册平台 */
- (void)registerUMKey{
    
    //    setPlaform是要注册的平台
    
    /* 微信聊天 */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WX_AppID appSecret:WX_AppSecret redirectURL:@"http://mobile.umeng.com/social"];
    
        //[[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxdc1e388c3822c80b" appSecret:@"3baf1193c85774b3fd9d18447d76cab0" redirectURL:@"http://mobile.umeng.com/social"];
    
}

// 支持所有iOS系统版本回调
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{

    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
        #pragma mark - 微信支付回调
        return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
    }
    return result;
}

#pragma 播放视频,支持横屏
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    if (self.allowRotation) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    }
    return UIInterfaceOrientationMaskPortrait;
    
}
#pragma 播放音频,支持后台
- (void)AudioBackGround{
    // 告诉app支持后台播放
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    [audioSession setActive:YES error:nil];
}


#pragma 监听网络转态
- (void)wangluozhuangtai{
    // Override point for customization after application launch.
    
    //[self requestHomePageDatas];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager ] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case -1:{
                //NSLog(@"未知网络");
                [WATHud showError:@"未知网络"];
                break;
            }
            case 0:{
                //NSLog(@"网络不可达");
                [WATHud showError:@"网络不可达"];
                break;
            }
            case 1:
                //NSLog(@"GPRS网络");
            {
                [WATHud showMessage:@"当前为 移动 网络"];
            }
                break;
            case 2:
                //NSLog(@"wifi网络");
            {
                [WATHud showMessage:@"当前为 wifi 网络"];
                
            }
                break;
            default:
                break;
        }
        if(status ==AFNetworkReachabilityStatusReachableViaWWAN || status == AFNetworkReachabilityStatusReachableViaWiFi)
        {
            //NSLog(@"有网");
            //教研升级
            [self checkVersion];
            
        }else
        {
            //NSLog(@"没有网");
            [WATHud showError:@"没有网络"];
        }
    }];
}
//检测软件是否需要升级
-(void)checkVersion
{
    return;
    NSDate *date = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYYMM"];
    NSString *DateTime = [formatter stringFromDate:date];
    if (DateTime.integerValue>201705) {
        NSString *newVersion;
        NSURL *url = [NSURL URLWithString:@"http://itunes.apple.com/cn/lookup?id=1151053511"];
        //通过url获取数据
        NSString *jsonResponseString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
        NSData *jsonData = [jsonResponseString dataUsingEncoding:NSUTF8StringEncoding];
        
        NSError *err;
        
        NSDictionary *loginAuthenticationResponse = [NSJSONSerialization JSONObjectWithData:jsonData
                                                     
                                                                                    options:NSJSONReadingMutableContainers
                                                     
                                                                                      error:&err];
   
        //从数据字典中检出版本号数据
        NSArray *configData = [loginAuthenticationResponse valueForKey:@"results"];
        for(id config in configData)
        {
            newVersion = [config valueForKey:@"version"];
        }
        
        //NSLog(@"通过appStore获取的版本号是：%@",newVersion);
        
        //获取本地软件的版本号
        NSString *localVersion = [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        
        NSString *msg = [NSString stringWithFormat:@"你当前的版本是V%@，发现新版本V%@，建议更新至新版本，是否下载新版本",localVersion,newVersion];
        
        if ([newVersion floatValue] > [localVersion floatValue])
        {
            
            [[ZWHHelper sharedHelper]addAlertViewControllerToView:self withClickBlock:^(int clickInt) {
                if (clickInt == 1) {
                    //打开iTunes  方法一
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/zhai-wu-you/id1151053511?mt=8"]];
                }
            } title:@"升级提示!" content:msg cancleStr:@"下次再说" confirmStr:@"现在升级"];
            //self.go = NO;//可通过推送通知
        }else{
            //self.go = YES;
        }
    }
    
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
