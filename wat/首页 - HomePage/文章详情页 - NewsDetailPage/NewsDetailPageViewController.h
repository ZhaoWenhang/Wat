//
//  NewsDetailPageViewController.h
//  wat
//
//  Created by 123 on 2018/5/25.
//  Copyright © 2018年 wat0801. All rights reserved.
//  文章详情页

#import <UIKit/UIKit.h>
#import "WatHomeNewsDetailsModel.h"
@interface NewsDetailPageViewController : ViewController
@property (nonatomic ,strong) NSURL *URLStr;
@property (nonatomic, strong) WatHomeNewsDetailsModel *watHomeNewsDetailsModel;
@property (nonatomic, strong) NSString *ios_mark_id;

@end
