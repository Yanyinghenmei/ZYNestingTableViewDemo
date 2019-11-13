//
//  SubViewController.h
//  ZYTableViewList
//
//  Created by Daniel Chuang on 2019/11/13.
//  Copyright © 2019 Daniel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYNestingView/ZYTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SubViewController : UIViewController<LFYSubControllerDelegate>
/// 列表
@property (nonatomic, strong) UITableView *tableView;
/// 是否可以滑动
@property (nonatomic, assign) BOOL isCanScroll;
/// 不滑动事件
@property (nonatomic, copy) ZYViewControllerAction noScrollAction;
@end

NS_ASSUME_NONNULL_END
