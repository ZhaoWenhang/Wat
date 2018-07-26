//
//  WatHomeClassListDetailModel.h
//  wat
//
//  Created by 123 on 2018/7/2.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WatHomeClassListDetailModel : NSObject
//"title":"课程1",
//"id":"55",
//"is_free":"0",
//"tags":[
//        ""
//        ],
//"add_time":"2018-05-31 12:01:20",
//"thumb":"http://admin.watcn.com/uploads/article/20180531/152773914837387243.jpg",
//"author":"小二哥",
//"hits":"1",
//"goods_type":"2",
//"sort":"1",
//"description":"",
//"sale_num":"200",
//"shop_type":"0",
//"video_path":"http://admin.watcn.com",
//"audio_path":"http://admin.watcn.com",
//"url":"http://h5.watcn.com/education/content?id=55",
//"shop_type_name":"在线课程",
//"goods_type_name":"图文"

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *is_free;
@property (nonatomic, strong) NSString *tags;
@property (nonatomic, strong) NSString *add_time;
@property (nonatomic, strong) NSString *thumb;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *hits;
@property (nonatomic, strong) NSString *goods_type;
@property (nonatomic, strong) NSString *sort;
@property (nonatomic, strong) NSString *subTitle; //description
@property (nonatomic, strong) NSString *sale_num;
@property (nonatomic, strong) NSString *shop_type;
@property (nonatomic, strong) NSString *video_path;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *shop_type_name;
@property (nonatomic, strong) NSString *goods_type_name;
@property (nonatomic, strong) NSString *audio_path;
@property (nonatomic, strong) NSString *share_url;
@property (nonatomic, strong) NSString *learning_time;
@property (nonatomic, strong) NSString *duration;
@property (nonatomic, strong) NSString *zhuanji;
@end
