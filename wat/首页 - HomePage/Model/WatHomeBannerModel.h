//
//  WatHomeBannerModel.h
//  wat
//
//  Created by apple on 2018/6/14.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WatHomeBannerModel : NSObject

@property (nonatomic, copy) NSString *b_name;
@property (nonatomic, copy) NSString *sort;
@property (nonatomic, copy) NSString *link_type; //1文章 直接跳转h5 2.课程 跳转在线视频 3 线下书籍 4是线下活动
@property (nonatomic, copy) NSString *banner_id;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, copy) NSString *start_time;
@property (nonatomic, copy) NSString *end_time;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *banner_position_id;
@property (nonatomic, copy) NSString *ios_mark_id; //goodsid
@end
