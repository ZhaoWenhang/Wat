//
//  applePay.h
//  zahb
//
//  Created by 技术平台开发部 on 2017/5/2.
//  Copyright © 2017年 技术平台开发部. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol applePayDelegate <NSObject>

@optional

- (void)payseccuss;

@end

@interface applePay : NSObject

+(applePay*)SharePurchases;
- (void)requestProductData:(NSString *)type;;

@property (nonatomic,weak)id<applePayDelegate>delegate;

@end
