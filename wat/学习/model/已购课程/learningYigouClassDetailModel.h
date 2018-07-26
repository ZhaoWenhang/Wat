//
//  learningYigouClassDetailModel.h
//  wat
//
//  Created by 123 on 2018/6/28.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface learningYigouClassDetailModel : NSObject



//"add_time" = "2018-05-31 12:00:51";
//author = "\U5185\U53c2\U9996\U5e2d\U8bb2\U8bfe\U5e08\Uff1a\U5468\U78a7\U6ce2";
//"create_time" = "2018-06-28 20:29:41";
//description = "\U4ece\U5916\U5356\U5e38\U89c1\U8bef\U533a\U3001\U6d41\U91cf\U7b56\U7565\U3001\U7ade\U4ef7\U89c4\U5212\U3001\U6d3b\U52a8\U8bbe\U7f6e\U3001\U6570\U636e\U5206\U6790\U7b49\U5916\U5356\U8001\U677f\U4eec\U6700\U5728\U610f\U76848\U4e2a\U75db";
//"goods_type" = 1;
//id = 54;
//"is_sale" = 1;
//oid = 130;
//"online_end" = "2018-08-31 12:00:38";
//"online_start" = "2018-05-31 12:00:29";
//price = "100.00";
//"sale_num" = 326;
//"shop_type" = 0;
//"shop_type_name" = "\U5728\U7ebf\U8bfe\U7a0b";
//sort = 1000;
//tags =                         (
//                                "\U77e5\U8bc6\U4ed8\U8d39",
//                                "\U9910\U996e"
//                                );
//"thumb_path" = "http://admin.watcn.com/uploads/article/20180621/152956620495238688.jpg";
//title = "\U5982\U4f55\U7ecf\U8425\U95e8\U5e97\U65e5\U6d41\U6c343\U4e07+";
//url = "http://h5.watcn.com/education/content?id=54";



@property (nonatomic, strong) NSString *add_time;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *create_time;
@property (nonatomic, strong) NSString *subTitle;
@property (nonatomic, strong) NSString *goods_type;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *is_sale;
@property (nonatomic, strong) NSString *oid;
@property (nonatomic, strong) NSString *online_end;
@property (nonatomic, strong) NSString *online_start;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *sale_num;
@property (nonatomic, strong) NSString *shop_type;
@property (nonatomic, strong) NSString *shop_type_name;
@property (nonatomic, strong) NSString *sort;
@property (nonatomic, strong) NSString *tags;
@property (nonatomic, strong) NSString *thumb_path;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *share_url;
@property (nonatomic, strong) NSString *content_type; // 1 音频 2 视频


@end
