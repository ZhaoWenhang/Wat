//
//  WeChatPayGetDetailModel.h
//  wat
//
//  Created by 123 on 2018/7/3.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeChatPayGetDetailModel : NSObject
//"appid":"wx48892c078c752b89",
//"partnerid":"1505665971",
//"prepayid":"wx03212518261801c2a0ae285f3474099514",
//"package":"Sign=WXPay",
//"noncestr":"5b3b793e47a9f",
//"timestamp":"1530624318",
//"sign":"C1934452896A1D164997660EFA28FDD1"
@property (nonatomic, strong)NSString *appid;
@property (nonatomic, strong)NSString *partnerid;
@property (nonatomic, strong)NSString *prepayid;
@property (nonatomic, strong)NSString *package;
@property (nonatomic, strong)NSString *noncestr;
@property (nonatomic, assign) UInt32 timestamp;
@property (nonatomic, strong)NSString *sign;


@end
