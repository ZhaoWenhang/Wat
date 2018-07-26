//
//  applePay.m
//  zahb
//
//  Created by 技术平台开发部 on 2017/5/2.
//  Copyright © 2017年 技术平台开发部. All rights reserved.
//

#import "applePay.h"
#import <StoreKit/StoreKit.h>

static applePay*_purchase = nil;

@interface applePay ()<SKPaymentTransactionObserver,SKProductsRequestDelegate>

@property (nonatomic,copy) NSString *currentProId;
@property (nonatomic,copy) NSString *orderNumber;

@end

@implementation applePay
{
    //UserItem *useritem;
}

#pragma mark - 支付以单利的形式展开

+(applePay*)SharePurchases
{
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        if (_purchase == nil) {
            
            _purchase = [[super alloc]init];
            
            [[SKPaymentQueue defaultQueue]addTransactionObserver:_purchase];
            
        }
        
    });
    
    return _purchase;
    
}

+(id)allocWithZone:(struct _NSZone *)zone
{
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        if (_purchase == nil) {
            
            _purchase = [[super allocWithZone:zone]init];
            
        }
        
    });
    
    return _purchase;
    
}

+(id)alloc
{
    return _purchase;
}

#pragma mark -支付钻石会员

- (void)requestProductData:(NSString *)type{
    
    _currentProId = type;
   // _orderNumber = orderNumber;
    
    [SVProgressHUD show];
    
#pragma mark -开始支付，根据录入内购项目的产品id去AppStore请求产品信息。
    
    if ([SKPaymentQueue canMakePayments]) {
        
        NSSet * set = [NSSet setWithObjects:type,nil];
        
        SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:set];
        request.delegate = self;
        [request start];
    }
    
    else
        
    {
        NSLog(@"无权限购买");
    }
}

//收到产品返回信息
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    
    NSLog(@"--------------收到产品反馈消息---------------------");
    NSArray *product = response.products;
    if([product count] == 0){
        [SVProgressHUD dismiss];
        NSLog(@"--------------没有商品------------------");
        return;
    }
    
    NSLog(@"productID:%@", response.invalidProductIdentifiers);
    NSLog(@"产品付费数量:%lu",(unsigned long)[product count]);
    
    SKProduct *p = nil;
    for (SKProduct *pro in product) {
        NSLog(@"%@", [pro description]);
        NSLog(@"%@", [pro localizedTitle]);
        NSLog(@"%@", [pro localizedDescription]);
        NSLog(@"%@", [pro price]);
        NSLog(@"%@", [pro productIdentifier]);
        
        if([pro.productIdentifier isEqualToString:_currentProId]){
            p = pro;
        }
    }
    
    SKPayment *payment = [SKPayment paymentWithProduct:p];
    
    NSLog(@"发送购买请求");
    [SVProgressHUD show];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

//请求失败
- (void)request:(SKRequest *)request didFailWithError:(NSError *)error{
    [SVProgressHUD showErrorWithStatus:@"支付失败"];
    NSLog(@"------------------错误-----------------:%@", error);
}

- (void)requestDidFinish:(SKRequest *)request{

    NSLog(@"------------反馈信息结束-----------------");
}
//沙盒测试环境验证
#define SANDBOX @"https://sandbox.itunes.apple.com/verifyReceipt"
//正式环境验证
#define AppStore @"https://buy.itunes.apple.com/verifyReceipt"
/**
 *  验证购买，避免越狱软件模拟苹果请求达到非法购买问题
 *
 */
-(void)verifyPurchaseWithPaymentTransaction{
    //从沙盒中获取交易凭证并且拼接成请求体数据
    NSURL *receiptUrl=[[NSBundle mainBundle] appStoreReceiptURL];
    NSData *receiptData=[NSData dataWithContentsOfURL:receiptUrl];
    
    NSString *receiptString=[receiptData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];//转化为base64字符串
    
    [self rechargeCallBackAFNwithinvoice:receiptString];
//    useritem = [IWAccountTool UserItemwithfile:@"useritem.data"];
//    if (useritem) {
//        [self rechargeCallBackAFNwithinvoice:receiptString];
//    }else{//未登录
//        [self rechargeyanzhengapplestorewithinvoce:receiptString];
//    }
}
//监听购买结果
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transaction{
    for(SKPaymentTransaction *tran in transaction){
        switch (tran.transactionState) {
            case SKPaymentTransactionStatePurchased:{
                NSLog(@"交易完成");

                [SVProgressHUD dismiss];
                [self verifyPurchaseWithPaymentTransaction];
                [[SKPaymentQueue defaultQueue] finishTransaction:tran];
                
            }
                break;
            case SKPaymentTransactionStatePurchasing:
                NSLog(@"商品添加进列表");

                
                break;
            case SKPaymentTransactionStateRestored:{
                NSLog(@"已经购买过商品");
                
                [[SKPaymentQueue defaultQueue] finishTransaction:tran];
            }
                break;
            case SKPaymentTransactionStateFailed:{
                NSLog(@"交易失败");
                [[SKPaymentQueue defaultQueue] finishTransaction:tran];
                [SVProgressHUD showErrorWithStatus:@"购买失败"];
            }
                break;
            default:
                break;
        }
    }
}

//交易结束
- (void)completeTransaction:(SKPaymentTransaction *)transaction{
    NSLog(@"交易结束");
    [WATHud dismiss];
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}


- (void)dealloc{
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
}

- (void)rechargeCallBackAFNwithinvoice:(NSString *)invoice
{
 
    NSMutableDictionary *paramDic = [NSMutableDictionary new];
    [paramDic setValue:invoice forKey:@"receipt"];
    
    if (ValidStr(paramDic[@"receipt"])) {
        __weak typeof (self)weakSelf = self;
        [Request POST:kApiAppPayCheckPay parameters:paramDic success:^(id responseObject) {
            if ([_delegate respondsToSelector:@selector(payseccuss)]) {
                                                   [_delegate payseccuss];
                                               }
            
            NSLog(@"成功了");
            [WATHud dismiss];
        } failure:^(NSError *error) {
            [WATHud dismiss];
        }];
    }


}

//用户未登录，本地自己请求苹果去验证
- (void)rechargeyanzhengapplestorewithinvoce:(NSString *)receiptString
{
        NSString *bodyString = [NSString stringWithFormat:@"{\"receipt-data\" : \"%@\"}", receiptString];//拼接请求数据
    
        NSData *bodyData = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
    
    
        //创建请求到苹果官方进行购买验证
        NSURL *url=[NSURL URLWithString:SANDBOX];
        NSMutableURLRequest *requestM=[NSMutableURLRequest requestWithURL:url];
        requestM.HTTPBody=bodyData;
        requestM.HTTPMethod=@"POST";
        //创建连接并发送同步请求
        NSError *error=nil;
        NSData *responseData=[NSURLConnection sendSynchronousRequest:requestM returningResponse:nil error:&error];
        if (error) {
            NSLog(@"验证购买过程中发生错误，错误信息：%@",error.localizedDescription);
            return;
        }
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",dic);
        if([dic[@"status"] intValue]==0){
            NSLog(@"购买成功！");
            
            if ([_delegate respondsToSelector:@selector(payseccuss)]) {
                [_delegate payseccuss];
            }
            
            NSDictionary *dicReceipt= dic[@"receipt"];
            NSDictionary *dicInApp=[dicReceipt[@"in_app"] firstObject];
            NSString *productIdentifier= dicInApp[@"product_id"];//读取产品标识
            //如果是消耗品则记录购买数量，非消耗品则记录是否购买过
            NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
            if ([productIdentifier isEqualToString:_currentProId]) {
                NSInteger purchasedCount=[defaults integerForKey:productIdentifier];//已购买数量
                [[NSUserDefaults standardUserDefaults] setInteger:(purchasedCount+1) forKey:productIdentifier];
            }else{
                [defaults setBool:YES forKey:productIdentifier];
            }
            //在此处对购买记录进行存储，可以存储到开发商的服务器端
        }else{
            NSLog(@"购买失败，未通过验证！");
        }

}

@end
