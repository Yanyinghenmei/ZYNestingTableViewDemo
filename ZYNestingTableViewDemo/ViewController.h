//
//  ViewController.h
//  ZYNestingTableViewDemo
//
//  Created by Daniel Chuang on 2019/11/13.
//  Copyright © 2019 Daniel Chuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYNestingView/ZYTableView.h"
#import "SubViewController.h"

@interface ViewController : UIViewController<ZYCurrentViewControllerDelegate>

/// 列表(主列表，只有一个cell，用于装UICollectionView)
@property (nonatomic, strong) ZYTableView *tableView;
/// 是否可以滑动
@property (nonatomic, assign) BOOL isCanScroll;
/// 第一个控制器
@property (nonatomic, strong) SubViewController *ZYVCOne;
/// 第二个控制器
@property (nonatomic, strong) SubViewController *ZYVCTwo;
@property (nonatomic, strong) SubViewController *ZYVCThire;

@end

