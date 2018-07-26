//
//  learningHistoryClassDetailModel.h
//  wat
//
//  Created by 123 on 2018/6/28.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface learningHistoryClassDetailModel : NSObject


//"create_time" = "2018-06-21 16:42:58";
//"finish_rate" = 20;
//gid = 55;
//id = 1;
//"learning_time" = 111;
//pid = 54;
//thumb = "http://admin.watcn.com/uploads/article/20180531/152773914837387243.jpg";
//title = "\U8bfe\U7a0b1";
//uid = 20;


@property (nonatomic, strong) NSString *create_time;
@property (nonatomic, strong) NSString *finish_rate;
@property (nonatomic, strong) NSString *gid;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *learning_time;
@property (nonatomic, strong) NSString *pid;
@property (nonatomic, strong) NSURL *thumb;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *content_type; //1 音频 2 视频

@end
