//
//  ZYTableViewHeaderView.h
//  ZYTableViewList
//
//  Created by Daniel on 2018/11/23.
//  Copyright © 2018 Daniel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYTableView.h"

@interface ZYTableViewHeaderView : UITableViewHeaderFooterView<LFYTabViewDelegate>

/// 比列
@property (nonatomic, assign) CGFloat proportion;
/// 点击事件
@property (nonatomic, copy) ZYTableViewHeaderViewAction clickAction;

@property (nonatomic,copy) NSArray<NSString *> *titles;

@end
