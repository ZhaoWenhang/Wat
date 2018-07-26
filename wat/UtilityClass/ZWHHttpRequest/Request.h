//
//  Request.h
//  ahaTravel
//
//  Created by ah on 2018/6/6.
//  Copyright © 2018年 gwd. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface Request : AFHTTPSessionManager

typedef void(^successCallback)(id responseObject);
typedef void(^failureCallback)(NSError *error); 

+(void)GET:(NSString *)relativePath
parameters:(id)parameters
   success:(successCallback)success
   failure:(failureCallback)failure;

+(void)POST:(NSString *)relativePath
 parameters:(NSDictionary *)parameters
    success:(successCallback)success
    failure:(failureCallback)failure;
//上传图片
+(void)POSTImageData:(NSString *)relativePath
          parameters:(NSString *)parameters
               image:(UIImage *)image
             success:(successCallback)success
             failure:(failureCallback)failure;

@end
