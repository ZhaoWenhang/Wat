//
//  VideoOneViewController.h
//  wat
//
//  Created by 123 on 2018/6/27.
//  Copyright © 2018年 wat0801. All rights reserved.
//


#import "ParentClassScrollViewController.h"

@interface VideoOneViewController : ParentClassScrollViewController
@property (nonatomic, strong) NSString *typeName; //类型 1专栏 2图文 3音频 4 视频
@property (nonatomic, strong) NSString *URLStr; //webView url
@end
