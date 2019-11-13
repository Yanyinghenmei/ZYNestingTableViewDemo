//
//  ZYNestingDelegate.h
//  LYFTableViewList
//
//  Created by Daniel Chuang on 2019/11/13.
//  Copyright © 2019 Daniel. All rights reserved.
//

#ifndef ZYNestingDelegate_h
#define ZYNestingDelegate_h

@protocol ZYCurrentViewControllerDelegate <NSObject>
@property (nonatomic, assign) BOOL isCanScroll;
@end


@protocol LFYSubControllerDelegate <NSObject>
typedef void(^ZYViewControllerAction)(void);
/// 列表
@property (nonatomic, strong) UITableView *tableView;
/// 是否可以滑动
@property (nonatomic, assign) BOOL isCanScroll;
/// 不滑动事件
@property (nonatomic, copy) ZYViewControllerAction noScrollAction;
@end


@protocol LFYTabViewDelegate <NSObject>
typedef void(^ZYTableViewHeaderViewAction)(NSInteger index);
/// 比列
@property (nonatomic, assign) CGFloat proportion;
/// 点击事件
@property (nonatomic, copy) ZYTableViewHeaderViewAction clickAction;
@end


#endif /* ZYNestingDelegate_h */
