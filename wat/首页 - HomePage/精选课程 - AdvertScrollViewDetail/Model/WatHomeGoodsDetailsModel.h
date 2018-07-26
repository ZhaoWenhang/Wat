//
//  WatHomeGoodsDetailsModel.h
//  wat
//
//  Created by apple on 2018/6/14.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WatHomeGoodsDetailsModel : NSObject

@property (nonatomic, copy) NSString *goods_id; //
@property (nonatomic, copy) NSString *price; //
@property (nonatomic, copy) NSString *title; //
@property (nonatomic, copy) NSString *shop_type; //
@property (nonatomic, copy) NSString *shop_type_name; //
@property (nonatomic, copy) NSURL *thumb_path; //
@property (nonatomic, copy) NSURL *url; //
@property (nonatomic, copy) NSString *sort; //

@property (nonatomic, copy) NSArray *tags; //
@property (nonatomic, copy) NSString *add_time; //
@property (nonatomic, copy) NSString *author; //


@property (nonatomic, copy) NSString *sale_num;
@property (nonatomic, copy) NSString *subTitle;
@property (nonatomic, copy) NSString *content_type; // 1音频 2视频

@end
