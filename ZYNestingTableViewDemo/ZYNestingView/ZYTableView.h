//
//  ZYTableView.h
//  ZYTableViewList
//
//  Created by Daniel on 2018/11/23.
//  Copyright © 2018 Daniel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYNestingDelegate.h"

typedef void(^ZYTableViewAction)(void);
@interface ZYTableView : UITableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
       currentViewController:(UIViewController<ZYCurrentViewControllerDelegate> *)viewController
               contentHeight:(CGFloat)contentHeight
                  headerView:(UIView *)headerView
                     tabView:(UIView<LFYTabViewDelegate>  *)tabView
             viewControllers:(NSArray<UIViewController<LFYSubControllerDelegate> *> *)controllers;

// 更新控制器
- (void)updateControllers:(NSArray<UIViewController<LFYSubControllerDelegate> *> *)controllers;
@end
