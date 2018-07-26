//
//  WatHomeNewsDetailsModel.h
//  wat
//
//  Created by apple on 2018/6/14.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WatHomeNewsDetailsModel : NSObject

@property (nonatomic, copy) NSString *pviews;
@property (nonatomic, copy) NSString *forward;
@property (nonatomic, copy) NSString *news_id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *tag;
@property (nonatomic, copy) NSURL *thumb;
@property (nonatomic, copy) NSString *add_date;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSURL *url;
@property (nonatomic, strong) NSString *author;//作者
@property (nonatomic, strong) NSString *type;//类型
@property (nonatomic, strong) NSString *share_url;


@end
