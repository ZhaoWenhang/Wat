//
//  HomeVideoClassViewController.h
//  wat
//
//  Created by 123 on 2018/6/27.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WatHomeClassListDetailModel.h"


@interface HomeVideoClassViewController : ViewController
@property (nonatomic, strong)NSString *typeName; // 类型 1专栏 2图文 3音频 4 视频
@property (nonatomic, strong)NSArray<WatHomeClassListDetailModel *> *list;
@property (nonatomic, strong)WatHomeClassListDetailModel *watHomeClassListDetailModel;
@property (nonatomic, strong) NSString *is_buy;
@property (nonatomic, strong) NSString *tableViewCellRow; //用来记录当前播放的序号,然后作用于上一曲,下一曲

@end
