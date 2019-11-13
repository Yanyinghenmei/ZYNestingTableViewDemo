//
//  ZYCollectionView.h
//  ZYTableViewList
//
//  Created by Daniel on 2018/11/23.
//  Copyright © 2018 Daniel. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZYPageCardControllerDelegate <NSObject>
- (NSInteger)totalCount;
- (UIViewController *)viewControllerAtIndex:(NSInteger)index;
@end

@class ViewController;

typedef void(^ZYCollectionViewAction)(CGFloat proportion);

@interface ZYCollectionView : UICollectionView

/// 控制器
@property (nonatomic, weak) UIViewController *viewController;
/// 横向偏移比例
@property (nonatomic, copy) ZYCollectionViewAction scrollAction;
/// delegate
@property (nonatomic,weak) id <ZYPageCardControllerDelegate>pageDelegate;

@end
