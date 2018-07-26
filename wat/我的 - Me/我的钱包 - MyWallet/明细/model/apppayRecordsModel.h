//
//  apppayRecordsModel.h
//  wat
//
//  Created by 123 on 2018/7/9.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface apppayRecordsModel : NSObject
//"id":"33",
//"uid":"20",
//"order_no":"APPPAY5B3F7F01592CCBZ68",
//"pay_money":"6.00",
//"pay_char":"com.watcn.wat6",
//"create_time":"2018-07-06 22:38:57",
//"in_or_out":"充值",
//"balance":"31047.93",
//"ios_pay_id":"1000000414917495"

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *order_no;
@property (nonatomic, strong) NSString *pay_money;
@property (nonatomic, strong) NSString *pay_char;
@property (nonatomic, strong) NSString *create_time;
@property (nonatomic, strong) NSString *in_or_out;
@property (nonatomic, strong) NSString *balance;
@property (nonatomic, strong) NSString *ios_pay_id;




@end
