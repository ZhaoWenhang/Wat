//
//  watNewsDetailModel.h
//  wat
//
//  Created by 123 on 2018/7/14.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface watNewsDetailModel : NSObject
@property (nonatomic, strong) NSString  *title;
@property (nonatomic, strong) NSString  *desc;
@property (nonatomic, strong) NSString  *thumb;
@property (nonatomic, strong) NSString  *url;



+ (void)asyncPostkApiArticleDetailSuccessBlock:(void(^)(watNewsDetailModel *watNewsDetail))successBlock errorBlock:(void(^)(NSError *errorResult))errorBlock paramDic:(NSMutableDictionary *)paramDic urlStr:(NSString *)urlStr;
@end
